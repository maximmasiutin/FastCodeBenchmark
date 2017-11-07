unit ReportFormUnit;

interface

uses
  Classes, Clipbrd, Controls, ComCtrls, ExtCtrls, Forms, StdCtrls;

type
  TReportForm = class(TForm)
  private
    function GetText: string;
    procedure SetText(const Value: string);
  public
    property Text: string read GetText write SetText;
  published
    ButtonClose: TButton;
    ButtonCopy: TButton;
    PanelButtonContainer: TPanel;
    RichEditReport: TRichEdit;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonCopyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

implementation

{$R *.dfm}

function TReportForm.GetText: string;
begin
  Result := RichEditReport.Text;
end;

procedure TReportForm.SetText(const Value: string);
begin
  RichEditReport.Text := Value;
end;

procedure TReportForm.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TReportForm.ButtonCopyClick(Sender: TObject);
begin
  Clipboard.SetTextBuf(PChar(RichEditReport.Text));
end;

procedure TReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
