program ����_���ȯ;

uses
  Vcl.Forms,
  ���� in 'D:\201907_�����̱���\����\����.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sky');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
