unit RoundToEXRefUnit;

interface

type
 TRoundToEXRangeExtended = -20..20;

function RoundToEX_Ref(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;

implementation

uses
 Math, SysUtils;

function RoundToEX_Ref(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
var
 LFactor: Extended;
 CW8087 : Word;

begin
 CW8087 := Get8087CW;
 if (ADigit < Low(TRoundToEXRangeExtended)) or (ADigit > High(TRoundToEXRangeExtended)) then
  raise Exception.Create('ADigit out of range');
 try
  SetPrecisionMode(pmExtended);
  SetRoundMode(rmNearest);
  LFactor := IntPower(10, ADigit);
  Result := Round(AValue / LFactor) * LFactor;
 finally
  Set8087CW(CW8087);
 end;
end;

end.
