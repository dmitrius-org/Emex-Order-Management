 unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, uniGUIForm, uniGUITypes, vcl.Dialogs,
  FireDAC.Moni.Base, FireDAC.Moni.FlatFile,
  FireDAC.Phys.FB,
  FireDAC.Phys.MySQL, FireDAC.Phys.ODBCBase, FireDAC.Moni.Custom,

  uCommonType, uAuditUtils, uAccrualUtils, uEmexUtils, uSqlUtils, uLogger,
  uGrantUtils, FireDAC.Moni.RemoteClient
  ;

type
  TUniMainModule = class(TUniGUIMainModule)
    FDConnection: TFDConnection;
    Query: TFDQuery;
    FDMoniFlatFileClientLink: TFDMoniFlatFileClientLink;
    qSetting: TFDQuery;
    FDMoniRemoteClientLink1: TFDMoniRemoteClientLink;
//    procedure AddConnectionDef(Sender: TObject);
    procedure UniGUIMainModuleDestroy(Sender: TObject);
    procedure UniGUIMainModuleBeforeLogin(Sender: TObject; var Handled:Boolean);
    procedure UniGUIMainModuleCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    /// <summary> AUserName - ����� ������������ </summary>
    AUserName: string;
    /// <summary> ASql -  </summary>
    ASql     : TSql;
    /// <summary> ARetVal -  </summary>
    ARetVal  : TRetVal;
    /// <summary> AAudit -  </summary>
    AAudit   : TAudit;
    /// <summary> AGrant -  </summary>
    AGrant: TGrant;

    ASPID: Integer;

    function dbConnect(AUser: string; APass: string; ABefore: Boolean = false): Boolean;
  end;

function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses
  UniGUIVars, ServerModule, uniGUIApplication, uMainVar;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;

//procedure TUniMainModule.AddConnectionDef(Sender: TObject);
//var
//  myDef: IFDStanConnectionDef;
//  i:integer;
//begin
//  with UniMainModule do
//  begin
//    //��������� ��� �� ��� ConnDef � ����� �� ������
//    if FDManager.IsConnectionDef('MSSQL_Connection') then Exit;
//
//    //�����, ���������, ���� ConnDef c ������ MSSQL_Connection �����������
//    myDef:=FDManager.ConnectionDefs.AddConnectionDef;
//    myDef.Name:='MSSQL_Connection';
//    myDef.Params.DriverID:='';
//    myDef.Params.Database:='';
//
//    // ����� ������ ������� ���������� ����������
//    myDef.Params.Add('Server=');
//    myDef.Params.Add('Port=');
//    myDef.Params.Add('CharacterSet=utf8');
//
//    // ��������� ��������� � ����� FDConnectionDefs.ini
//    myDef.Apply;
//    FDManager.Open;
//  end;
//end;

function TUniMainModule.dbConnect(AUser: string; APass: string; ABefore: Boolean = false): Boolean;
begin
  UniServerModule.Logger.AddLog('TUniMainModule.dbConnect', 'Begin');
  try
    result:=False;
    try


      FDConnection.ConnectionDefName:='Connection';
      UniServerModule.Logger.AddLog('TUniMainModule FDConnection DriverID', FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['DriverID']);
      FDConnection.Params.Values['DriverID'] :=FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['DriverID'];

      if (AUser<>'') and (APass<>'') then
      begin
        FDConnection.Params.Add('User_name=' + AUser);
        FDConnection.Params.Add('Password='  + APass);
      end;

      // ��������� ����������� �� ini �����
      UniServerModule.Logger.AddLog('TUniMainModule ��������� �����������', 'FDConnection');
      UniServerModule.Logger.AddLog('TUniMainModule FDConnection DriverID', FDConnection.Params.Values['DriverID']);
      UniServerModule.Logger.AddLog('TUniMainModule DriverID',  FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['DriverID']);
      UniServerModule.Logger.AddLog('TUniMainModule Server',    FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['Server']);
      UniServerModule.Logger.AddLog('TUniMainModule Database',  FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['Database']);
      UniServerModule.Logger.AddLog('TUniMainModule User_name', FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['User_name']);
      UniServerModule.Logger.AddLog('TUniMainModule ConnectionDefFileName', FDManager.ConnectionDefFileName);

      FDConnection.Open;

      AUserName:=AUser;
      ASPID := FDConnection.ExecSQLScalar('Select @@Spid');


      // ���������  �����������
      CreateDefLogger(UniServerModule.Logger.RootPath + '\log\' + AUserName + '_app_' + FormatDateTime('ddmmyyyy', Now) +'.log');

      Sql.Open('Select AppClientLog, AppSqlLog from tLoggerSettings (nolock) where UserID = dbo.GetUserID() ', [],[]);
      if Sql.Q.RecordCount > 0 then
      begin
        logger.isActive := Sql.Q.FindField('AppClientLog').Value;
        logger.Info('��������� ��������');

        FDMoniFlatFileClientLink.FileName := UniServerModule.Logger.RootPath + '\log\' + AUserName + '_sql_' + FormatDateTime('ddmmyyyy', Now) +'.log';
        FDMoniFlatFileClientLink.Tracing := Sql.Q.FindField('AppSqlLog').Value;
      end;
      Audit.Add(TObjectType.otAuthorization, 0, TFormAction.acLogin, '���� � �������');

    except
      on E: EFDDBEngineException do
      case E.Kind of
        ekUserPwdInvalid:
        begin
          if not ABefore then
          begin
           raise Exception.Create('��� ������������ ��� ������ �������!'{+ #13#10+#13#10+E.ClassName+' ������� ������, � ����������: '+E.Message});
//          UniSession.AddJS('alert("��� ������������ ��� ������ �������! ")')
          end
        end;
        ekUserPwdExpired:
        if not ABefore then
        begin
//          UniSession.AddJS('alert("������ ����������� � ��. ���� �������� ������ ������������ �����!")');
          raise Exception.Create('������ ����������� � ��. ���� �������� ������ ������������ �����!' {+#13#10+#13#10+E.ClassName+' ������� ������, � ����������: '+E.Message});
        end;
        ekServerGone:
//        UniSession.AddJS('alert("������ ���������� � ����� ������. ���� ���������� �� �����-�� �������!")')
          raise Exception.Create('������ ���������� � ����� ������. ���� ���������� �� �����-�� �������!' {+#13#10+#13#10+E.ClassName+' ������� ������, � ����������: '+E.Message});
      else // other issues
//         UniSession.AddJS('alert("������ ���������� � ����� ������. ����������� ������! ")')
        raise Exception.Create('������ ���������� � ����� ������. ����������� ������!' {+#13#10+#13#10+E.ClassName+' ������� ������, � ����������: '+E.Message});
      end;
      on E : Exception do
//        UniSession.AddJS('alert("'+E.ClassName+' ������� ������, � ����������: '+#13#10+#13#10+E.Message + '")')
        raise Exception.Create(E.ClassName+' ������� ������, � ����������: '+#13#10+#13#10+E.Message);
    end;

  finally
    result:=FDConnection.Connected;
    UniServerModule.Logger.AddLog('TUniMainModule.dbConnect', 'End');
  end;
end;

procedure TUniMainModule.UniGUIMainModuleBeforeLogin(Sender: TObject; var Handled: Boolean);
var S1, S2 : string;
begin
  UniServerModule.Logger.AddLog('TUniMainModule.UniGUIMainModuleBeforeLogin', 'begin');

  S1 := (Sender as TUniGUISession).UniApplication.Cookies.Values['_loginname'];
  S2 := (Sender as TUniGUISession).UniApplication.Cookies.Values['_pwd'];

  if (S1 <> '') and ( S2 <> '') then
  begin
    Handled := dbConnect ( S1,  S2, True );

    if Handled = False then
    begin
//       UniServerModule.Logger.AddLog('TUniMainModule.UniGUIMainModuleBeforeLogin', DateTimeToStr(Date));
//       UniServerModule.Logger.AddLog('TUniMainModule.UniGUIMainModuleBeforeLogin', DateTimeToStr(Date-1));

      (Sender as TUniGUISession).UniApplication.Cookies.SetCookie('_loginname','',Date-1);
      (Sender as TUniGUISession).UniApplication.Cookies.SetCookie('_pwd','',Date-1);
    end;

  end;
  UniServerModule.Logger.AddLog('TUniMainModule.UniGUIMainModuleBeforeLogin', 'end');
end;

procedure TUniMainModule.UniGUIMainModuleCreate(Sender: TObject);
begin
  {$IFDEF RELEASE}
  BackButtonAction := TUniBackButtonAction.bbaWarnUser;
  {$ENDIF}



end;

procedure TUniMainModule.UniGUIMainModuleDestroy(Sender: TObject);
begin
  Audit.Add(TObjectType.otAuthorization, 0, TFormAction.acLogin, '����� �� �������');

  FDConnection.Close;

  logger.Info('��������� �����������');
  FreeDefLogger;
end;

initialization
  RegisterMainModuleClass(TUniMainModule);
end.
