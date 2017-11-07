unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ComCtrls, ExtCtrls, Buttons, OleServer, ExcelXP;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    AboutSpeedButton: TSpeedButton;
    CloseBitBtn: TBitBtn;
    PageControl1: TPageControl;
    PenrynTabSheet: TTabSheet;
    FunctionNameLabel: TLabel;
    PenrynCol2Label: TLabel;
    PenrynCol3Label: TLabel;
    PenrynCol4Label: TLabel;
    PenrynCPUTypeLabeledEdit: TLabeledEdit;
    NorthwoodTabSheet: TTabSheet;
    Label1: TLabel;
    NorthwoodCol2Label: TLabel;
    NorthwoodCol3Label: TLabel;
    NorthwoodCol4Label: TLabel;
    NorthwoodCol5Label: TLabel;
    NorthwoodStringGrid: TStringGrid;
    NorthwoodCPUTypeLabeledEdit: TLabeledEdit;
    YonahTabSheet: TTabSheet;
    Label6: TLabel;
    YonahCPUTypeLabeledEdit: TLabeledEdit;
    ConroeTabSheet: TTabSheet;
    Label11: TLabel;
    ConroeCPUTypeLabeledEdit: TLabeledEdit;
    PhenomTabSheet: TTabSheet;
    Label16: TLabel;
    PhenomStringGrid: TStringGrid;
    PhenomCPUTypeLabeledEdit: TLabeledEdit;
    AMD64X2TabSheet: TTabSheet;
    Label21: TLabel;
    AMD64X2StringGrid: TStringGrid;
    AMD64X2CPUTypeLabeledEdit: TLabeledEdit;
    BlendedTabSheet: TTabSheet;
    Label26: TLabel;
    Label30: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    TotalLabel: TLabel;
    BlendedStringGrid: TStringGrid;
    CalculateBlendedButton: TButton;
    BlendedSizePenaltyTabSheet: TTabSheet;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    BlendedSizePenaltyStringGrid: TStringGrid;
    PenaltyForSizeLabeledEdit: TLabeledEdit;
    CalculateBlendedSizePenaltyButton: TButton;
    WinnersTabSheet: TTabSheet;
    AuthorLabel: TLabel;
    TargetsLabel: TLabel;
    WinnersLabel: TLabel;
    PointsLabel: TLabel;
    TargetLabel: TLabel;
    WinnerFunctionLabel: TLabel;
    WinnersStringGrid: TStringGrid;
    GetWinnersButton: TButton;
    PointsStringGrid: TStringGrid;
    GivePointsButton: TButton;
    FunctionSizesTabSheet: TTabSheet;
    Label43: TLabel;
    SizeLabel: TLabel;
    FunctionSizesStringGrid: TStringGrid;
    AMD64X2Col2Label: TLabel;
    AMD64X2Col3Label: TLabel;
    AMD64X2Col4Label: TLabel;
    AMD64X2Col5Label: TLabel;
    PhenomCol2Label: TLabel;
    PhenomCol3Label: TLabel;
    PhenomCol4Label: TLabel;
    PhenomCol5Label: TLabel;
    SpeedVersusSizeTabSheet: TTabSheet;
    StringGrid2: TStringGrid;
    CalculateSpeedVersusSizeTableButton: TButton;
    LoadAndDoButton: TButton;
    PenaltyForSizeLabel: TLabel;
    IA32WinnerLabel: TLabel;
    SizeLabel2: TLabel;
    SpeedLabel: TLabel;
    RelativeSpeedLabel: TLabel;
    RichEdit1: TRichEdit;
    NorthwoodCol6Label: TLabel;
    PhenomCol6Label: TLabel;
    AMD64X2Col6Label: TLabel;
    SpeedButton1: TSpeedButton;
    FunctionsToRemoveTabSheet: TTabSheet;
    FunctionsToRemoveStringGrid: TStringGrid;
    RunButton: TButton;
    FunctionsToKeepStringGrid: TStringGrid;
    Label2: TLabel;
    Label3: TLabel;
    PenrynCol5Label: TLabel;
    PenrynCol6Label: TLabel;
    PenrynStringGrid: TStringGrid;
    YonahStringGrid: TStringGrid;
    ConroeStringGrid: TStringGrid;
    ConroeCol2Label: TLabel;
    ConroeCol3Label: TLabel;
    ConroeCol4Label: TLabel;
    ConroeCol5Label: TLabel;
    ConroeCol6Label: TLabel;
    YonahCol2Label: TLabel;
    YonahCol3Label: TLabel;
    YonahCol4Label: TLabel;
    YonahCol5Label: TLabel;
    YonahCol6Label: TLabel;
    FileOpenDialog: TOpenDialog;
    FunctionsToRemoveRichEdit: TRichEdit;
    PenrynCol7Label: TLabel;
    PenrynCol8Label: TLabel;
    NorthwoodCol7Label: TLabel;
    NorthwoodCol8Label: TLabel;
    YonahCol7Label: TLabel;
    YonahCol8Label: TLabel;
    ConroeCol7Label: TLabel;
    ConroeCol8Label: TLabel;
    PhenomCol7Label: TLabel;
    PhenomCol8Label: TLabel;
    AMD64X2Col7Label: TLabel;
    AMD64X2Col8Label: TLabel;
    InstructionsetRadioGroup: TRadioGroup;
    AuthorRadioGroup: TRadioGroup;
    PenaltyForSizeLabeledEdit2: TLabeledEdit;
    SubBenchWeightTabSheet: TTabSheet;
    SubBenchWeightsStringGrid: TStringGrid;
    CalculateButton: TButton;
    ChallengeNameEdit: TEdit;
    ChallengeVersionNumberEdit: TEdit;
    Label5: TLabel;
    Label7: TLabel;
    LoadAndRunButton: TButton;
    Label4: TLabel;
    Label8: TLabel;
    PenrynSpeedUpOverRTLLabeledEdit: TLabeledEdit;
    NorthwoodSpeedUpOverRTLLabeledEdit: TLabeledEdit;
    YonahSpeedUpOverRTLLabeledEdit: TLabeledEdit;
    ConroeSpeedUpOverRTLLabeledEdit: TLabeledEdit;
    PhenomSpeedUpOverRTLLabeledEdit: TLabeledEdit;
    AMD64X2SpeedUpOverRTLLabeledEdit: TLabeledEdit;
    BlendedSpeedUpOverRTLLabeledEdit: TLabeledEdit;
    BlendedSizePenaltySpeedUpOverRTLLabeledEdit: TLabeledEdit;
    LoadFileButton: TBitBtn;
    LoadAllButton: TBitBtn;
    DoAllButton: TBitBtn;
    CreateSpreadsheetsButton: TBitBtn;
    CalcWinnerButton: TBitBtn;
    procedure RunButtonClick(Sender: TObject);
    procedure LoadFileButtonClick(Sender: TObject);
    procedure AboutSpeedButtonClick(Sender: TObject);
    procedure CalculateBlendedButtonClick(Sender: TObject);
    procedure CalculateBlendedSizePenaltyButtonClick(Sender: TObject);
    procedure LoadAllButtonClick(Sender: TObject);
    procedure GetWinnersButtonClick(Sender: TObject);
    procedure GivePointsButtonClick(Sender: TObject);
    procedure DoAllButtonClick(Sender: TObject);
    procedure CreateSpreadsheetsButtonClick(Sender: TObject);
    procedure CalculateSpeedVersusSizeTableButtonClick(Sender: TObject);
    procedure LoadAndDoButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CalculateButtonClick(Sender: TObject);
    procedure LoadAndRunButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CalcWinnerButtonClick(Sender: TObject);
    procedure CloseBitBtnClick(Sender: TObject);
  private
   AuthorFileName    : AnsiString;
   NoOfSubbenchmarks : Integer;
   procedure TestFunctionSizes;
   procedure CreateTemplateFunctionSizeFile(FileName : AnsiString);
  public
    ChallengeVersionNumber : AnsiString;
    ChallengeName : AnsiString;
    MainFormCaption : AnsiString;
  end;

  procedure ReadIniFile(FileName : AnsiString);
  procedure WriteIniFile(FileName : AnsiString);

var
  MainForm: TMainForm;

const
 INIFILENAME : AnsiString = 'SpreadsheetCreator.Ini';
 AUTHORNAME  : AnsiString = 'Authors.Ini';
 MaxAuthors = 30;

implementation
 { TODO 2 -oDKC -cBug : Functions that are not named corectly by conventions cause trouble. }
 
uses
 AboutUnit, Math, Excel_TLB, OptionsUnit, IniFiles, HelperUnit;

type

 TAuthor = record
  Initials,
  Name        : AnsiString;
  IsPresent   : Boolean;
  NrOfTargets,
  NrOfWinners : Integer;
 end;

 TAuthorNameInstructionSet = record
  AuthorName, InstructionSet : AnsiString;
 end;

{$R *.dfm}

//******************************************************************************
//Ini file handling functions
//******************************************************************************

procedure ReadIniFile(FileName : AnsiString);
var
 IniFile : TIniFile;

begin
 IniFile := TIniFile.Create(FileName);
 OptionsForm.FilePathLabeledEdit.Text := IniFile.ReadString('Settings', 'FilePathLabeledEditText', '');
 if OptionsForm.FilePathLabeledEdit.Text<>'' then
  MainForm.Caption := MainForm.MainFormCaption + '  -  ' + OptionsForm.FilePathLabeledEdit.Text
 else
  MainForm.Caption := MainForm.MainFormCaption + '  -  ' + 'no directory selected';
 OptionsForm.ExcludeRTLFunctionCheckBox.Checked := IniFile.ReadBool('Settings', 'ExcludeRTLFunctionCheckBoxChecked', False);
 IniFile.Free;
end;

procedure WriteIniFile(FileName : AnsiString);
var
 IniFile : TIniFile;

begin
 IniFile := TIniFile.Create(FileName);
 IniFile.WriteString('Settings', 'FilePathLabeledEditText', OptionsForm.FilePathLabeledEdit.Text);
 IniFile.WriteBool('Settings', 'ExcludeRTLFunctionCheckBoxChecked', OptionsForm.ExcludeRTLFunctionCheckBox.Checked);
 IniFile.Free;
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

//Author:            Dennis Kjaer Christensen
//Date:              10/9 2004
//Instructionset(s): IA32

function CharPosEY(const SearchCharacter : Char; const SourceString : AnsiString; Occurrence : Integer = 1; StartPos : Integer = 1) : Integer;
var
 Char1 : Char;
 NoOfCharsFound, Index : Integer;

begin
 if (((Length(SourceString)) > 0) and (Occurrence > 0) and
      (StartPos > 0) and (StartPos <= Length(SourceString))) then
  begin
   Result := 0;
   NoOfCharsFound := 0;
   Index := StartPos - 1;
   repeat
    Inc(Index);
    Char1 := SourceString[Index];
    if Char1 = SearchCharacter then
     begin
      Inc(NoOfCharsFound);
      if NoOfCharsFound = Occurrence then
       begin
        Result := Index;
        Break;
       end;
     end;
   until(Index >= Length(SourceString));
  end
 else
  begin
   Result := 0;
  end;
end;

function LoadFile(FileNamePath : AnsiString; StringGrid : TStringGrid;
                  CPUTypeLabeledEdit : TLabeledEdit) : AnsiString;
var
 StringList : TStringList;
 Index1, Index2, Row, LineNo, Col, TabNo, Count, ColNo : Integer;
 Line, S, Version1, Version, ChalName, FileName : AnsiString;

begin
 FileName := ExtractFileName(FileNamePath);
 Index1 := CharPosEY('_', FileName,1)+1;
 Index2 := CharPosEY('_', FileName,2);
 Count := Index2 - Index1;
 Version1 := Copy(FileName, Index1, Count);
 Version := StringReplace(Version1, '.', '',[rfReplaceAll]);
 Result := Version1;
 Index1 := 1;
 Index2 := CharPosEY('_', FileName,1);
 Count := Index2 - Index1;
 ChalName := Copy(FileName, Index1, Count);
 { TODO 3 -oDKC -cClumsy : Do not access MainForm.ChallengeName here. }
 MainForm.ChallengeName := ChalName;
 MainForm.ChallengeNameEdit.Text := MainForm.ChallengeName;
 StringList := TStringList.Create;
 StringList.LoadFromFile(FileNamePath);
 Row := 0;
 for LineNo := 0 to StringList.Count - 1 do
  begin
   Col := 0;
   Line := StringList[LineNo];
   if Pos('CPU', Line) <> 0 then
    begin
     Index1 := Pos('CPU :', Line);
     Index2 := Pos('(Authentic', Line);
     if Index2 = 0 then
      Index2 := Pos('(GenuineIntel', Line);
     Count := Index2 - Index1;
     S := Copy(Line, Index1 + 6, Count-7);
     CPUTypeLabeledEdit.Text := S;
    end;
   if Pos('Failed', Line) = 0 then
    begin
     TabNo := 0;
     if CharPos(''#9'', Line) <> 0 then
      begin
       repeat
        Index1 := CharPosEy(#9, Line, TabNo);
        Inc(TabNo);
        Index2 := CharPosEy(#9, Line, TabNo);
        if (Index2 = 0) then
          Break;
        S := Copy(Line, Index1 + 1, Index2 - Index1 - 1);
        StringGrid.RowCount := Row + 1;
        StringGrid.ColCount := Col + 1;
        StringGrid.Cells[Col, Row] := S;
        Inc(Col);
       until False;
       Dec(TabNo);
       Index1 := CharPosEy(#9, Line, TabNo);
       Index2 := Length(Line);
       S := Copy(Line, Index1 + 1, Index2 - Index1);
       StringGrid.RowCount := Row + 1;
       StringGrid.ColCount := Col + 1;
       StringGrid.Cells[Col, Row] := S;
       Inc(Row);
      end;
    end;
  end;
 if StringGrid.ColCount <= 8 then
  begin
   StringGrid.ColWidths[0] := 160;
   for ColNo := 1 to StringGrid.ColCount - 1 do
    StringGrid.ColWidths[ColNo] := 62;
  end
 else
  raise Exception.Create('Unsupported number of collums in file');
 StringList.Free;
end;

{ TODO 1 -oDKC -cfunctionality : Function size file must be tab separated. Allow space separation. }

procedure LoadFunctionSizesFile(FileName : AnsiString; StringGrid : TStringGrid; PenaltyForSizeLabeledEdit : TLabeledEdit);
var
 StringList : TStringList;
 Index1, Index2, Row, LineNo, Col, TabNo, Count, Index, RowNo2 : Integer;
 Line, S, S1, FunctionName1, FunctionName2, Size1, Size2, FunctionName : AnsiString;
 Swap, PenaltyForSizeConstantFound : Boolean;

begin
 PenaltyForSizeConstantFound := False;
 StringGrid.ColWidths[0] := 150;
 StringGrid.ColWidths[1] := 75;
 StringList := TStringList.Create;
 StringList.LoadFromFile(FileName);
 Row := 0;
 for LineNo := 0 to StringList.Count - 1 do
  begin
   Line := StringList[LineNo];
   S1 := Copy(Line,1,2);
   if S1 <> '//' then
    begin
     if Pos('PenaltyForSizeConstant', Line) <> 0 then
      begin
       PenaltyForSizeConstantFound := True;
       Index := CharPos(#9, Line);
       Count := Length(Line) - Index;
       S := Copy(Line, Index+1, Count);
       PenaltyForSizeLabeledEdit.Text := S;
      end
     else
      begin
       Col := 0;
       TabNo := 0;
       if CharPos(#9, Line) <> 0 then
        begin
         repeat
          Index1 := CharPosEy(#9, Line, TabNo);
          Inc(TabNo);
          Index2 := CharPosEy(#9, Line, TabNo);
          if (Index2 = 0) then
            Break;
          FunctionName := Copy(Line, Index1 + 1, Index2 - Index1 - 1);
          if FunctionName = '' then
           raise Exception.Create('Empty collum in ' + FileName);
          StringGrid.RowCount := Row + 1;
          StringGrid.ColCount := Col + 1;
          StringGrid.Cells[Col, Row] := FunctionName;
          Inc(Col);
         until False;
         Dec(TabNo);
         Index1 := CharPosEy(#9, Line, TabNo);
         Index2 := Length(Line);
         S := Copy(Line, Index1 + 1, Index2 - Index1);
         StringGrid.RowCount := Row + 1;
         StringGrid.ColCount := Col + 1;
         StringGrid.Cells[Col, Row] := S;
         Inc(Row);
        end;
      end;
    end;
  end;
 StringList.Free;
  //Sort by name
 repeat
  Swap := False;
  for RowNo2 := 0 to StringGrid.RowCount-2 do
   begin
    FunctionName1 := StringGrid.Cells[0, RowNo2];
    FunctionName2 := StringGrid.Cells[0, RowNo2+1];
    Size1 := StringGrid.Cells[1, RowNo2];
    Size2 := StringGrid.Cells[1, RowNo2+1];
    if FunctionName2 < FunctionName1 then
     begin
      Swap := True;
      StringGrid.Cells[0, RowNo2+1] := FunctionName1;
      StringGrid.Cells[0, RowNo2] := FunctionName2;
      StringGrid.Cells[1, RowNo2+1] := Size1;
      StringGrid.Cells[1, RowNo2] := Size2
     end;
   end;
 until (Swap = False);
 if not PenaltyForSizeConstantFound then
  raise Exception.Create('No PenaltyForSizeConstant found in ' + FileName);
end;

procedure TMainForm.AboutSpeedButtonClick(Sender: TObject);
begin
 AboutForm.ShowModal;
end;

function GetFunctionSize(FunctionName : AnsiString) : Integer;
var
 RowNo, RowNoMax : Integer;
 S : AnsiString;

begin
 Result := 9999;//Workaround for false compiler warning
 if FunctionName = '' then
  raise Exception.Create('Function name is ''');
 RowNoMax := MainForm.FunctionSizesStringGrid.RowCount;
 for RowNo := 0 to RowNoMax do
  begin
   S := MainForm.FunctionSizesStringGrid.Cells[0,RowNo];
   if S = FunctionName then
    begin
     Result := StrToInt(MainForm.FunctionSizesStringGrid.Cells[1,RowNo]);
     Break;
    end;
   if RowNo = RowNoMax then
    raise Exception.Create('Function size not found: ' + FunctionName);
  end;
end;

function GetAuthorName(FunctionName : AnsiString) : AnsiString;
var
 Pos1, Pos2 : Integer;
begin
 Pos1 := CharPosEY('_', FunctionName, 1);
 Pos2 := CharPosEY('_', FunctionName, 2);
 Result := UpperCase(Copy(FunctionName, Pos1+1, Pos2-Pos1-1));
 if (Result = 'IA32') or (Result = 'Pas') or
    (Result = 'PAS') or (Result = 'MMX') or
    (Result = 'IA32ext') or (Result = 'SSE') or
    (Result = 'SSE2') or (Result = 'SSE3') then
  //raise Exception.Create('Invalid authorname');
  begin
   Pos1 := CharPosEY('_', FunctionName, 2);
   Pos2 := CharPosEY('_', FunctionName, 3);
   Result := UpperCase(Copy(FunctionName, Pos1+1, Pos2-Pos1-1));
  end;
end;

function GetWinnerFunctionName(StringGrid : TStringGrid) : AnsiString;
var
 MaxCol, MinSize, Size1, MinSizeRowNo, Bench2, RowNo2, RowNo3, RowNo4, RefBench: Integer;
 S1,S2, FunctionName1, FunctionName2, AuthorName, AuthorName1, AuthorName2,
 BenchStr1, BenchStr2, PostFix : Ansistring;
 Delta: Double;
label
 Start;

begin
 if StringGrid.RowCount < 2 then
  begin
   Result := StringGrid.Cells[0,0];
   Exit;
  end;
 //If fastest functions are within 1% in speed then the smallest wins.
 MinSizeRowNo := 0; //For compiler
 RowNo2 := -1;
 MaxCol := StringGrid.ColCount - 1;
 MinSize := MaxInt;
 //Get speed of fastest function
 if not OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
  begin
   RefBench := StrToInt(StringGrid.Cells[MaxCol, 0]);
   repeat
    Inc(RowNo2);
    S1 := StringGrid.Cells[MaxCol, RowNo2];
    S2 := StringGrid.Cells[MaxCol, RowNo2 + 1];
    FunctionName1 := StringGrid.Cells[0, RowNo2];
    FunctionName2 := StringGrid.Cells[0, RowNo2 + 1];
    Size1 := GetFunctionSize(FunctionName1);
    if Size1 < MinSize then
     begin
      MinSize := Size1;
      MinSizeRowNo := RowNo2;
     end;
    Bench2 := StrToInt(S2);
    Delta := Abs(100 * (RefBench - Bench2) / (0.5 * (RefBench + Bench2)));
    //Continue seach until function is > 1% slower than ref function=fastest function
   until Delta > 1;
  end
 else
  begin
   RowNo3 := -1;
   repeat
    Inc(RowNo3);
    FunctionName1 := StringGrid.Cells[0, RowNo3];
    AuthorName := GetAuthorName(FunctionName1);
    RefBench := StrToInt(StringGrid.Cells[MaxCol, RowNo3]);
   until (AuthorName <> 'RTL');
   Dec(RowNo3);
   repeat
   Start :
    Inc(RowNo3);
    FunctionName1 := StringGrid.Cells[0, RowNo3];
    AuthorName1 := GetAuthorName(FunctionName1);
    if AuthorName1 = 'RTL' then
     goto Start;
    Size1 := GetFunctionSize(FunctionName1);
    BenchStr1 := StringGrid.Cells[MaxCol, RowNo3];
    //Remember smallest size and the rowno it is in
    if Size1 < MinSize then
     begin
      MinSize := Size1;
      MinSizeRowNo := RowNo3;
     end;
    //Examine next non RTL functions benchmark for use in termination
    RowNo4 := RowNo3;
    repeat
     Inc(RowNo4);
     FunctionName2 := StringGrid.Cells[0, RowNo4];
     BenchStr2 := StringGrid.Cells[MaxCol, RowNo4];
     AuthorName2 := GetAuthorName(FunctionName2);
    until (AuthorName2 <> 'RTL');
    Bench2 := StrToInt(BenchStr2);
    Delta := Abs(100 * (RefBench - Bench2) / (0.5 * (RefBench + Bench2)));
    //Continue seach until function is > 1% slower than ref function=fastest function
   until Delta > 1;
  end;
 Result := StringGrid.Cells[0, MinSizeRowNo];
 //Remove _a, _b, _c and _d postfixes.
 PostFix := Copy(Result, Length(Result)-1, 2);
 if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
  Result := Copy(Result, 1, Length(Result)-2);
end;

function GetInstructionSet(FunctionName : AnsiString) : AnsiString;
var
 Pos1, Pos2 : Integer;
begin
 Pos1 := CharPosEY('_', FunctionName, 2);
 Pos2 := CharPosEY('_', FunctionName, 3);
 if Pos2 = 0 then
  Pos2 := Length(FunctionName)+1;
 Result := Copy(FunctionName, Pos1+1, Pos2-Pos1-1);
 if (Result <> 'IA32') and (Result <> 'Pas') and
    (Result <> 'PAS') and (Result <> 'MMX') and
    (Result <> 'IA32ext') and (Result <> 'SSE') and
    (Result <> 'SSE2') and (Result <> 'SSE3') then
  //raise Exception.Create('Invalid instructionset');
  begin
   Pos1 := CharPosEY('_', FunctionName, 1);
   Pos2 := CharPosEY('_', FunctionName, 2);
   Result := Copy(FunctionName, Pos1+1, Pos2-Pos1-1);
  end;
end;

procedure TMainForm.GetWinnersButtonClick(Sender: TObject);
var
 RowNo, RowNo1 : Integer;
 WinnerfunctionName, FunctionName, InstructionSet, AuthorName, PostFix : AnsiString;
label
 Start1, Start2, Start3, Start4, Start5, Start6, Start7, Start8, Start9, Start10,
 Start11, Start12, Start13, Start14;

begin
 RowNo1 := 0;
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'Penryn';
 WinnerfunctionName := GetWinnerFunctionName(PenrynStringGrid);
 WinnersStringGrid.Cells[1,RowNo1] := WinnerfunctionName;
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'Northwood';
 WinnerfunctionName := GetWinnerFunctionName(NorthwoodStringGrid);
 WinnersStringGrid.Cells[1,RowNo1] := WinnerfunctionName;
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'Yonah';
 WinnerfunctionName := GetWinnerFunctionName(YonahStringGrid);
 WinnersStringGrid.Cells[1,RowNo1] := WinnerfunctionName;
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'Conroe';
 WinnerfunctionName := GetWinnerFunctionName(ConroeStringGrid);
 WinnersStringGrid.Cells[1,RowNo1] := WinnerfunctionName;
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'Phenom';
 WinnerfunctionName := GetWinnerFunctionName(PhenomStringGrid);
 WinnersStringGrid.Cells[1,RowNo1] := WinnerfunctionName;
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'AMD 64 X2';
 WinnerfunctionName := GetWinnerFunctionName(AMD64X2StringGrid);
 WinnersStringGrid.Cells[1,RowNo1] := WinnerfunctionName;
 Inc(RowNo1);
 //Find IA32 Size Penalty winner
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'IA32 Size Penalty';
 RowNo := -1;
 repeat
Start1 :
  Inc(RowNo);
  FunctionName := BlendedSizePenaltyStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start1;
   end;
 until (InstructionSet = 'IA32') or
       (InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedSizePenaltyStringGrid.RowCount-1);
 if (RowNo = BlendedSizePenaltyStringGrid.RowCount-1) and
    (InstructionSet <> 'IA32') and
    (InstructionSet <> 'Pas') and
    (InstructionSet <> 'PAS') then
  begin
   //No Pascal or IA32 function found
   WinnersStringGrid.Cells[1,RowNo1] := '';
  end
 else
  begin
   //Remove _a, _b, _c and _d postfixes.
   PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
   if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
    FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
   WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
  end;
 //Find IA32 winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'IA32';
 RowNo := -1;
 repeat
Start2 :
  Inc(RowNo);
  FunctionName := BlendedStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start2;
   end;
 until (InstructionSet = 'IA32') or
       (InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedStringGrid.RowCount-1);
 if (RowNo = BlendedStringGrid.RowCount-1) and
    (InstructionSet <> 'IA32') and
    (InstructionSet <> 'Pas') and
    (InstructionSet <> 'PAS') then
  begin
   //No Pascal or IA32 function found
   WinnersStringGrid.Cells[1,RowNo1] := '';
  end
 else
  begin
   //Remove _a, _b, _c and _d postfixes.
   PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
   if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
    FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
   WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
  end;
 {
 //Find IA32ext Size Penalty winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'IA32ext Size Penalty';
 RowNo := -1;
 repeat
 Start4 :
  Inc(RowNo);
  FunctionName := BlendedSizePenaltyStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start4;
   end;
 until (InstructionSet = 'IA32') or
       (InstructionSet = 'IA32Ext') or
       (InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedSizePenaltyStringGrid.RowCount-1);
 //Remove _a, _b, _c and _d postfixes.
 PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
 if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
  FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
 WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
 }
 {
 //Find IA32ext winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'IA32ext';
 RowNo := -1;
 repeat
Start5 :
  Inc(RowNo);
  FunctionName := BlendedStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start5;
   end;
 until (InstructionSet = 'IA32ext') or
       (RowNo >= BlendedStringGrid.RowCount-1);
 if (RowNo = BlendedStringGrid.RowCount-1) and
    (InstructionSet <> 'IA32ext') then
  begin
   //No Pascal or IA32 function found
   WinnersStringGrid.Cells[1,RowNo1] := '';
  end
 else
  begin
   //Remove _a, _b, _c and _d postfixes.
   PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
   if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
    FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
   WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
  end;
 }
 //Find MMX Size Penalty winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'MMX Size Penalty';
 RowNo := -1;
 repeat
 Start6 :
  Inc(RowNo);
  FunctionName := BlendedSizePenaltyStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start6;
   end;
 until (InstructionSet = 'IA32') or
       (InstructionSet = 'IA32Ext') or
       (InstructionSet = 'MMX') or
       (InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedSizePenaltyStringGrid.RowCount-1);
 //Remove _a, _b, _c and _d postfixes.
 PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
 if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
  FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
 WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
 //Find MMX  winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'MMX';
 RowNo := -1;
 repeat
 Start7 :
  Inc(RowNo);
  FunctionName := BlendedStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start7;
   end;
 until (InstructionSet = 'IA32') or
       (InstructionSet = 'IA32Ext') or
       (InstructionSet = 'MMX') or
       (InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedStringGrid.RowCount-1);
 { TODO 2 -oDKC -cBug : Handle situation where no functions is found for given target }
 //Remove _a, _b, _c and _d postfixes.
 PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
 if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
  FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
 WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
 {
 //Find SSE Size Penalty winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'SSE Size Penalty';
 RowNo := -1;
 repeat
 Start8 :
  Inc(RowNo);
  FunctionName := BlendedSizePenaltyStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start8;
   end;
 until (InstructionSet = 'IA32') or
       (InstructionSet = 'IA32Ext') or
       (InstructionSet = 'MMX') or
       (InstructionSet = 'SSE') or
       (InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedSizePenaltyStringGrid.RowCount-1);
 //Remove _a, _b, _c and _d postfixes.
 PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
 if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
  FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
 WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
 }
 //Find SSE winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'SSE';
 RowNo := -1;
 repeat
 Start9 :
  Inc(RowNo);
  FunctionName := BlendedStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start9;
   end;
 until (InstructionSet = 'IA32') or
       (InstructionSet = 'IA32Ext') or
       (InstructionSet = 'MMX') or
       (InstructionSet = 'SSE') or
       (InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedStringGrid.RowCount-1);
 //Remove _a, _b, _c and _d postfixes.
 PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
 if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
  FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
 WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
 {
 //Find SSE2 Size Penalty winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'SSE2 Size Penalty';
 RowNo := -1;
 repeat
 Start10 :
  Inc(RowNo);
  FunctionName := BlendedSizePenaltyStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start10;
   end;
 until (InstructionSet = 'IA32') or
       (InstructionSet = 'IA32Ext') or
       (InstructionSet = 'MMX') or
       (InstructionSet = 'SSE') or
       (InstructionSet = 'SSE2') or
       (InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedSizePenaltyStringGrid.RowCount-1);
 //Remove _a, _b, _c and _d postfixes.
 PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
 if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
  FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
 WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
 }
 //Find SSE2 winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'SSE2';
 RowNo := -1;
 repeat
 Start11 :
  Inc(RowNo);
  FunctionName := BlendedStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start11;
   end;
 until (InstructionSet = 'IA32') or
       (InstructionSet = 'IA32Ext') or
       (InstructionSet = 'MMX') or
       (InstructionSet = 'SSE') or
       (InstructionSet = 'SSE2') or
       (InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedStringGrid.RowCount-1);
 //Remove _a, _b, _c and _d postfixes.
 PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
 if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
  FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
 WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
 {
 //Find SSE3 Size Penalty winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'SSE3 Size Penalty';
 RowNo := -1;
 repeat
 Start12 :
  Inc(RowNo);
  FunctionName := BlendedSizePenaltyStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start12;
   end;
 until (InstructionSet = 'IA32') or
       (InstructionSet = 'IA32Ext') or
       (InstructionSet = 'MMX') or
       (InstructionSet = 'SSE') or
       (InstructionSet = 'SSE2') or
       (InstructionSet = 'SSE3') or
       (InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedSizePenaltyStringGrid.RowCount-1);
 //Remove _a, _b, _c and _d postfixes.
 PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
 if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
  FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
 WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
 }
 //Find SSE3 winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'SSE3';
 RowNo := -1;
 repeat
 Start13 :
  Inc(RowNo);
  FunctionName := BlendedStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start13;
   end;
 until (InstructionSet = 'IA32') or
       (InstructionSet = 'IA32Ext') or
       (InstructionSet = 'MMX') or
       (InstructionSet = 'SSE') or
       (InstructionSet = 'SSE2') or
       (InstructionSet = 'SSE3') or
       (InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedStringGrid.RowCount-1);
 //Remove _a, _b, _c and _d postfixes.
 PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
 if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
  FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
 WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
 {
 //Find SSSE3 Size Penalty winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'SSSE3 Size Penalty';
 RowNo := -1;
 repeat
 Start12 :
  Inc(RowNo);
  FunctionName := BlendedSizePenaltyStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start12;
   end;
 until (InstructionSet = 'IA32') or
       (InstructionSet = 'IA32Ext') or
       (InstructionSet = 'MMX') or
       (InstructionSet = 'SSE') or
       (InstructionSet = 'SSE2') or
       (InstructionSet = 'SSE3') or
       (InstructionSet = 'SSSE3') or
       (InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedSizePenaltyStringGrid.RowCount-1);
 //Remove _a, _b, _c and _d postfixes.
 PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
 if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
  FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
 WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
 }
  //Find SSSE3 winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'SSSE3';
 RowNo := -1;
 repeat
 Start3 :
  Inc(RowNo);
  FunctionName := BlendedStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start3;
   end;
 until (InstructionSet = 'IA32') or
       (InstructionSet = 'IA32Ext') or
       (InstructionSet = 'MMX') or
       (InstructionSet = 'SSE') or
       (InstructionSet = 'SSE2') or
       (InstructionSet = 'SSE3') or
       (InstructionSet = 'SSSE3') or
       (InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedStringGrid.RowCount-1);
 //Remove _a, _b, _c and _d postfixes.
 PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
 if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
  FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
 WinnersStringGrid.Cells[1,RowNo1] := FunctionName;

 //Find Pascal Size Penalty winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'Pascal Size Penalty';
 RowNo := -1;
 repeat
 Start14 :
  Inc(RowNo);
  FunctionName := BlendedSizePenaltyStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start14;
   end;
  until(InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedSizePenaltyStringGrid.RowCount-1);
 if (RowNo = BlendedSizePenaltyStringGrid.RowCount-1) and
    (InstructionSet <> 'PAS') and
    (InstructionSet <> 'Pas') then
  begin
   //No Pascal function found
   WinnersStringGrid.Cells[1,RowNo1] := '';
  end
 else
  begin
   //Remove _a, _b, _c and _d postfixes.
   PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
   if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
    FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
   WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
  end;
 //Find Pascal winner
 Inc(RowNo1);
 WinnersStringGrid.RowCount := RowNo1+1;
 WinnersStringGrid.Cells[0,RowNo1] := 'Pascal';
 RowNo := -1;
 repeat
 Start4 :
  Inc(RowNo);
  FunctionName := BlendedStringGrid.Cells[0, RowNo];
  InstructionSet := GetInstructionSet(FunctionName);
  if OptionsForm.ExcludeRTLFunctionCheckBox.Checked then
   begin
    AuthorName := GetAuthorName(FunctionName);
    if AuthorName = 'RTL' then
     goto Start4;
   end;
  until(InstructionSet = 'Pas') or
       (InstructionSet = 'PAS') or
       (RowNo >= BlendedStringGrid.RowCount-1);
 if (RowNo = BlendedStringGrid.RowCount-1) and
    (InstructionSet <> 'Pas') and
    (InstructionSet <> 'PAS') then
  begin
   //No Pascal function found
   WinnersStringGrid.Cells[1,RowNo1] := '';
  end
 else
  begin
   //Remove _a, _b, _c and _d postfixes.
   PostFix := Copy(FunctionName, Length(FunctionName)-1, 2);
   if (PostFix = '_a') or (PostFix = '_b') or (PostFix = '_c') or (PostFix = '_d') then
    FunctionName := Copy(FunctionName, 1, Length(FunctionName)-2);
   WinnersStringGrid.Cells[1,RowNo1] := FunctionName;
  end;
 WinnersStringGrid.ColWidths[0] := 125;
 WinnersStringGrid.ColWidths[1] := 150;
 GivePointsButton.Enabled := True;
end;

procedure TMainForm.GivePointsButtonClick(Sender: TObject);
var
 RowNo1, RowNo2, TargetPoints, WinnersPoints, TotalPoints, Targets, Winners,
 Points1, Points2, ColNo1: Integer;
 AuthorName, FunctionName, S, S1, S2, S3, Temp: AnsiString;

 AuthorArray : array[1..MaxAuthors] of TAuthor;
 NrOfAuthors : Integer;
 Swap : Boolean;
 I : Integer;
 IniFile : TIniFile;
const
 PasNoOfTargets : Integer = 16;    //All targets
 IA32NoOfTargets : Integer = 14;   //All targets except 2 Pas targets
 IA32ExtNoOfTargets : Integer = 12;//All targets except 2 Pas and 2 IA32 targets
 MMXNoOfTargets : Integer = 12;    //All 6 CPU targets + MMX, MMX size penalty, SSE, SSE2, SSE3, SSSE3
 SSENoOfTargets : Integer = 10;    //All 6 CPU targets + SSE, SSE2, SSE3, SSSE3
 SSE2NoOfTargets : Integer = 9;    //All 6 CPU targets +  SSE2, SSE3, SSSE2
 SSE3NoOfTargets : Integer = 6;    //Penryn, Yonah, Phenom X2, Conroe, SSE3, SSSE3
 SSSE3NoOfTargets : Integer = 2;   //Conroe, SSSE3

begin
 PointsStringGrid.ColWidths[0] := 125;
 PointsStringGrid.ColWidths[1] := 50;
 PointsStringGrid.ColWidths[2] := 50;
 PointsStringGrid.ColWidths[3] := 50;
 //Load authors from author.ini
 FillChar(AuthorArray, SizeOf(AuthorArray), 0);
 IniFile := TIniFile.Create(AuthorFileName);
 i := 1;
 s := IniFile.ReadString('Authors', Format('Initials%d', [i]), '');
 while (s<>'') do
  begin
   AuthorArray[i].Initials := s;
   AuthorArray[i].Name := IniFile.ReadString('Authors', Format('Name%d', [i]), '');
   Inc(i);
   s := IniFile.ReadString('Authors', Format('Initials%d', [i]), '');
  end;
 IniFile.Free;
 NrOfAuthors := i-1;
 //Find participants
 for RowNo1 := 0 to BlendedStringGrid.RowCount-1 do
  begin
   FunctionName := BlendedStringGrid.Cells[0,RowNo1];
   AuthorName := GetAuthorName(FunctionName);
   for i := 1 to NrOfAuthors do
    begin
     if (AuthorName<>'') and (AuthorArray[i].Initials=AuthorName) then
      begin
       AuthorArray[i].IsPresent := True;
       break;
      end;
    end;
  end;
 //Add authors to PointsStringGrid
 RowNo2 := -1;
 for i := 1 to NrOfAuthors do
  begin
   if AuthorArray[i].IsPresent then
    begin
     Inc(RowNo2);
     PointsStringGrid.RowCount := RowNo2+1;
     PointsStringGrid.Cells[0,RowNo2] := AuthorArray[i].Name;
    end;
  end;
 //Count targets
 for RowNo1 := 0 to BlendedStringGrid.RowCount-1 do
  begin
   FunctionName := BlendedStringGrid.Cells[0,RowNo1];
   AuthorName := GetAuthorName(FunctionName);
   for i := 1 to NrOfAuthors do
    begin
     if (AuthorName<>'') and (AuthorArray[i].Initials=AuthorName) then
      begin
       if (Pos('Pas', FunctionName) <> 0) or (Pos('PAS', FunctionName) <> 0) then
        AuthorArray[i].NrOfTargets := Max(AuthorArray[i].NrOfTargets, PasNoOfTargets)
       else if Pos('IA32', FunctionName) <> 0 then
        AuthorArray[i].NrOfTargets := Max(AuthorArray[i].NrOfTargets, IA32NoOfTargets)
       else if Pos('IA32Ext', FunctionName) <> 0 then
        AuthorArray[i].NrOfTargets := Max(AuthorArray[i].NrOfTargets, IA32ExtNoOfTargets)
       else if Pos('MMX', FunctionName) <> 0 then
        AuthorArray[i].NrOfTargets := Max(AuthorArray[i].NrOfTargets, MMXNoOfTargets)
       else if Pos('SSE', FunctionName) <> 0 then
        AuthorArray[i].NrOfTargets := Max(AuthorArray[i].NrOfTargets, SSENoOfTargets)
       else if Pos('SSE2', FunctionName) <> 0 then
        AuthorArray[i].NrOfTargets := Max(AuthorArray[i].NrOfTargets, SSE2NoOfTargets)
       else if Pos('SSE3', FunctionName) <> 0 then
        AuthorArray[i].NrOfTargets := Max(AuthorArray[i].NrOfTargets, SSE3NoOfTargets);
       break;
      end;
    end;
  end;
 //Give points for targets
  for i := 1 to NrOfAuthors do
   begin
    if (AuthorArray[i].IsPresent) then
     begin
      RowNo2 := -1;
      repeat
       Inc(RowNo2);
       S := PointsStringGrid.Cells[0,RowNo2];
      until (S = AuthorArray[i].Name);
      PointsStringGrid.Cells[1,RowNo2] := IntToStr(AuthorArray[i].NrOfTargets);
     end;
   end;
 //Count winners
 for RowNo1 := 0 to WinnersStringGrid.RowCount-1 do
  begin
   FunctionName := WinnersStringGrid.Cells[1,RowNo1];
   AuthorName := GetAuthorName(FunctionName);
   for i := 1 to NrOfAuthors do
    begin
     if (AuthorName<>'') and (AuthorArray[i].Initials=AuthorName) then
      begin
       Inc(AuthorArray[i].NrOfWinners);
       break;
      end;
    end;
  end;
 //Give points for winners
 for i := 1 to NrOfAuthors do
  begin
   if (AuthorArray[i].IsPresent) then
    begin
     RowNo2 := -1;
     repeat
      Inc(RowNo2);
      S := PointsStringGrid.Cells[0,RowNo2];
     until Pos(AuthorArray[i].Name, S) <> 0;
     PointsStringGrid.Cells[2,RowNo2] := IntToStr(AuthorArray[i].NrOfWinners);
    end;
  end;
 //Sum points
 for RowNo1 := 0 to PointsStringGrid.RowCount-1 do
  begin
   S1 := PointsStringGrid.Cells[1,RowNo1];
   if S1 <> '' then
    Targets := StrToInt(S1)
   else
    Targets := 0;
   TargetPoints := Targets;
   S2 := PointsStringGrid.Cells[2,RowNo1];
   if S2 <> '' then
    Winners := StrToInt(S2)
   else
    Winners := 0;
   WinnersPoints := Winners * 10;
   TotalPoints := TargetPoints + WinnersPoints;
   S3 := IntToStr(TotalPoints);
   PointsStringGrid.Cells[3,RowNo1] := S3;
  end;
 //Sort by points
 repeat
  Swap := False;
  for RowNo2 := 0 to PointsStringGrid.RowCount-2 do
   begin
    Points1 := StrToInt(PointsStringGrid.Cells[3, RowNo2]);
    Points2 := StrToInt(PointsStringGrid.Cells[3, RowNo2+1]);
    if Points1 < Points2 then
     begin
      Swap := True;
      for ColNo1 := 0 to PointsStringGrid.ColCount do
       begin
        Temp := PointsStringGrid.Cells[ColNo1, RowNo2];
        PointsStringGrid.Cells[ColNo1, RowNo2] := PointsStringGrid.Cells[ColNo1, RowNo2+1];
        PointsStringGrid.Cells[ColNo1, RowNo2+1] := Temp;
       end;
     end;
   end;
 until (Swap = False);
 CreateSpreadsheetsButton.Enabled := True;
end;

procedure TMainForm.CalculateSpeedVersusSizeTableButtonClick(Sender: TObject);
var
 PenaltyForSize, Row, RowNo, WinnerRow, Speed, MaxSpeed, RelativeSpeed, MinSize,
 Size, OldPenaltyForSize, OldSize, OldSpeed, OldRelativeSpeed: Integer;
 S, FunctionName, WinnerFunctionName, OldWinnerFunctionName, PenaltyForSizeRange,
 Instructionset, AuthorName, AuthorNameUpper, SelectedAuthorName : AnsiString;

begin
 RichEdit1.Clear;
 RichEdit1.Paragraph.TabCount := 5;
 RichEdit1.Paragraph.Tab[0] := 45;
 RichEdit1.Paragraph.Tab[1] := 160;
 RichEdit1.Paragraph.Tab[2] := 185;
 RichEdit1.Paragraph.Tab[3] := 215;
 RichEdit1.Lines.Add('SizePenalty' + #9
                   + 'WinnerFunction' + #9
                   + 'Size' + #9
                   + 'Speed' + #9
                   + 'RelativeSpeed');
 CalculateSpeedVersusSizeTableButton.Caption := 'Running';
 StringGrid2.ColCount := 5;
 StringGrid2.ColWidths[0] := 70;
 StringGrid2.ColWidths[1] := 150;
 StringGrid2.ColWidths[2] := 60;
 StringGrid2.ColWidths[3] := 60;
 Row := 0;
 Size := 0;
 Speed := 0;
 OldPenaltyForSize := 0;
 RelativeSpeed := 0;
 MinSize := MaxInt;
 for RowNo := 0 to BlendedSizePenaltyStringGrid.RowCount-1 do
  begin
   FunctionName := BlendedSizePenaltyStringGrid.Cells[0,RowNo];
   Instructionset := GetInstructionSet(FunctionName);
   AuthorName := GetAuthorName(FunctionName);
   SelectedAuthorName := AuthorRadioGroup.Items[AuthorRadioGroup.ItemIndex];
   AuthorNameUpper := UpperCase(AuthorName);
   if (AuthorNameUpper = SelectedAuthorName) or
      (SelectedAuthorName = 'All') then
    begin
     S := BlendedSizePenaltyStringGrid.Cells[8,RowNo];
     case InstructionsetRadioGroup.ItemIndex of
      0 :
       begin
        if (Instructionset = 'Pas') or
           (Instructionset = 'PAS') then
         begin
          Size := StrToInt(S);
          MinSize := Min(MinSize, Size);
         end;
       end;
      1 :
       begin
        if (Instructionset = 'Pas') or
           (Instructionset = 'PAS') or
           (Instructionset = 'IA32') then
         begin
          Size := StrToInt(S);
          MinSize := Min(MinSize, Size);
         end;
       end;
      2 :
       begin
        if (Instructionset = 'Pas') or
           (Instructionset = 'PAS') or
           (Instructionset = 'IA32') or
           (Instructionset = 'IA32ext') then
         begin
          Size := StrToInt(S);
          MinSize := Min(MinSize, Size);
         end;
       end;
      3 :
       begin
        if (Instructionset = 'Pas') or
           (Instructionset = 'PAS') or
           (Instructionset = 'IA32') or
           (Instructionset = 'IA32ext') or
           (Instructionset = 'MMX') then
         begin
          Size := StrToInt(S);
          MinSize := Min(MinSize, Size);
         end;
       end;
      4 :
       begin
        if (Instructionset = 'Pas') or
           (Instructionset = 'PAS') or
           (Instructionset = 'IA32') or
           (Instructionset = 'IA32ext') or
           (Instructionset = 'MMX') or
           (Instructionset = 'SSE') then
         begin
          Size := StrToInt(S);
          MinSize := Min(MinSize, Size);
         end;
       end;
      5 :
       begin
        if (Instructionset = 'Pas') or
           (Instructionset = 'PAS') or
           (Instructionset = 'IA32') or
           (Instructionset = 'IA32ext') or
           (Instructionset = 'MMX') or
           (Instructionset = 'SSE') or
           (Instructionset = 'SSE2') then
         begin
          Size := StrToInt(S);
          MinSize := Min(MinSize, Size);
         end;
       end;
      6 :
       begin
        if (Instructionset = 'Pas') or
           (Instructionset = 'PAS') or
           (Instructionset = 'IA32') or
           (Instructionset = 'IA32ext') or
           (Instructionset = 'MMX') or
           (Instructionset = 'SSE') or
           (Instructionset = 'SSE2') or
           (Instructionset = 'SSE3') then
         begin
          Size := StrToInt(S);
          MinSize := Min(MinSize, Size);
         end;
       end;
     end;
   end;
  end;
 if ChallengeName = 'Move' then
  MaxSpeed := 0
 else
  MaxSpeed := MaxInt;
 PenaltyForSize := -1;
 //Do until we get the smallest XXXX function by author as winner
 repeat
  Inc(PenaltyForSize);
  PenaltyForSizeLabeledEdit2.Text := IntToStr(PenaltyForSize);
  Update;
  StringGrid2.RowCount := Row+1;
  PenaltyForSizeLabeledEdit.Text := IntToStr(PenaltyForSize);
  CalculateBlendedSizePenaltyButtonClick(nil);
  StringGrid2.Cells[0, Row] := PenaltyForSizeLabeledEdit.Text;
  WinnerRow := -1;
  case InstructionsetRadioGroup.ItemIndex of
   0 :
    begin
     repeat
      Inc(WinnerRow);
      FunctionName := BlendedSizePenaltyStringGrid.Cells[0,WinnerRow];
      AuthorName := GetAuthorName(FunctionName);
      if (AuthorName = SelectedAuthorName) or (SelectedAuthorName = 'All') then
       begin
        Instructionset := GetInstructionSet(FunctionName);
        if (OptionsForm.ExcludeRTLFunctionCheckBox.Checked) and (AuthorName = 'RTL') then
         Continue;
        if (Instructionset = 'Pas') or (Instructionset = 'PAS') then
         Break;
       end;
     until (False);
    end;
   1 :
    begin
     repeat
      Inc(WinnerRow);
      FunctionName := BlendedSizePenaltyStringGrid.Cells[0,WinnerRow];
      AuthorName := GetAuthorName(FunctionName);
      if (AuthorName = SelectedAuthorName) or (SelectedAuthorName = 'All') then
       begin
        Instructionset := GetInstructionSet(FunctionName);
        if (OptionsForm.ExcludeRTLFunctionCheckBox.Checked) and (AuthorName = 'RTL') then
         Continue;
        if (Instructionset = 'Pas') or (Instructionset = 'PAS') or
           (Instructionset = 'IA32') then
         Break;
       end;
     until (False);
    end;
   2 :
    begin
     repeat
      Inc(WinnerRow);
      FunctionName := BlendedSizePenaltyStringGrid.Cells[0,WinnerRow];
      AuthorName := GetAuthorName(FunctionName);
      if (AuthorName = SelectedAuthorName) or (SelectedAuthorName = 'All') then
       begin
        Instructionset := GetInstructionSet(FunctionName);
        if (Instructionset = 'Pas') or (Instructionset = 'PAS') or
           (Instructionset = 'IA32') or (Instructionset = 'IA32ext') then
         Break;
       end;
     until (False);
    end;
   3 :
    begin
     repeat
      Inc(WinnerRow);
      FunctionName := BlendedSizePenaltyStringGrid.Cells[0,WinnerRow];
      AuthorName := GetAuthorName(FunctionName);
      if (AuthorName = SelectedAuthorName) or (SelectedAuthorName = 'All') then
       begin
        Instructionset := GetInstructionSet(FunctionName);
        if (Instructionset = 'Pas') or (Instructionset = 'PAS') or
           (Instructionset = 'IA32') or (Instructionset = 'IA32ext') or
           (Instructionset = 'MMX') then
         Break;
       end;
     until (False);
    end;
   4 :
    begin
     repeat
      Inc(WinnerRow);
      FunctionName := BlendedSizePenaltyStringGrid.Cells[0,WinnerRow];
      AuthorName := GetAuthorName(FunctionName);
      if (AuthorName = SelectedAuthorName) or (SelectedAuthorName = 'All') then
       begin
        Instructionset := GetInstructionSet(FunctionName);
        if (Instructionset = 'Pas') or (Instructionset = 'PAS') or
           (Instructionset = 'IA32') or (Instructionset = 'IA32ext') or
           (Instructionset = 'MMX') or (Instructionset = 'SSE') then
         Break;
       end;
     until (False);
    end;
   5 :
    begin
     repeat
      Inc(WinnerRow);
      FunctionName := BlendedSizePenaltyStringGrid.Cells[0,WinnerRow];
      AuthorName := GetAuthorName(FunctionName);
      if (AuthorName = SelectedAuthorName) or (SelectedAuthorName = 'All') then
       begin
        Instructionset := GetInstructionSet(FunctionName);
        if (Instructionset = 'Pas') or (Instructionset = 'PAS') or
           (Instructionset = 'IA32') or (Instructionset = 'IA32ext') or
           (Instructionset = 'MMX') or (Instructionset = 'SSE') or
           (Instructionset = 'SSE2') then
         Break;
       end;
     until (False);
    end;
   6 :
    begin
     repeat
      Inc(WinnerRow);
      FunctionName := BlendedSizePenaltyStringGrid.Cells[0,WinnerRow];
      AuthorName := GetAuthorName(FunctionName);
      if (AuthorName = SelectedAuthorName) or (SelectedAuthorName = 'All') then
       begin
        Instructionset := GetInstructionSet(FunctionName);
        if (Instructionset = 'Pas') or (Instructionset = 'PAS') or
           (Instructionset = 'IA32') or (Instructionset = 'IA32ext') or
           (Instructionset = 'MMX') or (Instructionset = 'SSE') or
           (Instructionset = 'SSE2') or (Instructionset = 'SSE3') then
         Break;
       end;
     until (False);
    end;
  end;
  StringGrid2.Cells[1, Row] := BlendedSizePenaltyStringGrid.Cells[0,WinnerRow];
  StringGrid2.Cells[2, Row] := BlendedSizePenaltyStringGrid.Cells[8,WinnerRow];
  StringGrid2.Cells[3, Row] := BlendedSizePenaltyStringGrid.Cells[7,WinnerRow];
  OldSize := Size;
  OldSpeed := Speed;
  OldRelativeSpeed := RelativeSpeed;
  Size := StrToInt(BlendedSizePenaltyStringGrid.Cells[8,WinnerRow]);
  Speed := StrToInt(BlendedSizePenaltyStringGrid.Cells[7,WinnerRow]);
  if ChallengeName = 'Move' then
   begin
    MaxSpeed := Max(MaxSpeed, Speed);//Actually we get the fastest function in the first iteration
    RelativeSpeed := Round(100 * Speed / MaxSpeed);
   end
  else
   begin
    MaxSpeed := Min(MaxSpeed, Speed);//Actually we get the fastest function in the first iteration
    RelativeSpeed := Round(100 * MaxSpeed / Speed);
   end;
  StringGrid2.Cells[4, Row] := IntToStr(RelativeSpeed);
  OldWinnerFunctionName := WinnerFunctionName;
  WinnerFunctionName := StringGrid2.Cells[1, Row];
  if (WinnerFunctionName <> OldWinnerFunctionName) and (PenaltyForSize <> 0) then
   begin
    PenaltyForSizeRange := IntToStr(OldPenaltyForSize)+ '-' + IntToStr(PenaltyForSize-1);
    RichEdit1.Lines.Add(PenaltyForSizeRange + #9
                      + OldWinnerFunctionName + #9
                      + IntToStr(OldSize) + #9
                      + IntToStr(OldSpeed) + #9
                      + IntToStr(OldRelativeSpeed));
    OldPenaltyForSize := PenaltyForSize;
   end;
  Update;
  Inc(Row);
 until Size = MinSize;
 PenaltyForSizeRange := IntToStr(OldPenaltyForSize)+ '-' + IntToStr(PenaltyForSize);
 RichEdit1.Lines.Add(PenaltyForSizeRange + #9
                   + WinnerFunctionName + #9
                   + IntToStr(Size) + #9
                   + IntToStr(Speed) + #9
                   + IntToStr(RelativeSpeed));
 CalculateSpeedVersusSizeTableButton.Caption := 'Done';
end;

procedure TMainForm.CalcWinnerButtonClick(Sender: TObject);
begin
 PageControl1.ActivePage := WinnersTabSheet;
 CalculateBlendedButton.Click;
 CalculateBlendedSizePenaltyButton.Click;
 GetWinnersButton.Click;
 GivePointsButton.Click;
end;

procedure TMainForm.CloseBitBtnClick(Sender: TObject);
begin
 Self.Close;
end;

procedure TMainForm.LoadAndDoButtonClick(Sender: TObject);
begin
 LoadAndDoButton.Caption := 'Running';
 LoadAllButtonClick(nil);
 CalculateBlendedButtonClick(nil);
 CalculateBlendedSizePenaltyButtonClick(nil);
 GetWinnersButtonClick(nil);
 GivePointsButtonClick(nil);
 CalculateSpeedVersusSizeTableButtonClick(nil);
 LoadAndDoButton.Caption := 'Done';
end;

procedure KeepBestByAuthor(KeepFunctionsStringList: TStringList; StringGrid : TStringGrid);
var
 I1, J, NoOfAuthors : Integer;
 AuthorNamesArray : array of AnsiString;
 FunctionName1, AuthorName1, FunctionName2, AuthorName2, InstructionSet1 : AnsiString;
 AuthorInList : Boolean;

begin
 NoOfAuthors := 1;
 SetLength(AuthorNamesArray, NoOfAuthors);
 FunctionName1 := StringGrid.Cells[0, 0];
 AuthorName1 := GetAuthorName(FunctionName1);
 AuthorNamesArray[NoOfAuthors - 1] := AuthorName1;
 for I1 := 1 to StringGrid.RowCount - 2 do
  begin
   AuthorName1 := GetAuthorName(FunctionName1);
   InstructionSet1 := GetInstructionSet(FunctionName1);
   FunctionName2 := StringGrid.Cells[0, I1 + 1];
   AuthorName2 := GetAuthorName(FunctionName2);
   if AuthorName2 <> AuthorName1 then
    begin
     AuthorInList := False;
     for J := 0 to Length(AuthorNamesArray) - 1 do
      begin
       if AuthorName2 = AuthorNamesArray[J] then
        begin
         AuthorInList := True;
         Break;
        end;
      end;
     if not AuthorInList then
      begin
       KeepFunctionsStringList.Add(FunctionName2);
       Inc(NoOfAuthors);
       SetLength(AuthorNamesArray, NoOfAuthors);
       AuthorNamesArray[NoOfAuthors - 1] := AuthorName2;
       FunctionName1 := FunctionName2;
      end;
    end;
  end;
end;

procedure KeepBestByAuthorInstructionSet(KeepFunctionsStringList: TStringList; StringGrid : TStringGrid);
var
 I1, J : Integer;
 NoOfAuthors : Integer;
 AuthorNamesInstructionSetArray : array of TAuthorNameInstructionSet;
 FunctionName1, AuthorName1, FunctionName2, AuthorName2, InstructionSet1,
 InstructionSet2 : AnsiString;
 AuthorInList : Boolean;

begin
 NoOfAuthors := 1;
 SetLength(AuthorNamesInstructionSetArray, NoOfAuthors);
 FunctionName1 := StringGrid.Cells[0, 0];
 AuthorName1 := GetAuthorName(FunctionName1);
 InstructionSet1 := GetInstructionSet(FunctionName1);
 AuthorNamesInstructionSetArray[NoOfAuthors - 1].AuthorName := AuthorName1;
 AuthorNamesInstructionSetArray[NoOfAuthors - 1].InstructionSet := InstructionSet1;
 //Always keeo number one even if it not selected as winner due to the 1% rule (if less than 1 % diffrence in speed then smallest wins)
 KeepFunctionsStringList.Add(FunctionName1);
 Inc(NoOfAuthors);
 SetLength(AuthorNamesInstructionSetArray, NoOfAuthors);
 AuthorName1 := GetAuthorName(FunctionName1);
 InstructionSet1 := GetInstructionSet(FunctionName1);
 AuthorNamesInstructionSetArray[NoOfAuthors - 1].AuthorName := AuthorName1;
 AuthorNamesInstructionSetArray[NoOfAuthors - 1].InstructionSet := InstructionSet1;
 for I1 := 0 to StringGrid.RowCount - 2 do
  begin
   AuthorName1 := GetAuthorName(FunctionName1);
   InstructionSet1 := GetInstructionSet(FunctionName1);
   FunctionName2 := StringGrid.Cells[0, I1 + 1];
   AuthorName2 := GetAuthorName(FunctionName2);
   InstructionSet2 := GetInstructionSet(FunctionName2);
   if (AuthorName2 <> AuthorName1) or (InstructionSet1 <> InstructionSet2) then
    begin
     AuthorInList := False;
     for J := 0 to Length(AuthorNamesInstructionSetArray) - 1 do
      begin
       if (AuthorName2 = AuthorNamesInstructionSetArray[J].AuthorName) and
          (InstructionSet2 = AuthorNamesInstructionSetArray[J].InstructionSet) then
        begin
         AuthorInList := True;
         Break;
        end;
      end;
     if not AuthorInList then
      begin
       KeepFunctionsStringList.Add(FunctionName2);
       Inc(NoOfAuthors);
       SetLength(AuthorNamesInstructionSetArray, NoOfAuthors);
       AuthorNamesInstructionSetArray[NoOfAuthors - 1].AuthorName := AuthorName2;
       AuthorNamesInstructionSetArray[NoOfAuthors - 1].InstructionSet := InstructionSet2;
       FunctionName1 := FunctionName2;
      end;
    end;
  end;
end;

procedure TMainForm.RunButtonClick(Sender: TObject);
var
 KeepFunctionsStringList, AllFunctionsStringList, RemoveFunctionsStringList : TStringList;
 I1, I2, I3, I4, KeepListCount, AllListCount : Integer;
 FunctionName, KeepFunctionName, S1, S2, S3, S4, FunctionName1, FunctionName2 : AnsiString;
 Keep, Deleted : Boolean;

begin
 FunctionsToRemoveRichEdit.Clear;
 //Create a list of functions thare are candidates to be removed from the B&V
 KeepFunctionsStringList := TStringList.Create;
 AllFunctionsStringList := TStringList.Create;
 RemoveFunctionsStringList := TStringList.Create;
 //Make list of all functions
 for I1 := 0 to BlendedStringGrid.RowCount-1 do
  AllFunctionsStringList.Add(BlendedStringGrid.Cells[0,I1]);
 for I1 := 0 to PenrynStringGrid.RowCount-1 do
  AllFunctionsStringList.Add(PenrynStringGrid.Cells[0,I1]);
 for I1 := 0 to YonahStringGrid.RowCount-1 do
  AllFunctionsStringList.Add(YonahStringGrid.Cells[0,I1]);
 //Remove all duplicates
 AllFunctionsStringList.Sort;
 AllListCount := AllFunctionsStringList.Count;
 repeat
  Deleted := False;
  I2 := 0;
  while I2 <= AllListCount-2 do
   begin
    FunctionName1 := AllFunctionsStringList[I2];
    I3 := I2+1;
    while I3 <= AllListCount-1 do
     begin
      FunctionName2 := AllFunctionsStringList[I3];
      if FunctionName2 = FunctionName1 then
       begin
        AllFunctionsStringList.Delete(I3);
        AllListCount := AllFunctionsStringList.Count;
        Deleted := True;
       end;
      Inc(I3);
     end;
    Inc(I2);
   end;
 until (Deleted = False);
 //Keep all winners
 for I1 := 0 to WinnersStringGrid.RowCount-1 do
  begin
   KeepFunctionName := WinnersStringGrid.Cells[1,I1];
   if KeepFunctionName <> '' then
    begin
     KeepFunctionsStringList.Add(KeepFunctionName + '_a');
     KeepFunctionsStringList.Add(KeepFunctionName + '_b');
     KeepFunctionsStringList.Add(KeepFunctionName + '_c');
     KeepFunctionsStringList.Add(KeepFunctionName + '_d');
    end;
  end;
 //Keep all the best by an author on a target
 KeepBestByAuthor(KeepFunctionsStringList, PenrynStringGrid);
 KeepBestByAuthor(KeepFunctionsStringList, NorthwoodStringGrid);
 KeepBestByAuthor(KeepFunctionsStringList, YonahStringGrid);
 KeepBestByAuthor(KeepFunctionsStringList, ConroeStringGrid);
 KeepBestByAuthor(KeepFunctionsStringList, AMD64X2StringGrid);
 KeepBestByAuthor(KeepFunctionsStringList, PhenomStringGrid);
 KeepBestByAuthor(KeepFunctionsStringList, BlendedStringGrid);
 KeepBestByAuthor(KeepFunctionsStringList, BlendedSizePenaltyStringGrid);
 //Keep all the best by an author on a target for a given instruction set
 KeepBestByAuthorInstructionSet(KeepFunctionsStringList, PenrynStringGrid);
 KeepBestByAuthorInstructionset(KeepFunctionsStringList, NorthwoodStringGrid);
 KeepBestByAuthorInstructionset(KeepFunctionsStringList, YonahStringGrid);
 KeepBestByAuthorInstructionset(KeepFunctionsStringList, ConroeStringGrid);
 KeepBestByAuthorInstructionset(KeepFunctionsStringList, AMD64X2StringGrid);
 KeepBestByAuthorInstructionset(KeepFunctionsStringList, PhenomStringGrid);
 KeepBestByAuthorInstructionset(KeepFunctionsStringList, BlendedStringGrid);
 KeepBestByAuthorInstructionset(KeepFunctionsStringList, BlendedSizePenaltyStringGrid);
 //Keep all _a, _b, _c and _d versions
 for I2 := 0 to KeepFunctionsStringList.Count-1 do
  begin
   KeepFunctionName := KeepFunctionsStringList[I2];
   S1 := Copy(KeepFunctionName, Length(KeepFunctionName)-1, 2);
   if (S1 ='_a') or (S1 ='_b') or (S1 ='_c') or (S1 ='_d') then
    begin
     //Add the 3 other versions to keep list
     S2 := Copy(KeepFunctionName, 1, Length(KeepFunctionName)-2);
     for I3 := 0 to AllFunctionsStringList.Count-1 do
      begin
       FunctionName := AllFunctionsStringList[I3];
       S3 := Copy(FunctionName, 1, Length(FunctionName)-2);
       if S2 = S3 then
        begin
         S4 := Copy(FunctionName, Length(FunctionName)-1, 2);
         if S4 <> S1 then
          KeepFunctionsStringList.Add(FunctionName);
        end;
      end;
    end;
  end;
 //Remove all duplicates
 KeepFunctionsStringList.Sort;
 KeepListCount := KeepFunctionsStringList.Count;
 repeat
  Deleted := False;
  I2 := 0;
  while I2 <= KeepListCount-2 do
   begin
    FunctionName1 := KeepFunctionsStringList[I2];
    I3 := I2+1;
    while I3 <= KeepListCount-1 do
     begin
      FunctionName2 := KeepFunctionsStringList[I3];
      if FunctionName2 = FunctionName1 then
       begin
        KeepFunctionsStringList.Delete(I3);
        KeepListCount := KeepFunctionsStringList.Count;
        Deleted := True;
       end;
      Inc(I3);
     end;
    Inc(I2);
   end;
 until (Deleted = False);
 //Create list of functions to remove = All functions - functions to keep
 for I2 := 0 to AllFunctionsStringList.Count-1 do
  begin
   FunctionName := AllFunctionsStringList[I2];
   //Search for function name in keep list
   Keep := False;
   for I3 := 0 to KeepFunctionsStringList.Count-1 do
    begin
     KeepFunctionName := KeepFunctionsStringList[I3];
     if FunctionName = KeepFunctionName then
      begin
       Keep := True;
       Break;
      end;
    end;
   if not Keep then
    RemoveFunctionsStringList.Add(FunctionName);
  end;
 KeepFunctionsStringList.Sort;
 for I4 := 0 to KeepFunctionsStringList.Count-1 do
  begin
   FunctionsToKeepStringGrid.RowCount := I4+1;
   FunctionsToKeepStringGrid.Cells[0,I4] := KeepFunctionsStringList[I4];
  end;
 RemoveFunctionsStringList.Sort;
 for I4 := 0 to RemoveFunctionsStringList.Count-1 do
  begin
   FunctionsToRemoveStringGrid.RowCount := I4+1;
   FunctionsToRemoveStringGrid.Cells[0,I4] := RemoveFunctionsStringList[I4];
   FunctionsToRemoveRichEdit.Lines.Add(RemoveFunctionsStringList[I4]);
  end;
 KeepFunctionsStringList.Free;
 RemoveFunctionsStringList.Free;
 AllFunctionsStringList.Free;
 FunctionsToKeepStringGrid.ColWidths[0] := 160;
 FunctionsToRemoveStringGrid.ColWidths[0] := 160;
end;

procedure TMainForm.CalculateButtonClick(Sender: TObject);
var
 RowNo, AverageSubBench, SubBenchNo, I, SumSubbench : Integer;
 SumSubBenchArray : array of Integer;
begin
 { TODO 1 -oDKC -cBug : Add handling of 3,4,5,6 subbenchmarks }
 LoadAllButtonClick(nil);
 SubBenchWeightsStringGrid.ColCount := NoOfSubbenchmarks+1;
 for SubBenchNo := 1 to NoOfSubbenchmarks do
  SubBenchWeightsStringGrid.Cells[SubBenchNo, 0] := 'Subbench' + IntToStr(SubBenchNo);
 SubBenchWeightsStringGrid.Cells[0, 1] := 'Penryn';
 SubBenchWeightsStringGrid.Cells[0, 2] := 'Northwood';
 SubBenchWeightsStringGrid.Cells[0, 3] := 'Yonah';
 SubBenchWeightsStringGrid.Cells[0, 4] := 'Conroe';
 SubBenchWeightsStringGrid.Cells[0, 5] := 'AMD 64 X2';
 SubBenchWeightsStringGrid.Cells[0, 6] := 'AMD 64';
 for SubBenchNo := 1 to NoOfSubbenchmarks do
  begin
   SubBenchWeightsStringGrid.Cells[SubBenchNo, 1] := PenrynStringGrid.Cells[SubBenchNo+1, 0];
   SubBenchWeightsStringGrid.Cells[SubBenchNo, 2] := NorthwoodStringGrid.Cells[SubBenchNo+1, 0];
   SubBenchWeightsStringGrid.Cells[SubBenchNo, 3] := YonahStringGrid.Cells[SubBenchNo+1, 0];
   SubBenchWeightsStringGrid.Cells[SubBenchNo, 4] := ConroeStringGrid.Cells[SubBenchNo+1, 0];
   SubBenchWeightsStringGrid.Cells[SubBenchNo, 5] := AMD64X2StringGrid.Cells[SubBenchNo+1, 0];
   SubBenchWeightsStringGrid.Cells[SubBenchNo, 6] := PhenomStringGrid.Cells[SubBenchNo+1, 0];
  end;
 SetLength(SumSubBenchArray, NoOfSubbenchmarks);
 for I := 0 to NoOfSubbenchmarks - 1 do
  SumSubBenchArray[I] := 0;
 for RowNo := 1 to 6 do
  begin
   for SubBenchNo := 1 to NoOfSubbenchmarks do
    begin
     if SubBenchWeightsStringGrid.Cells[SubBenchNo, RowNo] <> '' then
      SumSubBenchArray[SubBenchNo-1] := SumSubBenchArray[SubBenchNo-1] + StrToInt(SubBenchWeightsStringGrid.Cells[SubBenchNo, RowNo]);
    end;
  end;
 for SubBenchNo := 1 to NoOfSubbenchmarks do
  SubBenchWeightsStringGrid.Cells[SubBenchNo, 7] := IntToStr(SumSubBenchArray[SubBenchNo-1]);
 SumSubbench := 0;
 for SubBenchNo := 1 to NoOfSubbenchmarks do
  SumSubbench := SumSubbench + SumSubBenchArray[SubBenchNo-1];
 AverageSubBench := Round(SumSubbench / NoOfSubbenchmarks);
 for SubBenchNo := 1 to NoOfSubbenchmarks do
  SubBenchWeightsStringGrid.Cells[SubBenchNo, 8] := FloatToStrF(SumSubBenchArray[SubBenchNo-1] / AverageSubBench, ffFixed, 9, 2);
end;

procedure TMainForm.LoadAndRunButtonClick(Sender: TObject);
begin
 LoadAndRunButton.Caption := 'Running';
 LoadAllButtonClick(nil);
 CalculateBlendedButtonClick(nil);
 CalculateBlendedSizePenaltyButtonClick(nil);
 GetWinnersButtonClick(nil);
 GivePointsButtonClick(nil);
 RunButtonClick(nil);
 LoadAndRunButton.Caption := 'Done';
end;

procedure TMainForm.CalculateBlendedButtonClick(Sender: TObject);
var
 RowNo1, RowNo2,SumBenchmark, ColNo1, Benchmark, SumBenchmark1, SumBenchmark2,
 BenchmarkCol, NumberOfNonSSE3Functions, MaxNumberOfNonSSE3Functions,
 BlendedRowNo, WinnerBenchmark, ColNo : Integer;
 FunctionName, FunctionName1, FunctionName2, BenchmarkResult1, BenchmarkResult2,
 Temp, S, BenchmarkStr, WinnerBenchmarkStr : AnsiString;
 Swap : Boolean;
 BenchmarkScale : Double;
  FastestBlendedStr: string;
  FastestBlended: Integer;
  RTLBlended: Integer;
  RowNo: Integer;
  AuthorName: string;
  RTLBlendedStr: string;
  BlendedSpeedUpOverRTL: double;
const
 REFBENCHVALUE : Integer = 1000;

begin
 //Benchmark results are always in the rightmost collum and there are the same number of collums in all tables if they contain data
 BenchmarkCol := PenrynStringGrid.ColCount-1;
 BenchmarkCol := Max(BenchmarkCol, PenrynStringGrid.ColCount-1);
 BenchmarkCol := Max(BenchmarkCol, NorthwoodStringGrid.ColCount-1);
 BenchmarkCol := Max(BenchmarkCol, YonahStringGrid.ColCount-1);
 BenchmarkCol := Max(BenchmarkCol, ConroeStringGrid.ColCount-1);
 BenchmarkCol := Max(BenchmarkCol, PhenomStringGrid.ColCount-1);
 BenchmarkCol := Max(BenchmarkCol, AMD64X2StringGrid.ColCount-1);
 BlendedStringGrid.ColCount := 2;
 //No of rows in BlendedGrid is the number of rows in non-empty Target Grids, excluding SSE3 functions
 BlendedStringGrid.RowCount := 1;
 MaxNumberOfNonSSE3Functions := 0;
 //Get functionnames and benchmark results from Penryn page
 NumberOfNonSSE3Functions := 0;
 if PenrynStringGrid.Cells[0, 0] <> '' then
  begin
   //Get winners benchmark
   WinnerBenchmarkStr := PenrynStringGrid.Cells[BenchmarkCol, 0];
   WinnerBenchmark := StrToInt(WinnerBenchmarkStr);
   BenchmarkScale := REFBENCHVALUE / WinnerBenchmark;
   BlendedRowNo := 0;
   for RowNo1 := 0 to PenrynStringGrid.RowCount-1 do
    begin
     FunctionName := PenrynStringGrid.Cells[0, RowNo1];
     //No Blended SSE3 targets
     if Pos('SSE3', FunctionName) = 0 then
      begin
       Inc(NumberOfNonSSE3Functions);
       MaxNumberOfNonSSE3Functions := Max(MaxNumberOfNonSSE3Functions, NumberOfNonSSE3Functions);
       BlendedStringGrid.RowCount := MaxNumberOfNonSSE3Functions;
       BlendedStringGrid.RowCount := Max(NumberOfNonSSE3Functions, BlendedStringGrid.RowCount);
       BlendedStringGrid.Cells[0, BlendedRowNo] := FunctionName;
       //BlendedStringGrid.Cells[1, BlendedRowNo] := PenrynStringGrid.Cells[BenchmarkCol, RowNo1];
       BenchmarkStr := PenrynStringGrid.Cells[BenchmarkCol, RowNo1];
       Benchmark := StrToInt(BenchmarkStr);
       Benchmark := Round(BenchmarkScale * Benchmark);
       BlendedStringGrid.Cells[1, BlendedRowNo] := IntToStr(Benchmark);
       Inc(BlendedRowNo);
      end;
    end;
   //Sort by name
   repeat
    Swap := False;
    for RowNo2 := 0 to BlendedStringGrid.RowCount-2 do
     begin
      FunctionName1 := BlendedStringGrid.Cells[0, RowNo2];
      FunctionName2 := BlendedStringGrid.Cells[0, RowNo2+1];
      BenchmarkResult1 := BlendedStringGrid.Cells[1, RowNo2];
      BenchmarkResult2 := BlendedStringGrid.Cells[1, RowNo2+1];
      if FunctionName2 > FunctionName1 then
       begin
        Swap := True;
        BlendedStringGrid.Cells[0, RowNo2+1] := FunctionName1;
        BlendedStringGrid.Cells[0, RowNo2] := FunctionName2;
        BlendedStringGrid.Cells[1, RowNo2+1] := BenchmarkResult1;
        BlendedStringGrid.Cells[1, RowNo2] := BenchmarkResult2
       end;
     end;
   until (Swap = False);
  end;
 BlendedStringGrid.ColCount := 4;
 //Get functionnames and benchmark results from Northwood page
 NumberOfNonSSE3Functions := 0;
 if NorthwoodStringGrid.Cells[0, 0] <> '' then
  begin
   //Get winners benchmark
   WinnerBenchmarkStr := NorthwoodStringGrid.Cells[BenchmarkCol, 0];
   WinnerBenchmark := StrToInt(WinnerBenchmarkStr);
   BenchmarkScale := REFBENCHVALUE / WinnerBenchmark;
   BlendedRowNo := 0;
   for RowNo1 := 0 to NorthwoodStringGrid.RowCount-1 do
    begin
     FunctionName := NorthwoodStringGrid.Cells[0, RowNo1];
     //No Blended SSE3 targets
     if Pos('SSE3', FunctionName) = 0 then
      begin
       Inc(NumberOfNonSSE3Functions);
       MaxNumberOfNonSSE3Functions := Max(MaxNumberOfNonSSE3Functions, NumberOfNonSSE3Functions);
       BlendedStringGrid.RowCount := MaxNumberOfNonSSE3Functions;
       BlendedStringGrid.Cells[2, BlendedRowNo] := FunctionName;
       BenchmarkStr := NorthwoodStringGrid.Cells[BenchmarkCol, RowNo1];
       Benchmark := StrToInt(BenchmarkStr);
       Benchmark := Round(BenchmarkScale * Benchmark);
       BlendedStringGrid.Cells[3, BlendedRowNo] := IntToStr(Benchmark);
       Inc(BlendedRowNo);
      end;
    end;
   //Sort by name
   repeat
    Swap := False;
    for RowNo2 := 0 to BlendedStringGrid.RowCount-2 do
     begin
      FunctionName1 := BlendedStringGrid.Cells[2, RowNo2];
      FunctionName2 := BlendedStringGrid.Cells[2, RowNo2+1];
      BenchmarkResult1 := BlendedStringGrid.Cells[3, RowNo2];
      BenchmarkResult2 := BlendedStringGrid.Cells[3, RowNo2+1];
      if FunctionName2 > FunctionName1 then
       begin
        Swap := True;
        BlendedStringGrid.Cells[2, RowNo2+1] := FunctionName1;
        BlendedStringGrid.Cells[2, RowNo2] := FunctionName2;
        BlendedStringGrid.Cells[3, RowNo2+1] := BenchmarkResult1;
        BlendedStringGrid.Cells[3, RowNo2] := BenchmarkResult2
       end;
     end;
   until (Swap = False);
   //Remove colllum with redundant filenames
   for RowNo1 := 0 to BlendedStringGrid.RowCount-1 do
    begin
     BlendedStringGrid.Cells[0, RowNo1] := BlendedStringGrid.Cells[2, RowNo1];
     BlendedStringGrid.Cells[2, RowNo1] := BlendedStringGrid.Cells[3, RowNo1];
     BlendedStringGrid.Cells[3, RowNo1] := '';
    end;
  end;
 //Get functionnames and benchmark results from Yonah page
 NumberOfNonSSE3Functions := 0;
 BlendedStringGrid.ColCount := 5;
 if YonahStringGrid.Cells[0, 0] <> '' then
  begin
   //Get winners benchmark
   WinnerBenchmarkStr := YonahStringGrid.Cells[BenchmarkCol, 0];
   WinnerBenchmark := StrToInt(WinnerBenchmarkStr);
   BenchmarkScale := REFBENCHVALUE / WinnerBenchmark;
   BlendedRowNo := 0;
   for RowNo1 := 0 to YonahStringGrid.RowCount-1 do
    begin
     FunctionName := YonahStringGrid.Cells[0, RowNo1];
     //No Blended SSE3 targets
     if Pos('SSE3', FunctionName) = 0 then
      begin
       Inc(NumberOfNonSSE3Functions);
       MaxNumberOfNonSSE3Functions := Max(MaxNumberOfNonSSE3Functions, NumberOfNonSSE3Functions);
       BlendedStringGrid.RowCount := MaxNumberOfNonSSE3Functions;
       BlendedStringGrid.Cells[3, BlendedRowNo] := FunctionName;
       //BlendedStringGrid.Cells[4, BlendedRowNo] := YonahStringGrid.Cells[BenchmarkCol, RowNo1];
       BenchmarkStr := YonahStringGrid.Cells[BenchmarkCol, RowNo1];
       Benchmark := StrToInt(BenchmarkStr);
       Benchmark := Round(BenchmarkScale * Benchmark);
       BlendedStringGrid.Cells[4, BlendedRowNo] := IntToStr(Benchmark);
       Inc(BlendedRowNo);
      end;
    end;
   //Sort by name
   repeat
    Swap := False;
    for RowNo2 := 0 to BlendedStringGrid.RowCount-2 do
     begin
      FunctionName1 := BlendedStringGrid.Cells[3, RowNo2];
      FunctionName2 := BlendedStringGrid.Cells[3, RowNo2+1];
      BenchmarkResult1 := BlendedStringGrid.Cells[4, RowNo2];
      BenchmarkResult2 := BlendedStringGrid.Cells[4, RowNo2+1];
      if FunctionName2 > FunctionName1 then
       begin
        Swap := True;
        BlendedStringGrid.Cells[3, RowNo2+1] := FunctionName1;
        BlendedStringGrid.Cells[3, RowNo2] := FunctionName2;
        BlendedStringGrid.Cells[4, RowNo2+1] := BenchmarkResult1;
        BlendedStringGrid.Cells[4, RowNo2] := BenchmarkResult2
       end;
     end;
   until (Swap = False);
   //Remove colllum with redundant filenames
   for RowNo1 := 0 to BlendedStringGrid.RowCount-1 do
    begin
     BlendedStringGrid.Cells[0, RowNo1] := BlendedStringGrid.Cells[3, RowNo1];
     BlendedStringGrid.Cells[3, RowNo1] := BlendedStringGrid.Cells[4, RowNo1];
     BlendedStringGrid.Cells[4, RowNo1] := '';
    end;
  end;
 //Get functionnames and benchmark results from Conroe page
 NumberOfNonSSE3Functions := 0;
 BlendedStringGrid.ColCount := 6;
 if ConroeStringGrid.Cells[0, 0] <> '' then
  begin
   //Get winners benchmark
   WinnerBenchmarkStr := ConroeStringGrid.Cells[BenchmarkCol, 0];
   WinnerBenchmark := StrToInt(WinnerBenchmarkStr);
   BenchmarkScale := REFBENCHVALUE / WinnerBenchmark;
   BlendedRowNo := 0;
   for RowNo1 := 0 to ConroeStringGrid.RowCount-1 do
    begin
     FunctionName := ConroeStringGrid.Cells[0, RowNo1];
     //No Blended SSE3 targets
     if Pos('SSE3', FunctionName) = 0 then
      begin
       Inc(NumberOfNonSSE3Functions);
       MaxNumberOfNonSSE3Functions := Max(MaxNumberOfNonSSE3Functions, NumberOfNonSSE3Functions);
       BlendedStringGrid.RowCount := MaxNumberOfNonSSE3Functions;
       BlendedStringGrid.Cells[4, BlendedRowNo] := FunctionName;
       //BlendedStringGrid.Cells[5, BlendedRowNo] := ConroeStringGrid.Cells[BenchmarkCol, RowNo1];
       BenchmarkStr := ConroeStringGrid.Cells[BenchmarkCol, RowNo1];
       Benchmark := StrToInt(BenchmarkStr);
       Benchmark := Round(BenchmarkScale * Benchmark);
       BlendedStringGrid.Cells[5, BlendedRowNo] := IntToStr(Benchmark);
       Inc(BlendedRowNo);
      end;
    end;
   //Sort by name
   repeat
    Swap := False;
    for RowNo2 := 0 to BlendedStringGrid.RowCount-2 do
     begin
      FunctionName1 := BlendedStringGrid.Cells[4, RowNo2];
      FunctionName2 := BlendedStringGrid.Cells[4, RowNo2+1];
      BenchmarkResult1 := BlendedStringGrid.Cells[5, RowNo2];
      BenchmarkResult2 := BlendedStringGrid.Cells[5, RowNo2+1];
      if FunctionName2 > FunctionName1 then
       begin
        Swap := True;
        BlendedStringGrid.Cells[4, RowNo2+1] := FunctionName1;
        BlendedStringGrid.Cells[4, RowNo2] := FunctionName2;
        BlendedStringGrid.Cells[5, RowNo2+1] := BenchmarkResult1;
        BlendedStringGrid.Cells[5, RowNo2] := BenchmarkResult2
       end;
     end;
   until (Swap = False);
   //Remove colllum with redundant filenames
   for RowNo1 := 0 to BlendedStringGrid.RowCount-1 do
    begin
     BlendedStringGrid.Cells[0, RowNo1] := BlendedStringGrid.Cells[4, RowNo1];
     BlendedStringGrid.Cells[4, RowNo1] := BlendedStringGrid.Cells[5, RowNo1];
     BlendedStringGrid.Cells[5, RowNo1] := '';
    end;
  end;
 //Get functionnames and benchmark results from Phenom page
 NumberOfNonSSE3Functions := 0;
 BlendedStringGrid.ColCount := 7;
 if PhenomStringGrid.Cells[0, 0] <> '' then
  begin
   //Get winners benchmark
   WinnerBenchmarkStr := PhenomStringGrid.Cells[BenchmarkCol, 0];
   WinnerBenchmark := StrToInt(WinnerBenchmarkStr);
   BenchmarkScale := REFBENCHVALUE / WinnerBenchmark;
   BlendedRowNo := 0;
   for RowNo1 := 0 to PhenomStringGrid.RowCount-1 do
    begin
     FunctionName := PhenomStringGrid.Cells[0, RowNo1];
     //No Blended SSE3 targets
     if Pos('SSE3', FunctionName) = 0 then
      begin
       Inc(NumberOfNonSSE3Functions);
       MaxNumberOfNonSSE3Functions := Max(MaxNumberOfNonSSE3Functions, NumberOfNonSSE3Functions);
       BlendedStringGrid.RowCount := MaxNumberOfNonSSE3Functions;
       BlendedStringGrid.Cells[5, BlendedRowNo] := FunctionName;
       //BlendedStringGrid.Cells[6, BlendedRowNo] := PhenomStringGrid.Cells[BenchmarkCol, RowNo1];
       BenchmarkStr := PhenomStringGrid.Cells[BenchmarkCol, RowNo1];
       Benchmark := StrToInt(BenchmarkStr);
       Benchmark := Round(BenchmarkScale * Benchmark);
       BlendedStringGrid.Cells[6, BlendedRowNo] := IntToStr(Benchmark);
       Inc(BlendedRowNo);
      end;
    end;
   //Sort by name
   repeat
    Swap := False;
    for RowNo2 := 0 to BlendedStringGrid.RowCount-2 do
     begin
      FunctionName1 := BlendedStringGrid.Cells[5, RowNo2];
      FunctionName2 := BlendedStringGrid.Cells[5, RowNo2+1];
      BenchmarkResult1 := BlendedStringGrid.Cells[6, RowNo2];
      BenchmarkResult2 := BlendedStringGrid.Cells[6, RowNo2+1];
      if FunctionName2 > FunctionName1 then
       begin
        Swap := True;
        BlendedStringGrid.Cells[5, RowNo2+1] := FunctionName1;
        BlendedStringGrid.Cells[5, RowNo2] := FunctionName2;
        BlendedStringGrid.Cells[6, RowNo2+1] := BenchmarkResult1;
        BlendedStringGrid.Cells[6, RowNo2] := BenchmarkResult2
       end;
     end;
   until (Swap = False);
   //Remove colllum with redundant filenames
   for RowNo1 := 0 to BlendedStringGrid.RowCount-1 do
    begin
     BlendedStringGrid.Cells[0, RowNo1] := BlendedStringGrid.Cells[5, RowNo1];
     BlendedStringGrid.Cells[5, RowNo1] := BlendedStringGrid.Cells[6, RowNo1];
     BlendedStringGrid.Cells[6, RowNo1] := '';
    end;
  end;
 //Get functionnames and benchmark results from AMD64X2 page
 NumberOfNonSSE3Functions := 0;
 BlendedStringGrid.ColCount := 8;
 if AMD64X2StringGrid.Cells[0, 0] <> '' then
  begin
   //Get winners benchmark
   WinnerBenchmarkStr := AMD64X2StringGrid.Cells[BenchmarkCol, 0];
   WinnerBenchmark := StrToInt(WinnerBenchmarkStr);
   BenchmarkScale := REFBENCHVALUE / WinnerBenchmark;
   BlendedRowNo := 0;
   for RowNo1 := 0 to AMD64X2StringGrid.RowCount-1 do
    begin
     FunctionName := AMD64X2StringGrid.Cells[0, RowNo1];
     //No Blended SSE3 targets
     if Pos('SSE3', FunctionName) = 0 then
      begin
       Inc(NumberOfNonSSE3Functions);
       MaxNumberOfNonSSE3Functions := Max(MaxNumberOfNonSSE3Functions, NumberOfNonSSE3Functions);
       BlendedStringGrid.RowCount := MaxNumberOfNonSSE3Functions;
       BlendedStringGrid.Cells[6, BlendedRowNo] := FunctionName;
       //BlendedStringGrid.Cells[7, BlendedRowNo] := AMD64X2StringGrid.Cells[BenchmarkCol, RowNo1];
       BenchmarkStr := AMD64X2StringGrid.Cells[BenchmarkCol, RowNo1];
       Benchmark := StrToInt(BenchmarkStr);
       Benchmark := Round(BenchmarkScale * Benchmark);
       BlendedStringGrid.Cells[7, BlendedRowNo] := IntToStr(Benchmark);
       Inc(BlendedRowNo);
      end;
    end;
   //Sort by name
   repeat
    Swap := False;
    for RowNo2 := 0 to BlendedStringGrid.RowCount-2 do
     begin
      FunctionName1 := BlendedStringGrid.Cells[6, RowNo2];
      FunctionName2 := BlendedStringGrid.Cells[6, RowNo2+1];
      BenchmarkResult1 := BlendedStringGrid.Cells[7, RowNo2];
      BenchmarkResult2 := BlendedStringGrid.Cells[7, RowNo2+1];
      if FunctionName2 > FunctionName1 then
       begin
        Swap := True;
        BlendedStringGrid.Cells[6, RowNo2+1] := FunctionName1;
        BlendedStringGrid.Cells[6, RowNo2] := FunctionName2;
        BlendedStringGrid.Cells[7, RowNo2+1] := BenchmarkResult1;
        BlendedStringGrid.Cells[7, RowNo2] := BenchmarkResult2
       end;
     end;
   until (Swap = False);
   //Remove colllum with redundant filenames
   for RowNo1 := 0 to BlendedStringGrid.RowCount-1 do
    begin
     BlendedStringGrid.Cells[0, RowNo1] := BlendedStringGrid.Cells[6, RowNo1];
     BlendedStringGrid.Cells[6, RowNo1] := BlendedStringGrid.Cells[7, RowNo1];
     BlendedStringGrid.Cells[7, RowNo1] := '';
    end;
  end;
 //Sum benchmark results
 for RowNo1 := 0 to BlendedStringGrid.RowCount-1 do
  begin
   SumBenchmark := 0;
   for ColNo1 := 1 to 6 do
    begin
     S := BlendedStringGrid.Cells[ColNo1, RowNo1];
     if S <> '' then
      begin
       Benchmark := StrToInt(S);
       Inc(SumBenchmark, Benchmark);
      end;
    end;
   BlendedStringGrid.Cells[7, RowNo1] := IntToStr(SumBenchmark);
  end;
 if ChallengeName = 'Move' then
  begin
   //Sort by benchmark sum, highest number at top
   repeat
    Swap := False;
    for RowNo2 := 0 to BlendedStringGrid.RowCount-2 do
     begin
      SumBenchmark1 := StrToInt(BlendedStringGrid.Cells[7, RowNo2]);
      SumBenchmark2 := StrToInt(BlendedStringGrid.Cells[7, RowNo2+1]);
      if SumBenchmark1 < SumBenchmark2 then
       begin
        Swap := True;
        for ColNo1 := 0 to BlendedStringGrid.ColCount do
         begin
          Temp := BlendedStringGrid.Cells[ColNo1, RowNo2];
          BlendedStringGrid.Cells[ColNo1, RowNo2] := BlendedStringGrid.Cells[ColNo1, RowNo2+1];
          BlendedStringGrid.Cells[ColNo1, RowNo2+1] := Temp;
         end;
       end;
     end;
   until (Swap = False);
  end
 else
  begin
   //Sort by benchmark sum, lowest number at top
   repeat
    Swap := False;
    for RowNo2 := 0 to BlendedStringGrid.RowCount-2 do
     begin
      SumBenchmark1 := StrToInt(BlendedStringGrid.Cells[7, RowNo2]);
      SumBenchmark2 := StrToInt(BlendedStringGrid.Cells[7, RowNo2+1]);
      if SumBenchmark1 > SumBenchmark2 then
       begin
        Swap := True;
        for ColNo1 := 0 to BlendedStringGrid.ColCount do
         begin
          Temp := BlendedStringGrid.Cells[ColNo1, RowNo2];
          BlendedStringGrid.Cells[ColNo1, RowNo2] := BlendedStringGrid.Cells[ColNo1, RowNo2+1];
          BlendedStringGrid.Cells[ColNo1, RowNo2+1] := Temp;
         end;
       end;
     end;
   until (Swap = False);
  end;
 BlendedStringGrid.ColWidths[0] := 160;
 for ColNo := 1 to BlendedStringGrid.ColCount-1 do
  BlendedStringGrid.ColWidths[ColNo] := 70;
 //Speedup over RTL
 BlendedSpeedUpOverRTLLabeledEdit.Text := '';
 FastestBlendedStr := BlendedStringGrid.Cells[BlendedStringGrid.ColCount-1,0];
 if FastestBlendedStr <> '' then
  begin
 FastestBlended := StrToInt(FastestBlendedStr);
 RTLBlended := 0;
 RowNo := -1;
 repeat
  Inc(RowNo);
  FunctionName := BlendedStringGrid.Cells[0,RowNo];
  AuthorName := GetAuthorName(FunctionName);
  if (UpperCase(AuthorName) = 'RTL') then
   begin
    RTLBlendedStr := BlendedStringGrid.Cells[BlendedStringGrid.ColCount-1,RowNo];
    RTLBlended := StrToInt(RTLBlendedStr);
    Break;
   end;
 until (RowNo = BlendedStringGrid.RowCount-1);
 if (UpperCase(AuthorName) = 'RTL') then
  begin
   if ChallengeName <> 'Move' then
    BlendedSpeedUpOverRTL := RTLBlended / FastestBlended
   else
    BlendedSpeedUpOverRTL := FastestBlended / RTLBlended;
   BlendedSpeedUpOverRTLLabeledEdit.Text := FloatToStrF(BlendedSpeedUpOverRTL, ffFixed, 7, 2);
  end;
 end;
end;

procedure TMainForm.CalculateBlendedSizePenaltyButtonClick(Sender: TObject);
var
 RowNo1, RowNo2, Speed, Size, ColNo1, Benchmark, PenaltyForSizeConstant,
 Benchmark1, Benchmark2 : Integer;
 FunctionName1, FunctionName2, Temp, S1, S2, FunctionName : AnsiString;
 Swap : Boolean;
 BlendedSizePenaltyColNo: Integer;
  FastestBlendedSizePenaltyStr: string;
  FastestBlendedSizePenalty: Integer;
  RTLBlendedSizePenalty: Integer;
  RowNo: Integer;
  AuthorName: string;
  RTLBlendedSizePenaltyStr: string;
  BlendedSizePenaltySpeedUpOverRTL: Double;

begin
 PenaltyForSizeConstant := StrToInt(PenaltyForSizeLabeledEdit.Text);
 //Get functionnames and benchmark results from Blended page
 BlendedSizePenaltyStringGrid.RowCount := BlendedStringGrid.RowCount;
 BlendedSizePenaltyStringGrid.ColCount := BlendedStringGrid.ColCount;
 for RowNo1 := 0 to BlendedStringGrid.RowCount-1 do
  for ColNo1 := 0 to BlendedStringGrid.ColCount-1 do
   BlendedSizePenaltyStringGrid.Cells[ColNo1, RowNo1] := BlendedStringGrid.Cells[ColNo1, RowNo1];
 //Sort by name
 repeat
  Swap := False;
  for RowNo2 := 0 to BlendedSizePenaltyStringGrid.RowCount-2 do
   begin
    FunctionName1 := (BlendedSizePenaltyStringGrid.Cells[0, RowNo2]);
    FunctionName2 := (BlendedSizePenaltyStringGrid.Cells[0, RowNo2+1]);
    if FunctionName2 < FunctionName1 then
     begin
      Swap := True;
      for ColNo1 := 0 to BlendedSizePenaltyStringGrid.ColCount do
       begin
        Temp := BlendedSizePenaltyStringGrid.Cells[ColNo1, RowNo2];
        BlendedSizePenaltyStringGrid.Cells[ColNo1, RowNo2] := BlendedSizePenaltyStringGrid.Cells[ColNo1, RowNo2+1];
        BlendedSizePenaltyStringGrid.Cells[ColNo1, RowNo2+1] := Temp;
       end;
     end;
   end;
 until (Swap = False);
 //Get function sizes
 BlendedSizePenaltyStringGrid.ColCount := 10;
 BlendedSizePenaltyColNo := 0;
 for RowNo1 := 0 to FunctionSizesStringGrid.RowCount-1 do
  begin
   FunctionName := FunctionSizesStringGrid.Cells[0, RowNo1];
   if Pos('SSE3', FunctionName) = 0 then
    begin
     BlendedSizePenaltyStringGrid.Cells[8, BlendedSizePenaltyColNo] := FunctionSizesStringGrid.Cells[0, RowNo1];
     BlendedSizePenaltyStringGrid.Cells[9, BlendedSizePenaltyColNo] := FunctionSizesStringGrid.Cells[1, RowNo1];
     Inc(BlendedSizePenaltyColNo);
    end;
  end;
 //Remove redundant name collum and move size one collum left
 for RowNo1 := 0 to BlendedSizePenaltyStringGrid.RowCount-1 do
  begin
   BlendedSizePenaltyStringGrid.Cells[8, RowNo1] := BlendedSizePenaltyStringGrid.Cells[9, RowNo1];
   BlendedSizePenaltyStringGrid.Cells[9, RowNo1] := '';
  end;
 //Calculate benchmark results with size penalty
 for RowNo1 := 0 to BlendedSizePenaltyStringGrid.RowCount-1 do
  begin
   S1 := BlendedSizePenaltyStringGrid.Cells[7, RowNo1];
   Speed := StrToInt(S1);
   S2 := BlendedSizePenaltyStringGrid.Cells[8, RowNo1];
   Size := StrToInt(S2);
   if ChallengeName = 'Move' then
    Benchmark := Speed - Size * PenaltyForSizeConstant
   else
    Benchmark := Speed + Size * PenaltyForSizeConstant;
   BlendedSizePenaltyStringGrid.Cells[9, RowNo1] := IntToStr(Benchmark);
  end;
 if ChallengeName = 'Move' then
  begin
   //Sort by benchmark results
   repeat
    Swap := False;
    for RowNo2 := 0 to BlendedSizePenaltyStringGrid.RowCount-2 do
     begin
      Benchmark1 := StrToInt(BlendedSizePenaltyStringGrid.Cells[9, RowNo2]);
      Benchmark2 := StrToInt(BlendedSizePenaltyStringGrid.Cells[9, RowNo2+1]);
      if Benchmark1 < Benchmark2 then
       begin
        Swap := True;
        for ColNo1 := 0 to BlendedSizePenaltyStringGrid.ColCount do
         begin
          Temp := BlendedSizePenaltyStringGrid.Cells[ColNo1, RowNo2];
          BlendedSizePenaltyStringGrid.Cells[ColNo1, RowNo2] := BlendedSizePenaltyStringGrid.Cells[ColNo1, RowNo2+1];
          BlendedSizePenaltyStringGrid.Cells[ColNo1, RowNo2+1] := Temp;
         end;
       end;
     end;
   until (Swap = False);
  end
 else
  begin
   //Sort by benchmark results
   repeat
    Swap := False;
    for RowNo2 := 0 to BlendedSizePenaltyStringGrid.RowCount-2 do
     begin
      Benchmark1 := StrToInt(BlendedSizePenaltyStringGrid.Cells[9, RowNo2]);
      Benchmark2 := StrToInt(BlendedSizePenaltyStringGrid.Cells[9, RowNo2+1]);
      if Benchmark1 > Benchmark2 then
       begin
        Swap := True;
        for ColNo1 := 0 to BlendedSizePenaltyStringGrid.ColCount do
         begin
          Temp := BlendedSizePenaltyStringGrid.Cells[ColNo1, RowNo2];
          BlendedSizePenaltyStringGrid.Cells[ColNo1, RowNo2] := BlendedSizePenaltyStringGrid.Cells[ColNo1, RowNo2+1];
          BlendedSizePenaltyStringGrid.Cells[ColNo1, RowNo2+1] := Temp;
         end;
       end;
     end;
   until (Swap = False);
  end;
 BlendedSizePenaltyStringGrid.ColWidths[0] := 160;
 BlendedSizePenaltyStringGrid.ColWidths[1] := 50;
 BlendedSizePenaltyStringGrid.ColWidths[2] := 50;
 BlendedSizePenaltyStringGrid.ColWidths[3] := 50;
 BlendedSizePenaltyStringGrid.ColWidths[4] := 50;
 BlendedSizePenaltyStringGrid.ColWidths[5] := 50;
 BlendedSizePenaltyStringGrid.ColWidths[6] := 50;
 BlendedSizePenaltyStringGrid.ColWidths[7] := 50;
 BlendedSizePenaltyStringGrid.ColWidths[8] := 50;
 BlendedSizePenaltyStringGrid.ColWidths[9] := 50;
 //Speedup over RTL
 BlendedSizePenaltySpeedUpOverRTLLabeledEdit.Clear;
 FastestBlendedSizePenaltyStr := BlendedSizePenaltyStringGrid.Cells[BlendedSizePenaltyStringGrid.ColCount-3,0];
 FastestBlendedSizePenalty := StrToInt(FastestBlendedSizePenaltyStr);
 RTLBlendedSizePenalty := 0;
 RowNo := -1;
 repeat
  Inc(RowNo);
  FunctionName := BlendedSizePenaltyStringGrid.Cells[0,RowNo];
  AuthorName := GetAuthorName(FunctionName);
  if (UpperCase(AuthorName) = 'RTL') then
   begin
    RTLBlendedSizePenaltyStr := BlendedSizePenaltyStringGrid.Cells[BlendedSizePenaltyStringGrid.ColCount-3,RowNo];
    RTLBlendedSizePenalty := StrToInt(RTLBlendedSizePenaltyStr);
    Break;
   end;
 until (RowNo = BlendedSizePenaltyStringGrid.RowCount-1);
 if (UpperCase(AuthorName) = 'RTL') then
  begin
   if ChallengeName <> 'Move' then
    BlendedSizePenaltySpeedUpOverRTL := RTLBlendedSizePenalty / FastestBlendedSizePenalty
   else
    BlendedSizePenaltySpeedUpOverRTL := FastestBlendedSizePenalty / RTLBlendedSizePenalty;
   BlendedSizePenaltySpeedUpOverRTLLabeledEdit.Text := FloatToStrF(BlendedSizePenaltySpeedUpOverRTL, ffFixed, 7, 2);
  end;
 GetWinnersButton.Enabled := True;
end;

{ TODO 1 -oDKC -cBug : Only make headers for collums that exist }

procedure FillInSpreadSheet(Worksheet : _Worksheet; StringGrid : TStringGrid;
                            CPUType, Col2Title, Col3Title, Col4Title,
                            Col5Title, Col6Title, Col7Title, Col8Title, SpeedUpOverRTLStr : AnsiString);
var
 StringGridRowNo, StringGridColNo, ExcelSheetRowNo, ExcelSheetColNo : Integer;

begin
 WorkSheet.Cells.Item[1,1] := CPUType;
 WorkSheet.Cells.Item[3,1] := 'Function Name';
 WorkSheet.Cells.Item[3,2] := Col2Title;
 WorkSheet.Cells.Item[3,3] := Col3Title;
 WorkSheet.Cells.Item[3,4] := Col4Title;
 WorkSheet.Cells.Item[3,5] := Col5Title;
 WorkSheet.Cells.Item[3,6] := Col6Title;
 WorkSheet.Cells.Item[3,7] := Col7Title;
 WorkSheet.Cells.Item[3,8] := Col8Title;
 WorkSheet.Cells.Item[3,1].Font.Bold := True;
 WorkSheet.Cells.Item[3,2].Font.Bold := True;
 WorkSheet.Cells.Item[3,3].Font.Bold := True;
 WorkSheet.Cells.Item[3,4].Font.Bold := True;
 WorkSheet.Cells.Item[3,5].Font.Bold := True;
 WorkSheet.Cells.Item[3,6].Font.Bold := True;
 WorkSheet.Cells.Item[3,7].Font.Bold := True;
 WorkSheet.Cells.Item[3,8].Font.Bold := True;
 { TODO 2 -oDKC -cImprovement : Autosize collum width }
 WorkSheet.Cells.Item[3,1].ColumnWidth := 27;
 WorkSheet.Cells.Item[3,2].ColumnWidth := 12;
 WorkSheet.Cells.Item[3,3].ColumnWidth := 12;
 WorkSheet.Cells.Item[3,4].ColumnWidth := 12;
 WorkSheet.Cells.Item[3,5].ColumnWidth := 12;
 WorkSheet.Cells.Item[3,6].ColumnWidth := 12;
 WorkSheet.Cells.Item[3,7].ColumnWidth := 12;
 WorkSheet.Cells.Item[3,8].ColumnWidth := 12;
 for StringGridRowNo := 0 to StringGrid.RowCount-1 do
  for StringGridColNo := 0 to StringGrid.ColCount-1 do
   begin
    ExcelSheetRowNo := StringGridRowNo+4;
    ExcelSheetColNo  := StringGridColNo+1;
    WorkSheet.Cells.Item[ExcelSheetRowNo, ExcelSheetColNo]
     := StringGrid.Cells[StringGridColNo, StringGridRowNo];
   end;
 if SpeedUpOverRTLStr <> '' then
  begin
    WorkSheet.Cells.Item[3,StringGrid.ColCount+1] := 'Speedup over RTL';
    WorkSheet.Cells.Item[3,StringGrid.ColCount+1].Font.Bold := True;
    WorkSheet.Cells.Item[3,StringGrid.ColCount+1].ColumnWidth := 18;
    WorkSheet.Cells.Item[4,StringGrid.ColCount+1] := SpeedUpOverRTLStr;
  end;
end;

procedure TMainForm.CreateSpreadsheetsButtonClick(Sender: TObject);
var
 ExcelApplication : TExcelApplication;
 WorkSheet: _Worksheet;
 WorkSheets: Sheets;
 SaveChanges: OleVariant;
 Filename: OleVariant;
 WorkBook: _Workbook;
 StringGridRowNo, StringGridColNo, ExcelSheetRowNo, ExcelSheetColNo, Row, Col,
 MaxRow, MaxCol : Integer;
 Path, VersionNumber : AnsiString;

begin
 Path := OptionsForm.FilePathLabeledEdit.Text;
 VersionNumber := ChallengeVersionNumber;
 ExcelApplication := TExcelApplication.Create(nil);
 ExcelApplication.Visible[0] := True;
 ExcelApplication.Workbooks.Add(XLWBatWorksheet, 0);
 WorkBook := ExcelApplication.Workbooks.Item[1];
 Worksheets := WorkBook.Worksheets;
 Worksheets.Add(EmptyParam, EmptyParam, 8, EmptyParam, 0);
 //Fill in Penryn spreadsheet
 Worksheet := Worksheets.Get_Item(1) as _WorkSheet;
 Worksheet.Name := 'Penryn';
 FillInSpreadSheet(Worksheet, PenrynStringGrid, PenrynCPUTypeLabeledEdit.Text,
                   PenrynCol2Label.Caption, PenrynCol3Label.Caption,
                   PenrynCol4Label.Caption, PenrynCol5Label.Caption,
                   PenrynCol6Label.Caption, PenrynCol7Label.Caption,
                   PenrynCol8Label.Caption, PenrynSpeedUpOverRTLLabeledEdit.Text);
 //Fill in Northwood spreadsheet
 Worksheet := Worksheets.Get_Item(2) as _WorkSheet;
 Worksheet.Name := 'Northwood';
 FillInSpreadSheet(Worksheet, NorthwoodStringGrid, NorthwoodCPUTypeLabeledEdit.Text,
                   NorthwoodCol2Label.Caption, NorthwoodCol3Label.Caption,
                   NorthwoodCol4Label.Caption, NorthwoodCol5Label.Caption,
                   NorthwoodCol6Label.Caption, NorthwoodCol7Label.Caption,
                   NorthwoodCol8Label.Caption, NorthwoodSpeedUpOverRTLLabeledEdit.Text);
 //Fill in Yonah spreadsheet
 Worksheet := Worksheets.Get_Item(3) as _WorkSheet;
 Worksheet.Name := 'Yonah';
 FillInSpreadSheet(Worksheet, YonahStringGrid, YonahCPUTypeLabeledEdit.Text,
                   YonahCol2Label.Caption, YonahCol3Label.Caption,
                   YonahCol4Label.Caption, YonahCol5Label.Caption,
                   YonahCol6Label.Caption, YonahCol7Label.Caption,
                   YonahCol8Label.Caption, YonahSpeedUpOverRTLLabeledEdit.Text);
 //Fill in Conroe spreadsheet
 Worksheet := Worksheets.Get_Item(4) as _WorkSheet;
 Worksheet.Name := 'Conroe';
 FillInSpreadSheet(Worksheet, ConroeStringGrid, ConroeCPUTypeLabeledEdit.Text,
                   ConroeCol2Label.Caption, ConroeCol3Label.Caption,
                   ConroeCol4Label.Caption, ConroeCol5Label.Caption,
                   ConroeCol6Label.Caption, ConroeCol7Label.Caption,
                   ConroeCol8Label.Caption, ConroeSpeedUpOverRTLLabeledEdit.Text);
 //Fill in AMD64X2 spreadsheet
 Worksheet := Worksheets.Get_Item(5) as _WorkSheet;
 Worksheet.Name := 'AMD64X2';
 FillInSpreadSheet(Worksheet, AMD64X2StringGrid, AMD64X2CPUTypeLabeledEdit.Text,
                   AMD64X2Col2Label.Caption, AMD64X2Col3Label.Caption,
                   AMD64X2Col4Label.Caption, AMD64X2Col5Label.Caption,
                   AMD64X2Col6Label.Caption, AMD64X2Col7Label.Caption,
                   AMD64X2Col8Label.Caption, AMD64X2SpeedUpOverRTLLabeledEdit.Text);
 //Fill in Phenom spreadsheet
 Worksheet := Worksheets.Get_Item(6) as _WorkSheet;
 Worksheet.Name := 'Phenom';
 FillInSpreadSheet(Worksheet, PhenomStringGrid, PhenomCPUTypeLabeledEdit.Text,
                   PhenomCol2Label.Caption, PhenomCol3Label.Caption,
                   PhenomCol4Label.Caption, PhenomCol5Label.Caption,
                   PhenomCol6Label.Caption, PhenomCol7Label.Caption,
                   PhenomCol8Label.Caption, PhenomSpeedUpOverRTLLabeledEdit.Text);
 //Fill in Blended spreadsheet
 Worksheet := Worksheets.Get_Item(7) as _WorkSheet;
 Worksheet.Name := 'Blended';
 WorkSheet.Cells.Item[1,1] := 'Blended';
 WorkSheet.Cells.Item[1,1].Font.Size := 16;
 WorkSheet.Cells.Item[3,1] := 'Function Name';
 WorkSheet.Cells.Item[3,2] := 'Penryn';
 WorkSheet.Cells.Item[3,3] := 'Northwood';
 WorkSheet.Cells.Item[3,4] := 'Yonah';
 WorkSheet.Cells.Item[3,5] := 'Conroe';
 WorkSheet.Cells.Item[3,6] := 'Phenom';
 WorkSheet.Cells.Item[3,7] := 'Phenom X2';
 WorkSheet.Cells.Item[3,8] := 'Total';
 WorkSheet.Cells.Item[1,1].Font.Bold := True;
 WorkSheet.Cells.Item[3,1].Font.Bold := True;
 WorkSheet.Cells.Item[3,2].Font.Bold := True;
 WorkSheet.Cells.Item[3,3].Font.Bold := True;
 WorkSheet.Cells.Item[3,4].Font.Bold := True;
 WorkSheet.Cells.Item[3,5].Font.Bold := True;
 WorkSheet.Cells.Item[3,6].Font.Bold := True;
 WorkSheet.Cells.Item[3,7].Font.Bold := True;
 WorkSheet.Cells.Item[3,8].Font.Bold := True;
 WorkSheet.Cells.Item[3,1].ColumnWidth := 25;
 WorkSheet.Cells.Item[3,2].ColumnWidth := 10;
 WorkSheet.Cells.Item[3,3].ColumnWidth := 12;
 WorkSheet.Cells.Item[3,4].ColumnWidth := 10;
 WorkSheet.Cells.Item[3,5].ColumnWidth := 10;
 WorkSheet.Cells.Item[3,6].ColumnWidth := 10;
 WorkSheet.Cells.Item[3,7].ColumnWidth := 12;
 WorkSheet.Cells.Item[3,8].ColumnWidth := 10;
 for StringGridRowNo := 0 to BlendedStringGrid.RowCount-1 do
  for StringGridColNo := 0 to BlendedStringGrid.ColCount-1 do
   begin
    ExcelSheetRowNo := StringGridRowNo+4;
    ExcelSheetColNo  := StringGridColNo+1;
    WorkSheet.Cells.Item[ExcelSheetRowNo, ExcelSheetColNo]
     := BlendedStringGrid.Cells[StringGridColNo, StringGridRowNo];
   end;
 if BlendedSpeedUpOverRTLLabeledEdit.Text <> '' then
  begin
    WorkSheet.Cells.Item[3,BlendedStringGrid.ColCount+1] := 'Speedup over RTL';
    WorkSheet.Cells.Item[3,BlendedStringGrid.ColCount+1].Font.Bold := True;
    WorkSheet.Cells.Item[3,BlendedStringGrid.ColCount+1].ColumnWidth := 18;
    WorkSheet.Cells.Item[4,BlendedStringGrid.ColCount+1] := BlendedSpeedUpOverRTLLabeledEdit.Text;
  end;
 //Fill in Blended with size penalty spreadsheet
 Worksheet := Worksheets.Get_Item(8) as _WorkSheet;
 Worksheet.Name := 'BlendedSizePenalty';
 WorkSheet.Cells.Item[1,1] := 'Blended With Size Penalty';
 WorkSheet.Cells.Item[1,1].Font.Size := 16;
 WorkSheet.Cells.Item[3,1] := 'Function Name';
 WorkSheet.Cells.Item[3,2] := 'Penryn';
 WorkSheet.Cells.Item[3,3] := 'Northwood';
 WorkSheet.Cells.Item[3,4] := 'Yonah';
 WorkSheet.Cells.Item[3,5] := 'Conroe';
 WorkSheet.Cells.Item[3,6] := 'Phenom';
 WorkSheet.Cells.Item[3,7] := 'Phenom X2';
 WorkSheet.Cells.Item[3,8] := 'Total';
 WorkSheet.Cells.Item[3,9] := 'Size';
 WorkSheet.Cells.Item[3,10] := 'Benchmark';
 WorkSheet.Cells.Item[3,11] := 'Size Penalty Constant';
 WorkSheet.Cells.Item[1,1].Font.Bold := True;
 WorkSheet.Cells.Item[3,1].Font.Bold := True;
 WorkSheet.Cells.Item[3,2].Font.Bold := True;
 WorkSheet.Cells.Item[3,3].Font.Bold := True;
 WorkSheet.Cells.Item[3,4].Font.Bold := True;
 WorkSheet.Cells.Item[3,5].Font.Bold := True;
 WorkSheet.Cells.Item[3,6].Font.Bold := True;
 WorkSheet.Cells.Item[3,7].Font.Bold := True;
 WorkSheet.Cells.Item[3,8].Font.Bold := True;
 WorkSheet.Cells.Item[3,9].Font.Bold := True;
 WorkSheet.Cells.Item[3,10].Font.Bold := True;
 WorkSheet.Cells.Item[3,11].Font.Bold := True;
 WorkSheet.Cells.Item[3,1].ColumnWidth := 25;
 WorkSheet.Cells.Item[3,2].ColumnWidth := 10;
 WorkSheet.Cells.Item[3,3].ColumnWidth := 12;
 WorkSheet.Cells.Item[3,4].ColumnWidth := 10;
 WorkSheet.Cells.Item[3,5].ColumnWidth := 10;
 WorkSheet.Cells.Item[3,6].ColumnWidth := 10;
 WorkSheet.Cells.Item[3,7].ColumnWidth := 12;
 WorkSheet.Cells.Item[3,8].ColumnWidth := 10;
 WorkSheet.Cells.Item[3,9].ColumnWidth := 10;
 WorkSheet.Cells.Item[3,10].ColumnWidth := 12;
 WorkSheet.Cells.Item[3,11].ColumnWidth := 20;
 for StringGridRowNo := 0 to BlendedSizePenaltyStringGrid.RowCount-1 do
  for StringGridColNo := 0 to BlendedSizePenaltyStringGrid.ColCount-1 do
   begin
    ExcelSheetRowNo := StringGridRowNo+4;
    ExcelSheetColNo  := StringGridColNo+1;
    WorkSheet.Cells.Item[ExcelSheetRowNo, ExcelSheetColNo]
     := BlendedSizePenaltyStringGrid.Cells[StringGridColNo, StringGridRowNo];
   end;
 WorkSheet.Cells.Item[4,11] := PenaltyForSizeLabeledEdit.Text;
 if BlendedSizePenaltySpeedUpOverRTLLabeledEdit.Text <> '' then
  begin
    WorkSheet.Cells.Item[3,BlendedSizePenaltyStringGrid.ColCount+2] := 'Speedup over RTL';
    WorkSheet.Cells.Item[3,BlendedSizePenaltyStringGrid.ColCount+2].Font.Bold := True;
    WorkSheet.Cells.Item[3,BlendedSizePenaltyStringGrid.ColCount+2].ColumnWidth := 18;
    WorkSheet.Cells.Item[4,BlendedSizePenaltyStringGrid.ColCount+2] := BlendedSizePenaltySpeedUpOverRTLLabeledEdit.Text;
  end;
 //Fill in winners spreadsheet
 Worksheet := Worksheets.Get_Item(9) as _WorkSheet;
 Worksheet.Name := 'Winners';
 WorkSheet.Cells.Item[1,1] := 'Winners Points';
 WorkSheet.Cells.Item[1,1].Font.Size := 16;
 WorkSheet.Cells.Item[3,1] := 'Target';
 WorkSheet.Cells.Item[3,2] := 'Function Name';
 WorkSheet.Cells.Item[1,1].Font.Bold := True;
 WorkSheet.Cells.Item[3,1].Font.Bold := True;
 WorkSheet.Cells.Item[3,2].Font.Bold := True;
 WorkSheet.Cells.Item[1,1].ColumnWidth := 20;
 WorkSheet.Cells.Item[3,1].ColumnWidth := 20;
 WorkSheet.Cells.Item[3,2].ColumnWidth := 25;
 MaxRow := WinnersStringGrid.RowCount+1;
 MaxCol := WinnersStringGrid.ColCount;
 //Color cells
 for Row := 1 to MaxRow do
  for Col := 1 to MaxCol do
   WorkSheet.Cells.Item[Row+2,Col].Interior.ColorIndex := 8;
 //Redraw borders
 for Row := 1 to MaxRow do
  for Col := 1 to MaxCol do
   WorkSheet.Cells.Item[Row+2,Col].BorderAround(xlContinuous,2);
 for StringGridRowNo := 0 to WinnersStringGrid.RowCount-1 do
  for StringGridColNo := 0 to WinnersStringGrid.ColCount-1 do
   begin
    ExcelSheetRowNo := StringGridRowNo+4;
    ExcelSheetColNo  := StringGridColNo+1;
    WorkSheet.Cells.Item[ExcelSheetRowNo, ExcelSheetColNo]
     := WinnersStringGrid.Cells[StringGridColNo, StringGridRowNo];
   end;
 WorkSheet.Cells.Item[3,4] := 'Author';
 WorkSheet.Cells.Item[3,5] := '#Targets';
 WorkSheet.Cells.Item[3,6] := '#Winners';
 WorkSheet.Cells.Item[3,7] := 'Points';
 WorkSheet.Cells.Item[3,4].Font.Bold := True;
 WorkSheet.Cells.Item[3,5].Font.Bold := True;
 WorkSheet.Cells.Item[3,6].Font.Bold := True;
 WorkSheet.Cells.Item[3,7].Font.Bold := True;
 WorkSheet.Cells.Item[3,4].ColumnWidth := 22;
 WorkSheet.Cells.Item[3,5].ColumnWidth := 10;
 WorkSheet.Cells.Item[3,6].ColumnWidth := 10;
 WorkSheet.Cells.Item[3,7].ColumnWidth := 10;
 //Color cells
 MaxRow := PointsStringGrid.RowCount+1;
 MaxCol := PointsStringGrid.ColCount;
 for Row := 1 to MaxRow do
  for Col := 1 to MaxCol do
   WorkSheet.Cells.Item[Row+2,Col+3].Interior.ColorIndex := 4;
 //Redraw borders
 for Row := 1 to MaxRow do
  for Col := 1 to MaxCol do
   WorkSheet.Cells.Item[Row+2,Col+3].BorderAround(xlContinuous,2);
 for StringGridRowNo := 0 to PointsStringGrid.RowCount-1 do
  for StringGridColNo := 0 to PointsStringGrid.ColCount-1 do
   begin
    ExcelSheetRowNo := StringGridRowNo+4;
    ExcelSheetColNo  := StringGridColNo+4;
    WorkSheet.Cells.Item[ExcelSheetRowNo, ExcelSheetColNo]
     := PointsStringGrid.Cells[StringGridColNo, StringGridRowNo];
   end;
 SaveChanges := True;
 VersionNumber := StringReplace(VersionNumber, '.', '',[rfReplaceAll]);
 Filename := Path + '\' + ChallengeName + 'Benchmark' + VersionNumber + '.xls';
 Workbook.Close(SaveChanges, Filename, EmptyParam, 0);
 ExcelApplication.Free;
end;

procedure SetColLabels(StringGrid : TStringGrid;
                       Col2Label, Col3Label, Col4Label, Col5Label,
                       Col6Label, Col7Label, Col8Label : TLabel);
var
 RowNo : Integer;
 S : Ansistring;
 AlignCollumPresent : Boolean;

begin
 AlignCollumPresent := False;
 for RowNo := 0 to StringGrid.RowCount - 1 do
  begin
   S := StringGrid.Cells[1, RowNo];
   if (S = 'c') or (S = 'C') then
    begin
     AlignCollumPresent := True;
     Break;
    end;
  end;
 if StringGrid.ColCount = 2 then
  begin
   if AlignCollumPresent then
    begin
     raise Exception.Create('Unsupported number of collums in file');
    end
   else
    begin
     Col2Label.Caption := 'Benchmark';
     Col3Label.Caption := '';
     Col4Label.Caption := '';
     Col5Label.Caption := '';
     Col6Label.Caption := '';
     Col7Label.Caption := '';
     Col8Label.Caption := '';
     MainForm.NoOfSubbenchmarks := 0;
    end;
  end
 else if StringGrid.ColCount = 3 then
  begin
   if AlignCollumPresent then
    begin
     Col2Label.Caption := 'Align';
     Col3Label.Caption := 'Benchmark';
     Col4Label.Caption := '';
     Col5Label.Caption := '';
     Col6Label.Caption := '';
     Col7Label.Caption := '';
     Col8Label.Caption := '';
     MainForm.NoOfSubbenchmarks := 0;
    end
   else
    begin
     Col2Label.Caption := 'Subbench1';
     Col3Label.Caption := 'Benchmark';
     Col4Label.Caption := '';
     Col5Label.Caption := '';
     Col6Label.Caption := '';
     Col7Label.Caption := '';
     Col8Label.Caption := '';
     MainForm.NoOfSubbenchmarks := 1;
    end;
  end
 else if StringGrid.ColCount = 4 then
  begin
   if AlignCollumPresent then
    begin
     Col2Label.Caption := 'Align';
     Col3Label.Caption := 'Subbench1';
     Col4Label.Caption := 'Benchmark';
     Col5Label.Caption := '';
     Col6Label.Caption := '';
     Col7Label.Caption := '';
     Col8Label.Caption := '';
     MainForm.NoOfSubbenchmarks := 1;
    end
   else
    begin
     Col2Label.Caption := 'Subbench1';
     Col3Label.Caption := 'Subbench2';
     Col4Label.Caption := 'Benchmark';
     Col5Label.Caption := '';
     Col6Label.Caption := '';
     Col7Label.Caption := '';
     Col8Label.Caption := '';
     MainForm.NoOfSubbenchmarks := 2;
    end;
  end
 else if StringGrid.ColCount = 5 then
  begin
   if AlignCollumPresent then
    begin
     Col2Label.Caption := 'Align';
     Col3Label.Caption := 'Subbench1';
     Col4Label.Caption := 'Subbench2';
     Col5Label.Caption := 'Benchmark';
     Col6Label.Caption := '';
     Col7Label.Caption := '';
     Col8Label.Caption := '';
     MainForm.NoOfSubbenchmarks := 2;
    end
   else
    begin
     Col2Label.Caption := 'Subbench1';
     Col3Label.Caption := 'Subbench2';
     Col4Label.Caption := 'Subbench3';
     Col5Label.Caption := 'Benchmark';
     Col6Label.Caption := '';
     Col7Label.Caption := '';
     Col8Label.Caption := '';
     MainForm.NoOfSubbenchmarks := 3;
    end;
  end
 else if StringGrid.ColCount = 6 then
  begin
   if AlignCollumPresent then
    begin
     Col2Label.Caption := 'Align';
     Col3Label.Caption := 'Subbench1';
     Col4Label.Caption := 'Subbench2';
     Col5Label.Caption := 'Subbench3';
     Col6Label.Caption := 'Benchmark';
     Col7Label.Caption := '';
     Col8Label.Caption := '';
     MainForm.NoOfSubbenchmarks := 3;
    end
   else
    begin
     Col2Label.Caption := 'Subbench1';
     Col3Label.Caption := 'Subbench2';
     Col4Label.Caption := 'Subbench3';
     Col5Label.Caption := 'Subbench4';
     Col6Label.Caption := 'Benchmark';
     Col7Label.Caption := '';
     Col8Label.Caption := '';
     MainForm.NoOfSubbenchmarks := 4;
    end;
  end
 else if StringGrid.ColCount = 7 then
  begin
   if AlignCollumPresent then
    begin
     Col2Label.Caption := 'Align';
     Col3Label.Caption := 'Subbench1';
     Col4Label.Caption := 'Subbench2';
     Col5Label.Caption := 'Subbench3';
     Col6Label.Caption := 'Subbench4';
     Col7Label.Caption := 'Benchmark';
     Col8Label.Caption := '';
     MainForm.NoOfSubbenchmarks := 4;
    end
   else
    begin
     Col2Label.Caption := 'Subbench1';
     Col3Label.Caption := 'Subbench2';
     Col4Label.Caption := 'Subbench3';
     Col5Label.Caption := 'Subbench4';
     Col6Label.Caption := 'Subbench5';
     Col7Label.Caption := 'Benchmark';
     Col8Label.Caption := '';
     MainForm.NoOfSubbenchmarks := 5;
    end;
  end
 else if StringGrid.ColCount = 8 then
  begin
   if AlignCollumPresent then
    begin
     Col2Label.Caption := 'Align';
     Col3Label.Caption := 'Subbench1';
     Col4Label.Caption := 'Subbench2';
     Col5Label.Caption := 'Subbench3';
     Col6Label.Caption := 'Subbench4';
     Col7Label.Caption := 'Subbench5';
     Col8Label.Caption := 'Benchmark';
     MainForm.NoOfSubbenchmarks := 5;
    end
   else
    begin
     Col2Label.Caption := 'Subbench1';
     Col3Label.Caption := 'Subbench2';
     Col4Label.Caption := 'Subbench3';
     Col5Label.Caption := 'Subbench4';
     Col6Label.Caption := 'Subbench5';
     Col7Label.Caption := 'Subbench6';
     Col8Label.Caption := 'Benchmark';
     MainForm.NoOfSubbenchmarks := 6;
    end;
  end
 else
  raise Exception.Create('Unsupported number of columns in file');
end;

procedure TMainForm.DoAllButtonClick(Sender: TObject);
begin
 LoadAllButtonClick(nil);
 CalculateBlendedButtonClick(nil);
 CalculateBlendedSizePenaltyButtonClick(nil);
 GetWinnersButtonClick(nil);
 GivePointsButtonClick(nil);
 CreateSpreadsheetsButtonClick(nil);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 WriteIniFile(INIFILENAME);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 RichEdit1.Clear;
 FunctionsToRemoveRichEdit.Clear;
 ChallengeNameEdit.Clear;
 ChallengeVersionNumberEdit.Clear;
 MainFormCaption := MainForm.Caption;
 AuthorFileName := ExtractFilePath(Application.ExeName)+AUTHORNAME;
end;

function GetChallengeName(FileName : AnsiString) : AnsiString;
var
 Index1, Index2, Count : Integer;

begin
 Index1 := 1;
 Index2 := CharPosEY('_', FileName,1);
 Count := Index2 - Index1;
 Result := Copy(FileName, Index1, Count);
end;

function GetChallengeVersion(FileName : AnsiString) : AnsiString;
var
 Index1, Index2, Count : Integer;

begin
 Index1 := CharPosEY('_', FileName,1)+1;
 Index2 := CharPosEY('_', FileName,2);
 Count := Index2 - Index1;
 Result := Copy(FileName, Index1, Count);
end;

procedure TMainForm.FormShow(Sender: TObject);
var
 LoadPath, SearchPath : AnsiString;
 FindResult : Integer;
 SearchRec : TSearchRec;

begin
 LoadPath := OptionsForm.FilePathLabeledEdit.Text;
 SearchPath := OptionsForm.FilePathLabeledEdit.Text + '\*.txt';
 FindResult := FindFirst(SearchPath, faAnyFile, SearchRec);
 if FindResult = 0 then
  begin
   ChallengeNameEdit.Text := GetChallengeName(SearchRec.Name);
   ChallengeVersionNumberEdit.Text := GetChallengeVersion(SearchRec.Name);
  end;
end;

function IsFunctionPresent(FunctionName : AnsiString; StringList : TStringList) : Boolean;
var
 S : AnsiString;
 I : Integer;

begin
 Result := False;
 for I  := 0 to StringList.Count - 1 do
  begin
   S := StringList[I];
   if FunctionName = S then
    begin
     Result := True;
     Break;
    end;
  end;
end;

procedure HandleWrongFunctionSizeFile(AllFunctionsList, FunctionSizesList : TStringList);
var
 I1, I2, I3, I4, I5, I6 : Integer;
 S1, S2, S3, S4, S5 : AnsiString;
 Found : Boolean;

begin
 HelperForm.MatchRichEdit.Clear;
 AllFunctionsList.Sort;
 FunctionSizesList.Sort;
 HelperForm.AllFunctionsRichEdit.Lines := AllFunctionsList;
 HelperForm.FunctionSizesRichEdit.Lines := FunctionSizesList;
 //Duplicates
 for I1 := 0 to FunctionSizesList.Count-1 do
  begin
   S1 := FunctionSizesList[I1];
   for I2 := I1+1 to FunctionSizesList.Count-1 do
    begin
     S2 := FunctionSizesList[I2];
     if S1 = S2  then
      HelperForm.MatchRichEdit.lines.Add(S1 + #9 + 'Duplicate');
    end;
  end;
 for I3 := 0 to FunctionSizesList.Count-1 do
  begin
   S2 := FunctionSizesList[I3];
   //Search for function in benchmark results list
   Found := False;
   for I4 := 0 to AllFunctionsList.Count-1 do
    begin
     S3 := AllFunctionsList[I4];
     if S2 = S3  then
      begin
       Found := True;
       Break;
      end;
    end;
   if not Found then
    HelperForm.MatchRichEdit.lines.Add(S2 + #9 + 'Remove');
  end;
 for I5 := 0 to AllFunctionsList.Count-1 do
  begin
   S4 := AllFunctionsList[I5];
   //Search for function in function size list
   Found := False;
   for I6 := 0 to FunctionSizesList.Count-1 do
    begin
     S5 := FunctionSizesList[I6];
     if S4 = S5  then
      begin
       Found := True;
       Break;
      end;
    end;
   if not Found then
    HelperForm.MatchRichEdit.lines.Add(S4 + #9 + 'Missing');
  end;
 HelperForm.ShowModal;
end;

procedure TMainForm.TestFunctionSizes;
var
 AllFunctionsList, FunctionSizesList : TStringList;
 FunctionName, FunctionName1, FunctionName2 : AnsiString;
 RowNo, I : Integer;
 Res : Integer;
begin
 AllFunctionsList := TStringList.Create;
 FunctionSizesList := TStringList.Create;
 //Get all functions
 for RowNo := 0 to PenrynStringGrid.RowCount - 1 do
  begin
   FunctionName := PenrynStringGrid.Cells[0, RowNo];
   if FunctionName <> '' then
    if not IsFunctionPresent(FunctionName, AllFunctionsList) then
     AllFunctionsList.Add(FunctionName);
  end;
 for RowNo := 0 to NorthwoodStringGrid.RowCount - 1 do
  begin
   FunctionName := NorthwoodStringGrid.Cells[0, RowNo];
   if FunctionName <> '' then
    if not IsFunctionPresent(FunctionName, AllFunctionsList) then
     AllFunctionsList.Add(FunctionName);
  end;
 for RowNo := 0 to YonahStringGrid.RowCount - 1 do
  begin
   FunctionName := YonahStringGrid.Cells[0, RowNo];
   if FunctionName <> '' then
    if not IsFunctionPresent(FunctionName, AllFunctionsList) then
     AllFunctionsList.Add(FunctionName);
  end;
 for RowNo := 0 to ConroeStringGrid.RowCount - 1 do
  begin
   FunctionName := ConroeStringGrid.Cells[0, RowNo];
   if FunctionName <> '' then
    if not IsFunctionPresent(FunctionName, AllFunctionsList) then
     AllFunctionsList.Add(FunctionName);
  end;
 for RowNo := 0 to AMD64X2StringGrid.RowCount - 1 do
  begin
   FunctionName := AMD64X2StringGrid.Cells[0, RowNo];
   if FunctionName <> '' then
    if not IsFunctionPresent(FunctionName, AllFunctionsList) then
     AllFunctionsList.Add(FunctionName);
  end;
 for RowNo := 0 to PhenomStringGrid.RowCount - 1 do
  begin
   FunctionName := PhenomStringGrid.Cells[0, RowNo];
   if FunctionName <> '' then
    if not IsFunctionPresent(FunctionName, AllFunctionsList) then
     AllFunctionsList.Add(FunctionName);
  end;
 for RowNo := 0 to FunctionSizesStringGrid.RowCount - 1 do
  begin
   FunctionName := FunctionSizesStringGrid.Cells[0, RowNo];
   FunctionSizesList.Add(FunctionName);
  end;
 AllFunctionsList.Sort;
 FunctionSizesList.Sort;
 { TODO 1 -oDKC -cBug : Fails if SSE3 function size exist, but no benchmark result exist. }
 if AllFunctionsList.Count <> FunctionSizesList.Count then
  begin
   Res := MessageDlg('Functionsize file is incorrect - show helper form?',mtInformation,[mbYes, mbNo], 0);
   if Res = mrYes then
    HandleWrongFunctionSizeFile(AllFunctionsList, FunctionSizesList);
   end
 else
  begin
   for I := 0 to AllFunctionsList.Count - 1 do
    begin
     FunctionName1 := AllFunctionsList[I];
     FunctionName2 := FunctionSizesList[I];
     if FunctionName1 <> FunctionName2 then
      begin
       Res := MessageDlg('Functionsize file is incorrect - show helper form?',mtInformation,[mbYes, mbNo], 0);
        if Res = mrYes then
         begin
          HandleWrongFunctionSizeFile(AllFunctionsList, FunctionSizesList);
          Break;
         end;
      end;
    end;
  end;
 AllFunctionsList.Free;
 FunctionSizesList.Free;
end;

procedure TMainForm.CreateTemplateFunctionSizeFile(FileName : AnsiString);
var
 AllFunctionsList : TStringList;
 FunctionName, S : AnsiString;
 RowNo, I : Integer;

begin
 AllFunctionsList := TStringList.Create;
 //Get all functions
 for RowNo := 0 to PenrynStringGrid.RowCount - 1 do
  begin
   FunctionName := PenrynStringGrid.Cells[0, RowNo];
   if FunctionName <> '' then
    if not IsFunctionPresent(FunctionName, AllFunctionsList) then
     AllFunctionsList.Add(FunctionName);
  end;
 for RowNo := 0 to NorthwoodStringGrid.RowCount - 1 do
  begin
   FunctionName := NorthwoodStringGrid.Cells[0, RowNo];
   if FunctionName <> '' then
    if not IsFunctionPresent(FunctionName, AllFunctionsList) then
     AllFunctionsList.Add(FunctionName);
  end;
 for RowNo := 0 to YonahStringGrid.RowCount - 1 do
  begin
   FunctionName := YonahStringGrid.Cells[0, RowNo];
   if FunctionName <> '' then
    if not IsFunctionPresent(FunctionName, AllFunctionsList) then
     AllFunctionsList.Add(FunctionName);
  end;
 for RowNo := 0 to ConroeStringGrid.RowCount - 1 do
  begin
   FunctionName := ConroeStringGrid.Cells[0, RowNo];
   if FunctionName <> '' then
    if not IsFunctionPresent(FunctionName, AllFunctionsList) then
     AllFunctionsList.Add(FunctionName);
  end;
 for RowNo := 0 to AMD64X2StringGrid.RowCount - 1 do
  begin
   FunctionName := AMD64X2StringGrid.Cells[0, RowNo];
   if FunctionName <> '' then
    if not IsFunctionPresent(FunctionName, AllFunctionsList) then
     AllFunctionsList.Add(FunctionName);
  end;
 for RowNo := 0 to PhenomStringGrid.RowCount - 1 do
  begin
   FunctionName := PhenomStringGrid.Cells[0, RowNo];
   if FunctionName <> '' then
    if not IsFunctionPresent(FunctionName, AllFunctionsList) then
     AllFunctionsList.Add(FunctionName);
  end;
 AllFunctionsList.Sort;
 for I := 0 to AllFunctionsList.Count - 1 do
  begin
   S := AllFunctionsList[I];
   AllFunctionsList[I] := S + #9 + '9999';
  end;
 AllFunctionsList.Insert(0, 'PenaltyForSizeConstant' + #9 + '9999');
 AllFunctionsList.SaveToFile(FileName);
 AllFunctionsList.Free;
end;

procedure ClearStringGrid(var StringGrid : TStringGrid);
var
 RowNo, ColNo : Integer;

begin
 for RowNo := 0 to StringGrid.RowCount - 1 do
  for ColNo := 0 to StringGrid.ColCount - 1 do
   StringGrid.Cells[ColNo, RowNo] := '';
end;


procedure ClearStringGridAndZeroCellCount(var StringGrid : TStringGrid);
var
 RowNo, ColNo : Integer;

begin
 for RowNo := 0 to StringGrid.RowCount - 1 do
  for ColNo := 0 to StringGrid.ColCount - 1 do
   StringGrid.Cells[ColNo, RowNo] := '';
 StringGrid.RowCount := 0;
 StringGrid.ColCount := 0;
end;

{ TODO 2 -oDKC -cBug : Make sure that all files are for same challenge }

procedure TMainForm.LoadAllButtonClick(Sender: TObject);
var
 LoadPath, FileName, SearchPath, FastestPenrynStr, FunctionName, AuthorName,
 RTLPenrynStr, FastestNorthwoodStr, RTLNorthwoodStr, FastestYonahStr,
 FastestConroeStr, RTLConroeStr, FastestPhenomStr, RTLPhenomStr, FastestAMD64X2Str,
 RTLAMD64X2Str, RTLYonahStr : AnsiString;
 Attributes, FindResult, ReturnValue, RowNo, ColNo, FastestPenryn,
 RTLPenryn, FastestNorthwood, RTLNorthwood, RTLYonah, FastestYonah, RTLConroe,
 FastestConroe, FastestPhenom, RTLPhenom, FastestAMD64X2, RTLAMD64X2 : Integer;
 SearchRec : TSearchRec;
 FunctionSizeFileFound : Boolean;
 PenrynSpeedUpOverRTL, NorthwoodSpeedUpOverRTL, YonahSpeedUpOverRTL,
 ConroeSpeedUpOverRTL, PhenomSpeedUpOverRTL, AMD64X2SpeedUpOverRTL: Double;

begin
 CalcWinnerButton.Enabled := False;
 ClearStringGridAndZeroCellCount(PenrynStringGrid);
 ClearStringGridAndZeroCellCount(NorthwoodStringGrid);
 ClearStringGridAndZeroCellCount(ConroeStringGrid);
 ClearStringGridAndZeroCellCount(YonahStringGrid);
 ClearStringGridAndZeroCellCount(PhenomStringGrid);
 ClearStringGridAndZeroCellCount(AMD64X2StringGrid);
 ClearStringGrid(BlendedStringGrid);
 ClearStringGrid(BlendedSizePenaltyStringGrid);
 ClearStringGrid(FunctionSizesStringGrid);
 FunctionSizeFileFound := False;
 Attributes := faAnyFile;
 if OptionsForm.FilePathLabeledEdit.Text = '' then
  raise Exception.Create('No file path selected - please go to options and select one');
 LoadPath := OptionsForm.FilePathLabeledEdit.Text;
 SearchPath := OptionsForm.FilePathLabeledEdit.Text + '\*.txt';
 FindResult := FindFirst(SearchPath, Attributes, SearchRec);
 if FindResult = 0 then
  begin
   FileName := LoadPath + '\' + SearchRec.Name;
   if Pos('Benchmark', FileName) <> 0 then
    begin
     if Pos('Penryn', FileName) <> 0 then
      begin
       ChallengeVersionNumber := LoadFile(FileName, PenrynStringGrid,
                                          PenrynCPUTypeLabeledEdit);
       SetColLabels(PenrynStringGrid, PenrynCol2Label, PenrynCol3Label,
                    PenrynCol4Label, PenrynCol5Label, PenrynCol6Label,
                    PenrynCol7Label, PenrynCol8Label);
      end
     else if Pos('Northwood', FileName) <> 0 then
      begin
       ChallengeVersionNumber := LoadFile(FileName, NorthwoodStringGrid,
                                          NorthwoodCPUTypeLabeledEdit);
       SetColLabels(NorthwoodStringGrid, NorthwoodCol2Label, NorthwoodCol3Label,
                    NorthwoodCol4Label, NorthwoodCol5Label, NorthwoodCol6Label,
                    NorthwoodCol7Label, NorthwoodCol8Label);
      end
     else if Pos('Yonah', FileName) <> 0 then
      begin
       ChallengeVersionNumber := LoadFile(FileName, YonahStringGrid,
                                          YonahCPUTypeLabeledEdit);
       SetColLabels(YonahStringGrid, YonahCol2Label, YonahCol3Label,
                    YonahCol4Label, YonahCol5Label, YonahCol6Label,
                    YonahCol7Label, YonahCol8Label);
      end
     else if Pos('Conroe', FileName) <> 0 then
      begin
       ChallengeVersionNumber := LoadFile(FileName, ConroeStringGrid,
                                          ConroeCPUTypeLabeledEdit);
       SetColLabels(ConroeStringGrid, ConroeCol2Label, ConroeCol3Label,
                    ConroeCol4Label, ConroeCol5Label, ConroeCol6Label,
                    ConroeCol7Label, ConroeCol8Label);
      end
     else if Pos('AMD_64X2', FileName) <> 0 then
      begin
       ChallengeVersionNumber := LoadFile(FileName, AMD64X2StringGrid,
                                          AMD64X2CPUTypeLabeledEdit);
       SetColLabels(AMD64X2StringGrid, AMD64X2Col2Label, AMD64X2Col3Label,
                    AMD64X2Col4Label, AMD64X2Col5Label, AMD64X2Col6Label,
                    AMD64X2Col7Label, AMD64X2Col8Label);
      end
     else if Pos('AMD_64', FileName) <> 0 then
      begin
       ChallengeVersionNumber := LoadFile(FileName, PhenomStringGrid,
                                          PhenomCPUTypeLabeledEdit);
       SetColLabels(PhenomStringGrid, PhenomCol2Label, PhenomCol3Label,
                    PhenomCol4Label, PhenomCol5Label, PhenomCol6Label,
                    PhenomCol7Label, PhenomCol8Label);
      end
     else
      raise Exception.Create('Unknown benchmark file found: ' + FileName);
    end
   else if Pos('FunctionSizes', FileName) <> 0 then
    begin
     { TODO 2 -oDKC -cBug : ChallengeName can be wrong if Do All is followed by a function winner as function of size run is done }
     if (Pos(ChallengeName, FileName) <> 0) or (ChallengeName = '') then
      begin
       LoadFunctionSizesFile(FileName, FunctionSizesStringGrid, PenaltyForSizeLabeledEdit);
       FunctionSizeFileFound := True;
      end
     else
      raise Exception.Create('FunctionSizes file is for a wrong challenge');
    end;
  end;
 repeat
  FindResult := FindNext(SearchRec);
  if FindResult <> 0 then
   Break;
  FileName := LoadPath + '\' + SearchRec.Name;
  if Pos('Benchmark', FileName) <> 0 then
   begin
    if Pos('Penryn', FileName) <> 0 then
     begin
      ChallengeVersionNumber := LoadFile(FileName, PenrynStringGrid,
                                         PenrynCPUTypeLabeledEdit);
      SetColLabels(PenrynStringGrid, PenrynCol2Label, PenrynCol3Label,
                   PenrynCol4Label, PenrynCol5Label, PenrynCol6Label,
                   PenrynCol7Label, PenrynCol8Label);
     end
    else if Pos('Northwood', FileName) <> 0 then
     begin
      ChallengeVersionNumber := LoadFile(FileName, NorthwoodStringGrid,
                                         NorthwoodCPUTypeLabeledEdit);
      SetColLabels(NorthwoodStringGrid, NorthwoodCol2Label, NorthwoodCol3Label,
                   NorthwoodCol4Label, NorthwoodCol5Label, NorthwoodCol6Label,
                   NorthwoodCol7Label, NorthwoodCol8Label);
     end
    else if Pos('Yonah', FileName) <> 0 then
     begin
      ChallengeVersionNumber := LoadFile(FileName, YonahStringGrid,
                                         YonahCPUTypeLabeledEdit);
      SetColLabels(YonahStringGrid, YonahCol2Label, YonahCol3Label,
                   YonahCol4Label, YonahCol5Label, YonahCol6Label,
                   YonahCol7Label, YonahCol8Label);
     end
    else if Pos('Conroe', FileName) <> 0 then
     begin
      ChallengeVersionNumber := LoadFile(FileName, ConroeStringGrid,
                                         ConroeCPUTypeLabeledEdit);
      SetColLabels(ConroeStringGrid, ConroeCol2Label, ConroeCol3Label,
                   ConroeCol4Label, ConroeCol5Label, ConroeCol6Label,
                   ConroeCol7Label, ConroeCol8Label);
     end
    else if Pos('AMD_64X2', FileName) <> 0 then
     begin
      ChallengeVersionNumber := LoadFile(FileName, AMD64X2StringGrid,
                                         AMD64X2CPUTypeLabeledEdit);
      SetColLabels(AMD64X2StringGrid, AMD64X2Col2Label, AMD64X2Col3Label,
                   AMD64X2Col4Label, AMD64X2Col5Label, AMD64X2Col6Label,
                   AMD64X2Col7Label, AMD64X2Col8Label);
     end
    else if Pos('AMD_64', FileName) <> 0 then
     begin
      ChallengeVersionNumber := LoadFile(FileName, PhenomStringGrid,
                                         PhenomCPUTypeLabeledEdit);
      SetColLabels(PhenomStringGrid, PhenomCol2Label, PhenomCol3Label,
                   PhenomCol4Label, PhenomCol5Label, PhenomCol6Label,
                   PhenomCol7Label, PhenomCol8Label);
     end
    else
     raise Exception.Create('Unknown benchmark file found: ' + FileName);
   end
  else if (Pos(ChallengeName, FileName) <> 0) or (ChallengeName = '') then
   begin
    LoadFunctionSizesFile(FileName, FunctionSizesStringGrid, PenaltyForSizeLabeledEdit);
    FunctionSizeFileFound := True;
   end
  else
   raise Exception.Create('FunctionSizes file is for a wrong challenge');
 until False;
 if (not FunctionSizeFileFound) and (Sender<>OptionsForm) then
  begin
   ReturnValue := Application.MessageBox('No function size file found. Do you want to create a template', 'Info', MB_YESNO);
   if ReturnValue = IDYES then
    begin
     FileName := LoadPath + '\' + ChallengeName + '_' + ChallengeVersionNumber + '_' + 'FunctionSizes.txt';
     CreateTemplateFunctionSizeFile(FileName);
     LoadFunctionSizesFile(FileName, FunctionSizesStringGrid, PenaltyForSizeLabeledEdit);
    end;
  end;
 //Calculate speedup over RTL
 //Penryn
 PenrynSpeedUpOverRTLLabeledEdit.Clear;
 FastestPenrynStr := PenrynStringGrid.Cells[PenrynStringGrid.ColCount-1,0];
 if FastestPenrynStr <> '' then
  begin
   FastestPenryn := StrToInt(FastestPenrynStr);
   RTLPenryn := 0;
   RowNo := -1;
   repeat
    Inc(RowNo);
    FunctionName := PenrynStringGrid.Cells[0,RowNo];
    AuthorName := GetAuthorName(FunctionName);
    if (UpperCase(AuthorName) = 'RTL') then
     begin
      RTLPenrynStr := PenrynStringGrid.Cells[PenrynStringGrid.ColCount-1,RowNo];
      RTLPenryn := StrToInt(RTLPenrynStr);
      Break;
     end;
   until (RowNo = PenrynStringGrid.RowCount-1);
   if (UpperCase(AuthorName) = 'RTL') then
    begin
     if ChallengeName <> 'Move' then
      PenrynSpeedUpOverRTL := RTLPenryn / FastestPenryn
     else
      PenrynSpeedUpOverRTL := FastestPenryn / RTLPenryn;
     PenrynSpeedUpOverRTLLabeledEdit.Text := FloatToStrF(PenrynSpeedUpOverRTL, ffFixed, 7, 2);
    end;
  end;
 //Northwood
 NorthwoodSpeedUpOverRTLLabeledEdit.Clear;
 FastestNorthwoodStr := NorthwoodStringGrid.Cells[NorthwoodStringGrid.ColCount-1,0];
 if FastestNorthwoodStr <> '' then
  begin
   FastestNorthwood := StrToInt(FastestNorthwoodStr);
   RTLNorthwood := 0;
   RowNo := -1;
   repeat
    Inc(RowNo);
    FunctionName := NorthwoodStringGrid.Cells[0,RowNo];
    AuthorName := GetAuthorName(FunctionName);
    if (UpperCase(AuthorName) = 'RTL') then
     begin
      RTLNorthwoodStr := NorthwoodStringGrid.Cells[NorthwoodStringGrid.ColCount-1,RowNo];
      RTLNorthwood := StrToInt(RTLNorthwoodStr);
      Break;
     end;
   until (RowNo = NorthwoodStringGrid.RowCount-1);
   if (UpperCase(AuthorName) = 'RTL') then
    begin
     if ChallengeName <> 'Move' then
      NorthwoodSpeedUpOverRTL := RTLNorthwood / FastestNorthwood
     else
      NorthwoodSpeedUpOverRTL := FastestNorthwood / RTLNorthwood;
     NorthwoodSpeedUpOverRTLLabeledEdit.Text := FloatToStrF(NorthwoodSpeedUpOverRTL, ffFixed, 7, 2);
    end;
  end;
 //Yonah
 YonahSpeedUpOverRTLLabeledEdit.Clear;
 FastestYonahStr := YonahStringGrid.Cells[YonahStringGrid.ColCount-1,0];
 if FastestYonahStr <> '' then
  begin
   FastestYonah := StrToInt(FastestYonahStr);
   RTLYonah := 0;
   RowNo := -1;
   repeat
    Inc(RowNo);
    FunctionName := YonahStringGrid.Cells[0,RowNo];
    AuthorName := GetAuthorName(FunctionName);
    if (UpperCase(AuthorName) = 'RTL') then
     begin
      RTLYonahStr := YonahStringGrid.Cells[YonahStringGrid.ColCount-1,RowNo];
      RTLYonah := StrToInt(RTLYonahStr);
      Break;
     end;
   until (RowNo = YonahStringGrid.RowCount-1);
   if (UpperCase(AuthorName) = 'RTL') then
    begin
     if ChallengeName <> 'Move' then
      YonahSpeedUpOverRTL := RTLYonah / FastestYonah
     else
      YonahSpeedUpOverRTL := FastestYonah / RTLYonah;
     YonahSpeedUpOverRTLLabeledEdit.Text := FloatToStrF(YonahSpeedUpOverRTL, ffFixed, 7, 2);
    end;
  end;
 //Conroe
 ConroeSpeedUpOverRTLLabeledEdit.Clear;
 FastestConroeStr := ConroeStringGrid.Cells[ConroeStringGrid.ColCount-1,0];
 if FastestConroeStr <> '' then
  begin
   FastestConroe := StrToInt(FastestConroeStr);
   RTLConroe := 0;
   RowNo := -1;
   repeat
    Inc(RowNo);
    FunctionName := ConroeStringGrid.Cells[0,RowNo];
    AuthorName := GetAuthorName(FunctionName);
    if (UpperCase(AuthorName) = 'RTL') then
     begin
      RTLConroeStr := ConroeStringGrid.Cells[ConroeStringGrid.ColCount-1,RowNo];
      RTLConroe := StrToInt(RTLConroeStr);
      Break;
     end;
   until (RowNo = ConroeStringGrid.RowCount-1);
   if (UpperCase(AuthorName) = 'RTL') then
    begin
     if ChallengeName <> 'Move' then
      ConroeSpeedUpOverRTL := RTLConroe / FastestConroe
     else
      ConroeSpeedUpOverRTL := FastestConroe / RTLConroe;
     ConroeSpeedUpOverRTLLabeledEdit.Text := FloatToStrF(ConroeSpeedUpOverRTL, ffFixed, 7, 2);
    end;
  end;
 //Phenom
 PhenomSpeedUpOverRTLLabeledEdit.Clear;
 FastestPhenomStr := PhenomStringGrid.Cells[PhenomStringGrid.ColCount-1,0];
 if FastestPhenomStr <> '' then
  begin
   FastestPhenom := StrToInt(FastestPhenomStr);
   RTLPhenom := 0;
   RowNo := -1;
   repeat
    Inc(RowNo);
    FunctionName := PhenomStringGrid.Cells[0,RowNo];
    AuthorName := GetAuthorName(FunctionName);
    if (UpperCase(AuthorName) = 'RTL') then
     begin
      RTLPhenomStr := PhenomStringGrid.Cells[PhenomStringGrid.ColCount-1,RowNo];
      RTLPhenom := StrToInt(RTLPhenomStr);
      Break;
     end;
   until (RowNo = PhenomStringGrid.RowCount-1);
   if (UpperCase(AuthorName) = 'RTL') then
    begin
     if ChallengeName <> 'Move' then
      PhenomSpeedUpOverRTL := RTLPhenom / FastestPhenom
     else
      PhenomSpeedUpOverRTL := FastestPhenom / RTLPhenom;
     PhenomSpeedUpOverRTLLabeledEdit.Text := FloatToStrF(PhenomSpeedUpOverRTL, ffFixed, 7, 2);
    end;
  end;
 //AMD64X2
 AMD64X2SpeedUpOverRTLLabeledEdit.Clear;
 FastestAMD64X2Str := AMD64X2StringGrid.Cells[AMD64X2StringGrid.ColCount-1,0];
 if FastestAMD64X2Str <> '' then
  begin
   FastestAMD64X2 := StrToInt(FastestAMD64X2Str);
   RTLAMD64X2 := 0;
   RowNo := -1;
   repeat
    Inc(RowNo);
    FunctionName := AMD64X2StringGrid.Cells[0,RowNo];
    AuthorName := GetAuthorName(FunctionName);
    if (UpperCase(AuthorName) = 'RTL') then
     begin
      RTLAMD64X2Str := AMD64X2StringGrid.Cells[AMD64X2StringGrid.ColCount-1,RowNo];
      RTLAMD64X2 := StrToInt(RTLAMD64X2Str);
      Break;
     end;
   until (RowNo = AMD64X2StringGrid.RowCount-1);
   if (UpperCase(AuthorName) = 'RTL') then
    begin
     if ChallengeName <> 'Move' then
      AMD64X2SpeedUpOverRTL := RTLAMD64X2 / FastestAMD64X2
     else
      AMD64X2SpeedUpOverRTL := FastestAMD64X2 / RTLAMD64X2;
     AMD64X2SpeedUpOverRTLLabeledEdit.Text := FloatToStrF(AMD64X2SpeedUpOverRTL, ffFixed, 7, 2);
    end;
  end;
 FindClose(SearchRec);
 TestFunctionSizes;
 ChallengeVersionNumberEdit.Text := ChallengeVersionNumber;
 CalculateBlendedSizePenaltyButton.Enabled := True;
 CalculateBlendedButton.Enabled := True;
 CalcWinnerButton.Enabled := True;
end;

procedure TMainForm.LoadFileButtonClick(Sender: TObject);
var
 FileName : AnsiString;

begin
 FileOpenDialog.DefaultExt := '.txt';
 FileOpenDialog.Filter := 'Text files (*.txt)|*.TXT';
 FileOpenDialog.InitialDir := ExtractFilePath(Application.ExeName);
 case PageControl1.ActivePageIndex of
  0 :
   begin
    if FileOpenDialog.Execute then
     begin
      FileName := FileOpenDialog.FileName;
      LoadFile(FileName, PenrynStringGrid, PenrynCPUTypeLabeledEdit);
      SetColLabels(PenrynStringGrid, PenrynCol2Label, PenrynCol3Label,
                   PenrynCol4Label, PenrynCol5Label, PenrynCol6Label,
                   PenrynCol7Label, PenrynCol8Label);
     end;
   end;
  1 :
   begin
    if FileOpenDialog.Execute then
     begin
      FileName := FileOpenDialog.FileName;
      LoadFile(FileName, NorthwoodStringGrid, NorthwoodCPUTypeLabeledEdit);
      SetColLabels(NorthwoodStringGrid, NorthwoodCol2Label, NorthwoodCol3Label,
                   NorthwoodCol4Label, NorthwoodCol5Label, NorthwoodCol6Label,
                   NorthwoodCol7Label, NorthwoodCol8Label);
     end;
   end;
  2 :
   begin
    if FileOpenDialog.Execute then
     begin
      FileName := FileOpenDialog.FileName;
      LoadFile(FileName, YonahStringGrid, YonahCPUTypeLabeledEdit);
      SetColLabels(YonahStringGrid, YonahCol2Label, YonahCol3Label,
                   YonahCol4Label, YonahCol5Label, YonahCol6Label,
                   YonahCol7Label, YonahCol8Label);
     end;
   end;
  3 :
   begin
    if FileOpenDialog.Execute then
     begin
      FileName := FileOpenDialog.FileName;
      LoadFile(FileName, ConroeStringGrid, ConroeCPUTypeLabeledEdit);
      SetColLabels(ConroeStringGrid, ConroeCol2Label, ConroeCol3Label,
                   ConroeCol4Label, ConroeCol5Label, ConroeCol6Label,
                   ConroeCol7Label, ConroeCol8Label);
     end;
   end;
  4 :
   begin
    if FileOpenDialog.Execute then
     begin
      FileName := FileOpenDialog.FileName;
      LoadFile(FileName, PhenomStringGrid, PhenomCPUTypeLabeledEdit);
      SetColLabels(PhenomStringGrid, PhenomCol2Label, PhenomCol3Label,
                   PhenomCol4Label, PhenomCol5Label, PhenomCol6Label,
                   PhenomCol7Label, PhenomCol8Label);
     end;
   end;
  5 :
   begin
    if FileOpenDialog.Execute then
     begin
      FileName := FileOpenDialog.FileName;
      LoadFile(FileName, AMD64X2StringGrid, AMD64X2CPUTypeLabeledEdit);
      SetColLabels(AMD64X2StringGrid, AMD64X2Col2Label, AMD64X2Col3Label,
                   AMD64X2Col4Label, AMD64X2Col5Label, AMD64X2Col6Label,
                   AMD64X2Col7Label, AMD64X2Col8Label);
     end;
   end;
  9 :
   begin
    if FileOpenDialog.Execute then
     begin
      FileName := FileOpenDialog.FileName;
      LoadFunctionSizesFile(FileName, FunctionSizesStringGrid,
                            PenaltyForSizeLabeledEdit);
     end;
   end;
  else
   Application.MessageBox('Nothing to load for this page', 'Error', MB_OK) 
 end;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
 OptionsForm.ShowModal;
end;

end.
