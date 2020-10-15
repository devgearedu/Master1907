unit PatientListForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.WinXCalendars, Vcl.Mask, Vcl.WinXPickers, System.UITypes,
  Vcl.ComCtrls;

type
  TfrmPatientList = class(TForm)
    pnlClient: TPanel;
    pnlHeader: TPanel;
    pnlInput: TPanel;
    Splitter1: TSplitter;
    pnlGrid: TPanel;
    PanelGridHeader: TPanel;
    grdList: TDBGrid;
    edtSearch: TEdit;
    lbSearch: TLabel;
    ComboBox1: TComboBox;
    btnSearch: TButton;
    btnAdd: TButton;
    lbHeader: TLabel;
    btnFirst: TSpeedButton;
    btnPrior: TSpeedButton;
    btnNext: TSpeedButton;
    btnLast: TSpeedButton;
    btnClose: TButton;
    ilSearch: TImageList;
    pnlSubInput1: TPanel;
    pcInput: TPageControl;
    tstInput1: TTabSheet;
    Label1: TLabel;
    edtName: TDBEdit;
    Label2: TLabel;
    edtBirth: TDBEdit;
    grpGender: TDBRadioGroup;
    imgUser: TImage;
    Label6: TLabel;
    btnClearImage: TButton;
    btnLoadImage: TButton;
    Label3: TLabel;
    edtPhone: TDBEdit;
    dlgLoadImage: TOpenDialog;
    tstInput2: TTabSheet;
    Label7: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    clpReserve: TCalendarPicker;
    grpDoctor: TRadioGroup;
    Label5: TLabel;
    RservTime: TTimePicker;
    pnlSubInput2: TPanel;
    btnPost: TButton;
    btnCancel: TButton;
    btnDelete: TButton;
    pnlSubInput3: TPanel;
    btnAddReserv: TButton;
    btnDeleteCancel: TButton;
    btnReservCancel: TButton;
    PatientListSource: TDataSource;
    procedure btnSearchClick(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFirstClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure btnClearImageClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnLoadImageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddReservClick(Sender: TObject);
    procedure PatientListSourceDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CommonFunctions, MainClientForm, PatientManagerDataModule;

procedure TfrmPatientList.btnAddClick(Sender: TObject);      //�ű� ���
begin
  dm.PatientList.Append;
  edtName.SetFocus;
end;

procedure TfrmPatientList.btnAddReservClick(Sender: TObject);  //�����ư Ŭ��
begin
//  pcInput.ActivePage := tstInput2; //�����ǿ� ��Ŀ��.(������ ���� �ű��)
end;

procedure TfrmPatientList.btnCancelClick(Sender: TObject);    //���
begin
  dm.PatientList.Cancel;
end;

procedure TfrmPatientList.btnClearImageClick(Sender: TObject);  //�����ʱ�ȭ
var
  Field: TField;
begin
  imgUser.Picture.Assign(nil);

  Field := dm.PatientList.FieldByName('PATIENT_IMAGE');
  if dm.PatientList.State <> dsEdit then  //�������°� �ƴҽ�
    dm.PatientList.Edit;                  //�������·� ����
  Field.Assign(nil);
end;

procedure TfrmPatientList.btnCloseClick(Sender: TObject);  //�ݱ�
begin
  Close;
end;

procedure TfrmPatientList.btnDeleteClick(Sender: TObject);
begin
  if MessageDlg('������ �����Ͻðڽ��ϱ�? ������ �����ʹ� ������ �� �����ϴ�!', MTConfirmation, [mbYes, mbno], 0) = mrYes  then
    begin
    dm.PatientList.Delete;
    dm.PatientList.ApplyUpdates(-1);
    dm.PatientList.Refresh;
    end;
end;

procedure TfrmPatientList.btnPostClick(Sender: TObject);   //Post ������
begin
  if edtName.Text = '' then
  begin
    ShowMessage('�̸��� �Է��ϼ���.');
    edtName.SetFocus;
    Exit;
  end;

  if edtBirth.Text = '' then
  begin
    ShowMessage('��������� �Է��ϼ���.');
    edtBirth.SetFocus;
    Exit;
  end;

  dm.PatientList.Post;
  dm.PatientList.ApplyUpdates(-1);
  pcInput.ActivePage := tstInput1;
end;

procedure TfrmPatientList.btnSearchClick(Sender: TObject);

begin            //To do �ο��� ��ȸ��� �߰��ϱ�
  if edtSearch.text = '' then
    showMessage('�˻��� ������ �Է����ּ���!');
end;

procedure TfrmPatientList.edtSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);                          //��ȸ���(����)
begin
 if Key = vk_return then
    if not dm.PatientList.FindKey([edtSearch.Text]) then
      showmessage('��ġ�ϴ� ������ �����ϴ�');    //�ο��� ��ȸ����߰��ϱ�.
end;

procedure TfrmPatientList.edtSearchKeyUp(Sender: TObject; var Key: Word; //�˻����
  Shift: TShiftState);
var
  Filter: string;
begin
  Filter := '';
  if edtSearch.Text <> '' then
  begin
    if ComboBox1.Text = 'ȯ�ڸ�' then
      Filter := Format('PATIENT_NAME like ''%%%s%%''', [edtSearch.Text]); //���͸�
    if ComboBox1.Text = '�������' then
      Filter := Format('PATIENT_NAME like ''%%%s%%''', [edtSearch.Text]);
    if ComboBox1.Text = '����ó' then
    begin
      if Filter <> '' then
        Filter := Filter + ' or ';
      Filter := Filter + Format('PATIENT_PHONE like ''%%%s%%''', [edtSearch.Text]);
    end;
  end;

  dm.PatientList.Filter := Filter;
  dm.PatientList.Filtered := (Filter <> '');

end;

procedure TfrmPatientList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dm.PLFormLoadCheck := False;  //�̹��� �ҷ��ö� ���� ����
  Action := caFree;
  frmSub := nil;
end;

procedure TfrmPatientList.FormCreate(Sender: TObject);
begin
  dm.PLFormLoadCheck := True;  //�̹��� �ҷ��ö� ���� ����
end;

procedure TfrmPatientList.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);                    //���� �Է����� �Ѿ��.
begin
  if Key = vk_return then  //press������ #13
    SelectNext (activeControl, true, true);
end;

procedure TfrmPatientList.PatientListSourceDataChange(Sender: TObject;
  Field: TField);
Var
  LField: TField;
begin                   //DB�� ��ϵ� �̹����� �ҷ����� ���.
//  if (PLFormLoadCheck = True) then      //���� �����ִٸ�
  begin
//    if (PatientList.State = dsEdit) then  //�������̸�
//      Exit;
    LField := dm.PatientList.FieldByName('PATIENT_IMAGE');
    LoadImageFromBlobField(imgUser, LField as TBlobField);
  end;
end;

procedure TfrmPatientList.btnFirstClick(Sender: TObject);
begin
  dm.PatientList.First;
end;

procedure TfrmPatientList.btnPriorClick(Sender: TObject);
begin
  dm.PatientList.prior;
end;

procedure TfrmPatientList.btnNextClick(Sender: TObject);
begin
  dm.PatientList.Next;
end;

procedure TfrmPatientList.btnLastClick(Sender: TObject);
begin
  dm.PatientList.Last;
end;


procedure TfrmPatientList.btnLoadImageClick(Sender: TObject);
var     //DB���� �̹��� �ҷ�����
  Field: TField;
begin
    if dlgLoadImage.Execute then
    begin
      LoadImageFromFile(imgUser, dlgLoadImage.FileName);
      Field := dm.PatientList.FieldByName('PATIENT_IMAGE');
      SaveImageToBlobField(imgUser, Field as TBlobField);
    end;
end;

end.
