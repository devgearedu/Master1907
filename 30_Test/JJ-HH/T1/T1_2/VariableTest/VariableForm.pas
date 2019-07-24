unit VariableForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmVariable = class(TForm)
    Label2: TLabel;
    Label1: TLabel;
    edtSum: TEdit;
    edtNum: TEdit;
    btnPlus: TButton;
    btnMinus: TButton;
    procedure btnPlusClick(Sender: TObject);
    procedure btnMinusClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    /// <summary>���� FSum�� �ʱ�ȭ �Ѵ�.</summary>
    procedure InitData;
    /// <summary>���� FSum�� �Ķ���� ANum ���� ���Ѵ�.</summary>
    function AddNum(ANum: Integer): Integer;
    /// <summary>���� FSum�� �Ķ���� ANum ���� ����.</summary>
    function SubNum(ANum: Integer): Integer;
  end;

var
  frmVariable: TfrmVariable;
  FNum : integer;

implementation

{$R *.dfm}

{ TForm1 }

// ������ ������ �Էµ� ���� ���ϴ�.
procedure TfrmVariable.btnMinusClick(Sender: TObject);
var
  Num, Sum: Integer;
begin
  Sum:=FNum;
  Num := StrToInt(edtNum.Text);
  Sum := SubNum(Num);

  edtSum.Text := IntToStr(Sum);
end;

// ������ ������ �Էµ� ���� ���մϴ�.
procedure TfrmVariable.btnPlusClick(Sender: TObject);
var
  Num, Sum: Integer;
begin
  sum:=FNum;
  Num := StrToInt(edtNum.Text);
  Sum := AddNum(Num);

  edtSum.Text := IntToStr(Sum);
end;

procedure TfrmVariable.InitData;
begin
  // ���� FNum�� �ʱ�ȭ �ϼ���.
  FNum :=0;
end;

function TfrmVariable.AddNum(ANum: Integer): Integer;
begin
  FNum := FNum+ANum;
  Result := FNum;
end;

function TfrmVariable.SubNum(ANum: Integer): Integer;
begin
  FNum := FNum-ANum;
  Result := FNum;
end;

end.
