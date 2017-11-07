program ScaleDownBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  ScaleDownDKCUnit in 'ScaleDownDKCUnit.pas',
  ImageUnit in 'ImageUnit.pas' {ImageForm},
  ScaleDownRMKUnit in 'ScaleDownRMKUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TImageForm, ImageForm);
  Application.Run;
end.
