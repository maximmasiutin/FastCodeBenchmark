unit RoundToEXJHUnit;

interface

uses
 RoundToEXRefUnit;

function RoundToEX_JH1_Pas1(const AValue: Extended; const ADigit: TRoundToEXRange): Extended;

implementation

function RoundToEX_JH1_Pas1(const AValue: Extended; const ADigit: TRoundToEXRange): Extended;
var
 CW8087 : Word; ChgCWReq: boolean; LFactor : extended;
const
 LFactorArray : array[0 .. 37] of Extended =
  (1, 1E1, 1E2, 1E3, 1E4, 1E5, 1E6, 1E7, 1E8, 1E9, 1E10, 1E11,
   1E12, 1E13, 1E14, 1E15, 1E16, 1E17, 1E18, 1E19, 1E20, 1E21,
   1E22, 1E23, 1E24, 1E25, 1E26, 1E27, 1E28, 1E29, 1E30, 1E31,
   1E32, 1E33, 1E34, 1E35, 1E36, 1E37);
begin
  CW8087 := Get8087CW;
  ChgCWReq := ((CW8087 and $0F00) <> $0300);
  If ChgCWReq
    then Set8087CW($1332);
  try
    LFactor := LFactorArray[abs(ADigit)];
    if ADigit > 0
      then Result := Round(AValue / LFactor) * LFactor
      else Result := Round(AValue * LFactor) / LFactor;
  finally
    If ChgCWReq
      then Set8087CW(CW8087);
  end;
end;

end.
