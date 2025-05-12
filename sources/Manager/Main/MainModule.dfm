object UniMainModule: TUniMainModule
  OnCreate = UniGUIMainModuleCreate
  OnDestroy = UniGUIMainModuleDestroy
  RecallLastTheme = True
  Theme = 'crisp'
  Background.Fit = True
  LoginBackground.Fit = True
  DocumentKeyOptions = [dkDisableBackSpace]
  BrowserOptions = [boDisableMouseRightClick, boDisableChromeRefresh]
  MonitoredKeys.Keys = <>
  EnableSynchronousOperations = True
  WebSocketConnection.Enabled = True
  ExtLocale = 'ru'
  ServerMessages.UnavailableErrMsg = #1054#1096#1080#1073#1082#1072' '#1089#1074#1103#1079#1080
  ServerMessages.LoadingMessage = #1047#1072#1075#1088#1091#1079#1082#1072'...'
  ServerMessages.ExceptionTemplate.Strings = (
    '<html>'
    '<body bgcolor="#dfe8f6">'
    '<p style="text-align:center;color:#A05050">'#1054#1096#1080#1073#1082#1072'</p>'
    '<p style="text-align:center;color:#0000A0">[###message###]</p>'
    
      '<p style="text-align:center;color:#A05050"><a href="[###url###]"' +
      '>Restart application</a></p>'
    '</body>'
    '</html>')
  ServerMessages.InvalidSessionMessage = #1048#1089#1090#1077#1082#1083#1086' '#1074#1088#1077#1084#1103' '#1086#1078#1080#1076#1072#1085#1080#1103' '#1089#1077#1072#1085#1089#1072
  ServerMessages.TerminateMessage = #1042#1077#1073'-'#1089#1077#1072#1085#1089' '#1079#1072#1074#1077#1088#1096#1077#1085
  OnSessionTimeout = UniGUIMainModuleSessionTimeout
  OnBeforeLogin = UniGUIMainModuleBeforeLogin
  OnBrowserClose = UniGUIMainModuleBrowserClose
  Height = 238
  Width = 623
  object FDConnection: TFDConnection
    ConnectionName = 'Connection'
    Params.Strings = (
      'DriverID=MSSQL'
      'MonitorBy=Remote')
    FetchOptions.AssignedValues = [evMode, evAutoFetchAll]
    LoginPrompt = False
    OnLost = FDConnectionLost
    AfterConnect = FDConnectionAfterConnect
    AfterDisconnect = FDConnectionAfterDisconnect
    BeforeDisconnect = FDConnectionBeforeDisconnect
    Left = 42
    Top = 14
  end
  object Query: TFDQuery
    Connection = FDConnection
    FetchOptions.AssignedValues = [evItems, evRowsetSize, evAutoFetchAll]
    FetchOptions.RowsetSize = 50000
    Left = 44
    Top = 75
  end
  object FDMoniRemoteClientLink1: TFDMoniRemoteClientLink
    EventKinds = [ekCmdExecute, ekCmdDataIn, ekCmdDataOut, ekSQL, ekSQLVarIn, ekSQLVarOut]
    Tracing = True
    Left = 407
    Top = 17
  end
  object FDMoniSQl: TFDMoniCustomClientLink
    EventKinds = [ekError, ekSQL, ekSQLVarIn, ekSQLVarOut]
    OnOutput = FDMoniSQlOutput
    Left = 400
    Top = 80
  end
end
