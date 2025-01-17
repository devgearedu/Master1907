
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program UsageTrackerDemo;

uses
  Forms,
  DemoForm in 'DemoForm.pas' {fDemo};

{$R *.res}

{This application supports an extended user address space.}
{$SetPEFlags $20}

begin
  Application.Initialize;
  Application.CreateForm(TfDemo, fDemo);
  Application.Run;
end.
