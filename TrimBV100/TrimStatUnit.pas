unit TrimStatUnit;

interface

function GetTrimRatio : Double;

implementation

uses
 MainUnit, SysUtils, Math;

var
 TotalCount : Cardinal = 0;
 TrimCount : Cardinal = 0;
 NoTrimCount : Cardinal = 0;

function Trim_STAT_Pas_1_a(const S: string): string;
begin
 Inc(TotalCount);
 if S = '' then
  begin
   Inc(NoTrimCount);
   Exit;
  end;
 if (S[1] > ' ') and (S[Length(S)] > ' ') then
  Inc(NoTrimCount)
 else
  Inc(TrimCount);
end;

function GetTrimRatio : Double;
begin
 Result := TrimCount / TotalCount;
end;

initialization

 MainForm.RegisterFunction('Trim_STAT_Pas_1_a', @Trim_STAT_Pas_1_a);

end.


