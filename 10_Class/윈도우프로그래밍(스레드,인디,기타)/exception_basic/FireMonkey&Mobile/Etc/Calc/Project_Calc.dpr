program Project_Calc;

uses
  System.StartUpCopy,
  FMX.Forms,
  UCalc in 'UCalc.pas' {CalcForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TCalcForm, CalcForm);
  Application.Run;
end.
