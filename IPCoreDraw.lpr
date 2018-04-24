program IPCoreDraw;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, mainformu, uglobal
  { you can add units after this };

{$R *.res}

begin
  Application.Scaled:=True;
//  Application.Scaled:=True;
//  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TIPCoreDrawF, IPCoreDrawF);
  Application.Run;
end.

