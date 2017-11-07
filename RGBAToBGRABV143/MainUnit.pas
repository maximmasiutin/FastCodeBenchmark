unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'RGBAToBGRA';

type

  TRGB32Array = array[0..3] of Byte;
  PRGB32Array = ^TRGB32Array;

  TRGBColor = record
   Red, Green, Blue : Byte;
  end;

  TMainForm = class(TForm)
    ValidateButton: TButton;
    ValidationEdit: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    ReportRichEdit: TRichEdit;
    BenchmarkButton: TButton;
    RuntimeEdit: TEdit;
    FunctionSelectionRadioGroup: TRadioGroup;
    BenchmarkAllButton: TButton;
    Label2: TLabel;
    Bench1Edit: TEdit;
    Bench2Edit: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    ValidateAllButton: TButton;
    ClearButton: TButton;
    MaxSpreadBenchPercentageEdit: TEdit;
    FunctionNameEdit: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    SaveReportSpeedButton: TSpeedButton;
    PrintReportSpeedButton: TSpeedButton;
    SaveDialog: TSaveDialog;
    BenchTestButton: TButton;
    AlignFunctionName1Edit: TEdit;
    AlignFunctionName2Edit: TEdit;
    AlignMaxSpreadBenchPercentageEdit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SpreadTestButton: TButton;
    CleanResultsButton: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure SaveReportSpeedButtonClick(Sender: TObject);
    procedure PrintReportSpeedButtonClick(Sender: TObject);
    procedure BenchTestButtonClick(Sender: TObject);
    procedure SpreadTestButtonClick(Sender: TObject);
    procedure MaxSpreadBenchPercentageEditClick(Sender: TObject);
    procedure CleanResultsButtonClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    procedure ClearAllEditBoxes;
    procedure CleanResultsRichEdit;
    procedure SortRichEdit;
    procedure BenchmarkTest;
    procedure AlignmentTest;
    function SubBenchmark1 : Double;
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

function TColorToTRGB(const Color:  TColor):  TRGBColor;
function TRGBToTColor(const Color:  TRGBColor):  TColor;

var
 MainForm: TMainForm;

implementation

uses
 SystemInfoUnit, FastcodeCPUID, RGBToBGRDKCUnit, RGBToBGRNHUnit, RGBToBGR_LBG_Unit, RGBToBGR_JOH_Unit;

{$R *.dfm}

const
 NOOFRUNS : Cardinal = 25;
 SUBBENCH1SCALE : Double = 300;
 SUBBENCH1ARRAYSIZE : Cardinal = 30;
 NOOFRERUNS : Cardinal = 4;

type
 TRGBToBGRFunction = procedure (SrcDestBitmap : TBitmap);

var
 RGBToBGRFunction : TRGBToBGRFunction;

function TColorToTRGB(const Color:  TColor):  TRGBColor;
begin
 Result.Red := Byte((Color and $00FF0000) shr 16);
 Result.Green   := Byte((Color and $0000FF00) shr 8);
 Result.Blue := Byte(Color and $000000FF);
end;

function TRGBToTColor(const Color:  TRGBColor):  TColor;
begin
 Result := 256*256*Color.Red + 256*Color.Green + Color.Blue;
end;

function BitmapsDifference(const BitMap1, BitMap2 : TBitMap) : Cardinal;
var
 ColNo, RowNo, ImageHeight, ImageWidth, SumAbsoluteDifference : Cardinal;
 Image1Height, Image1Width, Image2Height, Image2Width : Cardinal;
 AbsoluteRGBDifference : TRGBColor;
 TotalAbsoluteDifference, ColNoX : Cardinal;
 RGBDifferenceRed, RGBDifferenceBlue, RGBDifferenceGreen : Integer;
 pScanline1, pScanline2 : PByteArray;
 APixel1, APixel2, BPixel1, BPixel2, GPixel1, GPixel2, RPixel1, RPixel2 : Byte;
 Pixel1, Pixel2 : TColor;
 RGBPixel1, RGBPixel2 : TRGBColor;

begin
  Image1Height := BitMap1.Height;
  Image1Width := BitMap1.Width;
  Image2Height := BitMap2.Height;
  Image2Width := BitMap2.Width;
  //Take smallest picture Height
  if Image1Height < Image2Height then
   ImageHeight := Image1Height
  else
   ImageHeight := Image2Height;
  //Take smallest picture
  if Image1Width < Image2Width then
   ImageWidth := Image1Width
  else
   ImageWidth := Image2Width;
  SumAbsoluteDifference := 0;
  if ((ImageWidth <> 0) and (ImageHeight <> 0)) then
   begin
    if ((BitMap1.PixelFormat = pf32bit) and
        (BitMap2.PixelFormat = pf32bit)) then
     begin
      for RowNo := 0 to ImageHeight-1 do
       begin
        pScanline1 := BitMap1.ScanLine[RowNo];
        pScanline2 := BitMap2.ScanLine[RowNo];
        for ColNo := 0 to ImageWidth - 1 do
         begin
          ColNoX := 4 * ColNo;
          APixel1 := pScanline1[ColNoX+3];
          APixel2 := pScanline2[ColNoX+3];
          if APixel1 <> APixel2 then
           raise Exception.Create('Alpha value modified');
          BPixel1 := pScanline1[ColNoX];
          BPixel2 := pScanline2[ColNoX];
          GPixel1 := pScanline1[ColNoX+1];
          GPixel2 := pScanline2[ColNoX+1];
          RPixel1 := pScanline1[ColNoX+2];
          RPixel2 := pScanline2[ColNoX+2];
          RGBDifferenceRed := RPixel2 - RPixel1;
          RGBDifferenceGreen := GPixel2 - GPixel1;
          RGBDifferenceBlue := BPixel2 - BPixel1;
          AbsoluteRGBDifference.Red := Abs(RGBDifferenceRed);
          AbsoluteRGBDifference.Green := Abs(RGBDifferenceGreen);
          AbsoluteRGBDifference.Blue := Abs(RGBDifferenceBlue);
          TotalAbsoluteDifference := AbsoluteRGBDifference.Red
                                   + AbsoluteRGBDifference.Green
                                   + AbsoluteRGBDifference.Blue;
          SumAbsoluteDifference := SumAbsoluteDifference + TotalAbsoluteDifference;
         end;
       end;
     end
    else if ((BitMap1.PixelFormat = pf24bit) and
             (BitMap2.PixelFormat = pf24bit)) then
     begin
      for RowNo := 0 to ImageHeight-1 do
       begin
        pScanline1 := BitMap1.ScanLine[RowNo];
        pScanline2 := BitMap2.ScanLine[RowNo];
        for ColNo := 0 to ImageWidth - 1 do
         begin
          ColNoX := 3 * ColNo;
          BPixel1 := pScanline1[ColNoX];
          BPixel2 := pScanline2[ColNoX];
          GPixel1 := pScanline1[ColNoX+1];
          GPixel2 := pScanline2[ColNoX+1];
          RPixel1 := pScanline1[ColNoX+2];
          RPixel2 := pScanline2[ColNoX+2];
          RGBDifferenceRed := RPixel2 - RPixel1;
          RGBDifferenceGreen := GPixel2 - GPixel1;
          RGBDifferenceBlue := BPixel2 - BPixel1;
          AbsoluteRGBDifference.Red := Abs(RGBDifferenceRed);
          AbsoluteRGBDifference.Green := Abs(RGBDifferenceGreen);
          AbsoluteRGBDifference.Blue := Abs(RGBDifferenceBlue);
          TotalAbsoluteDifference := AbsoluteRGBDifference.Red
                                   + AbsoluteRGBDifference.Green
                                   + AbsoluteRGBDifference.Blue;
          SumAbsoluteDifference := SumAbsoluteDifference + TotalAbsoluteDifference;
         end;
       end;
     end
    else
     begin
      for RowNo := 0 to ImageWidth-1 do
       begin
        for ColNo := 0 to ImageHeight-1 do
         begin
          Pixel1 := BitMap1.Canvas.Pixels[RowNo, ColNo];
          Pixel2 := BitMap2.Canvas.Pixels[RowNo, ColNo];
          RGBPixel1 := TColorToTRGB(Pixel1);
          RGBPixel2 := TColorToTRGB(Pixel2);
          RGBDifferenceRed := RGBPixel2.Red - RGBPixel1.Red;
          RGBDifferenceGreen := RGBPixel2.Green - RGBPixel1.Green;
          RGBDifferenceBlue := RGBPixel2.Blue - RGBPixel1.Blue;
          AbsoluteRGBDifference.Red := Abs(RGBDifferenceRed);
          AbsoluteRGBDifference.Green := Abs(RGBDifferenceGreen);
          AbsoluteRGBDifference.Blue := Abs(RGBDifferenceBlue);
          TotalAbsoluteDifference := AbsoluteRGBDifference.Red
                                   + AbsoluteRGBDifference.Green
                                   + AbsoluteRGBDifference.Blue;
          SumAbsoluteDifference := SumAbsoluteDifference + TotalAbsoluteDifference;
         end;
       end;
     end;
   end;
  Result := SumAbsoluteDifference;
end;

procedure TMainForm.ClearAllEditBoxes;
var
 ComponentInx : Integer;

begin
 for ComponentInx := 0 to ComponentCount-1 do
  begin
   if Components[ComponentInx] is TEdit then
    with Components[ComponentInx] as TEdit do
     Text := '';
  end;
end;

procedure TMainForm.SortRichEdit;
var
 I2, I3, LineNo, X1, X2 : Integer;
 S1, S2, Bench1String, Bench2String : AnsiString;
 Bench1, Bench2 : Double;
 Swapped : Boolean;
 C1, C2 : Char;

begin
 repeat
  Swapped := False;
  for LineNo := 0 to ReportRichEdit.Lines.Count-2 do
   begin
    S1 := ReportRichEdit.Lines[LineNo];
    S2 := ReportRichEdit.Lines[LineNo+1];
    I2 := Length(S1);
    repeat
     C1 := S1[I2];
     Dec(I2);
    until(C1 = #9);
    X1 := I2+2;
    I3 := Length(S2);
    repeat
     C2 := S2[I3];
     Dec(I3);
    until(C2 = #9);
    X2 := I3+2;
    Bench1String := Copy(S1, X1, Length(S1));
    Bench2String := Copy(S2, X2, Length(S2));
    Bench1 := StrToFloat(Bench1String);
    Bench2 := StrToFloat(Bench2String);
    if Bench2 < Bench1 then
     begin
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
   end;
 until(not Swapped);
end;

function CharPos(Chr : Char; const Str : AnsiString) : Integer;
var
 StrLenght, I : Integer;

begin
 StrLenght := Length(Str);
 if StrLenght > 0 then
  begin
   I := 0;
   repeat
    Inc(I);
   until((Str[I] = Chr) or (I >= StrLenght));
   if Str[I] = Chr then
    Result := I
   else
    Result := 0;
  end
 else
  Result := 0;
end;

//Finds the maximum spread in benchmarks due to code lignment for any function.

procedure TMainForm.AlignmentTest;
var
 I1, I2, LineNo1, LineNo2, X1, X2, TabNo1, TabNo2 : Integer;
 S1, S2, BenchString1, BenchString2, FunctionName1, FunctionName2,
 ShortFunctionName1, ShortFunctionName2 : AnsiString;
 Bench1, Bench2, AverageBench, Spread, DeltaBench, MaxSpread : Double;
 C1, C2 : Char;
 Tab1Pos1, Tab1Pos2 : Cardinal;

begin
 if ReportRichEdit.Lines.Count < 2 then
  Exit;
 Bench1Edit.Text := '';
 Bench2Edit.Text := '';
 AlignMaxSpreadBenchPercentageEdit.Text := '';
 AlignFunctionName1Edit.Text := '';
 AlignFunctionName2Edit.Text := '';
 MaxSpread := 0;
 for LineNo1 := 0 to ReportRichEdit.Lines.Count-2 do
  begin
   S1 := ReportRichEdit.Lines[LineNo1];
   for LineNo2 := LineNo1+1 to ReportRichEdit.Lines.Count-1 do
    begin
     S2 := ReportRichEdit.Lines[LineNo2];
     Tab1Pos1 := CharPos(#9, S1);
     Tab1Pos2 := CharPos(#9, S2);
     FunctionName1 := Copy(S1, 0, Tab1Pos1-1);
     FunctionName2 := Copy(S2, 0, Tab1Pos2-1);
     ShortFunctionName1 := Copy(S1, 0, Tab1Pos1-3);
     ShortFunctionName2 := Copy(S2, 0, Tab1Pos2-3);
     if ShortFunctionName1 = ShortFunctionName2 then
      begin
       if (FunctionName1[Length(FunctionName1)] = 'a') or
          (FunctionName1[Length(FunctionName1)] = 'b') or
          (FunctionName1[Length(FunctionName1)] = 'c') or
          (FunctionName1[Length(FunctionName1)] = 'd') then
        begin
         if (FunctionName2[Length(FunctionName1)] = 'a') or
            (FunctionName2[Length(FunctionName1)] = 'b') or
            (FunctionName2[Length(FunctionName1)] = 'c') or
            (FunctionName2[Length(FunctionName1)] = 'd') then
          begin
           //****************************
           //X1 := CharPosRew(#9, S1)
           I1 := Length(S1);
           TabNo1 := 0;
           repeat
            C1 := S1[I1];
            Dec(I1);
            if C1 = #9 then
             Inc(TabNo1);
           until(TabNo1 = 1);
           X1 := I1+2;
           //*****************************
           BenchString1 := Copy(S1, X1, 5);
           try
            Bench1 := StrToFloat(BenchString1);
           except
            Bench1 := 0;
           end;
           //****************************
           //X2 := CharPosRew(#9, S2)
           I2 := Length(S2);
           TabNo2 := 0;
           repeat
            C2 := S2[I2];
            Dec(I2);
            if C2 = #9 then
             Inc(TabNo2);
           until(TabNo2 = 1);
           X2 := I2+2;
           //****************************
           BenchString2 := Copy(S2, X2, 5);
           try
            Bench2 := StrToFloat(BenchString2);
           except
            Bench2 := 0;
           end;
           DeltaBench := Abs(Bench1 - Bench2);
           AverageBench := (Bench1+Bench2) / 2;
           Spread := 100 * DeltaBench / AverageBench;
           if Spread > MaxSpread then
            begin
             Bench1Edit.Text := BenchString1;
             Bench2Edit.Text := BenchString2;
             MaxSpread := Spread;
             AlignMaxSpreadBenchPercentageEdit.Text := FloatToStrF(MaxSpread, ffFixed, 9, 1);
             AlignFunctionName1Edit.Text := FunctionName1;
             AlignFunctionName2Edit.Text := FunctionName2;
             Update;
            end;
          end;
        end;
      end;
    end;
  end;
end;

//Finds the maximum spread in benchmarks for any function.

procedure TMainForm.BenchmarkTest;
var
 I1, I2, LineNo1, LineNo2, X1, X2, TabNo1, TabNo2 : Integer;
 S1, S2, BenchString1, BenchString2, FunctionName1, FunctionName2 : AnsiString;
 Bench1, Bench2, AverageBench, Spread, DeltaBench, MaxSpread : Double;
 C1, C2 : Char;
 Tab1Pos1, Tab1Pos2 : Cardinal;

begin
 if ReportRichEdit.Lines.Count < 2 then
  Exit;
 Bench1Edit.Text := '';
 Bench2Edit.Text := '';
 FunctionNameEdit.Text := '';
 MaxSpreadBenchPercentageEdit.Text := '';
 MaxSpreadBenchPercentageEdit.Color := clInfobk;
 MaxSpread := 0;
 for LineNo1 := 0 to ReportRichEdit.Lines.Count-2 do
  begin
   S1 := ReportRichEdit.Lines[LineNo1];
   for LineNo2 := LineNo1+1 to ReportRichEdit.Lines.Count-1 do
    begin
     S2 := ReportRichEdit.Lines[LineNo2];
     Tab1Pos1 := CharPos(#9, S1);
     Tab1Pos2 := CharPos(#9, S2);
     FunctionName1 := Copy(S1, 0, Tab1Pos1-1);
     FunctionName2 := Copy(S2, 0, Tab1Pos2-1);
     if FunctionName1 = FunctionName2 then
      begin
       //****************************
       //X1 := CharPosRew(#9, S1)
       I1 := Length(S1);
       TabNo1 := 0;
       repeat
        C1 := S1[I1];
        Dec(I1);
        if C1 = #9 then
         Inc(TabNo1);
       until(TabNo1 = 1);
       X1 := I1+2;
       //*****************************
       BenchString1 := Copy(S1, X1, 5);
       try
        Bench1 := StrToFloat(BenchString1);
       except
        Bench1 := 0;
       end;
       //****************************
       //X2 := CharPosRew(#9, S2)
       I2 := Length(S2);
       TabNo2 := 0;
       repeat
        C2 := S2[I2];
        Dec(I2);
        if C2 = #9 then
         Inc(TabNo2);
       until(TabNo2 = 1);
       X2 := I2+2;
       //****************************
       BenchString2 := Copy(S2, X2, 5);
       try
        Bench2 := StrToFloat(BenchString2);
       except
        Bench2 := 0;
       end;
       DeltaBench := Abs(Bench1 - Bench2);
       AverageBench := (Bench1+Bench2) / 2;
       Spread := 100 * DeltaBench / AverageBench;
       if Spread >= MaxSpread then
        begin
         Bench1Edit.Text := BenchString1;
         Bench2Edit.Text := BenchString2;
         MaxSpread := Spread;
         MaxSpreadBenchPercentageEdit.Text := FloatToStrF(MaxSpread, ffFixed, 9, 1);
         FunctionNameEdit.Text := FunctionName1;
         MaxSpreadBenchPercentageEdit.Color := clGreen;
         if MaxSpread > 2 then
          MaxSpreadBenchPercentageEdit.Color := clYellow;
         if MaxSpread > 5 then
          MaxSpreadBenchPercentageEdit.Color := clRed;
         Update;
        end;
      end;
    end;
  end;
end;

//Removes multiple results from same function. Preserves the fastest result

procedure TMainForm.CleanResultsRichEdit;
var
 LineNo1, LineNo2, Tab1Pos1, Tab1Pos2 : Integer;
 S1, S2, FunctionName1, FunctionName2 : AnsiString;

begin
 for LineNo1 := 0 to ReportRichEdit.Lines.Count-2 do
  begin
   S1 := ReportRichEdit.Lines[LineNo1];
   LineNo2 := LineNo1+1;
   while LineNo2 <= ReportRichEdit.Lines.Count-1 do
    begin
     S2 := ReportRichEdit.Lines[LineNo2];
     Tab1Pos1 := CharPos(#9, S1);
     Tab1Pos2 := CharPos(#9, S2);
     FunctionName1 := Copy(S1, 0, Tab1Pos1-1);
     FunctionName2 := Copy(S2, 0, Tab1Pos2-1);
     if FunctionName1 = FunctionName2 then
      begin
       ReportRichEdit.Lines.Delete(LineNo2);
       Dec(LineNo2);
      end;
     Inc(LineNo2);
    end;
  end;
end;

function CompareBitmaps(Bitmap1, Bitmap2 : TBitmap) : Boolean;
begin
 if BitmapsDifference(Bitmap1, Bitmap2) = 0 then
  Result := True
 else
  Result := False;
end;

function Validate1 : Boolean;
var
 Bitmap1, Bitmap2, Bitmap3 : TBitmap;
 RGB : TRGBColor;

begin
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap3 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap3.PixelFormat := pf32bit;
 Bitmap1.Height := 1;
 Bitmap2.Height := 1;
 Bitmap3.Height := 1;
 Bitmap1.Width := 1;
 Bitmap2.Width := 1;
 Bitmap3.Width := 1;
 RGB.Red := 1;
 RGB.Green := 2;
 RGB.Blue := 3;
 Bitmap1.Canvas.Pixels[0,0] := TRGBToTColor(RGB);//Alpha not supported in Bitmap1.Canvas.Pixels
 Bitmap2.Assign(Bitmap1);
 RGBToBGRFunction(Bitmap2);
 Bitmap3.Assign(Bitmap2);
 RGBToBGRFunction(Bitmap3);
 if not CompareBitmaps(Bitmap1, Bitmap3) then
  Result := False
 else
  Result := True;
 Bitmap1.Free;
 Bitmap2.Free;
 Bitmap3.Free;
end;

function Validate2 : Boolean;
var
 Bitmap1, Bitmap2, Bitmap3 : TBitmap;
 RGBColor : TColor;
 RGB : TRGBColor;

begin
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap3 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap3.PixelFormat := pf32bit;
 Bitmap1.Height := 1;
 Bitmap2.Height := 1;
 Bitmap3.Height := 1;
 Bitmap1.Width := 2;
 Bitmap2.Width := 2;
 Bitmap3.Width := 2;
 RGB.Red := 1;
 RGB.Green := 2;
 RGB.Blue := 3;
 RGBColor := TRGBToTColor(RGB);
 Bitmap1.Canvas.Pixels[0,0] := RGBColor;
 RGB.Red := 4;
 RGB.Green := 5;
 RGB.Blue := 6;
 RGBColor := TRGBToTColor(RGB);
 Bitmap1.Canvas.Pixels[1,0] := RGBColor;
 Bitmap2.Assign(Bitmap1);
 RGBToBGRFunction(Bitmap2);
 Bitmap3.Assign(Bitmap2);
 RGBToBGRFunction(Bitmap3);
 if not CompareBitmaps(Bitmap1, Bitmap3) then
  Result := False
 else
  Result := True;
 Bitmap1.Free;
 Bitmap2.Free;
 Bitmap3.Free;
end;

function Validate3 : Boolean;
var
 Bitmap1 : TBitmap;
 RGBColor : TColor;
 RGB : TRGBColor;

begin
 Result := True;
 Bitmap1 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap1.Height := 1;
 Bitmap1.Width := 3;
 RGB.Red := 1;
 RGB.Green := 2;
 RGB.Blue := 3;
 RGBColor := TRGBToTColor(RGB);
 Bitmap1.Canvas.Pixels[0,0] := RGBColor;
 RGB.Red := 4;
 RGB.Green := 5;
 RGB.Blue := 6;
 RGBColor := TRGBToTColor(RGB);
 Bitmap1.Canvas.Pixels[1,0] := RGBColor;
 RGB.Red := 7;
 RGB.Green := 8;
 RGB.Blue := 9;
 RGBColor := TRGBToTColor(RGB);
 Bitmap1.Canvas.Pixels[2,0] := RGBColor;
 RGBToBGRFunction(Bitmap1);
 RGBColor := Bitmap1.Canvas.Pixels[0,0];
 RGB := TColorToTRGB(RGBColor);
 if (RGB.Red <> 3) or (RGB.Green <> 2) or (RGB.Blue <> 1) then
  begin
   Result := False;
   Bitmap1.Free;
   Exit;
  end;
 RGBColor := Bitmap1.Canvas.Pixels[1,0];
 RGB := TColorToTRGB(RGBColor);
 if (RGB.Red <> 6) or (RGB.Green <> 5) or (RGB.Blue <> 4) then
  begin
   Result := False;
   Bitmap1.Free;
   Exit;
  end;
 RGBColor := Bitmap1.Canvas.Pixels[2,0];
 RGB := TColorToTRGB(RGBColor);
 if (RGB.Red <> 9) or (RGB.Green <> 8) or (RGB.Blue <> 7) then
  begin
   Result := False;
  end;
 Bitmap1.Free;
end;

function Validate4 : Boolean;
var
 Bitmap1, Bitmap2, Bitmap3 : TBitmap;
 RGBColor : TColor;
 RGB : TRGBColor;

begin
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap3 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap3.PixelFormat := pf32bit;
 Bitmap1.Height := 1;
 Bitmap2.Height := 1;
 Bitmap3.Height := 1;
 Bitmap1.Width := 2;
 Bitmap2.Width := 2;
 Bitmap3.Width := 2;
 RGB.Red := 1;
 RGB.Green := 2;
 RGB.Blue := 3;
 RGBColor := TRGBToTColor(RGB);
 Bitmap1.Canvas.Pixels[0,0] := RGBColor;
 RGB.Red := 4;
 RGB.Green := 5;
 RGB.Blue := 6;
 RGBColor := TRGBToTColor(RGB);
 Bitmap1.Canvas.Pixels[1,0] := RGBColor;
 Bitmap2.Assign(Bitmap1);
 RGBToBGRFunction(Bitmap2);
 Bitmap3.Assign(Bitmap2);
 RGBToBGRFunction(Bitmap3);
 if not CompareBitmaps(Bitmap1, Bitmap3) then
  Result := False
 else
  Result := True;
 Bitmap1.Free;
 Bitmap2.Free;
 Bitmap3.Free;
end;

function Validate5 : Boolean;
var
 Bitmap1, Bitmap2 : TBitmap;
 RGBColor : TColor;
 RGB : TRGBColor;
 I, J : Cardinal;
const
 HEIGHT : Cardinal = 1000;
 WIDTH : Cardinal = 2000;

begin
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap1.Height := HEIGHT;
 Bitmap2.Height := HEIGHT;
 Bitmap1.Width := WIDTH;
 Bitmap2.Width := WIDTH;
 RGB.Red := 1;
 RGB.Green := 1;
 RGB.Blue := 1;
 RGBColor := TRGBToTColor(RGB);
 for I := 0 to Bitmap1.Height-1 do
  begin
   for J := 0 to Bitmap1.Width-1 do
    begin
     Bitmap1.Canvas.Pixels[J,I] := RGBColor;
     Bitmap2.Canvas.Pixels[J,I] := RGBColor;
    end;
  end;
 RGBToBGRFunction(Bitmap1);
 if not CompareBitmaps(Bitmap1, Bitmap2) then
  Result := False
 else
  Result := True;
 Bitmap1.Free;
 Bitmap2.Free;
end;

function Validate6 : Boolean;
var
 Bitmap1, Bitmap2, Bitmap3 : TBitmap;
 RGBColor : TColor;
 RGB : TRGBColor;

begin
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap3 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap3.PixelFormat := pf32bit;
 Bitmap1.Height := 2;
 Bitmap2.Height := 2;
 Bitmap3.Height := 2;
 Bitmap1.Width := 2;
 Bitmap2.Width := 2;
 Bitmap3.Width := 2;
 RGB.Red := 1;
 RGB.Green := 2;
 RGB.Blue := 3;
 RGBColor := TRGBToTColor(RGB);
 Bitmap1.Canvas.Pixels[0,0] := RGBColor;
 RGB.Red := 4;
 RGB.Green := 5;
 RGB.Blue := 6;
 RGBColor := TRGBToTColor(RGB);
 Bitmap1.Canvas.Pixels[0,1] := RGBColor;
 RGB.Red := 7;
 RGB.Green := 8;
 RGB.Blue := 9;
 RGBColor := TRGBToTColor(RGB);
 Bitmap1.Canvas.Pixels[1,0] := RGBColor;
 RGB.Red := 10;
 RGB.Green := 11;
 RGB.Blue := 12;
 RGBColor := TRGBToTColor(RGB);
 Bitmap1.Canvas.Pixels[1,1] := RGBColor;
 RGBToBGRFunction(Bitmap1);
 Result := True;
 RGBColor := Bitmap1.Canvas.Pixels[0,0];
 RGB := TColorToTRGB(RGBColor);
 if (RGB.Red <> 3) or (RGB.Green <> 2) or (RGB.Blue <> 1) then
  begin
   Result := False;
   Exit;
  end;
 RGBColor := Bitmap1.Canvas.Pixels[0,1];
 RGB := TColorToTRGB(RGBColor);
 if (RGB.Red <> 6) or (RGB.Green <> 5) or (RGB.Blue <> 4) then
  begin
   Result := False;
   Exit;
  end;
 RGBColor := Bitmap1.Canvas.Pixels[1,0];
 RGB := TColorToTRGB(RGBColor);
 if (RGB.Red <> 9) or (RGB.Green <> 8) or (RGB.Blue <> 7) then
  begin
   Result := False;
   Exit;
  end;
 RGBColor := Bitmap1.Canvas.Pixels[1,1];
 RGB := TColorToTRGB(RGBColor);
 if (RGB.Red <> 12) or (RGB.Green <> 11) or (RGB.Blue <> 10) then
  begin
   Result := False;
  end;
 Bitmap1.Free;
 Bitmap2.Free;
 Bitmap3.Free;
end;

function Validate7 : Boolean;
var
 Bitmap1, Bitmap2 : TBitmap;
 RGBColor : TColor;
 RGB : TRGBColor;
 RowNo, J : Cardinal;
const
 HEIGHT : Cardinal = 1111;
 WIDTH : Cardinal = 234;

begin
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap1.Height := HEIGHT;
 Bitmap2.Height := HEIGHT;
 Bitmap1.Width := WIDTH;
 Bitmap2.Width := WIDTH;
 RGB.Red := 1;
 RGB.Green := 255;
 RGB.Blue := 1;
 RGBColor := TRGBToTColor(RGB);
 for RowNo := 0 to Bitmap1.Height-1 do
  begin
   for J := 0 to Bitmap1.Width-1 do
    begin
     Bitmap1.Canvas.Pixels[RowNo,J] := RGBColor;
     Bitmap2.Canvas.Pixels[RowNo,J] := RGBColor;
    end;
  end;
 RGBToBGRFunction(Bitmap1);
 if not CompareBitmaps(Bitmap1, Bitmap2) then
  Result := False
 else
  Result := True;
 Bitmap1.Free;
 Bitmap2.Free;
end;

function Validate8 : Boolean;
var
 Bitmap1, Bitmap2 : TBitmap;
 RGBColor : TColor;
 RGB : TRGBColor;
 I, J, Height : Cardinal;
const
 MAXHEIGHT : Cardinal = 111;
 WIDTH : Cardinal = 234;

begin
 Result := True;
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap1.Width := WIDTH;
 Height := 1;
 while Height < MAXHEIGHT do
  begin
   Bitmap1.Height := Height;
   Bitmap2.Height := Bitmap1.Height;
   Bitmap2.Width := Bitmap1.Width;
   RGB.Red := 1;
   RGB.Green := 255;
   RGB.Blue := 1;
   RGBColor := TRGBToTColor(RGB);
   for I := 0 to Bitmap1.Height-1 do
    begin
     for J := 0 to Bitmap1.Width-1 do
      begin
       Bitmap1.Canvas.Pixels[I,J] := RGBColor;
       Bitmap2.Canvas.Pixels[I,J] := RGBColor;
      end;
    end;
   RGBToBGRFunction(Bitmap1);
   if not CompareBitmaps(Bitmap1, Bitmap2) then
    begin
     Result := False;
     Break;
    end;
   Inc(Height);
  end;
 Bitmap1.Free;
 Bitmap2.Free;
end;

function Validate9 : Boolean;
var
 Bitmap1, Bitmap2 : TBitmap;
 RGBColor1, RGBColor2 : TColor;
 RGB1, RGB2 : TRGBColor;
 I, J, Height : Cardinal;
const
 MAXHEIGHT : Cardinal = 111;
 WIDTH : Cardinal = 234;

begin
 Result := True;
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap1.Width := WIDTH;
 Height := 1;
 while Height < MAXHEIGHT do
  begin
   Bitmap1.Height := Height;
   Bitmap2.Height := Bitmap1.Height;
   Bitmap2.Width := Bitmap1.Width;
   RGB1.Red := 17;
   RGB1.Green := 255;
   RGB1.Blue := 254;
   RGBColor1 := TRGBToTColor(RGB1);
   RGB2.Red := 254;
   RGB2.Green := 255;
   RGB2.Blue := 17;
   RGBColor2 := TRGBToTColor(RGB2);
   for I := 0 to Bitmap1.Height-1 do
    begin
     for J := 0 to Bitmap1.Width-1 do
      begin
       Bitmap1.Canvas.Pixels[I,J] := RGBColor1;
       Bitmap2.Canvas.Pixels[I,J] := RGBColor2;
      end;
    end;
   RGBToBGRFunction(Bitmap1);
   if not CompareBitmaps(Bitmap1, Bitmap2) then
    begin
     Result := False;
     Break;
    end;
   Inc(Height);
  end;
 Bitmap1.Free;
 Bitmap2.Free;
end;

function Validate10 : Boolean;
var
 Bitmap1, Bitmap2 : TBitmap;
 RGBColor1, RGBColor2 : TColor;
 RGB1, RGB2 : TRGBColor;
 I, J, Width : Cardinal;
const
 MAXWIDTH : Cardinal = 123;
 HEIGHT : Cardinal = 17;

begin
 Result := True;
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap1.Height := HEIGHT;
 Width := 1;
 while Width < MAXWIDTH do
  begin
   Bitmap1.Width := Width;
   Bitmap2.Height := Bitmap1.Height;
   Bitmap2.Width := Bitmap1.Width;
   RGB1.Red := 0;
   RGB1.Green := 255;
   RGB1.Blue := 54;
   RGBColor1 := TRGBToTColor(RGB1);
   RGB2.Red := 54;
   RGB2.Green := 255;
   RGB2.Blue := 0;
   RGBColor2 := TRGBToTColor(RGB2);
   for I := 0 to Bitmap1.Height-1 do
    begin
     for J := 0 to Bitmap1.Width-1 do
      begin
       Bitmap1.Canvas.Pixels[I,J] := RGBColor1;
       Bitmap2.Canvas.Pixels[I,J] := RGBColor2;
      end;
    end;
   RGBToBGRFunction(Bitmap1);
   if not CompareBitmaps(Bitmap1, Bitmap2) then
    begin
     Result := False;
     Break;
    end;
   Inc(Width);
  end;
 Bitmap1.Free;
 Bitmap2.Free;
end;

function Validate11 : Boolean;
var
 Bitmap1, Bitmap2 : TBitmap;
 RGBColor1 : TColor;
 RGB1 : TRGBColor;
 I, J, Width, Height : Cardinal;
const
 MAXWIDTH : Cardinal = 39;
 MAXHEIGHT : Cardinal = 27;

begin
 Result := True;
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Height := 1;
 while Height < MAXHEIGHT do
  begin
   Width := 1;
   while Width < MAXWIDTH do
    begin
     Bitmap1.Width := Width;
     Bitmap1.Height := Height;
     Bitmap2.Width := Bitmap1.Width;
     Bitmap2.Height := Bitmap1.Height;
     RGB1.Red := Random(255);
     RGB1.Green := Random(255);
     RGB1.Blue := Random(255);
     RGBColor1 := TRGBToTColor(RGB1);
     for I := 0 to Bitmap1.Height-1 do
      begin
       for J := 0 to Bitmap1.Width-1 do
        begin
         Bitmap1.Canvas.Pixels[I,J] := RGBColor1;
         Bitmap2.Canvas.Pixels[I,J] := RGBColor1;
        end;
      end;
     RGBToBGR_DKC_Pas_12(Bitmap1);
     RGBToBGRFunction(Bitmap2);
     if not CompareBitmaps(Bitmap1, Bitmap2) then
      begin
       Result := False;
       Break;
      end;
     Inc(Width);
    end;
   Inc(Height);
  end;
 Bitmap1.Free;
 Bitmap2.Free;
end;

function Validate12 : Boolean;
var
 Bitmap1, Bitmap2, Bitmap3 : TBitmap;
 RGB : TRGBColor;

begin
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap3 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap3.PixelFormat := pf32bit;
 Bitmap1.Height := 0;
 Bitmap2.Height := 0;
 Bitmap3.Height := 0;
 Bitmap1.Width := 1;
 Bitmap2.Width := 1;
 Bitmap3.Width := 1;
 RGB.Red := 1;
 RGB.Green := 2;
 RGB.Blue := 3;
 Bitmap1.Canvas.Pixels[0,0] := TRGBToTColor(RGB);//Alpha not supported in Bitmap1.Canvas.Pixels?
 Bitmap2.Assign(Bitmap1);
 RGBToBGRFunction(Bitmap2);
 Bitmap3.Assign(Bitmap2);
 RGBToBGRFunction(Bitmap3);
 if not CompareBitmaps(Bitmap1, Bitmap3) then
  Result := False
 else
  Result := True;
 Bitmap1.Free;
 Bitmap2.Free;
 Bitmap3.Free;
end;

function Validate13 : Boolean;
var
 Bitmap1, Bitmap2, Bitmap3 : TBitmap;
 RGB : TRGBColor;

begin
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap3 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap3.PixelFormat := pf32bit;
 Bitmap1.Height := 1;
 Bitmap2.Height := 1;
 Bitmap3.Height := 1;
 Bitmap1.Width := 0;
 Bitmap2.Width := 0;
 Bitmap3.Width := 0;
 RGB.Red := 1;
 RGB.Green := 2;
 RGB.Blue := 3;
 Bitmap1.Canvas.Pixels[0,0] := TRGBToTColor(RGB);//Alpha not supported in Bitmap1.Canvas.Pixels?
 Bitmap2.Assign(Bitmap1);
 RGBToBGRFunction(Bitmap2);
 Bitmap3.Assign(Bitmap2);
 RGBToBGRFunction(Bitmap3);
 if not CompareBitmaps(Bitmap1, Bitmap3) then
  Result := False
 else
  Result := True;
 Bitmap1.Free;
 Bitmap2.Free;
 Bitmap3.Free;
end;

function Validate14 : Boolean;
var
 Bitmap1, Bitmap2, Bitmap3 : TBitmap;
 RGB : TRGBColor;

begin
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap3 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap3.PixelFormat := pf32bit;
 Bitmap1.Height := 0;
 Bitmap2.Height := 0;
 Bitmap3.Height := 0;
 Bitmap1.Width := 0;
 Bitmap2.Width := 0;
 Bitmap3.Width := 0;
 RGB.Red := 1;
 RGB.Green := 2;
 RGB.Blue := 3;
 Bitmap1.Canvas.Pixels[0,0] := TRGBToTColor(RGB);//Alpha not supported in Bitmap1.Canvas.Pixels?
 Bitmap2.Assign(Bitmap1);
 RGBToBGRFunction(Bitmap2);
 Bitmap3.Assign(Bitmap2);
 RGBToBGRFunction(Bitmap3);
 if not CompareBitmaps(Bitmap1, Bitmap3) then
  Result := False
 else
  Result := True;
 Bitmap1.Free;
 Bitmap2.Free;
 Bitmap3.Free;
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionAddress : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  ValidateButton.Caption := 'Running';
  ValidationEdit.Color := clBlue;
  Update;
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@RGBToBGRFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if Validate1 and
     Validate2 and
     Validate3 and
     Validate4 and
     Validate5 and
     Validate6 and
     Validate7 and
     Validate8 and
     Validate9 and
     Validate10 and
     Validate11 and
     Validate12 and
     Validate13 then
   begin
    ValidationEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionName
                      + #9 + FunctionAddressString[8]
                     + #9 + 'Passed');
   end
  else
   begin
    ValidationEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionName
                      + #9 + FunctionAddressString[8]
                     + #9 + 'Failed');
   end;
  ValidateButton.Caption := 'Validate';
 except
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@RGBToBGRFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  ReportRichEdit.Lines.Add(FunctionName
                    + #9 + FunctionAddressString[8]
                   + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
var
 FunctionAddress, SubBench1, Bench : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@RGBToBGRFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  BenchmarkButton.Caption := 'Running';
  SubBench1 := Round(SubBenchmark1);
  Bench := SubBench1;
  RuntimeEdit.Text := IntToStr(Bench);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]
                           //+ #9 + IntToStr(SubBench1)
                           + #9 + IntToStr(Bench));
  SortRichEdit;
  BenchmarkTest;
  AlignmentTest;
  BenchmarkButton.Caption := 'Benchmark';
 except
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]
                           + #9 + 'Failed'
                           //+ #9 + '9999'
                           + #9 + '9999');
 end;
end;

function TMainForm.SubBenchmark1 : Double;
var
 Bitmap1, Bitmap2, Bitmap3, Bitmap4, Bitmap5, Bitmap6, Bitmap7 : TBitmap;
 I1, I2, I4, Row, Col : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 NoOfTicksArray : array of Int64;

begin
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap3 := TBitmap.Create;
 Bitmap4 := TBitmap.Create;
 Bitmap5 := TBitmap.Create;
 Bitmap6 := TBitmap.Create;
 Bitmap7 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap3.PixelFormat := pf32bit;
 Bitmap4.PixelFormat := pf32bit;
 Bitmap5.PixelFormat := pf32bit;
 Bitmap6.PixelFormat := pf32bit;
 Bitmap7.PixelFormat := pf32bit;
 Bitmap1.Height  := 40;
 Bitmap1.Width   := 57;
 Bitmap2.Height := 200;
 Bitmap2.Width  := 111;
 Bitmap3.Height := 398;
 Bitmap3.Width  := 723;
 Bitmap4.Height := 768;
 Bitmap4.Width := 1024;
 Bitmap5.Height := 896;
 Bitmap5.Width := 1234;
 Bitmap6.Height:= 1024;
 Bitmap6.Width := 1234;
 Bitmap7.Height:= 1624;
 Bitmap7.Width := 1234;
 //Not needed
 for Row := 0 to Bitmap1.Height-1 do
  for Col := 0 to Bitmap1.Width-1 do
   Bitmap1.Canvas.Pixels[Row,Col] := Row * Col;
 for Row := 0 to Bitmap2.Height-1 do
  for Col := 0 to Bitmap2.Width-1 do
   Bitmap2.Canvas.Pixels[Row,Col] := Row * Col;
 for Row := 0 to Bitmap3.Height-1 do
  for Col := 0 to Bitmap3.Width-1 do
   Bitmap3.Canvas.Pixels[Row,Col] := Row * Col;
 for Row := 0 to Bitmap4.Height-1 do
  for Col := 0 to Bitmap4.Width-1 do
   Bitmap4.Canvas.Pixels[Row,Col] := Row * Col;
 for Row := 0 to Bitmap5.Height-1 do
  for Col := 0 to Bitmap5.Width-1 do
   Bitmap5.Canvas.Pixels[Row,Col] := Row * Col;
 for Row := 0 to Bitmap6.Height-1 do
  for Col := 0 to Bitmap6.Width-1 do
   Bitmap6.Canvas.Pixels[Row,Col] := Row * Col;
 for Row := 0 to Bitmap7.Height-1 do
  for Col := 0 to Bitmap7.Width-1 do
   Bitmap7.Canvas.Pixels[Row,Col] := Row * Col;
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     RGBToBGRFunction(Bitmap1);
     RGBToBGRFunction(Bitmap2);
     RGBToBGRFunction(Bitmap3);
     RGBToBGRFunction(Bitmap4);
     RGBToBGRFunction(Bitmap5);
     RGBToBGRFunction(Bitmap6);
     RGBToBGRFunction(Bitmap7);
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[I1] := NoOfTicks;
  end;
 Bitmap1.Free;
 Bitmap2.Free;
 Bitmap3.Free;
 Bitmap4.Free;
 Bitmap5.Free;
 Bitmap6.Free;
 Bitmap7.Free;
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := RunTimeSec*SUBBENCH1SCALE;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var  CpuString : string;
begin
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount := 2;
 ReportRichEdit.Paragraph.Tab[0] := 110;
 ReportRichEdit.Paragraph.Tab[1] := 150;
 FunctionSelectionRadioGroupClick(nil);

 Caption := Format('%s   (%s with %s) (%s : %s)', [Caption, SystemInfoCompiler, SystemInfoCompilerSettings, FastCodeTargetStr[FastCodeTarget], SystemInfoCPUDetails]);

 case FastCodeTarget of
  fctRTLReplacement,
  fctBlendedIA32,
  fctBlendedMMX,
  fctBlendedSSE,
  fctBlendedSSE2 : CpuString := Format('%s_%s_F%d_M%d', [FastCodeTargetStr[FastCodeTarget], VendorStr[CPU.Vendor], CPU.EffFamily, CPU.EffModel ]);
  else CpuString := FastCodeTargetStr[FastCodeTarget];
 end;

 FValidationFileName := Format('%s_%s_Validation_%s.txt', [CHALLENGE_NAME,GetFormattedVersion, CpuString]);
 FBenchmarkFileName := Format('%s_%s_Benchmark_%s.txt', [CHALLENGE_NAME,GetFormattedVersion, CpuString]);
 FResultsFileName  := Format('%s_%s_Results_%s.txt', [CHALLENGE_NAME,GetFormattedVersion,CpuString]);

 FResultList := TStringList.Create;

 if ParamCount > 0 then
   PostMessage(Handle, WM_POSTPROCESSING, 0, 0)
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(FResultList);
end;

procedure TMainForm.FunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionRadioGroup.ItemIndex+1 of
  1 : RGBToBGRFunction := RGBToBGR_NH_Pas_1;
  2 : RGBToBGRFunction := RGBToBGR_DKC_Pas_12;
  3 : RGBToBGRFunction := RGBToBGR_DKC_Pas_13;
  4 : RGBToBGRFunction := RGBToBGR_DKC_Pas_14;
  5 : RGBToBGRFunction := RGBToBGR_DKC_Pas_15;
  6 : RGBToBGRFunction := RGBToBGR_DKC_Pas_16;
  7 : RGBToBGRFunction := RGBToBGR_DKC_Pas_17;
  8 : RGBToBGRFunction := RGBToBGR_DKC_IA32_7;
  9 : RGBToBGRFunction := RGBToBGR_DKC_IA32_8;
  10 : RGBToBGRFunction := RGBToBGR_DKC_IA32_9;
  11 : RGBToBGRFunction := RGBToBGR_DKC_IA32_10;
  12 : RGBToBGRFunction := RGBToBGR_DKC_IA32_11;
  13 : RGBToBGRFunction := RGBToBGR_DKC_IA32_12;
  14 : RGBToBGRFunction := RGBToBGR_DKC_IA32_13;
  15 : RGBToBGRFunction := RGBToBGR_DKC_IA32_14;
  16 : RGBToBGRFunction := RGBToBGR_DKC_IA32_15;
  17 : RGBToBGRFunction := RGBToBGR_DKC_IA32_16;
  18 : RGBToBGRFunction := RGBToBGR_DKC_IA32_17;
  19 : RGBToBGRFunction := RGBToBGR_DKC_IA32_18;
  20 : RGBToBGRFunction := RGBToBGR_DKC_IA32_19;
  21 : RGBToBGRFunction := RGBToBGR_DKC_IA32_20;
  22 : RGBToBGRFunction := RGBToBGR_DKC_IA32_21;
  23 : RGBToBGRFunction := RGBToBGR_DKC_IA32_22;
  24 : RGBToBGRFunction := RGBToBGR_DKC_IA32_23;
  25 : RGBToBGRFunction := RGBToBGR_DKC_MMX_3;
  26 : RGBToBGRFunction := RGBToBGR_DKC_SSE_2;
  27 : RGBToBGRFunction := RGBToBGR_DKC_SSE_4;
  28 : RGBToBGRFunction := RGBToBGR_JOH_PAS_1;
 else
  raise Exception.Create('Invalid Function Number');
 end;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 BenchmarkAllButton.Caption := 'Running';
 Update;
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_ABOVE_NORMAL failed');
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   BenchmarkButtonClick(nil);
   Update;
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';

 if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
 FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FBenchmarkFileName);
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 Update;
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   ValidateButtonClick(nil);
   Update;
  end;
 ValidateAllButton.Caption := 'Validate All';

 if FileExists(FValidationFileName) then FResultList.LoadFromFile(FValidationFileName);
 FResultList.Add(Format('[%s %s] Running "%s" validation version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FValidationFileName);
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog.FileName := FResultsFileName;
 if SaveDialog.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TMainForm.PrintReportSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('RBGAToGBRABenchReport');
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1, I2 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 Update;
 for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for I1 := 1 to 3 do
  begin
   for I2 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
    begin
     FunctionSelectionRadioGroup.ItemIndex := I2;
     BenchmarkButtonClick(nil);
     Update;
    end;
   FunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkButtonClick(nil);
   Update;
  end;
 BenchTestButton.Caption := 'Bench Test';
end;

procedure TMainForm.SpreadTestButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 for I := 1 to 20 do
  begin
   BenchmarkButtonClick(nil);
   Update;
  end;
end;

procedure TMainForm.MaxSpreadBenchPercentageEditClick(Sender: TObject);
begin
 MaxSpreadBenchPercentageEdit.SelectAll;
 MaxSpreadBenchPercentageEdit.CopyToClipboard;
end;

procedure TMainForm.CleanResultsButtonClick(Sender: TObject);
begin
 CleanResultsRichEdit;
 BenchmarkTest;
 AlignmentTest;
end;

procedure TMainForm.WMPOSTPROCESSING(var msg: TMessage);
begin
  if FindCmdLineSwitch('C', ['-', '/'], True) then
  begin
    // clear results;
    if FileExists(FValidationFileName) then DeleteFile(FValidationFileName);
    if FileExists(FBenchmarkFileName) then DeleteFile(FBenchmarkFileName);
  end;

  if FindCmdLineSwitch('B', ['-', '/'], True) then
  begin
    // run all benchmarks
    Show;
    Enabled := False;
    Application.ProcessMessages;
    Enabled := True;
    BenchmarkAllButton.Click;
    Halt;
  end;

  if FindCmdLineSwitch('V', ['-', '/'], True) then
  begin
    // perform all validations
    Show;
    Enabled := False;
    Application.ProcessMessages;
    Enabled := True;
    ValidateAllButton.Click;
    Halt;
  end;
end;

end.
