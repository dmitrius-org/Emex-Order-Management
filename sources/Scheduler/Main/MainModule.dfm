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
  OnBeforeLogin = UniGUIMainModuleBeforeLogin
  Height = 351
  Width = 1020
  object FDConnection: TFDConnection
    ConnectionName = 'Connection'
    Params.Strings = (
      'DriverID=MSSQL'
      'MonitorBy=Remote')
    FetchOptions.AssignedValues = [evMode, evAutoFetchAll]
    LoginPrompt = False
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
  object FDMoniFlatFileClientLink: TFDMoniFlatFileClientLink
    EventKinds = [ekError, ekCmdExecute, ekCmdDataIn, ekCmdDataOut, ekSQL, ekSQLVarIn, ekSQLVarOut]
    FileAppend = True
    FileColumns = [tiRefNo, tiTime, tiThreadID, tiClassName, tiObjID, tiMsgText]
    ShowTraces = False
    Left = 244
    Top = 16
  end
  object qSetting: TFDQuery
    Connection = FDConnection
    Left = 43
    Top = 139
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
    Left = 408
    Top = 112
  end
end
