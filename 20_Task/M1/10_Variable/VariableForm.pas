unit VariableForm;

interface

// ����� �׽�Ʈ

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edtNum: TEdit;
    Button1: TButton;
    edtSum: TEdit;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    // �� ��(����)������ ����ϴ� ������ �Լ��� ����

    { TODO : (1) ���� �� FSum ������ �����ϼ���. }

    function AddNum(ANum: Integer): Integer;
  public
    // �ٸ� ���ֿ��� ������ �� �ִ� ������ �Լ� ����
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.AddNum(ANum: Integer): Integer;
begin
  { TODO :
      (2) FSum ������ �Ķ���� ANum ���� ���մϴ�.
          FSum ���� ��ȯ }
  Result := 0;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Num, Sum: Integer;  // �̰��� ����� ������ �� �Լ������� ����մϴ�.
begin
  Num := StrToInt(edtNum.Text);
  Sum := AddNum(Num);

  edtSum.Text := IntToStr(Sum);
end;

end.
