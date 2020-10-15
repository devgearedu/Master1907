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
    AcceptLabel: TLabel;
    ActionList: TActionList;
    ActionManager: TActionManager;
    FileExit1: TFileExit;
    AcceptPanel_Sub1: TPanel;
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
    procedure btnCloseClick(Sender: TObject);
    procedure btnPatientListClick(Sender: TObject);
    procedure btnReservationClick(Sender: TObject);
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
  PatientListForm, ReservationForm;

procedure TfrmMain.btnCloseClick(Sender: TObject);     //����
begin
  Close;
end;

procedure TfrmMain.btnPatientListClick(Sender: TObject);  //ȯ�ڸ�� ����
begin
  if Assigned(frmSub) then            //�̹� �������� ��
  begin
    if not (frmSub is TfrmPatientList) then  //�Ҵ�� ���� �̳༮ Ÿ���� �ƴ� ��
      frmSub.Close;                          //�ݾƹ�����
  end;
  if not Assigned(frmSub) then            //�������� �ʴٸ�
    frmSub := TfrmPatientList.Create(Self); //frmSub�� �Ҵ��ض�. ������ : Self = MainForm
  frmSub.Parent := pnlMain;       // �θ𺯰� : MainForm -> pnlMain
  frmSub.BorderStyle := bsNone;
  frmSub.Align := alClient;
  frmSub.Show;
end;

procedure TfrmMain.btnReservationClick(Sender: TObject); //�������� ����
begin
  if Assigned(frmSub) then               //�̹� �������� ��
  begin
    if not (frmSub is TfrmReserve) then  //�Ҵ簪�� �̳༮�� �ƴϸ�
      frmSub.Close;                          //�ݾƶ�.
  end;
  if not Assigned(frmSub) then            //�������� �ʴٸ�.
    frmSub := TfrmReserve.Create(Self); //������ : Self = MainForm
  frmSub.Parent := pnlMain;       // �θ𺯰� : MainForm -> pnlMain
  frmSub.BorderStyle := bsNone;
  frmSub.Align := alClient;
  frmSub.Show;
end;


end.
