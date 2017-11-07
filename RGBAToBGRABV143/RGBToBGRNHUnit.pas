unit RGBToBGRNHUnit;

interface

uses
 Windows, Graphics;

procedure RGBToBGR_NH_Pas_1(SrcDestBitmap : TBitmap);

implementation

uses
 SysUtils;
 
//Author:            Nils Haeck
//Date:              18/3 2004
//Optimized for:     Blended
//Instructionset(s): IA32

procedure RGBToBGR_NH_Pas_1(SrcDestBitmap : TBitmap);
type
  PByte = ^byte;
var
  r, c, AColMax: integer;
  S, D: PByte;
  Red, Blue: byte;
begin
  if SrcDestBitmap.PixelFormat <> pf32bit then
    raise Exception.Create('Only pf32bit PixelFormat supported');
  AColMax := SrcDestBitmap.Width - 1;
  for r := 0 to SrcDestBitmap.Height - 1 do begin
    S := SrcDestBitmap.ScanLine[r];
    D := S;
    for c := 0 to AColMax do begin
      Red := S^;  inc(S, 2);
      Blue := S^; inc(S, 2);
      D^ := Blue; inc(D, 2);
      D^ := Red;  inc(D, 2);
    end;
  end;
end;

end.
 