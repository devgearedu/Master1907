<<<<<<< HEAD
unit ����;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Menus;

type
  TForm1 = class(TForm)
    GridPanel1: TGridPanel;
    num7: TButton;
    num8: TButton;
    num9: TButton;
    divide: TButton;
    num4: TButton;
    num5: TButton;
    num6: TButton;
    tbutton14: TButton;
    num1: TButton;
    num2: TButton;
    num3: TButton;
    sub: TButton;
    num0: TButton;
    num00: TButton;
    dot: TButton;
    add: TButton;
    ToolBar1: TToolBar;
    result: TButton;
    clear: TButton;
    delete: TButton;
    Edit1: TEdit;

    Procedure FormCreat(Sender: TObject);
    Procedure NumButtonClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  tag: integer;
  calvar1: string;
  calvar2: string;                //���� or ������ ����
  calvar3: string;                //operand1 �ʱ��Է°�, ������ ��ﰪ
  calvar4: real;                  //�����
  calvar5: integer;               //������ ����
  calvar6: string;                //operand2

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.numbuttonclick(sender: Tobject);
begin
  tag := (sender as TButton).Tag;
  begin

  case tag of
  20:
      begin
        if pos('.', Edit1.Text) = 0 then        //���� �ϳ���
          Edit1.Text := Edit1.Text +'.';
      end;

  21:
      begin
        edit1.Text := '0';    //clear
        calvar2 := '0';
        calvar3 := '';
        calvar4 := 0;
        calvar6 := '';
      end;

  22:
      begin
        edit1.text := copy(edit1.text, 1, length(edit1.Text)-1);   // backspace
        if length(edit1.Text)=0 then
          edit1.Text :='0';
      end
  end;
  end;

  if tag<19 then
  begin
      if (tag >=0) and (tag <11) then       // ���� ��ư(0~11) 0, ������(12~18) 1
        calvar1 := '0';

      if (tag >=11) and (tag <19) then
        calvar1 := '1';

      calvar2 := calvar2 + calvar1;

      if length(edit1.Text) >10 then      //�Է¹��� 10��
        showmessage('�Է¹����ʰ�');

      if (calvar2 = '00') or (calvar2 = '0') then         //'00' : clear, '0' �����Է�, operand1
        begin
          edit1.Text := '';
          calvar2 :='0';
          edit1.Text := edit1.Text + floattostr((sender as tbutton).Tag); //floattostr : �ε��Ҽ����� ���ڿ��� ��ȯ�ϴ� �Լ�
          calvar3 := edit1.Text;
          calvar4 := 0;
        end;

      if calvar2 = '01' then                                  //������ �Է�
        begin
          calvar5 := tag;
          edit1.Text := '';
        end;

      if (calvar2 = '010') or (calvar2 = '0100') then         //operand2 ����
        begin
          calvar2 := '010';
          calvar6 := calvar6 + floattostr(tag);
          edit1.text := calvar6;
        end;

      if (calvar2 = '0101') then                             //������ �Է�, '=' �Է�
        begin                                                //'0101' : 'ó���Է�, �������Է�, �ι�°~�Է�, = ��ư or �߰�������'
          calvar2 := '01';                                   //           0           1          0                   1
          case calvar5 of
           17 :
           begin
             try
              calvar4 := strtofloat(calvar3) / strtofloat(calvar6);
              except on e:EMathError do
              showmessage('0���� ���� �� �����ϴ�.');
             end;
           end;
           14 : calvar4 := strtofloat(calvar3) + strtofloat(calvar6);
           15 : calvar4 := strtofloat(calvar3) - strtofloat(calvar6);
           16 : calvar4 := strtofloat(calvar3) * strtofloat(calvar6);
          end;

          if tag = 18 then                      //����� ���
           begin
            edit1.Text := floattostr(calvar4);
            calvar2 := '010';                   //117������ ���ư��� ������ �غ�
           end;

          calvar6 := '';
          edit1.Text := floattostr(calvar4);
          calvar3 := floattostr(calvar4);       // ����� ����
          calvar5 := tag;
        end;

      if (calvar2 = '1') or (calvar2 = '011') then
        begin
          calvar2 := '0';
          if tag = 15 then
            edit1.Text := '-'
          else
            showmessage('�߸��� �Է��Դϴ�.')
        end;
  end;
end;


procedure TForm1.FormCreat(Sender: TObject);
begin
  edit1.Text := '';
end;


end.
=======
unit ����;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Menus;

type
  TForm1 = class(TForm)
    GridPanel1: TGridPanel;
    num7: TButton;
    num8: TButton;
    num9: TButton;
    divide: TButton;
    num4: TButton;
    num5: TButton;
    num6: TButton;
    tbutton14: TButton;
    num1: TButton;
    num2: TButton;
    num3: TButton;
    sub: TButton;
    num0: TButton;
    num00: TButton;
    dot: TButton;
    add: TButton;
    ToolBar1: TToolBar;
    result: TButton;
    clear: TButton;
    delete: TButton;
    Edit1: TEdit;

    Procedure FormCreat(Sender: TObject);
    Procedure NumButtonClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  tag: integer;
  calvar1: string;
  calvar2: string;                //���� or ������ ����
  calvar3: string;                //operand1 �ʱ��Է°�, ������ ��ﰪ
  calvar4: real;                  //�����
  calvar5: integer;               //������ ����
  calvar6: string;                //operand2

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.numbuttonclick(sender: Tobject);
begin
  tag := (sender as TButton).Tag;
  begin

  case tag of
  20:
      begin
        if pos('.', Edit1.Text) = 0 then        //���� �ϳ���
          Edit1.Text := Edit1.Text +'.';
      end;

  21:
      begin
        edit1.Text := '0';    //clear
        calvar2 := '0';
        calvar3 := '';
        calvar4 := 0;
        calvar6 := '';
      end;

  22:
      begin
        edit1.text := copy(edit1.text, 1, length(edit1.Text)-1);   // backspace
        if length(edit1.Text)=0 then
          edit1.Text :='0';
      end
  end;
  end;

  if tag<19 then
  begin
      if (tag >=0) and (tag <11) then       // ���� ��ư(0~11) 0, ������(12~18) 1
        calvar1 := '0';

      if (tag >=11) and (tag <19) then
        calvar1 := '1';

      calvar2 := calvar2 + calvar1;

      if length(edit1.Text) >10 then      //�Է¹��� 10��
        showmessage('�Է¹����ʰ�');

      if (calvar2 = '00') or (calvar2 = '0') then         //'00' : clear, '0' �����Է�, operand1
        begin
          edit1.Text := '';
          calvar2 :='0';
          edit1.Text := edit1.Text + floattostr((sender as tbutton).Tag); //floattostr : �ε��Ҽ����� ���ڿ��� ��ȯ�ϴ� �Լ�
          calvar3 := edit1.Text;
          calvar4 := 0;
        end;

      if calvar2 = '01' then                                  //������ �Է�
        begin
          calvar5 := tag;
          edit1.Text := '';
        end;

      if (calvar2 = '010') or (calvar2 = '0100') then         //operand2 ����
        begin
          calvar2 := '010';
          calvar6 := calvar6 + floattostr(tag);
          edit1.text := calvar6;
        end;

      if (calvar2 = '0101') then                             //������ �Է�, '=' �Է�
        begin                                                //'0101' : 'ó���Է�, �������Է�, �ι�°~�Է�, = ��ư or �߰�������'
          calvar2 := '01';                                   //           0           1          0                   1
          case calvar5 of
           17 :
           begin
             try
              calvar4 := strtofloat(calvar3) / strtofloat(calvar6);
              except on e:EMathError do
              showmessage('0���� ���� �� �����ϴ�.');
             end;
           end;
           14 : calvar4 := strtofloat(calvar3) + strtofloat(calvar6);
           15 : calvar4 := strtofloat(calvar3) - strtofloat(calvar6);
           16 : calvar4 := strtofloat(calvar3) * strtofloat(calvar6);
          end;

          if tag = 18 then                      //����� ���
           begin
            edit1.Text := floattostr(calvar4);
            calvar2 := '010';                   //117������ ���ư��� ������ �غ�
           end;

          calvar6 := '';
          edit1.Text := floattostr(calvar4);
          calvar3 := floattostr(calvar4);       // ����� ����
          calvar5 := tag;
        end;

      if (calvar2 = '1') or (calvar2 = '011') then
        begin
          calvar2 := '0';
          if tag = 15 then
            edit1.Text := '-'
          else
            showmessage('�߸��� �Է��Դϴ�.')
        end;
  end;
end;


procedure TForm1.FormCreat(Sender: TObject);
begin
  edit1.Text := '';
end;


end.
>>>>>>> ea544203bcbbc8ff04b6fd585b9049812dbf02e4
