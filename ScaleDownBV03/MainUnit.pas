unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

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
    ShowImageFormSpeedButton: TSpeedButton;
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
    procedure ShowImageFormSpeedButtonClick(Sender: TObject);
  private
    procedure ClearAllEditBoxes;
    procedure CleanResultsRichEdit;
    procedure SortRichEdit;
    procedure BenchmarkTest;
    procedure AlignmentTest;
    function SubBenchmark1 : Double;
  public
    { Public declarations }
  end;

function TColorToTRGB(const Color:  TColor):  TRGBColor;
function TRGBToTColor(const Color:  TRGBColor):  TColor;

var
 MainForm: TMainForm;

implementation

uses ScaleDownDKCUnit, ImageUnit, ScaleDownRMKUnit;

{$R *.dfm}

const
 NOOFRUNS : Cardinal = 1;
 SUBBENCH1SCALE : Double = 300;
 SUBBENCH1ARRAYSIZE : Cardinal = 30;
 NOOFRERUNS : Cardinal = 1;

type
 TScaleDownFunction = function (const SourceBitmap : TBitmap; ScaleFactor : Single) : TBitmap;

var
 ScaleDownFunction : TScaleDownFunction;

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
 BPixel1, BPixel2, GPixel1, GPixel2, RPixel1, RPixel2 : Byte;

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
     raise Exception.Create('Both bitmaps must be pf32bit');
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
 Bitmap1, Bitmap2 : TBitmap;
 RGB : TRGBColor;

begin
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap1.Height := 1;
 Bitmap2.Height := 1;
 Bitmap1.Width := 1;
 Bitmap2.Width := 1;
 RGB.Red := 1;
 RGB.Green := 2;
 RGB.Blue := 3;
 Bitmap1.Canvas.Pixels[0,0] := TRGBToTColor(RGB);
 Bitmap2 := ScaleDownFunction(Bitmap1, 1);
 if not CompareBitmaps(Bitmap1, Bitmap2) then
  Result := False
 else
  Result := True;
 Bitmap1.Free;
 Bitmap2.Free;
end;

//Functions are validated to produce the exact same result as the reference function

function Validate2 : Boolean;
var
 Bitmap1, Bitmap2 : TBitmap;
 RGBColor1 : TColor;
 RGB1 : TRGBColor;
 RowNo, ColNo, Width, Height : Cardinal;
const
 MAXWIDTH : Cardinal = 39;
 MAXHEIGHT : Cardinal = 27;
 SCALE : Single = 2;

begin
 Result := True;
 Bitmap1 := TBitmap.Create;
 Bitmap2 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2.PixelFormat := pf32bit;
 Height := 2;
 while Height < MAXHEIGHT do
  begin
   Width := 2;
   while Width < MAXWIDTH do
    begin
     Bitmap1.Width := Width;
     Bitmap1.Height := Height;
     Bitmap2.Width := Bitmap1.Width;
     Bitmap2.Height := Bitmap1.Height;
     RGB1.Red := 7;
     RGB1.Green := 11;
     RGB1.Blue := 13;
     RGBColor1 := TRGBToTColor(RGB1);
     for RowNo := 0 to Bitmap1.Height-1 do
      begin
       for ColNo := 0 to Bitmap1.Width-1 do
        begin
         Bitmap1.Canvas.Pixels[ColNo, RowNo] := RGBColor1;
         Bitmap2.Canvas.Pixels[ColNo, RowNo] := RGBColor1;
        end;
      end;
     ScaleDownDKCPas1(Bitmap1, Scale);
     ScaleDownFunction(Bitmap2, Scale);
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

function Validate3 : Boolean;
var
 Bitmap1, Bitmap2, Bitmap3 : TBitmap;
 RGBColor1 : TColor;
 RGB1 : TRGBColor;
 RowNo, ColNo, Width, Height : Cardinal;
const
 MAXWIDTH : Cardinal = 10;
 MAXHEIGHT : Cardinal = 10;
 SCALE : Single = 2.7;

begin
 Result := True;
 Bitmap1 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2 := TBitmap.Create;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap3 := TBitmap.Create;
 Bitmap3.PixelFormat := pf32bit;
 Height := 2;
 while Height < MAXHEIGHT do
  begin
   Width := 2;
   while Width < MAXWIDTH do
    begin
     Bitmap1.Width := Width;
     Bitmap1.Height := Height;
     for RowNo := 0 to Bitmap1.Height-1 do
      begin
       for ColNo := 0 to Bitmap1.Width-1 do
        begin
         RGB1.Red := Random(255);
         RGB1.Green := Random(255);
         RGB1.Blue := Random(255);
         RGBColor1 := TRGBToTColor(RGB1);
         Bitmap1.Canvas.Pixels[ColNo, RowNo] := RGBColor1;
        end;
      end;
     Bitmap2 := ScaleDownDKCPas1(Bitmap1, Scale);
     Bitmap3 := ScaleDownFunction(Bitmap1, Scale);
     if not CompareBitmaps(Bitmap2, Bitmap3) then
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
 Bitmap3.Free;
end;

function Validate4 : Boolean;
var
 Bitmap1, Bitmap2, Bitmap3 : TBitmap;
 RGBColor1 : TColor;
 RGB1 : TRGBColor;
 RowNo, ColNo, Width, Height : Cardinal;
 Scale : Single;
const
 MAXWIDTH : Cardinal = 50;
 MAXHEIGHT : Cardinal = 50;
 MAXSCALE : Single = 2;

begin
 Result := True;
 Bitmap1 := TBitmap.Create;
 Bitmap1.PixelFormat := pf32bit;
 Bitmap2 := TBitmap.Create;
 Bitmap2.PixelFormat := pf32bit;
 Bitmap3 := TBitmap.Create;
 Bitmap3.PixelFormat := pf32bit;
 Height := 10;
 while Height < MAXHEIGHT do
  begin
   Width := 10;
   while Width < MAXWIDTH do
    begin
     Scale := 1;
     while Scale < MAXSCALE do
      begin
       Bitmap1.Width := Width;
       Bitmap1.Height := Height;
       for RowNo := 0 to Bitmap1.Height-1 do
        begin
         for ColNo := 0 to Bitmap1.Width-1 do
          begin
           RGB1.Red := Random(255);
           RGB1.Green := Random(255);
           RGB1.Blue := Random(255);
           RGBColor1 := TRGBToTColor(RGB1);
           Bitmap1.Canvas.Pixels[ColNo,RowNo] := RGBColor1;
          end;
        end;
       try
        Bitmap2 := ScaleDownDKCPas1(Bitmap1, Scale);
       except
        Application.MessageBox(PChar('Help me ;-)' + ' Height: ' + IntToStr(Height) + ' Width: ' + IntToStr(Width)), 'Exception');
       end;
       Bitmap3 := ScaleDownFunction(Bitmap1, Scale);
       if not CompareBitmaps(Bitmap2, Bitmap3) then
        begin
         Result := False;
         Break;
        end;
       Scale := Scale * 1.1;
      end;
     Inc(Width);
    end;
   Inc(Height);
  end;
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
  FunctionAddress := Cardinal(@ScaleDownFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if Validate1 and
     Validate2 and
     Validate3 and
     Validate4 then
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
  FunctionAddress := Cardinal(@ScaleDownFunction);
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
 I1, I2, I4 : Cardinal;
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
     ScaleDownFunction(Bitmap1, 1);
     ScaleDownFunction(Bitmap2, 2);
     ScaleDownFunction(Bitmap3, PI);
     ScaleDownFunction(Bitmap4, 3);
     ScaleDownFunction(Bitmap5, 4);
     ScaleDownFunction(Bitmap6, 5.11);
     ScaleDownFunction(Bitmap7, 11);
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
begin
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount := 2;
 ReportRichEdit.Paragraph.Tab[0] := 110;
 ReportRichEdit.Paragraph.Tab[1] := 150;
 FunctionSelectionRadioGroupClick(nil);
end;

procedure TMainForm.FunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionRadioGroup.ItemIndex+1 of
  1 : ScaleDownFunction := ScaleDownRMKPas1;
  2 : ScaleDownFunction := ScaleDownDKCPas1;
  3 : ScaleDownFunction := ScaleDownDKCPas2;
  4 : ScaleDownFunction := ScaleDownDKCPas3;
  5 : ScaleDownFunction := ScaleDownDKCPas4;
  6 : ScaleDownFunction := ScaleDownDKCPas5;
  7 : ScaleDownFunction := ScaleDownDKCPas6;
  8 : ScaleDownFunction := ScaleDownDKCPas7;
  9 : ScaleDownFunction := ScaleDownDKCPas8;
  10 : ScaleDownFunction := ScaleDownDKCPas9;
  11 : ScaleDownFunction := ScaleDownDKCPas10;
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
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog.FileName := 'RBGToGBRBenchReport.Txt';
 if SaveDialog.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TMainForm.PrintReportSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('UpperCase Report');
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

procedure TMainForm.ShowImageFormSpeedButtonClick(Sender: TObject);
begin
 ImageForm.Show;
end;

end.
