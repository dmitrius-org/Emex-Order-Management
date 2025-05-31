object UniServerModule: TUniServerModule
  OnCreate = UniGUIServerModuleCreate
  OnDestroy = UniGUIServerModuleDestroy
  TempFolder = 'temp\'
  FrameworkFilesRoot = 'C:\Program Files (x86)\FMSoft\1583\Framework\uniGUI'
  SessionTimeout = 86400000
  Port = 8087
  Title = 'Managers'
  FaviconOptions = [foVisible]
  AjaxTimeout = 500000
  SuppressErrors = [errObjectNotFound]
  Bindings = <>
  MainFormDisplayMode = mfPage
  ServerMessages.UnavailableErrMsg = #1054#1096#1080#1073#1082#1072' '#1089#1074#1103#1079#1080'.'
  ServerMessages.LoadingMessage = #1047#1072#1075#1088#1091#1079#1082#1072'..'
  ServerMessages.InvalidSessionMessage = #1048#1089#1090#1077#1082#1083#1086' '#1074#1088#1077#1084#1103' '#1086#1078#1080#1076#1072#1085#1080#1103' '#1089#1077#1072#1085#1089#1072'.'
  ServerMessages.TerminateMessage = #1042#1077#1073'-'#1089#1077#1072#1085#1089' '#1079#1072#1074#1077#1088#1096#1077#1085'.'
  ExtLocale = 'ru'
  ServerLimits.MaxSessions = 500
  ServerLimits.MaxConnections = 1000
  SSL.SSLOptions.RootCertFile = 'root.pem'
  SSL.SSLOptions.CertFile = 'cert.pem'
  SSL.SSLOptions.KeyFile = 'key.pem'
  SSL.SSLOptions.Method = sslvSSLv23
  SSL.SSLOptions.SSLVersions = [sslvTLSv1_1, sslvTLSv1_2]
  SSL.SSLOptions.Mode = sslmUnassigned
  SSL.SSLOptions.VerifyMode = []
  SSL.SSLOptions.VerifyDepth = 0
  Options = [soAutoPlatformSwitch, soRestartSessionOnTimeout, soWipeShadowSessions, soLogSessionCreate, soLogSessionTerminate, soDontCompressDownloads, soEnableSessionMonitor, soEnableSessionMonitorAdmin]
  ServerLogger.Options = [logIndyExceptions, logSessionExceptions, logIndySSLExceptions, logIndySSLCryptoExceptions]
  ConnectionFailureRecovery.DetailedLog = True
  ConnectionFailureRecovery.FullSequenceLog = True
  ConnectionFailureRecovery.ErrorMessage = #1054#1096#1080#1073#1082#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
  ConnectionFailureRecovery.RetryMessage = #1055#1086#1074#1090#1086#1088#1085#1072#1103' '#1087#1086#1087#1099#1090#1082#1072'...'
  OnBeforeInit = UniGUIServerModuleBeforeInit
  OnHTTPCommand = UniGUIServerModuleHTTPCommand
  Height = 239
  Width = 611
  object FDManager: TFDManager
    DriverDefFileAutoLoad = False
    ConnectionDefFileAutoLoad = False
    WaitCursor = gcrAppWait
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 102
    Top = 26
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrAppWait
    Left = 209
    Top = 25
  end
  object FDGUIxErrorDialog: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 207
    Top = 97
  end
end
