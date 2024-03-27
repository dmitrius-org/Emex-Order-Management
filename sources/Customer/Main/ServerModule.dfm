object UniServerModule: TUniServerModule
  OnCreate = UniGUIServerModuleCreate
  OnDestroy = UniGUIServerModuleDestroy
  TempFolder = 'temp\'
  FrameworkFilesRoot = 'C:\Program Files (x86)\FMSoft\Framework\uniGUI'
  Port = 8079
  Title = 'Customer'
  AjaxTimeout = 500000
  SuppressErrors = []
  Bindings = <>
  MainFormDisplayMode = mfPage
  CustomFiles.Strings = (
    ''
    'files/css/main_menu.css'
    'files/css/grid.css'
    'files/css/custom.css '
    ''
    'files/css/hint.css')
  ExtLocale = 'ru'
  SSL.SSLOptions.RootCertFile = 'root.pem'
  SSL.SSLOptions.CertFile = 'cert.pem'
  SSL.SSLOptions.KeyFile = 'key.pem'
  SSL.SSLOptions.Method = sslvSSLv23
  SSL.SSLOptions.SSLVersions = [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
  SSL.SSLOptions.Mode = sslmClient
  SSL.SSLOptions.VerifyMode = []
  SSL.SSLOptions.VerifyDepth = 0
  Options = [soAutoPlatformSwitch, soWipeShadowSessions, soDontCompressDownloads, soEnableSessionMonitor, soEnableSessionMonitorAdmin]
  ServerLogger.Options = [logIndyExceptions, logSessionExceptions, logIndySSLExceptions, logIndySSLCryptoExceptions]
  ConnectionFailureRecovery.DetailedLog = True
  ConnectionFailureRecovery.FullSequenceLog = True
  ConnectionFailureRecovery.ErrorMessage = 'Connection Error'
  ConnectionFailureRecovery.RetryMessage = 'Retrying...'
  OnBeforeInit = UniGUIServerModuleBeforeInit
  OnHTTPCommand = UniGUIServerModuleHTTPCommand
  Height = 261
  Width = 906
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
    Provider = 'Console'
    ScreenCursor = gcrAppWait
    Left = 209
    Top = 25
  end
  object FDGUIxErrorDialog: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 207
    Top = 97
  end
  object FDConnection: TFDConnection
    ConnectionName = 'Connection'
    Params.Strings = (
      'DriverID=MSSQL')
    FetchOptions.AssignedValues = [evMode, evAutoFetchAll]
    LoginPrompt = False
    Left = 379
    Top = 24
  end
end
