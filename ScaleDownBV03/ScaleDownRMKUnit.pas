unit ScaleDownRMKUnit;

interface

uses
 Graphics;

function ScaleDownRMKPas1(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;

implementation

uses
 SysUtils;

type

  PRGB24 = ^TRGB24;
  TRGB24 = packed record
    B: Byte;
    G: Byte;
    R: Byte;
  end;

function ScaleDownRMKPas1(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
type
  PRGB32 = ^TRGB32;
  TRGB32 = packed record
    B: Byte;
    G: Byte;
    R: Byte;
    A: Byte;
  end;
var
  x, y, ix, iy: integer;
  x1, x2, x3: integer;

  xscale, yscale: single;
  iRed, iGrn, iBlu, iAlp, iRatio: Longword;
  pt, pt1: pRGB32;
  iSrc, iDst, s1: integer;
  i, j, r, g, b, tmpY: integer;

  RowDest, RowSource, RowSourceStart: integer;
  w, h: integer;
  dxmin, dymin: integer;
  ny1, ny2, ny3: integer;
  dx, dy: integer;
  lutX, lutY: array of integer;
  dstW, dstH: integer;
begin
  if SourceBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');

  if ScaleFactor < 1  then
   raise Exception.Create('ScaleFactor must be bigger than 1');

  Result := TBitmap.Create;
  Result.PixelFormat := pf32bit;

  w := SourceBitmap.Height;
  h := SourceBitmap.Width;
  dstW := Round(w / ScaleFactor);
  dstH := Round(h / ScaleFactor);
  if dstW < 1 then
  raise Exception.Create('Destination Bitmap to small');
  if dstH < 1 then
  raise Exception.Create('Destination Bitmap to small');

  Result.Height := Round(w / ScaleFactor);
  Result.Width := Round(h / ScaleFactor);

  w := Result.Width;
  h := Result.Height;

  iDst := (w * 32 + 31) and not 31;
  iDst := iDst div 8; //BytesPerScanline
  iSrc := (SourceBitmap.Width * 32 + 31) and not 31;
  iSrc := iSrc div 8;

  xscale := 1 / (w / SourceBitmap.Width);
  yscale := 1 / (h / SourceBitmap.Height);

  // X lookup table
  SetLength(lutX, w);
  x1 := 0;
  x2 := trunc(xscale);
  for x := 0 to w - 1 do
  begin
    lutX[x] := x2 - x1;
    x1 := x2;
    x2 := trunc((x + 2) * xscale);
  end;

  // Y lookup table
  SetLength(lutY, h);
  x1 := 0;
  x2 := trunc(yscale);
  for x := 0 to h - 1 do
  begin
    lutY[x] := x2 - x1;
    x1 := x2;
    x2 := trunc((x + 2) * yscale);
  end;

  dec(w);
  dec(h);
  RowDest := integer(Result.Scanline[0]);
  RowSourceStart := integer(SourceBitmap.Scanline[0]);
  RowSource := RowSourceStart;
  for y := 0 to h do
  begin
    dy := lutY[y];
    x1 := 0;
    x3 := 0;
    for x := 0 to w do
    begin
      dx:= lutX[x];
      iRed:= 0;
      iGrn:= 0;
      iBlu:= 0;
      iAlp:= 0;
      RowSource := RowSourceStart;
      for iy := 1 to dy do
      begin
        pt := PRGB32(RowSource + x1);
        for ix := 1 to dx do
        begin
          iRed := iRed + pt.R;
          iGrn := iGrn + pt.G;
          iBlu := iBlu + pt.B;
          iAlp := iAlp + pt.A;
          inc(pt);
        end;
        RowSource := RowSource - iSrc;
      end;
      iRatio := 65535 div (dx * dy);
      pt1 := PRGB32(RowDest + x3);
      pt1.R := (iRed * iRatio) shr 16;
      pt1.G := (iGrn * iRatio) shr 16;
      pt1.B := (iBlu * iRatio) shr 16;
      pt1.A := (iAlp * iRatio) shr 16;
      x1 := x1 + (dx shl 2);
      inc(x3, 4);
    end;
    RowDest := RowDest - iDst;
    RowSourceStart := RowSource;
  end;
end;

end.
 