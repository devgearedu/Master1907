
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program MainApp;

uses
  SimpleShareMem,
  Forms,
  MainAppForm in 'MainAppForm.pas' {fMainAppForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMainAppForm, fMainAppForm);
  Application.Run;
end.
