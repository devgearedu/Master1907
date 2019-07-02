unit ArrayForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FNumArr: array[0..9] of Integer;

    procedure InitArray;
    function GetArraySum: Integer;
    function GetArrayMaxNum: Integer;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
begin
  InitArray;
end;

// �迭�� �ʱⰪ�� ����
procedure TForm3.InitArray;
var
  I: Integer;
begin
  // �迭(FNumArr)�� ���̸�ŭ �ݺ��ϸ� ������ ��(1~100)�� ����
  for I := 0 to Length(FNumArr) - 1 do
    FNumArr[I] := Random(100);
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  I: Integer;
  Sum, MaxNum: Integer;
begin
  // �迭�� ��
  Sum := GetArraySum;

  // �迭 �� �ְ�
  MaxNum := GetArrayMaxNum;

  Memo1.Lines.Clear;
  Memo1.Lines.Add('�迭 ����');

  { TODO :
    (1) for ���� �̿��� �迭�� ������ ����ϼ���.
    �迭�� ũ�� ����ǵ� �����ϵ��� �ݺ��� ���� Length(FNumArr) - 1�� ����
     ��> for I := 0 to Length(FNumArr) - 1 do }

  Memo1.Lines.Add('�迭�� ���� ' + IntToStr(Sum) + ' �Դϴ�.');
  Memo1.Lines.Add('�迭�� �ִ밪�� ' + IntToStr(MaxNum) + ' �Դϴ�.');
end;

function TForm3.GetArraySum: Integer;
var
  I, Sum: Integer;
begin
  Sum := 0;
  { TODO : (2) for ���� �̿��� �迭�� ���� ��� ���� ��ȯ�ϵ��� ���� }

  Result := Sum;
end;

function TForm3.GetArrayMaxNum: Integer;
var
  I, MaxNum: Integer;
begin
  MaxNum := 0;
  { TODO :
    (3) for ���� �̿��� �迭�� �� �� ���� ū ���� ��ȯ�ϵ��� ����
        if ���� �̿��� ���ڸ� ��  }

  Result := MaxNum;
end;

procedure TForm3.Button2Click(Sender: TObject);
var
  I,
  CountOver, CountUnder: Integer;
begin
  CountOver := 0;
  CountUnder := 0;
  { TODO :
      (4) for ���� �̿��� �迭�� ����
          50 �̻�(>=)�� ��� CountOver 1 ����
          50 �̸�(<)�� ��� CountUnder 1 ���� �ϵ��� ����
  }

  Memo1.Lines.Add('50 �̻��� ���� ����: ' + IntToStr(CountOver));
  Memo1.Lines.Add('50 �̸��� ���� ����: ' + IntToStr(CountUnder));
end;

end.
