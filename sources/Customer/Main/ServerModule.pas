unit ServerModule;

{$I ..\compile.inc}

interface

uses
  Classes, Dialogs, SysUtils, uniGUIServer, uniGUIMainModule, uniGUIApplication, uIdCustomHTTPServer,
  uniGUITypes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.ConsoleUI.Wait, FireDAC.VCLUI.Error, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, Data.DB, uniThreadTimer

  ,Windows, Messages, Winapi.ShellAPI, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet
  ;

type
  TUniServerModule = class(TUniGUIServerModule)
    FDManager: TFDManager;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDGUIxErrorDialog: TFDGUIxErrorDialog;
    FDConnection: TFDConnection;
    procedure UniGUIServerModuleCreate(Sender: TObject);
    procedure UniGUIServerModuleDestroy(Sender: TObject);
    procedure UniGUIServerModuleBeforeInit(Sender: TObject);
  private
    { Private declarations }

    function dbConnect(): Boolean;
    function ClientRegistrationRequest(AHash: string): Integer;

  protected
    procedure FirstInit; override;

  public

  end;

  function UniServerModule: TUniServerModule;

  /// <summary>
  ///  ExploreWeb - �������������� ������ ���������� � ��������
  ///               ��� ��������� ����������
  ///</summary>
  procedure ExploreWeb(page:PChar);

implementation

{$R *.dfm}

uses
  UniGUIVars, uIdSSLOpenSSLHeaders, uSqlUtils, uniGUI.Loading;

function UniServerModule: TUniServerModule;
begin
  Result := TUniServerModule(UniGUIServerInstance);
end;


function TUniServerModule.dbConnect: Boolean;
begin
  Logger.AddLog('TUniServerModule.dbConnect', 'begin');
  try
    try
      FDConnection.ConnectionDefName:='Connection';

      FDConnection.Params.Values['DriverID'] :=FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['DriverID'];

      // ��������� ����������� �� ini �����
      Logger.AddLog('TUniServerModule ��������� �����������', 'FDConnection');
      Logger.AddLog('TUniServerModule FDTaskConnection DriverID', FDConnection.Params.Values['DriverID']);
      Logger.AddLog('TUniServerModule DriverID',    FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['DriverID']);
      Logger.AddLog('TUniServerModule Server',      FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['Server']);
      Logger.AddLog('TUniServerModule Database',    FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['Database']);
      Logger.AddLog('TUniServerModule User_name',   FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['User_name']);

      Logger.AddLog('TUniServerModule ConnectionDefFileName', FDManager.ConnectionDefFileName);
      FDConnection.Connected := True;

    except
      on E: EFDDBEngineException do
      case E.Kind of
        ekUserPwdInvalid:
          Logger.AddLog('TUniMainModule ekUserPwdInvalid', '��� ������������ ��� ������ �������! '+ #13#10+#13#10+E.ClassName+' ������� ������, � ����������: '+E.Message);
        ekUserPwdExpired:
          Logger.AddLog('TUniMainModule ekUserPwdExpired', '������ ����������� � ��. ���� �������� ������ ������������ �����! ' +#13#10+#13#10+E.ClassName+' ������� ������, � ����������: '+E.Message);
        ekServerGone:
          Logger.AddLog('TUniMainModule ekServerGone', '������ ���������� � ����� ������. ���� ���������� �� �����-�� �������! ' +#13#10+#13#10+E.ClassName+' ������� ������, � ����������: '+E.Message);
      else // other issues
        Logger.AddLog('TUniMainModule Other issues', '������ ���������� � ����� ������. ����������� ������! ' +#13#10+#13#10+E.ClassName+' ������� ������, � ����������: '+E.Message);
      end;
      on E : Exception do
        Logger.AddLog('TUniMainModule Exception', E.ClassName+' ������� ������, � ����������: '+#13#10+#13#10+E.Message);
    end;
  finally
    result:=FDConnection.Connected;
    Logger.AddLog('TUniServerModule.dbConnect', 'end');
  end;
end;

procedure TUniServerModule.FirstInit;
begin
  InitServerModule(Self);
end;


procedure TUniServerModule.UniGUIServerModuleBeforeInit(Sender: TObject);
begin
//{$ifndef UNIGUI_VCL}
//  Self.ExtRoot:='ext-7.2.0';
//  Self.UniRoot:='uni-1.90.0.1530';
//{$endif}
end;

procedure TUniServerModule.UniGUIServerModuleCreate(Sender: TObject);
begin
  Logger.AddLog('TUniServerModule.UniGUIServerModuleCreate', 'Begin');

    // Teste com numeros de 01 a 12
  TLoading.Render('12');

  {$IFDEF UNIGUI_VCL}
  ExploreWeb('http://127.0.0.1:8079');
  {$ENDIF}

  FDManager.DriverDefFileName     := UniServerModule.StartPath + 'Drivers.ini';
  FDManager.ConnectionDefFileName := UniServerModule.StartPath + 'Connection.ini';
  FDManager.DriverDefFileAutoLoad := True;
  FDManager.ConnectionDefFileAutoLoad := True;
  FDManager.Active := True;

  Logger.AddLog('TUniServerModule.SessionTimeout', FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['SessionTimeout']);

  if FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['FrameworkFilesRoot']<> '' then
    FrameworkFilesRoot := FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['FrameworkFilesRoot'];

  if FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['SessionTimeout'].ToInteger > 0 then
    SessionTimeout := FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['SessionTimeout'].ToInteger
  else
    SessionTimeout := 600000; // 10 �����

  {$IFDEF DEBUG}
      Title := FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['ApplicationName']+
               '. ��: '+
               FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['Database'];
  {$ELSE}
      Title := FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['ApplicationName'];
  {$ENDIF}

  dbConnect;

  Logger.AddLog('TUniServerModule.UniGUIServerModuleCreate', 'End');
end;

procedure TUniServerModule.UniGUIServerModuleDestroy(Sender: TObject);
begin
  FDManager.Close;
end;

function TUniServerModule.ClientRegistrationRequest(AHash: string): Integer;
var Query: TFDQuery;
begin
  Result := 0;
  try  
    Query:= TFDQuery.Create(nil);
    Query.Connection := FDConnection;
    Query.SQL.Text:=
             ' declare @R int '+
             ' exec @R= ClientRegistrationConfirmed @Hash = :Hash '+
             ' Select @R as R';
             
    Query.ParamByName('Hash').AsString := AHash;
    Query.Open();
    Result := Query.FieldByName('R').AsInteger
  finally
    FreeAndNil(Query);	
  end;
end;

procedure ExploreWeb(page:PChar);
var Returnvalue: Integer;
begin
  Returnvalue := ShellExecute(0,'open',page, nil, nil, 1);
  if Returnvalue <= 32  then
    begin
      case Returnvalue of
         0: ShowMessage ('������, ������������� ������!');
         2: ShowMessage ('������, ������ ����� �����!');
         3: ShowMessage ('������, ������ ����� ����!');
         11: ShowMessage ('������, ���� EXE ��������������!');
      else
        ShowMessage (PCHAR ('��� ������: '+ InttoStr (ReturnValue) +', ����������, ��������� ������. '));
      end;
    end;
end;

initialization
  RegisterServerModuleClass(TUniServerModule);
end.
