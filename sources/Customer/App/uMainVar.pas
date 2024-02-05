unit uMainVar;

interface

uses
  uSqlUtils, uLogger, uCommonType;

  function Sql: TSql;

  function RetVal: TRetVal;

  function SPID: Integer;

implementation

uses
  MainModule;

function Sql: TSql;
begin
  if not Assigned(MainModule.UniMainModule.ASql) then
    MainModule.UniMainModule.ASql := TSql.Create(MainModule.UniMainModule.FDConnection);

  Result := MainModule.UniMainModule.ASql;
end;

function RetVal: TRetVal;
begin
  if not Assigned(MainModule.UniMainModule.ARetVal) then
    MainModule.UniMainModule.ARetVal := tRetVal.Create(MainModule.UniMainModule.FDConnection);

  RetVal := MainModule.UniMainModule.ARetVal;
end;

function SPID: Integer;
begin
  Result := MainModule.UniMainModule.ASPID;
end;

end.
