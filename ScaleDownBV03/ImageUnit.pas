unit ImageUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtDlgs, ExtCtrls, ComCtrls;

type
  TImageForm = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    OpenPictureDialog: TOpenPictureDialog;
    BitBtn1: TBitBtn;
    ScaleDownButton: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    RadioGroup1: TRadioGroup;
    ScaleEdit: TEdit;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ScaleDownButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImageForm: TImageForm;

implementation

uses
 ScaleDownDKCUnit, ScaleDownRMKUnit;

{$R *.dfm}

procedure TImageForm.SpeedButton1Click(Sender: TObject);
begin
 if OpenPictureDialog.Execute then
  begin
   Image1.Picture.LoadFromFile(OpenPictureDialog.FileName);
   Image1.Picture.Bitmap.PixelFormat := pf32bit;
   ScaleDownButton.Enabled := True;
   RadioGroup1.Enabled := True;
   TrackBar1.Enabled := True;
  end;
end;

procedure TImageForm.ScaleDownButtonClick(Sender: TObject);
var
 SourceBitmap, DestinationBitmap : TBitmap;
 Scale : Single;

begin
 ScaleDownButton.Enabled := False;
 RadioGroup1.Enabled := False;
 Update;
 SourceBitmap := TBitmap.Create;
 Scale := StrToFloat(ScaleEdit.Text);
 Edit1.Text := IntToStr(Image1.Picture.Bitmap.Height);
 Edit2.Text := IntToStr(Image1.Picture.Bitmap.Width);
 case RadioGroup1.ItemIndex of
  0 : DestinationBitmap := ScaleDownRMKPas1(Image1.Picture.Bitmap, Scale);
  1 : DestinationBitmap := ScaleDownDKCPas1(Image1.Picture.Bitmap, Scale);
  2 : DestinationBitmap := ScaleDownDKCPas2(Image1.Picture.Bitmap, Scale);
  3 : DestinationBitmap := ScaleDownDKCPas3(Image1.Picture.Bitmap, Scale);
  4 : DestinationBitmap := ScaleDownDKCPas4(Image1.Picture.Bitmap, Scale);
  5 : DestinationBitmap := ScaleDownDKCPas5(Image1.Picture.Bitmap, Scale);
  6 : DestinationBitmap := ScaleDownDKCPas6(Image1.Picture.Bitmap, Scale);
  7 : DestinationBitmap := ScaleDownDKCPas7(Image1.Picture.Bitmap, Scale);
  8 : DestinationBitmap := ScaleDownDKCPas8(Image1.Picture.Bitmap, Scale);
  9 : DestinationBitmap := ScaleDownDKCPas9(Image1.Picture.Bitmap, Scale);
  10 : DestinationBitmap := ScaleDownDKCPas10(Image1.Picture.Bitmap, Scale);
 else
  DestinationBitmap := TBitmap.Create;
 end;
 Image2.Picture.Assign(DestinationBitmap);
 Edit3.Text := IntToStr(DestinationBitmap.Height);
 Edit4.Text := IntToStr(DestinationBitmap.Width);
 SourceBitmap.Free;
 DestinationBitmap.Free;
 ScaleDownButton.Enabled := True;
 RadioGroup1.Enabled := True;
 Update;
end;

procedure TImageForm.FormCreate(Sender: TObject);
begin
 ScaleEdit.Text := '3';
end;

procedure TImageForm.TrackBar1Change(Sender: TObject);
begin
 ScaleEdit.Text := FloatToStr(TrackBar1.Position / 10);
 ScaleDownButtonClick(nil);
end;

end.
