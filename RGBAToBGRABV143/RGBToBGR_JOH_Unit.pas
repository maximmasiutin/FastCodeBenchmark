unit RGBToBGR_JOH_Unit;

interface

uses
 Graphics;

procedure RGBToBGR_JOH_PAS_1(SrcDestBitmap : TBitmap);

implementation

uses
 SysUtils;

{$R-}

procedure RGBToBGR_JOH_PAS_1(SrcDestBitmap : TBitmap);
var
  H, W  : Integer;
  P, P2 : PByteArray;
  B     : Byte;
begin
  if SrcDestBitmap.PixelFormat <> pf32bit then
    raise Exception.Create('Only pf32bit PixelFormat supported');
  H := SrcDestBitmap.Height;
  W := SrcDestBitmap.Width;
  if (H > 0) and (W > 0) then
    begin
      P := SrcDestBitmap.ScanLine[0];
      if H > 1 then
        begin {Allow for Top-Down or Botton-Up DIB Orientation}
          P2 := P;
          P  := SrcDestBitmap.ScanLine[H-1];
          if Integer(P2) < Integer(P) then
            P := P2;
        end;
      P2 := @P[W * H * 4];
      repeat
        B    := P[0];
        P[0] := P[2];
        P[2] := B;
        Inc(Integer(P), 4);
      until P = P2;
    end;
end;

end.
