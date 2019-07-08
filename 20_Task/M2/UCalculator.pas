unit UCalculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Btn_Num1: TButton;
    Btn_Num2: TButton;
    Btn_Num3: TButton;
    Btn_Num4: TButton;
    Btn_Num5: TButton;
    Btn_Num6: TButton;
    Btn_Num7: TButton;
    Btn_Num8: TButton;
    Btn_Num9: TButton;
    Btn_Num0: TButton;
    Btn_Dot: TButton;
    Btn_Result: TButton;
    Btn_Sum: TButton;
    Btn_Sub: TButton;
    Btn_Mul: TButton;
    Btn_Div: TButton;
    Btn_CE: TButton;
    Btn_BackSpace: TButton;
    Edit1: TEdit;
    Panel: TPanel;
    procedure Btn_Num1Click(Sender: TObject);
    procedure Btn_SumClick(Sender: TObject);
    procedure Btn_ResultClick(Sender: TObject);
    procedure Btn_CEClick(Sender: TObject);
    procedure Btn_DotClick(Sender: TObject);
    procedure Btn_SubClick(Sender: TObject);
    function Add( Num1 , Num2 : Real) : Extended; Overload;
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);       //����

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Num1, Num2 : Real;
  Str : Integer;
  //Str(������)
  Dot_Check, Sub_Check, Oper_Check, Cal_Check: Boolean;
  //Dot_Check(.����Ŭ�� Ȯ��), Oper_Check(������ ����Ŭ��), Sub_Check(���� Ȯ��)
  Max : String;
  //Edit1.MaxLength

implementation

{$R *.dfm}
procedure TForm1.Btn_CEClick(Sender: TObject);         //��� ����
begin
  Edit1.Text := '';
  Num1 := 0;
  Num2 := 0;
  Str := 0;
  Dot_Check := False;
  Sub_Check := False;
  Max := '';
end;

procedure TForm1.Btn_DotClick(Sender: TObject);
begin
  if (Edit1.Text = '') Or (Edit1.Text = '-') then      //(Erroró��) ���� ���� "." Ŭ��
    begin
      ShowMessage('���ڸ� ���� �Է��ϼ���.');
      Exit;
    end;
  if Dot_Check = False then                            //(Erroró��) "." ����Ŭ��
    begin
      Edit1.Text := Edit1.Text + (Sender as TButton).Caption;
      Dot_Check := True;
    end
  else
    Showmessage('. �� 1���� �Է��ϼ���.');
end;

procedure TForm1.Btn_Num1Click(Sender: TObject);
begin
  if Max = '1111111111' then                           //Edit1.MaxLength
    begin
      ShowMessage('�Է¹����� �ʰ��Ͽ����ϴ�.');
      Exit;
    end;

  if Cal_Check then                                    // " = " ���� ���� �Է�
    begin
      Edit1.Text := '';
      Cal_Check := False;
    end;
  Edit1.Text := Edit1.Text + (Sender as TButton).Caption;         //���� �Է�
  Oper_Check := False;                                            //(Erroró��)������ 2��Ŭ����

  Max := Max + '1';                                    //Edit1.MaxLength
  Edit1.SetFocus;
end;

procedure TForm1.Btn_ResultClick(Sender: TObject);     //���
begin
  try
    Num1 := StrToFloat(Edit1.Text);                    //ù���� ����
    if Str <> 0 then
      begin
        Num2 := (Add(Num1, Num2));                     //��� �Լ� ȣ��
        Edit1.Text := FloatToStr(Num2);
        Num1 := 0;
        Str := 0;
        Cal_Check := True;
      end;

    Dot_Check := False;                                //�Ҽ��� Ȯ��
    Sub_Check := False;                                //���� Ȯ��
    Max := '';                                         //Edit1.MaxLength
  except
    if (Edit1.Text = '') And (Num1 = 0) And (Num2 = 0) then       //(Erroró��) ���� ���� = �Է½�
      begin
        Showmessage('���ڸ� �Է��ϼ���');
        Exit;
      end;

    if (Num1 = 0) And (Str = 99) then                             //(Erroró��) 12 / 0 =
      begin
        ShowMessage('0�� ������ �����ϴ�.');
        Btn_CEClick(Sender);
        Exit;
      end;

  end;

end;

procedure TForm1.Btn_SubClick(Sender: TObject);
begin
  if Edit1.Text = '-' then                             //"-" ���� 2�� �Է½�
    begin
      ShowMessage('���ڸ� �Է��ϼ���');
      Exit;
    end;

  if (Edit1.Text <> '')then                            //���� �Է�
    begin
      Btn_SumClick(Sender);
      Exit;
    end;

  if Sub_Check = False then                            //���� �Է�
    begin
      Edit1.Text := Edit1.Text + (Sender as TButton).Caption;
      Sub_Check := True;
    end
  else
    begin
      Showmessage('- �� 1���� �Է��ϼ���.');           //(Erroró��) "-" ����Ŭ��
      Exit;
    end
end;

procedure TForm1.Btn_SumClick(Sender: TObject);        //������ Ŭ��
begin
  try
    if Oper_Check then                                 //(Erroró��) ������ ����Ŭ��
      begin
        ShowMessage('�����ڴ� �ѹ��� �Է� �����մϴ�.');
        Num2 := 0;
        Exit;
      end;

    if Num1 = 0 then
      begin
        Btn_ResultClick(Sender);                       //Btn_Result.Click <> Btn_ResultClick(Sender) �ٸ�!!!
        case (Sender as TButton).tag of                //������ ��ȣ����                                         ////////////////////////////////////////
          11 : Str := 96;
          12 : Str := 97;
          13 : Str := 98;
          14 : Str := 99;
        end;

      end;
    Num1 := StrToFloat(Edit1.Text);
    Num2 := Num1;                                      //ó�� �������� �ι�° ������ �̵�
    Num1 := 0;                                         //ó�� ������ ����
    Edit1.Text := '';                                  //���� ���� �Է� ����

    Dot_Check := False;                                //�Ҽ���
    Sub_Check := False;                                //����
    Oper_Check := True;                                //������ 2��Ŭ��
    Max := '';                                         //Edit1.MaxLength
  except
  end;

end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if (Key < #96) or (Key > #111) or (Key = #8)
//   or (Key = #13) then                 //���ڸ� �Է� ����
//   begin
    case Key of
//      vk_Back : Btn_CE.OnClick( Sender as TWincontrol);
      vk_Return : Btn_Result.OnClick( Sender as TWincontrol);
//      vk_32 : Btn_Num0.OnClick( Sender as TWincontrol);
//      vk_1 : Btn_Num1.OnClick( Sender as TWincontrol);
//      vk_32 : Btn_Num2.OnClick( Sender as TWincontrol);
//      33 : Btn_Num3.OnClick( Sender as TWincontrol);
//      34 : Btn_Num4.OnClick( Sender as TWincontrol);
//      35 : Btn_Num5.OnClick( Sender as TWincontrol);
//      36 : Btn_Num6.OnClick( Sender as TWincontrol);
//      37 : Btn_Num7.OnClick( Sender as TWincontrol);
//      38 : Btn_Num8.OnClick( Sender as TWincontrol);
//      39 : Btn_Num9.OnClick( Sender as TWincontrol);
//      VK_ADD : Btn_Sum.OnClick( Sender as TWincontrol);
//      VK_SUBTRACT : Btn_Sub.OnClick( Sender as TWincontrol);
//      VK_MULTIPLY : Btn_Mul.OnClick( Sender as TWincontrol);
//      VK_DECIMAL : Btn_Dot.OnClick( Sender as TWincontrol);
//      VK_DIVIDE : Btn_Div.OnClick( Sender as TWincontrol);
    end;
end;

function TForm1.Add(Num1, Num2: Real ) : Extended;   //��� �Լ�
begin
  case Str of
    96 : result := Num2 + Num1;                      //������ ���ϱ�
    97 : result := Num2 - Num1;                      //������ �����
    98 : result := Num2 * Num1;                      //������ ���ϱ�
    99 : result := Num2 / Num1;                      //�Ǽ��� ������
  end;

end;

end.
