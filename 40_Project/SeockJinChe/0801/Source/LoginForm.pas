unit LoginForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Layouts;

type
  TfrmLogin = class(TForm)
    StyleBook1: TStyleBook;
    Layout1: TLayout;
    Label2: TLabel;
    edtId: TEdit;
    Label1: TLabel;
    edtPassword: TEdit;
    btnDuple: TButton;
    btnLoginCheck: TButton;
    procedure btnLoginCheckClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

uses MobileDataModule, MobileReserveForm;

procedure TfrmLogin.btnLoginCheckClick(Sender: TObject);
begin
  if (edtId.Text = 'madongseok') and (edtPassword.Text = 'masterkey') then
  begin
    UserSEQ := DataModule1.User.FieldByName('PATIENT_SEQ').AsInteger;   //�α������� ����
    UserName := DataModule1.User.FieldByName('PATIENT_NAME').AsString;
  end;

  frmMain.edtName.Text := UserName;  //����ȭ�鿡 �����̸� �ֱ�
  frmMain.pnlLogin.Visible := False; //�α���â ��Ȱ��ȭ
  close;
end;

end.
