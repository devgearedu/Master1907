
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
program RESTClientWithUserTypes;

uses
  Forms,
  RESTFormUnit58 in 'RESTFormUnit58.pas' {Form61},
  RESTClientClassesUnit7 in 'RESTClientClassesUnit7.pas',
  RESTClientModuleUnit9 in 'RESTClientModuleUnit9.pas' {ClientModule9: TDataModule},
  StringsField in 'StringsField.pas',
  PersonISODate in 'PersonISODate.pas',
  Person1 in 'Person1.pas',
  MarshalUnsupportedFields in 'MarshalUnsupportedFields.pas',
  MarshallingUtils in 'MarshallingUtils.pas',
  GenericListField in 'GenericListField.pas';

{$R *.res}

type
  TNeverFreed = class

  end;
begin
//  TNeverFreed.Create; // Make sure fastmm is detecting memory leaks
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm61, Form61);
  Application.CreateForm(TClientModule9, ClientModule9);
  Application.Run;
end.
