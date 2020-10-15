unit DecisionForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, System.ImageList,
  Vcl.ImgList;

type
  TfrmDecision = class(TForm)
    pnlClient: TPanel;
    pnlHeader: TPanel;
    Label1: TLabel;
    pnlMain: TPanel;
    pnlLeft: TPanel;
    grdDuring: TDBGrid;
    pnlGridHeader: TPanel;
    pnlGridFooter: TPanel;
    SplitterLeft: TSplitter;
    pnlMainSub: TPanel;
    pnlMiddle: TPanel;
    pnlRight: TPanel;
    SplitterRight: TSplitter;
    pnlBottom: TPanel;
    pnlMiddleHeader: TPanel;
    pnlMiddleHeaderSub: TPanel;
    pnlMiddleMedicine: TPanel;
    Splitter1: TSplitter;
    btnDecision: TButton;
    btnCancel: TButton;
    Label3: TLabel;
    btnDelete: TButton;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    DBMemo1: TDBMemo;
    pnlMiddleMedicineHeader: TPanel;
    Label5: TLabel;
    edtSearch: TEdit;
    grdMedicineList: TDBGrid;
    grdDecision: TDBGrid;
    ilDecision: TImageList;
    btnClose: TButton;
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRefreshClick(Sender: TObject);
    procedure grdMedicineListDblClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDecisionClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDecision: TfrmDecision;

implementation

{$R *.dfm}

uses PatientManagerDataModule, MainClientForm;

procedure TfrmDecision.btnCancelClick(Sender: TObject);
begin
  dm.Decision.Cancel;
end;

procedure TfrmDecision.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDecision.btnDecisionClick(Sender: TObject); //ó���ϱ� Ŭ����
begin
  if (dm.Decision.State = dsInsert) or (dm.Decision.State = dsEdit) then
  begin
    dm.Decision.FieldByName('PRICE').AsInteger := dm.Decision.FieldByName('PRICE_CALC').AsInteger; //���� �ݾ� PRICE�� �ֱ�
    dm.Decision.Post;                           //ó�泻�� DB�� �ֱ�
    dm.Decision.ApplyUpdates(-1);
    dm.Decision.Refresh;
  end;

  dm.Reserve.Edit;
  dm.Reserve.FieldByName('NOWSTATE').AsInteger := 30; //������� ���������� ����
  dm.Reserve.Post;
  dm.Reserve.ApplyUpdates(-1);
//  dm.Reserve.Refresh;
  dm.During.Refresh;       //����ȯ�� Refresh
//  showmessage('ó�� �Ϸ�!');
end;

procedure TfrmDecision.btnRefreshClick(Sender: TObject);
begin
  dm.During.Refresh;
end;

procedure TfrmDecision.Button1Click(Sender: TObject);
begin
  dm.Decision.Delete;
  dm.Decision.ApplyUpdates(-1);
  dm.Decision.Refresh;
end;

procedure TfrmDecision.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmDecision := nil;
end;

procedure TfrmDecision.FormShow(Sender: TObject);
begin
  try
    begin
      dm.During.Refresh;
    end;
  except
    showmessage('���� ���� ���¸� Ȯ�����ּ���!');
  end;
end;

procedure TfrmDecision.grdMedicineListDblClick(Sender: TObject);    //ó���� ��ǰ ����Ŭ���� grdDecision�� ���� �Է�.
begin
  if dm.Decision.FieldByName('MEDICINE_SEQ').AsInteger = dm.MedicineList.FieldByName('MEDICINE_SEQ').AsInteger then
    begin                               //�̹� ó���ǰ�� ������ ���� �߰�
      dm.Decision.Edit;
      dm.Decision.FieldByName('ACCEPT_AMOUNT').AsInteger := dm.Decision.FieldByName('ACCEPT_MOUNT').AsInteger + 1;
    end
  else
    dm.Decision.Insert;                 //��ǰ ó�� �߰��� �� �־��ֱ�
  dm.Decision.FieldByName('MEDICINE_SEQ').AsInteger := dm.MedicineList.FieldByName('MEDICINE_SEQ').AsInteger;
  dm.Decision.FieldByName('RESERVE_NAME').AsString := dm.Reserve.FieldByName('PATIENT_NAME').AsString;
  dm.Decision.FieldByName('RESERVE_SEQ').AsInteger := dm.During.FieldByName('RESERVE_SEQ').AsInteger;
end;

end.
