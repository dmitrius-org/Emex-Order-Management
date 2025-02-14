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
  uConfluencePagesF in 'App\Confluence\uConfluencePagesF.pas' {ConfluencePagesF: TUniForm},
  uInstrumentStateT in 'Core\Instrument\uInstrumentStateT.pas' {InstrumentStateT: TUniFrame},
  uGrantClient in 'Core\User\uGrantClient.pas' {GrantClientT: TUniFrame},
  uSettingsT in 'Core\Instrument\uSettingsT.pas' {SettingsT: TUniFrame},
  uEmployeeParametersF in 'Core\User\uEmployeeParametersF.pas' {EmployeeParametersF: TUniForm},
  uInstrument in 'Core\Instrument\uInstrument.pas' {InstrumentT: TUniFrame},
  uInstrumentF in 'Core\Instrument\uInstrumentF.pas' {UnstrumentF: TUniForm},
  uBalanceT in 'App\Clients\uBalanceT.pas' {BalanceT: TUniForm},
  uRefusalsT in 'App\Orders\uRefusalsT.pas' {RefusalsT: TUniFrame},
  uShipmentsT in 'App\Shipments\uShipmentsT.pas' {ShipmentsT: TUniFrame},
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
  uUtils.Grid in '..\Common\Common\uUtils.Grid.pas',
  uSqlUtils in '..\Common\Common\uSqlUtils.pas',
  uUtils.Varriant in '..\Common\Common\uUtils.Varriant.pas',
  uAuditUtils in '..\Common\CommonApp\uAuditUtils.pas',
  uError_T in '..\Common\CommonApp\uError_T.pas' {Error_T: TUniForm},
  uLookupF in '..\Common\CommonApp\uLookupF.pas' {LookupF: TUniForm},
  uToast in '..\Common\CommonApp\uToast.pas',
  uTask_F in '..\Scheduler\Task\uTask_F.pas' {Task_F: TUniForm},
  uTask_T in '..\Scheduler\Task\uTask_T.pas' {Task_T: TUniFrame},
  uTaskUtils in '..\Scheduler\Task\uTaskUtils.pas',
  uClientsTypeT in 'App\Clients\uClientsTypeT.pas' {ClientsTypeT: TUniFrame},
  uShipmentsProtocol_T in 'App\Shipments\uShipmentsProtocol_T.pas' {ShipmentsProtocol_T: TUniForm},
  uTaskBat_F in '..\Scheduler\Task\uTaskBat_F.pas' {TaskBAT_F: TUniForm},
  uTaskSQL_F in '..\Scheduler\Task\uTaskSQL_F.pas' {TaskSQL_F: TUniForm},
  uTaskProcedure_F in '..\Scheduler\Task\uTaskProcedure_F.pas' {TaskProcedure_F: TUniForm},
  uGroupSetFragileSignF in 'App\Orders\uGroupSetFragileSignF.pas' {GroupSetFragileSignF: TUniForm},
  uGroupDetailNameEditF in 'App\Orders\uGroupDetailNameEditF.pas' {GroupDetailNameEditF: TUniForm},
  uConfluenceT in 'App\Confluence\uConfluenceT.pas' {ConfluenceT: TUniFrame},
  uNodesF in 'Core\Instrument\uNodesF.pas' {NodesF: TUniForm},
  uConstant in '..\Common\CommonApp\uConstant.pas',
  uEmexUtils in 'App\emexdwc\uEmexUtils.pas',
  uAccrualUtils in 'App\Orders\uAccrualUtils.pas',
  uStatusForm in 'App\Common\uStatusForm.pas' {StatusForm: TUniForm},
  uInstructionT in 'App\Confluence\uInstructionT.pas' {InstructionT: TUniFrame},
  uInstructionDevT in 'App\Confluence\uInstructionDevT.pas' {InstructionDevT: TUniFrame},
  PriceUpdate in 'App\DashBoard\PriceUpdate.pas' {PriceUpdateT: TUniFrame},
  uDashBoardItem in 'App\DashBoard\uDashBoardItem.pas' {DashBoardItem: TUniFrame},
  uDashBoard in 'App\DashBoard\uDashBoard.pas' {DashBoardFrame: TUniFrame},
  uGroups2T in 'Core\User\uGroups2T.pas' {Groups2T: TUniForm},
  uClientsType2T in 'App\Clients\uClientsType2T.pas' {ClientType2T: TUniForm},
  uPromptReliabilityEdit in 'App\Clients\uPromptReliabilityEdit.pas' {PromptReliabilityEdit: TUniForm},
  uPromptMarginEdit in 'App\Clients\uPromptMarginEdit.pas' {PromptMarginEdit: TUniForm},
  uExportForm in 'App\Shipments\uExportForm.pas' {ExportForm: TUniForm},
  uShipmentsEditF in 'App\Shipments\uShipmentsEditF.pas' {ShipmentsEditF: TUniForm},
  uShipmentsReceiptStatusF in 'App\Shipments\uShipmentsReceiptStatusF.pas' {ShipmentsReceivedStatusF: TUniForm},
  uShipmentsTransporterDataF in 'App\Shipments\uShipmentsTransporterDataF.pas' {ShipmentsTransporterDataF: TUniForm},
  uOrdersNewDeliveryDateF in 'App\Orders\uOrdersNewDeliveryDateF.pas' {OrdersNewDeliveryDateF: TUniForm},
  uOrdersProtocol_T in 'App\Orders\uOrdersProtocol_T.pas' {OrdersProtocol_T: TUniForm},
  uShipmentsTransporterNumberF in 'App\Shipments\uShipmentsTransporterNumberF.pas' {ShipmentsTransporterNumberF: TUniForm},
  uUtils.Controll in '..\Common\CommonApp\uUtils.Controll.pas',
  uUserProfile in 'Core\User\uUserProfile.pas' {UserProfile: TUniForm},
  uBalanceTotalT_Wrapper in 'App\Clients\uBalanceTotalT_Wrapper.pas' {BalanceTotalT_W: TUniForm},
  uBalanceTotalT in '..\Common\Balance\uBalanceTotalT.pas' {BalanceTotalT: TUniFrame},
  uUtils.Date in '..\Common\CommonApp\uUtils.Date.pas',
  uMessengerMessage in '..\Common\Messenger\uMessengerMessage.pas' {Message: TUniFrame},
  uMessengerF in 'App\Messenger\uMessengerF.pas' {MessageF: TUniForm},
  uUtils.WS in '..\Common\CommonApp\uUtils.WS.pas',
  uUtils.Math in '..\Common\Common\uUtils.Math.pas',
  uServiceEmex in '..\Service\uServiceEmex.pas',
  uUtils.Strings in '..\Common\Common\uUtils.Strings.pas',
  uStatisticCanceled in 'App\Statistics\uStatisticCanceled.pas' {StatisticCanceled: TUniFrame},
  uShipmentsBoxesT in 'App\Shipments\uShipmentsBoxesT.pas' {ShipmentsBoxesT: TUniFrame},
  uUniFSComboBoxHelper in '..\Common\Common\uUniFSComboBoxHelper.pas',
  uStringHelper in '..\Common\Common\uStringHelper.pas',
  uClientPasswordResetF in 'App\Clients\uClientPasswordResetF.pas' {ClientPasswordResetF: TUniForm},
  uBalanceAddF in 'App\Clients\uBalanceAddF.pas' {BalanceAddF: TUniForm},
  uStatisticBrand in 'App\Statistics\uStatisticBrand.pas' {StatisticBrand: TUniFrame},
  uShipmentsBoxesT_Wrapper in 'App\Shipments\uShipmentsBoxesT_Wrapper.pas' {ShipmentsBoxesT_Wrapper: TUniForm},
  uShipmentsReceiptDateF in 'App\Shipments\uShipmentsReceiptDateF.pas' {ShipmentsReceiptDateF: TUniForm},
  uUniMemoHelper in '..\Common\Common\uUniMemoHelper.pas',
  uTreeMenuHelper in '..\Common\Common\uTreeMenuHelper.pas',
  uEmployeeOrdersProcessedT_Wrapper in 'App\Employees\uEmployeeOrdersProcessedT_Wrapper.pas' {EmployeeOrdersProcessedT_Wrapper: TUniForm},
  uEmployeeOrdersProcessedT in 'App\Employees\uEmployeeOrdersProcessedT.pas' {EmployeeOrdersProcessedT: TUniFrame};

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

