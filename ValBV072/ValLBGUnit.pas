unit ValLBGUnit;

{$R-,Q-}

{$INCLUDE Version.inc}

{$IFDEF Delphi2005Plus}
  {$WARN UNSAFE_CODE OFF}
{$ENDIF}

interface

implementation

uses
  SysUtils, Math,
//  FastcodeChallengeValLongUnit,
  FastcodeChallengeValInt64Unit,
//  FastcodeChallengeValExtUnit,
  FastcodeChallengeUnit;

procedure Filler1;
asm
 nop
  nop
     nop
  nop
end;


// This is based on ValInt64_JOH_PAS_4_a
// my small changes improved the speed om my amd
// 381 vs 431
{$WARNINGS OFF}
function ValInt64_LBG_PAS_1_a(const s; var code: Integer): Int64;
var
  Digit: Integer;
  Ch: Char;
  Neg, Hex, Valid: Boolean;
begin
  Result := 0;
  Code   := 0;
  if not Assigned(@S) then
    begin
      inc(Code);
      Exit;
    end;
  Neg   := False;
  Hex   := False;
  Valid := False;
  while PChar(@S)[Code] = ' ' do
    Inc(Code);
  Ch := PChar(@S)[Code];
  if Ch in ['+', '-'] then
    begin
      inc(Code);
      Neg := (Ch = '-');
      Ch := PChar(@S)[Code];
    end;
  if Ch = '$' then
    begin
      inc(Code);
      Hex := True;
    end
  else
  if Ch = '0' then
    begin
      inc(Code);
      if PChar(@S)[Code] in ['x','X'] then
        begin
          Hex := True;
          inc(Code);
        end
      else
        Valid := True;
    end;
  if Hex then
    begin
      while true do
        begin
          //Ch := Upcase(PChar(@S)[Code]);
          Ch := PChar(@S)[Code];
          inc(Code);
          case Ch of
            '0'..'9': Digit := Ord(Ch) - Ord('0');
            'a'..'f': Digit := Ord(Ch) - Ord('a') + 10;
            'A'..'F': Digit := Ord(Ch) - Ord('A') + 10;
            else      Break;
          end;
          if (Result < 0) or (Result > (High(Int64) shr 3)) then
            Break;
          Result := (Result shl 4) + Digit;
          Valid := True;
        end;
    end
  else
    begin
      while true do
        begin
          Ch := PChar(@S)[Code];
          inc(Code);
          if not (Ch in ['0'..'9']) then
            break;
          if Result > (High(Int64) div 10) then
            break;
          //Result := (Result * 10) + Ord(Ch) - Ord('0');
          Result := (Result shl 1) + (Result shl 3) + Ord(Ch) - Ord('0');
          Valid := True;
        end;
      if Result < 0 then {Possible Overflow}
        if (not neg) or (Result <> $8000000000000000) then
          begin
            Dec(Code);
            Exit;
          end;
    end;
  if Neg then
    Result := -Result;
  if Valid and (Ch = #0) then
    Code := 0;
end;
{$WARNINGS ON}








initialization
     Filler1;

    ChallengeValInt64.RegisterFunction(FunctionData(
    'ValInt64_LBG_PAS_1_a',  '', @ValInt64_LBG_PAS_1_a, fccPAS, fcaLBG));
end.


