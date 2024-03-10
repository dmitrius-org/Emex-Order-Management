object UniServerModule: TUniServerModule
  OnCreate = UniGUIServerModuleCreate
  OnDestroy = UniGUIServerModuleDestroy
  TempFolder = 'temp\'
  FrameworkFilesRoot = 'C:\Program Files (x86)\FMSoft\Framework\uniGUI'
  SessionTimeout = 86400000
  Port = 8078
  Title = 'Task Manager'
  AjaxTimeout = 500000
  UseGlobalImageCache = False
  SuppressErrors = []
  Bindings = <>
  MainFormDisplayMode = mfPage
  CustomFiles.Strings = (
    'files/css/main_menu.css'
    'files/css/grid.css'
    ''
    '')
  ExtLocale = 'ru'
  SSL.SSLOptions.RootCertFile = 'root.pem'
  SSL.SSLOptions.CertFile = 'cert.pem'
  SSL.SSLOptions.KeyFile = 'key.pem'
  SSL.SSLOptions.Method = sslvSSLv23
  SSL.SSLOptions.SSLVersions = [sslvTLSv1_1, sslvTLSv1_2]
  SSL.SSLOptions.Mode = sslmUnassigned
  SSL.SSLOptions.VerifyMode = []
  SSL.SSLOptions.VerifyDepth = 0
  Options = [soAutoPlatformSwitch, soWipeShadowSessions, soDontCompressDownloads, soEnableSessionMonitor, soEnableSessionMonitorAdmin]
  ServerLogger.Options = [logIndyExceptions, logSessionExceptions, logIndySSLExceptions, logIndySSLCryptoExceptions]
  ConnectionFailureRecovery.DetailedLog = True
  ConnectionFailureRecovery.FullSequenceLog = True
  ConnectionFailureRecovery.ErrorMessage = #1054#1096#1080#1073#1082#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
  ConnectionFailureRecovery.RetryMessage = #1055#1086#1074#1090#1086#1088#1085#1072#1103' '#1087#1086#1087#1099#1090#1082#1072'...'
  OnException = UniGUIServerModuleException
  Height = 281
  Width = 776
  object FDManager: TFDManager
    DriverDefFileAutoLoad = False
    ConnectionDefFileAutoLoad = False
    WaitCursor = gcrAppWait
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 78
    Top = 26
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Console'
    ScreenCursor = gcrAppWait
    Left = 185
    Top = 25
  end
  object FDGUIxErrorDialog: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 183
    Top = 97
  end
  object FDTaskConnection: TFDConnection
    ConnectionName = 'TaskConnection'
    LoginPrompt = False
    OnError = FDTaskConnectionError
    Left = 452
    Top = 23
  end
  object UniThreadTimer: TUniThreadTimer
    OnTimer = UniThreadTimerTimer
    Interval = 10000
    Left = 449
    Top = 97
  end
  object DBAlert: TFDEventAlerter
    Connection = FDTaskConnection
    OnAlert = DBAlertAlert
    Left = 608
    Top = 21
  end
end
