object UniMainModule: TUniMainModule
  OnCreate = UniGUIMainModuleCreate
  OnDestroy = UniGUIMainModuleDestroy
  RecallLastTheme = True
  Theme = 'crisp'
  Background.Fit = True
  LoginBackground.Fit = True
  DocumentKeyOptions = [dkDisableBackSpace]
  MonitoredKeys.Keys = <>
  EnableSynchronousOperations = True
  ExtLocale = 'ru'
  ServerMessages.InvalidSessionTemplate.Strings = (
    '<html>'
    '<body bgcolor="#dfe8f6">'
    
      '<p style="text-align:center;color:#A05050"><a href="[###url###]"' +
      '>Restart application</a></p>'
    '</body>'
    '</html>')
  ServerMessages.TerminateTemplate.Strings = (
    '<html>'
    '<body bgcolor="#dfe8f6">'
    
      '<p style="text-align:center;color:#A05050"><a href="[###url###]"' +
      '>Restart application</a></p>'
    '</body>'
    '</html>')
  OnBeforeLogin = UniGUIMainModuleBeforeLogin
  Height = 274
  Width = 696
  object FDConnection: TFDConnection
    ConnectionName = 'Connection'
    Params.Strings = (
      'DriverID=MSSQL'
      'MonitorBy=Remote')
    FetchOptions.AssignedValues = [evMode, evAutoFetchAll]
    LoginPrompt = False
    OnLogin = FDConnectionLogin
    OnLost = FDConnectionLost
    OnRestored = FDConnectionRestored
    OnRecover = FDConnectionRecover
    AfterConnect = FDConnectionAfterConnect
    AfterDisconnect = FDConnectionAfterDisconnect
    BeforeDisconnect = FDConnectionBeforeDisconnect
    BeforeStartTransaction = FDConnectionBeforeStartTransaction
    Left = 49
    Top = 5
  end
  object Query: TFDQuery
    Connection = FDConnection
    FetchOptions.AssignedValues = [evItems, evRowsetSize, evAutoFetchAll]
    FetchOptions.RowsetSize = 50000
    Left = 44
    Top = 75
  end
  object FDMoniFlatFileClientLink: TFDMoniFlatFileClientLink
    EventKinds = [ekError, ekCmdExecute, ekCmdDataIn, ekCmdDataOut, ekSQL, ekSQLVarIn, ekSQLVarOut]
    FileAppend = True
    FileColumns = [tiRefNo, tiTime, tiThreadID, tiClassName, tiObjID, tiMsgText]
    ShowTraces = False
    Left = 244
    Top = 8
  end
  object qSetting: TFDQuery
    Connection = FDConnection
    Left = 43
    Top = 139
  end
  object FDMoniRemoteClientLink1: TFDMoniRemoteClientLink
    EventKinds = [ekCmdExecute, ekCmdDataIn, ekCmdDataOut, ekSQL, ekSQLVarIn, ekSQLVarOut]
    Tracing = True
    Left = 428
    Top = 7
  end
  object FDMoniSQl: TFDMoniCustomClientLink
    EventKinds = [ekError, ekSQL, ekSQLVarIn, ekSQLVarOut]
    OnOutput = FDMoniSQlOutput
    Left = 432
    Top = 112
  end
end
