unit DKC_IA32_MM_Unit;

//Version 0.32 28-2-2006

interface

implementation

{$Assertions OFF}

{.$define ALIGN16}
{$define USEFASTMOVE}
{$define ALIGN16RANDOMIZEPOINTER}
{.$define PASCAL}
{$ifdef ALIGN16RANDOMIZEPOINTER}
 {$undef ALIGN16}
{$endif}

{$ifdef USEFASTMOVE}

uses
 Windows, FastcodeMoveCPUID;
{$else}
uses
 Windows;
{$endif}

type

 TAllocType = record
  pBlockExternal : Pointer;
  pBlockInternal : Pointer;
  InternalSize : Cardinal;
  ExternalSize : Cardinal;
  SmallAlloc : Boolean;
 end;

 TAllocTypeArray = array[0..100000000] of TAllocType;
 PAllocTypeArray = ^TAllocTypeArray;

 TStackEntry = record
  Index : Cardinal;
 end;

var
 Heap: THandle;
 RTLCriticalSection : TRTLCriticalSection;
 LastUsedIndex : Cardinal = 0;
 LastFreedIndex : Cardinal = 0;
 AllocArraySize : Cardinal;
 NoOfLivePointers: Cardinal;
 AllocArray : PAllocTypeArray;

const
 HEAP_NO_SERIALIZE = $00000001;
 SPLITSIZE : Integer = 25*1024;
 FLAGS : Cardinal = 1;//HEAP_NO_SERIALIZE;
 SHRINKSIZE : Cardinal = 1000;//Must be >= MINALLOCARRAYSIZE
 GROWSIZE : Cardinal = 1000;
 MAXNOOFDEFRAGROUNDS : Cardinal = 1000;
 SMALLOVERALLOCEXTRA : Integer = 64;
 OVERALLOCFACTORSMALL : Double = 1.2;
 OVERALLOCFACTORBIG : Double = 1.1;
 OVERALLOCFACTORSMALLUPSIZE : Double = 1.5;
 OVERALLOCFACTORSMALLDOWNSIZE : Double = 1/1.5;
 OVERALLOCPERCENTAGEBIGUPSIZE : Double = 1.5;
 OVERALLOCPERCENTAGEBIGDOWNSIZE : Double = 1/1.5;
 ALIGNSPACE : Integer = 15; //For 16 byte alignment
 RANDOMIZESPACE : Integer = 4096;
 MINALLOCARRAYSIZE : Cardinal = 1000;

var
 RandomCount : Cardinal = 0;
 RandomCountMax : Cardinal;

function CalculateRandomizeOffset : Cardinal;{$ifdef ver170}inline; {$endif} {$ifdef ver180}inline; {$endif}
begin
 //Result := 16*Random(RANDOMIZESPACE div 16);
 Inc(RandomCount,11);
 if RandomCount > RandomCountMax then
  RandomCount := 0;
 Result := 16*RandomCount;
 Assert(Result <= Cardinal(RANDOMIZESPACE));
end;

procedure InitializeAllocArray(StartIndex, StopIndex : Cardinal);
var
 Index : Cardinal;

begin
 Assert(StartIndex <= AllocArraySize-1);
 Assert(StopIndex <= AllocArraySize-1);
 for Index := StartIndex to StopIndex do
  begin
   AllocArray[Index].pBlockExternal := nil;
   AllocArray[Index].pBlockInternal := nil;
   AllocArray[Index].InternalSize := 0;
   AllocArray[Index].ExternalSize := 0;
   AllocArray[Index].SmallAlloc := True
  end;
end;

//Returns True if successfull

function GrowAllocArray(var AllocArray : PAllocTypeArray; var AllocArraySize : Cardinal) : Boolean;
var
 OldAllocArray, NewAllocArray : PAllocTypeArray;
 OldSize, NewSize : Cardinal;

begin
 OldAllocArray := AllocArray;
 OldSize := AllocArraySize;
 NewSize := OldSize + GROWSIZE;
 NewAllocArray := VirtualAlloc(nil, NewSize * SizeOf(TAllocType),MEM_COMMIT+MEM_TOP_DOWN, PAGE_READWRITE);
 if NewAllocArray = nil then
  begin
   Result := False;
  end
 else
  begin
   {$ifdef USEFASTMOVE}
   FastMove(OldAllocArray[0], NewAllocArray[0], OldSize * SizeOf(TAllocType));
   {$else}
   Move(OldAllocArray[0], NewAllocArray[0], OldSize * SizeOf(TAllocType));
   {$endif}
   AllocArray := NewAllocArray;
   AllocArraySize := NewSize;
   InitializeAllocArray(OldSize, NewSize-1);
   if VirtualFree(OldAllocArray, 0, MEM_RELEASE) then
    Result := True
   else
    Result := False;
  end;
end;

function ShrinkAllocArrayx(var AllocArray : PAllocTypeArray; var AllocArraySize : Cardinal) : Boolean;
var
 HighIndex, LowIndex, MaxUsedIndex : Integer;
 NewSize, NoOfDefragRounds, OldSize : Cardinal;
 OldAllocArray, NewAllocArray : PAllocTypeArray;
 Swap : Boolean;

begin
 Result := True;
 if AllocArraySize > MINALLOCARRAYSIZE + SHRINKSIZE then
  begin
   LastFreedIndex := 0;
   OldSize := AllocArraySize;
   NoOfDefragRounds := 0;
   HighIndex := AllocArraySize;
   LowIndex := -1;
   MaxUsedIndex := AllocArraySize;
   if MAXNOOFDEFRAGROUNDS > 0 then
    begin
     repeat
      Swap := True;
      //Find highest used index
      repeat
       Dec(HighIndex);
       if HighIndex < 0 then
        begin
         //No used indexes
         Swap := False;
         Break;
        end;
      until(AllocArray[HighIndex].pBlockExternal <> nil);
      //Find lowest unused index
      repeat
       Inc(LowIndex);
       if Cardinal(LowIndex) >= AllocArraySize then
        begin
         //No unused indexes
         Swap := False;
         Break;
        end;
      until(AllocArray[LowIndex].pBlockExternal = nil);
      if (LowIndex < HighIndex) and (Swap) then
       begin
        //Copy HighIndex to LowIndex
        AllocArray[LowIndex].pBlockExternal := AllocArray[HighIndex].pBlockExternal;
        AllocArray[LowIndex].pBlockInternal := AllocArray[HighIndex].pBlockInternal;
        AllocArray[LowIndex].InternalSize := AllocArray[HighIndex].InternalSize;
        AllocArray[LowIndex].ExternalSize := AllocArray[HighIndex].ExternalSize;
        AllocArray[LowIndex].SmallAlloc := AllocArray[HighIndex].SmallAlloc;
        //Clear HighIndex
        AllocArray[HighIndex].pBlockExternal := nil;
        AllocArray[HighIndex].pBlockInternal := nil;
        AllocArray[HighIndex].InternalSize := 0;
        AllocArray[HighIndex].ExternalSize := 0;
        AllocArray[HighIndex].SmallAlloc := True;
        MaxUsedIndex := HighIndex;
       end
      else
       begin
        //No more to defrag
        Break;
       end;
      Inc(NoOfDefragRounds)
     until(NoOfDefragRounds >= MAXNOOFDEFRAGROUNDS);
    end;
   repeat
    Dec(MaxUsedIndex);
    if MaxUsedIndex < 0 then
     begin
      //No used indexes
      Break;
     end;
   until(AllocArray[MaxUsedIndex].pBlockExternal <> nil);
   NewSize := OldSize - SHRINKSIZE;
   //Do not shrink below any used entries
   if NewSize < Cardinal(MaxUsedIndex)+1 then
    NewSize := MaxUsedIndex+1;
   if NewSize < OldSize then
    begin
     //Shrink AllocArray
     OldAllocArray := AllocArray;
     NewAllocArray := VirtualAlloc(nil, NewSize * SizeOf(TAllocType), MEM_COMMIT+MEM_TOP_DOWN, PAGE_READWRITE);
     AllocArray := NewAllocArray;
     if AllocArray = nil then
      begin
       //Not enough space for a new AllocArray keep the old one
       AllocArray := OldAllocArray;
      end
     else
      begin
       {$ifdef USEFASTMOVE}
       FastMove(OldAllocArray[0], AllocArray[0], NewSize * SizeOf(TAllocType));
       {$else}
       Move(OldAllocArray[0], AllocArray[0], NewSize * SizeOf(TAllocType));
       {$endif}
       if not VirtualFree(OldAllocArray, 0, MEM_RELEASE) then
        Result := False
       else
        begin
         AllocArraySize := NewSize;
         LastUsedIndex := 0;//NewSize-1;
         LastFreedIndex := 0;
        end;
      end;
    end;
  end;
end;

function ShrinkAllocArray(var AllocArray : PAllocTypeArray; var AllocArraySize : Cardinal) : Boolean;
var
 HighIndex, LowIndex, MaxUsedIndex : Integer;
 NewSize, OldSize : Cardinal;
 OldAllocArray, NewAllocArray : PAllocTypeArray;
label
 DefragEnd;

begin
 Result := True;
 //if AllocArraySize > MINALLOCARRAYSIZE + SHRINKSIZE then
 if AllocArraySize > MINALLOCARRAYSIZE then
  begin
   LastFreedIndex := 0;
   OldSize := AllocArraySize;
   LowIndex := 0;
   HighIndex := 0;
   repeat
    if AllocArray[LowIndex].pBlockExternal = nil then
     begin
      if HighIndex < LowIndex then
       HighIndex := LowIndex;
      repeat
       Inc(HighIndex);
       if Cardinal(HighIndex) >= AllocArraySize then
        //Remaining entries are all nil
        goto DefragEnd;
       if AllocArray[HighIndex].pBlockExternal <> nil then
        begin
         //Copy HighIndex to LowIndex
         AllocArray[LowIndex].pBlockExternal := AllocArray[HighIndex].pBlockExternal;
         AllocArray[LowIndex].pBlockInternal := AllocArray[HighIndex].pBlockInternal;
         AllocArray[LowIndex].InternalSize := AllocArray[HighIndex].InternalSize;
         AllocArray[LowIndex].ExternalSize := AllocArray[HighIndex].ExternalSize;
         AllocArray[LowIndex].SmallAlloc := AllocArray[HighIndex].SmallAlloc;
         //Clear HighIndex
         AllocArray[HighIndex].pBlockExternal := nil;
         AllocArray[HighIndex].pBlockInternal := nil;
         AllocArray[HighIndex].InternalSize := 0;
         AllocArray[HighIndex].ExternalSize := 0;
         AllocArray[HighIndex].SmallAlloc := True;
         Break;
        end;
      until (False);
     end;
    Inc(LowIndex);
   until(Cardinal(LowIndex) >= AllocArraySize-1) ;
 DefragEnd :
   MaxUsedIndex := AllocArraySize;
   repeat
    Dec(MaxUsedIndex);
    if MaxUsedIndex < 0 then
     begin
      //No used indexes
      Break;
     end;
   until(AllocArray[MaxUsedIndex].pBlockExternal <> nil);
   //NewSize := OldSize - SHRINKSIZE;
   //Do not shrink below any used entries
   //if NewSize < Cardinal(MaxUsedIndex)+1 then
   //Shrink as much as possible
   NewSize := MaxUsedIndex+1;
   //Do not shrink below MINALLOCARRAYSIZE
   if NewSize < MINALLOCARRAYSIZE then
    NewSize := MINALLOCARRAYSIZE;
   if NewSize < OldSize then
    begin
     //Shrink AllocArray
     OldAllocArray := AllocArray;
     NewAllocArray := VirtualAlloc(nil, NewSize * SizeOf(TAllocType), MEM_COMMIT+MEM_TOP_DOWN, PAGE_READWRITE);
     AllocArray := NewAllocArray;
     if AllocArray = nil then
      begin
       //Not enough space for a new AllocArray keep the old one
       AllocArray := OldAllocArray;
      end
     else
      begin
       {$ifdef USEFASTMOVE}
       FastMove(OldAllocArray[0], AllocArray[0], NewSize * SizeOf(TAllocType));
       {$else}
       Move(OldAllocArray[0], AllocArray[0], NewSize * SizeOf(TAllocType));
       {$endif}
       if not VirtualFree(OldAllocArray, 0, MEM_RELEASE) then
        Result := False
       else
        begin
         AllocArraySize := NewSize;
         LastUsedIndex := 0;//NewSize-1;
         LastFreedIndex := 0;
        end;
      end;
    end;
  end;
end;

function GetPInternal(Index : Cardinal) : Pointer;{$ifdef ver170}inline; {$endif} {$ifdef ver180}inline; {$endif}
begin
 Assert(Index <= AllocArraySize-1);
 Result := AllocArray[Index].pBlockInternal;
end;

function GetInternalSize(Index : Cardinal) : Cardinal; overload;{$ifdef ver170}inline; {$endif} {$ifdef ver180}inline; {$endif}
begin
 Assert(Index <= AllocArraySize-1);
 Result := AllocArray[Index].InternalSize;
end;

function GetExternalSize(Index : Cardinal) : Cardinal;{$ifdef ver170}inline; {$endif} {$ifdef ver180}inline; {$endif}
begin
 Assert(Index <= AllocArraySize-1);
 Result := AllocArray[Index].ExternalSize;
end;

procedure SetSize(Index, InternalSize, ExternalSize : Cardinal);{$ifdef ver170}inline; {$endif} {$ifdef ver180}inline; {$endif}
begin
 Assert(Index <= AllocArraySize-1);
 {$ifdef ALIGN16}
 Assert(InternalSize >= ExternalSize + Cardinal(ALIGNSPACE));
 {$else}
 Assert(InternalSize >= ExternalSize);
 {$endif}
 AllocArray[Index].InternalSize := InternalSize;
 AllocArray[Index].ExternalSize := ExternalSize;
end;

function GetSmallAlloc(Index : Cardinal) : Boolean; overload; {$ifdef ver170}inline; {$endif} {$ifdef ver180}inline; {$endif}
begin
 Assert(Index <= AllocArraySize-1);
 Result := AllocArray[Index].SmallAlloc;
end;

//Returns true if succesfull

function AddToAllocTypeArrayx(PExternal : Pointer;
                             PInternal : Pointer;
                             SmallAlloc : Boolean;
                             InternalSize, ExternalSize : Cardinal;
                             var AllocArraySize : Cardinal) : Boolean;
var
 Index1, Index2 : Integer;

begin
 Assert(Cardinal(PExternal) >= Cardinal(PInternal));
 Assert(InternalSize > ExternalSize);//Not 100% correct
 Result := True;
 Inc(NoOfLivePointers);
 if NoOfLivePointers > AllocArraySize then
  begin
   Result := GrowAllocArray(AllocArray, AllocArraySize);
   Assert(Result);
   if not Result then
    Exit;
  end;
 Index1 := LastFreedIndex;
 //Adding two allocs after each other with no free in between will force search for free slot to start here
 LastFreedIndex := AllocArraySize - 2;
 Index2 := Index1 + 1;
 if Cardinal(Index2) > AllocArraySize-1 then
  Index2 := AllocArraySize-1;
 Assert(Cardinal(Index1) <= AllocArraySize-1);
 Assert(Cardinal(Index2) <= AllocArraySize-1);
 repeat
  if (AllocArray[Index1].pBlockExternal = nil) then
   begin
    Assert(Cardinal(Index1) <= AllocArraySize-1);
    LastUsedIndex := Index1;
    AllocArray[Index1].pBlockExternal := PExternal;
    AllocArray[Index1].pBlockInternal := PInternal;
    AllocArray[Index1].InternalSize := InternalSize;
    AllocArray[Index1].ExternalSize := ExternalSize;
    AllocArray[Index1].SmallAlloc := SmallAlloc;
    Exit;
   end;
  if (AllocArray[Index2].pBlockExternal = nil) then
   begin
    Assert(Cardinal(Index2) <= AllocArraySize-1);
    LastUsedIndex := Index2;
    AllocArray[Index2].pBlockExternal := PExternal;
    AllocArray[Index2].pBlockInternal := PInternal;
    AllocArray[Index2].InternalSize := InternalSize;
    AllocArray[Index2].ExternalSize := ExternalSize;
    AllocArray[Index2].SmallAlloc := SmallAlloc;
    Exit;
   end;
  Dec(Index1);
  Inc(Index2);
  if Index1 < 0 then
   begin
    if (Cardinal(Index2) > AllocArraySize-1) then
     begin
      //Did not find space for pointer
      Result := False;
      Exit;
     end;
    repeat
     if (AllocArray[Index2].pBlockExternal = nil) then
      begin
       Assert(Index2 >= 0);
       Assert(Cardinal(Index2) <= AllocArraySize-1);
       LastUsedIndex := Index2;
       AllocArray[Index2].pBlockExternal := PExternal;
       AllocArray[Index2].pBlockInternal := PInternal;
       AllocArray[Index2].InternalSize := InternalSize;
       AllocArray[Index2].ExternalSize := ExternalSize;
       AllocArray[Index2].SmallAlloc := SmallAlloc;
       Exit;
      end;
     Inc(Index2);
    until(Cardinal(Index2) >= AllocArraySize);
    //Did not find space for pointer
    Result := False;
    Exit;
   end;
  if Cardinal(Index2) > AllocArraySize-1 then
   begin
    repeat
     if (Index1 < 0) then
      begin
       //Did not find space for pointer
       Result := False;
       Exit;
      end;
     if (AllocArray[Index1].pBlockExternal = nil) then
      begin
       Assert(Index1 >= 0);
       Assert(Cardinal(Index1) <= AllocArraySize-1);
       LastUsedIndex := Index1;
       AllocArray[Index1].pBlockExternal := PExternal;
       AllocArray[Index1].pBlockInternal := PInternal;
       AllocArray[Index1].InternalSize := InternalSize;
       AllocArray[Index1].ExternalSize := ExternalSize;
       AllocArray[Index1].SmallAlloc := SmallAlloc;
       Exit;
      end;
     Dec(Index1);
    until(Index1 <0) ;
   end;
 until(False);
end;

function AddToAllocTypeArray(PExternal : Pointer;
                             PInternal : Pointer;
                             SmallAlloc : Boolean;
                             InternalSize, ExternalSize : Cardinal;
                             var AllocArraySize : Cardinal) : Boolean;
var
 Index : Integer;

begin
 Assert(Cardinal(PExternal) >= Cardinal(PInternal));
 Assert(InternalSize > ExternalSize);//Not 100% correct
 Result := True;
 Inc(NoOfLivePointers);
 if NoOfLivePointers > AllocArraySize then
  begin
   Result := GrowAllocArray(AllocArray, AllocArraySize);
   //Assert(Result);
   if not Result then
    Exit;
  end;
  Index := LastFreedIndex;
  if (AllocArray[Index].pBlockExternal = nil) then
   begin
    Assert(Cardinal(Index) <= AllocArraySize-1);
    LastUsedIndex := Index;
    AllocArray[Index].pBlockExternal := PExternal;
    AllocArray[Index].pBlockInternal := PInternal;
    AllocArray[Index].InternalSize := InternalSize;
    AllocArray[Index].ExternalSize := ExternalSize;
    AllocArray[Index].SmallAlloc := SmallAlloc;
    Exit;
   end;
 Index := AllocArraySize-1;
 repeat
  if (AllocArray[Index].pBlockExternal = nil) then
   begin
    Assert(Cardinal(Index) <= AllocArraySize-1);
    LastUsedIndex := Index;
    AllocArray[Index].pBlockExternal := PExternal;
    AllocArray[Index].pBlockInternal := PInternal;
    AllocArray[Index].InternalSize := InternalSize;
    AllocArray[Index].ExternalSize := ExternalSize;
    AllocArray[Index].SmallAlloc := SmallAlloc;
    Exit;
   end;
  Dec(Index);
 until (Index < 0);
 //Did not find space for pointer
 Result := False;
end;

function RemoveFromAllocTypeArray(Index : Cardinal; var AllocArraySize : Cardinal) : Boolean; overload;
begin
 Assert(Index <= AllocArraySize-1);
 Result := True;
 AllocArray[Index].pBlockExternal := nil;
 AllocArray[Index].pBlockInternal := nil;
 AllocArray[Index].InternalSize := 0;
 AllocArray[Index].ExternalSize := 0;
 AllocArray[Index].SmallAlloc := True;
 Dec(NoOfLivePointers);
 if NoOfLivePointers >= AllocArraySize-SHRINKSIZE then
  begin
   LastFreedIndex := Index;
   LastUsedIndex := Index;
  end
 else
  Result := ShrinkAllocArray(AllocArray, AllocArraySize)
end;

//Returns -1 on Error

function GetIndexa(P : Pointer) : Integer;
var
 Index1, Index2 : Integer;

begin
 Result := -1;
 if LastUsedIndex > AllocArraySize-2 then
  LastUsedIndex := AllocArraySize-2;
 Index1 := LastUsedIndex;
 Index2 := LastUsedIndex+1;
 repeat
  if (AllocArray[Index1].pBlockExternal = P) then
   begin
    LastUsedIndex := Index1;
    Result := Index1;
    Assert(Result >= 0);
    Assert(Cardinal(Result) <= AllocArraySize-1);
    Exit;
   end;
  if (AllocArray[Index2].pBlockExternal = P) then
   begin
    LastUsedIndex := Index2;
    Result := Index2;
    Assert(Result >= 0);
    Assert(Cardinal(Result) <= AllocArraySize-1);
    Exit;
   end;
  Dec(Index1);
  Inc(Index2);
  if Index1 < 0 then
   begin
    if (Cardinal(Index2) > AllocArraySize-1) then
     begin
      //Did not find pointer
      Result := -1;
      Assert(Result >= 0);
      Exit;
     end;
    repeat
     if (AllocArray[Index2].pBlockExternal = P) then
      begin
       LastUsedIndex := Index2;
       Result := Index2;
       Assert(Result >= 0);
       Assert(Cardinal(Result) <= AllocArraySize-1);
       Exit;
      end;
     Inc(Index2);
    until(Cardinal(Index2) >= AllocArraySize);
    //Did not find pointer
    Result := -1;
    Assert(Result >= 0);
    Exit;
   end;
  if Cardinal(Index2) > AllocArraySize-1 then
   begin
    if (Index1 < 0) then
     begin
      //Did not find pointer
      Result := -1;
      Assert(Result >= 0);
      Exit;
     end;
    repeat
     if (AllocArray[Index1].pBlockExternal = P) then
      begin
       LastUsedIndex := Index1;
       Result := Index1;
       Assert(Result >= 0);
       Assert(Cardinal(Result) <= AllocArraySize-1);
       Exit;
      end;
     Dec(Index1);
    until(Index1 < 0);
    //Did not find pointer
    Result := -1;
    Assert(Result >= 0);
    Exit;
   end;
 until(False);
 Assert(Result >= 0);
 Assert(Cardinal(Result) <= AllocArraySize-1);
end;

{$ifdef PASCAL}

function GetIndex(P : Pointer) : Integer;
var
 Index1, Index2 : Integer;
label
 ResultIndex1, ResultIndex2;

begin
 Index1 := LastUsedIndex;
 Index2 := LastUsedIndex;
 repeat
  if (AllocArray[Index1].pBlockExternal = P) then
   goto ResultIndex1;
  if (AllocArray[Index2].pBlockExternal = P) then
   goto ResultIndex2;
  Dec(Index1);
  Inc(Index2);
  if Index1 < 0 then
   begin
    if (Cardinal(Index2) > AllocArraySize-1) then
     begin
      //Did not find pointer
      Result := -1;
      Assert(Result >= 0);
      Exit;
     end;
    repeat
     if (AllocArray[Index2].pBlockExternal = P) then
      goto ResultIndex2;
     Inc(Index2);
    until(Cardinal(Index2) >= AllocArraySize);
    //until(Cardinal(Index2) > AllocArraySize-1);//Test this
    //Did not find pointer
    Result := -1;
    Exit;
   end;
  if Cardinal(Index2) > AllocArraySize-1 then
   begin
    if (Index1 < 0) then
     begin
      //Did not find pointer
      Result := -1;
      Exit;
     end;
    repeat
     if (AllocArray[Index1].pBlockExternal = P) then
      goto ResultIndex1;
     Dec(Index1);
    until(Index1 < 0);
    //Did not find pointer
    Result := -1;
    Exit;
   end;
 until(False);
ResultIndex2 :
 LastUsedIndex := Index2;
 Result := Index2;
 Exit;
ResultIndex1 :
 LastUsedIndex := Index1;
 Result := Index1;
end;

{$else}

function GetIndex(P : Pointer) : Integer;
asm
   push ebx
   push esi
   push edi
   push ebp
   mov  esi, AllocArray
   mov  edi, AllocArraySize
   dec  edi
   //Index1 := LastUsedIndex;
   mov  edx,LastUsedIndex
   //Index2 := LastUsedIndex;
   mov  ecx,edx
   //if (AllocArray[Index1].pBlockExternal = P) then
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @Loop1 :
   lea  ebp,[edx+edx*4]
   cmp  eax,[esi+ebp*4]
   jz   @ResultIndex1
   //if (AllocArray[Index2].pBlockExternal = P) then
   lea  ebx,[ecx+ecx*4]
   cmp  eax,[esi+ebx*4]
   jz   @ResultIndex2
   //Dec(Index1);
   dec  edx
   //Inc(Index2);
   inc  ecx
   //if Index1 < 0 then
   test edx,edx
   jnl  @L3
   //if (Cardinal(Index2) > AllocArraySize-1) then
   cmp  edi,ecx
   jnb  @Loop2X
   //Result := -1;
   or   eax,-$01
   jmp  @Exit
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   //if (AllocArray[Index2].pBlockExternal = P) then
 @Loop2X :
   lea  ebx,[ecx+ecx*4]
 @Loop2 :
   cmp  eax,[esi+ebx*4]
   jz   @ResultIndex2
   //Inc(Index2);
   inc  ecx
   add  ebx,5
   //until(Cardinal(Index2) > AllocArraySize-1);
   cmp  ecx,edi
   jbe  @Loop2
   //Result := -1;
   or   eax,-$01
   jmp  @Exit
   //if Cardinal(Index2) > AllocArraySize-1 then
 @L3 :
   cmp  edi,ecx
   jnb  @Loop1
   //if (Index1 < 0) then
   test edx,edx
   jnl  @Loop3X
   //Result := -1;
   or   eax,-$01
   jmp  @Exit
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   //if (AllocArray[Index1].pBlockExternal = P) then
 @Loop3X :
   lea  ebp,[edx+edx*4]
 @Loop3 :
   cmp  eax,[esi+ebp*4]
   jz   @ResultIndex1
   //Dec(Index1);
   dec  edx
   sub  ebp,5
   //until(Index1 < 0);
   test edx,edx
   jnl  @Loop3
   //Result := -1;
   or   eax,-$01
   jmp  @Exit
 @ResultIndex2 :
   //LastUsedIndex := Index2;
   mov  LastUsedIndex,ecx
   //Result := Index2;
   mov  eax,ecx
   pop  ebp
   pop  edi
   pop  esi
   pop  ebx
   ret
 @ResultIndex1 :
   //LastUsedIndex := Index1;
   mov  LastUsedIndex,edx
   //Result := Index1;
   mov  eax,edx
 @Exit :
   pop  ebp
   pop  edi
   pop  esi
   pop  ebx
end;

{$endif}

function DKCGetMem(Size: Integer): Pointer;
var
 InternalSize, ExternalSize : Cardinal;
 InternalPtr, ExternalPtr : Pointer;
 {$ifdef ALIGN16}
 MisAlign : Cardinal;
 {$endif}
 {$ifdef ALIGN16RANDOMIZEPOINTER}
 MisAlign, RandomOffset : Cardinal;
 {$endif}

begin
 if IsMultiThread then
  EnterCriticalSection(RTLCriticalSection);
 ExternalSize := Size;
 if Size < SPLITSIZE then
  begin
   {$ifdef ALIGN16}
   InternalSize := Round(ExternalSize * OVERALLOCFACTORSMALL) + SMALLOVERALLOCEXTRA + ALIGNSPACE;
   {$else}
   {$ifdef ALIGN16RANDOMIZEPOINTER}
   InternalSize := Round(ExternalSize * OVERALLOCFACTORSMALL) + SMALLOVERALLOCEXTRA + ALIGNSPACE;
   {$else}
   InternalSize := Round(ExternalSize * OVERALLOCFACTORSMALL) + SMALLOVERALLOCEXTRA;
   {$endif}
   {$endif}
   InternalPtr := HeapAlloc(Heap, FLAGS, InternalSize);
   if InternalPtr <> nil then
    begin
     {$ifdef ALIGN16}
     MisAlign := Cardinal(InternalPtr) and 15;
     ExternalPtr := Pointer(Cardinal(InternalPtr) + MisAlign);
     {$else}
     {$ifdef ALIGN16RANDOMIZEPOINTER}
     MisAlign := Cardinal(InternalPtr) and 15;
     ExternalPtr := Pointer(Cardinal(InternalPtr) + MisAlign);
     {$else}
     ExternalPtr := InternalPtr;
     {$endif}
     {$endif}
     if AddToAllocTypeArray(ExternalPtr, InternalPtr, True, InternalSize, ExternalSize, AllocArraySize) then
      begin
       Result := ExternalPtr;
       Assert(Result <> nil);
      end
     else
      begin
       //No room in AllocArray for block
       HeapFree(Heap, FLAGS, InternalPtr);
       Result := nil;
      end;
    end
   else
    begin
     Result := nil;
    end;
  end
 else
  begin
   {$ifdef ALIGN16}
   InternalSize := Round(ExternalSize * OVERALLOCFACTORBIG) + ALIGNSPACE;
   {$else}
   {$ifdef ALIGN16RANDOMIZEPOINTER}
   InternalSize := Round(ExternalSize * OVERALLOCFACTORBIG) + RANDOMIZESPACE;
   {$else}
   InternalSize := Round(ExternalSize * OVERALLOCFACTORBIG);
   {$endif}
   {$endif}
   InternalPtr := VirtualAlloc(nil, InternalSize, MEM_COMMIT+MEM_TOP_DOWN, PAGE_READWRITE);
   if InternalPtr <> nil then
    begin
     {$ifdef ALIGN16}
     MisAlign := Cardinal(InternalPtr) and 15;
     ExternalPtr := Pointer(Cardinal(InternalPtr) + MisAlign);
     {$else}
     ExternalPtr := Pointer(Cardinal(InternalPtr));
     {$endif}
     {$ifdef ALIGN16RANDOMIZEPOINTER}
     MisAlign := Cardinal(InternalPtr) and 15;
     //RandomOffset := CalculateRandomizeOffset;
     Inc(RandomCount,11);
     if RandomCount > RandomCountMax then
      RandomCount := 0;
     RandomOffset := 16*RandomCount;
     ExternalPtr := Pointer(Cardinal(ExternalPtr) + MisAlign + RandomOffset);
     {$endif}
     if AddToAllocTypeArray(ExternalPtr, InternalPtr, False, InternalSize, ExternalSize, AllocArraySize) then
      begin
       Result := ExternalPtr;
       Assert(Result <> nil);
      end
     else
      Result := nil;
    end
   else
    Result := nil;
  end;
 if IsMultiThread then
  LeaveCriticalSection(RTLCriticalSection);
end;

//Returns 0 on success
//Returns 1 on error

function DKCFreeMem(Ptr: Pointer): Integer;
var
 Res, Success : Boolean;
 Index : Integer;
 InternalPtr : Pointer;

begin
 if IsMultiThread then
  EnterCriticalSection(RTLCriticalSection);
 Result := 0;//Assume success
 Index := GetIndex(Ptr);
 if Index <> -1 then
  begin
   InternalPtr := GetPInternal(Index);
   Assert(InternalPtr <> nil);
   if GetSmallAlloc(Index) then
    begin
     if HeapFree(Heap, FLAGS, InternalPtr) then
      begin
       Success := RemoveFromAllocTypeArray(Index, AllocArraySize);
       if not Success then
        begin
         Result := 1;
        end
       else
        begin
         if HeapCompact(Heap, FLAGS) = 0 then
          Result := 1;
        end;
      end
     else
      Result := 1;
    end
   else
    begin
     Res := VirtualFree(InternalPtr, 0, MEM_RELEASE);
     if Res then
      begin
       if not RemoveFromAllocTypeArray(Index, AllocArraySize) then
        Result := 1;
      end
     else
      Result := 1;
    end;
  end
 else
  Result := 1;
 Assert(Result=0);
 if IsMultiThread then
  LeaveCriticalSection(RTLCriticalSection);
end;

function DKCReallocMem(Ptr: Pointer; Size: Integer): Pointer;
var
 NewExternalSize, OldExternalSize, NewInternalSize, OldInternalSize : Integer;
 OldInternalPtr, NewInternalPtr, NewExternalPtr, OldExternalPtr : Pointer;
 OldIndex : Cardinal;
 {$ifdef ALIGN16}
 MisAlign, OldMisAlign, AlignDifference : Cardinal;
 {$endif}
 {$ifdef ALIGN16RANDOMIZEPOINTER}
 MisAlign, OldMisAlign, RandomOffset, AlignDifference : Cardinal;
 {$endif}

begin
 if IsMultiThread then
  EnterCriticalSection(RTLCriticalSection);
 OldExternalPtr := Ptr;
 OldIndex := GetIndex(Ptr);
 OldInternalPtr := GetPInternal(OldIndex);
 NewExternalSize := Size;
 OldExternalSize := GetExternalSize(OldIndex);
 OldInternalSize := GetInternalSize(OldIndex);
 if GetSmallAlloc(OldIndex) then
  begin
   if NewExternalSize < SPLITSIZE then
    begin
     //Realloc small as small
     {$ifdef ALIGN16}
     if (NewExternalSize > (OldInternalSize - ALIGNSPACE)) then //Upsize
     {$else}
     {$ifdef ALIGN16RANDOMIZEPOINTER}
     if (NewExternalSize > (OldInternalSize - ALIGNSPACE)) then //Upsize
     {$else}
     if (NewExternalSize > OldInternalSize) then //Upsize
     {$endif}
     {$endif}
      begin
       //Alloc more than requested
       {$ifdef ALIGN16}
       NewInternalSize := Round(NewExternalSize * OVERALLOCFACTORSMALLUPSIZE) + SMALLOVERALLOCEXTRA + ALIGNSPACE;
       {$else}
       {$ifdef ALIGN16RANDOMIZEPOINTER}
       NewInternalSize := Round(NewExternalSize * OVERALLOCFACTORSMALLUPSIZE) + SMALLOVERALLOCEXTRA + ALIGNSPACE;
       {$else}
       NewInternalSize := Round(NewExternalSize * OVERALLOCFACTORSMALLUPSIZE) + SMALLOVERALLOCEXTRA;
       {$endif}
       {$endif}
       OldInternalPtr := GetPInternal(OldIndex);
       NewInternalPtr := HeapRealloc(Heap, FLAGS, OldInternalPtr, NewInternalSize);
       {$ifdef ALIGN16}
       OldMisAlign := Cardinal(OldExternalPtr) - Cardinal(OldInternalPtr);//Will not align, but HeapRealloc moved data and we need to point at the new block no matter how it is aligned.
       NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + OldMisAlign);
       {$else}
       {$ifdef ALIGN16RANDOMIZEPOINTER}
       OldMisAlign := Cardinal(OldExternalPtr) - Cardinal(OldInternalPtr);//Will not align, but HeapRealloc moved data and we need to point at the new block no matter how it is aligned.
       NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + OldMisAlign);
       {$else}
       NewExternalPtr := NewInternalPtr;
       {$endif}
       {$endif}
       RemoveFromAllocTypeArray(OldIndex, AllocArraySize);
       if AddToAllocTypeArray(NewExternalPtr, NewInternalPtr, True, NewInternalSize, NewExternalSize, AllocArraySize) then
        begin
         Result := NewExternalPtr;
         Assert(Result <> nil);
        end
       else
        Result := nil;
      end
     {$ifdef ALIGN16}
     else if (NewExternalSize < Round(OldInternalSize * OVERALLOCFACTORSMALLDOWNSIZE) - SMALLOVERALLOCEXTRA - ALIGNSPACE) then
     {$else}
     {$ifdef ALIGN16RANDOMIZEPOINTER}
     else if (NewExternalSize < Round(OldInternalSize * OVERALLOCFACTORSMALLDOWNSIZE) - SMALLOVERALLOCEXTRA - ALIGNSPACE) then
     {$else}
     else if (NewExternalSize < Round(OldInternalSize * OVERALLOCFACTORSMALLDOWNSIZE) - SMALLOVERALLOCEXTRA) then
     {$endif}
     {$endif}
      begin
       //Downsize
       //Alloc more than requested
       {$ifdef ALIGN16}
       NewInternalSize := Round(NewExternalSize * OVERALLOCFACTORSMALLUPSIZE) + SMALLOVERALLOCEXTRA + ALIGNSPACE;
       {$else}
       {$ifdef ALIGN16RANDOMIZEPOINTER}
       NewInternalSize := Round(NewExternalSize * OVERALLOCFACTORSMALLUPSIZE) + SMALLOVERALLOCEXTRA + ALIGNSPACE;
       {$else}
       NewInternalSize := Round(NewExternalSize * OVERALLOCFACTORSMALLUPSIZE) + SMALLOVERALLOCEXTRA;
       {$endif}
       {$endif}
       OldInternalPtr := GetPInternal(OldIndex);
       NewInternalPtr := HeapRealloc(Heap, FLAGS, OldInternalPtr, NewInternalSize);
       {$ifdef ALIGN16}
       AlignDifference := Cardinal(OldExternalPtr) - Cardinal(OldInternalPtr);
       NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + AlignDifference);
       {$else}
       {$ifdef ALIGN16RANDOMIZEPOINTER}
       AlignDifference := Cardinal(OldExternalPtr) - Cardinal(OldInternalPtr);
       NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + AlignDifference);
       {$else}
       NewExternalPtr := NewInternalPtr;
       {$endif}
       {$endif}
       RemoveFromAllocTypeArray(OldIndex, AllocArraySize);
       if AddToAllocTypeArray(NewExternalPtr, NewInternalPtr, True, NewInternalSize, NewExternalSize, AllocArraySize) then
        begin
         Result := NewExternalPtr;
         Assert(Result <> nil);
        end
       else
        Result := nil;
      end
     else
      begin
       //InternalSize did not change because no realloc took place
       NewInternalSize := OldInternalSize;
       SetSize(OldIndex, NewInternalSize, NewExternalSize);
       Result := OldExternalPtr;
       Assert(Result <> nil);
      end;
    end
   else
    begin
     //Realloc small as big
     //Alloc more than requested
     {$ifdef ALIGN16}
     NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE) + ALIGNSPACE;
     {$else}
     {$ifdef ALIGN16RANDOMIZEPOINTER}
     NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE) + ALIGNSPACE + RANDOMIZESPACE;
     {$else}
     NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE);
     {$endif}
     {$endif}
     //Get new block
     NewInternalPtr := VirtualAlloc(nil, NewInternalSize, MEM_COMMIT+MEM_TOP_DOWN, PAGE_READWRITE);
     if NewInternalPtr <> nil then
      begin
       {$ifdef ALIGN16}
       MisAlign := Cardinal(NewInternalPtr) and 15;
       NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + MisAlign);
       {$else}
       {$ifdef ALIGN16RANDOMIZEPOINTER}
       MisAlign := Cardinal(NewInternalPtr) and 15;
       //RandomOffset := CalculateRandomizeOffset;
       Inc(RandomCount,11);
       if RandomCount > RandomCountMax then
        RandomCount := 0;
       RandomOffset := 16*RandomCount;
       NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + MisAlign + RandomOffset);
       {$else}
       NewExternalPtr := Pointer(Cardinal(NewInternalPtr));
       {$endif}
       {$endif}
       AddToAllocTypeArray(NewExternalPtr, NewInternalPtr, False, NewInternalSize, NewExternalSize, AllocArraySize);
       OldExternalSize := GetExternalSize(OldIndex);
       {$ifdef USEFASTMOVE}
       FastMove(OldExternalPtr^, NewExternalPtr^, OldExternalSize);
       {$else}
       Move(OldExternalPtr^, NewExternalPtr^, OldExternalSize);
       {$endif}
       if not HeapFree(Heap, FLAGS, OldInternalPtr) then
        Result := nil
       else
        begin
         RemoveFromAllocTypeArray(OldIndex, AllocArraySize);
         Result := NewExternalPtr;
         Assert(Result <> nil);
        end;
      end
     else
      Result := nil;
    end;
  end
 else
  begin
   if NewExternalSize >= SPLITSIZE then
    begin
     //Realloc big as big
     //Is realloc needed?
     //Upsize
     {$ifdef ALIGN16}
     if NewExternalSize > OldInternalSize - ALIGNSPACE then
     {$else}
     {$ifdef ALIGN16RANDOMIZEPOINTER}
     if NewExternalSize > OldInternalSize - ALIGNSPACE - RANDOMIZESPACE then
     {$else}
     if NewExternalSize > OldInternalSize then
     {$endif}
     {$endif}
      begin
       //Alloc more than requested
       {$ifdef ALIGN16}
       NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE) + ALIGNSPACE;
       {$else}
       {$ifdef ALIGN16RANDOMIZEPOINTER}
       NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE) + ALIGNSPACE + RANDOMIZESPACE;
       {$else}
       NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE);
       {$endif}
       {$endif}
       NewInternalPtr := VirtualAlloc(OldInternalPtr, NewInternalSize, MEM_COMMIT or MEM_TOP_DOWN, PAGE_READWRITE);
      end
     {$ifdef ALIGN16}
     else if (NewExternalSize < Round(OldInternalSize * OVERALLOCPERCENTAGEBIGDOWNSIZE) - ALIGNSPACE) then //Downsize
     {$else}
     {$ifdef ALIGN16RANDOMIZEPOINTER}
     else if (NewExternalSize < Round(OldInternalSize * OVERALLOCPERCENTAGEBIGDOWNSIZE) - ALIGNSPACE - RANDOMIZESPACE) then //Downsize
     {$else}
     else if (NewExternalSize < Round(OldInternalSize * OVERALLOCPERCENTAGEBIGDOWNSIZE)) then //Downsize
     {$endif}
     {$endif}
      begin
       //Alloc more than requested
       {$ifdef ALIGN16}
       NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE) + ALIGNSPACE;
       {$else}
       {$ifdef ALIGN16RANDOMIZEPOINTER}
       NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE) + ALIGNSPACE + RANDOMIZESPACE;
       {$else}
       NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE);
       {$endif}
       {$endif}
       NewInternalPtr := VirtualAlloc(OldExternalPtr, NewInternalSize, MEM_COMMIT or MEM_TOP_DOWN, PAGE_READWRITE);
      end
     else
      begin
       //InternalSize did not change because no realloc took place
       NewInternalSize := OldInternalSize;
       OldInternalPtr := GetPInternal(OldIndex);
       NewInternalPtr := OldInternalPtr;
      end;
     if NewInternalPtr <> nil then
      begin
       //VirtualRealloc succeded in mysterious ways
       //Was it inplace?
       if NewInternalPtr = OldInternalPtr then
        begin
         SetSize(OldIndex, NewInternalSize, NewExternalSize);
         Result := OldExternalPtr;
         Assert(Result <> nil);
        end
       else
        begin
         {$ifdef ALIGN16}
         MisAlign := Cardinal(NewInternalPtr) and 15;
         NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + MisAlign);
         {$else}
         {$ifdef ALIGN16RANDOMIZEPOINTER}
         MisAlign := Cardinal(NewInternalPtr) and 15;
         //RandomOffset := CalculateRandomizeOffset;
         Inc(RandomCount,11);
         if RandomCount > RandomCountMax then
          RandomCount := 0;
         RandomOffset := 16*RandomCount;
         NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + MisAlign + RandomOffset);
         {$else}
         NewExternalPtr := Pointer(Cardinal(NewInternalPtr));
         {$endif}
         {$endif}
         if NewExternalSize > OldExternalSize then
          begin
           OldExternalSize := GetExternalSize(OldIndex);
           {$ifdef USEFASTMOVE}
           FastMove(OldExternalPtr^, NewExternalPtr^, OldExternalSize);
           {$else}
           Move(OldExternalPtr^, NewExternalPtr^, OldExternalSize);
           {$endif}
          end;
         RemoveFromAllocTypeArray(OldIndex, AllocArraySize);
         if AddToAllocTypeArray(NewExternalPtr, NewInternalPtr, False, NewInternalSize, NewExternalSize, AllocArraySize) then
          begin
           Result := NewExternalPtr;
           Assert(Result <> nil);
          end
         else
          Result := nil;
        end;
      end
     else
      begin
       //Realloc failed. Try get a new block
       NewInternalPtr := VirtualAlloc(nil, NewInternalSize, MEM_COMMIT+MEM_TOP_DOWN, PAGE_READWRITE);
       if NewInternalPtr <> nil then
        begin
         {$ifdef ALIGN16}
         MisAlign := Cardinal(NewInternalPtr) and 15;
         NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + MisAlign);
         {$else}
         {$ifdef ALIGN16RANDOMIZEPOINTER}
         MisAlign := Cardinal(NewInternalPtr) and 15;
         //RandomOffset := CalculateRandomizeOffset;
         Inc(RandomCount,11);
         if RandomCount > RandomCountMax then
          RandomCount := 0;
         RandomOffset := 16*RandomCount;
         NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + MisAlign + RandomOffset);
         {$else}
         NewExternalPtr := NewInternalPtr;
         {$endif}
         {$endif}
         if AddToAllocTypeArray(NewExternalPtr, NewInternalPtr, False, NewInternalSize, NewExternalSize, AllocArraySize) then
          begin
           OldExternalSize := GetExternalSize(OldIndex);
           {$ifdef USEFASTMOVE}
           FastMove(OldExternalPtr^, NewExternalPtr^, OldExternalSize);
           {$else}
           Move(OldExternalPtr^, NewExternalPtr^, OldExternalSize);
           {$endif}
           if VirtualFree(OldInternalPtr, 0, MEM_RELEASE) then
            begin
             RemoveFromAllocTypeArray(OldIndex, AllocArraySize);
             Result := NewExternalPtr;
             Assert(Result <> nil);
            end
           else
            Result := nil;
          end
         else
          begin
           Result := nil;
          end;
        end
       else
        Result := nil;
      end;
    end
   else
    begin
     //Realloc big as small
     NewInternalSize := NewExternalSize + ALIGNSPACE;
     NewInternalPtr := HeapAlloc(Heap, FLAGS, NewInternalSize);
     {$ifdef ALIGN16}
     MisAlign := Cardinal(NewInternalPtr) and 15;
     NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + MisAlign);
     {$else}
     NewExternalPtr := NewInternalPtr;
     {$endif}
     if AddToAllocTypeArray(NewExternalPtr, NewInternalPtr, True, NewInternalSize, NewExternalSize, AllocArraySize) then
      begin
       {$ifdef USEFASTMOVE}
       FastMove(OldExternalPtr^, NewExternalPtr^, NewExternalSize);
       {$else}
       Move(OldExternalPtr^, NewExternalPtr^, NewExternalSize);
       {$endif}
       if VirtualFree(OldInternalPtr, 0, MEM_RELEASE) then
        begin
         RemoveFromAllocTypeArray(OldIndex, AllocArraySize);
         Result := NewExternalPtr;
         Assert(Result <> nil);
        end
       else
        begin
         Result := nil;
        end;
      end
     else
      begin
       Result := nil;
      end;
    end;
  end;
 if IsMultiThread then
  LeaveCriticalSection(RTLCriticalSection);
end;

procedure InitMemoryManager;
var
 MemMgr: TMemoryManager;
const
 MAXHEAPSIZE : Integer = 0;//MaxInt-(256*1024*1024);

begin
 NoOfLivePointers := 0;
 Heap := HeapCreate(FLAGS, 0, MAXHEAPSIZE);
 if Heap = 0 then
  RunError(203); // out of memory
 //Assert(AllocMemCount = 0);
 MemMgr.GetMem := DKCGetMem;
 MemMgr.FreeMem := DKCFreeMem;
 MemMgr.ReallocMem := DKCReallocMem;
 SetMemoryManager(MemMgr);
 InitializeCriticalSection(RTLCriticalSection);
 EnterCriticalSection(RTLCriticalSection);
 AllocArraySize := GROWSIZE;
 AllocArray := VirtualAlloc(nil, AllocArraySize * SizeOf(TAllocType),MEM_COMMIT+MEM_TOP_DOWN, PAGE_READWRITE);
 InitializeAllocArray(0, AllocArraySize-1);
 LeaveCriticalSection(RTLCriticalSection);
end;

initialization

 InitMemoryManager;
 RandomCountMax := RANDOMIZESPACE div 16;

finalization

 DeleteCriticalSection(RTLCriticalSection);
 if Heap <> 0 then
  HeapDestroy(Heap);
 VirtualFree(AllocArray, 0, MEM_RELEASE);
 AllocArray := nil;

end.
