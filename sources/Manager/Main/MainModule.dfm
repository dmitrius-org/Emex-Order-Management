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
  ExtLocale = 'ru'
  OnBeforeLogin = UniGUIMainModuleBeforeLogin
  Height = 238
  Width = 623
  object FDConnection: TFDConnection
    ConnectionName = 'Connection'
    Params.Strings = (
      'DriverID=MSSQL')
    FetchOptions.AssignedValues = [evMode, evAutoFetchAll]
    LoginPrompt = False
    AfterConnect = FDConnectionAfterConnect
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
