unit MedicineForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.WinXCalendars, Vcl.Mask, Vcl.WinXPickers, System.UITypes,
  Vcl.ComCtrls;

type
  TfrmMedicine = class(TForm)
    MedicinePanel: TPanel;
    pnlTop: TPanel;
    Label1: TLabel;
    pnlMain: TPanel;
    pnlLeft: TPanel;
    pnlInput: TPanel;
    Splitter1: TSplitter;
    Label2: TLabel;
    edtName: TDBEdit;
    Label3: TLabel;
    edtPrice: TDBEdit;
    Label6: TLabel;
    imgUser: TImage;
    btnClearImage: TButton;
    btnLoadImage: TButton;
    btnPost: TButton;
    btnCancel: TButton;
    btnDelete: TButton;
    dlgLoadImage: TOpenDialog;
    ilMedicine: TImageList;
    pnlHeader: TPanel;
    pnlGrid: TPanel;
    grdMedicine: TDBGrid;
    btnAdd: TButton;
    btnClose: TButton;
    lbSearch: TLabel;
    ComboBox1: TComboBox;
    edtSearch: TEdit;
    btnSearch: TButton;
    MedicineListSource: TDataSource;
    procedure btnClearImageClick(Sender: TObject);
    procedure btnLoadImageClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure MedicineListSourceDataChange(Sender: TObject; Field: TField);
    procedure MedicineListSourceStateChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMedicine: TfrmMedicine;

implementation

{$R *.dfm}

uses PatientManagerDataModule, CommonFunctions, MainClientForm;

procedure TfrmMedicine.btnAddClick(Sender: TObject);
begin
  dm.MedicineList.Insert;
  edtName.SetFocus;
end;

procedure TfrmMedicine.btnCancelClick(Sender: TObject);
begin
  dm.MedicineList.Cancel;
end;

procedure TfrmMedicine.btnClearImageClick(Sender: TObject);  //�����ʱ�ȭ
var
  Field: TField;
begin
  imgUser.Picture.Assign(nil);

  Field := dm.PatientList.FieldByName('MEDICINE_IMAGE');
  if dm.MedicineList.State <> dsEdit then  //�������°� �ƴҽ�
    dm.MedicineList.Edit;                  //�������·� ����
  Field.Assign(nil);
end;

procedure TfrmMedicine.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMedicine.btnDeleteClick(Sender: TObject);
begin
  if MessageDlg('������ �����Ͻðڽ��ϱ�? ������ �����ʹ� ������ �� �����ϴ�!', MTConfirmation, [mbYes, mbno], 0) = mrYes  then
    begin
    dm.MedicineList.Delete;                  //DB���� ����
    dm.MedicineList.ApplyUpdates(-1);
    dm.MedicineList.Refresh;
    end;
end;

procedure TfrmMedicine.btnLoadImageClick(Sender: TObject);
var     //�ҷ����� Ŭ��
  Field: TField;
begin
  if dlgLoadImage.Execute then
  begin
    LoadImageFromFile(imgUser, dlgLoadImage.FileName);
    Field := dm.MedicineList.FieldByName('MEDICINE_IMAGE');
    SaveImageToBlobField(imgUser, Field as TBlobField);
  end;
end;

procedure TfrmMedicine.btnPostClick(Sender: TObject);
begin
  if edtName.Text = '' then                     //��ĭüũ
  begin
    ShowMessage('�̸��� �Է��ϼ���.');
    edtName.SetFocus;
    Exit;
  end;

  if edtPrice.Text = '' then                    //��ĭüũ
  begin
    ShowMessage('��������� �Է��ϼ���.');
    edtPrice.SetFocus;
    Exit;
  end;

  dm.MedicineList.Post;
  dm.MedicineList.ApplyUpdates(-1);
  dm.MedicineList.Refresh;
end;

procedure TfrmMedicine.edtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Filter: string;
begin
  Filter := '';
  if edtSearch.Text <> '' then
  begin
    if ComboBox1.Text = '��ǰ��' then
      Filter := Format('MEDICINE_NAME like ''%%%s%%''', [edtSearch.Text]); //���͸�
    if ComboBox1.Text = '�Ϸù�ȣ' then
    begin
      if Filter <> '' then
        Filter := Filter + ' or ';
      Filter := Filter + Format('MEDICINE_SEQ like ''%%%s%%''', [edtSearch.Text]);
    end;
  end;

  dm.MedicineList.Filter := Filter;
  dm.MedicineList.Filtered := (Filter <> '');

end;

procedure TfrmMedicine.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmSub := nil;
end;

procedure TfrmMedicine.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_return then  //press������ #13
    SelectNext (activeControl, true, true);   //���� �Է����� �Ѿ��.
end;

procedure TfrmMedicine.MedicineListSourceDataChange(Sender: TObject;
  Field: TField);
Var
  LField: TField;
begin                   //DB�� ��ϵ� �̹����� �ҷ����� ���.
  begin
    LField := dm.MedicineList.FieldByName('MEDICINE_IMAGE');  //DB�̹�����θ� Lfield�� �ְ�
    LoadImageFromBlobField(imgUser, LField as TBlobField);  //imgUser�� Lfield�� �ε��ϱ�.
  end;
end;

procedure TfrmMedicine.MedicineListSourceStateChange(Sender: TObject);
var
  State: TDataSetState;
begin
  State := dm.MedicineList.State;

  btnAdd.Enabled := (State = dsBrowse);
  btnPost.Enabled := (State <> dsBrowse);
  btnDelete.Enabled := (State = dsBrowse);
  btnCancel.Enabled := (State <> dsBrowse);
end;

end.
