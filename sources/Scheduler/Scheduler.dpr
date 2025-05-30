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
  Scheduler
;

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
  uTask_F in 'Task\uTask_F.pas' {Task_F: TUniForm},
  uTask_T in 'Task\uTask_T.pas' {Task_T: TUniFrame},
  uTaskUtils in 'Task\uTaskUtils.pas',
  uCommonType in '..\Common\Common\uCommonType.pas',
  uFileU in '..\Common\Common\uFileU.pas',
  uUtils.Grid in '..\Common\Common\uUtils.Grid.pas',
  uSqlUtils in '..\Common\Common\uSqlUtils.pas',
  uUtils.Varriant in '..\Common\Common\uUtils.Varriant.pas',
  uLoggerF in '..\Common\logger\uLoggerF.pas' {LoggerF: TUniForm},
  uGrantUtils in '..\Common\CommonApp\uGrantUtils.pas',
  LoginEditForm in '..\Common\Login\LoginEditForm.pas' {LoginEditF: TUniForm},
  InfoForm in '..\Common\InfoForm.pas' {Info: TUniForm},
  uAuditUtils in '..\Common\CommonApp\uAuditUtils.pas',
  uMainVar in '..\Common\uMainVar.pas',
  uError_T in '..\Common\CommonApp\uError_T.pas' {Error_T: TUniForm},
  LoginForm in '..\Common\Login\LoginForm.pas' {LoginF: TUniLoginForm},
  uTaskBat_F in 'Task\uTaskBat_F.pas' {TaskBAT_F: TUniForm},
  uTaskProcedure_F in 'Task\uTaskProcedure_F.pas' {TaskProcedure_F: TUniForm},
  uTaskSQL_F in 'Task\uTaskSQL_F.pas' {TaskSQL_F: TUniForm},
  uTaskActionHead in 'Task\uTaskActionHead.pas' {TaskActionHead: TUniFrame},
  uConstant in '..\Common\CommonApp\uConstant.pas',
  uAccrualUtils in '..\Manager\App\Orders\uAccrualUtils.pas',
  uServiceEmex in '..\Service\uServiceEmex.pas',
  uEmexUtils in '..\Manager\App\emexdwc\uEmexUtils.pas',
  uUtils.Logger in '..\Common\Logger\uUtils.Logger.pas';

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
  //ReportMemoryLeaksOnShutdown:=True;  // Optional.
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
{$ENDIF}
end.

