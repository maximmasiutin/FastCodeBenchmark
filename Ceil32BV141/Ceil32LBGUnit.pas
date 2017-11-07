unit Ceil32LBGUnit;

interface

function Ceil32_LBG_Pas_1(const X: Single): Integer; overload;
function Ceil32_LBG_Pas_1(const X: Extended): Integer; overload;

implementation

{These functions require range checking}
{$IFOPT R-}
  {$DEFINE RANGECHECKINGWASOFF}
  {$R+}
{$ENDIF}

function Ceil32_LBG_Pas_1(const X: Single): Integer; overload;
begin
  if x < 0  then
    begin
      Result := Trunc(X);
      exit;
    end;
  Result := Trunc(X);
  if X - Result <> 0 then
    Inc(Result);
end;

function Ceil32_LBG_Pas_1(const X: Extended): Integer; overload;
begin
  Result := Trunc(X);
  if X < 0 then exit;
  if X - Result <> 0 then Inc(Result);
end;

{$IFDEF RANGECHECKINGWASOFF}
  {$UNDEF RANGECHECKINGWASOFF}
  {$R-}
{$ENDIF}

end.
