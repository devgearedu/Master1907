unit CalcForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TCalForm = class(TForm)
    LabelPanel: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PlsButton: TButton;
    Num0: TButton;
    Num1: TButton;
    Num2: TButton;
    Num3: TButton;
    Num4: TButton;
    Num5: TButton;
    Num6: TButton;
    Num7: TButton;
    Num8: TButton;
    Num9: TButton;
    MnsButton: TButton;
    MtpButton: TButton;
    DvsButton: TButton;
    RstLabel: TLabel;
    SaveLabel: TLabel;
    Panel5: TPanel;
    Button2: TButton;
    Button4: TButton;
    DmcButton: TButton;
    RstButton: TButton;
    Button1: TButton;
    CEButton: TButton;
    procedure NumClick(Sender: TObject);
    procedure CEClick(Sender: TObject);
    procedure OpButtonClick(Sender: TObject);
    procedure RstButtonClick(Sender: TObject);
    procedure Oprator(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CalForm: TCalForm;
  MaxLenth: Integer=10;   //���� �Է� ���� ����
  InputIndex: integer;    //�Է��� ���� ����
  InputOp: String;         //�Է��� �����ڱ�ȣ
  SaveNum: integer;        //������ �Է½� ������ �Է��ص� ����
  RstNum: integer;         //��� �Է½� ������ �Է��� ����
  x,y:string;   //�������� ����
  f:extended;   //


implementation

{$R *.dfm}                 //�������� �� ���� ��ġ��� ��ɾ�.

procedure TCalForm.CEClick(Sender: TObject);  //�ʱ�ȭ ��ư Ŭ��
begin
  RstLabel.Caption := '';
  SaveLabel.Caption := '';
  InputIndex := 0;
  InputOp := '';
end;

procedure TCalForm.NumClick(Sender: TObject);   //���� Ŭ�� ��
  begin
    try
      if InputIndex > MaxLenth then   //�Է±��� �ʰ��� ����
      begin
        raise EAbort.Create('�߰��� �Է��� �� �����ϴ�.(�Ⱥ���)');
      end;
      {if SaveLabel.Caption = '-' then
      begin
      RstLabel.Caption := '-' + (Sender as TButton).Caption;   //ó���� -Ŭ���� ���� �Է½�
      SaveLabel.Caption := '';
      InputOp := '';
      end;}

    Inc(InputIndex);         //���� �Է� ���� ����
    RstLabel.Caption := RstLabel.Caption + (Sender as TButton).Caption; //ȭ�鿡 ���� ���

    except

    end;


  end;

procedure TCalForm.OpButtonClick(Sender: TObject); //������ ��ȣ Ŭ����
begin
  if InputOp <> '' then      //������ ���� �Է� ��
  begin
    if RstLabel.Caption <> '' then
    begin
    RstButtonClick(Sender as TButton);
    Oprator(Sender as TButton);
    end;
  exit;                      //�Է� ����
  end;
  {if RstLabel.Caption = '' then      //���ڸ� �ƹ��͵� �Է����� �ʰ� ������ ��
  begin
    if InputOp = '��' then           //�ƹ��͵� ���� '-' ������ ��
    begin
    SaveLabel.Caption := '-';                 //���̺� ǥ��
    Exit;
    end;
  RstNum := 0;                       //0����
  RstLabel.Caption := '0';           //0ǥ��
  end;}
  Oprator(Sender as TButton);
end;

procedure TCalForm.RstButtonClick(Sender: TObject);   //'='������
begin
  RstNum := StrtoInt(RstLabel.Caption);
  if InputOp = '+' then
  RstLabel.Caption := InttoStr(SaveNum + RstNum);
  if InputOp = '��' then
  RstLabel.Caption := InttoStr(SaveNum - RstNum);
  if InputOp = 'X' then
  RstLabel.Caption := InttoStr(SaveNum * RstNum);
  if InputOp = '��' then
  begin
    try
      x :=InttoStr(SaveNum);
      y :=InttoStr(RstNum);
      f := strtofloat(x) / strtofloat(y);
      RstLabel.Caption := FloattoStr(f);
    except
      try
      RstLabel.Caption := InttoStr(SaveNum div RstNum);
      except
      showmessage('0���� ���� �� �����ϴ�');
      end;
    end;
  end;

  SaveLabel.Caption := '';



end;

procedure TCalForm.Oprator(Sender: TObject);
begin
 InputOp := (Sender as TButton).Caption;    //���� ��ư�� ĸ���� ����
 SaveNum := StrtoInt(RstLabel.Caption);     //ǥ��� ���ڸ� ����
 SaveLabel.Caption := InttoStr(SaveNum) + InputOp;    //��ܿ� ����� �� ǥ��
 RstLabel.Caption := '';                    //RstLabel �ʱ�ȭ
 InputIndex := 0;                           //�Է��� ���� ���� �ʱ�ȭ
end;

end.
