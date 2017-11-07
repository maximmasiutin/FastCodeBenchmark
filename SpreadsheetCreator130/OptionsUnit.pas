unit OptionsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, ExtCtrls, Buttons;

type
  TOptionsForm = class(TForm)
    FilePathLabeledEdit: TLabeledEdit;
    DirectoryListBox1: TDirectoryListBox;
    ExcludeRTLFunctionCheckBox: TCheckBox;
    CloseBitBtn: TBitBtn;
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseBitBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ClearGridsAndEdits;
    procedure ClearWinnerAndEdits;
    { Public declarations }
  end;

var
 OptionsForm: TOptionsForm;

implementation

uses MainUnit;

{$R *.dfm}

procedure TOptionsForm.DirectoryListBox1Change(Sender: TObject);
begin
 FilePathLabeledEdit.Text := DirectoryListBox1.Directory;
 MainForm.ChallengeName := '';
 MainForm.Caption := MainForm.MainFormCaption + '  -  ' + FilePathLabeledEdit.Text;
 MainForm.ChallengeNameEdit.Clear;
 MainForm.ChallengeVersionNumberEdit.Clear;
end;

procedure TOptionsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 WriteIniFile(INIFILENAME);
 MainForm.Caption := MainForm.MainFormCaption + '  -  ' + FilePathLabeledEdit.Text;
 try
  //MainForm.LoadAllButtonClick(self);
  ClearWinnerAndEdits;
  //MainForm.CreateSpreadsheetsButton.Enabled := False;
 except
  ClearGridsAndEdits;
  ClearWinnerAndEdits;
  //MainForm.CreateSpreadsheetsButton.Enabled := False;
 end;
end;

procedure TOptionsForm.ClearGridsAndEdits;
begin
 MainForm.PenrynStringGrid.RowCount := 1;
 MainForm.PenrynStringGrid.ColCount := 1;
 MainForm.PenrynStringGrid.Rows[0].Clear;
 MainForm.ConroeStringGrid.RowCount := 1;
 MainForm.ConroeStringGrid.ColCount := 1;
 MainForm.ConroeStringGrid.Rows[0].Clear;
 MainForm.NorthwoodStringGrid.RowCount := 1;
 MainForm.NorthwoodStringGrid.ColCount := 1;
 MainForm.NorthwoodStringGrid.Rows[0].Clear;
 MainForm.YonahStringGrid.RowCount := 1;
 MainForm.YonahStringGrid.ColCount := 1;
 MainForm.YonahStringGrid.Rows[0].Clear;
 MainForm.AMD64X2StringGrid.RowCount := 1;
 MainForm.AMD64X2StringGrid.ColCount := 1;
 MainForm.AMD64X2StringGrid.Rows[0].Clear;
 MainForm.PhenomStringGrid.RowCount := 1;
 MainForm.PhenomStringGrid.ColCount := 1;
 MainForm.PhenomStringGrid.Rows[0].Clear;
 MainForm.PenrynCPUTypeLabeledEdit.Text := '';
 MainForm.PenrynSpeedUpOverRTLLabeledEdit.Text := '';
 MainForm.NorthwoodCPUTypeLabeledEdit.Text := '';
 MainForm.NorthwoodSpeedUpOverRTLLabeledEdit.Text := '';
 MainForm.ConroeCPUTypeLabeledEdit.Text := '';
 MainForm.ConroeSpeedUpOverRTLLabeledEdit.Text := '';
 MainForm.YonahCPUTypeLabeledEdit.Text := '';
 MainForm.YonahSpeedUpOverRTLLabeledEdit.Text := '';
 MainForm.AMD64X2CPUTypeLabeledEdit.Text := '';
 MainForm.PhenomSpeedUpOverRTLLabeledEdit.Text := '';
 MainForm.AMD64X2CPUTypeLabeledEdit.Text := '';
 MainForm.AMD64X2SpeedUpOverRTLLabeledEdit.Text := '';
 MainForm.ChallengeNameEdit.Text := '';
 MainForm.ChallengeVersionNumberEdit.Text := '';
 MainForm.Caption := MainForm.MainFormCaption + '  -  "' + FilePathLabeledEdit.Text + '" - Invalid directory, please select a new one!';
end;

procedure TOptionsForm.ClearWinnerAndEdits;
var
 I : Integer;

begin
 for I := 0 to MainForm.WinnersStringGrid.RowCount - 1 do
  MainForm.WinnersStringGrid.Rows[i].Clear;
 for I := 0 to MainForm.PointsStringGrid.RowCount - 1 do
  MainForm.PointsStringGrid.Rows[i].Clear;
end;

procedure TOptionsForm.CloseBitBtnClick(Sender: TObject);
begin
 Close;
end;

procedure TOptionsForm.FormCreate(Sender: TObject);
begin
 ReadIniFile(INIFILENAME);
 DirectoryListBox1.Directory := FilePathLabeledEdit.Text;
end;

end.
