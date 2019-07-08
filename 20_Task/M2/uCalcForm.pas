unit uCalcForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmCalc = class(TForm)
    displayLabel: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    procedure ButtonNumberClick(Sender: TObject);
    procedure ButtonOperatorClick(Sender: TObject);
    procedure ButtonEqualClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure Button12KeyPress(Sender: TObject; var Key: Char);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCalc: TfrmCalc;

implementation

{$R *.dfm}
var
typing : boolean = false;  //Ÿ���������� üũ
firstNumber: integer;
secondNumber: integer;
operator :integer;
result: real;
rep: boolean = false;   //�����ڸ� �ݺ��ϴ��� ���� üũ
//���ڹ�ư�� ��������

procedure TfrmCalc.ButtonNumberClick(Sender: TObject);
begin
  rep := false;
  //�ݺ��� Ǯ����
  if typing then
    displayLabel.Caption := displayLabel.Caption + (sender as TButton).Caption
  else
  begin
    displayLabel.Caption := (sender as TButton).Caption;
    typing := true;
  end;

end;
//���� ������ ���ڸ� ����

procedure TfrmCalc.ButtonDeleteClick(Sender: TObject);
var s: string;
begin
  s := displayLabel.Caption;
  displayLabel.Caption := copy(s,0,length(s)-1);
end;
 //�޸𸮿� ����� ��簪�� ����

procedure TfrmCalc.Button12KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Button12.Click;
  end;

end;

procedure TfrmCalc.ButtonClearClick(Sender: TObject);
begin
  displayLabel.Caption := '';
  typing := false;
  firstNumber:= 0;
  secondNumber:= 0;
  result:= 0;
  rep := false;
end;
//������ ��ư�� �������� firstNumber�� ���÷��̶��� ���� ����
//�����ڸ� ���ڷ� �з�

procedure TfrmCalc.ButtonOperatorClick(Sender: TObject);

begin

  if rep then
  begin
  showmessage('���ڸ� �Է��ϼ���');
  end
  else
  firstNumber := strtoint(displayLabel.caption);
  displayLabel.caption := '';
  if (sender as TButton).Caption = '+' then
  operator := 1
  else if (sender as TButton).Caption = '-' then
  operator := 2
  else if (sender as TButton).Caption = '*' then
  operator := 3
  else if (sender as TButton).Caption = '/' then
  operator := 4;
   rep := true
end;
//=��ư�� �������� ó��

procedure TfrmCalc.ButtonEqualClick(Sender: TObject);

begin
  secondNumber := strtoint(displayLabel.caption);
  if rep then
  begin
  showmessage('���ڸ� �Է��ϼ���');
  end
  else
  case operator of
    1:
    begin
    result := firstNumber + secondNumber;
    end;
    2:
    begin
    result := firstNumber - secondNumber;
    end;
    3:
    begin
    result := firstNumber * secondNumber;
    end;
    4:
    begin
    result := firstNumber / secondNumber;
    end;
   end;
  displayLabel.caption := floattostr(result);
  typing := false;
  rep := true;
end;
end.
