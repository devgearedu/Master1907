program Clac;

uses
  Vcl.Forms,
  Cla in 'Cla.pas' {Form1},
  USplash in 'USplash.pas' {SplashForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  SplashForm := TSplashForm.Create(application);
  SplashForm.show;                //���÷���
  SplashForm.Refresh;
  Application.CreateForm(TForm1, Form1);
  SplashForm.Hide;         //���÷���
  SplashForm.Free;
  Application.Run;
end.
