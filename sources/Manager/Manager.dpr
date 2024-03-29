 {$I ..\compile.inc}

{$IFDEF UNIGUI_SERVICE}
  {$EXTENSION exe}
  program
{$ENDIF}
{$IFDEF UNIGUI_VCL}
  {$EXTENSION exe}
  program
{$ENDIF}
{$IFDEF UNIGUI_ISAPI}
  {$EXTENSION dll}
  library
{$ENDIF}
  Manager;

uses
  {$IFDEF UNIGUI_SERVICE}
  SvcMgr,
  {$ENDIF }
  {$IFDEF UNIGUI_VCL}
  Forms,
  {$ENDIF }
  {$IFDEF UNIGUI_ISAPI}
  uniGUIISAPI,
  {$ENDIF }
  ServerModule in 'Main\ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'Main\MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main\Main.pas' {MainForm: TUniForm},
  uStatistics in 'App\Statistics\uStatistics.pas' {StatisticsT: TUniFrame},
  uGrant in 'Core\User\uGrant.pas' {GrantF: TUniForm},
  uGroupsT in 'Core\User\uGroupsT.pas' {GroupsT: TUniFrame},
  uNodesT in 'Core\Instrument\uNodesT.pas' {NodesT: TUniFrame},
  uInstructionsF in 'App\Instructions\uInstructionsF.pas' {InstructionsF: TUniForm},
  uInstrumentStateT in 'Core\Instrument\uInstrumentStateT.pas' {InstrumentStateT: TUniFrame},
  uGrantClient in 'Core\User\uGrantClient.pas' {GrantClientT: TUniFrame},
  uSettingsT in 'Core\Instrument\uSettingsT.pas' {SettingsT: TUniFrame},
  uBalanceAddF in 'App\Clients\uBalanceAddF.pas' {BalanceAddF: TUniForm},
  uInstrument in 'Core\Instrument\uInstrument.pas' {InstrumentT: TUniFrame},
  uInstrumentF in 'Core\Instrument\uInstrumentF.pas' {UnstrumentF: TUniForm},
  uBalanceT in 'App\Clients\uBalanceT.pas' {BalanceT: TUniForm},
  uRefusalsT in 'App\Orders\uRefusalsT.pas' {RefusalsT: TUniFrame},
  uShipmentsT in 'App\Shipments\uShipmentsT.pas' {ShipmentsT: TUniFrame},
  uEmployeesT in 'App\Employees\uEmployeesT.pas' {EmployeesT: TUniFrame},
  uOrdersMessageF in 'App\Orders\uOrdersMessageF.pas' {OrdersMessageF: TUniForm},
  uTexT in 'Core\uTexT.pas' {TexT: TUniFrame},
  uClientsT in 'App\Clients\uClientsT.pas' {ClientsT: TUniFrame},
  uUploadingRefusals in 'App\Orders\uUploadingRefusals.pas',
  uGroupF in 'Core\User\uGroupF.pas' {GroupF: TUniForm},
  uClientsF in 'App\Clients\uClientsF.pas' {ClientsF: TUniForm},
  uPricesT in 'App\Prices\uPricesT.pas' {PricesT: TUniFrame},
  uSuppliersF in 'App\Suppliers\uSuppliersF.pas' {SuppliersF: TUniForm},
  uUserT in 'Core\User\uUserT.pas' {UsersT: TUniFrame},
  uUserF in 'Core\User\uUserF.pas' {UserF: TUniForm},
  uInstrumentActionT in 'Core\Instrument\uInstrumentActionT.pas' {InstrumentActionT: TUniFrame},
  uHome in 'App\uHome.pas' {HomeF: TUniFrame},
  uOrdersF in 'App\Orders\uOrdersF.pas' {OrderF: TUniForm},
  uSuppliersT in 'App\Suppliers\uSuppliersT.pas' {SuppliersT: TUniFrame},
  uOrdersT in 'App\Orders\uOrdersT.pas' {OrdersT: TUniFrame},
  TimeIntervals in '..\Common\logger\TimeIntervals.pas',
  uLogger in '..\Common\logger\uLogger.pas',
  uLoggerF in '..\Common\logger\uLoggerF.pas' {LoggerF: TUniForm},
  uUtils in '..\Common\logger\uUtils.pas',
  LoginEditForm in '..\Common\Login\LoginEditForm.pas' {LoginEditF: TUniForm},
  LoginForm in '..\Common\Login\LoginForm.pas' {LoginF: TUniLoginForm},
  InfoForm in '..\Common\InfoForm.pas' {Info: TUniForm},
  uGrantUtils in '..\Common\CommonApp\uGrantUtils.pas',
  uMainVar in '..\Common\uMainVar.pas',
  uCommonType in '..\Common\Common\uCommonType.pas',
  uFileU in '..\Common\Common\uFileU.pas',
  uGridUtils in '..\Common\Common\uGridUtils.pas',
  uSqlUtils in '..\Common\Common\uSqlUtils.pas',
  uVarUtils in '..\Common\Common\uVarUtils.pas',
  uEmexService in '..\Common\CommonApp\emexdwc\uEmexService.pas',
  uEmexUtils in '..\Common\CommonApp\emexdwc\uEmexUtils.pas',
  uAuditUtils in '..\Common\CommonApp\uAuditUtils.pas',
  uError_T in '..\Common\CommonApp\uError_T.pas' {Error_T: TUniForm},
  uAccrualUtils in '..\Common\CommonApp\uAccrualUtils.pas',
  uLookupF in '..\Common\CommonApp\uLookupF.pas' {LookupF: TUniForm},
  uToast in '..\Common\CommonApp\uToast.pas',
  uTask_F in '..\Scheduler\Task\uTask_F.pas' {Task_F: TUniForm},
  uTask_T in '..\Scheduler\Task\uTask_T.pas' {Task_T: TUniFrame},
  uTaskUtils in '..\Scheduler\Task\uTaskUtils.pas',
  uEmployeesF in 'App\Employees\uEmployeesF.pas' {EmployeesF: TUniForm},
  uClientsTypeT in 'App\Clients\uClientsTypeT.pas' {ClientsTypeT: TUniFrame},
  uOrdersProtocol_T in 'App\Orders\uOrdersProtocol_T.pas' {OrdersProtocol_T: TUniForm},
  uTaskBat_F in '..\Scheduler\Task\uTaskBat_F.pas' {TaskBAT_F: TUniForm},
  uTaskSQL_F in '..\Scheduler\Task\uTaskSQL_F.pas' {TaskSQL_F: TUniForm},
  uTaskProcedure_F in '..\Scheduler\Task\uTaskProcedure_F.pas' {TaskProcedure_F: TUniForm},
  uGroupSetFragileSignF in 'App\Orders\uGroupSetFragileSignF.pas' {GroupSetFragileSignF: TUniForm},
  uGroupDetailNameEditF in 'App\Orders\uGroupDetailNameEditF.pas' {GroupDetailNameEditF: TUniForm},
  uInstructionsT in 'App\Instructions\uInstructionsT.pas' {InstructionsT: TUniFrame},
  uNodesF in 'Core\Instrument\uNodesF.pas' {NodesF: TUniForm};

{$R *.res}


{$IFDEF UNIGUI_ISAPI}
exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;
{$ENDIF}

begin
{$IFDEF UNIGUI_SERVICE}
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TMyServiceClass, MyServiceClass);  // Get from your service module.
  Application.Run;
{$ENDIF}

{$IFDEF UNIGUI_VCL}
 // ReportMemoryLeaksOnShutdown:=True;  // Optional.
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
{$ENDIF}
end.

