object UniServerModule: TUniServerModule
  OnCreate = UniGUIServerModuleCreate
  OnDestroy = UniGUIServerModuleDestroy
  TempFolder = 'temp\'
  FrameworkFilesRoot = 'C:\Program Files (x86)\FMSoft\Framework\uniGUI'
  Port = 8089
  Title = 'Customer'
  AjaxTimeout = 500000
  SuppressErrors = []
  Bindings = <>
  MainFormDisplayMode = mfPage
  ServerMessages.UnavailableErrMsg = #1054#1096#1080#1073#1082#1072' '#1089#1074#1103#1079#1080'.'
  ServerMessages.LoadingMessage = #1047#1072#1075#1088#1091#1079#1082#1072'...'
  ServerMessages.ExceptionTemplate.Strings = (
    '<html>'
    '<body bgcolor="#dfe8f6">'
    
      '<p style="text-align:center;color:#A05050">'#1042' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1080' '#1087#1088#1086#1080#1079#1086#1096#1083 +
      #1072' '#1086#1096#1080#1073#1082#1072'.:</p>'
    '<p style="text-align:center;color:#0000A0">[###message###]</p>'
    
      '<p style="text-align:center;color:#A05050"><a href="[###url###]"' +
      '>'#1055#1077#1088#1077#1079#1072#1087#1091#1089#1090#1080#1090#1100' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077'</a></p>'
    '</body>'
    '</html>')
  ServerMessages.InvalidSessionTemplate.Strings = (
    '<html>'
    '<body bgcolor="#dfe8f6">'
    '<p style="text-align:center;color:#0000A0">[###message###]</p>'
    
      '<p style="text-align:center;color:#A05050"><a href="[###url###]"' +
      '>'#1055#1077#1088#1077#1079#1072#1087#1091#1089#1090#1080#1090#1100' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077'</a></p>'
    '</body>'
    '</html>')
  ServerMessages.TerminateTemplate.Strings = (
    '<html>'
    '<body bgcolor="#dfe8f6">'
    '<p style="text-align:center;color:#0000A0">[###message###]</p>'
    
      '<p style="text-align:center;color:#A05050"><a href="[###url###]"' +
      '>'#1055#1077#1088#1077#1079#1072#1087#1091#1089#1090#1080#1090#1100' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077'</a></p>'
    '</body>'
    '</html>')
  ServerMessages.InvalidSessionMessage = #1053#1077#1076#1077#1081#1089#1090#1074#1080#1090#1077#1083#1100#1085#1072#1103' '#1089#1077#1089#1089#1080#1103' '#1080#1083#1080' '#1074#1088#1077#1084#1103' '#1089#1077#1089#1089#1080#1080' '#1080#1089#1090#1077#1082#1083#1086'.'
  ServerMessages.TerminateMessage = #1042#1077#1073'-'#1089#1077#1089#1089#1080#1103' '#1079#1072#1074#1077#1088#1096#1077#1085#1072'.'
  ExtLocale = 'ru'
  SSL.SSLOptions.RootCertFile = 'root.pem'
  SSL.SSLOptions.CertFile = 'cert.pem'
  SSL.SSLOptions.KeyFile = 'key.pem'
  SSL.SSLOptions.Method = sslvSSLv23
  SSL.SSLOptions.SSLVersions = [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2]
  SSL.SSLOptions.Mode = sslmClient
  SSL.SSLOptions.VerifyMode = []
  SSL.SSLOptions.VerifyDepth = 0
  Options = [soAutoPlatformSwitch, soRestartSessionOnTimeout, soWipeShadowSessions, soDontCompressDownloads, soEnableSessionMonitor, soEnableSessionMonitorAdmin]
  ServerLogger.Options = [logIndyExceptions, logSessionExceptions, logIndySSLExceptions, logIndySSLCryptoExceptions]
  ConnectionFailureRecovery.DetailedLog = True
  ConnectionFailureRecovery.FullSequenceLog = True
  ConnectionFailureRecovery.ErrorMessage = 'Connection Error'
  ConnectionFailureRecovery.RetryMessage = 'Retrying...'
  OnBeforeInit = UniGUIServerModuleBeforeInit
  Height = 261
  Width = 682
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
