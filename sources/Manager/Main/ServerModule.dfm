object UniServerModule: TUniServerModule
  OnCreate = UniGUIServerModuleCreate
  OnDestroy = UniGUIServerModuleDestroy
  TempFolder = 'temp\'
  FrameworkFilesRoot = 'C:\Program Files (x86)\FMSoft\1583\Framework\uniGUI'
  SessionTimeout = 86400000
  Port = 8087
  Title = 'Managers'
  AjaxTimeout = 500000
  SuppressErrors = [errObjectNotFound]
  Bindings = <>
  MainFormDisplayMode = mfPage
  CustomFiles.Strings = (
    'files/fonts/fontawesome-pro-5.14.0-web/css/all.css'
    ''
    'files/css/custom.css '
    'files/css/grid.css'
    'files/css/main_menu.css'
    'files/css/dashboard.css'
    ''
    'files/css/messenger.css'
    'files/css/messenger_style.css'
    ''
    'files/tinyMCE5/tinymce.js'
    ''
    'files/js/BadgeText.js'
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
  Options = [soAutoPlatformSwitch, soWipeShadowSessions, soDontCompressDownloads]
  ServerLogger.Options = [logIndyExceptions, logSessionExceptions, logIndySSLExceptions, logIndySSLCryptoExceptions]
  ConnectionFailureRecovery.DetailedLog = True
  ConnectionFailureRecovery.FullSequenceLog = True
  ConnectionFailureRecovery.ErrorMessage = #1054#1096#1080#1073#1082#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
  ConnectionFailureRecovery.RetryMessage = #1055#1086#1074#1090#1086#1088#1085#1072#1103' '#1087#1086#1087#1099#1090#1082#1072'...'
  WebSocketServer.AlwaysUseHTTP = True
  OnBeforeInit = UniGUIServerModuleBeforeInit
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
