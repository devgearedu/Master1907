unit MobileReserveForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, Data.DB,
  Datasnap.DBClient, Data.Bind.EngExt, Fmx.Bind.DBEngExt, FMX.Objects,
  FMX.TabControl, Data.Bind.Components, FMX.ListBox, FMX.MultiView,
  System.Actions, FMX.ActnList, FMX.Gestures, FMX.Ani, FMX.Edit,
  Data.DbxDatasnap, Data.DBXCommon, IPPeerClient, Data.SqlExpr,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.DateTimeCtrls, FMX.ListView, Datasnap.Provider, Datasnap.DSConnect,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.DBScope,
  FMX.ComboEdit
  {$IFDEF ANDROID}
  , Androidapi.Helpers
  , Androidapi.JNI.JavaTypes
  , Androidapi.JNI.Os
  {$ENDIF};


type
  TfrmMain = class(TForm)
    lyoClient: TLayout;
    sbReserve: TStyleBook;
    BindingsList1: TBindingsList;
    ctrlMain: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    MultiView: TMultiView;
    ListBox: TListBox;
    tbSub: TToolBar;
    Button1: TButton;
    Label1: TLabel;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    TabItem4: TTabItem;
    TabItem5: TTabItem;
    tbMain: TToolBar;
    lbHeader: TLabel;
    btnMaster: TButton;
    Layout1: TLayout;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    cbDocotorSelect: TCheckBox;
    btnReserve: TButton;
    btnClear: TButton;
    lvWaitList: TListView;
    Label10: TLabel;
    dbReserveDate: TDateEdit;
    Label5: TLabel;
    Label6: TLabel;
    dbReserveTime: TTimeEdit;
    ImageControl1: TImageControl;
    BitmapAnimation1: TBitmapAnimation;
    BindSourceDB1: TBindSourceDB;
    BindSourceDB2: TBindSourceDB;
    Label7: TLabel;
    edtName: TEdit;
    pnlLogin: TPanel;
    btnLogin: TButton;
    btnSignUp: TButton;
    LinkFillControlToField1: TLinkFillControlToField;
    TabItem3_2: TTabItem;
    lvReserveList: TListView;
    edtDate: TEdit;
    edtTime: TEdit;
    edtDoctor: TEdit;
    ImageControl2: TImageControl;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    LinkControlToField4: TLinkControlToField;
    lbRst: TLabel;
    ListBoxItem6: TListBoxItem;
    LinkListControlToField1: TLinkListControlToField;
    ChangeTabAction1: TChangeTabAction;
    btnBack: TButton;
    Layout2: TLayout;
    btnDelete: TButton;
    BindSourceDB3: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    Timer1: TTimer;
    procedure ListBoxItem1Click(Sender: TObject);
    procedure btnMasterClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure ListBoxItem4Click(Sender: TObject);
    procedure ListBoxItem5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnReserveClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnSignUpClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure ListBoxItem6Click(Sender: TObject);
    procedure lvReserveListButtonClick(const Sender: TObject;
      const AItem: TListItem; const AObject: TListItemSimpleControl);
    procedure lvReserveListItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnBackClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  TextCheck: Boolean;
implementation

uses SignUpForm, MobileDataModule, LoginForm, FMain;
//{$IFDEF ANDROID}
//  Androidapi.Helpers,
//  Androidapi.JNI.JavaTypes,
//  Androidapi.JNI.Os,
//{$ENDIF}
{$R *.fmx}
//{$R *.LgXhdpiTb.fmx ANDROID}

procedure TfrmMain.btnBackClick(Sender: TObject);
begin
  ChangeTabAction1.Tab := TabItem3;
  ChangeTabAction1.ExecuteTarget(nil);
  btnBack.Visible := False;
end;

procedure TfrmMain.btnClearClick(Sender: TObject);
begin
  DataModule1.CancelItem; // �Է�/���� ��� ���
  ctrlMain.ActiveTab.TabControl.TabIndex := 0;
  lbHeader.Text := '����ȭ��';
end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
begin
  DataModule1.DeleteItem;
  DataModule1.UserReserve.Refresh;
  ChangeTabAction1.Tab := TabItem3;
end;

procedure TfrmMain.btnLoginClick(Sender: TObject);
begin
  frmLogin := TfrmLogin.Create(self);
  frmLogin.Show;
end;

procedure TfrmMain.btnMasterClick(Sender: TObject);
begin
  Multiview.Mode := TMultiviewMode.Drawer;
  Multiview.ShowMaster;  //��Ƽ�� ���̱�
end;

procedure TfrmMain.btnReserveClick(Sender: TObject);
begin
  if edtName.Text = '' then
   exit;
  DataModule1.AppendMode; // �Է� ���� ����
  DataModule1.UserReserve.FieldByName('PATIENT_SEQ').AsInteger := UserSEQ; //ȯ�ڹ�ȣ �ֱ�
  DataModule1.UserReserve.FieldByName('DOCTOR_SEQ').AsInteger := 1; //����ǻ� �־��ֱ�
  DataModule1.UserReserve.FieldByName('RESERVATION_DATE').AsDateTime := dbReserveDate.Date;//������ ��¥�� ����
  DataModule1.UserReserve.FieldByName('RESERVATION_TIME').AsDateTime := dbReserveTime.Time;//������ �ð����� ����
  DataModule1.UserReserve.FieldByName('NOWSTATE').AsInteger := 10;

  DataModule1.SaveItem; // �����׸� ����
  ctrlMain.ActiveTab.TabControl.TabIndex := 0;
  lbHeader.Text := '����ȭ��';

  lbRst.Text := '����Ϸ�!';
end;

procedure TfrmMain.btnSignUpClick(Sender: TObject);
begin
  frmSignUp := TfrmSignUp.Create(Self);
  frmSignUp.Show;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  Multiview.HideMaster;   //��Ƽ�� �����
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  ctrlMain.TabPosition := TTabPosition.None;
  ctrlMain.ActiveTab.TabControl.TabIndex := 0;

  DataModule1.Connect; // �����ͺ��̽� ����

  dbReserveTime.Time := now;    //����ð� �⺻��

//  Rectangle1.Fill.Color := $FFFAAC58;
//  Rectangle3.Fill.Color := $FFFAAC58;
//  Rectangle5.Fill.Color := $FFFAAC58;
//  Rectangle7.Fill.Color := $FFFAAC58;
//
//  Rectangle2.Fill.Color := $FFFBF8EF;
//  Rectangle4.Fill.Color := $FFFBF8EF;
//  Rectangle6.Fill.Color := $FFFBF8EF;

end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
{$IFDEF ANDROID}
  if Key = vkHardwareBack then
  begin
    { Show a multiple-button alert that triggers different code blocks according to
       your input }
    MessageDlg('���� �����ϰڽ��ϱ�?', System.UITypes.TMsgDlgType.mtInformation,
      [
        System.UITypes.TMsgDlgBtn.mbYes,
        System.UITypes.TMsgDlgBtn.mbNo
        //System.UITypes.TMsgDlgBtn.mbCancel
      ], 0,
      procedure (const AResult: TModalResult)
      begin
        if AResult = mrYes then SharedActivity.finish;
      end
      );

      Key := 0;
  end;
{$ENDIF}
end;

procedure TfrmMain.ListBoxItem1Click(Sender: TObject);
begin
  ctrlMain.ActiveTab.TabControl.TabIndex := 0; //��Ƽ���� ����,  ����ȭ��(TabItem1)
  Multiview.HideMaster;
  lbHeader.Text := '����ȭ��';
  Timer1.Enabled := False;
end;

procedure TfrmMain.ListBoxItem2Click(Sender: TObject);
begin
  ctrlMain.ActiveTab.TabControl.TabIndex := 1; //��Ƽ���� ����,  �����ϱ�(TabItem2)
  Multiview.HideMaster;
  lbHeader.Text := '�����ϱ�';
  Timer1.Enabled := False;
end;

procedure TfrmMain.ListBoxItem3Click(Sender: TObject);
begin
  ctrlMain.ActiveTab.TabControl.TabIndex := 2; //��Ƽ���� ����,  ����Ȯ��(TabItem3)
  Multiview.HideMaster;
  lbHeader.Text := '����Ȯ��';
  Timer1.Enabled := False;
end;

procedure TfrmMain.ListBoxItem4Click(Sender: TObject);
begin
  ctrlMain.ActiveTab.TabControl.TabIndex := 3; //��Ƽ���� ����,  ������(TabItem4)
  Multiview.HideMaster;
  lbHeader.Text := '����Ȯ��';
  Timer1.Enabled := False;
end;

procedure TfrmMain.ListBoxItem5Click(Sender: TObject);
begin
  ctrlMain.ActiveTab.TabControl.TabIndex := 4; //��Ƽ���� ����,  ������Ȯ��(TabItem5)
  Multiview.HideMaster;
  lbHeader.Text := '������Ȯ��';
  if Timer1.Enabled = False then
    Timer1.Enabled := True;
end;

procedure TfrmMain.ListBoxItem6Click(Sender: TObject);
begin
  ctrlMain.ActiveTab.TabControl.TabIndex := 5; //��Ƽ���� ����,  ������(TabItem6)
  Multiview.HideMaster;
  lbHeader.Text := '������';
  Timer1.Enabled := False;
end;

procedure TfrmMain.lvReserveListButtonClick(const Sender: TObject;
  const AItem: TListItem; const AObject: TListItemSimpleControl);
begin
  ctrlMain.ActiveTab.TabControl.TabIndex := 3; //��������
end;

procedure TfrmMain.lvReserveListItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  ChangeTabAction1.Tab := TabItem3_2;
  ChangeTabAction1.ExecuteTarget(nil);
  btnBack.Visible := True;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  try
  DataModule1.UserReserve.Refresh;
  DataModule1.WaitList.Refresh;
  if DataModule1.UserReserve.FieldByName('NOWSTATE').AsInteger = 20 then
  begin
    if not (TextCheck = True) then
    begin
      FormMain.Memo.Lines.Add(UserName);
      FormMain.Memo.Lines.Add(' ��, �������ֽʽÿ�.');
      TextCheck := True;
    end;
//    FormMain.ButtonSpeak.OnClick(Sender: TObject);
  end;
    //TTS��� ����.
  Except
    raise Exception.Create('���� ���� ���� Ȯ��!');
  end;
end;

end.
