unit OptionsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TOptionsForm = class(TForm)
    CloseBitBtn: TBitBtn;
    SortReportByRadioGroup: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SortReportByRadioGroupClick(Sender: TObject);
  private
   procedure ReadIniFile(FileName : AnsiString);
   procedure WriteIniFile(FileName : AnsiString);
  public
    { Public declarations }
  end;

var
  OptionsForm: TOptionsForm;

implementation

uses
 IniFiles, MainUnit;

const
 INIFILENAME : AnsiString = 'MoveIni.ini';

//******************************************************************************
//Ini file handling functions
//******************************************************************************

procedure TOptionsForm.ReadIniFile(FileName : AnsiString);
var
 IniFile : TIniFile;

begin
 IniFile := TIniFile.Create(FileName);
 SortReportByRadioGroup.ItemIndex := IniFile.ReadInteger('Options', 'SortReportByRadioGroup', 5);
 IniFile.Free;
end;

procedure TOptionsForm.WriteIniFile(FileName : AnsiString);
var
 IniFile : TIniFile;

begin
 IniFile := TIniFile.Create(FileName);
 IniFile.WriteInteger('Options', 'SortReportByRadioGroup', SortReportByRadioGroup.ItemIndex);
 IniFile.Free;
end;

{$R *.dfm}

procedure TOptionsForm.FormShow(Sender: TObject);
begin
 ReadIniFile(INIFILENAME);
end;

procedure TOptionsForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 WriteIniFile(INIFILENAME);
end;

procedure TOptionsForm.FormCreate(Sender: TObject);
begin
 ReadIniFile(INIFILENAME)
end;

procedure TOptionsForm.SortReportByRadioGroupClick(Sender: TObject);
begin
 MainForm.SortReport;
end;

end.
