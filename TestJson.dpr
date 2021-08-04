program TestJson;

uses
  Vcl.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uMainClasses in 'uMainClasses.pas',
  uTestJSON in 'uTestJSON.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
