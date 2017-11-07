unit DKC_IA32_MM_Unit;

//Version 0.27 31-12-2005

interface

implementation

{$define ALIGN16}
{$Assertions OFF}
{.$define USEFASTMOVE}
{.$define RANDOMIZEPOINTER}//not ready

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

{ TFreeStack = object
  private
   Stack : array[1..1] of TStackEntry;
   StackPointer : Cardinal;
  public
   procedure Init;
   procedure Push(I : Cardinal);
   function Pop : Cardinal;
 end;}

var
 Heap: THandle;
 RTLCriticalSection : TRTLCriticalSection;
 LastUsedIndex : Cardinal = 0;
 LastFreedIndex : Cardinal = 0;
 AllocArraySize : Cardinal;
 NoOfLivePointers: Cardinal;
 AllocArray : PAllocTypeArray;
 //FreeStack : TFreeStack;

const
 HEAP_NO_SERIALIZE = $00000001;
 SPLITSIZE : Integer = 25*1024;
 FLAGS : Cardinal = 1;//HEAP_NO_SERIALIZE;
 SHRINKSIZE : Cardinal = 1000;
 GROWSIZE : Cardinal = 1000;
 MAXNOOFDEFRAGROUNDS : Cardinal = 1500;
 SMALLOVERALLOCEXTRA : Integer = 32;
 OVERALLOCFACTORSMALL : Double = 1.5;
 OVERALLOCFACTORBIG : Double = 1.5;
 OVERALLOCFACTORSMALLUPSIZE : Double = 1.5;
 OVERALLOCFACTORSMALLDOWNSIZE : Double = 1/1.5;
 OVERALLOCPERCENTAGEBIGUPSIZE : Double = 1.5;
 OVERALLOCPERCENTAGEBIGDOWNSIZE : Double = 1/1.5;
 ALIGNSPACE : Integer = 15; //For 16 byte alignment
 RANDOMIZESPACE : Integer = 64;
 MINALLOCARRAYSIZE : Cardinal = 1000;
{
procedure TFreeStack.Init;
var
 I : Cardinal;
begin
 StackPointer := 0;
 for I := Low(Stack) to High(Stack) do
  Stack[I].Index := 0;
end;

procedure TFreeStack.Push(I : Cardinal);
begin
 if StackPointer < High(Stack) then
  begin
   Inc(StackPointer);
   Stack[StackPointer].Index := I;
  end
end;

function GetP(Index : Cardinal) : Pointer;
begin
 Assert(Index >= 0);
 Assert(Index <= AllocArraySize-1);
 if (Index >= 0) and (Index <= AllocArraySize-1) then
  Result := AllocArray[Index].pBlock
 else
  Result := nil;
end;

function TFreeStack.Pop : Cardinal;
begin
 Result := 0;
end;
}

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

function ShrinkAllocArray(var AllocArray : PAllocTypeArray; var AllocArraySize : Cardinal) : Boolean;
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

function GetPInternal(Index : Cardinal) : Pointer;
begin
 Assert(Index <= AllocArraySize-1);
 Result := AllocArray[Index].pBlockInternal;
end;

function GetInternalSize(Index : Cardinal) : Cardinal; overload;
begin
 Assert(Index <= AllocArraySize-1);
 Result := AllocArray[Index].InternalSize;
end;

function GetExternalSize(Index : Cardinal) : Cardinal;
begin
 Assert(Index <= AllocArraySize-1);
 Result := AllocArray[Index].ExternalSize;
end;

procedure SetSize(Index, InternalSize, ExternalSize : Cardinal);
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

function GetSmallAlloc(Index : Cardinal) : Boolean; overload;
begin
 Assert(Index <= AllocArraySize-1);
 Result := AllocArray[Index].SmallAlloc;
end;

//Returns true if succesfull

function AddToAllocTypeArray(PExternal : Pointer;
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
 //if Cardinal(Index1) > AllocArraySize-1 then
  //Index1 := AllocArraySize-1;
 if Cardinal(Index2) > AllocArraySize-1 then
  Index2 := AllocArraySize-1;

 Assert(Index1 <= AllocArraySize-1);
 Assert(Index2 <= AllocArraySize-1);
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
 if NoOfLivePointers < AllocArraySize-SHRINKSIZE then
  Result := ShrinkAllocArray(AllocArray, AllocArraySize)
 else
  begin
   LastFreedIndex := Index;
   LastUsedIndex := Index;
  end;
end;

//Returns -1 on Error

function GetIndex(P : Pointer) : Integer;
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

function DKCGetMem(Size: Integer): Pointer;
var
 InternalSize, ExternalSize : Cardinal;
 InternalPtr, ExternalPtr : Pointer;
 {$ifdef ALIGN16}
 MisAlign : Cardinal;
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
   InternalSize := Round(ExternalSize * OVERALLOCFACTORSMALL) + SMALLOVERALLOCEXTRA;
   {$endif}
   InternalPtr := HeapAlloc(Heap, FLAGS, InternalSize);
   //Assert(InternalPtr <> nil);//Do not assert on this. It is a valid error. We can run out of memory eg. Validate13
   if InternalPtr <> nil then
    begin
     {$ifdef ALIGN16}
     MisAlign := Cardinal(InternalPtr) and 15;
     ExternalPtr := Pointer(Cardinal(InternalPtr) + MisAlign);
     {$else}
     ExternalPtr := InternalPtr;
     {$endif}
     if AddToAllocTypeArray(ExternalPtr, InternalPtr, True, InternalSize, ExternalSize, AllocArraySize) then
      Result := ExternalPtr
     else
      Result := nil;
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
   InternalSize := Round(ExternalSize * OVERALLOCFACTORBIG);
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
     if AddToAllocTypeArray(ExternalPtr, InternalPtr, False, InternalSize, ExternalSize, AllocArraySize) then
      Result := ExternalPtr
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
 Index : Cardinal;
 InternalPtr : Pointer;

begin
 if IsMultiThread then
  EnterCriticalSection(RTLCriticalSection);
 Result := 0;//Assume success
 Index := GetIndex(Ptr);
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
       //if HeapCompact(Heap, FLAGS) = 0 then
        //Result := 1;
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
     if (NewExternalSize > OldInternalSize) then //Upsize
     {$endif}
      begin
       //Alloc more than requested
       {$ifdef ALIGN16}
       NewInternalSize := Round(NewExternalSize * OVERALLOCFACTORSMALLUPSIZE) + SMALLOVERALLOCEXTRA + ALIGNSPACE;
       {$else}
       NewInternalSize := Round(NewExternalSize * OVERALLOCFACTORSMALLUPSIZE) + SMALLOVERALLOCEXTRA;
       {$endif}
       OldInternalPtr := GetPInternal(OldIndex);
       NewInternalPtr := HeapRealloc(Heap, FLAGS, OldInternalPtr, NewInternalSize);
       {$ifdef ALIGN16}
       OldMisAlign := Cardinal(OldExternalPtr) - Cardinal(OldInternalPtr);//Will not align, but HeapRealloc moved data and we need to point at the new block no matter how it is aligned.
       NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + OldMisAlign);
       {$else}
       NewExternalPtr := NewInternalPtr;
       {$endif}
       RemoveFromAllocTypeArray(OldIndex, AllocArraySize);
       if AddToAllocTypeArray(NewExternalPtr, NewInternalPtr, True, NewInternalSize, NewExternalSize, AllocArraySize) then
        Result := NewExternalPtr
       else
        Result := nil;
      end
     {$ifdef ALIGN16}
     else if (NewExternalSize < Round(OldInternalSize * OVERALLOCFACTORSMALLDOWNSIZE) - SMALLOVERALLOCEXTRA - ALIGNSPACE) then
     {$else}
     else if (NewExternalSize < Round(OldInternalSize * OVERALLOCFACTORSMALLDOWNSIZE) - SMALLOVERALLOCEXTRA) then
     {$endif}
      begin
       //Downsize
       //Alloc more than requested
       {$ifdef ALIGN16}
       NewInternalSize := Round(NewExternalSize * OVERALLOCFACTORSMALLUPSIZE) + SMALLOVERALLOCEXTRA + ALIGNSPACE;
       {$else}
       NewInternalSize := Round(NewExternalSize * OVERALLOCFACTORSMALLUPSIZE) + SMALLOVERALLOCEXTRA;
       {$endif}
       {$ifdef RANDOMIZEPOINTER}
       NewInternalSize := NewInternalSize + RANDOMIZESPACE;
       {$endif}
       OldInternalPtr := GetPInternal(OldIndex);
       NewInternalPtr := HeapRealloc(Heap, FLAGS, OldInternalPtr, NewInternalSize);
       {$ifdef ALIGN16}
       AlignDifference := Cardinal(OldExternalPtr) - Cardinal(OldInternalPtr);
       NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + AlignDifference);
       {$else}
       NewExternalPtr := NewInternalPtr;
       {$endif}
       {$ifdef RANDOMIZEPOINTER}
       NewExternalPtr := Pointer(Cardinal(NewExternalPtr) + 16{Random(RANDOMIZESPACE)});
       {$endif}
       RemoveFromAllocTypeArray(OldIndex, AllocArraySize);
       if AddToAllocTypeArray(NewExternalPtr, NewInternalPtr, True, NewInternalSize, NewExternalSize, AllocArraySize) then
        begin
         Result := NewExternalPtr
        end
       else
        begin
         Result := nil;
        end;
      end
     else
      begin
       //InternalSize did not change because no realloc took place
       NewInternalSize := OldInternalSize;
       SetSize(OldIndex, NewInternalSize, NewExternalSize);
       Result := OldExternalPtr;
      end;
    end
   else
    begin
     //Realloc small as big
     //Alloc more than requested
     {$ifdef ALIGN16}
     NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE) + ALIGNSPACE;
     {$else}
     NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE);
     {$endif}
     //Get new block
     NewInternalPtr := VirtualAlloc(nil, NewInternalSize, MEM_COMMIT+MEM_TOP_DOWN, PAGE_READWRITE);
     if NewInternalPtr <> nil then
      begin
       {$ifdef ALIGN16}
       MisAlign := Cardinal(NewInternalPtr) and 15;
       NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + MisAlign);
       {$else}
       NewExternalPtr := Pointer(Cardinal(NewInternalPtr));
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
        end;
      end
     else
      Result := nil;
    end;
  end
 else
  begin
   if NewExternalSize > SPLITSIZE then
    begin
     //Realloc big as big
     //Is realloc needed?
     //Upsize
     {$ifdef ALIGN16}
     if NewExternalSize > OldInternalSize - ALIGNSPACE then
     {$else}
     if NewExternalSize > OldInternalSize then
     {$endif}
      begin
       //Alloc more than requested
       {$ifdef ALIGN16}
       NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE) + ALIGNSPACE;
       {$else}
       NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE);
       {$endif}
       NewInternalPtr := VirtualAlloc(OldInternalPtr, NewInternalSize, MEM_COMMIT or MEM_TOP_DOWN, PAGE_READWRITE);
      end
     {$ifdef ALIGN16}
     else if (NewExternalSize < Round(OldInternalSize * OVERALLOCPERCENTAGEBIGDOWNSIZE) - ALIGNSPACE) then //Downsize
     {$else}
     else if (NewExternalSize < Round(OldInternalSize * OVERALLOCPERCENTAGEBIGDOWNSIZE)) then //Downsize
     {$endif}
      begin
       //Alloc more than requested
       {$ifdef ALIGN16}
       NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE) + ALIGNSPACE;
       {$else}
       NewInternalSize := Round(NewExternalSize * OVERALLOCPERCENTAGEBIGUPSIZE);
       {$endif}
       NewInternalPtr := VirtualAlloc(OldExternalPtr, NewInternalSize, MEM_COMMIT or MEM_TOP_DOWN, PAGE_READWRITE);
      end
     else
      begin
       //InternalSize did not change because no realloc took place
       NewInternalSize := OldInternalSize;
       OldInternalPtr := GetPInternal(OldIndex);
       NewInternalPtr := OldInternalPtr;
       //Result := OldExternalPtr;
      end;
     if NewInternalPtr <> nil then
      begin
       //VirtualRealloc succeded in mysterious ways
       //Was it inplace?
       if NewInternalPtr = OldInternalPtr then
        begin
         SetSize(OldIndex, NewInternalSize, NewExternalSize);
         Result := OldInternalPtr;
        end
       else
        begin
         {$ifdef ALIGN16}
         MisAlign := Cardinal(NewInternalPtr) and 15;
         NewExternalPtr := Pointer(Cardinal(NewInternalPtr) + MisAlign);
         {$else}
         NewExternalPtr := Pointer(Cardinal(NewInternalPtr));
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
          end
         else
          begin
           Result := nil;
          end;
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
         NewExternalPtr := NewInternalPtr;
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
//resourcestring
 //sError = 'DKC_IA32_MM_Unit must be the first unit used by the project';
var
 MemMgr: TMemoryManager;

begin
 NoOfLivePointers := 0;
 Heap := HeapCreate(FLAGS, 0, 0);
 if Heap = 0 then
  RunError(203); // out of memory
 Assert(AllocMemCount = 0);
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

finalization

 DeleteCriticalSection(RTLCriticalSection);
 if Heap <> 0 then
  HeapDestroy(Heap);
 VirtualFree(AllocArray, 0, MEM_RELEASE);
 AllocArray := nil;

end.
