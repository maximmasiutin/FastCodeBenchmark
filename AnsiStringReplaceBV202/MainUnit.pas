unit MainUnit;

interface

uses
strutils,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'AnsiStringReplace';

type
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
    SpreadBench1Edit: TEdit;
    SpreadBench2Edit: TEdit;
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
    DestinationEdit: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    AlignSpreadBench1Edit: TEdit;
    AlignSpreadBench2Edit: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    ErrorTrapOnCheckBox: TCheckBox;
    Label15: TLabel;
    Label16: TLabel;
    AboutSpeedButton: TSpeedButton;
    Button1: TButton;
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
    procedure AboutSpeedButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    NoOfTicksArray : array of Int64;
    Frequency : Int64;
    procedure ClearAllEditBoxes;
    procedure CleanResultsRichEdit;
    procedure SortRichEdit;
    procedure BenchmarkTest;
    procedure AlignmentTest;
    function SubBenchmark1 : Cardinal;
    function SubBenchmark2 : Cardinal;
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
 MainForm: TMainForm;

implementation

uses
 AnsiStringReplaceRefUnit, FastcodeCPUID, SystemInfoUnit,
 StringReplaceDKCUnit,
 AnsiStringReplace_EWC,
 HVStringReplace,
 AnsiStringReplaceSHAUnit,
 StringReplaceEGPasUnit,
 AnsiStringReplace_EWC2,
 AnsiStringReplaceJOHPASUnit12,
 AnsiStringReplaceJOHIA32Unit12,
 AnsiStringReplaceJOHIA32Unit17,
 AnsiStringReplaceJOHIA32Unit18,
 AboutUnit;

{$R *.dfm}

const
 NOOFRUNS : Cardinal = 10000;
 //The two subbenchmarks should contribute evenly
 SUBBENCH1SCALE : Double = 5000;
 SUBBENCH2SCALE : Double = 750;
 NOOFRERUNS : Cardinal = 10;
 VALIDATETESTNOMAX : Cardinal = 40+1;
 BENCHMARKTESTNOMAX : Cardinal = 54;
 BENCHMARKTESTNOSPLIT : Cardinal = 27; //BENCHMARKTESTNOMAX / 2
 VALIDATE4IMIN : Cardinal = 0;
 VALIDATE4IMAX : Cardinal = 20;
 VALIDATE5IMIN : Cardinal = 250;
 VALIDATE5IMAX : Cardinal = 255;
 VALIDATE8MAX : Cardinal = 24;
 VALIDATE9MAX : Cardinal = 30;
 VALIDATE10MAX1 : Cardinal = 4;
 VALIDATE10MAX2 : Cardinal = 10;
 VALIDATE11MAX : Cardinal = 22;
 VALIDATE12MAX : Cardinal = 35;
 VALIDATE16MAX1 : Cardinal = 5;//255 max
 VALIDATE16MAX2 : Cardinal = 5;

type
 TAnsiStringReplaceFunction = function (const S, OldPattern, NewPattern: AnsiString;
                                    Flags: TReplaceFlags): AnsiString;
 TTestSet = record
  DestinationString,
  SourceString,
  SearchString,
  ReplaceString : AnsiString;
  ReplaceFlags : TReplaceFlags;
 end;

var
 AnsiStringReplaceFunction : TAnsiStringReplaceFunction;
 ValidateTestSetArray : array of TTestSet;
 BenchmarkTestSetArray : array of TTestSet;

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

procedure FillValidateTestSetArray;
var
 T : Integer;
 
begin
 SetLength(ValidateTestSetArray, VALIDATETESTNOMAX);
 ValidateTestSetArray[0].SourceString := 'A';
 ValidateTestSetArray[0].SearchString := 'A';
 ValidateTestSetArray[0].ReplaceString := 'a';
 ValidateTestSetArray[0].DestinationString := 'a';
 ValidateTestSetArray[0].ReplaceFlags := [rfReplaceAll];
 ValidateTestSetArray[1].SourceString := 'ABCDEF';
 ValidateTestSetArray[1].SearchString := 'ab';
 ValidateTestSetArray[1].ReplaceString := 'ab';
 ValidateTestSetArray[1].DestinationString := 'abCDEF';
 ValidateTestSetArray[1].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[2].SourceString := 'ABCDEFABCDEF';
 ValidateTestSetArray[2].SearchString := 'ABC';
 ValidateTestSetArray[2].ReplaceString := 'XX';
 ValidateTestSetArray[2].DestinationString := 'XXDEFABCDEF';
 ValidateTestSetArray[2].ReplaceFlags := [];
 ValidateTestSetArray[3].SourceString := #0 + 'a';
 ValidateTestSetArray[3].SearchString := 'A';
 ValidateTestSetArray[3].ReplaceString := 'X';
 ValidateTestSetArray[3].DestinationString := #0 + 'X';
 ValidateTestSetArray[3].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[4].SourceString := ' a b c ';
 ValidateTestSetArray[4].SearchString := 'B ';
 ValidateTestSetArray[4].ReplaceString := 'X';
 ValidateTestSetArray[4].DestinationString := ' a Xc ';
 ValidateTestSetArray[4].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[5].SourceString := ' a b c ';
 ValidateTestSetArray[5].SearchString := 'B';
 ValidateTestSetArray[5].ReplaceString := ' X ';
 ValidateTestSetArray[5].DestinationString := ' a  X  c ';
 ValidateTestSetArray[5].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[6].SourceString := 'abc';
 ValidateTestSetArray[6].SearchString := 'B';
 ValidateTestSetArray[6].ReplaceString := '';
 ValidateTestSetArray[6].DestinationString := 'ac';
 ValidateTestSetArray[6].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[7].SourceString := ' a b c ';
 ValidateTestSetArray[7].SearchString := '';
 ValidateTestSetArray[7].ReplaceString := 'X';
 ValidateTestSetArray[7].DestinationString := ' a b c ';
 ValidateTestSetArray[7].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[8].SourceString := ' a b c ';
 ValidateTestSetArray[8].SearchString := 'b c';
 ValidateTestSetArray[8].ReplaceString := 'X y Z';
 ValidateTestSetArray[8].DestinationString := ' a X y Z ';
 ValidateTestSetArray[8].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[9].SourceString := '';
 ValidateTestSetArray[9].SearchString := 'a';
 ValidateTestSetArray[9].ReplaceString := 'b';
 ValidateTestSetArray[9].DestinationString := '';
 ValidateTestSetArray[9].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[10].SourceString := 'axayazafakamal';
 ValidateTestSetArray[10].SearchString := 'a';
 ValidateTestSetArray[10].ReplaceString := 'b';
 ValidateTestSetArray[10].DestinationString := 'bxbybzbfbkbmbl';
 ValidateTestSetArray[10].ReplaceFlags := [rfReplaceAll];
 ValidateTestSetArray[11].SourceString := #0 + #1;
 ValidateTestSetArray[11].SearchString := #0 + #1;
 ValidateTestSetArray[11].ReplaceString := #0;
 ValidateTestSetArray[11].DestinationString := #0;
 ValidateTestSetArray[11].ReplaceFlags := [rfReplaceAll];
 ValidateTestSetArray[12].SourceString := #0;
 ValidateTestSetArray[12].SearchString := #0 + #1;
 ValidateTestSetArray[12].ReplaceString := #0;
 ValidateTestSetArray[12].DestinationString := #0;
 ValidateTestSetArray[12].ReplaceFlags := [rfReplaceAll];
 ValidateTestSetArray[13].SourceString := #0 + #1 + #2;
 ValidateTestSetArray[13].SearchString := #0 + #1;
 ValidateTestSetArray[13].ReplaceString := #0;
 ValidateTestSetArray[13].DestinationString := #0 + #2;
 ValidateTestSetArray[13].ReplaceFlags := [rfReplaceAll];
 ValidateTestSetArray[14].SourceString := 'a';
 ValidateTestSetArray[14].SearchString := 'a';
 ValidateTestSetArray[14].ReplaceString := '';
 ValidateTestSetArray[14].DestinationString := '';
 ValidateTestSetArray[14].ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
 ValidateTestSetArray[15].SourceString := 'aaaaabbbbbaaaaabbbbbaaaaabbbbb';
 ValidateTestSetArray[15].SearchString := 'aa';
 ValidateTestSetArray[15].ReplaceString := 'x';
 ValidateTestSetArray[15].DestinationString := 'xxabbbbbxxabbbbbxxabbbbb';
 ValidateTestSetArray[15].ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
 ValidateTestSetArray[16].SourceString := 'SSSSSSSSSSSSSSSSSSSSSSSSSSSTTTTTTTTTTTTTTTTTTTTTT';
 ValidateTestSetArray[16].SearchString := 'SSSSSSSSSSSSSSSSSSSSSSSSSSS';
 ValidateTestSetArray[16].ReplaceString := 'QQQ';
 ValidateTestSetArray[16].DestinationString := 'QQQTTTTTTTTTTTTTTTTTTTTTT';
 ValidateTestSetArray[16].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[17].SourceString := 'SSSSSSSSSSSSSSSSSSSSSSSSSSSTTTTTTTTTTTTTTTTTTTTTT';
 ValidateTestSetArray[17].SearchString := 'SSSSSSSSSSSSSSSSSSSSSSSSSSS';
 ValidateTestSetArray[17].ReplaceString := 'QQQ';
 ValidateTestSetArray[17].DestinationString := 'QQQTTTTTTTTTTTTTTTTTTTTTT';
 ValidateTestSetArray[17].ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
 ValidateTestSetArray[18].SourceString := 'aaaaaBBccVVDDvv';
 ValidateTestSetArray[18].SearchString := 'vv';
 ValidateTestSetArray[18].ReplaceString := '';
 ValidateTestSetArray[18].DestinationString := 'aaaaaBBccDD';
 ValidateTestSetArray[18].ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
 ValidateTestSetArray[19].SourceString := #158;
 ValidateTestSetArray[19].SearchString := #158;
 ValidateTestSetArray[19].ReplaceString := #1;
 ValidateTestSetArray[19].DestinationString := #1;
 ValidateTestSetArray[19].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[20].SourceString := #138;
 ValidateTestSetArray[20].SearchString := #154;
 ValidateTestSetArray[20].ReplaceString := #1;
 ValidateTestSetArray[20].DestinationString := #1;
 ValidateTestSetArray[20].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[21].SourceString := #0 + #1;
 ValidateTestSetArray[21].SearchString := #0 + #1;
 ValidateTestSetArray[21].ReplaceString := 'ss';
 ValidateTestSetArray[21].DestinationString := 'ss';
 ValidateTestSetArray[21].ReplaceFlags := [rfReplaceAll];
 ValidateTestSetArray[22].SourceString := 'aahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhaa';
 ValidateTestSetArray[22].SearchString := 'aa';
 ValidateTestSetArray[22].ReplaceString := '';
 ValidateTestSetArray[22].DestinationString := 'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh';
 ValidateTestSetArray[22].ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
 ValidateTestSetArray[23].SourceString := 'ssssssssssssssssssssssssssss';
 ValidateTestSetArray[23].SearchString := 'a';
 ValidateTestSetArray[23].ReplaceString := 'a';
 ValidateTestSetArray[23].DestinationString := 'ssssssssssssssssssssssssssss';
 ValidateTestSetArray[23].ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
 ValidateTestSetArray[24].SourceString := 'xX';
 for T := 1 to 10000 do
  ValidateTestSetArray[24].SourceString := ValidateTestSetArray[24].SourceString + 'rr';
 ValidateTestSetArray[24].SourceString := ValidateTestSetArray[24].SourceString + 'xX';
 ValidateTestSetArray[24].SearchString := 'xX';
 ValidateTestSetArray[24].ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
 ValidateTestSetArray[24].DestinationString := StringReplaceRef(ValidateTestSetArray[24].SourceString,
                                                                ValidateTestSetArray[24].SearchString,
                                                                ValidateTestSetArray[24].ReplaceString,
                                                                ValidateTestSetArray[23].ReplaceFlags);
 //StringReplace('  ',' ',[rfReplaceAll]) ;
 ValidateTestSetArray[25].SourceString := '  ';
 ValidateTestSetArray[25].SearchString := ' ';
 ValidateTestSetArray[25].ReplaceString := '';
 ValidateTestSetArray[25].DestinationString := '';
 ValidateTestSetArray[25].ReplaceFlags := [rfReplaceAll];
 ValidateTestSetArray[26].SourceString := '  ';
 ValidateTestSetArray[26].SearchString := ' ';
 ValidateTestSetArray[26].ReplaceString := '';
 ValidateTestSetArray[26].DestinationString := '';
 ValidateTestSetArray[26].ReplaceFlags := [rfReplaceAll];
 ValidateTestSetArray[27].SourceString := '    ';
 ValidateTestSetArray[27].SearchString := '  ';
 ValidateTestSetArray[27].ReplaceString := ' ';
 ValidateTestSetArray[27].DestinationString := '  ';
 ValidateTestSetArray[27].ReplaceFlags := [rfReplaceAll];
 ValidateTestSetArray[28].SourceString := #8'a'#8'b'#8'c';
 ValidateTestSetArray[28].SearchString := #8;
 ValidateTestSetArray[28].ReplaceString := '        ';
 ValidateTestSetArray[28].DestinationString := '        a        b        c';
 ValidateTestSetArray[28].ReplaceFlags := [rfReplaceAll];
 ValidateTestSetArray[29].SourceString := '        a        b        c';
 ValidateTestSetArray[29].SearchString := '        ';
 ValidateTestSetArray[29].ReplaceString := #8;
 ValidateTestSetArray[29].DestinationString := #8'a'#8'b'#8'c';
 ValidateTestSetArray[29].ReplaceFlags := [rfReplaceAll];
 ValidateTestSetArray[30].SourceString := #0#1#0#1;
 ValidateTestSetArray[30].SearchString := #0#1;
 ValidateTestSetArray[30].ReplaceString := #0;
 ValidateTestSetArray[30].DestinationString := #0#0;
 ValidateTestSetArray[30].ReplaceFlags := [rfReplaceAll];
 ValidateTestSetArray[31].SourceString := 'lallallallallallal';
 ValidateTestSetArray[31].SearchString := 'lallallal';
 ValidateTestSetArray[31].ReplaceString := 'lallal';
 ValidateTestSetArray[31].DestinationString := 'lallallallal';
 ValidateTestSetArray[31].ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
 ValidateTestSetArray[32].SourceString := 'AAAAAAAAAAAAA';
 ValidateTestSetArray[32].SearchString := '';
 ValidateTestSetArray[32].ReplaceString := 'a';
 ValidateTestSetArray[32].DestinationString := 'AAAAAAAAAAAAA';
 ValidateTestSetArray[32].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[33].SourceString := '';
 ValidateTestSetArray[33].SearchString := 'AAAAAAAAAAAAA';
 ValidateTestSetArray[33].ReplaceString := 'a';
 ValidateTestSetArray[33].DestinationString := '';
 ValidateTestSetArray[33].ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
 ValidateTestSetArray[34].SourceString := 'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSwwwwwwSSSSSSSSSSSSSSSSSSSSSSSSSSSSS';
 ValidateTestSetArray[34].SearchString := 'wwwwww';
 ValidateTestSetArray[34].ReplaceString := 'kk';
 ValidateTestSetArray[34].DestinationString := 'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSkkSSSSSSSSSSSSSSSSSSSSSSSSSSSSS';
 ValidateTestSetArray[34].ReplaceFlags := [rfReplaceAll];
 ValidateTestSetArray[35].SourceString := 'a';
 ValidateTestSetArray[35].SearchString := 'a';
 ValidateTestSetArray[35].ReplaceString := '';
 ValidateTestSetArray[35].DestinationString := '';
 ValidateTestSetArray[35].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[36].SourceString := 'a';
 ValidateTestSetArray[36].SearchString := 'a';
 ValidateTestSetArray[36].ReplaceString := '';
 ValidateTestSetArray[36].DestinationString := '';
 ValidateTestSetArray[36].ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
 ValidateTestSetArray[37].SourceString := 'a';
 ValidateTestSetArray[37].SearchString := 'a';
 ValidateTestSetArray[37].ReplaceString := '';
 ValidateTestSetArray[37].DestinationString := '';
 ValidateTestSetArray[37].ReplaceFlags := [];
 ValidateTestSetArray[38].SourceString := 'A';
 ValidateTestSetArray[38].SearchString := 'a';
 ValidateTestSetArray[38].ReplaceString := '';
 ValidateTestSetArray[38].DestinationString := '';
 ValidateTestSetArray[38].ReplaceFlags := [rfIgnoreCase];
 ValidateTestSetArray[39].SourceString := 'a';
 ValidateTestSetArray[39].SearchString := 'A';
 ValidateTestSetArray[39].ReplaceString := 'b';
 ValidateTestSetArray[39].DestinationString := 'b';
 ValidateTestSetArray[39].ReplaceFlags := [rfIgnoreCase, rfReplaceAll];

 ValidateTestSetArray[40].SourceString := #0#0#0#1;
 ValidateTestSetArray[40].SearchString := #0#1;
 ValidateTestSetArray[40].ReplaceString := #1#0;
 ValidateTestSetArray[40].DestinationString := #0#0#1#0;
 ValidateTestSetArray[40].ReplaceFlags := [rfIgnoreCase, rfReplaceAll];

end;

procedure FillBenchmarkTestSetArray;
var
 I, J, K, T : Integer;
 C : Char;

begin
 SetLength(BenchmarkTestSetArray, BENCHMARKTESTNOMAX);
 I := 0;
 BenchmarkTestSetArray[I].SourceString := '';
 BenchmarkTestSetArray[I].SearchString := '';
 BenchmarkTestSetArray[I].ReplaceString := '';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'a';
 BenchmarkTestSetArray[I].SearchString := 'a';
 BenchmarkTestSetArray[I].ReplaceString := '';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'A';
 BenchmarkTestSetArray[I].SearchString := 'a';
 BenchmarkTestSetArray[I].ReplaceString := '';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'a';
 BenchmarkTestSetArray[I].SearchString := 'a';
 BenchmarkTestSetArray[I].ReplaceString := 'b';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'A';
 BenchmarkTestSetArray[I].SearchString := 'A';
 BenchmarkTestSetArray[I].ReplaceString := 'B';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'a';
 BenchmarkTestSetArray[I].SearchString := 'a';
 BenchmarkTestSetArray[I].ReplaceString := 'bc';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'A';
 BenchmarkTestSetArray[I].SearchString := 'A';
 BenchmarkTestSetArray[I].ReplaceString := 'BC';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aa';
 BenchmarkTestSetArray[I].SearchString := 'a';
 BenchmarkTestSetArray[I].ReplaceString := 'b';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aa';
 BenchmarkTestSetArray[I].SearchString := 'aa';
 BenchmarkTestSetArray[I].ReplaceString := 'bc';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'AA';
 BenchmarkTestSetArray[I].SearchString := 'AA';
 BenchmarkTestSetArray[I].ReplaceString := 'BC';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aA';
 BenchmarkTestSetArray[I].SearchString := 'Aa';
 BenchmarkTestSetArray[I].ReplaceString := 'bc';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aaaaa';
 BenchmarkTestSetArray[I].SearchString := 'a';
 BenchmarkTestSetArray[I].ReplaceString := 'x';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'AAAAA';
 BenchmarkTestSetArray[I].SearchString := 'A';
 BenchmarkTestSetArray[I].ReplaceString := 'X';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := '3.14159264';
 BenchmarkTestSetArray[I].SearchString := '.';
 BenchmarkTestSetArray[I].ReplaceString := ',';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aaaaaaa';
 BenchmarkTestSetArray[I].SearchString := 'a';
 BenchmarkTestSetArray[I].ReplaceString := 'x';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aaaaaaa';
 BenchmarkTestSetArray[I].SearchString := 'aa';
 BenchmarkTestSetArray[I].ReplaceString := 'xx';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'AAAAAAAA';
 BenchmarkTestSetArray[I].SearchString := 'AA';
 BenchmarkTestSetArray[I].ReplaceString := 'xx';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aaaaaaaa';
 BenchmarkTestSetArray[I].SearchString := 'aaaaaaaa';
 BenchmarkTestSetArray[I].ReplaceString := '';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aaaaaaaa';
 BenchmarkTestSetArray[I].SearchString := 'aaaaaaaa';
 BenchmarkTestSetArray[I].ReplaceString := 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'FFFFFFFFFF';
 BenchmarkTestSetArray[I].SearchString := 'FFFFFFFFFF';
 BenchmarkTestSetArray[I].ReplaceString := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aaaaaBBccVVDDvv';
 BenchmarkTestSetArray[I].SearchString := 'vv';
 BenchmarkTestSetArray[I].ReplaceString := '';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aaaaaBBccVVDDvvaaaaaBBccVVDDvv';
 BenchmarkTestSetArray[I].SearchString := 'cc';
 BenchmarkTestSetArray[I].ReplaceString := 'sssssss';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'wwWWwwRRrrttTTXXuuQQssLKIUYTRwwWW';
 BenchmarkTestSetArray[I].SearchString := 'ww';
 BenchmarkTestSetArray[I].ReplaceString := 'jgtrewwqacbbjhjkjklknm,jhghh';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'sssssssssssssssssssssssssssssssssKKKKKKK';
 BenchmarkTestSetArray[I].SearchString := 'KKKKKKK';
 BenchmarkTestSetArray[I].ReplaceString := 'lllllllllllllll';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aaaaabbbbbaaaaabbbbbaaaaabbbbb';
 BenchmarkTestSetArray[I].SearchString := 'aa';
 BenchmarkTestSetArray[I].ReplaceString := 'x';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'uuuuugggggguuuuugggggguuuuugggggguuuuugggggg';
 BenchmarkTestSetArray[I].SearchString := 'uuuuu';
 BenchmarkTestSetArray[I].ReplaceString := 'xxxxxxxx';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aaaaabbbbbaaaaabbbbbaaaaabbbbb';
 BenchmarkTestSetArray[I].SearchString := 'aa';
 BenchmarkTestSetArray[I].ReplaceString := 'xxx';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'AaAAaAaAaAaAaAaaAaaaAAAaaaAAAAAaaaaaAAAAAaaaaaAAA';
 BenchmarkTestSetArray[I].SearchString := 'aAAaaAAaAaaAaaAaaAaaaAAaaAaaaaAAaaAAaaaaAaaaAaaaa';
 BenchmarkTestSetArray[I].ReplaceString := 'jfggryetruwhwjfhsjkf';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aaaaabbbbbaaaaabbbbbaaaaabbbbb';
 BenchmarkTestSetArray[I].SearchString := 'aaaaa';
 BenchmarkTestSetArray[I].ReplaceString := 'xxxxx';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZDENNIS';
 BenchmarkTestSetArray[I].SearchString := 'DEF';
 BenchmarkTestSetArray[I].ReplaceString := 'QQQQ';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'DennisDennisDennisDennisDennisDennisMicro';
 BenchmarkTestSetArray[I].SearchString := 'Dennis';
 BenchmarkTestSetArray[I].ReplaceString := 'Dummy';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
 BenchmarkTestSetArray[I].SearchString := 'aaaaaaaaa';
 BenchmarkTestSetArray[I].ReplaceString := 'xxx';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'sataSATAsataSataSATAsaTAsATasataSATAsataSataSATAsaTAsATasataSATAsataSataSATAsaTAsATa';
 BenchmarkTestSetArray[I].SearchString := 'SATA';
 BenchmarkTestSetArray[I].ReplaceString := 'xxxxxxxxxxxxxxxxxx';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
 BenchmarkTestSetArray[I].SearchString := 'aaaaaaaaaaaaaaaa';
 BenchmarkTestSetArray[I].ReplaceString := 'xxxxxxxxxxxxxxxxxxxxx';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'beginendcasewhilefordorepeatuntilwithintegerdouble';
 BenchmarkTestSetArray[I].SearchString := 'until';
 BenchmarkTestSetArray[I].ReplaceString := 'khgtrdfghjjk';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
 BenchmarkTestSetArray[I].SearchString := 'aaaaaaaaaaaaaaaaaaaaaaaaaaa';
 BenchmarkTestSetArray[I].ReplaceString := 'xxxxxxxxxxxxxxxxxxxxx';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'DennisBorlandMicrosoftIntelAMDFastcodeDEFDiamondback';
 BenchmarkTestSetArray[I].SearchString := 'Microsoft';
 BenchmarkTestSetArray[I].ReplaceString := 'Dollars';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'DennisMicroBorlandMicrosoftIntelMicroAMDMicroFastcodeDEFMicroDiamondback';
 BenchmarkTestSetArray[I].SearchString := 'Diamond';
 BenchmarkTestSetArray[I].ReplaceString := 'Macro';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'DennisMicroBorlandMicrosoftIntelMicroAMDMicroFastcodeDEFMicroDiamondback';
 BenchmarkTestSetArray[I].SearchString := 'DEF';
 BenchmarkTestSetArray[I].ReplaceString := 'Macro';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXDennis';
 BenchmarkTestSetArray[I].SearchString := 'Dennis';
 BenchmarkTestSetArray[I].ReplaceString := 'YY';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'XXXXXxXXXXXXxXXXXXxXXXXXXxXXXXXxXXXXXDennis';
 BenchmarkTestSetArray[I].SearchString := 'X';
 BenchmarkTestSetArray[I].ReplaceString := 'Y';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'XXXXXxXXXXxXXXXXxXXXXxXXXXxXXXXxXXXXXDennis';
 BenchmarkTestSetArray[I].SearchString := 'X';
 BenchmarkTestSetArray[I].ReplaceString := 'YY';
 Inc(I);
 for K := 1 to 1000 do
  begin
   C := Char(Random(255));
   BenchmarkTestSetArray[I].SourceString := BenchmarkTestSetArray[I].SourceString + C;
   if ((200 < K) and (K < 210)) then
    BenchmarkTestSetArray[I].SearchString := BenchmarkTestSetArray[I].SearchString + C;
  end;
 BenchmarkTestSetArray[I].ReplaceString := 'YY';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := '';
 for J :=0 to Random(5)+1 do
  if (J and 1)=0 then
  	BenchmarkTestSetArray[I].SourceString
    := BenchmarkTestSetArray[I].SourceString + StringOfChar('b', 1000+Random(2000))
  else
   BenchmarkTestSetArray[I].SourceString
    := BenchmarkTestSetArray[I].SourceString + 'BornToBeReplaced';
 BenchmarkTestSetArray[I].SearchString := 'BornToBeReplaced';
 BenchmarkTestSetArray[I].ReplaceString := StringOfChar('!', Random(40));
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZDENNISDennisabcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZ';
 BenchmarkTestSetArray[I].SearchString := 'Dennis';
 BenchmarkTestSetArray[I].ReplaceString := '';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'FgHtReSabcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZDENNISDennisabcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZDennisdennis';
 BenchmarkTestSetArray[I].SearchString := 'Dennis';
 BenchmarkTestSetArray[I].ReplaceString := '';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZDENNISDennisabcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZ';
 BenchmarkTestSetArray[I].SearchString := 'abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZDENNISDennisabcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZ';
 BenchmarkTestSetArray[I].ReplaceString := 'X';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := '3,141592;2,54656;123235,86;455,232;1313,464646464;5656,';
 BenchmarkTestSetArray[I].SearchString := ',';
 BenchmarkTestSetArray[I].ReplaceString := '.';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC';
 BenchmarkTestSetArray[I].SearchString := 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCcccccccccccccccccccccc';
 BenchmarkTestSetArray[I].ReplaceString := 'x';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCcccccccccccccccccccccccc';
 BenchmarkTestSetArray[I].SearchString := 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc';
 BenchmarkTestSetArray[I].ReplaceString := 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'ABCDEFGabcdefgABCDEFGabcdefgABCDEFghylhdfetgdsjkfkiuwfgfchFSAERYIUKJJHGFRRGhdjjhgkjkrouttghdjjghjgfsaqQQWEWRKÅÆÆLKJNBNØNBCXZ>ASWErhfherjkie651489659069832654!!"#¤%&';
 BenchmarkTestSetArray[I].SearchString := '59069832654';
 BenchmarkTestSetArray[I].ReplaceString := 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'xX';
 for T := 1 to 100 do
  BenchmarkTestSetArray[I].SourceString := BenchmarkTestSetArray[I].SourceString + 'rr';
 BenchmarkTestSetArray[I].SourceString := BenchmarkTestSetArray[I].SourceString + 'xX';
 BenchmarkTestSetArray[I].SearchString := 'xX';
 BenchmarkTestSetArray[I].ReplaceString := 'ttttttttttttttttttttttttttttttttttttttttt';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'AaDDsSeRTtyUYui)(76¤¤#21§fgHJKæ;nbVCxAaDDsSeRTtyUYui)(76¤¤#21§fgHJKæ;nbVCxAaDDsSeRTtyUYui)(76¤¤#21§fgHJKæ;nbVCxAaDDsSeRTtyUYui)(76¤¤#21§fgHJKæ;nbVCxAaDDsSeRTtyUYui)(76¤¤#21§fgHJKæ;nbVCxAaDDsSeRTtyUYui)(76¤¤#21§fgHJKæ;nbVCxAaDDsSeRTtyUYui)(76¤¤#21';
 BenchmarkTestSetArray[I].SearchString := 'AaDDsSeRTtyUYui)(76¤¤#21§fgHJKæ;nbVCx';
 BenchmarkTestSetArray[I].ReplaceString := 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
 Inc(I);
 BenchmarkTestSetArray[I].SourceString := 'AaDDsSeRTtyUYui)(76¤¤#21§fgHJKæ;nbVCxAaDDsSeRTtyUYui)(76¤¤#21§fgHJKæ;nbVCxAaDDsSeRTtyUYui)(76¤¤#21§fgHJKæ;nbVCxAaDDsSeRTtyUYui)(76¤¤#21§fgHJKæ;nbVCxAaDDsSeRTtyUYui)(76¤¤#21§fgHJKæ;nbVCxAaDDsSeRTtyUYui)(76¤¤#21§fgHJKæ;nbVCxAaDDsSeRTtyUYui)(76¤¤#21';
 BenchmarkTestSetArray[I].SearchString := ')(76¤¤#21§fgHJKæ;nbVCx';
 BenchmarkTestSetArray[I].ReplaceString := 'dfgh';
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

procedure TMainForm.AboutSpeedButtonClick(Sender: TObject);
begin
 AboutForm.ShowModal;
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
 AlignSpreadBench1Edit.Text := '';
 AlignSpreadBench2Edit.Text := '';
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
             AlignSpreadBench1Edit.Text := BenchString1;
             AlignSpreadBench2Edit.Text := BenchString2;
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
 SpreadBench1Edit.Text := '';
 SpreadBench2Edit.Text := '';
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
         SpreadBench1Edit.Text := BenchString1;
         SpreadBench2Edit.Text := BenchString2;
         MaxSpread := Spread;
         MaxSpreadBenchPercentageEdit.Text := FloatToStrF(MaxSpread, ffFixed, 9, 1);
         FunctionNameEdit.Text := FunctionName1;
         MaxSpreadBenchPercentageEdit.Color := clGreen;
         if MaxSpread > 1 then
          MaxSpreadBenchPercentageEdit.Color := clYellow;
         if MaxSpread > 3 then
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

procedure ShowMessageBox(Heading, Text : AnsiString);
begin
 Application.MessageBox(PChar(Text), PChar(Heading));
end;


procedure ErrorTrap(ValidateFunction : Cardinal;
                    SourceString, SearchString, ReplaceString : AnsiString;
                    ReplaceFlags : TReplaceFlags);
var
 DestinationString : AnsiString;

  procedure EMMS;
  asm
   emms
  end;
begin
 EMMS;
 //Enable for debugging
 DestinationString := AnsiStringReplaceFunction(SourceString, SearchString, ReplaceString, ReplaceFlags);
 if MainForm.ErrorTrapOnCheckBox.Checked then
  begin
   ShowMessageBox('Validation Failure', 'ValidateFunction: ' + IntToStr(ValidateFunction)
                + ' SourceString: ' + SourceString
                + ' SearchString: ' + SearchString
                + ' ReplaceString: ' + ReplaceString);
  end;
end;

function Validate1 : Boolean;
var
 DestinationString, SourceString, SearchString, ReplaceString : AnsiString;
 ReplaceFlags : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
const
 VALIDATENO : Cardinal = 1;

begin
 SourceString := 'hhabhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh';
 SearchString := 'ab';
 ReplaceString := SearchString;
 ReplaceFlags := [rfReplaceAll];
 DestinationString := AnsiStringReplaceFunction(SourceString, SearchString, ReplaceString, ReplaceFlags);
 if DestinationString <> SourceString then
  begin
   ErrorTrap(VALIDATENO, SourceString, SearchString, ReplaceString, ReplaceFlags);
   Result := False;
  end
 else
  Result := True;
end;

function Validate2 : Boolean;
var
 DestinationString, SourceString, SearchString, ReplaceString, DestStringRef, S : AnsiString;
 ReplaceFlags : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
 I1: Integer;
const
 VALIDATENO : Cardinal = 2;

begin
 S := '';
 for I1 := 1 to 2523 do
  S := S + 'A';
 SourceString := S + 'FF' + S + 'FF';
 DestStringRef := S + 'XX' + S + 'XX';
 SearchString := 'FF';
 ReplaceString := 'XX';
 ReplaceFlags := [rfReplaceAll];
 DestinationString := AnsiStringReplaceFunction(SourceString, SearchString, ReplaceString, ReplaceFlags);
 if DestinationString <> DestStringRef then
  begin
   ErrorTrap(VALIDATENO, SourceString, SearchString, ReplaceString, ReplaceFlags);
   Result := False;
  end
 else
  Result := True;
end;

function Validate3 : Boolean;
var
 DestString : AnsiString;
 TestNo : Cardinal;
const
 VALIDATENO : Cardinal = 3;

begin
 Result := True;
 TestNo := 0;
 try
  for TestNo := 0 to VALIDATETESTNOMAX-1 do
   begin
    DestString := AnsiStringReplaceFunction(ValidateTestSetArray[TestNo].SourceString,
                                            ValidateTestSetArray[TestNo].SearchString,
                                            ValidateTestSetArray[TestNo].ReplaceString,
                                            ValidateTestSetArray[TestNo].ReplaceFlags);
    if DestString <> ValidateTestSetArray[TestNo].DestinationString then
     begin
      ErrorTrap(VALIDATENO,
                ValidateTestSetArray[TestNo].SourceString,
                ValidateTestSetArray[TestNo].SearchString,
                ValidateTestSetArray[TestNo].ReplaceString,
                ValidateTestSetArray[TestNo].ReplaceFlags);
      Result := False;
      Break;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, ValidateTestSetArray[TestNo].SourceString,
                        ValidateTestSetArray[TestNo].SearchString,
                        ValidateTestSetArray[TestNo].ReplaceString,
                        ValidateTestSetArray[TestNo].ReplaceFlags);
  Result := False;
 end;
end;

function Validate4 : Boolean;
var
 SourceString, SearchString, ReplaceString : AnsiString;
 ReplaceFlags : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
 DestString, DestStringRef : AnsiString;
 I1, I2, I3, I4 : Cardinal;
const
 VALIDATENO : Cardinal = 4;

begin
 Result := True;
 for I4 := 1 to 4 do
  begin
   case I4 of
    1 : ReplaceFlags := [];
    2 : ReplaceFlags := [rfReplaceAll];
    3 : ReplaceFlags := [rfIgnoreCase];
    4 : ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
   end;
   ReplaceString := '';
   for I1 := VALIDATE4IMIN to VALIDATE4IMAX do
    begin
     ReplaceString := ReplaceString + Char(I1);
     SearchString := '';
     for I2 := VALIDATE4IMIN to VALIDATE4IMAX do
      begin
       SearchString := SearchString + Char(I2);
       SourceString := '';
       for I3 := VALIDATE4IMIN to VALIDATE4IMAX do
        begin
         SourceString := SourceString + Char(I3);
         DestStringRef := StringReplaceRef(SourceString, SearchString, ReplaceString, ReplaceFlags);
         DestString := AnsiStringReplaceFunction(SourceString, SearchString, ReplaceString, ReplaceFlags);
         if DestString <> DestStringRef then
          begin
           ErrorTrap(VALIDATENO, SourceString, SearchString, ReplaceString, ReplaceFlags);
           Result := False;
           Exit;
          end;
        end;
      end;
    end;
  end;
end;

//Like Validate4, but against the RTL function.
//Avoid the case were the RTL function fails.

function Validate5 : Boolean;
var
 SourceString, SearchString, ReplaceString : AnsiString;
 ReplaceFlags : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
 DestString, DestStringRef : AnsiString;
 I1, I2, I3, I4 : Cardinal;
const
 VALIDATENO : Cardinal = 5;

begin
 Result := True;
 for I4 := 1 to 4 do
  begin
   case I4 of
    1 : ReplaceFlags := [];
    2 : ReplaceFlags := [rfReplaceAll];
    3 : ReplaceFlags := [rfIgnoreCase];
    4 : ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
   end;
   ReplaceString := '';
   for I1 := VALIDATE5IMIN to VALIDATE5IMAX do
    begin
     ReplaceString := ReplaceString + Char(I1);
     SearchString := '';
     for I2 := VALIDATE5IMIN to VALIDATE5IMAX do
      begin
       SearchString := SearchString + Char(I2);
       SourceString := '';
       for I3 := VALIDATE5IMIN to VALIDATE5IMAX do
        begin
         SourceString := SourceString + Char(I3);
         DestStringRef := StringReplace(SourceString, SearchString, ReplaceString, ReplaceFlags);
         DestString := AnsiStringReplaceFunction(SourceString, SearchString, ReplaceString, ReplaceFlags);
         if DestString <> DestStringRef then
          begin
           ErrorTrap(VALIDATENO, SourceString, SearchString, ReplaceString, ReplaceFlags);
           Result := False;
           Exit;
          end;
        end;
      end;
    end;
  end;
end;

function Validate6: boolean;
const
  VALIDATENO : Cardinal = 6;

procedure SetStringProtected(var s: string; var flags: dword);
const
  block= 4*1024;
var
  p, q: pchar;
begin;
  if (flags and PAGE_NOACCESS)<>0 then SetLength(s,3*block);

  p:=pointer(s);
  integer(q):=(integer(p) and -block) + 2*block;

  if (flags and PAGE_NOACCESS)<>0
  then pinteger(p-4)^:=(q-p)-1
  else pinteger(p-4)^:=3*block;

  VirtualProtect(q,1,flags,@flags);
  end;

function ValidateStringProtected(var S: string; LengthToValidate: Integer) : Boolean;

var
 TestString, SearchString, DestinationString : string;
 ReplaceFlags : TReplaceFlags;
 i, j, len : integer;
 p : pointer;
label
  BreakValidation;

begin;
  Result := False;
  Len := Length(S);
  if ((LengthToValidate and 3) <> 3)
   or (LengthToValidate < 3)
   or (LengthToValidate > Len-8) then
    Exit;
  TestString := 'abcdefg';
  FillChar(S[1], Len, 'x');
  System.Move(TestString[1], S[len+1-Length(TestString)], Length(TestString));
  p := PChar(pointer(S)) + (Len-LengthToValidate);
  pInteger(PChar(p)-4)^ := LengthToValidate;
  pInteger(PChar(p)-8)^ := 1;
  try
   for j:=0 to 2 do
    begin;
     ReplaceFlags:=[rfReplaceAll];
     if j>0 then
      ReplaceFlags:=ReplaceFlags+[rfIgnoreCase];
     if j<2 then
      TestString:=LowerCase(TestString)
     else
      TestString:=UpperCase(TestString);
     for i:=1 to Length(TestString) do
      begin;
       SearchString := copy(TestString,i,MaxInt);
       SearchString[Length(SearchString)] := '9';
       DestinationString := AnsiStringReplaceFunction(string(p), SearchString, '', ReplaceFlags);
       Result := (DestinationString=string(p));
       if not Result then
        goto BreakValidation;
       SearchString := copy(TestString,i,MaxInt);
       SearchString[1] := '9';
       DestinationString := AnsiStringReplaceFunction(string(p), SearchString, '', ReplaceFlags);
       Result := (DestinationString=string(p));
       if not Result then
        goto BreakValidation;
       SearchString:=copy(TestString,i,MaxInt);
       DestinationString:=AnsiStringReplaceFunction(string(p), SearchString, '', ReplaceFlags);
       Result:=((Length(SearchString)<=LengthToValidate)
            and (DestinationString=copy(string(p),1, Length(string(p))-Length(SearchString)))
             or (Length(SearchString)>LengthToValidate)
            and (DestinationString=string(p)));
       if not Result then
        goto BreakValidation;
      end;
    end;
 BreakValidation:
  except
   ErrorTrap(VALIDATENO, string(p), SearchString, '', ReplaceFlags);
   Result := False;
  end;
 if not Result then
  ErrorTrap(VALIDATENO, string(p), SearchString, '', ReplaceFlags);
end;

const
  len: array[0..7] of integer = (3, 7, 11, 15, 83, 87, 91, 95);
var
  flags: dword;
  s: string;
  i: integer;
begin;
  flags := PAGE_NOACCESS;
  SetStringProtected(s, flags);
  Result := true;
  for i := Low(Len) to High(Len) do
   Result := Result and ValidateStringProtected(s, len[i]);
  SetStringProtected(s, flags);
end;

function Validate7 : Boolean;
var
 c1, c2 : Char;
const
 VALIDATENO : Cardinal = 7;

begin
 Result := True;
 for c1 := #1 to #255 do
  for c2 := #1 to #255 do
   begin
    if StringReplace(c1, c2, #1, [rfIgnoreCase])
     <> AnsiStringReplaceFunction(c1, c2, #1, [rfIgnoreCase]) then
     begin
      Result := False;
      ErrorTrap(VALIDATENO, c1, c2, #1, [rfIgnoreCase]);
      Exit;
     end;
   end;
end;

function Validate8 : Boolean;
var
 DestinationString, SourceString, SearchString, ReplaceString : AnsiString;
 ReplaceFlags : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
 C1 : Char;
 I : Integer;
const
 VALIDATENO : Cardinal = 8;

begin
 Result := True;
 SourceString := '';
 C1 := 'X';
 for I := 1 to VALIDATE8MAX do
  begin
   SourceString := SourceString + C1;
   SearchString := C1;
   ReplaceString := '';
   ReplaceFlags := [rfReplaceAll];
   DestinationString := AnsiStringReplaceFunction(SourceString, SearchString, ReplaceString, ReplaceFlags);
   if DestinationString <> '' then
    begin
     ErrorTrap(VALIDATENO, SourceString, SearchString, ReplaceString, ReplaceFlags);
     Result := False;
     Break;
    end;
  end;
end;

function Validate9 : Boolean;
var
 DestinationString, SourceString, SearchString, ReplaceString : AnsiString;
 ReplaceFlags : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
 C1 : Char;
 I : Integer;
const
 VALIDATENO : Cardinal = 9;

begin
 Result := True;
 SourceString := '';
 for I := 1 to VALIDATE9MAX do
  begin
   C1 := Char((I mod 257) - 1);
   SourceString := SourceString + C1;
   SearchString := SourceString;
   ReplaceString := SourceString;
   ReplaceFlags := [rfReplaceAll];
   DestinationString := AnsiStringReplaceFunction(SourceString, SearchString, ReplaceString, ReplaceFlags);
   if DestinationString <> SourceString then
    begin
     ErrorTrap(VALIDATENO, SourceString, SearchString, ReplaceString, ReplaceFlags);
     Result := False;
     Break;
    end;
  end;
end;

function Validate10 : Boolean;
var
 DestinationString, SourceString, SearchString, ReplaceString, DestinationStringRef : AnsiString;
 ReplaceFlags : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
 C1, C2, C3 : Char;
 I1, I2, I3, I4, I5 : Integer;
const
 VALIDATENO : Cardinal = 10;

begin
 Result := True;
 for I1 := 1 to VALIDATE10MAX2 do
  begin
   C1 := Char(I1);
   SourceString := C1;
   for I2 := 1 to VALIDATE10MAX2 do
    begin
     C2 := Char(I2);
     SearchString := C2;
     for I3 := 1 to VALIDATE10MAX2 do
      begin
       C3 := Char(I3);
       ReplaceString := C3;
       for I4 := 1 to 4 do
        begin
         case I4 of
          1 : ReplaceFlags := [];
          2 : ReplaceFlags := [rfReplaceAll];
          3 : ReplaceFlags := [rfIgnoreCase];
          4 : ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
         end;
         for I5 := 1 to VALIDATE10MAX1 do
          begin
           DestinationStringRef := StringReplace(SourceString, SearchString, ReplaceString, ReplaceFlags);
           DestinationString := AnsiStringReplaceFunction(SourceString, SearchString, ReplaceString, ReplaceFlags);
           if DestinationString <> DestinationStringRef then
            begin
             ErrorTrap(VALIDATENO, SourceString, SearchString, ReplaceString, ReplaceFlags);
             Result := False;
             Exit;
            end;
            SourceString := Char((I5 mod 256)) + SourceString;
          end;
        end;
      end;
    end;
  end;
end;

//Test that source strings are preserved

function Validate11 : Boolean;
var
 DestinationString, SourceString, SearchString, ReplaceString, SourceStringRef,
 SearchStringRef, ReplaceStringRef : AnsiString;
 ReplaceFlags, ReplaceFlagsRef : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
 C1, C2, C3 : Char;
 I : Integer;
const
 VALIDATENO : Cardinal = 11;

begin
 Result := True;
 SourceString := '';
 SearchString := '';
 ReplaceString := '';
 for I := 1 to VALIDATE11MAX do
  begin
   C1 := Char(Random(255));
   C2 := Char(Random(255));
   C3 := Char(Random(255));
   SourceString := C1 + SourceString;
   SearchString := C2 + SearchString;
   if I mod 5 = 0 then
    SearchString := SourceString;//Force match
   ReplaceString := C3 + ReplaceString;
   if I mod 4 = 0 then
    ReplaceFlags := []
   else if I mod 4 = 1 then
    ReplaceFlags := [rfReplaceAll]
   else if I mod 4 = 2 then
    ReplaceFlags := [rfIgnoreCase]
   else if I mod 4 = 3 then
    ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
   //Back up source strings
   SourceStringRef := SourceString;
   SearchStringRef := SearchString;
   ReplaceStringRef := ReplaceString;
   ReplaceFlagsRef := ReplaceFlags;
   DestinationString := AnsiStringReplaceFunction(SourceString, SearchString, ReplaceString, ReplaceFlags);
   if (SourceString  <> SourceStringRef) or
      (SearchString  <> SearchStringRef) or
      (ReplaceString <> ReplaceStringRef) or
      (ReplaceFlags  <> ReplaceFlagsRef) then
    begin
     ErrorTrap(VALIDATENO, SourceString, SearchString, ReplaceString, ReplaceFlags);
     Result := False;
     Break;
    end;
  end;
end;

function Validate12 : Boolean;
var
 DestinationString, SourceString, SearchString, ReplaceString, S : AnsiString;
 ReplaceFlags : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
 C1, C2 : Char;
 I : Integer;
const
 VALIDATENO : Cardinal = 12;

begin
 Result := True;
 ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
 for I := 1 to VALIDATE12MAX do
  begin
   C1 := Char(Random(255));
   C2 := Char(I mod 256);
   S := C1 + S + C2;
   SourceString := UpperCase(S);
   SearchString := LowerCase(S);
   ReplaceString := S;
   DestinationString := AnsiStringReplaceFunction(SourceString, SearchString, ReplaceString, ReplaceFlags);
   if DestinationString <> S then
    begin
     ErrorTrap(VALIDATENO, SourceString, SearchString, ReplaceString, ReplaceFlags);
     Result := False;
     Break;
    end;
  end;
end;

//Validation for non-nil zero length source string

var
 SourceStringGlobal : AnsiString;

function Validate13 : Boolean;
var
 SearchString, ReplaceString, DestinationString : AnsiString;
 ReplaceFlags : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
const
 VALIDATENO : Cardinal = 13;

begin
 SearchString := 'Z';
 ReplaceString := 'G';
 ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
 SourceStringGlobal := 'Z';
 (PInteger(Integer(SourceStringGlobal)-4))^ := 0;
 DestinationString := AnsiStringReplaceFunction(SourceStringGlobal, SearchString, ReplaceString, ReplaceFlags);
 if DestinationString <> '' then
  begin
   Result := False;
   ErrorTrap(VALIDATENO, SourceStringGlobal, SearchString, ReplaceString, ReplaceFlags);
  end
 else
  Result := True;
end;

//Validation for non-nil zero length source string

var
 SearchStringGlobal : AnsiString;

function Validate14 : Boolean;
var
 SourceString, ReplaceString, DestinationString : AnsiString;
 ReplaceFlags : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
const
 VALIDATENO : Cardinal = 14;

begin
 SourceString := 'Z';
 ReplaceString := 'H';
 ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
 SearchStringGlobal := 'Z';
 (PInteger(Integer(SearchStringGlobal)-4))^ := 0;
 DestinationString := AnsiStringReplaceFunction(SourceString, SearchStringGlobal, ReplaceString, ReplaceFlags);
 if DestinationString <> 'Z' then
  begin
   Result := False;
   ErrorTrap(VALIDATENO, SourceString, SearchStringGlobal, ReplaceString, ReplaceFlags);
  end
 else
  Result := True;
end;

function Validate15 : Boolean;

function ShaString(Len: integer): string;
begin
  SetLength(Result,Len);
  FillChar(Result[1],Len,'2');
  Result[1]:='1';
end;

var
  s1, s2: AnsiString;
begin
  s1:=ShaString(64*1024);
  s2:=ShaString(128*1024-1);
  try
    Result:=(s2=AnsiStringReplaceFunction(s1,'1',s1,[rfReplaceAll]));
  except
    Result:=false;
  end;
end;

function Validate16 : Boolean;
var
 DestinationString, SourceString, SearchString, ReplaceString, DestinationStringRef : AnsiString;
 ReplaceFlags : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
 C1, C2, C3, C4 : Char;
 I1, I2, I3, I4, I5, I6 : Integer;
const
 VALIDATENO : Cardinal = 16;

begin
 Result := True;
 for I6 := 0 to VALIDATE16MAX1 do
  begin
   C1 := Char(I6);
   for I1 := 0 to VALIDATE16MAX2 do
    begin
     C2 := Char(I1);
     SourceString := C1 + C2;
     for I2 := 0 to VALIDATE16MAX2 do
      begin
       C3 := Char(I2);
       SearchString := C3;
       for I3 := 0 to VALIDATE16MAX2 do
        begin
         C3 := Char(I3);
         ReplaceString := C3 + C3;
         for I4 := 1 to 4 do
          begin
           case I4 of
            1 : ReplaceFlags := [];
            2 : ReplaceFlags := [rfReplaceAll];
            3 : ReplaceFlags := [rfIgnoreCase];
            4 : ReplaceFlags := [rfReplaceAll, rfIgnoreCase];
           end;
           for I5 := 1 to VALIDATE16MAX1 do
            begin
             DestinationStringRef := StringReplaceRef(SourceString, SearchString, ReplaceString, ReplaceFlags);
             DestinationString := AnsiStringReplaceFunction(SourceString, SearchString, ReplaceString, ReplaceFlags);
             if DestinationString <> DestinationStringRef then
              begin
               ErrorTrap(VALIDATENO, SourceString, SearchString, ReplaceString, ReplaceFlags);
               Result := False;
               Exit;
              end;
             C4 := Char(I5);
             SourceString := SourceString + C4 + C4;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function Validate18 : Boolean;
var
 S : AnsiString;

begin
 try
  Result := True;
  SetLength(S, MaxInt div 2);
  FillChar(S[1], 9999, 'a');
  S := AnsiStringReplaceFunction(S,'a',S,[]);
 except
  //What to do here !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Result := False;
 end;
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionAddress : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  //if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_LOWEST) = False then
   //raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_LOWEST failed');
  ValidateButton.Caption := 'Running';
  ValidationEdit.Color := clBlue;
  Update;
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@AnsiStringReplaceFunction);
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
     Validate13 and
     Validate14 and
     Validate15 and
     Validate16 then
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
  FunctionAddress := Cardinal(@AnsiStringReplaceFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  ReportRichEdit.Lines.Add(FunctionName
                    + #9 + FunctionAddressString[8]
                   + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
var
 FunctionAddress, SubBench1, Bench, SubBench2 : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@AnsiStringReplaceFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  BenchmarkButton.Caption := 'Running';
  SubBench1 := SubBenchmark1;
  SubBench2 := SubBenchmark2;
  Bench := SubBench1 + SubBench2;
  RuntimeEdit.Text := IntToStr(Bench);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]
                           + #9 + IntToStr(SubBench1)
                           + #9 + IntToStr(SubBench2)
                           + #9 + IntToStr(Bench));
  SortRichEdit;
  BenchmarkTest;
  AlignmentTest;
  BenchmarkButton.Caption := 'Benchmark';
 except
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]
                           + #9 + 'Failed'
                           + #9 + '9999'
                           + #9 + '9999');
 end;
end;

function TMainForm.SubBenchmark1 : Cardinal;
var                                              
 DestinationString : AnsiString;
 ReplaceFlags : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
 I1, I3, I5, I6 : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 for I3 := 1 to NOOFRERUNS do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I1 := 1 to NOOFRUNS do
    begin
     if I1 mod 4 = 3 then
      ReplaceFlags := [rfReplaceAll]
     else if I1 mod 4 = 2 then
      ReplaceFlags := [rfReplaceAll, rfIgnoreCase]
     else if I1 mod 4 = 1 then
      ReplaceFlags := [rfIgnoreCase]
     else
      ReplaceFlags := [];
     for I5 := 0 to BENCHMARKTESTNOSPLIT-1 do
      begin
       DestinationString := AnsiStringReplaceFunction(BenchmarkTestSetArray[I5].SourceString,
                                                      BenchmarkTestSetArray[I5].SearchString,
                                                      BenchmarkTestSetArray[I5].ReplaceString,
                                                      ReplaceFlags);
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[I3-1] := NoOfTicks;
   DestinationEdit.Text := DestinationString;//Fool compiler
  end;
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I6 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I6] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I6];
  end;
 RunTimeSec := MinNoOfTicks / Frequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmark2 : Cardinal;
var
 DestinationString : AnsiString;
 ReplaceFlags : TReplaceFlags; //TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
 I1, I3, I5, I6 : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 for I3 := 1 to NOOFRERUNS do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I1 := 1 to NOOFRUNS do
    begin
     if I1 mod 4 = 3 then
      ReplaceFlags := [rfReplaceAll]
     else if I1 mod 4 = 2 then
      ReplaceFlags := [rfReplaceAll, rfIgnoreCase]
     else if I1 mod 4 = 1 then
      ReplaceFlags := [rfIgnoreCase]
     else
      ReplaceFlags := [];
     for I5 := BENCHMARKTESTNOSPLIT to BENCHMARKTESTNOMAX-1 do
      begin
       DestinationString := AnsiStringReplaceFunction(BenchmarkTestSetArray[I5].SourceString,
                                                      BenchmarkTestSetArray[I5].SearchString,
                                                      BenchmarkTestSetArray[I5].ReplaceString,
                                                      ReplaceFlags);
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[I3-1] := NoOfTicks;
   DestinationEdit.Text := DestinationString;//Fool compiler
  end;
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I6 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I6] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I6];
  end;
 RunTimeSec := MinNoOfTicks / Frequency;
 Result := Round(RunTimeSec*SUBBENCH2SCALE);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var CpuString : string;
begin
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount := 4;
 ReportRichEdit.Paragraph.Tab[0] := 120;
 ReportRichEdit.Paragraph.Tab[1] := 160;
 ReportRichEdit.Paragraph.Tab[2] := 210;
 ReportRichEdit.Paragraph.Tab[3] := 260;
 FunctionSelectionRadioGroupClick(nil);
 FillValidateTestSetArray;
 FillBenchmarkTestSetArray;
 if not QueryPerformanceFrequency(Frequency) then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);

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
   1 : AnsiStringReplaceFunction := StringReplace;        // "StringReplace_RTL_PAS_1"
   2 : AnsiStringReplaceFunction := StringReplaceRef;     // "StringReplace_REF_PAS_1"
   3 : AnsiStringReplaceFunction := StringReplace_HV_IA32_1;
   4 : AnsiStringReplaceFunction := StringReplace_SHA_IA32_1;
   5 : AnsiStringReplaceFunction := StringReplace_EG_MMX_1;
   6 : AnsiStringReplaceFunction := StringReplace_EWC_IA32_2;
   7 : AnsiStringReplaceFunction := StringReplace_DKC_Pas_6;
   8 : AnsiStringReplaceFunction := StringReplace_DKC_IA32_17;
   9 : AnsiStringReplaceFunction := StringReplace_DKC_IA32_19;
  10 : AnsiStringReplaceFunction := StringReplace_DKC_IA32_20;
  11 : AnsiStringReplaceFunction := StringReplace_DKC_MMX_12;
  12 : AnsiStringReplaceFunction := StringReplace_DKC_MMX_13;
  13 : AnsiStringReplaceFunction := StringReplace_DKC_MMX_14;
  14 : AnsiStringReplaceFunction := StringReplace_DKC_SSE_11;
  15 : AnsiStringReplaceFunction := StringReplace_DKC_SSE_12;
  16 : AnsiStringReplaceFunction := StringReplace_DKC_SSE2_21;
  17 : AnsiStringReplaceFunction := StringReplace_DKC_SSE2_22;
  18 : AnsiStringReplaceFunction := StringReplace_JOH_PAS_12;
  19 : AnsiStringReplaceFunction := StringReplace_JOH_IA32_12;
  20 : AnsiStringReplaceFunction := StringReplace_JOH_IA32_17;
  21 : AnsiStringReplaceFunction := StringReplace_JOH_IA32_18;
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
 //First run profits from a "clear" memory
 FunctionSelectionRadioGroup.ItemIndex := 0;
 BenchmarkButtonClick(nil);
 ReportRichEdit.Clear;
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   BenchmarkButtonClick(nil);
   Update;
  end;
 BenchmarkTest;
 AlignmentTest;
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
 //for I := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
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
 ReportRichEdit.Print('AnsiStringReplace Report');
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1, I2 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 Update;
 //for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 for I1 := 1 to 3 do
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

procedure TMainForm.Button1Click(Sender: TObject);
var
  a,b,c,d,e,I:integer;
  S, SubStr: string;
begin
(*
  for a := 1 to 10 do
    begin
      setlength(s,a);
      for b := 1 to 10 do
        begin
          setlength(substr,b);
          d := (1 shl b) - 1;  //1,3,7,15...
          for c := 0 to d do
            begin

            end;

        end;

    end;
*)

  SetLength(S, 4);
  SetLength(SubStr, 2);

  for b := 1 to 100000 do
    begin
      for a  := 1 to Length(S) do
        S[a] := char(random(2));
      for a  := 1 to Length(SubStr) do
        SubStr[a] := char(random(2));
      I := AnsiStringReplaceJOHIA32Unit12.AnsiPosExIC(SubStr, S);
      if I <> PosEx(SubStr, S) then
        begin
          beep;
          I := AnsiStringReplaceJOHIA32Unit12.AnsiPosExIC(SubStr, S);
          sleep(I);
        end;
    end;


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
