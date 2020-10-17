unit LoopForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmLoop = class(TForm)
    edtStartNum: TEdit;
    btnOddCount: TButton;
    edtEndNum: TEdit;
    btnMul3Sum: TButton;
    Label1: TLabel;
    procedure btnOddCountClick(Sender: TObject);
    procedure btnMul3SumClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function CalcOddNumCount(AStartNum, AEndNum: Integer): Integer;
    function CalcMul3NumSum(AStartNum, AEndNum: Integer): Integer;
  end;

var
  frmLoop: TfrmLoop;

implementation

{$R *.dfm}

{ TForm3 }

procedure TfrmLoop.btnOddCountClick(Sender: TObject);
var
  StartNum, EndNum: Integer;
  Count: Integer;
begin
  StartNum := StrToIntDef(edtStartNum.Text, 0);
  EndNum   := StrToIntDef(edtEndNum.Text, 0);

  Count := CalcOddNumCount(StartNum, EndNum);

  ShowMessage(Format('�� �� ������ Ȧ���� [%d]�� �Դϴ�.', [Count]));
end;

procedure TfrmLoop.btnMul3SumClick(Sender: TObject);
var
  StartNum, EndNum: Integer;
  Sum: Integer;
begin
  StartNum := StrToIntDef(edtStartNum.Text, 0);
  EndNum   := StrToIntDef(edtEndNum.Text, 0);

  Sum := CalcMul3NumSum(StartNum, EndNum);

  ShowMessage(Format('�� �� ������ 3�� ����� ���� [%d] �Դϴ�.', [Sum]));
end;

function TfrmLoop.CalcOddNumCount(AStartNum, AEndNum: Integer): Integer;
var
  i : integer;    //
begin
  {
    TODO : AStartNum�� AEndNum ������ Ȧ���� ������ ��ȯ�մϴ�.
          Ȧ���� �Ǵ��� mod(������) �����ڸ� �̿��մϴ�.
          e.g. if Num mod 2 = 1 then
  }
  Result := 0;
  for I := AStartNum to AEndNum do
  if i mod 2 =1 then
    Inc(Result);//
end;

function TfrmLoop.CalcMul3NumSum(AStartNum, AEndNum: Integer): Integer;
begin
  {
    TODO : AStartNum�� AEndNum ������ 3�� ����� ���� ��ȯ�մϴ�.
  }
  Result := 0;
end;

end.
