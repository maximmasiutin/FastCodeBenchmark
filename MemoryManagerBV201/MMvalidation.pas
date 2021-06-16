unit MMValidation;

interface

uses
  SysUtils, Classes, Math;

type
  TValidateFunction = function: Boolean of object;
  TValidateProgressEvent = procedure(const CurrentValidation, Failed: string) of object;

  TMMValidation = class(TComponent)
  private
    FOnProgress: TValidateProgressEvent;
    FFailedList: string;
    MMValue: Int64;
    function MMGetValue(ACeil: Integer): Integer;
    function Validate1: Boolean;
    function Validate2: Boolean;
    function Validate3: Boolean;
    function Validate4: Boolean;
    function Validate5: Boolean;
    function Validate6: Boolean;
    function Validate7: Boolean;
    function Validate8: Boolean;
    function Validate9: Boolean;
    function Validate10: Boolean;
    function Validate11: Boolean;
    function Validate12: Boolean;
    function Validate13: Boolean;
    function Validate14: Boolean;
    function Validate15: boolean;
    function Validate16: boolean;
    function Validate17: Boolean;
    function Validate18: Boolean;
    function Validate19: Boolean;
    function Validate20: Boolean;
    function Validate21: Boolean;
    function Validate22: Boolean;
    function Validate24: Boolean;
    function Validate25: Boolean;
    function Validate26: Boolean;
    function Validate27: boolean;
    function Validate28: boolean;
    function Validate29: boolean;
    function Validate30: boolean;
    function Validate31: boolean;
    function Validate32: boolean;
    function Validate33: boolean;
    function Validate34: boolean;
    function Validate35: boolean;
    function Validate36: boolean;
    function Validate37: boolean;
    function Validate38: boolean;
    function Validate39: boolean;
    function Validate40: Boolean;
    function Validate41: Boolean;
    function Validate42: Boolean;
    function Validate43: Boolean;
    function Validate44: Boolean;
    function Validate45: Boolean;
    function Validate46: Boolean;
    function Validate47: Boolean;
    function Validate48: Boolean;
    function Validate49: Boolean;
{$IFNDEF WIN64}
    function Validate50: Boolean;
{$ENDIF}
  private
    procedure DoValidate(ValidateFunction: TValidateFunction; const ValidationName: string);
  public
    property OnProgress: TValidateProgressEvent read FOnProgress write FOnProgress;  // to show progress of validation

    function Validate: string;      // returns list of failed validations
    function ExtraValidate: string; // returns list of failed validations
  end;

TValidate28Thread = class(TThread)
public
  NextValue: Integer;
  procedure Execute; override;
end;


implementation

uses
  Windows,
  BenchmarkForm, BenchmarkUtilities, PrimeNumbers;

(*
{$IFDEF WIN64}
{$define SkipGlobalMemoryStatusCheck}
{$ENDIF}
*)

{$ifdef SkipGlobalMemoryStatusCheck}
procedure GlobalMemoryStatus(var lpBuffer: TMemoryStatus); inline;
begin
  lpBuffer.dwLength := SizeOf(lpBuffer);
  lpBuffer.dwMemoryLoad := 50;
  lpBuffer.dwTotalPhys := MaxInt;
  lpBuffer.dwAvailPhys := MaxInt div 2;
  lpBuffer.dwTotalPageFile := MaxInt;
  lpBuffer.dwAvailPageFile := MaxInt div 2;
  lpBuffer.dwTotalVirtual := MaxInt;
  lpBuffer.dwAvailVirtual := MaxInt div 2;
end;
{$endif}

const
  ShortRun = True;

const
  Validate28Prime = 251;

procedure SleepAfterMemoryConsumingTest;
begin
{$IFDEF WIN64}
  Sleep(50); { 1/20th of a second should be enough}
{$ELSE}
  Sleep(1000); { 1 second }
{$ENDIF}
end;



function TMMValidation.Validate: string;
begin
  FFailedList := '';
{$ifndef Validate_49_only}
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate1, 'Validate1');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate2, 'Validate2');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate3, 'Validate3');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate4, 'Validate4');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate5, 'Validate5');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate6, 'Validate6');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate7, 'Validate7');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate8, 'Validate8');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate9, 'Validate9');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate10, 'Validate10');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate11, 'Validate11');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate12, 'Validate12');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate14, 'Validate14');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate17, 'Validate17');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate18, 'Validate18');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate19, 'Validate19');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate20, 'Validate20');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate21, 'Validate21');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate22, 'Validate22');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate25, 'Validate25');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate26, 'Validate26');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate28, 'Validate28');
{$IFNDEF FPC} // FPC does not raise the EOutOfMemory
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate32, 'Validate32');
{$ENDIF}
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate34, 'Validate34');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate35, 'Validate35');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate36, 'Validate36');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate37, 'Validate37');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate38, 'Validate38');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate39, 'Validate39');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate40, 'Validate40');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate41, 'Validate41');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate42, 'Validate42');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate43, 'Validate43');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate44, 'Validate44');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate45, 'Validate45');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate46, 'Validate46');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate47, 'Validate47');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate48, 'Validate48');
{$endif}
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate49, 'Validate49');
  SleepAfterMemoryConsumingTest;
  Result := FFailedList;
end;

// validate 45 to 48 do not actually validate anything - they just
// are useful in multi-threaded tests

function TMMValidation.Validate45: Boolean;
const
  Size = 3;
  Count = 100000000;
var
  i: Integer;
  p: Pointer;
begin
  Result := True;
  try
    for I := 0 to Count-1 do
    begin
      GetMem(p, Size);
      FreeMem(p, Size);
    end;
  except
    Result := False;
  end;
end;

function TMMValidation.Validate46: Boolean;
const
  Size = 4097;
  Count = 40000000;
var
  i: Integer;
  p: Pointer;
begin
  Result := True;
  try
    for I := 0 to Count-1 do
    begin
      GetMem(p, Size);
      FreeMem(p, Size);
    end;
  except
    Result := False;
  end;
end;

function TMMValidation.Validate47: Boolean;
const
  Size = 256*1024+17;
  Count = 50000000;
var
  i: Integer;
  p: Pointer;
begin
  Result := True;
  try
    for I := 0 to Count-1 do
    begin
      GetMem(p, Size);
      FreeMem(p, Size);
    end;
  except
    Result := False;
  end;
end;

function TMMValidation.Validate48: Boolean;
const
  Size = 40+1024*1024;
  Count = 250000;
var
  i: Integer;
  p: Pointer;
begin
  Result := True;
  try
    for I := 0 to Count-1 do
    begin
      GetMem(p, Size);
      FreeMem(p, Size);
    end;
  except
    Result := False;
  end;
end;


function TMMValidation.ExtraValidate: string;
begin
  FFailedList := '';
{$IFNDEF FPC}
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate13, 'Validate13'); // FPC does not raise EOutOfMemory
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate15, 'Validate15'); // FPC does not raise EInvalidPointer
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate16, 'Validate16'); // FPC does not raise EInvalidPointer
{$ENDIF}
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate18, 'Validate18');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate20, 'Validate20');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate24, 'Validate24');
{$IFDEF VALIDATE_DLL}
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate27, 'Validate27');
{$ENDIF}
{$IFNDEF FPC} // FPC does not raise the EOutOfMemory
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate29, 'Validate29');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate30, 'Validate30');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate31, 'Validate31');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate32, 'Validate32');
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate33, 'Validate33');
{$IFNDEF WIN64}
  DoValidate({$IFDEF FPC}@{$ENDIF}Validate50, 'Validate50');
{$ENDIF}
{$ENDIF}
  Result := FFailedList;
end;

function TMMValidation.MMGetValue(ACeil: Integer): Integer;
begin
  Inc(MMValue, 197); // prime
  Result := MMValue mod ACeil;
end;

procedure TMMValidation.DoValidate(ValidateFunction: TValidateFunction; const ValidationName: string);
var
  Passed: Boolean;
  StartCycles, FinishCycles: Int64;
begin
  if Assigned(FOnProgress) then
    FOnProgress(ValidationName, FFailedList);

  try
    StartCycles := GetCPUTicks;
    try
      Passed := ValidateFunction();
    except
      Passed := False;
    end;
  finally
    FinishCycles := GetCPUTicks;
    if Assigned(FOnProgress) then
    begin
      FOnProgress(ValidationName + 'Cycles='+IntToStr(FinishCycles-StartCycles)+';', '');
    end;
  end;

  if not Passed then
    FFailedList := FFailedList + ValidationName + ';';
end;

type
  TExportedMethod = procedure;

(**************************************************************************************************)
// all Validation functions below
(**************************************************************************************************)

function TMMValidation.Validate1 : Boolean;
var
 SomeArray : array of Byte;
 MemoryStatus : TMemoryStatus;
const
 BYTESTOALLOCATE = 1;//1 byte

begin
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  if MemoryStatus.dwAvailVirtual >= BYTESTOALLOCATE then
   SetLength(SomeArray, BYTESTOALLOCATE);
 except
  Result := False;
 end;
end;

function TMMValidation.Validate2 : Boolean;
var
 SomeArray1, SomeArray2 : array of Byte;
 MemoryStatus : TMemoryStatus;
const
 BYTESTOALLOCATE = 1;//1 byte

begin
 Result := False;
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  if MemoryStatus.dwAvailVirtual >= BYTESTOALLOCATE then
   begin
    SetLength(SomeArray1, BYTESTOALLOCATE);
    SetLength(SomeArray2, BYTESTOALLOCATE);
    //Validate that pointers do not overlap
    if @SomeArray1[0] = @SomeArray2[0] then
     Result := False;
   end;
 except
  Result := False;
 end;
end;

function TMMValidation.Validate3 : Boolean;
var
 SomeArray : array of Byte;
 MemoryStatus : TMemoryStatus;
const
 BYTESTOALLOCATEMAX = 2;//2 byte

begin
 Result := False;
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  if MemoryStatus.dwAvailVirtual >= BYTESTOALLOCATEMAX then
   begin
    //Allocate 1 byte
    SetLength(SomeArray, 1);
    //Fill it
    SomeArray[0] := 0;
    //Expand array
    SetLength(SomeArray, 2);
    //Validate that data in first allocation is preserved by realloc/expand
    if SomeArray[0] <> 0 then
     Result := False;
   end;
 except
  Result := False;
 end;
end;

function TMMValidation.Validate4 : Boolean;
var
 I : Cardinal;
 MemoryStatus : TMemoryStatus;
 pMem : Pointer;
 pChr : PAnsiChar;
const
 BYTESTOALLOCATEMAX = 32000;//32 KB

begin
 Result := False;
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  if MemoryStatus.dwAvailVirtual >= BYTESTOALLOCATEMAX then
   begin
    pMem := AllocMem(BYTESTOALLOCATEMAX);
    pChr := pMem;
    for I := 0 to BYTESTOALLOCATEMAX-1 do
     begin
      if pChr^ <> #0 then
       begin
        Result := False;
        Break;
       end;
      Inc(PChr);
     end;
    FreeMem(pMem, BYTESTOALLOCATEMAX);
   end;
 except
  Result := False;
 end;
end;

function TMMValidation.Validate5 : Boolean;
var
 I : Cardinal;
 SomeArray : array of Byte;
 MemoryStatus : TMemoryStatus;
const
 BYTESTOALLOCATE = 64000;//64kB byte
 NOOFITERATIONS = 100000;

begin
 Result := False;
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  for I := 1 to NOOFITERATIONS do
   begin
    if MemoryStatus.dwAvailVirtual >= BYTESTOALLOCATE then
     //Allocate
     SetLength(SomeArray, BYTESTOALLOCATE);
    //Free
    SetLength(SomeArray, 0);
   end;
 except
  Result := False;
 end;
end;

function TMMValidation.Validate6 : Boolean;
var
 I : Cardinal;
 pMem : Pointer;
 MemoryStatus : TMemoryStatus;
const
 BYTESTOALLOCATE = 40000;//40kB byte
 NOOFITERATIONS = 5000000;

begin
 Result := False;
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  for I := 1 to NOOFITERATIONS do
   begin
    if MemoryStatus.dwAvailVirtual >= BYTESTOALLOCATE then
     begin
      //Allocate
      GetMem(pMem, BYTESTOALLOCATE);
      //Free
      FreeMem(pMem, BYTESTOALLOCATE);
     end;
   end;
 except
  Result := False;
 end;
end;

function TMMValidation.Validate7 : Boolean;
var
 I1, I2, I3, J1, J2 : Cardinal;
 pMem : Pointer;
 PointerArray : array[1..10] of Pointer;
 MemoryStatus : TMemoryStatus;
const
 BYTESTOALLOCATE = 1;//1 byte

begin
 for I1 := Low(PointerArray) to High(PointerArray) do
 begin
  PointerArray[I1] := nil;
 end;

 try
  Result := True;
  for I2 := Low(PointerArray) to High(PointerArray) do
   begin
    FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
    GlobalMemoryStatus(MemoryStatus);
    if MemoryStatus.dwAvailVirtual >= BYTESTOALLOCATE then
     begin
      //Allocate all pointers
      GetMem(pMem, BYTESTOALLOCATE);
      PointerArray[I2] := pMem;
     end;
   end;
  for J1 := Low(PointerArray) to Pred(High(PointerArray)) do
   for J2 := Succ(J1) to Length(PointerArray) do
    begin
     //No pointers can overlap = be closer than BYTESTOALLOCATE
     if NativeUint(Abs(NativeInt(PointerArray[J1]) - NativeInt(PointerArray[J2]))) < BYTESTOALLOCATE then
      begin
       Result := False;
       Break;
      end;
    end;
  //Free all pointers
  for I3 := Low(PointerArray) to High(PointerArray) do
   begin
    pMem := PointerArray[I3];
    FreeMem(pMem, BYTESTOALLOCATE);
    PointerArray[I3] := nil;
   end;
 except
  Result := False;
 end;
end;

function TMMValidation.Validate8 : Boolean;
var
 I1, I2, I3, J1, J2 : Cardinal;
 pMem : Pointer;
 PointerArray : array[1..10] of Pointer;
 MemoryStatus : TMemoryStatus;
const
 BYTESTOALLOCATE = 2;//2 byte

begin
 for I1 := 1 to Length(PointerArray) do
  PointerArray[I1] := nil;
 try
  Result := True;
  for I2 := 1 to Length(PointerArray) do
   begin
    FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
    GlobalMemoryStatus(MemoryStatus);
    if MemoryStatus.dwAvailVirtual >= BYTESTOALLOCATE then
     begin
      //Allocate all pointers
      GetMem(pMem, BYTESTOALLOCATE);
      PointerArray[I2] := pMem;
     end;
   end;
  for J1 := 1 to Length(PointerArray)-1 do
   for J2 := J1+1 to Length(PointerArray) do
    begin
     //No pointers can overlap = be closer than BYTESTOALLOCATE
     if NativeUInt(Abs(NativeInt(PointerArray[J1]) - NativeInt(PointerArray[J2]))) < BYTESTOALLOCATE then
      begin
       Result := False;
       Break;
      end;
    end;
  //Free all pointers
  for I3 := 1 to Length(PointerArray) do
   begin
    pMem := PointerArray[I3];
    FreeMem(pMem, BYTESTOALLOCATE);
    PointerArray[I3] := nil;
   end;
 except
  Result := False;
 end;
end;

// this test allocates a maximum of 400K bytes (200*2000}
function TMMValidation.Validate9 : Boolean;
const
  CIterations = 200;
var
 Prime, I1, I2, I3, J1, J2, BytesToAllocate : Cardinal;
 BytesToAllocate_SIZET: SIZE_T;
 pMem : Pointer;
 NI1, NI2: NativeInt;
 A: NativeUint;
 PointerArray : array[1..2000] of Pointer;
 MemoryStatus : TMemoryStatus;
const
 BYTESTOALLOCATEMAX = CIterations;

begin
 Result := True;
 Prime := VeryGoodPrimes[0];
 try
  for BytesToAllocate := 1 to BYTESTOALLOCATEMAX do
   begin
    for I1 := 1 to Length(PointerArray) do
     PointerArray[I1] := nil;
    if (ShortRun) and ((BytesToAllocate*Prime) mod 17{prime}=1) then
    begin
      Continue;
    end;
    for I2 := 1 to Length(PointerArray) do
     begin
      FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
      GlobalMemoryStatus(MemoryStatus);
      BytesToAllocate_SIZET := BytesToAllocate;
      if MemoryStatus.dwAvailVirtual >= BytesToAllocate_SIZET then
       begin
        //Allocate all pointers
        GetMem(pMem, BytesToAllocate);
        PointerArray[I2] := pMem;
       end;
     end;
    for J1 := 1 to Length(PointerArray)-1 do
     for J2 := J1+1 to Length(PointerArray) do
      begin
       //No pointers can overlap = be closer than BytesToAllocate
        NI1 := NativeInt(PointerArray[J1]);
        NI2 := NativeInt(PointerArray[J2]);
        A := Abs(NI1 - NI2);
        if A < BytesToAllocate then
        begin
         Result := False;
         Exit;
        end;
      end;
    //Free all pointers
    for I3 := 1 to Length(PointerArray) do
     begin
      pMem := PointerArray[I3];
      FreeMem(pMem, BytesToAllocate);
      PointerArray[I3] := nil;
     end;
   end;
 except
  Result := False;
 end;
end;

{just allocate 1 MB and immediately release it}
function TMMValidation.Validate10 : Boolean;
var
 SomeArray : array of Byte;
 MemoryStatus : TMemoryStatus;
 Address: Pointer;
 AddressCard : NativeUInt;
const
 BYTESTOALLOCATE = 1*1000*1000;//1 MB

begin
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  if MemoryStatus.dwAvailVirtual >= BYTESTOALLOCATE then
   begin
    SetLength(SomeArray, BYTESTOALLOCATE);
    Address := @SomeArray[0];
    AddressCard := NativeUInt(Address);
    //Is allocation 4 byte aligned?
    if AddressCard mod 4 <> 0 then
     Result := False;
   end;
 except
  Result := False;
 end;
end;

//Validating small to medium upsize of one array combined with many small strings resize

// allocates a maximum of 16 megabytes

function TMMValidation.Validate11 : Boolean;
const
  CIterations = 32*1000;
var
 I, J, K, L, NoOfStrings: Cardinal;
 I_SIZET: SIZE_T;
 SomeArray : array of Cardinal;
 StringArray : array[1..523{PrimeNumber}] of Ansistring;
 TempS : AnsiString;
 MemoryStatus : TMemoryStatus;
const
  BYTESTOALLOCATEMAX = CIterations;

begin
 Result := True;
 try
   NoOfStrings := Length(StringArray);
   for I := 0 to BYTESTOALLOCATEMAX-1 do
   begin
    //Clear a string sometimes
    if I mod 5 = 0 then
     StringArray[MMGetValue(NoOfStrings) + 1] := '';
    //Grow a string with an 'A'
    StringArray[(I mod NoOfStrings) + 1] := StringArray[(I mod Cardinal(Length(StringArray)))+1] + 'A';
    //Grow SomeArray if place for it
    FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
    GlobalMemoryStatus(MemoryStatus);
    I_SIZET := I;
    if MemoryStatus.dwAvailVirtual > I_SIZET then
     SetLength(SomeArray, I+1);
    SomeArray[I] := I;
    //Validate that SomeArray data are not changed
    for J := 0 to I do
     begin
      if SomeArray[J] <> J then
       begin
        Result := False;
        Exit;
       end;
     end;
    //Validate that all strings contains 'A's and nothing else
    for K := 1 to Length(StringArray) do
     begin
      TempS := StringArray[K];
      for L := 1 to Length(TempS) do
       begin
        if TempS[L] <> 'A' then
         begin
          Result := False;
          Exit;
         end;
       end;
     end;
   end;
 except
  Result := False;
 end;
end;

//Creates a square 2 dimensional array - same as #12, but doesn't truncate
//the product of the multiplication

// allocate 2MB in total for the short run

function TMMValidation.Validate39 : Boolean;
const
  CSquareSideLengthCardinalLongRun = 1100;
  CSquareSideLengthCardinalShortRun = 800;
var
 SomeArray : array of array of Cardinal;
 MemoryStatus : TMemoryStatus;
 I1, I2, I3, I4, I5, IMax : Cardinal;
 I_SIZET: SIZE_T;
begin
 Result := True;
 if ShortRun then
   IMax := CSquareSideLengthCardinalShortRun
 else
   IMax := CSquareSideLengthCardinalLongRun;

 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  //Grow array
  SetLength(SomeArray, 1, 1);
  SomeArray[0,0] := 0;
  for I1 := 2 to IMax do
   begin
    I_SIZET := I1*I1;
    if MemoryStatus.dwAvailVirtual >= I_SIZET then
     begin
      SetLength(SomeArray, I1, I1);
      //Old data preserved? (0's in first iteration)
      for I2 := 0 to I1-2 do
      begin
        for I3 := 0 to I1-2 do
        begin
         if SomeArray[I2,I3] <> (I2 or (I3 shl 16)) then
          begin
           Result := False;
           Exit;
          end;
        end;
      end;
      //Fill it (again)
      for I4 := 0 to I1-1 do
      begin
        for I5 := 0 to I1-1 do
        begin
          SomeArray[I4,I5] := (I4 or (I5 shl 16));
        end;
      end;
     end
    else
     //Stop test if no more memory available
     Exit;
   end;
 except
  Result := False;
 end;
end;


//Creates a square 2 dimensional array - same as #12, but doesn't truncate
//the product of the multiplication

function GetWordByXY_40(x, y, side: Integer): Word;
var
  Product: Int64;
  Remainder: Integer;
begin
  Product := y * side + x;
  Remainder := Product mod Length(VeryGoodPrimes);
  Result := Word(VeryGoodPrimes[Remainder]);
end;


// allocate 500KB in total for the short run, 5MB for the long run
function TMMValidation.Validate40 : Boolean;

const
  CSquareSideLengthWordLongRun = 1500;
  CSquareSideLengthWordShortRun = 500;

var
 SomeArray : packed array of packed array of Word;
 MemoryStatus : TMemoryStatus;
 I1, I2, I3, I4, I5, IMax : Cardinal;
 I_SIZET: SIZE_T;
begin
 Result := True;
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 if ShortRun then
   IMax := CSquareSideLengthWordShortRun
 else
   IMax := CSquareSideLengthWordLongRun;
 try
  //Grow array
  SetLength(SomeArray, 1, 1);
  SomeArray[0,0] := GetWordByXY_40(0, 0, IMax);
  for I1 := 2 to IMax do
   begin
    I_SIZET := I1*I1;
    if MemoryStatus.dwAvailVirtual >= I_SIZET then
     begin
      SetLength(SomeArray, I1, I1);
      //Old data preserved? (0's in first iteration)
      for I2 := 0 to I1-2 do
      begin
        for I3 := 0 to I1-2 do
        begin
         if SomeArray[I2,I3] <> GetWordByXY_40(I2, I3, Imax) then
          begin
           Result := False;
           Exit;
          end;
        end;
      end;
      //Fill it (again)
      for I4 := 0 to I1-1 do
      begin
        for I5 := 0 to I1-1 do
        begin
          SomeArray[I4,I5] := GetWordByXY_40(I4, I5, Imax);
        end;
      end;
     end
    else
     //Stop test if no more memory available
     Exit;
   end;
 except
  Result := False;
 end;
end;

function GetWordByXY_41(x, y, len: Integer): Word;
var
  Product: Int64;
  Remainder: Integer;
begin
  Product := y * len + x;
  Remainder := Product mod Length(VeryGoodPrimes);
  Result := Word(VeryGoodPrimes[Remainder]);
end;

// allocate 3MB for the short run, 47 MB for the long run
function TMMValidation.Validate41 : Boolean;

const
  CSquareSideLengthWordLongRun = 5000;
  CSquareSideLengthWordShortRun = 1250;

var
 SomeArray : packed array of packed array of Word;
 MemoryStatus : TMemoryStatus;
 IMax : Cardinal;
 X, Y: Cardinal;
 I: Integer;
 J: Integer;
begin
 Result := True;
 SleepAfterMemoryConsumingTest;
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 if ShortRun then
   IMax := CSquareSideLengthWordShortRun
 else
   IMax := CSquareSideLengthWordLongRun;
 try
  //Grow array
  X := 1;
  Y := 1;
  SetLength(SomeArray, X, Y);
  SomeArray[0,0] := GetWordByXY_41(X-1, Y-1, IMax);
  while (X < IMax) and (Y < IMax) do
  begin
     // grow X
     for I := 1 to 10 do
     begin
       Inc(X);
       SetLength(SomeArray, X, Y);
       for J := 0 to Y-1 do
       begin
         SomeArray[X-1,J] := GetWordByXY_41(X-1, J, IMax);
         if SomeArray[X-2,J] <> GetWordByXY_41(X-2, J, IMax) then
         begin
           Result := False;
           Exit;
         end;
       end;
     end;

     // grow Y
     for I := 1 to 10 do
     begin
       Inc(Y);
       SetLength(SomeArray, X, Y);
       for J := 0 to X-1 do
       begin
         SomeArray[J,Y-1] := GetWordByXY_41(J, Y-1, IMax);
         if SomeArray[J,Y-2] <> GetWordByXY_41(J, Y-2, IMax) then
         begin
           Result := False;
           Exit;
         end;
       end;
     end;

     for I := 0 to Y-2 do
     begin
       for J := 0 to X-2 do
       begin
         if SomeArray[I,J] <> GetWordByXY_41(I, J, IMax) then
         begin
         begin
           Result := False;
           Exit;
         end;
       end;
     end;
   end;
  end;
 except
  Result := False;
 end;
 SleepAfterMemoryConsumingTest;
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
end;



//Creates a square 2 dimensional array
//Grows it from 1x1 = 1 byte to CSideLength side length of the square

// allocates a maximum of 1MB

function TMMValidation.Validate12 : Boolean;
const
  CSquareSideLengthCardinal = 1000;

var
 SomeArray : array of array of Cardinal;
 MemoryStatus : TMemoryStatus;
 I1, I2, I3, I4, I5, IMax : Cardinal;
begin
 Result := True;
 SleepAfterMemoryConsumingTest;
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 IMax := CSquareSideLengthCardinal;
 try
  //Grow array
  SetLength(SomeArray, 1, 1);
  SomeArray[0,0] := 0;
  for I1 := 2 to IMax do
   begin
    if MemoryStatus.dwAvailVirtual >= I1*I1 then
     begin
      SetLength(SomeArray, I1, I1);
      //Old data preserved? (0's in first iteration)
      for I2 := 0 to I1-2 do
      begin
        for I3 := 0 to I1-2 do
        begin
         if SomeArray[I2,I3] <> (I2 * I3) mod 256 then
          begin
           Result := False;
           Exit;
          end;
        end;
      end;
      //Fill it (again)
      for I4 := 0 to I1-1 do
      begin
        for I5 := 0 to I1-1 do
        begin
          SomeArray[I4,I5] := (I4 * I5) mod 256;
        end;
      end;
     end
    else
     //Stop test if no more memory available
     Exit;
   end;
   Finalize(SomeArray);
 except
  Result := False;
 end;
 SleepAfterMemoryConsumingTest;
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
end;

// stress test... pushing the MM to an "Out of Memory" by allocating 16 kB pointers
// see whether we get an EOutOfMemory (OK) or something else (WRONG)

function TMMValidation.Validate13: Boolean;
const
{$IFDEF WIN64}
  NumPointers = 2500000;
  BlockSize = 16381 {prime};
{$ELSE}
  NumPointers = 250000;
  BlockSize = 16381 {prime};
{$ENDIF}
type
  PPointers = ^TPointers;
  TPointers = array[0..NumPointers-1] of Pointer;

var
 Pointers: PPointers;
 n : integer;
begin
 Result := False;
 New(Pointers);
 try
   n := 0;
   try
    repeat
     //Allocate 16 kB pointer
     GetMem(Pointers^[n], BlockSize);
     PAnsiChar(Pointers^[n])[0] := 'A';
{$WARN COMPARISON_TRUE OFF}
     if BlockSize > 2 then
     begin
       PAnsiChar(Pointers^[n])[BlockSize-1] := 'B';
     end;
{$WARN COMPARISON_TRUE ON}

     Inc(n);
    until n > High(Pointers^);
    Result := True;  // no exception at all, and using more than 250000 * 16384 = 4 GB...interesting !
   except
    on E: EOutOfMemory do  // that's the right exception...
     Result := True
    else // all other exceptions are wrong...
     Result := False;
   end;
   //Release memory
   while n > 0 do
    begin
     Dec(n);
     FreeMem(Pointers^[n], BlockSize);
    end;
 finally
   Dispose(Pointers);
 end;
end;


// allocate maximum of 80 KB
function TMMValidation.Validate14 : Boolean;
var
 SomeArray : array of Byte;
 MemoryStatus : TMemoryStatus;
 BytesToAllocate, I: Cardinal;
 StartAddress : Pointer;
 SizeT: SIZE_T;
const
 BYTESTOALLOCATEMIN = 70 * 1024;//70 Kbyte
 BYTESTOALLOCATEMAX = 80 * 1024;//80 Kbyte

begin
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  for BytesToAllocate := BYTESTOALLOCATEMIN to BYTESTOALLOCATEMAX do
   begin
    SizeT := BytesToAllocate;
    if MemoryStatus.dwAvailVirtual >= SizeT then
     begin
      //Allocate
      SetLength(SomeArray, BytesToAllocate);
      //4 byte alignment?
      StartAddress := @SomeArray[8];
      if NativeUint(StartAddress) mod 4 <> 0 then
       begin
        Result := False;
        Exit;
       end;
      for I := 0 to BytesToAllocate-1 do
       SomeArray[I] := 255;
      //Free
      SetLength(SomeArray, 0);
     end;
   end;
 except
  Result := False;
 end;
end;

function TMMValidation.Validate15: boolean;
var
 Ptr: Pointer;
const
  CSize = 10;
begin
 Result := False;
 {Allocate a block}
 GetMem(Ptr, CSize);
 {Free it}
 FreeMem(Ptr, CSize);
 {Try to free it again and see whether the MM catches the error}
 try
  FreeMem(Ptr, CSize);
  Result := False;
 except
   on E: EInvalidPointer do
     Result := True; // when we are trying to release a memory twice, we should get EInvalidPointer
   else
     Result := False;
 end;
end;

var
   TRRR: Integer;

function TMMValidation.Validate16: boolean;
const
  CPrimes : array[0..64] of Word = (
    131,137,149,157,163,179,193,211,227,241,257,277,283,293,307,331,359,389,443,
    449,487,541,619,631,733,739,877,881,967,1061,1259,1277,1499,1511,1801,1811,
    1984,2176,2273,2281,2287,2293,2297,2309,2311,2333,2339,2341,2347,2351,2357,
    2371,2377,2381,2383,2389,2393,2399,2411,2417,2423,2437,2441,2447,2459);
  CIterationsIn  = 3;
  CIterationsOut = 2;
var
  i, j, k, SIZE_TO_ALLOCATE: integer;
  t1: pointer;
  t2: pointer;
begin
  Result := False;
  for k := 0 to CIterationsOut-1 do
  begin
    for j := Low(CPrimes) to High(CPrimes) do
    begin
      SIZE_TO_ALLOCATE := CPrimes[j];
      i := CIterationsIn;
      while (i <> 0) do
      begin
        dec(i);
        Inc(TRRR);
        GetMem(t1, SIZE_TO_ALLOCATE);
        FreeMem(t1, SIZE_TO_ALLOCATE);
        try
          FreeMem(t1, SIZE_TO_ALLOCATE); // try to free two times -- it should give an exception!
          Result := False;
          Exit;
        except
             on E: EInvalidPointer do
               Result := True; // when we are trying to release a memory twice, we should get EInvalidPointer
             else
               Result := False;
        end;

        t1 := nil;
        t2 := nil;
        GetMem(t1, SIZE_TO_ALLOCATE);
        GetMem(t2, SIZE_TO_ALLOCATE);
        if (t1 = t2) then
        begin
          result := false;
          exit;
        end;
        FreeMem(t1, SIZE_TO_ALLOCATE);
        FreeMem(t2, SIZE_TO_ALLOCATE);
      end;
    end;
  end;
end;

var
  TotalMemoryAllocatedByValidae17: LONG;

{$ifdef FPC}
function InterlockedAdd(var Addend: Integer; Value: Integer): Integer; inline;
begin
  Result := InterlockedExchangeAdd(Addend, Value) + Value;
end;

var
  InterlockedAdd64CS: TRTLCriticalSection;

function InterlockedAdd64(var Addend: Int64; Value: Int64): Int64; inline;
begin
{$IFDEF WIN64}
 Result := InterlockedExchangeAdd64(Addend, Value) + Value;
{$ELSE}
 EnterCriticalSection(InterlockedAdd64CS);
 Inc(Addend, Value);
 Result := Addend;
 LeaveCriticalSection(InterlockedAdd64CS);
{$ENDIF}
end;

{$endif}

{
function InterlockedAdd(var Addend: Integer; Value: Integer): Integer; assembler;
asm
   lock xchg add
end;
}


// allocate maximum of 1 GB at once
function TMMValidation.Validate17 : Boolean;
var
  SomeArray : array of Byte;
  SomePointer: PAnsiChar;
  MemoryStatus : TMemoryStatus;
  Allocated: LONG;
  Touch: Cardinal;
  PrimeIdx: Integer;
const
  TouchStart = 7 {prime};
  ShortRunTouchStep = 8209 {prime};
  BYTESTOALLOCATE = 256*1000*1000;//256 Mbyte
  BYTESTOALLOCATEMAX = BYTESTOALLOCATE*4;
begin
  SomePointer := nil;
  FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
  GlobalMemoryStatus(MemoryStatus);
  try
    if MemoryStatus.dwAvailVirtual >= BYTESTOALLOCATE then
    begin


      // increase the counter
      Allocated := InterlockedAdd(TotalMemoryAllocatedByValidae17, BYTESTOALLOCATE);
      if Allocated < BYTESTOALLOCATEMAX then
      begin
        if ShortRun then
        begin
          Result := True;
          // allocate the buffer
          GetMem(SomePointer, BYTESTOALLOCATE);

          // fill the data
          PrimeIdx := Low(VeryGoodPrimes);
          Touch := TouchStart;
          while Touch < BYTESTOALLOCATE do
          begin
            SomePointer[Touch] := AnsiChar(Byte(VeryGoodPrimes[PrimeIdx]));
            Inc(Touch, ShortRunTouchStep);
            Inc(PrimeIdx);
            if PrimeIdx > High(VeryGoodPrimes) then PrimeIdx := Low(VeryGoodPrimes);
          end;

          // verify the data
          PrimeIdx := Low(VeryGoodPrimes);
          Touch := TouchStart;
          while Touch < BYTESTOALLOCATE do
          begin
            if SomePointer[Touch] <> AnsiChar(Byte(VeryGoodPrimes[PrimeIdx])) then
            begin
              Result := False;
              Break;
            end;
            Inc(Touch, ShortRunTouchStep);
            Inc(PrimeIdx);
            if PrimeIdx > High(VeryGoodPrimes) then PrimeIdx := Low(VeryGoodPrimes);
          end;

          // release the buffer
          FreeMem(SomePointer, BYTESTOALLOCATE);
          SomePointer := nil;
        end else
        begin
          SetLength(SomeArray, BYTESTOALLOCATE);
          Inc(SomeArray[Low(SomeArray)]);  // touch again the memory allocated
          Inc(SomeArray[High(SomeArray)]); // touch again the memory allocated
          Result := (SomeArray[(Low(SomeArray))] = 1) and (SomeArray[High(SomeArray)] = 1);
        end;
      end else
      begin
        Result := True;
      end;
      Finalize(SomeArray);
      if SomePointer <> nil then
      begin
        FreeMem(SomePointer, BYTESTOALLOCATE);
        SomePointer := nil;
      end;

      // decrease the counter
      InterlockedAdd(TotalMemoryAllocatedByValidae17, -BYTESTOALLOCATE);
    end;
  except
    Result := False;
  end;
end;

//Grow dynamic array with STEPSIZE from MIN to MAX and validate that it is 8 byte aligned

// allocate 700 MB or long run, 7MB on short run

function TMMValidation.Validate18 : Boolean;
var
 SomeArray : array of Byte;
 MemoryStatus : TMemoryStatus;
 BytesToAllocate, I, Iter : Cardinal;
 StartAddress: Pointer;
 FillMax: Cardinal;
 MMax: Cardinal;
 BYTESTOALLOCATEMIN: Cardinal;
 PrimeIndex: Integer;
 CFillByte: Byte;
 InitialSizeT: SIZE_T;
const
 CIterationCount = 12;
 CFillStep = 4093;
 BYTESTOALLOCATESTEPSIZE = 11 {prime};
 BYTESTOALLOCATEMAX_LONG_RUN = 700*1000*1000;
 BYTESTOALLOCATEMAX_SHORT_RUN = 7*1000*1000;

begin
 Result := True;
 if ShortRun then MMax := BYTESTOALLOCATEMAX_SHORT_RUN else MMax := BYTESTOALLOCATEMAX_LONG_RUN;
 PrimeIndex := Low(VeryGoodPrimes);
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 InitialSizeT := MemoryStatus.dwAvailVirtual;
 for Iter := 1 to CIterationCount do
 try
  BYTESTOALLOCATEMIN := VeryGoodPrimes[PrimeIndex];
  CFillByte := Byte(BYTESTOALLOCATEMIN);
  Inc(PrimeIndex);
  if PrimeIndex>High(VeryGoodPrimes) then
  begin
    PrimeIndex := Low(VeryGoodPrimes);
  end;

  BytesToAllocate := BYTESTOALLOCATEMIN;
  while BytesToAllocate <= MMax do
   begin
    if InitialSizeT >= BytesToAllocate then
     begin
      //Allocate
      SetLength(SomeArray, BytesToAllocate);
      //8 byte alignment?
      StartAddress := @(SomeArray[0]);
      if NativeUint(StartAddress) mod 8 <> 0 then
       begin
        Result := False;
        Exit;
       end;
      FillMax := (BytesToAllocate div CFillStep);
      if FillMax > 0 then
      begin
        SomeArray[Low(SomeArray)] := CFillByte;
        for I := 0 to FillMax-1 do
        begin
         SomeArray[I*CFillStep] := CFillByte;  {touch the allocated memory}
        end;
        SomeArray[High(SomeArray)] := CFillByte;
      end else
      begin
        SomeArray[Low(SomeArray)] := CFillByte;
        SomeArray[High(SomeArray)] := CFillByte;
      end;
      //Free
      SetLength(SomeArray, 0);
      BytesToAllocate := BytesToAllocate * BYTESTOALLOCATESTEPSIZE;
     end else
     begin
       BytesToAllocate := BytesToAllocate;
     end;
   end;
 except
  Result := False;
 end;
end;

//Allocates 100000 pointers up to BYTESTOALLOCATEMAX per pointer
//Validate 4 byte alignment, unique pointers, non overlapping blocks,
//read and write to block with 4 byte granularity, but does not write past the end.
//Does not write to the last 0-3 bytes of a block

function TMMValidation.Validate19 : Boolean;
const
  CIterations = 11;
  CNumPointers = 100*1000;
var
 IterationCounter, I1, I2, I3, J1, J2, J3, BytesToAllocate, RunNo, BigBlockSize : Cardinal;
 PointersToFill, MemBlockSize: NativeUInt;
 pMem : Pointer;
 PNU: PNativeUInt;
 PointerArray : array[1..CNumPointers] of Pointer;
 MemoryStatus : TMemoryStatus;
 pInt : PPointer;
 RefData : Pointer;
 SizeT: SIZE_T;
const
 BYTESTOALLOCATEMAX = 2500;//2.5 Kbyte per pointer max
 RUNNOMAX = CIterations;
 BIGBLOCKGROWRATE = 1024*1024;//1 MB extra per run

begin
 IterationCounter := 0;
 Result := True;
 try
  for RunNo := 1 to RUNNOMAX do
   begin
    //Initialize pointer array - not really needed
    for I1 := Low(PointerArray) to High(PointerArray) do
     PointerArray[I1] := nil;
    for I2 := Low(PointerArray) to High(PointerArray) do
     begin
      if I2 = 1 then
       begin
        BigBlockSize := RunNo * BIGBLOCKGROWRATE + SizeOf(Pointer);     //Always allocate >= 4 byte
        BytesToAllocate := BigBlockSize//Allocate one big block that grows linearily
       end
      else
       begin
        BytesToAllocate := MMGetValue(BYTESTOALLOCATEMAX-1)+SizeOf(Pointer);//Always allocate >= 4 byte
       end;
      if BytesToAllocate < SizeOf(Pointer) then
       raise Exception.Create('To small block allocated');

      if ShortRun then
      begin
        Inc(IterationCounter);
        if (IterationCounter mod 997 {prime}) <> 1 then
        begin
          // run only each 997th attempt
          Continue;
        end;
      end;



      FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
      GlobalMemoryStatus(MemoryStatus);
      SizeT := BytesToAllocate;
      if MemoryStatus.dwAvailVirtual >= SizeT then
       begin
        //Allocate all pointers
        GetMem(pMem, BytesToAllocate);
        if NativeUInt(pMem) mod SizeOf(Pointer) <> 0 then
         begin
          //Pointer not aligned
          Result := False;
          Exit;
         end;
        PointerArray[I2] := pMem;
        //Fill allocated memory with unique data = Pointer
        pInt := pMem;
        PointersToFill := (BytesToAllocate) div SizeOf(Pointer);
        if PointersToFill > 0 then
         begin
          //But write size in pointers in first bytes
          pInt^ := Pointer(PointersToFill);
          Inc(pInt);
          //Does not write to all bytes in block if block size is not multiple of 4
          for J1 := 1 to PointersToFill-1 do
           begin
            //Write with pointer size byte granularity
            pInt^ := pMem;
            Inc(pInt);
           end;
         end;
       end;
     end;
    //No mem overwritten
    for J2 := Low(PointerArray) to High(PointerArray) do
     begin
      pInt := PointerArray[J2];
      RefData := PointerArray[J2];
      if (pInt = nil) or (RefData = nil) then Continue;


      pnu := PNativeUInt(pInt);
      MemBlockSize := pnu^;

      Inc(pInt);


      if MemBlockSize > 0 then
      begin
        for J3 := 1 to MemBlockSize-1 do
         begin
          if pInt^ <> RefData then
           begin
            //Memory block is overwritten
            Result := False;
            Exit;
           end;
          Inc(pInt);
         end;
      end else
      begin
        MemBlockSize := MemBlockSize;
      end;
     end;
    //Free all pointers
    for I3 := Low(PointerArray) to High(PointerArray) do
     begin
      pMem := PointerArray[I3];
      FreeMem(pMem, BytesToAllocate);
      PointerArray[I3] := nil;
     end;
   end;
 except
  Result := False;
 end;
end;

function TMMValidation.Validate20 : Boolean;
var
 SomeArray : array of Byte;
 MemoryStatus : TMemoryStatus;
 C: Cardinal;
 SizeT: SIZE_T;
const
 BYTESTOALLOCATE_LONG = 1024*1024*1024;//1G
 BYTESTOALLOCATE_SHORT = 5*1024*1024;//5M

begin
  if ShortRun then
  begin
    C := BYTESTOALLOCATE_SHORT;
  end else
  begin
    C := BYTESTOALLOCATE_LONG;
  end;

 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  SizeT := C;
  if MemoryStatus.dwAvailVirtual >= SizeT then
   SetLength(SomeArray, C);
 except
  Result := False;
 end;
end;


const
  MaxAllowedByValidate21 = 30*1024*1024; {30 MB}

var
  TotalAllocatedByValidate21: LONG;

function TMMValidation.Validate21 : Boolean;
var
  SomeArray : array of Byte;
  MemoryStatus : TMemoryStatus;
  I1, I2, I3, SmallAllocSize, BigAllocSize : Cardinal;
  Prime,I6: Int64;
  PrimeIdx: Integer;
  Executed, Skipped: Integer;
  Total: LONG;
  SizeT: SIZE_T;
const
  CSkipPrimeOnShortRun = 3; // a prime number, skip each N-th run on a short run
  SMALLALLOCSIZEMIN = 1;//1 byte
  SMALLALLOCSIZEMAX = 100;//100 byte
  BIGALLOCSIZEMIN = 1024*1024;//1 Mbyte
  BIGALLOCSIZEMAX = 1024*1024 + 100;//1 Mbyte + 100 b
  FILLBYTE = 223 {prime};
begin
  Result := True;
  Executed := 0;
  Skipped := 0;

  PrimeIdx := Low(VeryGoodPrimes);
  try
    for SmallAllocSize := SMALLALLOCSIZEMIN to SMALLALLOCSIZEMAX do
    begin
      for BigAllocSize := BIGALLOCSIZEMIN to BIGALLOCSIZEMAX do
      begin
        if ShortRun then
        begin
          Prime := VeryGoodPrimes[PrimeIdx];
          Inc(PrimeIdx);
          if PrimeIdx > High(VeryGoodPrimes) then PrimeIdx := Low(VeryGoodPrimes);
          I6 := SmallAllocSize*BigAllocSize;
          I6 := I6*Prime;
          if I6 mod CSkipPrimeOnShortRun <> 1 then
          begin
            Inc(Skipped);
            Continue;
          end else
          begin
            if True then
            Inc(Executed);
          end;
        end;
        try
          Total := InterlockedAdd(TotalAllocatedByValidate21, BigAllocSize+SmallAllocSize);
          if Total < MaxAllowedByValidate21 then
          begin
            FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
            GlobalMemoryStatus(MemoryStatus);
            SizeT := BigAllocSize+SmallAllocSize;
            if MemoryStatus.dwAvailVirtual >= SizeT then
            begin
              SetLength(SomeArray, SmallAllocSize);
              for I1 := 0 to SmallAllocSize-1 do
              begin
                SomeArray[I1] := FILLBYTE;
              end;
              SetLength(SomeArray, BigAllocSize);
              for I2 := 0 to SmallAllocSize-1 do
              begin
                if SomeArray[I2] <> FILLBYTE then
                 begin
                  Result := False;
                  Exit;
                 end;
              end;
              SetLength(SomeArray, SmallAllocSize);
              for I3 := 0 to SmallAllocSize-1 do
               begin
                if SomeArray[I3] <> FILLBYTE then
                 begin
                  Result := False;
                  Exit;
                 end;
               end;
            end;
          end else
          begin
            Dec(Executed);
            Inc(Skipped);
          end;
        finally
          InterlockedAdd(TotalAllocatedByValidate21, -(BigAllocSize+SmallAllocSize));
        end;
      end;
    end;
  except
    Result := False;
  end;
end;

//Grow dynamic array with STEPSIZE from MIN to MAX and validate that it is 4 byte aligned

function TMMValidation.Validate22 : Boolean;
var
 SomeArray : array of Byte;
 MemoryStatus : TMemoryStatus;
 BytesToAllocate, I2, I3, OldBytesToAllocate : Cardinal;
 StartAddress: Pointer;
 IterationCounter: Int64;
 SizeT: SIZE_T;
const
 BYTESTOALLOCATESTEPSIZE = 2;
 BYTESTOALLOCATEMIN = 5;//5 byte
 BYTESTOALLOCATEMAX = 50*1024*1024;//50 Mbyte
 FILLBYTE = 227 {prime};

begin
 try
  Result := True;
  OldBytesToAllocate := 1;
  //Allocate
  SetLength(SomeArray, 1);
  SomeArray[0] := FILLBYTE;
  BytesToAllocate := BYTESTOALLOCATEMIN;
  while BytesToAllocate <= BYTESTOALLOCATEMAX do
   begin
    Inc(IterationCounter);
    if ShortRun then
    begin
      if Odd(IterationCounter) then Continue;
    end;
    FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
    GlobalMemoryStatus(MemoryStatus);
    SizeT := BytesToAllocate;
    if MemoryStatus.dwAvailVirtual >= SizeT then
     begin
      //Reallocate
      SetLength(SomeArray, BytesToAllocate);
      //Old data preserved?
      for I3 := 0 to OldBytesToAllocate-1 do
       begin
        if SomeArray[I3] <> FILLBYTE then
         begin
          Result := False;
          Exit;
         end;
       end;
      //4 byte alignment?
      //No need to add offset to compensate for refcount and size data
      StartAddress := @SomeArray[0];
      if NativeUInt(StartAddress) mod 4 <> 0 then
       begin
        Result := False;
        Exit;
       end;
      //Fill newly allocated space
      for I2 := OldBytesToAllocate to BytesToAllocate-1 do
       SomeArray[I2] := FILLBYTE;
      OldBytesToAllocate := BytesToAllocate;
      BytesToAllocate := BytesToAllocate * BYTESTOALLOCATESTEPSIZE;
     end;
   end;
  //Free
  SetLength(SomeArray, 0);
 except
  Result := False;
 end;
end;

//Allocate NOOFPOINTERS starting at 1 byte size and growing with
//ALLOCGROWSTEPSIZE per pointer and then free's them all.
//Validates that all allocated memory is freed after SLEEPTIMEAFTERFREE seconds.

//NOT ACCEPTED BY COMMUNITY
{
function TMMValidation.Validate23 : Boolean;
var
 MemoryStatus : TMemoryStatus;
 PointerArray : array of Pointer;
 I, IntitialFreeMemlory, EndFreeMemory : Integer;
 AllocSize : Integer;
 AllocSizeFP : Double;
const
 NOOFPOINTERS : Integer = 1000000;
 ALLOCGROWSTEPSIZE : Double = 0.001;
 SLEEPTIMEAFTERFREE : Integer = 10;//Seconds to free
 SLACK : Integer = 32*1024*1024;

begin
 try
  Result := True;
  GlobalMemoryStatus(MemoryStatus);
  IntitialFreeMemory := MemoryStatus.dwAvailVirtual;
  //Allocate
  SetLength(PointerArray, NOOFPOINTERS);
  AllocSizeFP := 1;
  for I:= 0 to Length(PointerArray)-1 do
   begin
    AllocSizeFP := AllocSizeFP + ALLOCGROWSTEPSIZE;
    AllocSize := Round(AllocSizeFP);
    GetMem(PointerArray[I], AllocSize);
   end;
  //Free
  for I:= 0 to Length(PointerArray)-1 do
   FreeMem(PointerArray[I]);
  SetLength(PointerArray, 0);
  //Give a little time to free
  Sleep(SLEEPTIMEAFTERFREE*1000);
  GlobalMemoryStatus(MemoryStatus);
  EndFreeMemory := MemoryStatus.dwAvailVirtual;
  //Did everything get freed?
  if IntitialFreeMemory - EndFreeMemory > SLACK then
   Result := False;
 except
  Result := False;
 end;
 //More free than when we started !!!!!!!!!!!!!
 if EndFreeMemory > IntitialFreeMemory then
  raise Exception.Create('More free memory after running test !!!');
end;
}




const
  MaxAllowedToAllocateForValidate24 = 500*1024*1024;
var
  TotalAllocatedByValidate24: LONG;

// Allocate 500 MB

function TMMValidation.Validate24 : Boolean;
var
 MemoryStatus : TMemoryStatus;
 PointerArray : packed array of Pointer;
 SizeArray : packed array of Cardinal;
 I: Integer;
 FreeMemoryRun1, FreeMemoryLastRun : SIZE_T;
 AllocSize, RunNo : Integer;
 AllocSizeFP : Double;
 Total: ULONG;
 RunAgain, FirstRun: Boolean;
const
 NOOFPOINTERS = 1000000;
 ALLOCGROWSTEPSIZE : Double = 0.001;
 SLACK = 100*1024;

begin
 FirstRun := True;
 repeat
   RunAgain := False;
   try
    FreeMemoryRun1 := 0;//For compiler
    for RunNo := 1 to 2 do
     begin
      Result := True;
      //Allocate
      SetLength(PointerArray, NOOFPOINTERS);
      SetLength(SizeArray, NOOFPOINTERS);

      for I:= 0 to Length(PointerArray)-1 do
      begin
        PointerArray[I] := nil;
        SizeArray[I] := 0;
      end;

      AllocSizeFP := 1;
      for I:= 0 to Length(PointerArray)-1 do
       begin
        AllocSizeFP := AllocSizeFP + ALLOCGROWSTEPSIZE;
        AllocSize := Round(AllocSizeFP);
        Total := InterlockedAdd(TotalAllocatedByValidate24, AllocSize);
        if Total < MaxAllowedToAllocateForValidate24 then
        begin
          SizeArray[I] := AllocSize;
          GetMem(PointerArray[I], AllocSize);
        end else
        begin
          InterlockedAdd(TotalAllocatedByValidate24, -AllocSize);
        end;
       end;
      //Free
      for I:= 0 to Length(PointerArray)-1 do
      begin
        if PointerArray[I] <> nil then
        begin
          AllocSize := SizeArray[I];
          InterlockedAdd(TotalAllocatedByValidate24, -AllocSize);
          FreeMem(PointerArray[I], AllocSize);
          PointerArray[I] := nil;
          SizeArray[I] := 0;
        end;
      end;
      SetLength(PointerArray, 0); Finalize(PointerArray);
      SetLength(SizeArray, 0); Finalize(SizeArray);
      FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
      //Give a little time to free
      SleepAfterMemoryConsumingTest;
      GlobalMemoryStatus(MemoryStatus);
      if RunNo = 1 then
      begin
       FreeMemoryRun1 := MemoryStatus.dwAvailVirtual
      end
      else
       begin
        FreeMemoryLastRun := MemoryStatus.dwAvailVirtual;
        //Did memory usage increase?
        if FreeMemoryLastRun < (FreeMemoryRun1 - SLACK) then
        begin
          Result := False;
          if not FirstRun then Break;
          FirstRun := False;
          SleepAfterMemoryConsumingTest;
          GlobalMemoryStatus(MemoryStatus);
          FreeMemoryRun1 := MemoryStatus.dwAvailVirtual;
          RunAgain := True;
        end else
        begin
          Result := True;
          Break;
        end;
       end;
     end;
   except
    Result := False;
   end;
 until not RunAgain;
end;

//Based on Validate11 but validating big array downsize combined with many small strings resize

function TMMValidation.Validate26 : Boolean;
var
 I, J, K, L, I2, NoOfStrings  : Cardinal;
 SomeArray : array of Cardinal;
 StringArray : array[1..10000] of Ansistring;
 TempS : AnsiString;
 MemoryStatus : TMemoryStatus;
 SomeArraySize : Cardinal;
 SomeArraySizeFP : Double;
const
 NOOFRUNS : Integer = 2000;
 SOMEARRAYMAXSIZE : Integer = 50*1024*1024;
 SHRINKFACTOR : Double = 0.95;
begin
 Result := True;
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  SomeArraySize := SOMEARRAYMAXSIZE;
  SomeArraySizeFP := SomeArraySize;
  if MemoryStatus.dwAvailVirtual >= SomeArraySize then
   SetLength(SomeArray, SomeArraySize);
  //Fill SomeArray
  for I2 := 0 to SomeArraySize-1 do
   SomeArray[I2] := I2;
  for I := 0 to NOOFRUNS-1 do
   begin
    NoOfStrings := Length(StringArray);
    //Clear a string sometimes
    if I mod 5 = 0 then
     StringArray[MMGetValue(NoOfStrings) + 1] := '';
    //Grow a string with an 'A'
    StringArray[(I mod NoOfStrings) + 1] := StringArray[(I mod Cardinal(Length(StringArray)))+1] + 'A';
    //Shrink SomeArray
    SomeArraySizeFP := SomeArraySizeFP * SHRINKFACTOR;
    SomeArraySize := Round(SomeArraySizeFP);
    //SomeArray length always > 0
    if SomeArraySize <= 0 then
     SomeArraySize := 1;
    SetLength(SomeArray, SomeArraySize);
    //Validate that SomeArray data are not changed
    for J := 0 to SomeArraySize-1 do
     begin
      if SomeArray[J] <> J then
       begin
        Result := False;
        Exit;
       end;
     end;
    //Validate that all strings contains 'A's and nothing else
    for K := 1 to Length(StringArray) do
     begin
      TempS := StringArray[K];
      for L := 1 to Length(TempS) do
       begin
        if TempS[L] <> 'A' then
         begin
          Result := False;
          Exit;
         end;
       end;
     end;
   end;
   Finalize(StringArray);
   Finalize(SomeArray);
 except
  Result := False;
 end;
end;

function TMMValidation.Validate27 : Boolean;
const
  ITERATIONS = 100;
  DLL_FUNCTIONNAME = 'LeakSomeMemory';
  DLL_BASENAME = 'MMUsageDLL';
var
  Handle: integer;
  LInitialUsage: Cardinal;
  ExportedMethod: TExportedMethod;
  LFileName: string;
begin
  {Get the initial memory usage}
  LInitialUsage := GetAddressSpaceUsed;
  {Default to fail}
  Result := False;
  {Build the DLL filename}
  LFileName := Format('%s_%s_%s.dll', [DLL_BASENAME, GetCompilerAbbr, GetMMName]);
  {Load the DLL}
  Handle := LoadLibrary(PChar(LFileName));
  if Handle = 0 then
  begin
    // ShowMessage('Cannot Load DLL ' + LFileName);
    Exit;
  end;
  {Get the exported procedure}
  {$IFDEF FPC}
  Pointer(ExportedMethod) := GetProcAddress(Handle, DLL_FUNCTIONNAME);
  {$ELSE}
  ExportedMethod := GetProcAddress(Handle, DLL_FUNCTIONNAME);
  {$ENDIF}
  if @ExportedMethod = nil then
  begin
    // ShowMessage('Cannot Find ' + DLL_FUNCTIONNAME);
    FreeLibrary(Handle);
    Exit;
  end;
  {Run the exported method}
  ExportedMethod;
  {Free the library}
  FreeLibrary(Handle);
  {Was the memory leak in the DLL corrected? Allow maximum increase of 256K}
  if GetAddressSpaceUsed - LInitialUsage < 4 then
    Result := True;
end;

//****************************************************************************
//Multithreadvalidation
//****************************************************************************

type

  TMultiThreadValidate25Thread = class(TThread)
  public
   function GetPassed : Boolean;
   procedure Execute; override;
   function ThreadGetValue(ACeil: Integer): Integer;
  private
   Passed : Boolean;
   PrimeModValue: Integer;
   function MultiThreadValidate1 : Boolean;
   function MultiThreadValidate2 : Boolean;
   function MultiThreadValidate3 : Boolean;
   function MultiThreadValidate4 : Boolean;
   function MultiThreadValidate5 : Boolean;
   function MultiThreadValidate6 : Boolean;
  end;

function TMultiThreadValidate25Thread.GetPassed : Boolean;
begin
 Result := Passed;
end;


const
  Validate25Divizor = 11;

function TMultiThreadValidate25Thread.MultiThreadValidate1 : Boolean;
var
 SomeArray : array of Byte;
 MemoryStatus : TMemoryStatus;
const
 BYTESTOALLOCATE = 100*1024*1024 div Validate25Divizor;//100 MB

begin
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  if MemoryStatus.dwAvailVirtual >= BYTESTOALLOCATE then
   SetLength(SomeArray, BYTESTOALLOCATE);
 except
  Result := False;
 end;
end;

function TMultiThreadValidate25Thread.MultiThreadValidate2 : Boolean;
var
 SomeArray : array of Byte;
 MemoryStatus : TMemoryStatus;
 RunNo : Cardinal;
 SomeArraySize : Integer;
const
 BYTESTOALLOCATEMAX = 100000;//
 NOOFRUNS = 10000 div Validate25Divizor;
 STEPSIZE = 1024;

begin
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  if MemoryStatus.dwAvailVirtual >= BYTESTOALLOCATEMAX then
   SetLength(SomeArray, BYTESTOALLOCATEMAX);
  for RunNo := 1 to NOOFRUNS do
   begin
    SomeArraySize := BYTESTOALLOCATEMAX - RunNo * Trunc(BYTESTOALLOCATEMAX / NOOFRUNS);
    //Downsize
    SetLength(SomeArray, SomeArraySize);
    //Upsize
    SetLength(SomeArray, SomeArraySize + STEPSIZE);
   end;
 except
  Result := False;
 end;
end;

//Reallocate one dynamic array

function TMultiThreadValidate25Thread.MultiThreadValidate3 : Boolean;
var
 Size, RunNo : Cardinal;
 SomeArray : array of Byte;
 MemoryStatus : TMemoryStatus;
const
 MAXSIZE = 10000;
 RUNNOMAX = (10 div Validate25Divizor)+1;

begin
 try
  Result := True;
  for RunNo := 1 to RUNNOMAX do
   begin
    FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
    GlobalMemoryStatus(MemoryStatus);
    Size := ThreadGetValue(MAXSIZE);
    if MemoryStatus.dwAvailVirtual >= Size then
     SetLength(SomeArray, Size);
   end;
  //"Free"
  SetLength(SomeArray, 0);
 except
  Result := False;
 end;
end;

function TMultiThreadValidate25Thread.MultiThreadValidate4 : Boolean;
var
 Size, StringNo, I : Cardinal;
 StringArray : array of AnsiString;
 MemoryStatus : TMemoryStatus;
const
 MAXSIZE = 25;
 NOOFSTRINGS = 1000000 div Validate25Divizor;
begin
 try
  Result := True;
  SetLength(StringArray, NOOFSTRINGS);
  for StringNo := 0 to NOOFSTRINGS-1 do
   begin
    FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
    GlobalMemoryStatus(MemoryStatus);
    Size := ThreadGetValue(MAXSIZE);
    if MemoryStatus.dwAvailVirtual >= Size then
     begin
      SetLength(StringArray[StringNo], Size);
      //Fill string
      for I := 1 to Size do
       StringArray[StringNo][I] := 'A';
     end
   end;
  //Validate string content for all strings
  for StringNo := 0 to NOOFSTRINGS-1 do
   begin
    for I := 1 to Length(StringArray[StringNo]) do
     begin
      if StringArray[StringNo][I] <> 'A' then
       begin
        Result := False;
        Break;
       end;
     end;
   end;
  //"Free" all strings
  for StringNo := 0 to NOOFSTRINGS-1 do
   SetLength(StringArray[StringNo], 0);
  SetLength(StringArray, 0);
 except
  Result := False;
 end;
end;

function TMultiThreadValidate25Thread.MultiThreadValidate5 : Boolean;
var
 Size : Cardinal;
 StringNo, I, RunNo : Cardinal;
 StringArray : array of AnsiString;
 MemoryStatus : TMemoryStatus;
const
 MAXRUNNO = (200 div Validate25Divizor)+1;
 MINSIZE  = 10;
 MAXSIZE = 1000;
 NOOFSTRINGS = 10000;

begin
 try
  Result := True;
  SetLength(StringArray, NOOFSTRINGS);
  for RunNo := 1 to MAXRUNNO do
   begin
    for StringNo := 0 to NOOFSTRINGS-1 do
     begin
      FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
      GlobalMemoryStatus(MemoryStatus);
      Size := Cardinal(ThreadGetValue(MAXSIZE - MINSIZE)) + MINSIZE;
      if MemoryStatus.dwAvailVirtual >= Size then
       begin
        SetLength(StringArray[StringNo], Size);
        //Fill string up to MINSIZE in round 1
        if RunNo = 1 then
         begin
          for I := 1 to MINSIZE do
           StringArray[StringNo][I] := 'A';
         end
        else
         begin
          //Fill string from MINSIZE to Size in remaining rounds
          if Size > MINSIZE + 1 then
           begin
            for I := MINSIZE + 1 to Size do
             StringArray[StringNo][I] := 'X';
           end;
         end;
       end
     end;
    //Validate string content in low part up to MINSIZE for all strings
    for StringNo := 0 to NOOFSTRINGS-1 do
     begin
      for I := 1 to MINSIZE do
       begin
        if StringArray[StringNo][I] <> 'A' then
         begin
          Result := False;
          Break;
         end;
       end;
     end;
   end;
  //"Free" all strings
  for StringNo := 0 to NOOFSTRINGS-1 do
   SetLength(StringArray[StringNo], 0);
  //"Free" StringArray
  SetLength(StringArray, 0);
 except
  Result := False;
 end;
end;

function TMultiThreadValidate25Thread.MultiThreadValidate6 : Boolean;
var
 Size, StringNo, I, RunNo : Cardinal;
 StringArray : array of AnsiString;
 MemoryStatus : TMemoryStatus;
const
 MAXRUNNO = (20 div Validate25Divizor)+1;
 MINSIZE  = 1024;
 MAXSIZE = 10*1024*1024;
 NOOFSTRINGS = 20;

begin
 try
  Result := True;
  SetLength(StringArray, NOOFSTRINGS);
  for RunNo := 1 to MAXRUNNO do
   begin
    for StringNo := 0 to NOOFSTRINGS-1 do
     begin
      FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
      GlobalMemoryStatus(MemoryStatus);
      Size := Cardinal(ThreadGetValue(MAXSIZE - MINSIZE)) + MINSIZE;
      if MemoryStatus.dwAvailVirtual >= Size then
       begin
        SetLength(StringArray[StringNo], Size);
        //Fill string up to MINSIZE in round 1
        if RunNo = 1 then
         begin
          for I := 1 to MINSIZE do
           StringArray[StringNo][I] := 'A';
         end
        else
         begin
          //Fill string from MINSIZE to Size in remaining rounds
          if Size > MINSIZE + 1 then
           begin
            for I := MINSIZE + 1 to Size do
             StringArray[StringNo][I] := 'X';
           end;  
         end;
       end
     end;
    //Validate string content in low part up to MINSIZE for all strings
    for StringNo := 0 to NOOFSTRINGS-1 do
     begin
      for I := 1 to MINSIZE do
       begin
        if StringArray[StringNo][I] <> 'A' then
         begin
          Result := False;
          Break;
         end;
       end;
     end;
   end;
  //"Free" all strings
  for StringNo := 0 to NOOFSTRINGS-1 do
   SetLength(StringArray[StringNo], 0);
  //"Free" StringArray
  SetLength(StringArray, 0);
 except
  Result := False;
 end;
end;

function TMultiThreadValidate25Thread.ThreadGetValue(ACeil: Integer): Integer;
begin
  Inc(PrimeModValue, 509); // a prime number
  Result := PrimeModValue mod ACeil;
end;


procedure SleepUntilRunningNextThread;
begin
{$IFDEF WIN32}
  Sleep(1000); // 1 second under Win32
{$ELSE}
  Sleep(50); // 1/50th of a second should be enough under Win64
{$ENDIF}
end;

const
  AllowOnlyLowestThreads = True;


procedure TMultiThreadValidate25Thread.Execute;
begin
 Passed := MultiThreadValidate1
       and MultiThreadValidate2
       and MultiThreadValidate3
       and MultiThreadValidate4
       and MultiThreadValidate5
       and MultiThreadValidate6;
end;

function TMMValidation.Validate25 : Boolean;
var
 MultiThreadValidateThread1 : TMultiThreadValidate25Thread;
 MultiThreadValidateThread2 : TMultiThreadValidate25Thread;
 MultiThreadValidateThread3 : TMultiThreadValidate25Thread;
 MultiThreadValidateThread4 : TMultiThreadValidate25Thread;
 Result1, Result2, Result3, Result4 : Boolean;

begin
 MultiThreadValidateThread1 := TMultiThreadValidate25Thread.Create(True);
 MultiThreadValidateThread2 := TMultiThreadValidate25Thread.Create(True);
 MultiThreadValidateThread3 := TMultiThreadValidate25Thread.Create(True);
 MultiThreadValidateThread4 := TMultiThreadValidate25Thread.Create(True);
 MultiThreadValidateThread1.FreeOnTerminate := False;
 MultiThreadValidateThread2.FreeOnTerminate := False;
 MultiThreadValidateThread3.FreeOnTerminate := False;
 MultiThreadValidateThread4.FreeOnTerminate := False;

 if AllowOnlyLowestThreads then
 begin
   MultiThreadValidateThread1.Priority := tpLowest;
   MultiThreadValidateThread2.Priority := tpLowest;
   MultiThreadValidateThread3.Priority := tpLowest;
   MultiThreadValidateThread4.Priority := tpLowest;
 end else
 begin
   MultiThreadValidateThread1.Priority := tpLowest;
   MultiThreadValidateThread2.Priority := tpLower;
   MultiThreadValidateThread3.Priority := tpNormal;
   MultiThreadValidateThread4.Priority := tpHighest;
 end;
 SleepUntilRunningNextThread;
 MultiThreadValidateThread1.Start;
 SleepUntilRunningNextThread;
 MultiThreadValidateThread2.Start;
 SleepUntilRunningNextThread;
 MultiThreadValidateThread3.Start;
 SleepUntilRunningNextThread;
 MultiThreadValidateThread4.Start;
 MultiThreadValidateThread1.WaitFor;
 MultiThreadValidateThread2.WaitFor;
 MultiThreadValidateThread3.WaitFor;
 MultiThreadValidateThread4.WaitFor;
 Result1 := MultiThreadValidateThread1.GetPassed;
 Result2 := MultiThreadValidateThread2.GetPassed;
 Result3 := MultiThreadValidateThread3.GetPassed;
 Result4 := MultiThreadValidateThread4.GetPassed;
 MultiThreadValidateThread1.Free;
 MultiThreadValidateThread2.Free;
 MultiThreadValidateThread3.Free;
 MultiThreadValidateThread4.Free;
 Result := Result1 and Result2 and Result3 and Result4;
end;

function TMMValidation.Validate28: boolean;
const
  ThreadCount = 6;
var
  LThreads: array[0..ThreadCount - 1] of TValidate28Thread;
  LInd: integer;
begin
  Result := True;
  {Create the threads}
  for LInd := 0 to ThreadCount - 1 do
  begin
    LThreads[LInd] := TValidate28Thread.Create(True);
    LThreads[LInd].FreeOnTerminate := False;
    LThreads[LInd].Priority := tpLowest;
  end;

  for LInd := 0 to ThreadCount - 1 do
  begin
    LThreads[LInd].Resume;
  end;

  {Wait for all threads to finish}
  for LInd := 0 to ThreadCount - 1 do
  begin
    LThreads[LInd].WaitFor;
  end;

  for LInd := 0 to ThreadCount - 1 do
  begin
    Result := Result and Boolean(LThreads[LInd].ReturnValue);
    LThreads[LInd].Free;
    LThreads[LInd] := nil;
  end;
end;

{ TValidate28Thread }

procedure TValidate28Thread.Execute;
const
  NumStrings = 256;
  TestCount = 5000;
  MaxLength = 256 * 1024;
var
  LStrings: array[0..NumStrings - 1] of String;
  i, LTestNo, LIndex, LOldSize, LNewSize: integer;
  LPCheck: PAnsiChar;
begin
  for i := Low(LStrings) to High(LStrings) do LStrings[i] := '';
  Inc(NextValue, Validate28Prime);
  {All ok so far}
  ReturnValue := ord(True);
  {Run the loop}
  for LTestNo := 1 to TestCount do
  begin
    {Reallocate a string}
    LIndex := NextValue mod NumStrings;
    Inc(NextValue, Validate28Prime);
    LOldSize := Length(LStrings[LIndex]);
    LNewSize := NextValue mod MaxLength;
    Inc(NextValue, Validate28Prime);
    SetLength(LStrings[LIndex], LNewSize);
    {Check that the contents was unchanged}
    LPCheck := Pointer(LStrings[LIndex]);
    for i := 1 to Min(LOldSize, LNewSize) do
    begin
      if LPCheck^ <> AnsiChar(LIndex) then
      begin
        ReturnValue := ord(False);
        exit;
      end;
      Inc(LPCheck);
    end;
    {Fill the newly allocated area}
    FillChar(PAnsiChar(NativeInt(LStrings[LIndex]) + LOldSize)^, LNewSize - LOldSize, Byte(LIndex));
  end;
end;

// stress test... pushing the MM to an "Out of Memory" by allocating 160 kB pointers
// see whether we get an EOutOfMemory (OK) or something else (WRONG)

function TMMValidation.Validate29: Boolean;
var
 Pointers : array[0..20000] of Pointer;
 n : integer;
const
  cMemSize = 163840;
begin
 n := 0;
 try
  repeat
   //Allocate 16 kB pointer
   GetMem(Pointers[n], cMemSize);
   PAnsiChar(Pointers[n])[4] := 'A';
   Inc(n);
  until n > High(Pointers);
  Result := True;  // no exception at all, and using more than 3 GB...interesting !
 except
  on E: EOutOfMemory do  // that's the right exception...
   Result := True
  else // all other exceptions are wrong...
   Result := False;
 end;
 //Release memory
 while n > 0 do
  begin
   Dec(n);
   FreeMem(Pointers[n], cMemSize);
  end;
end;

// stress test... pushing the MM to an "Out of Memory" by allocating 32 kB pointers
// see whether we get an EOutOfMemory (OK) or something else (WRONG)

function TMMValidation.Validate30: Boolean;
const
  ArraySize = 100000;
type
  TPointers = array[0..ArraySize] of Pointer;
  PPointers = ^TPointers;
  TSizes = array[0..ArraySize] of Integer;
  PSizes = ^TSizes;
var
 Pointers : PPointers;
 Sizes   : PSizes;
 n : integer;
const
  cAllocLow = 32*1024;
  cAllocHigh = 512*1024*1024;
begin
 n := 0;
 try
  GetMem(Pointers, SizeOf(TPointers));
  GetMem(Sizes, SizeOf(TSizes));
  GetMem(Pointers^[n], CAllocHigh);
  Sizes^[n] := CAllocHigh;
  PAnsiChar(Pointers^[n])[4] := 'A';
  Inc(n);
  repeat
   //Allocate 32 kB pointer
   GetMem(Pointers^[n], cAllocLow);
   Sizes^[n] := cAllocLow;
   PAnsiChar(Pointers^[n])[4] := 'A';
   Inc(n);
  until n > High(Pointers^);
  Result := True;  // no exception at all, and using more than 100000 * 32kB + 512 MB = 3.7 GB...interesting !
 except
  on E: EOutOfMemory do  // that's the right exception...
   Result := True
  else // all other exceptions are wrong...
   Result := False;
 end;
 //Release memory
 while n > 0 do
  begin
   Dec(n);
   FreeMem(Pointers^[n], Sizes^[n]);
  end;
  FreeMem(Pointers, SizeOf(TPointers));
  FreeMem(Sizes, SizeOf(TSizes));
end;

// stress test... pushing the MM to an "Out of Memory" by allocating 24 kB pointers
// see whether we get an EOutOfMemory (OK) or something else (WRONG)

function TMMValidation.Validate31: Boolean;
const
{$IFDEF WIN32}
  CBlockSizeSmall = 24*1024;
  CBlockSizeBig = 512*1024*1024;
  CNumPointers = 150000;
{$ELSE}
  CNumPointers = 15000000;
  CBlockSizeSmall = 24*1024;
  CBlockSizeBig = 512*1024*1024;
{$ENDIF}
type
 PPOinters = ^TPointers;
 TPointers = array[0..CNumPointers-1] of Pointer;
var
 Pointers: PPointers;
{$IFDEF WIN32}
 n : integer;
{$ELSE}
 n: Int64;
{$endif}

begin
 New(Pointers);
 try
   n := 0;
   try
    GetMem(Pointers^[n], CBlockSizeBig);
    PAnsiChar(Pointers^[n])[0] := 'A';
    PAnsiChar(Pointers^[n])[CBlockSizeBig-1] := 'B';
    Inc(n);
    repeat
     //Allocate 32 kB pointer
     GetMem(Pointers^[n], CBlockSizeSmall);
     PAnsiChar(Pointers^[n])[0] := 'A';
     PAnsiChar(Pointers^[n])[CBlockSizeSmall-1] := 'B';
     Inc(n);
    until n > High(Pointers^);
    Result := True;  // no exception at all, and using more than 150000 * 24kB + 512 MB = 4.1 GB...interesting !
   except
    on E: EOutOfMemory do  // that's the right exception...
     Result := True
    else // all other exceptions are wrong...
     Result := False;
   end;
   //Release memory
   while n > 0 do
    begin
     Dec(n);
     FreeMem(Pointers^[n]);
    end;
 finally
   Dispose(Pointers);
 end;
end;

//Allocates 1000 pointers up to BYTESTOALLOCATEMAX per pointer
//Validates 16 byte alignment

// This is in total 2GB

var
  CurAllocValidate32: Int64;


function TMMValidation.Validate32 : Boolean;
const
  CIterNormalRun = 1250;
  CIterQuickRun = 125;
{$IFDEF WIN64}
  CNumPointers = 1000;
{$ELSE}
  CNumPointers = 50;
{$ENDIF}
var
 I1, I2, I3, BytesToAllocate, RunNo : Cardinal;
 pMem : Pointer;
 PointerArray : packed array[1..CNumPointers] of Pointer;
 SizeArray : packed array[1..CNumPointers] of Cardinal;
 MemoryStatus : TMemoryStatus;
 RUNNOMAX: Cardinal;
 MaxAllocValidate32, Total: Int64;
const
{$IFDEF WIN64}
 BYTESTOALLOCATEMAX = 2*1024*1024;//2 Mbyte per pointer max
{$ELSE}
 BYTESTOALLOCATEMAX = 128*1024;//128K per pointer max
{$ENDIF}

begin
  Result := True;
  if ShortRun then RUNNOMAX := CIterQuickRun else RUNNOMAX := CIterNormalRun;

  {$IFDEF WIN64}
  MaxAllocValidate32 := 1*1024*1024*1024; {1GB}
  MaxAllocValidate32 := MaxAllocValidate32 * 2; {2 GB}
  {$ELSE}
  MaxAllocValidate32 := 32*1024*1024;//32 Mbytes total
  {$ENDIF}

 try
  //Initialize pointer array - not really needed
  for I1 := 1 to Length(PointerArray) do
  begin
    PointerArray[I1] := nil;
    SizeArray[I1] := 0;
  end;
  for RunNo := 1 to RUNNOMAX do
   begin
    //Allocate all pointers
    for I2 := Low(PointerArray) to High(PointerArray) do
    begin
      BytesToAllocate := MMGetValue(BYTESTOALLOCATEMAX-1)+4;//Always allocate >= 4 byte
      FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
      GlobalMemoryStatus(MemoryStatus);
      if MemoryStatus.dwAvailVirtual >= BytesToAllocate then
      begin
        Total := InterlockedAdd64(CurAllocValidate32, BytesToAllocate);
        if Total <= MaxAllocValidate32 then
        begin
          GetMem(pMem, BytesToAllocate);
          if NativeUInt(pMem) mod 8 <> 0 then
           begin
            //Pointer not 8 byte aligned
            Result := False;
            //Free all non nil pointers
            for I3 := 1 to Length(PointerArray) do
             begin
              pMem := PointerArray[I3];
              if pMem <> nil then
               begin
                FreeMem(pMem);
                PointerArray[I3] := nil;
               end;
             end;
            Exit;
           end;
          PointerArray[I2] := pMem;
          SizeArray[I2] := BytesToAllocate;
        end else
        begin
          InterlockedAdd64(CurAllocValidate32, -BytesToAllocate);
        end;
      end;
    end;
    //Free all pointers
    for I3 := 1 to Length(PointerArray) do
     begin
      pMem := PointerArray[I3];
      if pMem <> nil then
      begin
        BytesToAllocate := SizeArray[I3];
        InterlockedAdd64(CurAllocValidate32, -BytesToAllocate);
        FreeMem(pMem, BytesToAllocate);
        PointerArray[I3] := nil;
        SizeArray[I3] := 0;
      end;
     end;
   end;
 except
   on E: EOutOfMemory do
     Result := True;  // that's the right exception...
   else
     Result := False; // all other exceptions are wrong...
 end;
end;

// stress test... pushing the MM to an "Out of Memory" by allocating AllocSize pointers
// see whether we get an EOutOfMemory (OK) or something else (WRONG)

function TMMValidation.Validate33: Boolean;
const
{$ifdef WIN64}
  CNumPointers = 100000000;
{$ELSE}
  CNumPointers = 100000;
{$ENDIF}
type
 PPointers = ^TPointers;
 TPointers = array[0..CNumPointers-1] of Pointer;
var
 PrimeIndex, Divizor, n, AllocSize : integer;
 Pointers: PPointers;
begin

 New(Pointers);
 try
   PrimeIndex := Low(VeryGoodPrimes);
   n := 0;
   try
    AllocSize := VeryGoodPrimes[PrimeIndex];
    Inc(PrimeIndex);
    if PrimeIndex > High(VeryGoodPrimes) then PrimeIndex := Low(VeryGoodPrimes);


    repeat
     GetMem(Pointers^[n], AllocSize);
     PAnsiChar(Pointers^[n])[0] := 'A';
     if AllocSize > 2 then
     begin
       PAnsiChar(Pointers^[n])[AllocSize-1] := 'B';
     end;
     Inc(n);

     // multiply AllocSize by ~1.111
     AllocSize := MulDiv(AllocSize, 124513 {prime}, 112067 {prime});

     if AllocSize > (MaxInt div 3) then
     begin
       Divizor := VeryGoodPrimes[PrimeIndex];
       Inc(PrimeIndex);
       if PrimeIndex > High(VeryGoodPrimes) then PrimeIndex := Low(VeryGoodPrimes);
       AllocSize := AllocSize div Divizor;
     end;
    until n > High(Pointers^);
    Result := True;  // no exception at all, and using more than XXX MB
   except
    on E: Exception do  // that's the right exception...
     Result := (E is EOutOfMemory) or (E.ClassName = 'EOutOfMemory');
   end;
   //Release memory
   while n > 0 do
    begin
     Dec(n);
     FreeMem(Pointers^[n]);
    end;
 finally
   Dispose(Pointers);
 end;
end;

function TMMValidation.Validate34 : Boolean;
var
 pMem1, pMem2, pMem3 : Pointer;
 MemoryStatus : TMemoryStatus;
 BytesToAllocate : Cardinal;
const
 BYTESTOALLOCATEMIN = 1;//1 byte
 BYTESTOALLOCATEMAX = 2 * 1024 * 1024;//2 Mbyte

begin
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  for BytesToAllocate := BYTESTOALLOCATEMIN to BYTESTOALLOCATEMAX do
   begin
    if MemoryStatus.dwAvailVirtual >= BytesToAllocate then
     begin
      //Allocate
      pMem1 := GetMemory(BytesToAllocate);
      //Realloc to same size
      PMem2 := ReallocMemory(pMem1, BytesToAllocate);
      if pMem1 <> pMem2 then
       begin
        PMem3 := ReallocMemory(pMem2, BytesToAllocate);
        FreeMemory(pMem3);
        Result := False;
        Exit;
       end;
      FreeMemory(pMem2);
     end;
   end;
 except
  Result := False;
 end;
end;

function TMMValidation.Validate35 : Boolean;
var
 pMem1, pMem2, pMem3 : Pointer;
 MemoryStatus : TMemoryStatus;
 BytesToAllocate : Cardinal;
const
 BYTESTOALLOCATEMIN : Cardinal = 1;//1 byte
 BYTESTOALLOCATEMAX : Cardinal = 2 * 1024 * 1024;//2 Mbyte

begin
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  for BytesToAllocate := BYTESTOALLOCATEMAX downto BYTESTOALLOCATEMIN do
   begin
    if MemoryStatus.dwAvailVirtual >= BytesToAllocate then
     begin
      //Allocate
      pMem1 := GetMemory(BytesToAllocate);
      //Realloc to same size
      PMem2 := ReallocMemory(pMem1, BytesToAllocate);
      if pMem1 <> pMem2 then
       begin
        PMem3 := ReallocMemory(pMem2, BytesToAllocate);
        FreeMemory(pMem2);
        Result := False;
        Exit;
       end;
      FreeMemory(pMem2);
     end;
   end;
 except
  Result := False;
 end;
end;

function TMMValidation.Validate36 : Boolean;
var
 pMem1, pMem2, pMem3, pMem4 : Pointer;
 MemoryStatus : TMemoryStatus;
 BytesToAllocate, BytesToAllocateFirst : Cardinal;
const
 BYTESTOALLOCATEMIN : Cardinal = 211; {prime}
 BYTESTOALLOCATEMAX : Cardinal = 123457 {prime};

begin
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  for BytesToAllocate := BYTESTOALLOCATEMAX downto BYTESTOALLOCATEMIN do
   begin
    if MemoryStatus.dwAvailVirtual >= BytesToAllocate then
     begin
      //Allocate a block of size that is unlikely the same as before
      BytesToAllocateFirst := MMGetValue(BYTESTOALLOCATEMAX-1)+1;
      pMem1 := GetMemory(BytesToAllocateFirst);
      //Realloc
      PMem2 := ReallocMemory(pMem1, BytesToAllocate);
      //Realloc to same size again
      PMem3 := ReallocMemory(pMem2, BytesToAllocate);
      if pMem2 <> pMem3 then
       begin
        PMem4 := ReallocMemory(pMem3, BytesToAllocate);
        FreeMemory(pMem3);
        Result := False;
        Exit;
       end;
      FreeMemory(pMem3);
     end;
   end;
 except
  Result := False;
 end;
end;

function TMMValidation.Validate37 : Boolean;
var
 pMem1, pMem2, pMem3 : Pointer;
 MemoryStatus : TMemoryStatus;
 BytesToAllocate : Cardinal;
const
 BYTESTOALLOCATEMIN : Cardinal = 1;//1 byte
 BYTESTOALLOCATEMAX : Cardinal = 2 * 1024 * 1024;//2 Mbyte

begin
 FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
 GlobalMemoryStatus(MemoryStatus);
 try
  Result := True;
  for BytesToAllocate := BYTESTOALLOCATEMIN to BYTESTOALLOCATEMAX do
   begin
    if MemoryStatus.dwAvailVirtual >= BytesToAllocate then
     begin
      //Allocate
      GetMem(pMem1, BytesToAllocate);
      //Realloc to same size
      PMem2 := pMem1;
      ReallocMem(pMem2, BytesToAllocate);
      if pMem1 <> pMem2 then
       begin
        ReallocMem(pMem2, BytesToAllocate);
        FreeMemory(pMem2);
        Result := False;
        Exit;
       end;
      //Realloc to same size again
      PMem3 := pMem2;
      ReallocMem(pMem3, BytesToAllocate);
      if pMem2 <> pMem3 then
       begin
        ReallocMem(pMem3, BytesToAllocate);
        FreeMem(pMem3);
        Result := False;
        Exit;
       end;
      FreeMem(pMem3);
     end;
   end;
 except
  Result := False;
 end;
end;

function TMMValidation.Validate38 : Boolean;
var
 i, j, maxmem : Integer;
 ptr, oldptr : Pointer;

begin
 maxmem := 5*1024;
 Result := True;
 for i := 1 to maxmem do
 begin
   for j := 1 to maxmem do
   begin
     getmem(ptr, i);
     try
       reallocmem(ptr, j);
       oldptr := ptr;
       reallocmem(ptr, j);
       if oldptr <> ptr then
       begin
         reallocmem(ptr, j);
         Result := False;
         exit;
       end;
     finally
       freemem(ptr);
     end;
   end;
 end;
end;

type
  TMMValidationThread = class(TThread)
    DoneFlagForMainThread, PreparedFlagForMainThread: LONG;
    Result: Boolean;
    ValidationSuites: array of TValidateFunction;
    FPrepareEventHandle,
    FExitEventHandle,
    FStartEventHandle: THandle;
    procedure Execute; override;
    procedure AddSuite(V: TValidateFunction);
  end;

procedure TMMValidationThread.Execute;
var
  i: Integer;
  f: TValidateFunction;
begin
  try
    InterlockedExchange(PreparedFlagForMainThread, 1);
    SetEvent(FPrepareEventHandle);

    if WaitForSingleObject(FStartEventHandle, INFINITE) <> WAIT_OBJECT_0 then
    begin
      Result := False
    end else
    begin
      Result := True;
      for I := Low(ValidationSuites) to High(ValidationSuites) do
      begin
        f := ValidationSuites[I];
        if not f() then
        begin
          Result := False;
          Break;
        end;
      end;
    end;
  finally
    InterlockedExchange(DoneFlagForMainThread, 1);
    SetEvent(FExitEventHandle);
  end;
end;

procedure TMMValidationThread.AddSuite(V: TValidateFunction);
begin
  SetLength(ValidationSuites, Length(ValidationSuites)+1);
  ValidationSuites[High(ValidationSuites)] := V;
end;


// Same goal as for Validate34 - find cases where on same size returns different pointer
// but does not check for memory status - doesn't call GlobalMemoryStatus.

// It also checks how fast it can allocate and deallocate memory of essentially the same size

function TMMValidation.Validate43 : Boolean;
var
 pMem1Normal, pMem2Normal: Pointer;
 pMem1Medium, pMem2Medium : Pointer;
 pMem1Big,    pMem2Big: Pointer;
 pMem1Huge,   pMem2Huge : Pointer;
 BytesToAllocate : Cardinal;
const
 BYTESTOALLOCATEMIN = 1;//1 byte
 BYTESTOALLOCATEMAX = 150*1024;//150K

 ADDNORMAL = 0;
 ADDMEDIUM = 8*1024; // 8K
 ADDBIG    = 128*1024; // 128K
 ADDHUGE   = 64*1024*1024; // 64M

begin
 try
  Result := True;
  for BytesToAllocate := BYTESTOALLOCATEMIN to BYTESTOALLOCATEMAX do
  begin
    pMem1Normal := nil;
    pMem1Medium := nil;
    pMem1Big := nil;
    pMem1Huge := nil;
    //Allocate
    ReallocMem(pMem1Normal, BytesToAllocate+ADDNORMAL);
    ReallocMem(pMem1Medium, BytesToAllocate+ADDMEDIUM);
    ReallocMem(pMem1Big,    BytesToAllocate+ADDBIG);
    ReallocMem(pMem1Huge,   BytesToAllocate+ADDHUGE);
    //Realloc to same size
    pMem2Normal := pMem1Normal;
    pMem2Medium := pMem1Medium;
    pMem2Big    := pMem1Big   ;
    pMem2Huge   := pMem1Huge  ;
    ReallocMem(pMem2Normal, BytesToAllocate+ADDNORMAL);
    ReallocMem(pMem2Medium, BytesToAllocate+ADDMEDIUM);
    ReallocMem(pMem2Big,    BytesToAllocate+ADDBIG);
    ReallocMem(pMem2Huge,   BytesToAllocate+ADDHUGE);
    if pMem1Normal <> pMem2Normal then
    begin
      Result := False;
    end;
    if pMem1Medium <> pMem2Medium then
    begin
      Result := False;
    end;
    if pMem1Big <> pMem2Big then
    begin
      Result := False;
    end;
    if pMem1Huge <> pMem2Huge then
    begin
      Result := False;
    end;
    pMem1Normal := nil;
    ReallocMem(pMem2Normal, 0);
    pMem1Medium := nil;
    ReallocMem(pMem2Medium, 0);
    pMem1Big := nil;
    ReallocMem(pMem2Big, 0);
    pMem1Huge := nil;
    ReallocMem(pMem2Huge, 0);
    if not Result then Break;
  end;
 except
  Result := False;
 end;
end;


function TMMValidation.Validate44 : Boolean;
const
 cNumBlocks = 5000;
 cLimitPerPool = 8*1024*1024; // 8M per pool, 4 pools in total

 ADDNORMAL = 1;
 ADDMEDIUM = 8*1024; // 8K
 ADDBIG    = 128*1024; // 128K
 ADDHUGE   = 4*1024*1024; // 4M
type
  TMemInfo = packed record Ptr: Pointer; Size: Cardinal end;
var
  pMem1Normal, pMem2Normal,
  pMem1Medium, pMem2Medium,
  pMem1Big,    pMem2Big,
  pMem1Huge,   pMem2Huge : Pointer;
  BytesToAllocate : Cardinal;
  Normal, Medium, Big, Huge: packed array[0..cNumBlocks-1] of TMemInfo;
  NormalStored, MediumStored, BigStored, HugeStored: Integer;
  i: Integer;
  TotalNormal, TotalMedium, TotalBig, TotalHuge: Integer;

begin
 try
  Result := True;

  NormalStored := 0;
  MediumStored := 0;
  BigStored := 0;
  HugeStored := 0;

  TotalNormal := 0;
  TotalMedium := 0;
  TotalBig := 0;
  TotalHuge := 0;

  for i := 0 to cNumBlocks-1 do
  begin
    with Normal[i] do begin Ptr := nil; Size := 0 end;
    with Medium[i] do begin Ptr := nil; Size := 0 end;
    with Big[i] do begin Ptr := nil; Size := 0 end;
    with Huge[i] do begin Ptr := nil; Size := 0 end;
  end;

  for i := 0 to cNumBlocks-1 do
  begin
    BytesToAllocate := i;
    pMem1Normal := nil;
    pMem1Medium := nil;
    pMem1Big := nil;
    pMem1Huge := nil;
    //Allocate
    ReallocMem(pMem1Normal, BytesToAllocate+ADDNORMAL);
    ReallocMem(pMem1Medium, BytesToAllocate+ADDMEDIUM);
    ReallocMem(pMem1Big,    BytesToAllocate+ADDBIG);
    ReallocMem(pMem1Huge,   BytesToAllocate+ADDHUGE);
    //Realloc to same size
    pMem2Normal := pMem1Normal;
    pMem2Medium := pMem1Medium;
    pMem2Big    := pMem1Big   ;
    pMem2Huge   := pMem1Huge  ;
    ReallocMem(pMem2Normal, BytesToAllocate+ADDNORMAL);
    ReallocMem(pMem2Medium, BytesToAllocate+ADDMEDIUM);
    ReallocMem(pMem2Big,    BytesToAllocate+ADDBIG);
    ReallocMem(pMem2Huge,   BytesToAllocate+ADDHUGE);
    if pMem1Normal <> pMem2Normal then
    begin
      Result := False;
    end;
    if pMem1Medium <> pMem2Medium then
    begin
      Result := False;
    end;
    if pMem1Big <> pMem2Big then
    begin
      Result := False;
    end;
    if pMem1Huge <> pMem2Huge then
    begin
      Result := False;
    end;
    pMem1Normal := nil;
    pMem1Medium := nil;
    pMem1Big := nil;
    pMem1Huge := nil;

    if TotalNormal < cLimitPerPool then
    begin
      Inc(TotalNormal, BytesToAllocate+ADDNORMAL);
      with Normal[NormalStored] do begin Ptr := pMem2Normal; Size := BytesToAllocate+ADDNORMAL end;
      Inc(NormalStored);
      pMem2Normal := nil;
    end;

    if TotalMedium < cLimitPerPool then
    begin
      Inc(TotalMedium, BytesToAllocate+ADDMedium);
      with Medium[MediumStored] do begin Ptr := pMem2Medium; Size := BytesToAllocate+ADDMedium end;
      Inc(MediumStored);
      pMem2Medium := nil;
    end;


    if TotalBig < cLimitPerPool then
    begin
      Inc(TotalBig, BytesToAllocate+ADDBig);
      with Big[BigStored] do begin Ptr := pMem2Big; Size := BytesToAllocate+ADDBig end;
      Inc(BigStored);
      pMem2Big := nil;
    end;


    if TotalHuge < cLimitPerPool then
    begin
      Inc(TotalHuge, BytesToAllocate+ADDHuge);
      with Huge[HugeStored] do begin Ptr := pMem2Huge; Size := BytesToAllocate+ADDHuge end;
      Inc(HugeStored);
      pMem2Huge := nil;
    end;

    ReallocMem(pMem2Normal, 0);
    ReallocMem(pMem2Medium, 0);
    ReallocMem(pMem2Big, 0);
    ReallocMem(pMem2Huge, 0);

    if not Result then Break;

   end;


  if Result then
  begin
    // try to reallocate existing blocks

    for i := 0 to NormalStored-1 do
    begin
      with Normal[i] do
      begin
        pMem1Normal := Ptr;
        pMem2Normal := Ptr;
        ReallocMem(pMem2Normal, Size);
        if pMem1Normal <> pMem2Normal then
        begin
          Result := False;
        end;
        ReallocMem(pMem2Normal, 0);
        Ptr := nil;
        Size := 0;
      end;
    end;

    for i := 0 to MediumStored-1 do
    begin
      with Medium[i] do
      begin
        pMem1Medium := Ptr;
        pMem2Medium := Ptr;
        ReallocMem(pMem2Medium, Size);
        if pMem1Medium <> pMem2Medium then
        begin
          Result := False;
        end;
        ReallocMem(pMem2Medium, 0);
        Ptr := nil;
        Size := 0;
      end;
    end;

    for i := 0 to BigStored-1 do
    begin
      with Big[i] do
      begin
        pMem1Big := Ptr;
        pMem2Big := Ptr;
        ReallocMem(pMem2Big, Size);
        if pMem1Big <> pMem2Big then
        begin
          Result := False;
        end;
        ReallocMem(pMem2Big, 0);
        Ptr := nil;
        Size := 0;
      end;
    end;

    for i := 0 to HugeStored-1 do
    begin
      with Huge[i] do
      begin
        pMem1Huge := Ptr;
        pMem2Huge := Ptr;
        ReallocMem(pMem2Huge, Size);
        if pMem1Huge <> pMem2Huge then
        begin
          Result := False;
        end;
        ReallocMem(pMem2Huge, 0);
        Ptr := nil;
        Size := 0;
      end;
    end;
  end;



 except
  Result := False;
 end;
end;

{$IFNDEF WIN64}
function TMMValidation.Validate50: Boolean;
type
  TPointerArray = array[0..1024*1024-1] of PPointerArray;
  PPointerArray = ^TPointerArray;
const
  BlockSize = 1069;
var
  i, j, jm, r, c: Integer;
  ba: PByteArray;
  pa: PPointerArray;
begin
  Result := False;
  pa := nil;
  r := 0;
  c := 0;
  try
    GetMem(pa, SizeOf(TPointerArray));
    r := Low(TPointerArray);
    while r <= High(TPointerArray) do
    begin
      GetMem(pa^[r], SizeOf(TPointerArray));
      c := Low(TPointerArray);
      while c <= High(TPointerArray) do
      begin
        GetMem(ba, BlockSize);
        pa^[r]^[c] := ba;
        i := 0;
        while i < BlockSize do
        begin
          ba^[i] := not ba^[i];
          Inc(i, 61);
        end;
        Inc(c);
      end;
      Inc(r);
    end;
  except
    Result := True;
  end;
  try
    for i := 0 to r do
    begin
      if i = r then
      begin
        jm := c;
      end else
      begin
        jm := High(TPointerArray)
      end;
      for j := 0 to jm do
      begin
        ba := pa^[i]^[j];
        FreeMem(ba, BlockSize);
      end;
      FreeMem(pa^[i], SizeOf(TPointerArray));
    end;
    FreeMem(pa, SizeOf(TPointerArray));
  except
    Result := False;
  end;
end;
{$ENDIF}


const
  ValidationSuitesPerThread = 6;
{$IFDEF DEBUG}
  ThreadCount = 16;
{$ELSE}
  ThreadCount = 32;
{$ENDIF}

{multi-threaded test}
function TMMValidation.Validate49: Boolean;
var
  ValidationSuites: array of TValidateFunction;
  ValidationSuiteFreq: array of Integer;

  procedure AddSuite(V: TValidateFunction);
  begin
    SetLength(ValidationSuites, Length(ValidationSuites)+1);
    ValidationSuites[High(ValidationSuites)] := V;
  end;

var
  PrimeIdx: Integer;
  PrepareEvent, ExitEvent, StartEvent: THandle;
  ThreadList: TList;

  procedure AddThread(T: TMMValidationThread);
  var
    Prime, vl: Cardinal;
    SuiteIdx, i: Integer;
    VF: TValidateFunction;
  begin
    vl := Length(ValidationSuites);


    while Length(T.ValidationSuites) < ValidationSuitesPerThread do
    begin
      Prime := VeryGoodPrimes[PrimeIdx];
      Inc(PrimeIdx);

      if PrimeIdx > High(VeryGoodPrimes) then
      begin
        PrimeIdx := Low(VeryGoodPrimes);
      end;

      SuiteIdx := Prime mod vl;
      VF := ValidationSuites[SuiteIdx];
      if not Assigned(VF) then Continue;

      Inc(ValidationSuiteFreq[SuiteIdx]);

      T.AddSuite(VF);

    end;

    T.FPrepareEventHandle := PrepareEvent;
    T.FExitEventHandle := ExitEvent;
    T.FStartEventHandle := StartEvent;
    T.Priority := tpLowest;
    ThreadList.Add(T);

  end;

var
  T: TMMValidationThread;
  ValSuitesLen, Prime, wr: Cardinal;
  I, ThreadsPrepared: Integer;
  D: LONG;

begin
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_BELOW_NORMAL);
  Result := True;
  AddSuite(nil);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate1);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate2);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate3);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate4);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate5);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate6);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate7);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate8);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate9);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate10);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate11);
  {$IFDEF FORCE_THREADED_SLOW_TESTS}
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate12);
  {$ENDIF}
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate14);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate17);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate18);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate19);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate20);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate21);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate22);
  {$IFDEF FORCE_THREADED_SLOW_TESTS}
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate26);
  {$ENDIF}

  {$IFDEF FORCE_THREADED_HUGE_MEMORY_TESTS}
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate32);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate34);
  {$ENDIF}

  {$IFDEF FORCE_THREADED_SLOW_TESTS}
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate35);
  {$ENDIF}
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate36);
  {$IFDEF FORCE_THREADED_HUGE_MEMORY_TESTS}
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate37);
  {$ENDIF}
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate38);
  {$IFDEF FORCE_THREADED_HUGE_MEMORY_TESTS}
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate39);
  {$ENDIF}
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate40);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate43);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate44);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate45);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate46);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate47);
  AddSuite({$IFDEF FPC}@{$ENDIF}Validate48);
  i := Low(VeryGoodPrimes);
  ValSuitesLen := Length(ValidationSuites);
  repeat
    Prime := VeryGoodPrimes[i];
    Inc(i);
    if Prime < ValSuitesLen then Continue;
    Break;
  until False;
  while ValSuitesLen < Prime do
  begin
    AddSuite(nil);
    ValSuitesLen := Length(ValidationSuites);
  end;

   SetLength(ValidationSuiteFreq, Length(ValidationSuites));

   PrimeIdx := Low(VeryGoodPrimes);


   ThreadList := TList.Create;
   StartEvent := CreateEvent(nil, True, False, nil);
   ExitEvent := CreateEvent(nil, False, False, nil);
   PrepareEvent := CreateEvent(nil, False, False, nil);

   for I := 0 to ThreadCount-1 do
   begin
     AddThread(TMMValidationThread.Create(True));
   end;

   for I := 0 to ThreadList.Count-1 do
   begin
     T := TMMValidationThread(ThreadList[i]);
     T.Start;
   end;

   ThreadsPrepared := 0;

   while ThreadsPrepared < ThreadCount do
   begin
     wr := WaitForSingleObject(PrepareEvent, INFINITE);
     if wr = WAIT_OBJECT_0 then
     begin
       for I := ThreadList.Count-1 downto 0 do
       begin
         T := TMMValidationThread(ThreadList[i]);
         D := InterlockedExchange(T.PreparedFlagForMainThread, 0);
         if D <> 0 then
         begin
           Inc(ThreadsPrepared);
         end;
       end;
     end else
     begin
       raise Exception.Create('TMMValidation MultiThreaded Test -- failed on preparation');
     end;
   end;

//   ShowMessage('Ready');

   SetEvent(StartEvent); // Poehali!

   repeat
     wr := WaitForSingleObject(ExitEvent, INFINITE);
     if wr = WAIT_OBJECT_0 then
     begin
       for I := ThreadList.Count-1 downto 0 do
       begin
         T := TMMValidationThread(ThreadList[i]);
         D := InterlockedExchange(T.DoneFlagForMainThread, 0);
         if D <> 0 then
         begin
           T.WaitFor;
           if not T.Result then
           begin
             Result := False;
           end;
           T.Free;
           ThreadList[i] := nil;
         end;
       end;
       ThreadList.Pack;
     end else
     begin
       raise Exception.Create('TMMValidation MultiThreaded Test -- failed on execute');
     end;
   until ThreadList.Count = 0;
   ThreadList.Free;
   ThreadList := nil;

   CloseHandle(StartEvent);
   CloseHandle(ExitEvent);
   CloseHandle(PrepareEvent);
   SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_NORMAL);
end;

{based on Validate42, but larger size: Allocate 4 blocks of 1GB}
function TMMValidation.Validate42 : Boolean;
const
 Iterations = 4;
 BYTESTOALLOCATE = (MaxInt div 2)-1;
var
 arrays: packed array[0..Iterations-1] of packed array of Byte;
 MemoryStatus : TMemoryStatus;
 i: Integer;
begin
 try
  Result := True;
  for I := Low(arrays) to High(arrays) do
  begin
    FillChar(MemoryStatus, SizeOf(MemoryStatus), 0);
    GlobalMemoryStatus(MemoryStatus);
    if MemoryStatus.dwAvailVirtual >= BYTESTOALLOCATE then
    begin
      SetLength(arrays[i], BYTESTOALLOCATE);
    end;
  end;
 except
  Result := False;
 end;
end;

{$IFDEF FPC}
initialization
InitializeCriticalSection(InterlockedAdd64CS);
finalization
DeleteCriticalSection(InterlockedAdd64CS);
{$ENDIF}
end.

