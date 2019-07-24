unit ConditionForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmCondition = class(TForm)
    edtId: TEdit;
    edtPwd: TEdit;
    Button1: TButton;
    mmoIds: TMemo;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FIds: array of string;
    FPwds: array of string;

    function CheckEmpty(AId, APwd: string): Boolean;
    function CheckNotFoundId(AId, APwd: string): Boolean;
    function CheckIncorrect(AId, APwd: string): Boolean;
  public
    { Public declarations }
    procedure InitData;

    function LoginCheck(AId, APwd: string): Integer;
  end;

var
  frmCondition: TfrmCondition;

const
  LOGIN_RESULT_OK           = 0;
  LOGIN_RESULT_NOTFOUND_ID  = 10;
  LOGIN_RESULT_INCORRECT    = 20;
  LOGIN_RESULT_EMPTY        = 30;

implementation

{$R *.dfm}

{ TForm2 }

procedure TfrmCondition.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  InitData;

  for I := 0 to Length(FIds) - 1 do
    mmoIds.Lines.Add(FIds[I] + '/' + FPwds[I]);
end;

procedure TfrmCondition.InitData;
begin
  FIds  := ['abc', 'test', 'yourid', 'myid', 'unknown'];
  FPwds := ['123', '123', '123', '123', '123'];
end;

function TfrmCondition.CheckEmpty(AId, APwd: string): Boolean;
begin
  { TODO : ���̵�� ��й�ȣ�� ����(����) ��� False ��ȯ }
 if (AId = '') and (APwd ='') then
  Result := False;
end;

function TfrmCondition.CheckNotFoundId(AId, APwd: string): Boolean;
var
  I : integer;
begin
  { TODO : ���̵� FIds �迭�ȿ� ���� ��� False ��ȯ }
  for I := 0 to Length(FIds)-1 do
    if AId=FIds[I] then
      exit(True);
  Result := False;
end;

function TfrmCondition.CheckIncorrect(AId, APwd: string): Boolean;
var
  I, idIndex : integer;

begin
  { TODO : ��й�ȣ�� ���� �ʴ� ��� False ��ȯ }
  for I := 0 to Length(FIds)-1 do
  begin
    if AId=FIds[I] then
    begin
      idIndex := I;
      break;
    end;
  end;

  if (APwd <> FPwds[idIndex]) then
    Result := False
  else
    exit(True);
end;

function TfrmCondition.LoginCheck(AId, APwd: string): Integer;
begin
  // ���̵� �Ǵ� ��й�ȣ�� ������ ��� 30 ��ȯ
  if not CheckEmpty(AId, APwd) then
    Exit(LOGIN_RESULT_EMPTY);

  // ���̵� ã�� �� ���� ��� 10 ��ȯ
  if not CheckNotFoundId(AId, APwd) then
    Exit(LOGIN_RESULT_NOTFOUND_ID);

  // ���̵��� ��й�ȣ�� ���� �ʴ� ��� 20 ��ȯ
  if not CheckIncorrect(AId, APwd) then
    Exit(LOGIN_RESULT_INCORRECT);

  // ���̵� ��й�ȣ�� ��ȿ�� ��� 0 ��ȯ
  Result := LOGIN_RESULT_OK;
end;

procedure TfrmCondition.Button1Click(Sender: TObject);
var
  LoginResult: Integer;
begin
  LoginResult := LoginCheck(edtId.Text, edtPwd.Text);

  if LoginResult > 0 then
  begin
    case LoginResult of
    LOGIN_RESULT_NOTFOUND_ID,
    LOGIN_RESULT_INCORRECT:   ShowMessage('���̵� �Ǵ� ��й�ȣ�� ���� �ʽ��ϴ�.');
    LOGIN_RESULT_EMPTY:       ShowMessage('���̵�� ��й�ȣ�� �Է��ϼ���.');
    end;
    Exit;
  end;

  ShowMessage('�α��� ����');
end;

end.
