unit MainClientForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.ActnMenus, Vcl.Menus, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.StdActns, Vcl.DBCtrls,
  System.ImageList, Vcl.ImgList;

type
  TfrmMain = class(TForm)
    ToolBarPanel: TPanel;
    AcceptPanel: TPanel;
    ActionMenuBar: TActionMainMenuBar;
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
    procedure btnCloseClick(Sender: TObject);
    procedure btnPatientListClick(Sender: TObject);
    procedure btnReservationClick(Sender: TObject);
    procedure btnMedicineClick(Sender: TObject);
    procedure btnDiagnosisClick(Sender: TObject);
    procedure btnDoctorClick(Sender: TObject);
    procedure btnAcceptClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnOutputClick(Sender: TObject);
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
    dm.Reserve.Edit;
    dm.Reserve.FieldByName('NOWSTATE').AsInteger := 0;
    dm.Reserve.Post;
    dm.Reserve.ApplyUpdates(-1);
    dm.Reserve.Refresh;
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


end.
