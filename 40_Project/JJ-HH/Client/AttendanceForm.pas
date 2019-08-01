unit AttendanceForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.WinXCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.WinXPickers, Vcl.DBCtrls;

type
  TfrmAttendance = class(TForm)
    pnlScreen: TPanel;
    pcForAttend: TPageControl;
    tshtAttendClient: TTabSheet;
    tshtAttendCoach: TTabSheet;
    tshtAttendCourse: TTabSheet;
    pnlSearchClient: TPanel;
    pnlShowClient: TPanel;
    dbgrdCurrentEnroll: TDBGrid;
    edtClientCode: TEdit;
    edtClientName_: TEdit;
    edtYAndMCurrent: TEdit;
    lblText1: TLabel;
    lblText2: TLabel;
    rdbtnCodeClient: TRadioButton;
    rdbtnName_Client: TRadioButton;
    sbClient: TSearchBox;
    lblAttendanceStatus: TLabel;
    dbgrdAttendByClient: TDBGrid;
    btnAttend: TButton;
    dbgrdAttendByClass: TDBGrid;
    cmbbxYearAndMonth: TComboBox;
    cmbbxSports: TComboBox;
    btnLookupToAttend: TButton;
    cmbbxWeekdays: TComboBox;
    dpDate_Of_Course: TDatePicker;
    btnSelectEnrolledCourse: TButton;
    procedure sbClientInvokeSearch(Sender: TObject);
    procedure tshtAttendCourseShow(Sender: TObject);
    procedure btnLookupToAttendClick(Sender: TObject);
    procedure btnSelectEnrolledCourseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAttendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAttendance: TfrmAttendance;

implementation

{$R *.dfm}

uses
  EnrollmentForm, ServerMethodsUnitGym_ClientClass, NamesakeForm,
  MainForm, System.DateUtils, System.Generics.Collections;

var
  DaysDictAF : TDictionary<Integer, string>;

procedure TfrmAttendance.btnAttendClick(Sender: TObject);
begin
  frmMain.cdsQryAttendances.Active := False;
  serverclient.SelectAttendanceByClientAndCourse(IntToStr(frmMain.cdsQryEnrollments.FieldByName('client_code').AsInteger),
    IntToStr(frmMain.cdsQryEnrollments.FieldByName('course_code').AsInteger), edtYAndMCurrent.Text);
  frmMain.cdsQryAttendances.Active := True;

  frmMain.cdsQryAttendances.Locate('is_present', 'N', []);

  if (serverclient.AttendByClient(dbgrdCurrentEnroll.Fields[0].Value,
                              dbgrdAttendByClient.Fields[4].Value,
                              (dbgrdAttendByClient.Fields[0].Value)) ) then
  begin
    frmMain.cdsQryAttendances.Refresh;
  end;
end;

procedure TfrmAttendance.btnLookupToAttendClick(Sender: TObject);
var
  frmNSForAttend : TfrmNamesake;
begin
  frmMain.cdsQryCourses.Active := False;
  serverclient.SelectCourseToAttend(cmbbxYearAndMonth.Text,cmbbxSports.Text,cmbbxWeekdays.Text);
  frmMain.cdsQryCourses.Active := True;

  if frmMain.cdsQryCourses.RecordCount > 0 then
  begin
    frmNSForAttend := TfrmNamesake.Create(nil);
    frmNSForAttend.dbgrdNamesake.DataSource := frmMain.dsQryCourses;
    frmNSForAttend.ShowModal;
  end
  else
  begin
    exit;
  end;

  frmMain.cdsQryAttendances.Active := False;
  serverclient.SelectAttendanceByCourseAndDate(DateToStr(dpDate_Of_Course.Date),
    IntToStr(frmMain.cdsQryCourses.FieldByName('code').AsInteger));
  frmMain.cdsQryAttendances.Active := True;

  frmMain.cdsQryAttendances.Fields[1].DisplayWidth := 10;
  dbgrdAttendByClass.DataSource := frmMain.dsQryAttendances;

end;

procedure TfrmAttendance.btnSelectEnrolledCourseClick(Sender: TObject);
var
  OutStr : string;
  Flag : Byte;
begin
  Flag := 0;

  frmMain.cdsQryAttendances.Active := False;
  serverclient.SelectAttendanceByClientAndCourse(IntToStr(frmMain.cdsQryEnrollments.FieldByName('client_code').AsInteger),
    IntToStr(frmMain.cdsQryEnrollments.FieldByName('course_code').AsInteger), edtYAndMCurrent.Text);
  frmMain.cdsQryAttendances.Active := True;

  while not frmMain.cdsQryAttendances.Eof do
  begin
    if (Pos(DaysDictAF.Items[DayOfTheWeek(Today)],frmMain.cdsQryAttendances.Fields[3].Value) = 0) then
    begin
      Flag := 1;
//      ShowMessage('�ٸ� ����');
      break;
    end;
    if (frmMain.cdsQryAttendances.Fields[0].Value = Today) then
    begin
//      ShowMessage('�ش糯¥ ����');
      Flag := 1;
      break;
    end;
  frmMain.cdsQryAttendances.Next;
  end;

  if Flag = 0 then
  begin
    if (serverclient.InsertNotPresent(IntToStr(frmMain.cdsQryEnrollments.Fields[0].Value),
                            IntToStr(frmMain.cdsQryEnrollments.Fields[1].Value),
                            DateToStr(Today))) then
    begin
      frmMain.cdsQryAttendances.Refresh;
    end;
  end;

  frmMain.cdsQryAttendances.fields[0].DisplayLabel := '��������';
  frmMain.cdsQryAttendances.fields[1].DisplayLabel := '����';
  frmMain.cdsQryAttendances.fields[1].DisplayWidth := 10;
  frmMain.cdsQryAttendances.fields[2].DisplayLabel := '���۽ð�';
  frmMain.cdsQryAttendances.fields[2].DisplayWidth := 12;
  frmMain.cdsQryAttendances.fields[3].DisplayLabel := '����';
  frmMain.cdsQryAttendances.fields[3].DisplayWidth := 10;
  frmMain.cdsQryAttendances.fields[4].DisplayLabel := '�����ڵ�';
  frmMain.cdsQryAttendances.fields[4].DisplayWidth := 10;
  frmMain.cdsQryAttendances.fields[5].DisplayLabel := '�⼮����';

  dbgrdAttendByClient.DataSource := frmMain.dsQryAttendances;
end;

procedure TfrmAttendance.FormCreate(Sender: TObject);
begin
  DaysDictAF := TDictionary<Integer, string>.Create(0);
  DaysDictAF.AddOrSetValue(DaySunday, '��');
  DaysDictAF.AddOrSetValue(DayMonday, '��');
  DaysDictAF.AddOrSetValue(DayTuesday, 'ȭ');
  DaysDictAF.AddOrSetValue(DayWednesday, '��');
  DaysDictAF.AddOrSetValue(DayThursday, '��');
  DaysDictAF.AddOrSetValue(DayFriday, '��');
  DaysDictAF.AddOrSetValue(DaySaturday, '��');
end;

procedure TfrmAttendance.sbClientInvokeSearch(Sender: TObject);
var
  frmNSClient : TfrmNamesake;
begin
  if sbClient.Text = '' then
  begin
    ShowMessage('�˻�� �Է��ϼ���');
    exit;
  end;

  frmMain.cdsQryClients.Active := False;

  if rdbtnCodeClient.Checked then
  begin
    serverclient.SelectByFieldAndValueClient('code', sbClient.Text);
    frmMain.cdsQryClients.Active := True;
  end;

  if rdbtnName_Client.Checked then
  begin
    serverclient.SelectByFieldAndValueClient('name_', sbClient.Text);
    frmMain.cdsQryClients.Active := True;

    if frmMain.cdsQryClients.RecordCount > 1 then
    begin
      frmNSClient := TfrmNamesake.Create(nil);
      frmNSClient.dbgrdNamesake.DataSource := frmMain.dsQryClients;
      frmNSClient.ShowModal;
    end;
  end;


//  btnModifycoach.Enabled := True;
  edtClientName_.Text := frmMain.cdsQryClientsName_.Value;
  edtClientCode.Text := '(' + IntToStr(frmMain.cdsQryClientsCODE.Value) + ')';
  edtYAndMCurrent.Text := FormatDateTime('yyyymm',Today);

  frmMain.cdsQryEnrollments.Active := False;

  serverclient.SelectFromEnrollmentsAndCourses(IntToStr(frmMain.cdsQryClientsCODE.Value));
  frmMain.cdsQryEnrollments.Active := True;

  frmMain.cdsQryEnrollments.Fields[0].DisplayLabel := 'ȸ����ȣ';
  frmMain.cdsQryEnrollments.Fields[1].DisplayLabel := '�����ڵ�';
  frmMain.cdsQryEnrollments.Fields[2].DisplayLabel := '���¸�';
  frmMain.cdsQryEnrollments.Fields[3].DisplayLabel := '����';
  frmMain.cdsQryEnrollments.Fields[4].DisplayLabel := '�Ⱓ����';
  frmMain.cdsQryEnrollments.Fields[5].DisplayLabel := '���۽ð�';

  if frmMain.cdsQryEnrollments.RecordCount > 0 then
    dbgrdCurrentEnroll.DataSource := frmMain.dsQryEnrollments;

  dbgrdAttendByClient.DataSource := nil;
end;

procedure TfrmAttendance.tshtAttendCourseShow(Sender: TObject);
var
  VarDate : TDate;
begin
  VarDate := StrToDate('2019-07-01');

//  cmbbxYearAndMonth.Items.Add('201907');
  while VarDate < StrToDate('2019-10-01') do
  begin
    cmbbxYearAndMonth.Items.Add(FormatDateTime('yyyymm',VarDate));
    VarDate := IncMonth(VarDate);
  end;
  cmbbxYearAndMonth.Text := '�Ⱓ';

  cmbbxSports.Items.Add('��');
  cmbbxSports.Items.Add('����');
  cmbbxSports.Items.Add('�䰡');
  cmbbxSports.Items.Add('�౸');
  cmbbxSports.Items.Add('�ｺ');
  cmbbxSports.Text := '���¸�';

  cmbbxWeekdays.Items.Add('ȭ��');
  cmbbxWeekdays.Items.Add('������');
  cmbbxWeekdays.Text := '����';
end;

end.
