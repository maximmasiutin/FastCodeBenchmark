unit ScaleDownDKCUnit;

interface

uses
 Windows, Graphics;

function ScaleDownDKCPas1(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
function ScaleDownDKCPas2(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
function ScaleDownDKCPas3(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
function ScaleDownDKCPas4(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
function ScaleDownDKCPas5(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
function ScaleDownDKCPas6(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
function ScaleDownDKCPas7(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
function ScaleDownDKCPas8(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
function ScaleDownDKCPas9(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
function ScaleDownDKCPas10(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;

implementation

uses
 MainUnit, SysUtils;

//Author:            Dennis Kjaer Christensen
//Date:              26/3 2004
//Instructionset(s): IA32

function ScaleDownDKCPas1(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
var
 SrcRowNo, DstRowNo, SrcColNo, DstColNo, SrcRowNoMax, SrcColNoMax, DstRowNoMax,
 DstColNoMax, UpperBorderRow, LowerBorderRow, LeftBorderCol, RigthBorderCol,
 SrcRow, SrcCol, NoOfSrcPixels, SumSrcPixelRGBRed, SumSrcPixelRGBBlue, SumSrcPixelRGBGreen : Cardinal;
 SrcPixel, SrcPixelMain, DestPixel : TColor;
 SrcPixelRGB, AverageSrcPixelRGB : TRGBColor;

begin
 if SourceBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if ScaleFactor < 1  then
  raise Exception.Create('ScaleFactor must be bigger than 1');
 Result := TBitmap.Create;
 Result.PixelFormat := pf32bit;
 SrcRowNoMax := SourceBitmap.Height;
 SrcColNoMax := SourceBitmap.Width;
 DstRowNoMax := Round(SrcRowNoMax / ScaleFactor);
 DstColNoMax := Round(SrcColNoMax / ScaleFactor);
 if DstRowNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 if DstColNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 Result.Height := DstRowNoMax;
 Result.Width := DstColNoMax;
 for DstRowNo := 0 to DstRowNoMax-1 do
  begin
   for DstColNo := 0 to DstColNoMax-1 do
    begin
     SrcColNo := Round(DstColNo * ScaleFactor);
     SrcRowNo := Round(DstRowNo * ScaleFactor);
     if SrcRowNo > SrcRowNoMax-1 then
      SrcRowNo := SrcRowNoMax-1;
     if SrcColNo > SrcColNoMax-1 then
      SrcColNo := SrcColNoMax-1;
     if (SrcRowNo > 1) and (SrcColNo > 1) and
        (SrcRowNo < SrcRowNoMax-2) and (SrcColNo < SrcColNoMax-2) then
      begin
       //Calculate size of source area.
       //One destination pixel must be calculated from ScaleFactor*ScaleFactor source pixels.
       //Then all source pixels are used once
       //The source area for each destination pixel is a square with SideLength = ScaleFactor.
       //The Center pixel is pointed at by [SrcColNo, SrcRowNo].
       //The borders are located at SrcColNo +- 0.5 * ScaleFactor
       //and SrcRowNo +- 0.5 * ScaleFactor
       UpperBorderRow := SrcRowNo - Round(0.5 * ScaleFactor);
       LowerBorderRow := SrcRowNo + Round(0.5 * ScaleFactor);
       LeftBorderCol := SrcColNo - Round(0.5 * ScaleFactor);
       RigthBorderCol := SrcColNo + Round(0.5 * ScaleFactor);
       NoOfSrcPixels := 0;
       SumSrcPixelRGBRed := 0;
       SumSrcPixelRGBGreen := 0;
       SumSrcPixelRGBBlue := 0;
       for SrcRow := UpperBorderRow to LowerBorderRow do
        begin
         for SrcCol := LeftBorderCol to RigthBorderCol do
          begin
           Inc(NoOfSrcPixels);
           if SrcRow > SrcRowNoMax-1 then
            raise Exception.Create('SrcRow out of range');
           if SrcCol > SrcColNoMax-1 then
            raise Exception.Create('SrcCol out of range');
           SrcPixel := SourceBitmap.Canvas.Pixels[SrcCol, SrcRow];
           SrcPixelRGB := TColorToTRGB(SrcPixel);
           SumSrcPixelRGBRed := SumSrcPixelRGBRed + SrcPixelRGB.Red;
           SumSrcPixelRGBGreen := SumSrcPixelRGBGreen + SrcPixelRGB.Green;
           SumSrcPixelRGBBlue := SumSrcPixelRGBBlue + SrcPixelRGB.Blue;
          end;
        end;
       AverageSrcPixelRGB.Red := SumSrcPixelRGBRed div NoOfSrcPixels;
       AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen div NoOfSrcPixels;
       AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue div NoOfSrcPixels;
       DestPixel := TRGBToTColor(AverageSrcPixelRGB);
      end
     else
      begin
       SrcPixelMain := SourceBitmap.Canvas.Pixels[SrcColNo, SrcRowNo];
       DestPixel := SrcPixelMain;
      end;
     Result.Canvas.Pixels[DstColNo, DstRowNo] := DestPixel;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/3 2004
//Instructionset(s): IA32

function ScaleDownDKCPas2(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
var
 SrcRowNo, DstRowNo, SrcColNo, DstColNo, SrcRowNoMax, SrcColNoMax, DstRowNoMax,
 DstColNoMax, UpperBorderRow, LowerBorderRow, LeftBorderCol, RigthBorderCol,
 SrcRow, SrcCol, NoOfSrcPixels, SumSrcPixelRGBRed, SumSrcPixelRGBBlue, SumSrcPixelRGBGreen : Cardinal;
 SrcPixelMain, DestPixel : TColor;
 SrcPixelRGB, AverageSrcPixelRGB : TRGBColor;
 pScanLine : PByteArray;

begin
 if SourceBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if ScaleFactor < 1  then
  raise Exception.Create('ScaleFactor must be bigger than 1');
 Result := TBitmap.Create;
 Result.PixelFormat := pf32bit;
 SrcRowNoMax := SourceBitmap.Height;
 SrcColNoMax := SourceBitmap.Width;
 DstRowNoMax := Round(SrcRowNoMax / ScaleFactor);
 DstColNoMax := Round(SrcColNoMax / ScaleFactor);
 if DstRowNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 if DstColNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 Result.Height := DstRowNoMax;
 Result.Width := DstColNoMax;
 for DstRowNo := 0 to DstRowNoMax-1 do
  begin
   for DstColNo := 0 to DstColNoMax-1 do
    begin
     SrcColNo := Round(DstColNo * ScaleFactor);
     SrcRowNo := Round(DstRowNo * ScaleFactor);
     if SrcRowNo > SrcRowNoMax-1 then
      SrcRowNo := SrcRowNoMax-1;
     if SrcColNo > SrcColNoMax-1 then
      SrcColNo := SrcColNoMax-1;
     if (SrcRowNo > 1) and (SrcColNo > 1) and
        (SrcRowNo < SrcRowNoMax-2) and (SrcColNo < SrcColNoMax-2) then
      begin
       UpperBorderRow := SrcRowNo - Round(0.5 * ScaleFactor);
       LowerBorderRow := SrcRowNo + Round(0.5 * ScaleFactor);
       LeftBorderCol := SrcColNo - Round(0.5 * ScaleFactor);
       RigthBorderCol := SrcColNo + Round(0.5 * ScaleFactor);
       NoOfSrcPixels := 0;
       SumSrcPixelRGBRed := 0;
       SumSrcPixelRGBGreen := 0;
       SumSrcPixelRGBBlue := 0;
       for SrcRow := UpperBorderRow to LowerBorderRow do
        begin
         pScanLine := SourceBitmap.ScanLine[SrcRow];
         for SrcCol := LeftBorderCol to RigthBorderCol do
          begin
           Inc(NoOfSrcPixels);
           if SrcRow > SrcRowNoMax-1 then
            raise Exception.Create('SrcRow out of range');
           if SrcCol > SrcColNoMax-1 then
            raise Exception.Create('SrcCol out of range');
           SrcPixelRGB.Red := pScanLine[4*SrcCol];
           SrcPixelRGB.Green := pScanLine[4*SrcCol+1];
           SrcPixelRGB.Blue := pScanLine[4*SrcCol+2];
           SumSrcPixelRGBRed := SumSrcPixelRGBRed + SrcPixelRGB.Red;
           SumSrcPixelRGBGreen := SumSrcPixelRGBGreen + SrcPixelRGB.Green;
           SumSrcPixelRGBBlue := SumSrcPixelRGBBlue + SrcPixelRGB.Blue;
          end;
        end;
       AverageSrcPixelRGB.Red := SumSrcPixelRGBRed div NoOfSrcPixels;
       AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen div NoOfSrcPixels;
       AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue div NoOfSrcPixels;
       DestPixel := TRGBToTColor(AverageSrcPixelRGB);
      end
     else
      begin
       SrcPixelMain := SourceBitmap.Canvas.Pixels[SrcColNo, SrcRowNo];
       DestPixel := SrcPixelMain;
      end;
     Result.Canvas.Pixels[DstColNo, DstRowNo] := DestPixel;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/3 2004
//Instructionset(s): IA32

function ScaleDownDKCPas3(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
var
 SrcRowNo, DstRowNo, SrcColNo, DstColNo, SrcRowNoMax, SrcColNoMax, DstRowNoMax,
 DstColNoMax, UpperBorderRow, LowerBorderRow, LeftBorderCol, RigthBorderCol,
 SrcRow, SrcCol, NoOfSrcPixels, SumSrcPixelRGBRed, SumSrcPixelRGBBlue, SumSrcPixelRGBGreen : Cardinal;
 SrcPixelMain, DestPixel : TColor;
 SrcPixelRGB, AverageSrcPixelRGB, DestPixelRGB : TRGBColor;
 pScanLine, pResultScanLine : PByteArray;

begin
 if SourceBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if ScaleFactor < 1  then
  raise Exception.Create('ScaleFactor must be bigger than 1');
 Result := TBitmap.Create;
 Result.PixelFormat := pf32bit;
 SrcRowNoMax := SourceBitmap.Height;
 SrcColNoMax := SourceBitmap.Width;
 DstRowNoMax := Round(SrcRowNoMax / ScaleFactor);
 DstColNoMax := Round(SrcColNoMax / ScaleFactor);
 if DstRowNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 if DstColNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 Result.Height := DstRowNoMax;
 Result.Width := DstColNoMax;
 for DstRowNo := 0 to DstRowNoMax-1 do
  begin
   for DstColNo := 0 to DstColNoMax-1 do
    begin
     SrcColNo := Round(DstColNo * ScaleFactor);
     SrcRowNo := Round(DstRowNo * ScaleFactor);
     if SrcRowNo > SrcRowNoMax-1 then
      SrcRowNo := SrcRowNoMax-1;
     if SrcColNo > SrcColNoMax-1 then
      SrcColNo := SrcColNoMax-1;
     if (SrcRowNo > 1) and (SrcColNo > 1) and
        (SrcRowNo < SrcRowNoMax-2) and (SrcColNo < SrcColNoMax-2) then
      begin
       UpperBorderRow := SrcRowNo - Round(0.5 * ScaleFactor);
       LowerBorderRow := SrcRowNo + Round(0.5 * ScaleFactor);
       LeftBorderCol := SrcColNo - Round(0.5 * ScaleFactor);
       RigthBorderCol := SrcColNo + Round(0.5 * ScaleFactor);
       NoOfSrcPixels := 0;
       SumSrcPixelRGBRed := 0;
       SumSrcPixelRGBGreen := 0;
       SumSrcPixelRGBBlue := 0;
       for SrcRow := UpperBorderRow to LowerBorderRow do
        begin
         pScanLine := SourceBitmap.ScanLine[SrcRow];
         for SrcCol := LeftBorderCol to RigthBorderCol do
          begin
           Inc(NoOfSrcPixels);
           if SrcRow > SrcRowNoMax-1 then
            raise Exception.Create('SrcRow out of range');
           if SrcCol > SrcColNoMax-1 then
            raise Exception.Create('SrcCol out of range');
           SrcPixelRGB.Red := pScanLine[4*SrcCol];
           SrcPixelRGB.Green := pScanLine[4*SrcCol+1];
           SrcPixelRGB.Blue := pScanLine[4*SrcCol+2];
           SumSrcPixelRGBRed := SumSrcPixelRGBRed + SrcPixelRGB.Red;
           SumSrcPixelRGBGreen := SumSrcPixelRGBGreen + SrcPixelRGB.Green;
           SumSrcPixelRGBBlue := SumSrcPixelRGBBlue + SrcPixelRGB.Blue;
          end;
        end;
       AverageSrcPixelRGB.Red := SumSrcPixelRGBRed div NoOfSrcPixels;
       AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen div NoOfSrcPixels;
       AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue div NoOfSrcPixels;
       DestPixel := TRGBToTColor(AverageSrcPixelRGB);
      end
     else
      begin
       SrcPixelMain := SourceBitmap.Canvas.Pixels[SrcColNo, SrcRowNo];
       DestPixel := SrcPixelMain;
      end;
     //Result.Canvas.Pixels[DstColNo, DstRowNo] := DestPixel;
     pResultScanLine := Result.ScanLine[DstRowNo];
     DestPixelRGB := TColorToTRGB(DestPixel);
     pResultScanLine[DstColNo*4] := DestPixelRGB.Red;
     pResultScanLine[DstColNo*4+1] := DestPixelRGB.Green;
     pResultScanLine[DstColNo*4+2] := DestPixelRGB.Blue
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/3 2004
//Instructionset(s): IA32

function ScaleDownDKCPas4(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
var
 SrcRowNo, DstRowNo, SrcColNo, DstColNo, SrcRowNoMax, SrcColNoMax, DstRowNoMax,
 DstColNoMax, UpperBorderRow, LowerBorderRow, LeftBorderCol, RigthBorderCol,
 SrcRow, SrcCol, NoOfSrcPixels, SumSrcPixelRGBRed, SumSrcPixelRGBBlue, SumSrcPixelRGBGreen : Cardinal;
 SrcPixelMain, DestPixel : TColor;
 SrcPixelRGB, AverageSrcPixelRGB, DestPixelRGB : TRGBColor;
 pScanLine, pResultScanLine : PByteArray;

begin
 if SourceBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if ScaleFactor < 1  then
  raise Exception.Create('ScaleFactor must be bigger than 1');
 Result := TBitmap.Create;
 Result.PixelFormat := pf32bit;
 SrcRowNoMax := SourceBitmap.Height;
 SrcColNoMax := SourceBitmap.Width;
 DstRowNoMax := Round(SrcRowNoMax / ScaleFactor);
 DstColNoMax := Round(SrcColNoMax / ScaleFactor);
 if DstRowNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 if DstColNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 Result.Height := DstRowNoMax;
 Result.Width := DstColNoMax;
 for DstRowNo := 0 to DstRowNoMax-1 do
  begin
   for DstColNo := 0 to DstColNoMax-1 do
    begin
     SrcColNo := Round(DstColNo * ScaleFactor);
     SrcRowNo := Round(DstRowNo * ScaleFactor);
     if SrcRowNo > SrcRowNoMax-1 then
      SrcRowNo := SrcRowNoMax-1;
     if SrcColNo > SrcColNoMax-1 then
      SrcColNo := SrcColNoMax-1;
     if (SrcRowNo > 1) and (SrcColNo > 1) and
        (SrcRowNo < SrcRowNoMax-2) and (SrcColNo < SrcColNoMax-2) then
      begin
       UpperBorderRow := SrcRowNo - Round(0.5 * ScaleFactor);
       LowerBorderRow := SrcRowNo + Round(0.5 * ScaleFactor);
       LeftBorderCol := SrcColNo - Round(0.5 * ScaleFactor);
       RigthBorderCol := SrcColNo + Round(0.5 * ScaleFactor);
       NoOfSrcPixels := 0;
       SumSrcPixelRGBRed := 0;
       SumSrcPixelRGBGreen := 0;
       SumSrcPixelRGBBlue := 0;
       for SrcRow := UpperBorderRow to LowerBorderRow do
        begin
         pScanLine := SourceBitmap.ScanLine[SrcRow];
         for SrcCol := LeftBorderCol to RigthBorderCol do
          begin
           Inc(NoOfSrcPixels);
           if SrcRow > SrcRowNoMax-1 then
            raise Exception.Create('SrcRow out of range');
           if SrcCol > SrcColNoMax-1 then
            raise Exception.Create('SrcCol out of range');
           SrcPixelRGB.Red := pScanLine[4*SrcCol];
           SrcPixelRGB.Green := pScanLine[4*SrcCol+1];
           SrcPixelRGB.Blue := pScanLine[4*SrcCol+2];
           SumSrcPixelRGBRed := SumSrcPixelRGBRed + SrcPixelRGB.Red;
           SumSrcPixelRGBGreen := SumSrcPixelRGBGreen + SrcPixelRGB.Green;
           SumSrcPixelRGBBlue := SumSrcPixelRGBBlue + SrcPixelRGB.Blue;
          end;
        end;
       AverageSrcPixelRGB.Red := SumSrcPixelRGBRed div NoOfSrcPixels;
       AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen div NoOfSrcPixels;
       AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue div NoOfSrcPixels;
       DestPixel := TRGBToTColor(AverageSrcPixelRGB);
      end
     else
      begin
       //SrcPixelMain := SourceBitmap.Canvas.Pixels[SrcColNo, SrcRowNo];
       pScanLine := SourceBitmap.ScanLine[SrcRowNo];
       SrcPixelRGB.Red := pScanLine[4*SrcColNo];
       SrcPixelRGB.Green := pScanLine[4*SrcColNo+1];
       SrcPixelRGB.Blue := pScanLine[4*SrcColNo+2];
       SrcPixelMain := TRGBToTColor(SrcPixelRGB);
       DestPixel := SrcPixelMain;
      end;
     pResultScanLine := Result.ScanLine[DstRowNo];
     DestPixelRGB := TColorToTRGB(DestPixel);
     pResultScanLine[DstColNo*4] := DestPixelRGB.Red;
     pResultScanLine[DstColNo*4+1] := DestPixelRGB.Green;
     pResultScanLine[DstColNo*4+2] := DestPixelRGB.Blue
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/3 2004
//Instructionset(s): IA32

function ScaleDownDKCPas5(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
var
 SrcRowNo, DstRowNo, SrcColNo, DstColNo, SrcRowNoMax, SrcColNoMax, DstRowNoMax,
 DstColNoMax, UpperBorderRow, LowerBorderRow, LeftBorderCol, RigthBorderCol,
 SrcRow, SrcCol, NoOfSrcPixels, SumSrcPixelRGBRed, SumSrcPixelRGBBlue, SumSrcPixelRGBGreen : Cardinal;
 SrcPixelRGB, AverageSrcPixelRGB : TRGBColor;
 pScanLine, pResultScanLine : PByteArray;

begin
 if SourceBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if ScaleFactor < 1  then
  raise Exception.Create('ScaleFactor must be bigger than 1');
 Result := TBitmap.Create;
 Result.PixelFormat := pf32bit;
 SrcRowNoMax := SourceBitmap.Height;
 SrcColNoMax := SourceBitmap.Width;
 DstRowNoMax := Round(SrcRowNoMax / ScaleFactor);
 DstColNoMax := Round(SrcColNoMax / ScaleFactor);
 if DstRowNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 if DstColNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 Result.Height := DstRowNoMax;
 Result.Width := DstColNoMax;
 for DstRowNo := 0 to DstRowNoMax-1 do
  begin
   pResultScanLine := Result.ScanLine[DstRowNo];
   for DstColNo := 0 to DstColNoMax-1 do
    begin
     SrcColNo := Round(DstColNo * ScaleFactor);
     SrcRowNo := Round(DstRowNo * ScaleFactor);
     if SrcRowNo > SrcRowNoMax-1 then
      SrcRowNo := SrcRowNoMax-1;
     if SrcColNo > SrcColNoMax-1 then
      SrcColNo := SrcColNoMax-1;
     if (SrcRowNo > 1) and (SrcColNo > 1) and
        (SrcRowNo < SrcRowNoMax-2) and (SrcColNo < SrcColNoMax-2) then
      begin
       UpperBorderRow := SrcRowNo - Round(0.5 * ScaleFactor);
       LowerBorderRow := SrcRowNo + Round(0.5 * ScaleFactor);
       LeftBorderCol := SrcColNo - Round(0.5 * ScaleFactor);
       RigthBorderCol := SrcColNo + Round(0.5 * ScaleFactor);
       NoOfSrcPixels := 0;
       SumSrcPixelRGBRed := 0;
       SumSrcPixelRGBGreen := 0;
       SumSrcPixelRGBBlue := 0;
       for SrcRow := UpperBorderRow to LowerBorderRow do
        begin
         pScanLine := SourceBitmap.ScanLine[SrcRow];
         for SrcCol := LeftBorderCol to RigthBorderCol do
          begin
           Inc(NoOfSrcPixels);
           SrcPixelRGB.Red := pScanLine[4*SrcCol];
           SrcPixelRGB.Green := pScanLine[4*SrcCol+1];
           SrcPixelRGB.Blue := pScanLine[4*SrcCol+2];
           SumSrcPixelRGBRed := SumSrcPixelRGBRed + SrcPixelRGB.Red;
           SumSrcPixelRGBGreen := SumSrcPixelRGBGreen + SrcPixelRGB.Green;
           SumSrcPixelRGBBlue := SumSrcPixelRGBBlue + SrcPixelRGB.Blue;
          end;
        end;
       AverageSrcPixelRGB.Red := SumSrcPixelRGBRed div NoOfSrcPixels;
       AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen div NoOfSrcPixels;
       AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue div NoOfSrcPixels;
       pResultScanLine[DstColNo*4] := AverageSrcPixelRGB.Red;
       pResultScanLine[DstColNo*4+1] := AverageSrcPixelRGB.Green;
       pResultScanLine[DstColNo*4+2] := AverageSrcPixelRGB.Blue
      end
     else
      begin
       pScanLine := SourceBitmap.ScanLine[SrcRowNo];
       SrcPixelRGB.Red := pScanLine[4*SrcColNo];
       SrcPixelRGB.Green := pScanLine[4*SrcColNo+1];
       SrcPixelRGB.Blue := pScanLine[4*SrcColNo+2];
       pResultScanLine[DstColNo*4] := SrcPixelRGB.Red;
       pResultScanLine[DstColNo*4+1] := SrcPixelRGB.Green;
       pResultScanLine[DstColNo*4+2] := SrcPixelRGB.Blue
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/3 2004
//Instructionset(s): IA32

function ScaleDownDKCPas6(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
var
 SrcRowNo, DstRowNo, SrcColNo, DstColNo, SrcRowNoMax, SrcColNoMax, DstRowNoMax,
 DstColNoMax, UpperBorderRow, LowerBorderRow, LeftBorderCol, RigthBorderCol,
 SrcRow, SrcCol, NoOfSrcPixels, SumSrcPixelRGBRed, SumSrcPixelRGBBlue, SumSrcPixelRGBGreen : Cardinal;
 SrcPixelRGB, AverageSrcPixelRGB : TRGBColor;
 pScanLine, pResultScanLine : PByteArray;

begin
 if SourceBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if ScaleFactor < 1  then
  raise Exception.Create('ScaleFactor must be bigger than 1');
 Result := TBitmap.Create;
 Result.PixelFormat := pf32bit;
 SrcRowNoMax := SourceBitmap.Height;
 SrcColNoMax := SourceBitmap.Width;
 DstRowNoMax := Round(SrcRowNoMax / ScaleFactor);
 DstColNoMax := Round(SrcColNoMax / ScaleFactor);
 if DstRowNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 if DstColNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 Result.Height := DstRowNoMax;
 Result.Width := DstColNoMax;
 for DstRowNo := 0 to DstRowNoMax-1 do
  begin
   pResultScanLine := Result.ScanLine[DstRowNo];
   SrcRowNo := Round(DstRowNo * ScaleFactor);
   if SrcRowNo > SrcRowNoMax-1 then
    SrcRowNo := SrcRowNoMax-1;
   UpperBorderRow := SrcRowNo - Round(0.5 * ScaleFactor);
   LowerBorderRow := SrcRowNo + Round(0.5 * ScaleFactor);
   for DstColNo := 0 to DstColNoMax-1 do
    begin
     SrcColNo := Round(DstColNo * ScaleFactor);
     if SrcColNo > SrcColNoMax-1 then
      SrcColNo := SrcColNoMax-1;
     if (SrcRowNo > 1) and (SrcColNo > 1) and
        (SrcRowNo < SrcRowNoMax-2) and (SrcColNo < SrcColNoMax-2) then
      begin
       LeftBorderCol := SrcColNo - Round(0.5 * ScaleFactor);
       RigthBorderCol := SrcColNo + Round(0.5 * ScaleFactor);
       NoOfSrcPixels := 0;
       SumSrcPixelRGBRed := 0;
       SumSrcPixelRGBGreen := 0;
       SumSrcPixelRGBBlue := 0;
       for SrcRow := UpperBorderRow to LowerBorderRow do
        begin
         pScanLine := SourceBitmap.ScanLine[SrcRow];
         for SrcCol := LeftBorderCol to RigthBorderCol do
          begin
           Inc(NoOfSrcPixels);
           SrcPixelRGB.Red := pScanLine[4*SrcCol];
           SrcPixelRGB.Green := pScanLine[4*SrcCol+1];
           SrcPixelRGB.Blue := pScanLine[4*SrcCol+2];
           SumSrcPixelRGBRed := SumSrcPixelRGBRed + SrcPixelRGB.Red;
           SumSrcPixelRGBGreen := SumSrcPixelRGBGreen + SrcPixelRGB.Green;
           SumSrcPixelRGBBlue := SumSrcPixelRGBBlue + SrcPixelRGB.Blue;
          end;
        end;
       if NoOfSrcPixels = 2 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 1;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 1;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 1;
        end
       else if NoOfSrcPixels = 4 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 2;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 2;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 2;
        end
       else if NoOfSrcPixels = 8 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 3;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 3;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 3;
        end
       else
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed div NoOfSrcPixels;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen div NoOfSrcPixels;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue div NoOfSrcPixels;
        end;
       pResultScanLine[DstColNo*4] := AverageSrcPixelRGB.Red;
       pResultScanLine[DstColNo*4+1] := AverageSrcPixelRGB.Green;
       pResultScanLine[DstColNo*4+2] := AverageSrcPixelRGB.Blue
      end
     else
      begin
       pScanLine := SourceBitmap.ScanLine[SrcRowNo];
       SrcPixelRGB.Red := pScanLine[4*SrcColNo];
       SrcPixelRGB.Green := pScanLine[4*SrcColNo+1];
       SrcPixelRGB.Blue := pScanLine[4*SrcColNo+2];
       pResultScanLine[DstColNo*4] := SrcPixelRGB.Red;
       pResultScanLine[DstColNo*4+1] := SrcPixelRGB.Green;
       pResultScanLine[DstColNo*4+2] := SrcPixelRGB.Blue
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/3 2004
//Instructionset(s): IA32

function ScaleDownDKCPas7(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
var
 SrcRowNo, DstRowNo, SrcColNo, DstColNo, SrcRowNoMax, SrcColNoMax, DstRowNoMax,
 DstColNoMax, UpperBorderRow, LowerBorderRow, LeftBorderCol, RigthBorderCol,
 SrcRow, SrcCol, NoOfSrcPixels, SumSrcPixelRGBRed, SumSrcPixelRGBBlue,
 SumSrcPixelRGBGreen, SrcPixel, AverageSrcPixel : Cardinal;
 DestPixel : TColor;
 SrcPixelRGB, AverageSrcPixelRGB, DestPixelRGB : TRGBColor;
 pScanLine : PByteArray;
 pScanLineBuffer : array of PByteArray;
 pResultScanLine : pIntegerArray;

begin
 if SourceBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if ScaleFactor < 1  then
  raise Exception.Create('ScaleFactor must be bigger than 1');
 Result := TBitmap.Create;
 Result.PixelFormat := pf32bit;
 SrcRowNoMax := SourceBitmap.Height;
 SrcColNoMax := SourceBitmap.Width;
 DstRowNoMax := Round(SrcRowNoMax / ScaleFactor);
 DstColNoMax := Round(SrcColNoMax / ScaleFactor);
 if DstRowNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 if DstColNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 Result.Height := DstRowNoMax;
 Result.Width := DstColNoMax;
 for DstRowNo := 0 to DstRowNoMax-1 do
  begin
   pResultScanLine := Result.ScanLine[DstRowNo];
   SrcRowNo := Round(DstRowNo * ScaleFactor);
   if SrcRowNo > SrcRowNoMax-1 then
    SrcRowNo := SrcRowNoMax-1;
   UpperBorderRow := SrcRowNo - Round(0.5 * ScaleFactor);
   LowerBorderRow := SrcRowNo + Round(0.5 * ScaleFactor);
   for DstColNo := 0 to DstColNoMax-1 do
    begin
     SrcColNo := Round(DstColNo * ScaleFactor);
     if SrcColNo > SrcColNoMax-1 then
      SrcColNo := SrcColNoMax-1;
     if (SrcRowNo > 1) and (SrcColNo > 1) and
        (SrcRowNo < SrcRowNoMax-2) and (SrcColNo < SrcColNoMax-2) then
      begin
       LeftBorderCol := SrcColNo - Round(0.5 * ScaleFactor);
       RigthBorderCol := SrcColNo + Round(0.5 * ScaleFactor);
       SetLength(pScanLineBuffer, LowerBorderRow-UpperBorderRow+1);
       for SrcRow := UpperBorderRow to LowerBorderRow do
        begin
         pScanLine := SourceBitmap.ScanLine[SrcRow];
         pScanLineBuffer[SrcRow - UpperBorderRow] := pScanLine;
        end;
       NoOfSrcPixels := 0;
       SumSrcPixelRGBRed := 0;
       SumSrcPixelRGBGreen := 0;
       SumSrcPixelRGBBlue := 0;
       for SrcRow := UpperBorderRow to LowerBorderRow do
        begin
         pScanLine := pScanLineBuffer[SrcRow - UpperBorderRow];
         for SrcCol := LeftBorderCol to RigthBorderCol do
          begin
           Inc(NoOfSrcPixels);
           SrcPixelRGB.Red := pScanLine[4*SrcCol];
           SrcPixelRGB.Green := pScanLine[4*SrcCol+1];
           SrcPixelRGB.Blue := pScanLine[4*SrcCol+2];
           SumSrcPixelRGBRed := SumSrcPixelRGBRed + SrcPixelRGB.Red;
           SumSrcPixelRGBGreen := SumSrcPixelRGBGreen + SrcPixelRGB.Green;
           SumSrcPixelRGBBlue := SumSrcPixelRGBBlue + SrcPixelRGB.Blue;
          end;
        end;
       if NoOfSrcPixels = 2 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 1;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 1;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 1;
        end
       else if NoOfSrcPixels = 4 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 2;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 2;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 2;
        end
       else if NoOfSrcPixels = 8 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 3;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 3;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 3;
        end
       else
        begin
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBRed div NoOfSrcPixels;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen div NoOfSrcPixels;
         AverageSrcPixelRGB.Red := SumSrcPixelRGBBlue div NoOfSrcPixels;
        end;
       //pResultScanLine[DstColNo*4] := AverageSrcPixelRGB.Red;
       //pResultScanLine[DstColNo*4+1] := AverageSrcPixelRGB.Green;
       //pResultScanLine[DstColNo*4+2] := AverageSrcPixelRGB.Blue
       AverageSrcPixel := TRGBToTColor(AverageSrcPixelRGB);
       pResultScanLine[DstColNo] := AverageSrcPixel;
      end
     else
      begin
       pScanLine := SourceBitmap.ScanLine[SrcRowNo];
       SrcPixelRGB.Blue := pScanLine[4*SrcColNo];
       SrcPixelRGB.Green := pScanLine[4*SrcColNo+1];
       SrcPixelRGB.Red := pScanLine[4*SrcColNo+2];
       SrcPixel := TRGBToTColor(SrcPixelRGB);
       pResultScanLine[DstColNo] := SrcPixel;
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/3 2004
//Instructionset(s): IA32

function ScaleDownDKCPas8(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
var
 SrcRowNo, DstRowNo, SrcColNo, DstColNo, SrcRowNoMax, SrcColNoMax, DstRowNoMax,
 DstColNoMax, UpperBorderRow, LowerBorderRow, LeftBorderCol, RigthBorderCol,
 SrcRow, SrcCol, NoOfSrcPixels, SumSrcPixelRGBRed, SumSrcPixelRGBBlue,
 SumSrcPixelRGBGreen, SrcPixel : Cardinal;
 SrcPixelRGB, AverageSrcPixelRGB : TRGBColor;
 pByteSrcScanLine, pByteResultScanLine, pByteSrcScanLinex, pByteScanLineRef : PByteArray;
 pIntegerSrcScanLine, pIntegerResultScanLine : pIntegerArray;
 ScanLineSize : Integer;

begin
 if SourceBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if ScaleFactor < 1  then
  raise Exception.Create('ScaleFactor must be bigger than 1');
 Result := TBitmap.Create;
 Result.PixelFormat := pf32bit;
 SrcRowNoMax := SourceBitmap.Height;
 SrcColNoMax := SourceBitmap.Width;
 DstRowNoMax := Round(SrcRowNoMax / ScaleFactor);
 DstColNoMax := Round(SrcColNoMax / ScaleFactor);
 if DstRowNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 if DstColNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 Result.Height := DstRowNoMax;
 Result.Width := DstColNoMax;
 for DstRowNo := 0 to DstRowNoMax-1 do
  begin
   pByteResultScanLine := Result.ScanLine[DstRowNo];
   pIntegerResultScanLine := Result.ScanLine[DstRowNo];
   SrcRowNo := Round(DstRowNo * ScaleFactor);
   if SrcRowNo > SrcRowNoMax-1 then
    SrcRowNo := SrcRowNoMax-1;
   UpperBorderRow := SrcRowNo - Round(0.5 * ScaleFactor);
   LowerBorderRow := SrcRowNo + Round(0.5 * ScaleFactor);
   for DstColNo := 0 to DstColNoMax-1 do
    begin
     SrcColNo := Round(DstColNo * ScaleFactor);
     if SrcColNo > SrcColNoMax-1 then
      SrcColNo := SrcColNoMax-1;
     if (SrcRowNo > 1) and (SrcColNo > 1) and
        (SrcRowNo < SrcRowNoMax-2) and (SrcColNo < SrcColNoMax-2) then
      begin
       LeftBorderCol := SrcColNo - Round(0.5 * ScaleFactor);
       RigthBorderCol := SrcColNo + Round(0.5 * ScaleFactor);
       NoOfSrcPixels := 0;
       SumSrcPixelRGBRed := 0;
       SumSrcPixelRGBGreen := 0;
       SumSrcPixelRGBBlue := 0;
       pByteSrcScanLine := SourceBitmap.ScanLine[UpperBorderRow];
       pByteSrcScanLinex := SourceBitmap.ScanLine[UpperBorderRow+1];
       ScanLineSize := Integer(pByteSrcScanLinex) - Integer(pByteSrcScanLine);
       for SrcRow := UpperBorderRow to LowerBorderRow do
        begin
         for SrcCol := LeftBorderCol to RigthBorderCol do
          begin
           Inc(NoOfSrcPixels);
           SrcPixelRGB.Red := pByteSrcScanLine[4*SrcCol];
           SrcPixelRGB.Green := pByteSrcScanLine[4*SrcCol+1];
           SrcPixelRGB.Blue := pByteSrcScanLine[4*SrcCol+2];
           SumSrcPixelRGBRed := SumSrcPixelRGBRed + SrcPixelRGB.Red;
           SumSrcPixelRGBGreen := SumSrcPixelRGBGreen + SrcPixelRGB.Green;
           SumSrcPixelRGBBlue := SumSrcPixelRGBBlue + SrcPixelRGB.Blue;
          end;
         pByteSrcScanLine := PByteArray(Integer(pByteSrcScanLine) + ScanLineSize);
        end;
       if NoOfSrcPixels = 1 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue;
        end
       else if NoOfSrcPixels = 2 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 1;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 1;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 1;
        end
       else if NoOfSrcPixels = 4 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 2;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 2;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 2;
        end
       else if NoOfSrcPixels = 8 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 3;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 3;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 3;
        end
       else
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed div NoOfSrcPixels;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen div NoOfSrcPixels;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue div NoOfSrcPixels;
        end;
       pByteResultScanLine[DstColNo*4] := AverageSrcPixelRGB.Red;
       pByteResultScanLine[DstColNo*4+1] := AverageSrcPixelRGB.Green;
       pByteResultScanLine[DstColNo*4+2] := AverageSrcPixelRGB.Blue
      end
     else
      begin
       pIntegerSrcScanLine := SourceBitmap.ScanLine[SrcRowNo];
       SrcPixel := pIntegerSrcScanLine[SrcColNo];
       pIntegerResultScanLine[DstColNo] := SrcPixel;
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/3 2004
//Instructionset(s): IA32

function ScaleDownDKCPas9(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
var
 SrcRowNo, DstRowNo, SrcColNo, DstColNo, SrcRowNoMax, SrcColNoMax, DstRowNoMax,
 DstColNoMax, UpperBorderRow, LowerBorderRow, LeftBorderCol, RigthBorderCol,
 SrcRow, SrcCol, NoOfSrcPixels, SumSrcPixelRGBRed, SumSrcPixelRGBBlue,
 SumSrcPixelRGBGreen, SrcPixel, RoundedHalfScaleFactor : Cardinal;
 SrcPixelRGB, AverageSrcPixelRGB : TRGBColor;
 pByteSrcScanLine, pByteResultScanLine, pByteSrcScanLinex, pByteScanLineRef : PByteArray;
 pIntegerSrcScanLine, pIntegerResultScanLine : pIntegerArray;
 ScanLineSize : Integer;

begin
 if SourceBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if ScaleFactor < 1  then
  raise Exception.Create('ScaleFactor must be bigger than 1');
 Result := TBitmap.Create;
 Result.PixelFormat := pf32bit;
 SrcRowNoMax := SourceBitmap.Height;
 SrcColNoMax := SourceBitmap.Width;
 DstRowNoMax := Round(SrcRowNoMax / ScaleFactor);
 DstColNoMax := Round(SrcColNoMax / ScaleFactor);
 if DstRowNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 if DstColNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 RoundedHalfScaleFactor := Round(0.5 * ScaleFactor);
 Result.Height := DstRowNoMax;
 Result.Width := DstColNoMax;
 for DstRowNo := 0 to DstRowNoMax-1 do
  begin
   pByteResultScanLine := Result.ScanLine[DstRowNo];
   pIntegerResultScanLine := Result.ScanLine[DstRowNo];
   SrcRowNo := Round(DstRowNo * ScaleFactor);
   if SrcRowNo > SrcRowNoMax-1 then
    SrcRowNo := SrcRowNoMax-1;
   UpperBorderRow := SrcRowNo - RoundedHalfScaleFactor;
   LowerBorderRow := SrcRowNo + RoundedHalfScaleFactor;
   for DstColNo := 0 to DstColNoMax-1 do
    begin
     SrcColNo := Round(DstColNo * ScaleFactor);
     if SrcColNo > SrcColNoMax-1 then
      SrcColNo := SrcColNoMax-1;
     if (SrcRowNo > 1) and (SrcColNo > 1) and
        (SrcRowNo < SrcRowNoMax-2) and (SrcColNo < SrcColNoMax-2) then
      begin
       LeftBorderCol := SrcColNo - RoundedHalfScaleFactor;
       RigthBorderCol := SrcColNo + RoundedHalfScaleFactor;
       NoOfSrcPixels := 0;
       SumSrcPixelRGBRed := 0;
       SumSrcPixelRGBGreen := 0;
       SumSrcPixelRGBBlue := 0;
       pByteSrcScanLine := SourceBitmap.ScanLine[UpperBorderRow];
       pByteSrcScanLinex := SourceBitmap.ScanLine[UpperBorderRow+1];
       ScanLineSize := Integer(pByteSrcScanLinex) - Integer(pByteSrcScanLine);
       for SrcRow := UpperBorderRow to LowerBorderRow do
        begin
         for SrcCol := LeftBorderCol to RigthBorderCol do
          begin
           Inc(NoOfSrcPixels);
           SrcPixelRGB.Red := pByteSrcScanLine[4*SrcCol];
           SrcPixelRGB.Green := pByteSrcScanLine[4*SrcCol+1];
           SrcPixelRGB.Blue := pByteSrcScanLine[4*SrcCol+2];
           SumSrcPixelRGBRed := SumSrcPixelRGBRed + SrcPixelRGB.Red;
           SumSrcPixelRGBGreen := SumSrcPixelRGBGreen + SrcPixelRGB.Green;
           SumSrcPixelRGBBlue := SumSrcPixelRGBBlue + SrcPixelRGB.Blue;
          end;
         pByteSrcScanLine := PByteArray(Integer(pByteSrcScanLine) + ScanLineSize);
        end;
       if NoOfSrcPixels = 1 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue;
        end
       else if NoOfSrcPixels = 2 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 1;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 1;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 1;
        end
       else if NoOfSrcPixels = 4 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 2;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 2;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 2;
        end
       else if NoOfSrcPixels = 8 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 3;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 3;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 3;
        end
       else
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed div NoOfSrcPixels;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen div NoOfSrcPixels;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue div NoOfSrcPixels;
        end;
       pByteResultScanLine[DstColNo*4] := AverageSrcPixelRGB.Red;
       pByteResultScanLine[DstColNo*4+1] := AverageSrcPixelRGB.Green;
       pByteResultScanLine[DstColNo*4+2] := AverageSrcPixelRGB.Blue
      end
     else
      begin
       pIntegerSrcScanLine := SourceBitmap.ScanLine[SrcRowNo];
       SrcPixel := pIntegerSrcScanLine[SrcColNo];
       pIntegerResultScanLine[DstColNo] := SrcPixel;
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/3 2004
//Instructionset(s): IA32

function ScaleDownDKCPas10(const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;
var
 SrcRowNo, DstRowNo, SrcColNo, DstColNo, SrcRowNoMax, SrcColNoMax, DstRowNoMax,
 DstColNoMax, UpperBorderRow, LowerBorderRow, LeftBorderCol, RigthBorderCol,
 SrcRow, SrcCol, NoOfSrcPixels, SumSrcPixelRGBRed, SumSrcPixelRGBBlue,
 SumSrcPixelRGBGreen, SrcPixel, RoundedHalfScaleFactor, AverageSrcPixel : Cardinal;
 SrcPixelRGB, AverageSrcPixelRGB : TRGBColor;
 pByteSrcScanLine, pByteResultScanLine, pByteSrcScanLinex, pByteScanLineRef : PByteArray;
 pIntegerSrcScanLine, pIntegerResultScanLine : pIntegerArray;
 ScanLineSize : Integer;
 Temp : Byte;
begin
 if SourceBitmap.PixelFormat <> pf32bit then
  raise Exception.Create('Only pf32bit PixelFormat supported');
 if ScaleFactor < 1  then
  raise Exception.Create('ScaleFactor must be bigger than 1');
 Result := TBitmap.Create;
 Result.PixelFormat := pf32bit;
 SrcRowNoMax := SourceBitmap.Height;
 SrcColNoMax := SourceBitmap.Width;
 DstRowNoMax := Round(SrcRowNoMax / ScaleFactor);
 DstColNoMax := Round(SrcColNoMax / ScaleFactor);
 if DstRowNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 if DstColNoMax < 1 then
  raise Exception.Create('Destination Bitmap to small');
 RoundedHalfScaleFactor := Round(0.5 * ScaleFactor);
 Result.Height := DstRowNoMax;
 Result.Width := DstColNoMax;
 for DstRowNo := 0 to DstRowNoMax-1 do
  begin
   pByteResultScanLine := Result.ScanLine[DstRowNo];
   pIntegerResultScanLine := Result.ScanLine[DstRowNo];
   SrcRowNo := Round(DstRowNo * ScaleFactor);
   if SrcRowNo > SrcRowNoMax-1 then
    SrcRowNo := SrcRowNoMax-1;
   UpperBorderRow := SrcRowNo - RoundedHalfScaleFactor;
   LowerBorderRow := SrcRowNo + RoundedHalfScaleFactor;
   for DstColNo := 0 to DstColNoMax-1 do
    begin
     SrcColNo := Round(DstColNo * ScaleFactor);
     if SrcColNo > SrcColNoMax-1 then
      SrcColNo := SrcColNoMax-1;
     if (SrcRowNo > 1) and (SrcColNo > 1) and
        (SrcRowNo < SrcRowNoMax-2) and (SrcColNo < SrcColNoMax-2) then
      begin
       LeftBorderCol := SrcColNo - RoundedHalfScaleFactor;
       RigthBorderCol := SrcColNo + RoundedHalfScaleFactor;
       NoOfSrcPixels := 0;
       SumSrcPixelRGBRed := 0;
       SumSrcPixelRGBGreen := 0;
       SumSrcPixelRGBBlue := 0;
       pByteSrcScanLine := SourceBitmap.ScanLine[UpperBorderRow];
       pByteSrcScanLinex := SourceBitmap.ScanLine[UpperBorderRow+1];
       ScanLineSize := Integer(pByteSrcScanLinex) - Integer(pByteSrcScanLine);
       for SrcRow := UpperBorderRow to LowerBorderRow do
        begin
         for SrcCol := LeftBorderCol to RigthBorderCol do
          begin
           Inc(NoOfSrcPixels);
           //Swap byte order
           SrcPixelRGB.Blue := pByteSrcScanLine[4*SrcCol];
           SrcPixelRGB.Green := pByteSrcScanLine[4*SrcCol+1];
           SrcPixelRGB.Red := pByteSrcScanLine[4*SrcCol+2];
           SumSrcPixelRGBRed := SumSrcPixelRGBRed + SrcPixelRGB.Red;
           SumSrcPixelRGBGreen := SumSrcPixelRGBGreen + SrcPixelRGB.Green;
           SumSrcPixelRGBBlue := SumSrcPixelRGBBlue + SrcPixelRGB.Blue;
          end;
         pByteSrcScanLine := PByteArray(Integer(pByteSrcScanLine) + ScanLineSize);
        end;
       if NoOfSrcPixels = 1 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue;
        end
       else if NoOfSrcPixels = 2 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 1;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 1;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 1;
        end
       else if NoOfSrcPixels = 4 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 2;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 2;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 2;
        end
       else if NoOfSrcPixels = 8 then
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed shr 3;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen shr 3;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue shr 3;
        end
       else
        begin
         AverageSrcPixelRGB.Red := SumSrcPixelRGBRed div NoOfSrcPixels;
         AverageSrcPixelRGB.Green := SumSrcPixelRGBGreen div NoOfSrcPixels;
         AverageSrcPixelRGB.Blue := SumSrcPixelRGBBlue div NoOfSrcPixels;
        end;
       AverageSrcPixel := TRGBToTColor(AverageSrcPixelRGB);
       pIntegerResultScanLine[DstColNo] := AverageSrcPixel;
      end
     else
      begin
       pIntegerSrcScanLine := SourceBitmap.ScanLine[SrcRowNo];
       SrcPixel := pIntegerSrcScanLine[SrcColNo];
       pIntegerResultScanLine[DstColNo] := SrcPixel;
      end;
    end;
  end;
end;

end.
