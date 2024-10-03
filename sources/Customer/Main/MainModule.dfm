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
  OnBeforeLogin = UniGUIMainModuleBeforeLogin
  Height = 351
  Width = 1020
  object FDConnection: TFDConnection
    ConnectionName = 'Connection'
    Params.Strings = (
      'DriverID=MSSQL')
    FetchOptions.AssignedValues = [evMode, evAutoFetchAll]
    LoginPrompt = False
    AfterDisconnect = FDConnectionAfterDisconnect
    BeforeDisconnect = FDConnectionBeforeDisconnect
    Left = 41
    Top = 13
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
    Left = 428
    Top = 15
  end
end
