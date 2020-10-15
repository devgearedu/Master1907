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
    btnDecisionDelete: TButton;
    btnRefresh: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRefreshClick(Sender: TObject);
    procedure grdMedicineListDblClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDecisionClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDecisionDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDecision: TfrmDecision;

implementation

{$R *.dfm}

uses PatientManagerDataModule, MainClientForm, DataSnapClientClass;

procedure TfrmDecision.btnCancelClick(Sender: TObject);
begin
  dm.Decision.Cancel;
end;

procedure TfrmDecision.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDecision.btnDecisionClick(Sender: TObject); //ó���ϱ� Ŭ����
var
  ReserveSeq: Integer;
  Client: TServerMethodsClient;
begin                                          //�����޼ҵ� ȣ��
  Client := TServerMethodsClient.Create(dm.SQLConnection.DBXConnection);

  ReserveSeq := dm.During.FieldByName('RESERVE_SEQ').AsInteger;
  if Client.AcceptDecision(ReserveSeq) then    //�޼ҵ� ���
  showmessage('ó�� �Ϸ�!');
  Client.Free;

//  dm.During.Refresh;       //����ȯ�� Refresh
end;

procedure TfrmDecision.btnRefreshClick(Sender: TObject);
begin
  dm.During.Refresh;
end;

procedure TfrmDecision.btnDecisionDeleteClick(Sender: TObject);
begin
  try
    dm.Decision.Delete;
    dm.Decision.ApplyUpdates(-1);
    dm.Decision.Refresh;
  except
    raise Exception.Create('������ �����Ͱ� �����ϴ�.');
  end;
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
      dm.Decision.FieldByName('ACCEPT_AMOUNT').AsInteger := dm.Decision.FieldByName('ACCEPT_AMOUNT').AsInteger + 1;
    end
  else
    dm.Decision.Insert;                 //��ǰ ó�� �߰��� �� �־��ֱ�
  dm.Decision.FieldByName('MEDICINE_SEQ').AsInteger := dm.MedicineList.FieldByName('MEDICINE_SEQ').AsInteger;
  dm.Decision.FieldByName('RESERVE_NAME').AsString := dm.Reserve.FieldByName('PATIENT_NAME').AsString;
  dm.Decision.FieldByName('RESERVE_SEQ').AsInteger := dm.During.FieldByName('RESERVE_SEQ').AsInteger;
  dm.Decision.FieldByName('PATIENT_SEQ').AsInteger := dm.Reserve.FieldByName('PATIENT_SEQ').AsInteger;

  if dm.Decision.FieldByName('ACCEPT_AMOUNT').AsString = '' then //ó�� Ŭ����(���� ���������)
    dm.Decision.FieldByName('ACCEPT_AMOUNT').AsInteger := 1;

    dm.Decision.FieldByName('PRICE').AsInteger := dm.Decision.FieldByName('PRICE_CALC').AsInteger; //���� �ݾ� PRICE�� �ֱ�

    dm.Decision.Post;
    dm.Decision.ApplyUpdates(-1);         //������Ʈ
end;

end.
