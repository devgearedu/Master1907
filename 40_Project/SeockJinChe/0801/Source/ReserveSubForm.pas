unit ReserveSubForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.WinXCalendars, Vcl.Mask, Vcl.WinXPickers, System.UITypes,
  Vcl.ComCtrls;

type
  TfrmReserveSub = class(TForm)
    pnlGrid: TPanel;
    PanelGridHeader: TPanel;
    lbSearch: TLabel;
    btnFirst: TSpeedButton;
    btnPrior: TSpeedButton;
    btnNext: TSpeedButton;
    btnLast: TSpeedButton;
    btnSearch: TButton;
    grdList: TDBGrid;
    edtSearch: TEdit;
    ComboBox1: TComboBox;
    pnlInput: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label7: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtName: TDBEdit;
    dbReserve: TCalendarPicker;
    dbTime: TTimePicker;
    btnAddReserv: TButton;
    btnReservCancel: TButton;
    btnDeleteCancel: TButton;
    grpDoctor: TDBRadioGroup;
    grpSelectDoctor: TRadioGroup;
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdListDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddReservClick(Sender: TObject);
    procedure btnDeleteCancelClick(Sender: TObject);
    procedure btnReservCancelClick(Sender: TObject);
    procedure dbTimeCloseUp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReserveSub: TfrmReserveSub;

implementation

{$R *.dfm}

uses ReservationForm, PatientManagerDataModule;

procedure TfrmReserveSub.btnAddReservClick(Sender: TObject);  //�����ϱ� Ŭ����
var
  DocSeq: Integer;
begin
  if edtName.Text = '' then
  begin
    ShowMessage('ȯ�ڸ� �����ϼ���.');
    Exit;
  end;

  dm.Reserve.Append;

  //ȯ�ڹ�ȣ
  dm.Reserve.FieldByName('PATIENT_SEQ').AsInteger := dm.PatientList.FieldByName('PATIENT_SEQ').AsInteger;

  //������ ����
//  if dm.Reserve.FieldByName('RESERVATION_DATE').AsDateTime <> dbReserve.Date then //������ ��¥�� ����������
//  begin
    dm.Reserve.FieldByName('RESERVATION_DATE').AsDateTime := dbReserve.Date;    //������ �ð����� ����
//  end;

  //����ð� ����
//  if dm.Reserve.FieldByName('RESERVATION_TIME').AsDateTime <> dbTime.Time then  //������ �ð��� ����������
//  begin
    dm.Reserve.FieldByName('RESERVATION_TIME').AsDateTime := dbTime.Time;       //������ �ð����� ����
//  end;

  //����ǻ� ����
  DocSeq := grpSelectDoctor.ItemIndex;
  dm.Reserve.FieldByName('DOCTOR_SEQ').AsInteger := DocSeq;

  dm.Reserve.FieldByName('NOWSTATE').AsInteger := 10;  //���º��� : ������

  dm.Reserve.Post;
  dm.Reserve.ApplyUpdates(-1);
  dm.Reserve.Refresh;
  close;
end;

procedure TfrmReserveSub.btnDeleteCancelClick(Sender: TObject);
begin
  if MessageDlg('������ �����Ͻðڽ��ϱ�?', MTConfirmation, [mbYes, mbno], 0) = mrYes  then
    begin
      dm.Reserve.Delete;
      dm.Reserve.ApplyUpdates(-1);
      dm.Reserve.Refresh;
    end;
end;

procedure TfrmReserveSub.btnReservCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmReserveSub.dbTimeCloseUp(Sender: TObject);
var
  Field: TField;
begin
  Field := dm.Reserve.FieldByName('RESERVATION_TIME');

  if Field.AsDateTime <> dbTime.Time then
  begin
    if dm.Reserve.State = dsBrowse then
    begin
      if dm.Reserve.RecNo > 0 then  //�̹� ������ ���
        dm.Reserve.Edit
      else
        dm.Reserve.Append;      //�űԵ���� ���
    end;
      Field.AsDateTime := dbTime.Time;
  end;

end;

procedure TfrmReserveSub.edtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);                                   //�˻����
var
  Filter: string;
begin
  Filter := '';
  if edtSearch.Text <> '' then
  begin
    if ComboBox1.Text = 'ȯ�ڸ�' then
      Filter := Format('PATIENT_NAME like ''%%%s%%''', [edtSearch.Text]); //���͸�
    if ComboBox1.Text = '�������' then
      Filter := Format('PATIENT_BIRTH like ''%%%s%%''', [edtSearch.Text]);
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

procedure TfrmReserveSub.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmReserveSub := nil;
end;

procedure TfrmReserveSub.FormCreate(Sender: TObject);
begin
  dbReserve.Date := now;
  dbTime.Time := now;
end;

procedure TfrmReserveSub.grdListDblClick(Sender: TObject);
var
  Field: TField;
  Today: TDate;
begin
  Field := dm.Reserve.FieldByName('RESERVATION_DATE');
   if dm.Reserve.State = dsBrowse then
   begin
     dm.Reserve.Edit;
     Today := now;
     Field.AsDateTime := Today;
     dm.Reserve.Post;
     dm.Reserve.ApplyUpdates(-1);
   end;

   frmReserveSub.Close;
end;

end.
