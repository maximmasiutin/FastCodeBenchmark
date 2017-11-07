unit IntToStrLBGUnit;

interface

{$INCLUDE Defines.inc}

uses
  FastcodeChallengeUnit,
  FastcodeChallengeIntToStr32Unit,
  FastcodeChallengeIntToStr64Unit;

implementation

uses
  Windows,SysUtils ;

function IntToStr_JOH_LBG_IA32_1_a(Value: Integer): string;
function divU100(Value:Cardinal):Cardinal;

ASM
  MOV EDX, 051eb851fh // 0.1 * 2^32 * 8 rounded up
  MUL EDX
  SHR EDX, 5          // divide by 2^32 * 8
  MOV EAX, EDX

end;
const
  TwoDigitLookup : packed array[0..99] of array[1..2] of Char =
    ('00','01','02','03','04','05','06','07','08','09',
     '10','11','12','13','14','15','16','17','18','19',
     '20','21','22','23','24','25','26','27','28','29',
     '30','31','32','33','34','35','36','37','38','39',
     '40','41','42','43','44','45','46','47','48','49',
     '50','51','52','53','54','55','56','57','58','59',
     '60','61','62','63','64','65','66','67','68','69',
     '70','71','72','73','74','75','76','77','78','79',
     '80','81','82','83','84','85','86','87','88','89',
     '90','91','92','93','94','95','96','97','98','99');


type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
var
  Negative : Boolean;
  I, J, K  : Cardinal;
  Digits   : Byte;
  P        : PByte;
  NewLen, OldLen : Integer;
begin
  Negative := Value < 0;
  I := Abs(Value);
  if I >= 10000 then
    if I >= 1000000 then
      if I >= 100000000 then
        Digits := 9 + Ord(I >= 1000000000)
      else
        Digits := 7 + Ord(I >= 10000000)
    else
      Digits := 5 + Ord(I >= 100000)
  else
    if I >= 100 then
      Digits := 3 + Ord(I >= 1000)
    else
      Digits := 1 + Ord(I >= 10);
  NewLen  := Digits + Ord(Negative);
  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if NewLen <> OldLen then
    SetLength(Result, NewLen);
  P := Pointer(Result);
  P^ := Byte('-');
  Inc(P, Ord(Negative));
  if Digits > 2 then
    repeat
      j := divU100(I);           {Dividend div 100}
      K  :=I-( J * 100);         {Dividend - (Dividend div 100 * 100)}
      I  := J;                   {Next Dividend}
      Dec(Digits, 2);
      PWord(@PByteArray(P)[Digits])^ := Word(TwoDigitLookup[K]);
    until Digits <= 2;
  if Digits = 2 then
    PWord(@PByteArray(P)[Digits-2])^ := Word(TwoDigitLookup[I])
  else
    P^ := I or ord('0');
end;

//Author:            Lars Bloch Gravengaard
//Date:              12/6 2005
//Instructionset(s): Pas
function IntToStr_LBG_PAS_1_a(Value: Integer): string;
const
   Digits : array[-9..9] of Char = '9876543210123456789';

var
    StringLength : Integer;
    pointer          : pByte;

begin
   case Abs(Value) of
     0..9                  : StringLength := 1;
     10..99                : StringLength := 2;
     100..999              : StringLength := 3;
     1000..9999            : StringLength := 4;
     10000..99999          : StringLength := 5;
     100000..999999        : StringLength := 6;
     1000000..9999999      : StringLength := 7;
     10000000..99999999    : StringLength := 8;
     100000000..999999999  : StringLength := 9;
   else
     StringLength := 10;
   end;

   if Value < 0 then
     Inc(StringLength);

   SetLength(Result, StringLength);
   pointer := @Result[StringLength];

   pByte(Result)^ := Ord('-');

   repeat
     pointer^:= Ord(Digits[Value-((Value div 10) * 10)]);
     Dec(pointer);
     Value := Value div 10;
   until Value = 0;

end;

//Author:            Lars Bloch Gravengaard
//Date:              17/9 2005
//Instructionset(s): Pas

function IntToStr_LBG_PAS_2_a(Value: Integer): string;
const
  Digit : array[-9..9] of Char = '9876543210123456789';
label
  D1,D2,D3,D4,D5,D6,D7,D8,D9;
var
  StringLength,StringLengthTemp,tmp : Integer;
  pointer          : pByte;

begin
  case Abs(Value) of
    0..9                  : StringLength := 1;
    10..99                : StringLength := 2;
    100..999              : StringLength := 3;
    1000..9999            : StringLength := 4;
    10000..99999          : StringLength := 5;
    100000..999999        : StringLength := 6;
    1000000..9999999      : StringLength := 7;
    10000000..99999999    : StringLength := 8;
    100000000..999999999  : StringLength := 9;
  else
    StringLength := 10;
  end;

   StringLengthTemp := StringLength + ORD(Value < 0);

   SetLength(Result, StringLengthTemp);
   pointer := @Result[StringLengthTemp];

   pByte(Result)^ := Ord('-');

       if  StringLength = 1 then goto D1
  else if  StringLength = 2 then goto D2
  else if  StringLength = 3 then goto D3
  else if  StringLength = 4 then goto D4
  else if  StringLength = 5 then goto D5
  else if  StringLength = 6 then goto D6
  else if  StringLength = 7 then goto D7
  else if  StringLength = 8 then goto D8
  else if  StringLength = 9 then goto D9;

    tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-(tmp * 10)]);
    Value := tmp;
    Dec(pointer);

D9: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Value := tmp;
    Dec(pointer);
D8: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D7: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D6: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D5: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D4: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D3: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D2: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D1: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
end;


//Author:            Lars Bloch Gravengaard
//Date:              17/9 2005
//Instructionset(s): IA32,PAS
function IntToStr_LBG_IA32_1_a(Value: Integer): string;

const
  Digits : array[0..9] of Char = '0123456789';

label
  D1,D2,D3,D4,D5,D6,D7,D8,D9;

var
    StringLength,StringLength_,tmp : Integer;
    pointer          : pByte;


//function divU10(Value:Integer):Integer;
function divU10(Value:Cardinal):Cardinal;

ASM
  MOV EDX, 0CCCCCCCDh // 0.1 * 2^32 * 8 rounded up
  MUL EDX
  SHR EDX, 3          // divide by 2^32 * 8
  MOV EAX, EDX

end;

begin
  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  case Abs(Value) of
    0..9                  : StringLength := 1;
    10..99                : StringLength := 2;
    100..999              : StringLength := 3;
    1000..9999            : StringLength := 4;
    10000..99999          : StringLength := 5;
    100000..999999        : StringLength := 6;
    1000000..9999999      : StringLength := 7;
    10000000..99999999    : StringLength := 8;
    100000000..999999999  : StringLength := 9;
  else
    StringLength := 10;
  end;

  StringLength_ := StringLength;
  Inc(StringLength,ORD(Value < 0));
  Value:= Abs(Value);

  SetLength(Result, StringLength);
  pointer := @Result[StringLength];

  pByte(Result)^ := Ord('-');
       if  StringLength_ = 1 then goto D1
  else if  StringLength_ = 2 then goto D2
  else if  StringLength_ = 3 then goto D3
  else if  StringLength_ = 4 then goto D4
  else if  StringLength_ = 5 then goto D5
  else if  StringLength_ = 6 then goto D6
  else if  StringLength_ = 7 then goto D7
  else if  StringLength_ = 8 then goto D8
  else if  StringLength_ = 9 then goto D9;

  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Value := tmp;
  Dec(pointer);

D9:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Value := tmp;
  Dec(pointer);
D8:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D7:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D6:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D5:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D4:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D3:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D2:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D1:
  tmp := divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
end;

//Author:            Lars Bloch Gravengaard
//Date:              17/9 2005
//Instructionset(s): Pas

function IntToStr64_LBG_PAS_1_a(Value: int64): string;
const
  Digit : array[-9..9] of Char = '9876543210123456789';
label
  D1,D2,D3,D4,D5,D6,D7,D8,D9;
var
  StringLength,StringLengthTemp,OldLen:integer;
 tmp,Value_ : int64;
  pointer          : pByte;

begin
  if Value = $8000000000000000 then
    begin {Special Case since ABS($8000000000000000) Fails}
      Result := '-9223372036854775808';
      Exit;
    end;

  if (Value >= -MaxInt-1) and (Value <= MaxInt) then
    begin {Within Integer Range - Use Faster Integer Version}
      Result := IntToStr_LBG_IA32_1_a(Value);
      Exit;
    end;

  Value_ := Abs(Value);

  if Value_ >= 100000000000000 then
    if Value_ >= 10000000000000000 then
      if Value_ >= 1000000000000000000 then
        StringLength := 19
      else
        StringLength := 17 + Ord(Value_ >= 100000000000000000)
    else
      StringLength := 15 + Ord(Value_ >= 1000000000000000)
  else
    if Value_ >= 1000000000000 then
      StringLength := 13 + Ord(Value_ >= 10000000000000)
    else
      if Value_ >= 10000000000 then
        StringLength := 11 + Ord(Value_ >= 100000000000)
      else
        StringLength := 10;

  StringLengthTemp := StringLength + ORD(Value < 0);

  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if StringLengthTemp <> OldLen then
    SetLength(Result, StringLengthTemp);

   pointer := @Result[StringLengthTemp];
   pByte(Result)^ := Ord('-');

   repeat
     tmp := Value div 10;
     pointer^:= Ord(Digit[Value-((tmp) * 10)]);
     Dec(pointer);
     Value := tmp;
   until Value = 0;
end;
function Int64Div_JOH_PAS_a(var X, Y : Int64) : Int64;
type
  iRec = packed record
    Lo, Hi : LongWord;
  end;
var
  I, J : LongWord;
begin
  I := iRec(X).Hi and $80000000; {if X >= 0 then I := 0}
  J := iRec(Y).Hi and $80000000; {if Y >= 0 then J := 0}
  if I xor J = 0 then
    begin {Same Sign}
      if I = 0 then
        begin {Both Positive}
          if X >= Y then
            Result := X div Y
          else
            Result := 0
        end
      else
        begin {Both Negative}
          if X <= Y then
            Result := X div Y
          else
            Result := 0
        end;
    end
  else
    begin {Different Sign}
      if I = 0 then
        begin {X = +ve, Y = -ve}
          if X >= -Y then
            Result := X div Y
          else
            Result := 0
        end
      else
        begin {X = -ve, Y = +ve}
          if X <= -Y then
            Result := X div Y
          else
            Result := 0
        end;
    end;
end;

function IntToStr64_LBG_IA32_1_a(Value: int64): string;
const
  Digit : array[-9..9] of Char = '9876543210123456789';

var
  StringLength,StringLengthTemp,OldLen:integer;
 tmp,Value_,Ti : int64;
  pointer          : pByte;
begin
  if Value = $8000000000000000 then
    begin {Special Case since ABS($8000000000000000) Fails}
      Result := '-9223372036854775808';
      Exit;
    end;

  if (Value >= -MaxInt-1) and (Value <= MaxInt) then
    begin {Within Integer Range - Use Faster Integer Version}
      Result := IntToStr_LBG_IA32_1_a(Value);
      Exit;
    end;

  Value_ := Abs(Value);

  if Value_ >= 100000000000000 then
    if Value_ >= 10000000000000000 then
      if Value_ >= 1000000000000000000 then
        StringLength := 19
      else
        StringLength := 17 + Ord(Value_ >= 100000000000000000)
    else
      StringLength := 15 + Ord(Value_ >= 1000000000000000)
  else
    if Value_ >= 1000000000000 then
      StringLength := 13 + Ord(Value_ >= 10000000000000)
    else
      if Value_ >= 10000000000 then
        StringLength := 11 + Ord(Value_ >= 100000000000)
      else
        StringLength := 10;

  StringLengthTemp := StringLength + ORD(Value < 0);

  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if StringLengthTemp <> OldLen then
    SetLength(Result, StringLengthTemp);

   pointer := @Result[StringLengthTemp];
   pByte(Result)^ := Ord('-');
ti:=10 ;
   repeat
     //tmp := Value div 10;
     tmp := Int64Div_JOH_PAS_a(Value,ti);
     pointer^:= Ord(Digit[Value-((tmp) * 10)]);
     Dec(pointer);
     Value := tmp;
   until Value = 0;
   end;

function IntToStr_JOH_LBG_IA32_1_b(Value: Integer): string;
function divU100(Value:Cardinal):Cardinal;

ASM
  MOV EDX, 051eb851fh // 0.1 * 2^32 * 8 rounded up
  MUL EDX
  SHR EDX, 5          // divide by 2^32 * 8
  MOV EAX, EDX

end;
const
  TwoDigitLookup : packed array[0..99] of array[1..2] of Char =
    ('00','01','02','03','04','05','06','07','08','09',
     '10','11','12','13','14','15','16','17','18','19',
     '20','21','22','23','24','25','26','27','28','29',
     '30','31','32','33','34','35','36','37','38','39',
     '40','41','42','43','44','45','46','47','48','49',
     '50','51','52','53','54','55','56','57','58','59',
     '60','61','62','63','64','65','66','67','68','69',
     '70','71','72','73','74','75','76','77','78','79',
     '80','81','82','83','84','85','86','87','88','89',
     '90','91','92','93','94','95','96','97','98','99');


type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
var
  Negative : Boolean;
  I, J, K  : Cardinal;
  Digits   : Byte;
  P        : PByte;
  NewLen, OldLen : Integer;
begin
  Negative := Value < 0;
  I := Abs(Value);
  if I >= 10000 then
    if I >= 1000000 then
      if I >= 100000000 then
        Digits := 9 + Ord(I >= 1000000000)
      else
        Digits := 7 + Ord(I >= 10000000)
    else
      Digits := 5 + Ord(I >= 100000)
  else
    if I >= 100 then
      Digits := 3 + Ord(I >= 1000)
    else
      Digits := 1 + Ord(I >= 10);
  NewLen  := Digits + Ord(Negative);
  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if NewLen <> OldLen then
    SetLength(Result, NewLen);
  P := Pointer(Result);
  P^ := Byte('-');
  Inc(P, Ord(Negative));
  if Digits > 2 then
    repeat
      j := divU100(I);           {Dividend div 100}
      K  :=I-( J * 100);         {Dividend - (Dividend div 100 * 100)}
      I  := J;                   {Next Dividend}
      Dec(Digits, 2);
      PWord(@PByteArray(P)[Digits])^ := Word(TwoDigitLookup[K]);
    until Digits <= 2;
  if Digits = 2 then
    PWord(@PByteArray(P)[Digits-2])^ := Word(TwoDigitLookup[I])
  else
    P^ := I or ord('0');
end;

//Author:            Lars Bloch Gravengaard
//Date:              12/6 2005
//Instructionset(s): Pas
function IntToStr_LBG_PAS_1_b(Value: Integer): string;
const
   Digits : array[-9..9] of Char = '9876543210123456789';

var
    StringLength : Integer;
    pointer          : pByte;

begin
   case Abs(Value) of
     0..9                  : StringLength := 1;
     10..99                : StringLength := 2;
     100..999              : StringLength := 3;
     1000..9999            : StringLength := 4;
     10000..99999          : StringLength := 5;
     100000..999999        : StringLength := 6;
     1000000..9999999      : StringLength := 7;
     10000000..99999999    : StringLength := 8;
     100000000..999999999  : StringLength := 9;
   else
     StringLength := 10;
   end;

   if Value < 0 then
     Inc(StringLength);

   SetLength(Result, StringLength);
   pointer := @Result[StringLength];

   pByte(Result)^ := Ord('-');

   repeat
     pointer^:= Ord(Digits[Value-((Value div 10) * 10)]);
     Dec(pointer);
     Value := Value div 10;
   until Value = 0;

end;

//Author:            Lars Bloch Gravengaard
//Date:              17/9 2005
//Instructionset(s): Pas

function IntToStr_LBG_PAS_2_b(Value: Integer): string;
const
  Digit : array[-9..9] of Char = '9876543210123456789';
label
  D1,D2,D3,D4,D5,D6,D7,D8,D9;
var
  StringLength,StringLengthTemp,tmp : Integer;
  pointer          : pByte;

begin
  case Abs(Value) of
    0..9                  : StringLength := 1;
    10..99                : StringLength := 2;
    100..999              : StringLength := 3;
    1000..9999            : StringLength := 4;
    10000..99999          : StringLength := 5;
    100000..999999        : StringLength := 6;
    1000000..9999999      : StringLength := 7;
    10000000..99999999    : StringLength := 8;
    100000000..999999999  : StringLength := 9;
  else
    StringLength := 10;
  end;

   StringLengthTemp := StringLength + ORD(Value < 0);

   SetLength(Result, StringLengthTemp);
   pointer := @Result[StringLengthTemp];

   pByte(Result)^ := Ord('-');

       if  StringLength = 1 then goto D1
  else if  StringLength = 2 then goto D2
  else if  StringLength = 3 then goto D3
  else if  StringLength = 4 then goto D4
  else if  StringLength = 5 then goto D5
  else if  StringLength = 6 then goto D6
  else if  StringLength = 7 then goto D7
  else if  StringLength = 8 then goto D8
  else if  StringLength = 9 then goto D9;

    tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-(tmp * 10)]);
    Value := tmp;
    Dec(pointer);

D9: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Value := tmp;
    Dec(pointer);
D8: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D7: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D6: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D5: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D4: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D3: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D2: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D1: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
end;


//Author:            Lars Bloch Gravengaard
//Date:              17/9 2005
//Instructionset(s): IA32,PAS
function IntToStr_LBG_IA32_1_b(Value: Integer): string;

const
  Digits : array[0..9] of Char = '0123456789';

label
  D1,D2,D3,D4,D5,D6,D7,D8,D9;

var
    StringLength,StringLength_,tmp : Integer;
    pointer          : pByte;


//function divU10(Value:Integer):Integer;
function divU10(Value:Cardinal):Cardinal;

ASM
  MOV EDX, 0CCCCCCCDh // 0.1 * 2^32 * 8 rounded up
  MUL EDX
  SHR EDX, 3          // divide by 2^32 * 8
  MOV EAX, EDX

end;

begin
  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  case Abs(Value) of
    0..9                  : StringLength := 1;
    10..99                : StringLength := 2;
    100..999              : StringLength := 3;
    1000..9999            : StringLength := 4;
    10000..99999          : StringLength := 5;
    100000..999999        : StringLength := 6;
    1000000..9999999      : StringLength := 7;
    10000000..99999999    : StringLength := 8;
    100000000..999999999  : StringLength := 9;
  else
    StringLength := 10;
  end;

  StringLength_ := StringLength;
  Inc(StringLength,ORD(Value < 0));
  Value:= Abs(Value);

  SetLength(Result, StringLength);
  pointer := @Result[StringLength];

  pByte(Result)^ := Ord('-');
       if  StringLength_ = 1 then goto D1
  else if  StringLength_ = 2 then goto D2
  else if  StringLength_ = 3 then goto D3
  else if  StringLength_ = 4 then goto D4
  else if  StringLength_ = 5 then goto D5
  else if  StringLength_ = 6 then goto D6
  else if  StringLength_ = 7 then goto D7
  else if  StringLength_ = 8 then goto D8
  else if  StringLength_ = 9 then goto D9;

  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Value := tmp;
  Dec(pointer);

D9:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Value := tmp;
  Dec(pointer);
D8:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D7:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D6:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D5:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D4:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D3:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D2:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D1:
  tmp := divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
end;

//Author:            Lars Bloch Gravengaard
//Date:              17/9 2005
//Instructionset(s): Pas

function IntToStr64_LBG_PAS_1_b(Value: int64): string;
const
  Digit : array[-9..9] of Char = '9876543210123456789';
label
  D1,D2,D3,D4,D5,D6,D7,D8,D9;
var
  StringLength,StringLengthTemp,OldLen:integer;
 tmp,Value_ : int64;
  pointer          : pByte;

begin
  if Value = $8000000000000000 then
    begin {Special Case since ABS($8000000000000000) Fails}
      Result := '-9223372036854775808';
      Exit;
    end;

  if (Value >= -MaxInt-1) and (Value <= MaxInt) then
    begin {Within Integer Range - Use Faster Integer Version}
      Result := IntToStr_LBG_IA32_1_b(Value);
      Exit;
    end;

  Value_ := Abs(Value);

  if Value_ >= 100000000000000 then
    if Value_ >= 10000000000000000 then
      if Value_ >= 1000000000000000000 then
        StringLength := 19
      else
        StringLength := 17 + Ord(Value_ >= 100000000000000000)
    else
      StringLength := 15 + Ord(Value_ >= 1000000000000000)
  else
    if Value_ >= 1000000000000 then
      StringLength := 13 + Ord(Value_ >= 10000000000000)
    else
      if Value_ >= 10000000000 then
        StringLength := 11 + Ord(Value_ >= 100000000000)
      else
        StringLength := 10;

  StringLengthTemp := StringLength + ORD(Value < 0);

  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if StringLengthTemp <> OldLen then
    SetLength(Result, StringLengthTemp);

   pointer := @Result[StringLengthTemp];
   pByte(Result)^ := Ord('-');

   repeat
     tmp := Value div 10;
     pointer^:= Ord(Digit[Value-((tmp) * 10)]);
     Dec(pointer);
     Value := tmp;
   until Value = 0;
end;
function Int64Div_JOH_PAS_b(var X, Y : Int64) : Int64;
type
  iRec = packed record
    Lo, Hi : LongWord;
  end;
var
  I, J : LongWord;
begin
  I := iRec(X).Hi and $80000000; {if X >= 0 then I := 0}
  J := iRec(Y).Hi and $80000000; {if Y >= 0 then J := 0}
  if I xor J = 0 then
    begin {Same Sign}
      if I = 0 then
        begin {Both Positive}
          if X >= Y then
            Result := X div Y
          else
            Result := 0
        end
      else
        begin {Both Negative}
          if X <= Y then
            Result := X div Y
          else
            Result := 0
        end;
    end
  else
    begin {Different Sign}
      if I = 0 then
        begin {X = +ve, Y = -ve}
          if X >= -Y then
            Result := X div Y
          else
            Result := 0
        end
      else
        begin {X = -ve, Y = +ve}
          if X <= -Y then
            Result := X div Y
          else
            Result := 0
        end;
    end;
end;

function IntToStr64_LBG_IA32_1_b(Value: int64): string;
const
  Digit : array[-9..9] of Char = '9876543210123456789';

var
  StringLength,StringLengthTemp,OldLen:integer;
 tmp,Value_,Ti : int64;
  pointer          : pByte;
begin
  if Value = $8000000000000000 then
    begin {Special Case since ABS($8000000000000000) Fails}
      Result := '-9223372036854775808';
      Exit;
    end;

  if (Value >= -MaxInt-1) and (Value <= MaxInt) then
    begin {Within Integer Range - Use Faster Integer Version}
      Result := IntToStr_LBG_IA32_1_b(Value);
      Exit;
    end;

  Value_ := Abs(Value);

  if Value_ >= 100000000000000 then
    if Value_ >= 10000000000000000 then
      if Value_ >= 1000000000000000000 then
        StringLength := 19
      else
        StringLength := 17 + Ord(Value_ >= 100000000000000000)
    else
      StringLength := 15 + Ord(Value_ >= 1000000000000000)
  else
    if Value_ >= 1000000000000 then
      StringLength := 13 + Ord(Value_ >= 10000000000000)
    else
      if Value_ >= 10000000000 then
        StringLength := 11 + Ord(Value_ >= 100000000000)
      else
        StringLength := 10;

  StringLengthTemp := StringLength + ORD(Value < 0);

  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if StringLengthTemp <> OldLen then
    SetLength(Result, StringLengthTemp);

   pointer := @Result[StringLengthTemp];
   pByte(Result)^ := Ord('-');
ti:=10 ;
   repeat
     //tmp := Value div 10;
     tmp := Int64Div_JOH_PAS_b(Value,ti);
     pointer^:= Ord(Digit[Value-((tmp) * 10)]);
     Dec(pointer);
     Value := tmp;
   until Value = 0;
   end;

function IntToStr_JOH_LBG_IA32_1_c(Value: Integer): string;
function divU100(Value:Cardinal):Cardinal;

ASM
  MOV EDX, 051eb851fh // 0.1 * 2^32 * 8 rounded up
  MUL EDX
  SHR EDX, 5          // divide by 2^32 * 8
  MOV EAX, EDX

end;
const
  TwoDigitLookup : packed array[0..99] of array[1..2] of Char =
    ('00','01','02','03','04','05','06','07','08','09',
     '10','11','12','13','14','15','16','17','18','19',
     '20','21','22','23','24','25','26','27','28','29',
     '30','31','32','33','34','35','36','37','38','39',
     '40','41','42','43','44','45','46','47','48','49',
     '50','51','52','53','54','55','56','57','58','59',
     '60','61','62','63','64','65','66','67','68','69',
     '70','71','72','73','74','75','76','77','78','79',
     '80','81','82','83','84','85','86','87','88','89',
     '90','91','92','93','94','95','96','97','98','99');


type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
var
  Negative : Boolean;
  I, J, K  : Cardinal;
  Digits   : Byte;
  P        : PByte;
  NewLen, OldLen : Integer;
begin
  Negative := Value < 0;
  I := Abs(Value);
  if I >= 10000 then
    if I >= 1000000 then
      if I >= 100000000 then
        Digits := 9 + Ord(I >= 1000000000)
      else
        Digits := 7 + Ord(I >= 10000000)
    else
      Digits := 5 + Ord(I >= 100000)
  else
    if I >= 100 then
      Digits := 3 + Ord(I >= 1000)
    else
      Digits := 1 + Ord(I >= 10);
  NewLen  := Digits + Ord(Negative);
  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if NewLen <> OldLen then
    SetLength(Result, NewLen);
  P := Pointer(Result);
  P^ := Byte('-');
  Inc(P, Ord(Negative));
  if Digits > 2 then
    repeat
      j := divU100(I);           {Dividend div 100}
      K  :=I-( J * 100);         {Dividend - (Dividend div 100 * 100)}
      I  := J;                   {Next Dividend}
      Dec(Digits, 2);
      PWord(@PByteArray(P)[Digits])^ := Word(TwoDigitLookup[K]);
    until Digits <= 2;
  if Digits = 2 then
    PWord(@PByteArray(P)[Digits-2])^ := Word(TwoDigitLookup[I])
  else
    P^ := I or ord('0');
end;

//Author:            Lars Bloch Gravengaard
//Date:              12/6 2005
//Instructionset(s): Pas
function IntToStr_LBG_PAS_1_c(Value: Integer): string;
const
   Digits : array[-9..9] of Char = '9876543210123456789';

var
    StringLength : Integer;
    pointer          : pByte;

begin
   case Abs(Value) of
     0..9                  : StringLength := 1;
     10..99                : StringLength := 2;
     100..999              : StringLength := 3;
     1000..9999            : StringLength := 4;
     10000..99999          : StringLength := 5;
     100000..999999        : StringLength := 6;
     1000000..9999999      : StringLength := 7;
     10000000..99999999    : StringLength := 8;
     100000000..999999999  : StringLength := 9;
   else
     StringLength := 10;
   end;

   if Value < 0 then
     Inc(StringLength);

   SetLength(Result, StringLength);
   pointer := @Result[StringLength];

   pByte(Result)^ := Ord('-');

   repeat
     pointer^:= Ord(Digits[Value-((Value div 10) * 10)]);
     Dec(pointer);
     Value := Value div 10;
   until Value = 0;

end;

//Author:            Lars Bloch Gravengaard
//Date:              17/9 2005
//Instructionset(s): Pas

function IntToStr_LBG_PAS_2_c(Value: Integer): string;
const
  Digit : array[-9..9] of Char = '9876543210123456789';
label
  D1,D2,D3,D4,D5,D6,D7,D8,D9;
var
  StringLength,StringLengthTemp,tmp : Integer;
  pointer          : pByte;

begin
  case Abs(Value) of
    0..9                  : StringLength := 1;
    10..99                : StringLength := 2;
    100..999              : StringLength := 3;
    1000..9999            : StringLength := 4;
    10000..99999          : StringLength := 5;
    100000..999999        : StringLength := 6;
    1000000..9999999      : StringLength := 7;
    10000000..99999999    : StringLength := 8;
    100000000..999999999  : StringLength := 9;
  else
    StringLength := 10;
  end;

   StringLengthTemp := StringLength + ORD(Value < 0);

   SetLength(Result, StringLengthTemp);
   pointer := @Result[StringLengthTemp];

   pByte(Result)^ := Ord('-');

       if  StringLength = 1 then goto D1
  else if  StringLength = 2 then goto D2
  else if  StringLength = 3 then goto D3
  else if  StringLength = 4 then goto D4
  else if  StringLength = 5 then goto D5
  else if  StringLength = 6 then goto D6
  else if  StringLength = 7 then goto D7
  else if  StringLength = 8 then goto D8
  else if  StringLength = 9 then goto D9;

    tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-(tmp * 10)]);
    Value := tmp;
    Dec(pointer);

D9: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Value := tmp;
    Dec(pointer);
D8: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D7: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D6: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D5: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D4: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D3: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D2: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D1: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
end;


//Author:            Lars Bloch Gravengaard
//Date:              17/9 2005
//Instructionset(s): IA32,PAS
function IntToStr_LBG_IA32_1_c(Value: Integer): string;

const
  Digits : array[0..9] of Char = '0123456789';

label
  D1,D2,D3,D4,D5,D6,D7,D8,D9;

var
    StringLength,StringLength_,tmp : Integer;
    pointer          : pByte;


//function divU10(Value:Integer):Integer;
function divU10(Value:Cardinal):Cardinal;

ASM
  MOV EDX, 0CCCCCCCDh // 0.1 * 2^32 * 8 rounded up
  MUL EDX
  SHR EDX, 3          // divide by 2^32 * 8
  MOV EAX, EDX

end;

begin
  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  case Abs(Value) of
    0..9                  : StringLength := 1;
    10..99                : StringLength := 2;
    100..999              : StringLength := 3;
    1000..9999            : StringLength := 4;
    10000..99999          : StringLength := 5;
    100000..999999        : StringLength := 6;
    1000000..9999999      : StringLength := 7;
    10000000..99999999    : StringLength := 8;
    100000000..999999999  : StringLength := 9;
  else
    StringLength := 10;
  end;

  StringLength_ := StringLength;
  Inc(StringLength,ORD(Value < 0));
  Value:= Abs(Value);

  SetLength(Result, StringLength);
  pointer := @Result[StringLength];

  pByte(Result)^ := Ord('-');
       if  StringLength_ = 1 then goto D1
  else if  StringLength_ = 2 then goto D2
  else if  StringLength_ = 3 then goto D3
  else if  StringLength_ = 4 then goto D4
  else if  StringLength_ = 5 then goto D5
  else if  StringLength_ = 6 then goto D6
  else if  StringLength_ = 7 then goto D7
  else if  StringLength_ = 8 then goto D8
  else if  StringLength_ = 9 then goto D9;

  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Value := tmp;
  Dec(pointer);

D9:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Value := tmp;
  Dec(pointer);
D8:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D7:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D6:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D5:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D4:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D3:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D2:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D1:
  tmp := divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
end;

//Author:            Lars Bloch Gravengaard
//Date:              17/9 2005
//Instructionset(s): Pas

function IntToStr64_LBG_PAS_1_c(Value: int64): string;
const
  Digit : array[-9..9] of Char = '9876543210123456789';
label
  D1,D2,D3,D4,D5,D6,D7,D8,D9;
var
  StringLength,StringLengthTemp,OldLen:integer;
 tmp,Value_ : int64;
  pointer          : pByte;

begin
  if Value = $8000000000000000 then
    begin {Special Case since ABS($8000000000000000) Fails}
      Result := '-9223372036854775808';
      Exit;
    end;

  if (Value >= -MaxInt-1) and (Value <= MaxInt) then
    begin {Within Integer Range - Use Faster Integer Version}
      Result := IntToStr_LBG_IA32_1_c(Value);
      Exit;
    end;

  Value_ := Abs(Value);

  if Value_ >= 100000000000000 then
    if Value_ >= 10000000000000000 then
      if Value_ >= 1000000000000000000 then
        StringLength := 19
      else
        StringLength := 17 + Ord(Value_ >= 100000000000000000)
    else
      StringLength := 15 + Ord(Value_ >= 1000000000000000)
  else
    if Value_ >= 1000000000000 then
      StringLength := 13 + Ord(Value_ >= 10000000000000)
    else
      if Value_ >= 10000000000 then
        StringLength := 11 + Ord(Value_ >= 100000000000)
      else
        StringLength := 10;

  StringLengthTemp := StringLength + ORD(Value < 0);

  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if StringLengthTemp <> OldLen then
    SetLength(Result, StringLengthTemp);

   pointer := @Result[StringLengthTemp];
   pByte(Result)^ := Ord('-');

   repeat
     tmp := Value div 10;
     pointer^:= Ord(Digit[Value-((tmp) * 10)]);
     Dec(pointer);
     Value := tmp;
   until Value = 0;
end;
function Int64Div_JOH_PAS_c(var X, Y : Int64) : Int64;
type
  iRec = packed record
    Lo, Hi : LongWord;
  end;
var
  I, J : LongWord;
begin
  I := iRec(X).Hi and $80000000; {if X >= 0 then I := 0}
  J := iRec(Y).Hi and $80000000; {if Y >= 0 then J := 0}
  if I xor J = 0 then
    begin {Same Sign}
      if I = 0 then
        begin {Both Positive}
          if X >= Y then
            Result := X div Y
          else
            Result := 0
        end
      else
        begin {Both Negative}
          if X <= Y then
            Result := X div Y
          else
            Result := 0
        end;
    end
  else
    begin {Different Sign}
      if I = 0 then
        begin {X = +ve, Y = -ve}
          if X >= -Y then
            Result := X div Y
          else
            Result := 0
        end
      else
        begin {X = -ve, Y = +ve}
          if X <= -Y then
            Result := X div Y
          else
            Result := 0
        end;
    end;
end;

function IntToStr64_LBG_IA32_1_c(Value: int64): string;
const
  Digit : array[-9..9] of Char = '9876543210123456789';

var
  StringLength,StringLengthTemp,OldLen:integer;
 tmp,Value_,Ti : int64;
  pointer          : pByte;
begin
  if Value = $8000000000000000 then
    begin {Special Case since ABS($8000000000000000) Fails}
      Result := '-9223372036854775808';
      Exit;
    end;

  if (Value >= -MaxInt-1) and (Value <= MaxInt) then
    begin {Within Integer Range - Use Faster Integer Version}
      Result := IntToStr_LBG_IA32_1_c(Value);
      Exit;
    end;

  Value_ := Abs(Value);

  if Value_ >= 100000000000000 then
    if Value_ >= 10000000000000000 then
      if Value_ >= 1000000000000000000 then
        StringLength := 19
      else
        StringLength := 17 + Ord(Value_ >= 100000000000000000)
    else
      StringLength := 15 + Ord(Value_ >= 1000000000000000)
  else
    if Value_ >= 1000000000000 then
      StringLength := 13 + Ord(Value_ >= 10000000000000)
    else
      if Value_ >= 10000000000 then
        StringLength := 11 + Ord(Value_ >= 100000000000)
      else
        StringLength := 10;

  StringLengthTemp := StringLength + ORD(Value < 0);

  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if StringLengthTemp <> OldLen then
    SetLength(Result, StringLengthTemp);

   pointer := @Result[StringLengthTemp];
   pByte(Result)^ := Ord('-');
ti:=10 ;
   repeat
     //tmp := Value div 10;
     tmp := Int64Div_JOH_PAS_c(Value,ti);
     pointer^:= Ord(Digit[Value-((tmp) * 10)]);
     Dec(pointer);
     Value := tmp;
   until Value = 0;
   end;

function IntToStr_JOH_LBG_IA32_1_d(Value: Integer): string;
function divU100(Value:Cardinal):Cardinal;

ASM
  MOV EDX, 051eb851fh // 0.1 * 2^32 * 8 rounded up
  MUL EDX
  SHR EDX, 5          // divide by 2^32 * 8
  MOV EAX, EDX

end;
const
  TwoDigitLookup : packed array[0..99] of array[1..2] of Char =
    ('00','01','02','03','04','05','06','07','08','09',
     '10','11','12','13','14','15','16','17','18','19',
     '20','21','22','23','24','25','26','27','28','29',
     '30','31','32','33','34','35','36','37','38','39',
     '40','41','42','43','44','45','46','47','48','49',
     '50','51','52','53','54','55','56','57','58','59',
     '60','61','62','63','64','65','66','67','68','69',
     '70','71','72','73','74','75','76','77','78','79',
     '80','81','82','83','84','85','86','87','88','89',
     '90','91','92','93','94','95','96','97','98','99');


type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
var
  Negative : Boolean;
  I, J, K  : Cardinal;
  Digits   : Byte;
  P        : PByte;
  NewLen, OldLen : Integer;
begin
  Negative := Value < 0;
  I := Abs(Value);
  if I >= 10000 then
    if I >= 1000000 then
      if I >= 100000000 then
        Digits := 9 + Ord(I >= 1000000000)
      else
        Digits := 7 + Ord(I >= 10000000)
    else
      Digits := 5 + Ord(I >= 100000)
  else
    if I >= 100 then
      Digits := 3 + Ord(I >= 1000)
    else
      Digits := 1 + Ord(I >= 10);
  NewLen  := Digits + Ord(Negative);
  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if NewLen <> OldLen then
    SetLength(Result, NewLen);
  P := Pointer(Result);
  P^ := Byte('-');
  Inc(P, Ord(Negative));
  if Digits > 2 then
    repeat
      j := divU100(I);           {Dividend div 100}
      K  :=I-( J * 100);         {Dividend - (Dividend div 100 * 100)}
      I  := J;                   {Next Dividend}
      Dec(Digits, 2);
      PWord(@PByteArray(P)[Digits])^ := Word(TwoDigitLookup[K]);
    until Digits <= 2;
  if Digits = 2 then
    PWord(@PByteArray(P)[Digits-2])^ := Word(TwoDigitLookup[I])
  else
    P^ := I or ord('0');
end;

//Author:            Lars Bloch Gravengaard
//Date:              12/6 2005
//Instructionset(s): Pas
function IntToStr_LBG_PAS_1_d(Value: Integer): string;
const
   Digits : array[-9..9] of Char = '9876543210123456789';

var
    StringLength : Integer;
    pointer          : pByte;

begin
   case Abs(Value) of
     0..9                  : StringLength := 1;
     10..99                : StringLength := 2;
     100..999              : StringLength := 3;
     1000..9999            : StringLength := 4;
     10000..99999          : StringLength := 5;
     100000..999999        : StringLength := 6;
     1000000..9999999      : StringLength := 7;
     10000000..99999999    : StringLength := 8;
     100000000..999999999  : StringLength := 9;
   else
     StringLength := 10;
   end;

   if Value < 0 then
     Inc(StringLength);

   SetLength(Result, StringLength);
   pointer := @Result[StringLength];

   pByte(Result)^ := Ord('-');

   repeat
     pointer^:= Ord(Digits[Value-((Value div 10) * 10)]);
     Dec(pointer);
     Value := Value div 10;
   until Value = 0;

end;

//Author:            Lars Bloch Gravengaard
//Date:              17/9 2005
//Instructionset(s): Pas

function IntToStr_LBG_PAS_2_d(Value: Integer): string;
const
  Digit : array[-9..9] of Char = '9876543210123456789';
label
  D1,D2,D3,D4,D5,D6,D7,D8,D9;
var
  StringLength,StringLengthTemp,tmp : Integer;
  pointer          : pByte;

begin
  case Abs(Value) of
    0..9                  : StringLength := 1;
    10..99                : StringLength := 2;
    100..999              : StringLength := 3;
    1000..9999            : StringLength := 4;
    10000..99999          : StringLength := 5;
    100000..999999        : StringLength := 6;
    1000000..9999999      : StringLength := 7;
    10000000..99999999    : StringLength := 8;
    100000000..999999999  : StringLength := 9;
  else
    StringLength := 10;
  end;

   StringLengthTemp := StringLength + ORD(Value < 0);

   SetLength(Result, StringLengthTemp);
   pointer := @Result[StringLengthTemp];

   pByte(Result)^ := Ord('-');

       if  StringLength = 1 then goto D1
  else if  StringLength = 2 then goto D2
  else if  StringLength = 3 then goto D3
  else if  StringLength = 4 then goto D4
  else if  StringLength = 5 then goto D5
  else if  StringLength = 6 then goto D6
  else if  StringLength = 7 then goto D7
  else if  StringLength = 8 then goto D8
  else if  StringLength = 9 then goto D9;

    tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-(tmp * 10)]);
    Value := tmp;
    Dec(pointer);

D9: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Value := tmp;
    Dec(pointer);
D8: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D7: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D6: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D5: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D4: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D3: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D2: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
    Dec(pointer);
    Value := tmp;
D1: tmp :=  Value div 10;
    pointer^:= Ord(Digit[Value-tmp*10]);
end;


//Author:            Lars Bloch Gravengaard
//Date:              17/9 2005
//Instructionset(s): IA32,PAS
function IntToStr_LBG_IA32_1_d(Value: Integer): string;

const
  Digits : array[0..9] of Char = '0123456789';

label
  D1,D2,D3,D4,D5,D6,D7,D8,D9;

var
    StringLength,StringLength_,tmp : Integer;
    pointer          : pByte;


//function divU10(Value:Integer):Integer;
function divU10(Value:Cardinal):Cardinal;

ASM
  MOV EDX, 0CCCCCCCDh // 0.1 * 2^32 * 8 rounded up
  MUL EDX
  SHR EDX, 3          // divide by 2^32 * 8
  MOV EAX, EDX

end;

begin
  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  case Abs(Value) of
    0..9                  : StringLength := 1;
    10..99                : StringLength := 2;
    100..999              : StringLength := 3;
    1000..9999            : StringLength := 4;
    10000..99999          : StringLength := 5;
    100000..999999        : StringLength := 6;
    1000000..9999999      : StringLength := 7;
    10000000..99999999    : StringLength := 8;
    100000000..999999999  : StringLength := 9;
  else
    StringLength := 10;
  end;

  StringLength_ := StringLength;
  Inc(StringLength,ORD(Value < 0));
  Value:= Abs(Value);

  SetLength(Result, StringLength);
  pointer := @Result[StringLength];

  pByte(Result)^ := Ord('-');
       if  StringLength_ = 1 then goto D1
  else if  StringLength_ = 2 then goto D2
  else if  StringLength_ = 3 then goto D3
  else if  StringLength_ = 4 then goto D4
  else if  StringLength_ = 5 then goto D5
  else if  StringLength_ = 6 then goto D6
  else if  StringLength_ = 7 then goto D7
  else if  StringLength_ = 8 then goto D8
  else if  StringLength_ = 9 then goto D9;

  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Value := tmp;
  Dec(pointer);

D9:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Value := tmp;
  Dec(pointer);
D8:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D7:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D6:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D5:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D4:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D3:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D2:
  tmp :=  divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
  Dec(pointer);
  Value := tmp;
D1:
  tmp := divU10( Value);
  pointer^:= Ord(Digits[Value-tmp*10]);
end;

//Author:            Lars Bloch Gravengaard
//Date:              17/9 2005
//Instructionset(s): Pas

function IntToStr64_LBG_PAS_1_d(Value: int64): string;
const
  Digit : array[-9..9] of Char = '9876543210123456789';
label
  D1,D2,D3,D4,D5,D6,D7,D8,D9;
var
  StringLength,StringLengthTemp,OldLen:integer;
 tmp,Value_ : int64;
  pointer          : pByte;

begin
  if Value = $8000000000000000 then
    begin {Special Case since ABS($8000000000000000) Fails}
      Result := '-9223372036854775808';
      Exit;
    end;

  if (Value >= -MaxInt-1) and (Value <= MaxInt) then
    begin {Within Integer Range - Use Faster Integer Version}
      Result := IntToStr_LBG_IA32_1_d(Value);
      Exit;
    end;

  Value_ := Abs(Value);

  if Value_ >= 100000000000000 then
    if Value_ >= 10000000000000000 then
      if Value_ >= 1000000000000000000 then
        StringLength := 19
      else
        StringLength := 17 + Ord(Value_ >= 100000000000000000)
    else
      StringLength := 15 + Ord(Value_ >= 1000000000000000)
  else
    if Value_ >= 1000000000000 then
      StringLength := 13 + Ord(Value_ >= 10000000000000)
    else
      if Value_ >= 10000000000 then
        StringLength := 11 + Ord(Value_ >= 100000000000)
      else
        StringLength := 10;

  StringLengthTemp := StringLength + ORD(Value < 0);

  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if StringLengthTemp <> OldLen then
    SetLength(Result, StringLengthTemp);

   pointer := @Result[StringLengthTemp];
   pByte(Result)^ := Ord('-');

   repeat
     tmp := Value div 10;
     pointer^:= Ord(Digit[Value-((tmp) * 10)]);
     Dec(pointer);
     Value := tmp;
   until Value = 0;
end;
function Int64Div_JOH_PAS_d(var X, Y : Int64) : Int64;
type
  iRec = packed record
    Lo, Hi : LongWord;
  end;
var
  I, J : LongWord;
begin
  I := iRec(X).Hi and $80000000; {if X >= 0 then I := 0}
  J := iRec(Y).Hi and $80000000; {if Y >= 0 then J := 0}
  if I xor J = 0 then
    begin {Same Sign}
      if I = 0 then
        begin {Both Positive}
          if X >= Y then
            Result := X div Y
          else
            Result := 0
        end
      else
        begin {Both Negative}
          if X <= Y then
            Result := X div Y
          else
            Result := 0
        end;
    end
  else
    begin {Different Sign}
      if I = 0 then
        begin {X = +ve, Y = -ve}
          if X >= -Y then
            Result := X div Y
          else
            Result := 0
        end
      else
        begin {X = -ve, Y = +ve}
          if X <= -Y then
            Result := X div Y
          else
            Result := 0
        end;
    end;
end;

function IntToStr64_LBG_IA32_1_d(Value: int64): string;
const
  Digit : array[-9..9] of Char = '9876543210123456789';

var
  StringLength,StringLengthTemp,OldLen:integer;
 tmp,Value_,Ti : int64;
  pointer          : pByte;
begin
  if Value = $8000000000000000 then
    begin {Special Case since ABS($8000000000000000) Fails}
      Result := '-9223372036854775808';
      Exit;
    end;

  if (Value >= -MaxInt-1) and (Value <= MaxInt) then
    begin {Within Integer Range - Use Faster Integer Version}
      Result := IntToStr_LBG_IA32_1_d(Value);
      Exit;
    end;

  Value_ := Abs(Value);

  if Value_ >= 100000000000000 then
    if Value_ >= 10000000000000000 then
      if Value_ >= 1000000000000000000 then
        StringLength := 19
      else
        StringLength := 17 + Ord(Value_ >= 100000000000000000)
    else
      StringLength := 15 + Ord(Value_ >= 1000000000000000)
  else
    if Value_ >= 1000000000000 then
      StringLength := 13 + Ord(Value_ >= 10000000000000)
    else
      if Value_ >= 10000000000 then
        StringLength := 11 + Ord(Value_ >= 100000000000)
      else
        StringLength := 10;

  StringLengthTemp := StringLength + ORD(Value < 0);

  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if StringLengthTemp <> OldLen then
    SetLength(Result, StringLengthTemp);

   pointer := @Result[StringLengthTemp];
   pByte(Result)^ := Ord('-');
ti:=10 ;
   repeat
     //tmp := Value div 10;
     tmp := Int64Div_JOH_PAS_d(Value,ti);
     pointer^:= Ord(Digit[Value-((tmp) * 10)]);
     Dec(pointer);
     Value := tmp;
   until Value = 0;
   end;

initialization
begin
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_LBG_IA32_1_a', 'Division, loop removed, fast div 10', @IntToStr_LBG_IA32_1_a, fccIA32, fcaLBG));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_LBG_IA32_1_b', 'Division, loop removed, fast div 10', @IntToStr_LBG_IA32_1_b, fccIA32, fcaLBG));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_LBG_IA32_1_c', 'Division, loop removed, fast div 10', @IntToStr_LBG_IA32_1_c, fccIA32, fcaLBG));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_LBG_IA32_1_d', 'Division, loop removed, fast div 10', @IntToStr_LBG_IA32_1_d, fccIA32, fcaLBG));
end;

end.
