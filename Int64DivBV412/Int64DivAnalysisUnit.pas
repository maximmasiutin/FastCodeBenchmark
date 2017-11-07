unit Int64DivAnalysisUnit;

interface

function Int64Div_Analyse(var X, Y: Int64): Int64;
//procedure CalculateDistribution;

implementation

uses
 SysUtils;

var
  TotalDivisions, BigBigDivisions, BigSmallDivisions, SmallBigDivisions,
  SmallSmallDivisions, ZeroResults: Cardinal;

procedure ClearCounters; {Call from Unit Initialization}
begin
  TotalDivisions := 0;
  BigBigDivisions := 0;
  BigSmallDivisions := 0;
  SmallBigDivisions := 0;
  SmallSmallDivisions := 0;
  ZeroResults := 0;
end;

function Int64Div_Analyse(var X, Y: Int64): Int64;
var
 Dividend, Divisor: Int64;
 //BigDividend, BigDivisor: Boolean;
const
 MININT64 : Int64 = Low(Int64);
 MAXINT64 : Int64 = High(Int64);//$7FFFFFFFFFFFFFFF;

begin
  Inc(TotalDivisions);
  if X <> MININT64 then //Cannot Abs MinInt64
   Dividend := Abs(X)
  else
   Dividend := Abs(X+1); //It is still big
  if Y <> MININT64 then //Cannot Abs MinInt64
   Divisor  := Abs(Y)
  else
   Divisor := Abs(X+1); //It is still big
  if (Dividend > MaxInt) and (Divisor > MaxInt)then
   Inc(BigBigDivisions)
  else if (Dividend > MaxInt) and (Divisor <= MaxInt)then
   Inc(BigSmallDivisions)
  else if (Dividend <= MaxInt) and (Divisor > MaxInt)then
   Inc(SmallBigDivisions)
  else if (Dividend <= MaxInt) and (Divisor <= MaxInt)then
   Inc(SmallSmallDivisions)
  else
   raise Exception.Create('We never get here');
  Result := X div Y;
  if Result = 0 then
    Inc(ZeroResults);
end;
{
procedure CalculateDistribution;
var
 BigBigDivisionsPercentage : Double;
 BigSmallDivisionsPercentage : Double;
 SmallBigDivisionsPercentage : Double;
 SmallSmallDivisionsPercentage : Double;
 ZeroResultsPercentage : Double;
 BigBigDivisionsFP : Double;
 BigSmallDivisionsFP : Double;
 SmallBigDivisionsFP : Double;
 SmallSmallDivisionsFP : Double;
 ZeroResultsFP : Double;

begin
 BigBigDivisionsFP := BigBigDivisions;
 BigSmallDivisionsFP := BigSmallDivisions;
 SmallBigDivisionsFP := SmallBigDivisions;
 SmallSmallDivisionsFP := SmallSmallDivisions;
 ZeroResultsFP := ZeroResults;
 BigBigDivisionsPercentage := 100 * BigBigDivisionsFP/TotalDivisions;
 SmallSmallDivisionsPercentage := 100 * SmallSmallDivisionsFP/TotalDivisions;
 BigSmallDivisionsPercentage := 100 * BigSmallDivisionsFP/TotalDivisions;
 SmallBigDivisionsPercentage := 100 * SmallBigDivisionsFP/TotalDivisions;
 ZeroResultsPercentage := 100 * ZeroResultsFP/TotalDivisions;
end;
}
//Large dividend and large divisor - Subbench 1
//Small dividend and Small divisor - Subbench 2
//Large dividend and small divisor - Subbench 3
//Small dividend and large divisor - Subbench 4

//Johns real world distribution
//5/80/12/3
//Zero result divisions

//Benchmark distribution
//5.3/78/13/3.4
//Zero result divisions
//3.4

initialization

 ClearCounters;

end.
