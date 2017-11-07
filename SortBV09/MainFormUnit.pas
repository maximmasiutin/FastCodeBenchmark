unit MainFormUnit;

interface

{$INCLUDE Defines.inc}

uses
  Buttons, CheckLst, Classes, Clipbrd, ComCtrls, Controls, Dialogs, Forms,
  Graphics, ImgList, Math, Menus, StdCtrls, SysUtils, Windows,
  FastcodeChallengeUnit, FastcodeChallengeManagementUnit, ExtCtrls;

type
  TListViewResultsColumn = (lrcName, lrcAlign, lrcCategory, lrcAuthor, lrcValid,
    lrcBenchRes, lrcBenchSpread, lrcSubBench);

const
  LISTVIEWRESULTS_COLUMN_NAMES: array[TListViewResultsColumn] of string = (
    'Name',         // lrcName
    'Alignment',    // lrcAlign
    'Category',     // lrcCategory
    'Author',       // lrcAuthor
    'Validation',   // lrcValid
    'Result',       // lrcBenchRes
    'Spread',       // lrcBenchSpread
    'SubBench %d'); // lrcSubBench

  LISTVIEWRESULTS_COLUMN_WIDTHS: array[TListViewResultsColumn] of Integer = (
    4,  // lrcName
    1,  // lrcAlign
    2,  // lrcCategory
    2,  // lrcAuthor
    2,  // lrcValid
    2,  // lrcBenchRes
    2,  // lrcBenchSpread
    2); // lrcSubBench

type
  TChallengeArray = array of TFastcodeChallenge;

  TIntegerArray = array of Integer;

  TMainForm = class(TForm)
  private
    FBenchmarking: Boolean;
    FManager: TFastcodeChallengeManager;
    FListViewResultsColumns: set of TListViewResultsColumn;
    FListViewResultsSortColumn: Integer;
    FListViewResultsSortRevert: Boolean;
    procedure CheckListBoxFunctionSelectAll(Select: Boolean);
    procedure CheckListBoxFunctionSelectAuthor(Select: Boolean);
    procedure CheckListBoxFunctionSelectCategory(Select: Boolean);
    function GetCurrentChallenge: TFastcodeChallenge;
    function GetPopupMenuResultColumnsItem(LRC: TListViewResultsColumn): TMenuItem;
    function GetPopupMenuResultColumnsItemIndex(Item: TMenuItem): TListViewResultsColumn;
    procedure ManagerBenchmarkStart(Sender: TObject; Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; Index, Count: Integer);
    procedure ManagerLogLine(Sender: TObject; const Text: string);
    procedure ManagerProgress(Sender: TObject; Progress, ProgressMax: Integer);
    procedure ManagerResultsUpdated(Sender: TObject; Challenge: TFastcodeChallenge);
    procedure ManagerStatusChange(Sender: TObject; const StatusText: string; Busy: Boolean);
    procedure ManagerValidateStart(Sender: TObject; Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; Index, Count: Integer);
    procedure ReportToFile(const Separator: string; Quoted: Boolean; const DefaultExt: string);
    procedure UpdateListViewResults;
    procedure UpdateListViewResultsColumns;
    procedure UpdateListViewResultsSortIcon;
    procedure UpdateTab;
  published
    ButtonBenchmarkSpread: TButton;
    ButtonAllDeselect: TButton;
    ButtonAllSelect: TButton;
    ButtonAuthorDeselect: TButton;
    ButtonAuthorSelect: TButton;
    ButtonBenchmarkAll: TButton;
    ButtonBenchmarkSel: TButton;
    ButtonCategoryDeselect: TButton;
    ButtonCategorySelect: TButton;
    ButtonReportCopy: TButton;
    ButtonReportShow: TButton;
    ButtonValidateAll: TButton;
    ButtonValidateSel: TButton;
    CheckListBoxFunction: TCheckListBox;
    ComboBoxAuthor: TComboBox;
    ComboBoxCategory: TComboBox;
    EditSpread: TEdit;
    LabelAuthor: TLabel;
    LabelCategory: TLabel;
    LabelFunctionSelection: TLabel;
    LabelLog: TLabel;
    LabelResults: TLabel;
    LabelSelectAll: TLabel;
    LabelSpread: TLabel;
    ListViewResults: TListView;
    MainMenu: TMainMenu;
    MemoLog: TMemo;
    MenuItemBenchmark: TMenuItem;
    MenuItemExit: TMenuItem;
    MenuItemFile: TMenuItem;
    MenuItemGlobal: TMenuItem;
    MenuItemReport: TMenuItem;
    MenuItemReportClipboard: TMenuItem;
    MenuItemReportFile: TMenuItem;
    MenuItemReportFileCSV: TMenuItem;
    MenuItemReportFileTabSeparated: TMenuItem;
    MenuItemSubBenchmark: TMenuItem;
    MenuItemSubchallenge: TMenuItem;
    MenuItemSubValidate: TMenuItem;
    MenuItemValidate: TMenuItem;
    Panel1: TPanel;
    PopupMenuResultColumns: TPopupMenu;
    PopupMenuResultColumnsItem1: TMenuItem;
    PopupMenuResultColumnsItem2: TMenuItem;
    PopupMenuResultColumnsItem3: TMenuItem;
    PopupMenuResultColumnsItem4: TMenuItem;
    PopupMenuResultColumnsItem5: TMenuItem;
    PopupMenuResultColumnsItem6: TMenuItem;
    PopupMenuResultColumnsItem7: TMenuItem;
    PopupMenuResultColumnsItem8: TMenuItem;
    ProgressBar: TProgressBar;
    SaveDialogReport: TSaveDialog;
    SortImageList: TImageList;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    StatusBar: TStatusBar;
    TabControl: TTabControl;
    procedure ButtonAllDeselectClick(Sender: TObject);
    procedure ButtonAllSelectClick(Sender: TObject);
    procedure ButtonAuthorDeselectClick(Sender: TObject);
    procedure ButtonAuthorSelectClick(Sender: TObject);
    procedure ButtonBenchmarkAllClick(Sender: TObject);
    procedure ButtonBenchmarkSelClick(Sender: TObject);
    procedure ButtonBenchmarkSpreadClick(Sender: TObject);
    procedure ButtonCategoryDeselectClick(Sender: TObject);
    procedure ButtonCategorySelectClick(Sender: TObject);
    procedure ButtonReportCopyClick(Sender: TObject);
    procedure ButtonReportShowClick(Sender: TObject);
    procedure ButtonValidateAllClick(Sender: TObject);
    procedure ButtonValidateSelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListViewResultsColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListViewResultsColumnRightClick(Sender: TObject; Column: TListColumn; Point: TPoint);
    procedure ListViewResultsCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure MenuItemBenchmarkClick(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);
    procedure MenuItemReportClick(Sender: TObject);
    procedure MenuItemReportClipboardClick(Sender: TObject);
    procedure MenuItemReportFileCSVClick(Sender: TObject);
    procedure MenuItemReportFileTabSeparatedClick(Sender: TObject);
    procedure MenuItemValidateClick(Sender: TObject);
    procedure PopupMenuResultColumnsItemClick(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  D5Support, ReportFormUnit, ReportWriterUnit, SystemInfoUnit, UtilsUnit;

procedure TMainForm.CheckListBoxFunctionSelectAll(Select: Boolean);
var
  I: Integer;
begin
  for I := 0 to CheckListBoxFunction.Items.Count-1 do
    CheckListBoxFunction.Checked[I] := Select;
end;

procedure TMainForm.CheckListBoxFunctionSelectAuthor(Select: Boolean);
var
  Author: TFastcodeAuthor;
  CurrFunction: PFastcodeChallengeFunction;
  I: Integer;
begin
  Author := TFastcodeAuthor(ComboBoxAuthor.Items.Objects[ComboBoxAuthor.ItemIndex]);
  for I := 0 to CheckListBoxFunction.Items.Count-1 do
  begin
    CurrFunction := PFastcodeChallengeFunction(CheckListBoxFunction.Items.Objects[I]);
    if CurrFunction^.Author = Author then
      CheckListBoxFunction.Checked[I] := Select;
  end;
end;

procedure TMainForm.CheckListBoxFunctionSelectCategory(Select: Boolean);
var
  Category: TFastcodeCategory;
  CurrFunction: PFastcodeChallengeFunction;
  I: Integer;
begin
  Category := TFastcodeCategory(ComboBoxCategory.Items.Objects[ComboBoxCategory.ItemIndex]);
  for I := 0 to CheckListBoxFunction.Items.Count-1 do
  begin
    CurrFunction := PFastcodeChallengeFunction(CheckListBoxFunction.Items.Objects[I]);
    if CurrFunction^.Category = Category then
      CheckListBoxFunction.Checked[I] := Select;
  end;
end;

function TMainForm.GetCurrentChallenge: TFastcodeChallenge;
begin
  Result := TFastcodeChallenge.Challenges[TabControl.TabIndex];
end;

function TMainForm.GetPopupMenuResultColumnsItem(LRC: TListViewResultsColumn): TMenuItem;
begin
  case LRC of
    lrcName:        Result := PopupMenuResultColumnsItem1;
    lrcAlign:       Result := PopupMenuResultColumnsItem2;
    lrcCategory:    Result := PopupMenuResultColumnsItem3;
    lrcAuthor:      Result := PopupMenuResultColumnsItem4;
    lrcValid:       Result := PopupMenuResultColumnsItem5;
    lrcBenchRes:    Result := PopupMenuResultColumnsItem6;
    lrcBenchSpread: Result := PopupMenuResultColumnsItem7;
    lrcSubBench:    Result := PopupMenuResultColumnsItem8;
  else
    Assert(False, Format('TMainForm.GetPopupMenuResultColumnsItem: column index %d out of bounds', [Ord(LRC)]));
    Result := nil;
  end;
end;

function TMainForm.GetPopupMenuResultColumnsItemIndex(Item: TMenuItem): TListViewResultsColumn;
begin
  Assert(Item.Tag in [Ord(Low(TListViewResultsColumn))..Ord(High(TListViewResultsColumn))],
    Format('TMainForm.GetPopupMenuResultColumnsItemIndex: column index %d out of bounds', [Item.Tag]));
  Result := TListViewResultsColumn(Item.Tag);
end;

procedure TMainForm.ManagerBenchmarkStart(Sender: TObject; Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; Index, Count: Integer);
var
  I: Integer;
begin
  if Challenge <> GetCurrentChallenge then
    Exit;

  for I := 0 to CheckListBoxFunction.Items.Count - 1 do
    if PFastcodeChallengeFunction(CheckListBoxFunction.Items.Objects[I]) = Func then
    begin
      CheckListBoxFunction.ItemIndex := I;
      Break;
    end;
end;

procedure TMainForm.ManagerLogLine(Sender: TObject; const Text: string);
begin
  MemoLog.Lines.Add(Text);
end;

procedure TMainForm.ManagerProgress(Sender: TObject; Progress, ProgressMax: Integer);
begin
  ProgressBar.Max := ProgressMax;
  ProgressBar.Position := Progress;
  Update;
end;

procedure TMainForm.ManagerResultsUpdated(Sender: TObject; Challenge: TFastcodeChallenge);
begin
  if Challenge = GetCurrentChallenge then
    UpdateListViewResults;
end;

procedure TMainForm.ManagerStatusChange(Sender: TObject; const StatusText: string; Busy: Boolean);
begin
  StatusBar.SimpleText := StatusText;
  if not Busy then
    ProgressBar.Position := 0;
end;

procedure TMainForm.ManagerValidateStart(Sender: TObject; Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; Index, Count: Integer);
var
  I: Integer;
begin
  if Challenge <> GetCurrentChallenge then
    Exit;

  for I := 0 to CheckListBoxFunction.Items.Count - 1 do
    if PFastcodeChallengeFunction(CheckListBoxFunction.Items.Objects[I]) = Func then
    begin
      CheckListBoxFunction.ItemIndex := I;
      Break;
    end;
end;

procedure TMainForm.ReportToFile(const Separator: string; Quoted: Boolean; const DefaultExt: string);
var
  Challenges: TFastcodeChallengeArray;
  DefaultFilename: string;
  I: Integer;
  ReportWriter: TReportWriterTextSeparated;
begin
  Challenges := TFastcodeChallenge.Challenges;

  DefaultFilename := 'BenchReport';
  for I := Low(Challenges) to High(Challenges) do
   if FManager.HasResults(Challenges[I]) then
     DefaultFilename := Challenges[I].Name + '_' + DefaultFilename;
  SaveDialogReport.FileName := DefaultFilename + '.' + DefaultExt;
  SaveDialogReport.DefaultExt := '.' + DefaultExt;

  if not SaveDialogReport.Execute then
    Exit;

  ReportWriter := TReportWriterTextSeparated.Create(Separator, Quoted);
  try
    FManager.ReportText(Challenges, ReportWriter);
    ReportWriter.SaveToFile(SaveDialogReport.FileName);
  finally
    ReportWriter.Free;
  end;
end;

procedure TMainForm.UpdateListViewResults;
const
  VALIDATION_STRINGS: array[TTriState] of string = (
    'Failed', // tsFalse
    'Passed', // tsTrue
    '');      // tsUnknown
var
  Challenge: TFastcodeChallenge;
  Func: PFastcodeChallengeFunction;
  I: Integer;
  ResultRec: PFunctionResultRec;
  ValidateList: TList;
  WorstSpread: Double;

 procedure AddItem(Func: PFastcodeChallengeFunction; ResultRec: PFunctionResultRec); forward;
 procedure DisplaySubBenches(ResultRec: PFunctionResultRec; Dest: TStrings); forward;

 procedure AddItem(Func: PFastcodeChallengeFunction; ResultRec: PFunctionResultRec);
 var
   LRC: TListViewResultsColumn;
   NewItem: TListItem;
   BenchmarkSum, Spread: Double;
 begin
   NewItem := ListViewResults.Items.Add;
   NewItem.Caption := Func^.Name;
   NewItem.ImageIndex := -1;

   if ResultRec = nil then
   begin
     BenchmarkSum := Nan;
     Spread := Nan;
   end
   else
   begin
     BenchmarkSum := ResultRec^.BenchmarkSum;
     Spread := FManager.CalculateSpread(ResultRec^.Challenge, ResultRec^.Func);
     if not IsNan(Spread) and (IsNan(WorstSpread) or (Spread > WorstSpread)) then
       WorstSpread := Spread;
   end;             

   for LRC := Low(TListViewResultsColumn) to High(TListViewResultsColumn) do
     if LRC in FListViewResultsColumns then
       case LRC of
         lrcName:        { The name is shown as the caption };
         lrcAlign:       NewItem.SubItems.Add(Format('%.1x', [LongWord(Func^.Addr) and $F]));
         lrcCategory:    NewItem.SubItems.Add(FASTCODE_CATEGORY_NAMES[Func^.Category]);
         lrcAuthor:      NewItem.SubItems.Add(FASTCODE_AUTHOR_NAMES[Func^.Author]);
         lrcValid:       NewItem.SubItems.Add(VALIDATION_STRINGS[Func^.Valid]);
         lrcBenchRes:    NewItem.SubItems.Add(BenchmarkResultToString(BenchmarkSum));
         lrcBenchSpread: NewItem.SubItems.Add(BenchmarkSpreadToString(Spread));
         lrcSubBench:    DisplaySubBenches(ResultRec, NewItem.SubItems);
       else
         Assert(False, Format('TMainForm.UpdateListViewResults: the column of type %d is not being handled', [Ord(LRC)]));
       end;
 end;

 procedure DisplaySubBenches(ResultRec: PFunctionResultRec; Dest: TStrings);
 var
   I: Integer;
 begin
   if ResultRec = nil then
   begin
     for I := 0 to Challenge.BenchmarkCount - 1 do
       Dest.Add('');
   end
   else
   begin
     for I := Low(ResultRec^.BenchmarkSub) to High(ResultRec^.BenchmarkSub) do
       Dest.Add(BenchmarkResultToString(ResultRec^.BenchmarkSub[I]));
   end;
 end;

begin
  if FBenchmarking then
    Exit;

  WorstSpread := Nan;

  Challenge := GetCurrentChallenge;
  ListViewResults.Items.Clear;
  ListViewResults.Items.BeginUpdate;
  try
    FManager.Lock;
    try
      ValidateList := TList.Create;
      try
        ValidateList.Capacity := Challenge.FunctionCount;
        for I := 0 to Challenge.FunctionCount - 1 do
          ValidateList.Add(Challenge.Functions[I]);

        if FListViewResultsColumns * [lrcBenchRes, lrcBenchSpread, lrcSubBench] <> [] then
          for I := 0 to FManager.ResultCount - 1 do
          begin
            ResultRec := FManager.Results[I];
            if ResultRec^.Challenge = Challenge then
            begin
              AddItem(ResultRec^.Func, ResultRec);
              ValidateList.Remove(ResultRec^.Func);
            end;
          end;

        if lrcValid in FListViewResultsColumns then
          for I := 0 to ValidateList.Count - 1 do
          begin
            Func := PFastcodeChallengeFunction(ValidateList[I]);
            if Func^.Valid <> tsNull then
              AddItem(Func, nil);
          end;
      finally
        ValidateList.Free;
      end;
    finally
      FManager.Unlock;
    end;
  finally
    ListViewResults.Items.EndUpdate;
  end;

  EditSpread.Text := BenchmarkSpreadToString(WorstSpread);
  if IsNan(WorstSpread) then
    EditSpread.Color := clWhite
  else
    if WorstSpread > 0.01 then
      EditSpread.Color := clRed
    else
      EditSpread.Color := clGreen;
end;

procedure TMainForm.UpdateListViewResultsColumns;
var
  Challenge: TFastcodeChallenge;
  I: Integer;
  LRC: TListViewResultsColumn;
  NewColumn: TListColumn;
  WidthFactor, WidthTotal: Integer;
begin
  Challenge := GetCurrentChallenge;

  WidthTotal := 0;
  for LRC := Low(TListViewResultsColumn) to High(TListViewResultsColumn) do
    if (LRC <> lrcSubBench) and (LRC in FListViewResultsColumns) then
      WidthTotal := WidthTotal+LISTVIEWRESULTS_COLUMN_WIDTHS[LRC];
  if lrcSubBench in FListViewResultsColumns then
    WidthTotal := WidthTotal + LISTVIEWRESULTS_COLUMN_WIDTHS[lrcSubBench]*Challenge.BenchmarkCount;
  WidthFactor := ListViewResults.ClientWidth div WidthTotal;

  FListViewResultsSortColumn := 0;

  ListViewResults.Columns.BeginUpdate;
  try
    ListViewResults.Columns.Clear;
    for LRC := Low(TListViewResultsColumn) to High(TListViewResultsColumn) do
      if (LRC <> lrcSubBench) and (LRC in FListViewResultsColumns) then
      begin
        NewColumn := ListViewResults.Columns.Add;
        NewColumn.Caption := LISTVIEWRESULTS_COLUMN_NAMES[LRC];
        NewColumn.Width := LISTVIEWRESULTS_COLUMN_WIDTHS[LRC]*WidthFactor;
        if LRC = lrcBenchRes then
          FListViewResultsSortColumn := NewColumn.Index;
      end;
    if lrcSubBench in FListViewResultsColumns then
      for I := 0 to Challenge.BenchmarkCount-1 do
      begin
        NewColumn := ListViewResults.Columns.Add;
        NewColumn.Caption := Format(LISTVIEWRESULTS_COLUMN_NAMES[lrcSubBench], [I+1]);
        NewColumn.Width := LISTVIEWRESULTS_COLUMN_WIDTHS[lrcSubBench]*WidthFactor;
      end;
  finally
    ListViewResults.Columns.EndUpdate;
  end;

  UpdateListViewResultsSortIcon;
  UpdateListViewResults;
end;

procedure TMainForm.UpdateListViewResultsSortIcon;
var
  I: Integer;
begin
  for I := 0 to ListViewResults.Columns.Count-1 do
    if I = FListViewResultsSortColumn then
      ListViewResults.Columns[I].ImageIndex := Ord(FListViewResultsSortRevert)
    else
      ListViewResults.Columns[I].ImageIndex := -1;
end;

procedure TMainForm.UpdateTab;
var
  Author: TFastcodeAuthor;
  Authors: set of TFastcodeAuthor;
  Category: TFastcodeCategory;
  Categories: set of TFastcodeCategory;
  Challenge: TFastcodeChallenge;
  CurrFunction: PFastcodeChallengeFunction;
  I: Integer;
  Name: string;
begin
  Challenge := GetCurrentChallenge;
  Authors := [];
  Categories := [];

  CheckListBoxFunction.Items.Clear;
  for I := 0 to Challenge.FunctionCount-1 do
  begin
    CurrFunction := Challenge.Functions[I];
    Authors := Authors+[CurrFunction^.Author];
    Categories := Categories+[CurrFunction^.Category];

    Name := CurrFunction^.Name;
    if CurrFunction^.Desc <> '' then
      Name := Name + ' - ' + CurrFunction^.Desc;
    CheckListBoxFunction.Items.AddObject(Name, TObject(CurrFunction));
  end;

  ComboBoxAuthor.Items.Clear;
  for Author := Low(TFastcodeAuthor) to High(TFastcodeAuthor) do
    if Author in Authors then
      ComboBoxAuthor.Items.AddObject(FASTCODE_AUTHOR_NAMES[Author], TObject(Author));
  ComboBoxAuthor.ItemIndex := 0;

  ComboBoxCategory.Items.Clear;
  for Category := Low(TFastcodeCategory) to High(TFastcodeCategory) do
    if Category in Categories then
      ComboBoxCategory.Items.AddObject(FASTCODE_CATEGORY_NAMES[Category], TObject(Category));
  ComboBoxCategory.ItemIndex := 0;

  UpdateListViewResultsColumns;

  Caption := Format('%s B&V for Fastcode version %s', [Challenge.Name, Challenge.Version]);
end;

procedure TMainForm.ButtonAllDeselectClick(Sender: TObject);
begin
  CheckListBoxFunctionSelectAll(False);
end;

procedure TMainForm.ButtonAllSelectClick(Sender: TObject);
begin
  CheckListBoxFunctionSelectAll(True);
end;

procedure TMainForm.ButtonAuthorDeselectClick(Sender: TObject);
begin
  CheckListBoxFunctionSelectAuthor(False);
end;

procedure TMainForm.ButtonAuthorSelectClick(Sender: TObject);
begin
  CheckListBoxFunctionSelectAuthor(True);
end;

procedure TMainForm.ButtonBenchmarkAllClick(Sender: TObject);
var
  Functions: array of PFastcodeChallengeFunction;
  I: Integer;
begin
  FListViewResultsColumns := [lrcName, lrcAlign, lrcBenchRes, lrcSubBench];
  UpdateListViewResultsColumns;

  SetLength(Functions, CheckListBoxFunction.Items.Count);
  for I := 0 to CheckListBoxFunction.Items.Count - 1 do
    Functions[I] := PFastcodeChallengeFunction(CheckListBoxFunction.Items.Objects[I]);

  FBenchmarking := True;
  try
    FManager.Benchmark(GetCurrentChallenge, Functions);
  finally
    FBenchmarking := False;
  end;
  CheckListBoxFunction.ItemIndex := -1;
  UpdateListViewResults;
end;

procedure TMainForm.ButtonBenchmarkSelClick(Sender: TObject);
var
  Functions: array of PFastcodeChallengeFunction;
  FunctionCount, I: Integer;
begin
  SetLength(Functions, CheckListBoxFunction.Items.Count);
  FunctionCount := 0;
  for I := 0 to CheckListBoxFunction.Items.Count - 1 do
    if CheckListBoxFunction.Checked[I] then
    begin
      Functions[FunctionCount] := PFastcodeChallengeFunction(CheckListBoxFunction.Items.Objects[I]);
      Inc(FunctionCount);
    end;
  SetLength(Functions, FunctionCount);

  FBenchmarking := True;
  try
    FManager.Benchmark(GetCurrentChallenge, Functions);
  finally
    FBenchmarking := False;
  end;
  CheckListBoxFunction.ItemIndex := -1;
  UpdateListViewResults;
end;

procedure TMainForm.ButtonCategoryDeselectClick(Sender: TObject);
begin
  CheckListBoxFunctionSelectCategory(False);
end;

procedure TMainForm.ButtonCategorySelectClick(Sender: TObject);
begin
  CheckListBoxFunctionSelectCategory(True);
end;

procedure TMainForm.ButtonReportCopyClick(Sender: TObject);
var
  ReportWriter: TReportWriterTextPlain;
begin
  ReportWriter := TReportWriterTextPlain.Create;
  try
    FManager.ReportText([GetCurrentChallenge], ReportWriter);
    Clipboard.SetTextBuf(PChar(ReportWriter.ToString));
  finally
    ReportWriter.Free;
  end;
end;

procedure TMainForm.ButtonReportShowClick(Sender: TObject);
var
  ReportWriter: TReportWriterTextPlain;
  RF: TReportForm;
begin
  RF := TReportForm.Create(nil);
  try
    ReportWriter := TReportWriterTextPlain.Create;
    try
      FManager.ReportText([GetCurrentChallenge], ReportWriter);
      RF.Text := ReportWriter.ToString;
    finally
      ReportWriter.Free;
    end;
    RF.Show;
  except
    RF.Free;
    raise;
  end;
end;

procedure TMainForm.ButtonValidateAllClick(Sender: TObject);
var
  Functions: array of PFastcodeChallengeFunction;
  I: Integer;
begin
  FListViewResultsColumns := [lrcName, lrcAlign, lrcValid];
  UpdateListViewResultsColumns;

  SetLength(Functions, CheckListBoxFunction.Items.Count);
  for I := 0 to CheckListBoxFunction.Items.Count - 1 do
    Functions[I] := PFastcodeChallengeFunction(CheckListBoxFunction.Items.Objects[I]);

  FManager.Validate(GetCurrentChallenge, Functions);
  CheckListBoxFunction.ItemIndex := -1;
end;

procedure TMainForm.ButtonValidateSelClick(Sender: TObject);
var
  Functions: array of PFastcodeChallengeFunction;
  FunctionCount, I: Integer;
begin
  SetLength(Functions, CheckListBoxFunction.Items.Count);
  FunctionCount := 0;
  for I := 0 to CheckListBoxFunction.Items.Count - 1 do
    if CheckListBoxFunction.Checked[I] then
    begin
      Functions[FunctionCount] := PFastcodeChallengeFunction(CheckListBoxFunction.Items.Objects[I]);
      Inc(FunctionCount);
    end;
  SetLength(Functions, FunctionCount);

  FManager.Validate(GetCurrentChallenge, Functions);
  CheckListBoxFunction.ItemIndex := -1;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  Challenges: TFastcodeChallengeArray;
  H, I, W: Integer;
begin
  FManager := TFastcodeChallengeManager.Create;
  FManager.OnBenchmarkStart := ManagerBenchmarkStart;
  FManager.OnLogLine := ManagerLogLine;
  FManager.OnProgress := ManagerProgress;
  FManager.OnResultsUpdated := ManagerResultsUpdated;
  FManager.OnStatusChange := ManagerStatusChange;
  FManager.OnValidateStart := ManagerValidateStart;

  W := Math.Min(Math.Max(700, Screen.Width - 200), 1000);
  H := W * Screen.Height div Screen.Width;
  SetBounds((Screen.Width - W) div 2, (Screen.Height - H) div 2, W, H);

  FListViewResultsColumns := [lrcName, lrcAlign, lrcValid, lrcBenchRes, lrcBenchSpread];

  TabControl.Tabs.Clear;
  Challenges := TFastcodeChallenge.Challenges;
  for I := Low(Challenges) to High(Challenges) do
    TabControl.Tabs.Add(Format('%s (v %s)', [Challenges[I].Name, Challenges[I].Version]));
  TabControl.TabIndex := 0;
  UpdateTab;

  MemoLog.Lines.Add('Compiler used: ' + SystemInfoCompiler);
  MemoLog.Lines.Add('CPU type: ' + SystemInfoCPU);
  MemoLog.Lines.Add('Windows version: ' + SystemInfoWindows);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FManager);
end;

procedure TMainForm.ListViewResultsColumnClick(Sender: TObject; Column: TListColumn);
begin
  if FListViewResultsSortColumn = Column.Index then
    FListViewResultsSortRevert := not FListViewResultsSortRevert
  else
  begin
    FListViewResultsSortColumn := Column.Index;
    FListViewResultsSortRevert := False;
  end;
  UpdateListViewResultsSortIcon;
  ListViewResults.CustomSort(nil, 0);
end;

procedure TMainForm.ListViewResultsColumnRightClick(Sender: TObject; Column: TListColumn; Point: TPoint);
var
  LRC: TListViewResultsColumn;
  ScreenPoint: TPoint;
begin
  for LRC := Low(TListViewResultsColumn) to High(TListViewResultsColumn) do
    GetPopupMenuResultColumnsItem(LRC).Checked := LRC in FListViewResultsColumns;
  ScreenPoint := ListViewResults.ClientToScreen(Point);
  PopupMenuResultColumns.Popup(ScreenPoint.X, ScreenPoint.Y);
end;

procedure TMainForm.ListViewResultsCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
var
  SI1, SI2: TStrings;
begin
  Compare := 0;
  if FListViewResultsSortColumn > 0 then
  begin
    SI1 := Item1.SubItems;
    SI2 := Item2.SubItems;
    if SI1.Count >= FListViewResultsSortColumn then
      if SI2.Count >= FListViewResultsSortColumn then
        Compare := CompareStr(SI1[FListViewResultsSortColumn - 1], SI2[FListViewResultsSortColumn - 1])
      else
        Compare := 1
    else
      if SI2.Count >= FListViewResultsSortColumn then
        Compare := -1
      else
        Compare := 0;
  end;

  if Compare = 0 then
    Compare := CompareStr(Item1.Caption, Item2.Caption);

  if FListViewResultsSortRevert then
    Compare := -Compare;
end;

procedure TMainForm.MenuItemBenchmarkClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  OldIndex := TabControl.TabIndex;
  for I := 0 to TabControl.Tabs.Count-1 do
  begin
    TabControl.TabIndex := I;
    UpdateTab;
    ButtonBenchmarkAllClick(Sender);
  end;
  TabControl.TabIndex := OldIndex;
  UpdateTab;
end;

procedure TMainForm.MenuItemExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.MenuItemReportClick(Sender: TObject);
var
  ReportWriter: TReportWriterTextPlain;
  RF: TReportForm;
begin
  RF := TReportForm.Create(nil);
  try
    ReportWriter := TReportWriterTextPlain.Create;
    try
      FManager.ReportText(TFastcodeChallenge.Challenges, ReportWriter);
      RF.Text := ReportWriter.ToString;
    finally
      ReportWriter.Free;
    end;
    RF.Show;
  except
    RF.Free;
    raise;
  end;
end;

procedure TMainForm.MenuItemReportClipboardClick(Sender: TObject);
var
  ReportWriter: TReportWriterTextPlain;
begin
  ReportWriter := TReportWriterTextPlain.Create;
  try
    FManager.ReportText(TFastcodeChallenge.Challenges, ReportWriter);
    Clipboard.SetTextBuf(PChar(ReportWriter.ToString));
  finally
    ReportWriter.Free;
  end;
end;

procedure TMainForm.MenuItemReportFileCSVClick(Sender: TObject);
begin
  ReportToFile(ListSeparator, True, 'csv');
end;

procedure TMainForm.MenuItemReportFileTabSeparatedClick(Sender: TObject);
begin
  ReportToFile(#9, False, 'txt');
end;

procedure TMainForm.MenuItemValidateClick(Sender: TObject);
var
  I, OldIndex: Integer;
begin
  OldIndex := TabControl.TabIndex;
  for I := 0 to TabControl.Tabs.Count-1 do
  begin
    TabControl.TabIndex := I;
    UpdateTab;
    ButtonValidateAllClick(Sender);
  end;
  TabControl.TabIndex := OldIndex;
end;

procedure TMainForm.PopupMenuResultColumnsItemClick(Sender: TObject);
var
  LRC: TListViewResultsColumn;
begin
  LRC := GetPopupMenuResultColumnsItemIndex(Sender as TMenuItem);
  FListViewResultsColumns := (FListViewResultsColumns + [LRC]) - (FListViewResultsColumns * [LRC]);
  UpdateListViewResultsColumns;
end;

procedure TMainForm.TabControlChange(Sender: TObject);
begin
  UpdateTab;
end;

procedure TMainForm.ButtonBenchmarkSpreadClick(Sender: TObject);
const
  REPEAT_COUNT = 10;
var
  Functions: array of PFastcodeChallengeFunction;
  FunctionCount, I, Index: Integer;
begin
  FListViewResultsColumns := [lrcName, lrcAlign, lrcBenchRes, lrcBenchSpread];
  UpdateListViewResultsColumns;

  FunctionCount := CheckListBoxFunction.Items.Count;
  SetLength(Functions, FunctionCount * REPEAT_COUNT);

  for I := Low(Functions) to High(Functions) do
  begin
    Index := I mod FunctionCount;
    if ((I div FunctionCount) and 1) <> 0 then
      Index := FunctionCount - Index - 1;

    Functions[I] := PFastcodeChallengeFunction(CheckListBoxFunction.Items.Objects[Index]);
  end;

  FBenchmarking := True;
  try
    FManager.Benchmark(GetCurrentChallenge, Functions);
  finally
    FBenchmarking := False;
  end;
  CheckListBoxFunction.ItemIndex := -1;
  UpdateListViewResults;
end;

end.
