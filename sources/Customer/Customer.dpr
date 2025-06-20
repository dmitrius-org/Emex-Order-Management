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
  Customer;

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
  uCommonType in '..\Common\Common\uCommonType.pas',
  uSqlUtils in '..\Common\Common\uSqlUtils.pas',
  uMainVar in 'App\uMainVar.pas',
  uLoggerF in '..\Common\logger\uLoggerF.pas' {LoggerF: TUniForm},
  uUtils.Varriant in '..\Common\Common\uUtils.Varriant.pas',
  uAuditUtils in '..\Common\CommonApp\uAuditUtils.pas',
  ServerModule in 'Main\ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'Main\MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main\Main.pas' {MainForm: TUniForm},
  LoginForm in 'Main\LoginForm.pas' {LoginF: TUniLoginForm},
  uBasket in 'App\uBasket.pas' {BasketF: TUniFrame},
  InfoForm in 'Main\InfoForm.pas' {Info: TUniForm},
  uOrdersProtocol_T in 'App\Orders\uOrdersProtocol_T.pas' {OrdersProtocol_T: TUniForm},
  uOrdersT2 in 'App\Orders\uOrdersT2.pas' {OrdersT2: TUniFrame},
  uUserResetF in 'Main\uUserResetF.pas' {UserResetF: TUniForm},
  uSearch in 'App\uSearch.pas' {SearchF: TUniFrame},
  uOrderF in 'App\Orders\uOrderF.pas' {OrderF: TUniForm},
  uEmail.gmail in '..\Common\Common\uEmail.gmail.pas',
  uFileU in '..\Common\Common\uFileU.pas',
  uEmexUtils in 'App\uEmexUtils.pas',
  uToast in '..\Common\CommonApp\uToast.pas',
  uApp in '..\Common\Common\uApp.pas',
  uUserRegisterF in 'Main\uUserRegisterF.pas' {UserRegisterF: TUniForm},
  uError_T in '..\Common\CommonApp\uError_T.pas' {Error_T: TUniForm},
  uUtils.Grid in '..\Common\Common\uUtils.Grid.pas',
  uniGUI.Loading in '..\Common\Loading\uniGUI.Loading.pas',
  uBalanceTotalT in '..\Common\Balance\uBalanceTotalT.pas' {BalanceTotalT: TUniFrame},
  uUtils.WS in '..\Common\CommonApp\uUtils.WS.pas',
  uMessengerF in 'App\Messenger\uMessengerF.pas' {MessageF: TUniForm},
  uMessengerMessage in '..\Common\Messenger\uMessengerMessage.pas' {Message: TUniFrame},
  uUtils.Math in '..\Common\Common\uUtils.Math.pas',
  uServiceEmex in '..\Service\uServiceEmex.pas',
  uConstant in '..\Common\CommonApp\uConstant.pas',
  uReOrderF in 'App\Orders\uReOrderF.pas' {ReOrder: TUniForm},
  uUtils.Mark in '..\Common\CommonApp\uUtils.Mark.pas',
  uVersion in '..\Common\CommonApp\uVersion.pas',
  uStatisticOrders in 'App\Statistics\uStatisticOrders.pas' {StatisticOrders: TUniFrame},
  uStatistics in 'App\Statistics\uStatistics.pas' {StatisticsT: TUniFrame},
  LoginEditForm in 'Main\LoginEditForm.pas' {LoginEditF: TUniForm},
  uUniMemoHelper in '..\Common\Common\uUniMemoHelper.pas',
  uStatusForm in 'App\Common\uStatusForm.pas' {StatusForm: TUniForm},
  uUniExComboBoxHelper in '..\Common\Common\uUniExComboBoxHelper.pas',
  uUtils.Logger in '..\Common\Logger\uUtils.Logger.pas',
  uUtils.BusinessComboBoxHelper in '..\Common\CommonApp\uUtils.BusinessComboBoxHelper.pas',
  uUtils.Localizer in '..\Common\Common\uUtils.Localizer.pas',
  uBaseForm in 'App\Common\uBaseForm.pas' {BaseForm: TUniForm};

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

