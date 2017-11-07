unit TrimRTLUnit;

interface

implementation

uses
 MainUnit, SysUtils, Math;

function Trim_RTL_Pas_2_a(const S: string): string;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] <= ' ') do Inc(I);
  if I > L then Result := '' else
  begin
    while S[L] <= ' ' do Dec(L);
    Result := Copy(S, I, L - I + 1);
  end;
end;

function Trim_RTL_Pas_2_b(const S: string): string;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] <= ' ') do Inc(I);
  if I > L then Result := '' else
  begin
    while S[L] <= ' ' do Dec(L);
    Result := Copy(S, I, L - I + 1);
  end;
end;

function Trim_RTL_Pas_2_c(const S: string): string;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] <= ' ') do Inc(I);
  if I > L then Result := '' else
  begin
    while S[L] <= ' ' do Dec(L);
    Result := Copy(S, I, L - I + 1);
  end;
end;

function Trim_RTL_Pas_2_d(const S: string): string;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] <= ' ') do Inc(I);
  if I > L then Result := '' else
  begin
    while S[L] <= ' ' do Dec(L);
    Result := Copy(S, I, L - I + 1);
  end;
end;

initialization

 MainForm.RegisterFunction('Trim_RTL_Pas_1_a', @Trim);
 MainForm.RegisterFunction('Trim_RTL_Pas_2_a', @Trim_RTL_Pas_2_a);
 MainForm.RegisterFunction('Trim_RTL_Pas_2_b', @Trim_RTL_Pas_2_b);
 MainForm.RegisterFunction('Trim_RTL_Pas_2_c', @Trim_RTL_Pas_2_c);
 MainForm.RegisterFunction('Trim_RTL_Pas_2_d', @Trim_RTL_Pas_2_d);

end.


