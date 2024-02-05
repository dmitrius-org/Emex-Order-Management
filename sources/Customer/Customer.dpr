{$I compile.inc}

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
  TimeIntervals in '..\Common\logger\TimeIntervals.pas',
  uLogger in '..\Common\logger\uLogger.pas',
  uLoggerF in '..\Common\logger\uLoggerF.pas' {LoggerF: TUniForm},
  uUtils in '..\Common\logger\uUtils.pas',
  uVarUtils in '..\Common\Common\uVarUtils.pas',
  uAuditUtils in '..\Common\CommonApp\uAuditUtils.pas',
  ServerModule in 'Main\ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'Main\MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main\Main.pas' {MainForm: TUniForm},
  LoginForm in 'Main\LoginForm.pas' {LoginF: TUniLoginForm},
  uBasket in 'App\uBasket.pas' {BasketF: TUniFrame},
  LoginEditForm in 'Main\LoginEditForm.pas' {LoginEditF: TUniForm},
  InfoForm in 'Main\InfoForm.pas' {Info: TUniForm},
  uOrdersProtocol_T in 'App\Orders\uOrdersProtocol_T.pas' {OrdersProtocol_T: TUniForm},
  uOrdersT2 in 'App\Orders\uOrdersT2.pas' {OrdersT2: TUniFrame},
  uUserRegisterF in 'Main\uUserRegisterF.pas' {UserRegisterF: TUniForm},
  uSearch in 'App\uSearch.pas' {SearchF: TUniFrame},
  uOrderF in 'App\Orders\uOrderF.pas' {OrderF: TUniForm},
  uEmail.gmail in '..\Common\Common\uEmail.gmail.pas',
  uFileU in '..\Common\Common\uFileU.pas',
  uGridUtils in '..\Common\Common\uGridUtils.pas',
  uEmexService in '..\Common\CommonApp\emexdwc\uEmexService.pas',
  uEmexUtils in 'App\uEmexUtils.pas',
  uToast in '..\Common\CommonApp\uToast.pas',
  uOrdersMessageF in 'App\Orders\uOrdersMessageF.pas' {OrdersMessageF: TUniForm};

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

