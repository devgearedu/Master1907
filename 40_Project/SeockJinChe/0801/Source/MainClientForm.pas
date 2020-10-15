unit MainClientForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.ActnMenus, Vcl.Menus, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.StdActns, Vcl.DBCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Themes;

type
  TfrmMain = class(TForm)
    ToolBarPanel: TPanel;
    AcceptPanel: TPanel;
    AcceptGrid: TDBGrid;
    ActionList: TActionList;
    ActionManager: TActionManager;
    FileExit1: TFileExit;
    pnlAcceptButton: TPanel;
    btnAccept: TButton;
    btnOutput: TButton;
    btnRefresh: TButton;
    pnlMain: TPanel;
    ilToolbar: TImageList;
    ToolBar: TToolBar;
    btnPatientList: TToolButton;
    btnReservation: TToolButton;
    btnDiagnosis: TToolButton;
    btnMessage: TToolButton;
    btnMedicine: TToolButton;
    btnDoctor: TToolButton;
    ToolButton1: TToolButton;
    btnClose: TButton;
    ImageList: TImageList;
    pnlAcceptHeader: TPanel;
    Label1: TLabel;
    Action1: TAction;
    Action2: TAction;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N2: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    EmeralLightSlate1: TMenuItem;
    CyanNight1: TMenuItem;
    MetropolisUIGreen1: TMenuItem;
    OnyxBlue1: TMenuItem;
    RubiGraphite1: TMenuItem;
    SkyDefalt1: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    Infomaion1: TMenuItem;
    windows1: TMenuItem;
    procedure btnCloseClick(Sender: TObject);
    procedure btnPatientListClick(Sender: TObject);
    procedure btnReservationClick(Sender: TObject);
    procedure btnMedicineClick(Sender: TObject);
    procedure btnDiagnosisClick(Sender: TObject);
    procedure btnDoctorClick(Sender: TObject);
    procedure btnAcceptClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnOutputClick(Sender: TObject);
    procedure Infomaion1Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure EmeralLightSlate1Click(Sender: TObject);
    procedure CyanNight1Click(Sender: TObject);
    procedure MetropolisUIGreen1Click(Sender: TObject);
    procedure OnyxBlue1Click(Sender: TObject);
    procedure RubiGraphite1Click(Sender: TObject);
    procedure SkyDefalt1Click(Sender: TObject);
    procedure windows1Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  frmSub: TForm;                            // ���� ���� �����Ǵ� ������

implementation

{$R *.dfm}

uses PatientManagerDataModule, DiagnosisForm, MedicineForm, MessageForm,
  PatientListForm, ReservationForm, DecisionForm;

procedure TfrmMain.btnAcceptClick(Sender: TObject);
begin
  if MessageDlg('�����Ͻðڽ��ϱ�?', MTConfirmation, [mbYes, mbno], 0) = mrYes  then
  begin
    AcceptGrid.SetFocus;
    dm.Accept.Edit;
    dm.Accept.FieldByName('NOWSTATE').AsInteger := 0;
    dm.Accept.Post;
    dm.Accept.ApplyUpdates(-1);
    dm.Accept.Refresh;
  end;

end;

procedure TfrmMain.btnCloseClick(Sender: TObject);     //����
begin
  Close;
end;

procedure TfrmMain.btnDiagnosisClick(Sender: TObject);  //���᳻�� ����
begin
  if Assigned(frmSub) then            //�̹� �������� ��
  begin
    if not (frmSub is TfrmDiagnosis) then  //�Ҵ�� ���� �̳༮ Ÿ���� �ƴ� ��
      frmSub.Close;                          //�ݾƹ�����
  end;
  if not Assigned(frmSub) then            //�������� �ʴٸ�
    frmSub := TfrmDiagnosis.Create(frmSub); //frmSub�� �Ҵ��ض�. ������ : Self = MainForm
  frmSub.Parent := pnlMain;       // �θ𺯰� : MainForm -> pnlMain
  frmSub.BorderStyle := bsNone;
  frmSub.Align := alClient;
  frmSub.Show;
end;

procedure TfrmMain.btnDoctorClick(Sender: TObject);   //�ǻ� ���� ȭ�� ����
begin
  if not Assigned(frmDecision) then            //�������� �ʴٸ�
    frmDecision := TfrmDecision.Create(frmDecision); //frmSub�� �Ҵ��ض�. ������ frmDecision (Self�ϋ� frmMain)
  frmDecision.WindowState := wsMaximized;
  frmDecision.Show;
end;

procedure TfrmMain.btnMedicineClick(Sender: TObject); //��ǰ��� ����
begin
  if Assigned(frmSub) then            //�̹� �������� ��
  begin
    if not (frmSub is TfrmMedicine) then  //�Ҵ�� ���� �̳༮ Ÿ���� �ƴ� ��
      frmSub.Close;                          //�ݾƹ�����
  end;
  if not Assigned(frmSub) then            //�������� �ʴٸ�
    frmSub := TfrmMedicine.Create(frmSub); //frmSub�� �Ҵ��ض�. ������ frmSub
  frmSub.Parent := pnlMain;       // �θ𺯰� : MainForm -> pnlMain
  frmSub.BorderStyle := bsNone;
  frmSub.Align := alClient;
  frmSub.Show;
end;

procedure TfrmMain.btnOutputClick(Sender: TObject);
begin
  if MessageDlg('����Ͻðڽ��ϱ�?', MTConfirmation, [mbYes, mbno], 0) = mrYes  then
    showMessage('��¿Ϸ�!');
end;

procedure TfrmMain.btnPatientListClick(Sender: TObject);  //ȯ�ڸ�� ����
begin
  if Assigned(frmSub) then            //�̹� �������� ��
  begin
    if not (frmSub is TfrmPatientList) then  //�Ҵ�� ���� �̳༮ Ÿ���� �ƴ� ��
      frmSub.Close;                          //�ݾƹ�����
  end;
  if not Assigned(frmSub) then            //�������� �ʴٸ�
    frmSub := TfrmPatientList.Create(frmSub); //frmSub�� �Ҵ��ض�. ������ frmSub
  frmSub.Parent := pnlMain;       // �θ𺯰� : MainForm -> pnlMain
  frmSub.BorderStyle := bsNone;
  frmSub.Align := alClient;
  frmSub.Show;
end;

procedure TfrmMain.btnRefreshClick(Sender: TObject);
begin
  dm.Accept.Refresh;
end;

procedure TfrmMain.btnReservationClick(Sender: TObject); //�������� ����
begin
  if Assigned(frmSub) then               //�̹� �������� ��
  begin
    if not (frmSub is TfrmReserve) then  //�Ҵ簪�� �̳༮�� �ƴϸ�
      frmSub.Close;                          //�ݾƶ�.
  end;
  if not Assigned(frmSub) then            //�������� �ʴٸ�.
    frmSub := TfrmReserve.Create(frmSub); //������ frmSub
  frmSub.Parent := pnlMain;       // �θ𺯰� : MainForm -> pnlMain
  frmSub.BorderStyle := bsNone;
  frmSub.Align := alClient;
  frmSub.Show;
end;


procedure TfrmMain.CyanNight1Click(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Cyan Night');
end;

procedure TfrmMain.EmeralLightSlate1Click(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Emerald Light Slate');
end;

procedure TfrmMain.Infomaion1Click(Sender: TObject);
begin
  showmessage('������ : �ּ���');
end;

procedure TfrmMain.MetropolisUIGreen1Click(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Metropolis UI Green');
end;

procedure TfrmMain.N5Click(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.N8Click(Sender: TObject);
begin
  frmMain.WindowState := wsMaximized;
end;

procedure TfrmMain.N9Click(Sender: TObject);
begin
  frmMain.WindowState := wsMinimized;
end;

procedure TfrmMain.OnyxBlue1Click(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Onyx Blue');
end;

procedure TfrmMain.RubiGraphite1Click(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Ruby Graphite');
end;

procedure TfrmMain.SkyDefalt1Click(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Sky');
end;

procedure TfrmMain.windows1Click(Sender: TObject);
begin
  TStyleManager.TrySetStyle('Windows10');
end;

end.
