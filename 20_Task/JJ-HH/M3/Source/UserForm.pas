unit UserForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.DBCtrls, Vcl.WinXCalendars, Vcl.Mask, Vcl.Grids,
  Vcl.DBGrids;

type
  TfrmUser = class(TForm)
    pnlHeader: TPanel;
    pnlContent: TPanel;
    lblCaption: TLabel;
    btnAdd: TButton;
    btnClose: TButton;
    pnlGrid: TPanel;
    pnlInput: TPanel;
    Splitter1: TSplitter;
    pnlGridHeader: TPanel;
    grdList: TDBGrid;
    Label1: TLabel;
    edtSearch: TEdit;
    chkSearchName: TCheckBox;
    chkSearchPhone: TCheckBox;
    Label2: TLabel;
    edtName: TDBEdit;
    Label3: TLabel;
    dpBirth: TCalendarPicker;
    grpSex: TDBRadioGroup;
    Label4: TLabel;
    edtPhone: TDBEdit;
    Label5: TLabel;
    edtMail: TDBEdit;
    GroupBox1: TGroupBox;
    btnClearImage: TButton;
    btnLoadImage: TButton;
    imgUser: TImage;
    dlgLoadImage: TOpenDialog;
    btnSave: TButton;
    btnCancel: TButton;
    btnDelete: TButton;
    dsUser: TDataSource;
    procedure btnLoadImageClick(Sender: TObject);
    procedure btnClearImageClick(Sender: TObject);
    procedure dsUserDataChange(Sender: TObject; Field: TField);
    procedure dpBirthCloseUp(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure dsUserStateChange(Sender: TObject);
    procedure edtNameExit(Sender: TObject);
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function DuplicatedUser: Boolean;
  public
    { Public declarations }
  end;

var
  frmUser: TfrmUser;

implementation

{$R *.dfm}

uses DataAccessModule, CommonFunctions;

procedure TfrmUser.btnAddClick(Sender: TObject);
begin
  dmDataAccess.qryUser.Append;
  edtName.SetFocus;
end;

procedure TfrmUser.btnCancelClick(Sender: TObject);
begin
  dmDataAccess.qryUser.Cancel;
end;

procedure TfrmUser.btnClearImageClick(Sender: TObject);
var
  Field: TField;
begin
  imgUser.Picture.Assign(nil);
  Field := dmDataAccess.qryUser.FieldByName('USER_IMAGE');

  if dmDataAccess.qryUser.State <> dsEdit then
    dmDataAccess.qryUser.Edit;

  Field.Assign(nil);

end;

procedure TfrmUser.btnDeleteClick(Sender: TObject);
var
  rentCount: Integer;
  Msg, name, OutYN: String;
begin
  rentCount := dmDataAccess.qryUser.FieldByName('USER_RENT_COUNT').AsInteger;
  name := dmDataAccess.qryUser.FieldByName('USER_NAME').AsString;
  OutYN := dmDataAccess.qryUser.FieldByName('USER_OUT_YN').AsString;

  if OutYN = 'Y' then
  begin
    ShowMessage('�̹� Ż���� ȸ���Դϴ�.');
    Exit;

  end;
  if rentCount > 0 then
  begin
    ShowMessage(Format('���� �뿩 ���� ������[%d]�� �����մϴ�', [rentCount]));
    Exit;
  end;

  Msg := Format('������ [%s]���� Ż�� ó���ϰڽ��ϱ�?', [name]);
  if MessageDlg(Msg, mtInformation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  if dmDataAccess.qryUser.State <> dsEdit then
    dmDataAccess.qryUser.Edit;
  dmDataAccess.qryUser.FieldByName('USER_OUT_YN').AsString := 'Y';
  dmDataAccess.qryUser.FieldByName('USER_OUT_DATE').AsDateTime := Now;
  dmDataAccess.qryUser.Post;
  dmDataAccess.qryUser.Refresh;

end;

procedure TfrmUser.btnLoadImageClick(Sender: TObject);
var
  Field: TField;
begin
  if dlgLoadImage.Execute then
  begin
    LoadImageFromFile(imgUser, dlgLoadImage.FileName);

    Field := dmDataAccess.qryBook.FieldByName('USER_IMAGE');
    SaveImageToBlobField(imgUser, Field as TBlobField);
  end;

end;

procedure TfrmUser.btnSaveClick(Sender: TObject);
begin
  if edtName.Text = '' then
  begin
    ShowMessage('�̸��� �Է��ϼ���');
    edtName.SetFocus;
    Exit;
  end;

  if dpBirth.IsEmpty then
  begin
    ShowMessage('��������� �Է��ϼ���');
    dpBirth.SetFocus;
    Exit;
  end;

  dmDataAccess.qryUser.Post;
  dmDataAccess.qryUser.Refresh;
end;

procedure TfrmUser.dpBirthCloseUp(Sender: TObject);
var
  Field: TField;
begin
  Field := dmDataAccess.qryUser.FieldByName('USER_BIRTH');

  if Field.AsDateTime <> dpBirth.Date then
  begin
    if dmDataAccess.qryUser.State = dsBrowse then
    begin
      if dmDataAccess.qryUser.RecNo > 0 then
        dmDataAccess.qryUser.Edit
      else
        dmDataAccess.qryUser.Append;
    end;
    if dpBirth.IsEmpty then
      Field.Assign(nil)
    else
      Field.AsDateTime := dpBirth.Date;
  end;

  DuplicatedUser;
end;

procedure TfrmUser.dsUserDataChange(Sender: TObject; Field: TField);
var
  LField: TField;
begin
  if dmDataAccess.qryUser.State = dsEdit then
    Exit;

  LField := dmDataAccess.qryUser.FieldByName('USER_IMAGE');
  LoadImageFromBlobField(imgUser, LField as TBlobField);

  LField := dmDataAccess.qryUser.FieldByName('USER_BIRTH');
  if LField.AsDateTime = 0 then
    dpBirth.IsEmpty := True
  else
    dpBirth.Date := LField.AsDateTime;

end;

procedure TfrmUser.dsUserStateChange(Sender: TObject);
var
  State: TDataSetState;
  OutYN: string;

begin
  State := dmDataAccess.qryUser.State;

  btnAdd.Enabled := (State = dsBrowse);
  btnSave.Enabled := (State <> dsBrowse);
  btnDelete.Enabled := (State = dsBrowse);
  btnCancel.Enabled := (State <> dsBrowse);
end;

function TfrmUser.DuplicatedUser: Boolean;
var
  Seq: Integer;
  name: string;
  Birth: TDateTime;
begin
  Seq := dmDataAccess.qryUser.FieldByName('USER_SEQ').AsInteger;
  Name := dmDataAccess.qryUser.FieldByName('USER_NAME').AsString;
  Birth := dmDataAccess.qryUser.FieldByName('USER_BIRTH').AsDateTime;

  if (Name = '') or (Birth = 0) then
    Exit;

  if dmDataAccess.DuplicatedUser(Seq, Name, Birth) then
    ShowMessage('�̹� ��ϵ� ȸ���Դϴ�.(�̸��� ��������� �ߺ��˴ϴ�)');

end;

procedure TfrmUser.edtNameExit(Sender: TObject);
begin
  DuplicatedUser;
end;

procedure TfrmUser.edtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Filter: string;
begin
  Filter := '';
  if edtSearch.Text <> '' then
  begin
    if chkSearchName.Checked then
      Filter := Format('USER_NAME like ''%%%s%%''', [edtSearch.Text]);
    if chkSearchPhone.Checked then
    begin
      if Filter <> '' then
        Filter := Filter + ' or ';
      Filter := Filter + Format('USER_PHONE like ''%%%s%%''', [edtSearch.Text]);
    end;
  end;

  dmDataAccess.qryUser.Filter := Filter;
  dmDataAccess.qryUser.Filtered := (Filter <> '');

end;

end.
