unit TestConditionForm;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, Vcl.Dialogs, Winapi.Windows, System.SysUtils, ConditionForm,
  Vcl.Graphics, System.Variants, Winapi.Messages, Vcl.StdCtrls, Vcl.Controls, Vcl.Forms,
  System.Classes;

type
  // Test methods for class TfrmFunction

  TestTfrmCondition = class(TTestCase)
  strict private
    FfrmCondition: TfrmCondition;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestLoginCheckEmpty;
    procedure TestLoginCheckNotfound;
    procedure TestLoginCheckIncorrect;
    procedure TestLoginCheckOK;
  end;

implementation

procedure TestTfrmCondition.SetUp;
begin
  FfrmCondition := TfrmCondition.Create(nil);
end;

procedure TestTfrmCondition.TearDown;
begin
  FfrmCondition.Free;
  FfrmCondition := nil;
end;

procedure TestTfrmCondition.TestLoginCheckEmpty;
var
  ReturnValue: Integer;
begin
  ReturnValue := FfrmCondition.LoginCheck('', '');
  CheckEquals(ReturnValue, LOGIN_RESULT_EMPTY, '공백 확인');
end;

procedure TestTfrmCondition.TestLoginCheckNotfound;
var
  ReturnValue: Integer;
begin
  ReturnValue := FfrmCondition.LoginCheck('no_id', '');
  CheckEquals(ReturnValue, LOGIN_RESULT_NOTFOUND_ID, 'Id 없음');
end;

procedure TestTfrmCondition.TestLoginCheckIncorrect;
var
  ReturnValue: Integer;
begin
  ReturnValue := FfrmCondition.LoginCheck('abc', '0000');
  CheckEquals(ReturnValue, LOGIN_RESULT_INCORRECT, 'Id와 비밀번호 비일치');
end;

procedure TestTfrmCondition.TestLoginCheckOK;
var
  ReturnValue: Integer;
begin
  ReturnValue := FfrmCondition.LoginCheck('abc', '123');
  CheckEquals(ReturnValue, LOGIN_RESULT_OK, 'OK');
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTfrmCondition.Suite);
end.

