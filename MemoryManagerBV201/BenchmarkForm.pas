unit BenchmarkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, BenchmarkClassUnit, Math, MMValidation,
  ImgList, Controls, StdCtrls, ComCtrls, Buttons,
  Menus, ToolWin, Forms;

  {$I FASTCODE_MM.INC}

const
  WM_POSTPROCESSING = WM_USER + 1;
  WMU_EXTRAVALIDATION = WM_USER + 2;

type
  {The benchmark form}
  TfBenchmark = class(TForm)
    gbBenchmarks: TGroupBox;
    bRunSelectedBenchmark: TBitBtn;
    bRunAllCheckedBenchmarks: TBitBtn;
    mBenchmarkDescription: TMemo;
    ValidateButton: TBitBtn;
    BitBtn1: TBitBtn;
    RunTimeEdit: TEdit;
    ExtraValidateButton: TBitBtn;
    bGraph: TBitBtn;
    PageControl1: TPageControl;
    TabSheetBenchmarkResults: TTabSheet;
    ListViewResults: TListView;
    TabSheetProgress: TTabSheet;
    TabSheetValidation: TTabSheet;
    MemoValidation: TMemo;
    mResults: TMemo;
    ToolBar1: TToolBar;
    ToolButtonCopyResults: TToolButton;
    TabSheetScores: TTabSheet;
    MemoScores: TMemo;
    ImageList1: TImageList;
    ToolButtonDeleteResults: TToolButton;
    btnCopySummary: TBitBtn;
    bRenameMM: TToolButton;
    ToolButton1: TToolButton;
    ListViewBenchmarks: TListView;
    TabSheetCPU: TTabSheet;
    MemoCPU: TMemo;
    PopupMenuBenchmarks: TPopupMenu;
    PopupClearAllCheckMarks: TMenuItem;
    PopupSelectAllCheckMarks: TMenuItem;
    N1: TMenuItem;
    PopupCheckAllDefaultBenchmarks: TMenuItem;
    PopupCheckAllThreadedBenchmarks: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var AAction: TCloseAction);
    procedure btnCopySummaryClick(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure bRunSelectedBenchmarkClick(Sender: TObject);
    procedure bRunAllCheckedBenchmarksClick(Sender: TObject);
    procedure bGraphClick(Sender: TObject);
    procedure ToolButtonCopyResultsClick(Sender: TObject);
    procedure ToolButtonDeleteResultsClick(Sender: TObject);
    procedure ListViewResultsCompare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure bRenameMMClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ListViewBenchmarksSelectItem(Sender: TObject;
      Item: TListItem; Selected: Boolean);
    procedure PopupClearAllCheckMarksClick(Sender: TObject);
    procedure PopupSelectAllCheckMarksClick(Sender: TObject);
    procedure PopupCheckAllDefaultBenchmarksClick(Sender: TObject);
    procedure PopupCheckAllThreadedBenchmarksClick(Sender: TObject);
  private
    FRanBenchmarkCount: Integer;
    FMMValidation: TMMValidation;
    FValidationHasBeenRun: Boolean;
    FValidationFailures: string;
    FExtraValidationHasBeenRun: Boolean;
    FExtraValidationFailures: string;
    FBenchmarkHasBeenRun: Boolean;
    FXMLResultList: TStringList;

    procedure LoadXMLResults;
    procedure SaveXMLResults;
    procedure AddValidationToLog;
    procedure UpdateValidationInLog;
    procedure AddBenchmark;
    procedure UpdateBenchmark;
    procedure SaveSummary;
    procedure ValidationProgress(const CurrentValidation, Failed: string);
    procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
    procedure WMUExtraValidation(var msg: TMessage); message WMU_EXTRAVALIDATION;

    {Runs a benchmark and returns its relative speed}
    procedure RunBenchmark(ABenchmarkClass: TFastcodeMMBenchmarkClass);

    procedure InitResultsDisplay;
    procedure AddResultsToDisplay(const BenchName, MMName, TimeRan: String;
      Ticks, Peak: Cardinal; CurrentSession: string= 'T'; InitialLoad: Boolean = False);
    procedure LoadResultsToDisplay;
    procedure SaveResults;

    procedure CalculateScores;
  public
    CSVResultsFileName: string;
  end;

var
  fBenchmark: TfBenchmark;

const
  CSV_RESULT_PREFIX = 'MMBench';
  SUMMARY_FILE_PREFIX = 'BVSummary';
  XML_RESULT_BACKUP_FILENAME = 'MMChallenge_Backup.xml';
  XML_RESULT_FILENAME = 'MMChallenge.xml';

  //Column indices for the ListView
  LVCOL_BENCH     = 0;
  LVCOL_MM        = 1;
  LVCOL_TIME      = 2;
  LVCOL_TICKS     = 3;
  LVCOL_MEM       = 4;

  //ListView Subitem Indices
  LVSI_MM        = 0;
  LVSI_TIME      = 1;
  LVSI_TICKS     = 2;
  LVSI_MEM       = 3;

  //Order of columns in the Results File
  RESULTS_BENCH   = 0;
  RESULTS_MM      = 1;
  RESULTS_TICKS   = 2;
  RESULTS_MEM     = 3;
  RESULTS_TIME    = 4;

{$IFDEF MM_FASTMM4_AVX}
  {Robert Houdart's BucketMM}
  MemoryManager_Name = 'FastMM4-AVX';
  DllExtension = 'AVX';
{$ENDIF}
{$IFDEF MM_BUCKETMM}
  {Robert Houdart's BucketMM}
  MemoryManager_Name = 'BucketMM';
  DllExtension = 'BUC';
{$ENDIF}
{$IFDEF MM_BUCKETMM_ASM}
  {Robert Houdart's BucketBasmMM}
  MemoryManager_Name = 'BucketMM_Asm';
  DllExtension = 'BCA';
{$ENDIF}
{$IFDEF MM_BUCKETMMDKC_ASM}
  {Robert Houdart's BucketBasmMM}
  MemoryManager_Name = 'BucketMMDKC_Asm';
  DllExtension = 'BCA';
{$ENDIF}
{$IFDEF MM_DKCIA32MM}
  {Dennis Kjaer Christensen Slowcode challenge entry v0.12}
  MemoryManager_Name = 'DKCIA32MM';
  DllExtension = 'DKC';
{$ENDIF}
{$IFDEF MM_EWCMM}
  {Eric Carman's EWCMM}
  MemoryManager_Name = 'EWCMM';
  DllExtension = 'EWC';
{$ENDIF}
{$IFDEF MM_FASTMM2}
  {Pierre le Riche's FastMM v2.xx}
  MemoryManager_Name = 'FastMM2';
  DllExtension = 'FA2';
{$ENDIF}
{$IFDEF MM_FASTMM3}
  {Pierre le Riche's FastMM v3.xx}
  MemoryManager_Name = 'FastMM3';
  DllExtension = 'FA3';
{$ENDIF}
{$IFDEF MM_FASTMM5}
  {Pierre le Riche's FastMM v5.xx}
  MemoryManager_Name = 'FastMM45';
  DllExtension = 'FA5';
{$ENDIF}
{$IFDEF MM_FASTMM4}
{$IFNDEF MM_FASTMM4_AVX}
  {Pierre le Riche's FastMM v4.xx}
  MemoryManager_Name = 'FastMM4';
  DllExtension = 'FA4';
{$ENDIF}
{$ENDIF}
{$IFDEF MM_FASTMM4_16}
  {Pierre le Riche's FastMM v4.xx}
  MemoryManager_Name = 'FastMM4_16';
  DllExtension = 'FA4_16';
{$ENDIF}
{$IFDEF MM_HEAPMM}
  {Vladimir Kladov's HeapMM}
  { disabled... identical to WINMEM }
  MemoryManager_Name = 'HeapMM';
  DllExtension = 'HPM';
{$ENDIF}
{$IFDEF MM_LOCALHEAP}
  {Carsten Zeumer's LocalHeapMM (Uses the windows heap)}
  { disabled... identical to WINMEM }
  MemoryManager_Name = 'LocalHeapMM';
  DllExtension = 'LHM';
{$ENDIF}
{$IFDEF MM_MULTIMM}
  {Robert Lee's HPMM}
  MemoryManager_Name = 'MultiMM';
  DllExtension = 'MMM';
{$ENDIF}
{$IFDEF MM_NEXUSMM}
  {NexusDB Memory Manager}
  MemoryManager_Name = 'NexusMM';
  DllExtension = 'NEX';
{$ENDIF}
{$IFDEF MM_PSDMM}
  {PSDMemoryManager v1.0}
  MemoryManager_Name = 'PSDMM';
  DllExtension = 'PSD';
{$ENDIF}
{$IFDEF MM_QMEMORY}
  {Andrew Driazgov's QMemory}
  MemoryManager_Name = 'QMemory';
  DllExtension = 'QMM';
{$ENDIF}
{$IFDEF MM_RECYCLERMM}
  {Eric Grange's RecyclerMM}
  MemoryManager_Name = 'RecyclerMM';
  DllExtension = 'REC';
{$ENDIF}
{$IFDEF MM_RTLMM}
  { Borland Delphi RTL Memory Manager }
  MemoryManager_Name = 'RTLMM';
  DllExtension = 'RTL';
{$ENDIF}
{$IFDEF MM_TOPMM}
  {Ivo Top's TopMM}
  MemoryManager_Name = 'TopMM';
  DllExtension = 'TOP';
{$ENDIF}
{$IFDEF MM_WINMEM}
	{Mike Lischke's WinMem (Uses the windows heap)}
  MemoryManager_Name = 'WinMem';
  DllExtension = 'WIN';
{$ENDIF}


implementation

uses
  {$IFDEF MM_FASTMM4}
  FastMM4,
  {$ENDIF}
  Clipbrd,
	FragmentationTestUnit, NexusDBBenchmarkUnit, ReallocMemBenchmark,
	DownsizeTestUnit, ReplayBenchmarkUnit, WildThreadsBenchmarkUnit,
	BlockSizeSpreadBenchmark, SmallDownsizeBenchmark,
	SmallUpsizeBenchmark, RawPerformanceSingleThread, RawPerformanceMultiThread,
	AddressSpaceCreepBenchmark, LargeBlockSpreadBenchmark,
	StringThreadTestUnit, ArrayUpsizeSingleThread, DoubleFPBenchmark1Unit,
	DoubleFPBenchmark2Unit, DoubleFPBenchmark3Unit, SingleFPBenchmark1Unit,
	SingleFPBenchmark2Unit, MoveBenchmark1Unit, MoveBenchmark2Unit,
	AddressSpaceCreepBenchmarkLarge, LinkedListBenchmark, RenameMMForm,
  BenchmarkUtilities, GeneralFunctions, SystemInfoUnit;

{$R *.dfm}

{Disables the window ghosting feature for the calling graphical user interface
 (GUI) process. Window ghosting is a Windows Manager feature that lets the user
 minimize, move, or close the main window of an application that is not
 responding. (This "feature" causes problems with form z-order and also
 modal forms not showing as modal after long periods of non-responsiveness)}
procedure DisableProcessWindowsGhosting;
type
  TDisableProcessWindowsGhostingProc = procedure;
var
  PDisableProcessWindowsGhostingProc: TDisableProcessWindowsGhostingProc;
begin
  {$IFDEF FPC}
  Pointer(PDisableProcessWindowsGhostingProc) := GetProcAddress(
  {$ELSE}
  PDisableProcessWindowsGhostingProc := GetProcAddress(
  {$ENDIF}
    GetModuleHandle('user32.dll'),
    'DisableProcessWindowsGhosting');
  if Assigned(PDisableProcessWindowsGhostingProc) then
    PDisableProcessWindowsGhostingProc;
end;

procedure TfBenchmark.FormCreate(Sender: TObject);

  {$IFDEF WIN32}
  //From FastcodeBenchmarkTool091 - Per Dennis C. Suggestion
  procedure ShowCPUInfo;
  var
   CPUID : TCPUID;
   I : Integer;
  begin
    MemoCPU.Lines.Clear;
    for I := Low(CPUID) to High(CPUID) do CPUID[I] := -1;
      if IsCPUID_Available then
        begin
          CPUID	:= GetCPUID;
          MemoCPU.Lines.Add('Processor Type:    ' + IntToStr(CPUID[1] shr 12 and 3));
          MemoCPU.Lines.Add('Family:            ' + IntToStr(CPUID[1] shr 8 and $f));
          MemoCPU.Lines.Add('Model:             ' + IntToStr(CPUID[1] shr 4 and $f));
          MemoCPU.Lines.Add('Stepping:          ' + IntToStr(CPUID[1] and $f));
          MemoCPU.Lines.Add('Name:              ' + DetectCPUType(Integer(CPUID[1] shr 8 and $f),
                                                                  Integer(CPUID[1] shr 4 and $f)));
          MemoCPU.Lines.Add('Frequency:         ' + IntToStr(GetCPUFrequencyMHz) + ' MHz');
          MemoCPU.Lines.Add('Vendor:            ' + GetCPUVendor);
        end;
  end;
  {$ENDIF}

var
  i: integer;
  Item: TListItem;
  LWeight: Double;
  CopiedExeFileName: string;
  LBenchmark: TFastcodeMMBenchmarkClass;
begin
  Caption := Format('%s %s - %s   %s', [Caption, GetFormattedVersion, GetMMName, GetCompilerName]);
  {$IFDEF WIN32}
  ShowCPUInfo;
  {$ENDIF}
  MemoCPU.Lines.Clear;
  MemoCPU.Lines.Add(SystemInfoCPU);
  MemoCPU.Lines.Add('');
  MemoCPU.Lines.Add(SystemInfoWindows);

  //fGraphs := TfGraphs.Create(Self);

  CSVResultsFileName := Format('%s%s_%s.csv',
    [ExtractFilePath(GetModuleName(HInstance)), CSV_RESULT_PREFIX, GetCompilerAbbr]);

  FValidationHasBeenRun := False;
  FValidationFailures := '';
  FExtraValidationHasBeenRun := False;
  FExtraValidationFailures := '';
  FBenchmarkHasBeenRun := False;
  FXMLResultList := TStringList.Create;
  LoadXMLResults;

  // make a copy of the application's Exe for later use
  //Skip copy if this is the MM specific exe.
  if Pos('_' + GetMMName, GetModuleName(HInstance)) = 0 then
  begin
    CopiedExeFileName := Format('%s_%s_%s.exe',
      [ChangeFileExt(Application.ExeName, ''), GetCompilerAbbr, GetMMName]);
    CopyFile(PChar(GetModuleName(HInstance)), PChar(CopiedExeFileName), False);
  end;

  {List the benchmarks}
  for i := low(Benchmarks) to high(Benchmarks) do
  begin
    LBenchmark := Benchmarks[i];
    Item := ListViewBenchmarks.Items.Add;
    Item.Data := Pointer(i);
    if Assigned(LBenchmark) then
    begin
      Item.Checked := LBenchmark.RunByDefault and not LBenchmark.Is32BitSpecial;
      Item.Caption := LBenchmark.GetBenchmarkName;
      LWeight := LBenchmark.GetSpeedWeight;
      Item.SubItems.Add(BenchmarkCategoryNames[LBenchmark.GetCategory]);
      Item.SubItems.Add(FormatFloat('0.## %', LWeight * 100));
      Item.SubItems.Add(FormatFloat('0.## %', 100 - LWeight * 100));
      Item.SubItems.Add(FormatFloat('0.## %', LBenchmark.GetBenchmarkWeight * 100));
      Item.SubItems.Add(FormatFloat('0.## %', GlobalBenchmarkWeights[i] * 100));
    end;
  end;

  if ListViewBenchmarks.Items.Count > 0 then
  begin
    //Select the first benchmark
    ListViewBenchmarks.Items[0].Selected := True;
    ListViewBenchmarks.Items[0].Focused  := True;
    //Set the benchmark description.
    ListViewBenchmarksSelectItem(nil, ListViewBenchmarks.Selected,
                                      ListViewBenchmarks.Selected <> nil);
  end;

  InitResultsDisplay;

  FMMValidation := TMMValidation.Create(Self);
  FMMValidation.OnProgress := {$IFDEF FPC}@{$ENDIF}ValidationProgress;
  MemoValidation.Lines.Clear;

  PageControl1.ActivePage := TabSheetBenchmarkResults;

  if ParamCount > 0 then
    PostMessage(Handle, WM_POSTPROCESSING, 0, 0)
end;

procedure TfBenchmark.FormClose(Sender: TObject; var AAction: TCloseAction);
begin
  if FRanBenchmarkCount > 0 then
    SaveResults;
  FreeAndNil(FXMLResultList);
end;

procedure TfBenchmark.bRunSelectedBenchmarkClick(Sender: TObject);
var
  StartTime, RunTime : TDateTime;

begin
  StartTime := Time;
  Screen.Cursor := crHourglass;
  RuntimeEdit.Text := 'Running';
  RuntimeEdit.Color := clLime;

  if ListViewBenchmarks.Selected = nil then
    Exit;

  bRunSelectedBenchmark.Caption := 'Running';
  Enabled := False;
  Application.ProcessMessages;
  Enabled := True;

  RunBenchmark(Benchmarks[NativeInt(ListViewBenchmarks.Selected.Data)]);
  if FRanBenchmarkCount > 0 then
    SaveResults;

  CalculateScores;
  SaveSummary;

  bRunSelectedBenchmark.Caption := 'Run Selected Benchmark';
  Enabled := False;
  Application.ProcessMessages;
  Enabled := True;

  Screen.Cursor := crDefault;
  RuntimeEdit.Color := clWindow;
  RunTime := Time - StartTime;
  RunTimeEdit.Text := 'Benchmark Time: ' + TimeToStr(RunTime);
end;

procedure TfBenchmark.RunBenchmark(ABenchmarkClass: TFastcodeMMBenchmarkClass);
var
  LBenchmark: TFastcodeMMBenchmark;
  LStartTicks, LUsedTicks: Int64;
  s: string;
begin
  PageControl1.ActivePage := TabSheetProgress;

  s := Trim(Trim(FormatDateTime('HH:nn:ss', time)) + ' Running Benchmark: ' + ABenchmarkClass.GetBenchmarkName + '...');
  mResults.Lines.Add(s);
  {Create the benchmark}
  LBenchmark := ABenchmarkClass.CreateBenchmark;
  try
    if LBenchmark.CanRunBenchmark then
    begin
      {Do the getmem test}
      LStartTicks := GetCPUTicks;
      LBenchmark.RunBenchmark;
      LUsedTicks := GetCPUTicks - LStartTicks;
      {Add a line}

      mResults.Lines[mResults.Lines.Count - 1] := Trim(Trim(FormatDateTime('HH:nn:ss', time)) + ' '
        + Trim(Format('%-45s  MTicks = %6d    Mem = %7d',
        [ Trim(ABenchmarkClass.GetBenchmarkName), LUsedTicks shr 20, LBenchmark.PeakAddressSpaceUsage])));
      Enabled := False;
      Application.ProcessMessages;
      Enabled := True;

      AddResultsToDisplay(ABenchmarkClass.GetBenchmarkName,
                          MemoryManager_Name,
                          Trim(FormatDateTime('YYYYMMDD HH:NN:SS.ZZZ', Now)),
                          LUsedTicks shr 20,
                          LBenchmark.PeakAddressSpaceUsage);
      if not FBenchmarkHasBeenRun then
      begin
        AddBenchmark;
        FBenchmarkHasBeenRun := True;
      end;
      UpdateBenchmark;
    end
    else
      begin
        mResults.Lines[mResults.Lines.Count - 1] := Trim(ABenchmarkClass.GetBenchmarkName) +
          ': Skipped';
        Enabled := False;
        Application.ProcessMessages;
        Enabled := True;
      end;
  finally
    {Free the benchmark}
    LBenchmark.Free;
  end;
end;

procedure TfBenchmark.bRunAllCheckedBenchmarksClick(Sender: TObject);
var
 i: integer;
 StartTime, RunTime : TDateTime;

begin
  StartTime := Time;
  Screen.Cursor := crHourglass;
  RuntimeEdit.Text := 'Running';
  RuntimeEdit.Color := clLime;
  bRunAllCheckedBenchmarks.Caption := 'Running';
  Enabled := False;
  Application.ProcessMessages;
  Enabled := True;
  mResults.Lines.Add('***Running All Checked Benchmarks***');
  for i := Low(BenchMarks) to high(BenchMarks) do
  begin
    {Must this benchmark be run?}
    if ListViewBenchmarks.Items[i].Checked then
    begin
      {Show progress in checkboxlist}
      ListViewBenchmarks.Items[i].Selected := True;
      ListViewBenchmarks.Items[i].Focused  := True;
      ListViewBenchmarks.Selected.MakeVisible(False);
      ListViewBenchmarksSelectItem(nil, ListViewBenchmarks.Selected,
                                        ListViewBenchmarks.Selected <> nil);
      Enabled := False;
      Application.ProcessMessages;
      Enabled := True;
      {Run the benchmark}
      RunBenchmark(BenchMarks[i]);

      {$IFDEF MM_FASTMM4}
      {$IFDEF DEBUG}
      Sleep(1000);
      FastMM4.ScanMemoryPoolForCorruptions;
      {$ENDIF}
      {$ENDIF}

      {Wait one second}
      Sleep(1000);
    end;
  end;
  mResults.Lines.Add('***All Checked Benchmarks Done***');
  bRunAllCheckedBenchmarks.Caption := 'Run All Checked Benchmarks';
  if FRanBenchmarkCount > 0 then
    SaveResults;
  CalculateScores;
  SaveSummary;
  Screen.Cursor := crDefault;
  RuntimeEdit.Color := clWindow;
  RunTime := Time - StartTime;
  RunTimeEdit.Text := 'Benchmark Time: ' + TimeToStr(RunTime);
end;

procedure TfBenchmark.ValidateButtonClick(Sender: TObject);
var
 StartTime, RunTime : TDateTime;
 FailedValidation, OriginalCaption: string;

begin
 StartTime := Time;
 Screen.Cursor := crHourglass;
 try
   OriginalCaption := (Sender as TBitBtn).Caption;
   TBitBtn(Sender).Caption := 'Running';
   RuntimeEdit.Text := 'Running';
   RuntimeEdit.Color := clLime;
   MemoValidation.Color := clLime;
   MemoValidation.Lines.Clear;
   PageControl1.ActivePage := TabSheetValidation;
   Enabled := False;
   Application.ProcessMessages;
   Enabled := True;
   // execute Validation
   if not (FValidationHasBeenRun or FExtraValidationHasBeenRun)then
     AddValidationToLog;
   if Sender = ExtraValidateButton then
   begin
     FailedValidation := FMMValidation.ExtraValidate;
     FExtraValidationFailures := FailedValidation;
     FExtraValidationHasBeenRun := True;
     Enabled := False;
     Application.ProcessMessages;
     Enabled := True;
     UpdateValidationInLog;
   end
   else
   begin
     FailedValidation := FMMValidation.Validate;
     FValidationFailures := FailedValidation;
     FValidationHasBeenRun := True;
     Enabled := False;
     Application.ProcessMessages;
     Enabled := True;
     UpdateValidationInLog;
   end;

   // show result
   if FailedValidation = '' then
   begin
     MemoValidation.Color := clGreen;
     MemoValidation.Lines.Add('Passed All Validations!');
     if Sender = ExtraValidateButton then
     begin
       ExtraValidateButton.Font.Color := clGreen;
       ExtraValidateButton.Caption := 'FastCode Quality Label';
     end else
     begin
       ValidateButton.Font.Color := clGreen;
       ValidateButton.Caption := 'Passed Validations';
       if ExtraValidateButton.Font.Color <> clGreen then
       begin
// Commented: it clears current results
//         PostMessage(Handle, WMU_EXTRAVALIDATION, 0, 0);
       end;
     end;
   end
   else
   begin
     ExtraValidateButton.Font.Color := clRed;
     ExtraValidateButton.Caption := 'Failed to get the FastCode Quality Label';
     ValidateButton.Font.Color := clRed;
     ValidateButton.Caption := 'Did not Pass Validations';
     MemoValidation.Color := clRed;
     MemoValidation.Lines.Add('Failed Validations: ' + FailedValidation);
   end;
   RunTime := Time - StartTime;
   RunTimeEdit.Text := 'Validation Time: ' + TimeToStr(RunTime);

   // check FastCode Quality Label
//   if Sender = ExtraValidateButton then begin
//     if FastCodeQualityLabel xor (PassValidations and (FailedValidation = '')) then
//       ShowMessage(Format('Constant FastCodeQualityLabel for "%s" should be updated in the source code !',
//         [MemoryManager_Name]));
//   end
//   else begin
//     if PassValidations xor (FailedValidation = '') then
//       ShowMessage(Format('Constant PassValidations for "%s" should be updated in the source code !',
//         [MemoryManager_Name]));
//   end;
 finally
   Screen.Cursor := crDefault;
   RuntimeEdit.Color := clWindow;
   (Sender as TBitBtn).Caption := OriginalCaption;
 end;
end;

procedure TfBenchmark.bGraphClick(Sender: TObject);
begin
  //fGraphs.LoadResultsFromFile(CSVResultsFileName);
//  fGraphs.BuildGraphs;
//  fGraphs.Show;
end;

procedure TfBenchmark.ValidationProgress(const CurrentValidation, Failed: string);
begin
 if Failed = '' then
 begin
   MemoValidation.Color := clGreen;
   RunTimeEdit.Text := Format('Running %s...', [CurrentValidation]);
   MemoValidation.Lines.Add(Format('Running %s...', [CurrentValidation]))
 end
 else
 begin
   MemoValidation.Color := clRed;
   RunTimeEdit.Text := Format('Running %s... - Failed: %s', [CurrentValidation, Failed]);
   MemoValidation.Lines.Add(Format('Running %s... - Failed: %s', [CurrentValidation, Failed]));
 end;
 Enabled := False;
 Application.ProcessMessages;
 Enabled := True;
 Sleep(250);  // slow down a bit so you can see what's happening
end;

procedure TfBenchmark.InitResultsDisplay;
begin
  ListViewResults.Items.BeginUpdate;
  try
    ListViewResults.Items.Clear;
  finally
    ListViewResults.Items.EndUpdate;
  end;

  FRanBenchmarkCount := 0;
  LoadResultsToDisplay;

  ListViewResults.Column[LVCOL_BENCH].Width := 120;
  ListViewResults.Column[LVCOL_MM].Width    := 120;
  ListViewResults.Column[LVCOL_TIME].Width  := 120;
  ListViewResults.Column[LVCOL_TICKS].Width := 120;
  ListViewResults.Column[LVCOL_MEM].Width   := 120;

  CalculateScores;
end;

procedure TfBenchmark.AddResultsToDisplay(const BenchName, MMName, TimeRan: String;
  Ticks, Peak: Cardinal; CurrentSession: string = 'T'; InitialLoad: Boolean = False);
var
  Item: TListItem;
begin
  Inc(FRanBenchmarkCount);

  Item := ListViewResults.Items.Add;
  Item.Caption := BenchName;
  Item.SubItems.Add(MMName);
  Item.SubItems.Add(TimeRan);
  Item.SubItems.Add(IntToStr(Ticks));
  Item.SubItems.Add(IntToStr(Peak));
  Item.SubItems.Add(CurrentSession);

//  if not InitialLoad then
//    ListViewResults.AlphaSort;
end;

procedure TfBenchmark.LoadResultsToDisplay;
var
  CSV, Bench: TStringList;
  l: Integer;
  BenchName, MMName, TimeRan: string;
  Ticks, Peak: Integer;
begin
  if not FileExists(CSVResultsFileName) then
    Exit;

  CSV := TStringList.Create;
  Bench := TStringList.Create;
  try
    Bench.Delimiter := ';';

    CSV.LoadFromFile(CSVResultsFileName);

    ListViewResults.Items.BeginUpdate;
    try
      for l := 0 to CSV.Count - 1 do
      begin
        Bench.DelimitedText   := CSV[l];
        if Bench.Count < 4 then
          Continue;

        BenchName := Bench[RESULTS_BENCH];
        if Trim(BenchName) = '' then
          Continue;

        MMName    := Bench[RESULTS_MM];
        if Bench.Count > RESULTS_TIME then  // Available from B&V 0.25 on
          TimeRan   := Bench[RESULTS_TIME]
        else
          TimeRan   := '';
        Ticks     := StrToIntDef(Bench[RESULTS_TICKS], MaxInt);
        Peak      := StrToIntDef(Bench[RESULTS_MEM], MaxInt);

        AddResultsToDisplay(BenchName, MMName, TimeRan, Ticks, Peak, 'F');
      end;
    finally
      ListViewResults.Items.EndUpdate;
    end;

    // ListViewResults.AlphaSort;

    if ListViewResults.Items.Count > 0 then
    begin
      ListViewResults.Items[0].Selected := True;
      ListViewResults.Items[0].Focused  := True;
    end;
  finally
    Bench.Free;
    CSV.Free;
  end;
end;

procedure TfBenchmark.SaveResults;
var
  CSV, Bench: TStringList;
  i:          Integer;
begin
  CSV := TStringList.Create;

  Bench := TStringList.Create;
  try
    Bench.Delimiter := ';';

    for i := 0 to ListViewResults.Items.Count - 1 do
      begin
        Bench.Clear;

        Bench.Add(ListViewResults.Items[i].Caption);
        Bench.Add(ListViewResults.Items[i].SubItems[LVSI_MM]);
        Bench.Add(ListViewResults.Items[i].SubItems[LVSI_TICKS]);
        Bench.Add(ListViewResults.Items[i].SubItems[LVSI_MEM]);
        Bench.Add(ListViewResults.Items[i].SubItems[LVSI_TIME]);

        CSV.Add(Bench.DelimitedText);
      end;

    CSV.SaveToFile(CSVResultsFileName);
  finally
    Bench.Free;
    CSV.Free;
  end;
end;

procedure TfBenchmark.ToolButtonCopyResultsClick(Sender: TObject);
var
  iRow: Integer;
  iCol: Integer;
  StringList: TStringList;
  s: string;
  Item: TListItem;
begin
  //The tab-delimited data dropped to the clipboard can be pasted into
  // Excel and will generally auto-separate itself into columns.
  StringList := TStringList.Create;
  try
    //Header
    s := '';
    for iCol := 0 to ListViewResults.Columns.Count - 1 do
      s := s + #9 + ListViewResults.Column[iCol].Caption;
    Delete(s, 1, 1); // delete initial #9 character
    StringList.Add(s);

    //Body
    for iRow := 0 to ListViewResults.Items.Count - 1 do begin
      Item := ListViewResults.Items[iRow];
      s := Item.Caption;
      for iCol := 0 to Item.SubItems.Count - 1 do
        s := s + #9 + Item.SubItems[iCol];
      StringList.Add(s);
    end;

		Clipbrd.Clipboard.AsText := StringList.Text;
  finally
    StringList.Free;
  end;
end;

procedure TfBenchmark.CalculateScores;
begin
  if not FileExists(CSVResultsFileName) then
    begin
      MemoScores.Lines.Clear;
      Exit;
    end;

  //fGraphs.LoadResultsFromFile(CSVResultsFileName);

  {load score in memo}
  MemoScores.Lines.BeginUpdate;
  try
    MemoScores.Lines.Clear;
    //fGraphs.ShowSummary(MemoScores.Lines);
  finally
    MemoScores.Lines.EndUpdate;
  end;
end;

procedure TfBenchmark.ToolButtonDeleteResultsClick(Sender: TObject);
begin
//  if (Application.MessageBox('Are you sure you want to delete all results?',
//    'Confirm Results Clear', MB_ICONQUESTION or MB_YesNo or MB_DefButton2) = mrYes) then
  begin
    ListViewResults.Items.BeginUpdate;
    try
      ListViewResults.Items.Clear;
    finally
      ListViewResults.Items.EndUpdate;
    end;
    DeleteFile(CSVResultsFileName);
    FRanBenchmarkCount := 0;
    CalculateScores;
  end;
end;

procedure TfBenchmark.ListViewResultsCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  //Sort list by Benchmark Name, MM Name, Time Ran
  Compare := AnsiCompareText(Item1.Caption, Item2.Caption);
  if Compare = 0 then
    Compare := AnsiCompareText(Item1.SubItems[0], Item2.SubItems[0]);
  if Compare = 0 then
    Compare := AnsiCompareText(Item1.SubItems[1], Item2.SubItems[1]);
end;

procedure TfBenchmark.btnCopySummaryClick(Sender: TObject);
var
  StringList: TStringList;
begin
  if not FileExists(CSVResultsFileName) then
    Exit;
  //fGraphs.LoadResultsFromFile(CSVResultsFileName);
  StringList := TStringList.Create;
  try
    //fGraphs.ExportTabbedSummary(StringList);
    Clipboard.AsText := StringList.Text;
  finally
    StringList.Free;
  end;
end;

procedure TfBenchmark.bRenameMMClick(Sender: TObject);
var
  LInd: integer;
  LOldName, LNewName: String;
begin
  if ListViewResults.ItemIndex >= 0 then
  begin
    Application.CreateForm(TfRenameMM, fRenameMM);
    try
      LOldName := ListViewResults.Items[ListViewResults.ItemIndex].SubItems[0];
      fRenameMM.eMMName.Text := LOldName;
      if (fRenameMM.ShowModal = mrOK) and (fRenameMM.eMMName.Text <> '') then
      begin
        LNewName := fRenameMM.eMMName.Text;
        for LInd := 0 to ListViewResults.Items.Count - 1 do
        begin
          if ListViewResults.Items[LInd].SubItems[0] = LOldName then
            ListViewResults.Items[LInd].SubItems[0] := LNewName;
        end;
        SaveResults;
        CalculateScores;
      end;
    finally
      FreeAndNil(fRenameMM);
    end;
  end;
end;

procedure TfBenchmark.ToolButton1Click(Sender: TObject);
var
  LMMName: string;
  LInd: integer;
begin
  if ListViewResults.ItemIndex < 0 then
    exit;
  LMMName := ListViewResults.Items[ListViewResults.ItemIndex].SubItems[0];
//  if (Application.MessageBox(PChar('Are you sure you want to delete results for ' + LMMName + '?'),
//    'Confirm Results Delete', MB_ICONQUESTION or MB_YesNo or MB_DefButton2) = mrYes) then
  begin
    for LInd := ListViewResults.Items.Count - 1 downto 0 do
    begin
      if ListViewResults.Items[LInd].SubItems[0] = LMMName then
      begin
        ListViewResults.Items[LInd].Delete;
        Dec(FRanBenchmarkCount);
      end;
    end;
    SaveResults;
    CalculateScores;
  end;
end;

procedure TfBenchmark.ListViewBenchmarksSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  LBenchmarkClass: TFastcodeMMBenchmarkClass;
  s: string;
begin
  //Set the benchmark description
  if (Item <> nil) and Selected then
  begin
    LBenchmarkClass := Benchmarks[NativeInt(Item.Data)];
    if Assigned(LBenchmarkClass) then
    begin
      s := LBenchmarkClass.GetBenchmarkDescription;
      if LBenchmarkClass.Is32BitSpecial then
      begin
        s := Trim(s)+' Please do not compare execution times of 32-bit and 64-bit variants of this benhmars since they use different data sets.';
      end;
      mBenchmarkDescription.Text := s;
    end;
  end;
end;

procedure TfBenchmark.PopupClearAllCheckMarksClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ListViewBenchmarks.Items.Count - 1 do
    ListViewBenchmarks.Items[i].Checked := False;
end;

procedure TfBenchmark.PopupSelectAllCheckMarksClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ListViewBenchmarks.Items.Count - 1 do
    ListViewBenchmarks.Items[i].Checked := True;
end;

procedure TfBenchmark.PopupCheckAllDefaultBenchmarksClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ListViewBenchmarks.Items.Count - 1 do
    ListViewBenchmarks.Items[i].Checked := Benchmarks[i].RunByDefault;
end;

procedure TfBenchmark.PopupCheckAllThreadedBenchmarksClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ListViewBenchmarks.Items.Count - 1 do
    ListViewBenchmarks.Items[i].Checked := Benchmarks[i].IsThreadedSpecial;
end;

// ----------------------------------------------------------------------------
procedure TfBenchmark.LoadXMLResults;
var
  InsertionPoint: Integer;
begin
  if FileExists(XML_RESULT_FILENAME) then
  begin
    FXMLResultList.LoadFromFile(XML_RESULT_FILENAME);

    InsertionPoint := FXMLResultList.IndexOf('</mmbench>');
    if InsertionPoint = -1 then
    begin
      InsertionPoint := FXMLResultList.Count - 1;
      FXMLResultList.Insert(InsertionPoint, '<mmbench>');
      FXMLResultList.Insert(InsertionPoint+1, '</mmbench>');
    end;
  end
  else
  begin
    FXMLResultList.Add('<mmchallenge>');
    FXMLResultList.Add('<mmbench>');
    FXMLResultList.Add('</mmbench>');
    FXMLResultList.Add('</mmchallenge>');
  end;
end;

// ----------------------------------------------------------------------------
procedure TfBenchmark.AddValidationToLog;
var
  InsertionPoint: Integer;
  BenchmarksIndex: Integer;
begin
  InsertionPoint := FXMLResultList.IndexOf('</validations>');
  if InsertionPoint = -1 then
  begin
    BenchmarksIndex := FXMLResultList.IndexOf('<benchmarks>');
    if BenchmarksIndex > -1 then
      InsertionPoint := BenchmarksIndex
    else
      InsertionPoint := FXMLResultList.Count - 1;
    FXMLResultList.Insert(InsertionPoint-1, '<validations>');
    FXMLResultList.Insert(InsertionPoint, '</validations>');
  end;

  FXMLResultList.Insert(InsertionPoint,
    Format('<validation version="%s" compiler="%s" MM="%s">', [GetFormattedVersion, GetCompilerAbbr, GetMMName]));
  // FXMLResultList.Insert(InsertionPoint, '<validation compiler="' + GetCompilerName + '" MM="' + GetMMName + '" >');
  
  // FXMLResultList.Insert(InsertionPoint+1, Format('<cpu>%s</cpu>', [SystemInfoCPU]));
  FXMLResultList.Insert(InsertionPoint+1, {$IFDEF WIN32__}SystemInfoCPUAsXML{$ELSE}''{$ENDIF});
  FXMLResultList.Insert(InsertionPoint+2, Format('<os>%s</os>', [SystemInfoWindows]));
  FXMLResultList.Insert(InsertionPoint+3, '<result> </result>');
  FXMLResultList.Insert(InsertionPoint+4, '<extraresult> </extraresult>');
  FXMLResultList.Insert(InsertionPoint+5, '</validation>');
end;

// ----------------------------------------------------------------------------
procedure TfBenchmark.UpdateValidationInLog;
var
  s: string;
  ResultIndex: Integer;
begin
  s := '';
  ResultIndex := FXMLResultList.IndexOf('</validations>') - 3;

  if FValidationHasBeenRun then
  begin
    if FValidationFailures = '' then
      s := 'PASS'
    else
      s := 'FAILED: ' + FValidationFailures;
    FXMLResultList[ResultIndex] := Format('<result>%s</result>', [s]);
  end;

  if FExtraValidationHasBeenRun then
  begin
    s := FExtraValidationFailures;
    if FExtraValidationFailures = '' then
      s := 'PASS'
    else
      s := 'FAILED: ' + FExtraValidationFailures;
    FXMLResultList[ResultIndex+1] := Format('<extraresult>%s</extraresult>', [s]);
  end;

  SaveXMLResults;
end;

// ----------------------------------------------------------------------------
procedure TfBenchmark.AddBenchmark;
var
  InsertionPoint: Integer;
begin
  InsertionPoint := FXMLResultList.IndexOf('</benchmarks>');
  if InsertionPoint = -1 then
  begin
    InsertionPoint := FXMLResultList.Count - 1;
    FXMLResultList.Insert(InsertionPoint-1, '<benchmarks>');
    FXMLResultList.Insert(InsertionPoint, '</benchmarks>');
  end;

  FXMLResultList.Insert(InsertionPoint,
    Format('<benchmark version="%s" compiler="%s" MM="%s">', [GetFormattedVersion, GetCompilerAbbr, GetMMName]));
  // FXMLResultList.Insert(InsertionPoint, '<benchmark compiler="' + GetCompilerName + '" MM="' + GetMMName + '" >');

  // FXMLResultList.Insert(InsertionPoint+1, Format('<cpu>%s</cpu>', [SystemInfoCPU]));
  FXMLResultList.Insert(InsertionPoint+1, {$IFDEF WIN32__}SystemInfoCPUAsXML{$ELSE}''{$ENDIF});
  FXMLResultList.Insert(InsertionPoint+2, Format('<os>%s</os>', [SystemInfoWindows]));
  FXMLResultList.Insert(InsertionPoint+3, '<result> </result>');
  FXMLResultList.Insert(InsertionPoint+4, '</benchmark>');
end;

// ----------------------------------------------------------------------------
procedure TfBenchmark.UpdateBenchmark;
var
  i: Integer;
  s: string;
  Item: TListItem;
  ResultIndex: Integer;
begin
  ResultIndex := FXMLResultList.IndexOf('</benchmarks>')-1;

  while SameText(Copy(FXMLResultList[ResultIndex-1], 1, 7), '<result') do
  begin
    FXMLResultList.Delete(ResultIndex-1);
    Dec(ResultIndex);
  end;

  for i := ListViewResults.Items.Count -1 downto 0 do
  begin
    Item := ListViewResults.Items[i];
    if SameText('T', Item.SubItems[4]) then
    begin
      s := Format('<result name="%s" time="%s" mticks="%s" mem="%s" />',
        [Item.Caption, Item.SubItems[1], Item.SubItems[2], Item.SubItems[3]]);
      FXMLResultList.Insert(ResultIndex, s);
    end;
  end;
  SaveXMLResults;
end;

// ----------------------------------------------------------------------------
procedure TfBenchmark.WMUExtraValidation(var msg: TMessage);
begin
  ExtraValidateButton.Click;
end;


procedure TfBenchmark.WMPOSTPROCESSING(var msg: TMessage);
begin
  if FindCmdLineSwitch('SmokeTest', ['-', '/'], True) then
  begin
    Application.ProcessMessages;
    Close;
    Exit;
  end;

  if FindCmdLineSwitch('C', ['-', '/'], True) then
  begin
    // clear CSV results;
    ToolButtonDeleteResults.Click;
  end;

  // All benchmarks
  if FindCmdLineSwitch('B', ['-', '/'], True) then
  begin
    // run all benchmarks
    Show;
    Enabled := False;
    Application.ProcessMessages;
    Enabled := True;
    bRunAllCheckedBenchmarks.Click;
    Halt;
  end;

  // All validations
  if FindCmdLineSwitch('V', ['-', '/'], True) then
  begin
    // perform all validations
    Show;
    Enabled := False;
    Application.ProcessMessages;
    Enabled := True;
    ValidateButton.Click;
    ExtraValidateButton.Click;
    Halt;
  end;

  // Regular validations
  if FindCmdLineSwitch('RV', ['-', '/'], True) then
  begin
    // perform all validations
    Show;
    Enabled := False;
    Application.ProcessMessages;
    Enabled := True;
    ValidateButton.Click;
    Halt;
  end;

  // Extra validations
  if FindCmdLineSwitch('EV', ['-', '/'], True) then
  begin
    // perform only extra validations
    Show;
    Enabled := False;
    Application.ProcessMessages;
    Enabled := True;
    ExtraValidateButton.Click;
    Halt;
  end;
end;

// ----------------------------------------------------------------------------
procedure TfBenchmark.SaveSummary;
var
  FileName: string;
  F: TextFile;
  i: Integer;
begin
  FileName := Format('%s%s_%s.txt',
    [ExtractFilePath(GetModuleName(HInstance)), SUMMARY_FILE_PREFIX, GetCompilerAbbr]);

  if FileExists(FileName) then
    DeleteFile(FileName);

  AssignFile(F, FileName);
  Rewrite(F);
  try
    Writeln(F, 'Summary report for Memory Manager challenge ' +
      GetFormattedVersion + FormatDateTime('  yyyy-mmm-dd hh:nn:ss', NOW));
    Writeln(F, '');
    Writeln(F, 'Compiler: ' + GetCompilerName);
    Writeln(F, SystemInfoCPU);
    Writeln(F, SystemInfoWindows);
    Writeln(F, '');
    Writeln(F, '');

    for i := 0 to MemoScores.Lines.Count - 1 do
      Writeln(F, MemoScores.Lines[i]);

    Flush(F);
  finally
    CloseFile(F);
  end;
end;

// ----------------------------------------------------------------------------
procedure TfBenchmark.SaveXMLResults;
var
  F: TextFile;
  i: Integer;
begin
  if FileExists(XML_RESULT_FILENAME) then
    DeleteFile(XML_RESULT_FILENAME);

  AssignFile(F, XML_RESULT_FILENAME);
  Rewrite(F);
  try
    for i := 0 to FXMLResultList.Count - 1 do
      Writeln(F, FXMLResultList[i]);

    Flush(F);
  finally
    CloseFile(F);
  end;

  // Sometimes forcing an out of memory error causes you to lose the previous
  // results leaving you with an empty file.  This is kind of a backup plan.
  if FileExists(XML_RESULT_BACKUP_FILENAME) then
    DeleteFile(XML_RESULT_BACKUP_FILENAME);
  CopyFile(XML_RESULT_FILENAME, XML_RESULT_BACKUP_FILENAME, False);

//  FXMLResultList.SaveToFile(XML_RESULT_FILENAME);
//  Application.ProcessMessages;
end;


initialization
  {We want the main form repainted while it's busy running}
  DisableProcessWindowsGhosting;

end.
