object LoggerF: TLoggerF
  AlignWithMargins = True
  Left = 0
  Top = 0
  ClientHeight = 327
  ClientWidth = 581
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1103
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  LayoutConfig.Cls = 'login-form-'
  TextHeight = 15
  object MainContainer: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 581
    Height = 327
    Hint = ''
    ParentColor = False
    Align = alClient
    TabOrder = 0
    object Mainbox: TUniGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 575
      Height = 321
      Hint = ''
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1103
      Align = alClient
      TabOrder = 1
      object cbSqlLog: TUniDBCheckBox
        AlignWithMargins = True
        Left = 14
        Top = 208
        Width = 561
        Height = 17
        Hint = ''
        Margins.Top = 10
        DataField = 'LogSql'
        Caption = #1051#1086#1075#1080#1088#1086#1074#1072#1085#1080#1077' SQL '#1079#1072#1087#1088#1086#1089#1086#1074
        TabOrder = 1
        ParentColor = False
        Color = clBtnFace
      end
      object UniLabel1: TUniLabel
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 3
        Height = 13
        Hint = ''
        Caption = ''
        Align = alTop
        TabOrder = 2
      end
      object LogDestination: TUniCheckComboBox
        Left = 14
        Top = 28
        Width = 499
        Hint = #1042#1082#1083#1102#1095#1080#1090#1100' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1077
        Text = ''
        Items.Strings = (
          #1042' '#1092#1072#1081#1083
          #1042' '#1073#1072#1079#1091' '#1076#1072#1085#1085#1099#1093)
        TabOrder = 3
        ClearButton = True
        FieldLabel = #1042#1082#1083#1102#1095#1080#1090#1100' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1077
        FieldLabelAlign = laTop
        IconItems = <>
      end
      object FileEvent: TUniCheckComboBox
        Left = 14
        Top = 85
        Width = 499
        Hint = #1057#1086#1073#1099#1090#1080#1103' '#1076#1083#1103' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1103' '#1074' '#1092#1072#1081#1083
        Text = ''
        Items.Strings = (
          'HEADER'
          'INFO'
          'WARN'
          'ERROR'
          'CRITICAL'
          'EXCEPT'
          'DEBUG')
        TabOrder = 4
        ClearButton = True
        FieldLabel = #1057#1086#1073#1099#1090#1080#1103' '#1076#1083#1103' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1103' '#1074' '#1092#1072#1081#1083
        FieldLabelAlign = laTop
        IconItems = <>
      end
      object DBEvent: TUniCheckComboBox
        Left = 14
        Top = 140
        Width = 499
        Hint = #1057#1086#1073#1099#1090#1080#1103' '#1076#1083#1103' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1103' '#1074' '#1073#1072#1079#1091' '#1076#1072#1085#1085#1099#1093
        Text = ''
        Items.Strings = (
          'HEADER'
          'INFO'
          'WARN'
          'ERROR'
          'CRITICAL'
          'EXCEPT'
          'DEBUG')
        TabOrder = 5
        ClearButton = True
        FieldLabel = #1057#1086#1073#1099#1090#1080#1103' '#1076#1083#1103' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1103' '#1074' '#1073#1072#1079#1091' '#1076#1072#1085#1085#1099#1093
        FieldLabelAlign = laTop
        IconItems = <>
      end
      object btnCancel: TUniBitBtn
        AlignWithMargins = True
        Left = 340
        Top = 272
        Width = 103
        Height = 38
        Hint = ''
        Margins.Right = 10
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          200000000000000400000000000000000000000000000000000000000000131C
          3C471E2B5F700000000000000000000000000000000000000000000000000000
          00000000000000000000000000001F2D6375131C3C4700000000131C3C474260
          D0F64463D8FF1F2D617300000000000000000000000000000000000000000000
          00000000000000000000202E65774463D8FF4260D1F7131C3C472130687B4463
          D8FF4463D8FF4463D8FF1F2D6173000000000000000000000000000000000000
          000000000000202E65774463D8FF4463D8FF4463D8FF212F677A000000002231
          6C7F4463D8FF4463D8FF4463D8FF1F2D61730000000000000000000000000000
          0000202E65774463D8FF4463D8FF4463D8FF22316B7E00000000000000000000
          000022316C7F4463D8FF4463D8FF4463D8FF1F2D61730000000000000000202E
          65774463D8FF4463D8FF4463D8FF22316B7E0000000000000000000000000000
          00000000000022316C7F4463D8FF4463D8FF4463D8FF1F2D6173202E65774463
          D8FF4463D8FF4463D8FF22316B7E000000000000000000000000000000000000
          0000000000000000000022316C7F4463D8FF4463D8FF4463D8FF4463D8FF4463
          D8FF4463D8FF22316B7E00000000000000000000000000000000000000000000
          000000000000000000000000000022316C7F4463D8FF4463D8FF4463D8FF4463
          D8FF22316B7E0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000202E65774463D8FF4463D8FF4463D8FF4463
          D8FF1F2D62740000000000000000000000000000000000000000000000000000
          00000000000000000000202E65774463D8FF4463D8FF4463D8FF4463D8FF4463
          D8FF4463D8FF1F2D627400000000000000000000000000000000000000000000
          000000000000202E65774463D8FF4463D8FF4463D8FF22316B7E22316C7F4463
          D8FF4463D8FF4463D8FF1F2D6274000000000000000000000000000000000000
          0000202E65774463D8FF4463D8FF4463D8FF21316A7D00000000000000002231
          6C7F4463D8FF4463D8FF4463D8FF1F2D6274000000000000000000000000202E
          65774463D8FF4463D8FF4463D8FF21316A7D0000000000000000000000000000
          000022316C7F4463D8FF4463D8FF4463D8FF1F2D6274000000001F2D63754463
          D8FF4463D8FF4463D8FF21316A7D000000000000000000000000000000000000
          00000000000022316C7F4463D8FF4463D8FF4463D8FF1E2C6172151E414D4261
          D3F94463D8FF21316A7D00000000000000000000000000000000000000000000
          0000000000000000000022316C7F4463D8FF4261D3F9151E424E00000000151E
          414D212F677A0000000000000000000000000000000000000000000000000000
          00000000000000000000000000002130687B151E414D00000000}
        Caption = #1054#1090#1084#1077#1085#1072
        TabOrder = 6
        LayoutConfig.Margin = '0px 0px 5px 2px'
        OnClick = btnCancelClick
      end
      object btnOk: TUniBitBtn
        AlignWithMargins = True
        Left = 448
        Top = 272
        Width = 105
        Height = 38
        Hint = ''
        Margins.Right = 6
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000C0E0A1500000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000031362652909F70F32D32234C000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000003136265293A373F997A776FF93A373F92B3022490000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000003136265293A373F997A776FF97A776FF97A776FF93A273F82B2F
          2148000000000000000000000000000000000000000000000000000000000000
          00003136265393A373F997A776FF91A071F54951397B93A273F897A776FF93A2
          73F82B2F21480000000000000000000000000000000000000000000000000506
          0409839166DD97A776FF91A071F5262A1E40000000002B2F214893A273F897A7
          76FF93A273F82B30224900000000000000000000000000000000000000000000
          000015171023808D64D8262A1E400000000000000000000000002B2F214893A2
          73F897A776FF93A273F82B302249000000000000000000000000000000000000
          0000000000000202010300000000000000000000000000000000000000002B2F
          214893A273F897A776FF93A273F82B3022490000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00002B2F214893A273F897A776FF93A273F82B30224900000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000002B2F214893A273F897A776FF76825CC701010001000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000002B2F214875825CC60B0C081200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000010100010000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ParentFont = False
        Font.Height = -13
        TabOrder = 7
        LayoutConfig.Margin = '0px 2px 5px 5px'
        OnClick = btnOkClick
      end
    end
  end
  object Query: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvRefreshMode]
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.KeyFields = 'LoggerSettingsID'
    UpdateOptions.AutoIncFields = 'LoggerSettingsID'
    SQL.Strings = (
      '  '
      '  '
      'if not exists ('
      '  Select 1'
      '    from tLoggerSettings (nolock)'
      '   where UserID = :UserID'
      '     and AppName= :AppName'
      ' )  '
      '  '
      '  insert into tLoggerSettings '
      '        (UserID, AppName) '
      '  select :UserID, :AppName     '
      ''
      ''
      'Select ls.LoggerSettingsID, '
      '       ls.UserID, '
      '       ls.FileLogLevel,'
      '       ls.DBLogLevel,'
      '       ls.LogSql,'
      '       convert(varchar, coalesce(c.Brief, u.Name, '#39#39')) Username,'
      '       ls.LogDestination'
      '  from tLoggerSettings ls (nolock)'
      '  left join tClients c (nolock)'
      '         on c.ClientID = ls.UserID'
      '        and :AppName   = '#39'Customer'#39
      '  left join tUser u (nolock)'
      '         on u.UserID  = ls.UserID'
      '        and :AppName <> '#39'Customer'#39'        '
      '        '
      ' where ls.UserID = :UserID'
      '   and ls.AppName= :AppName')
    Left = 484
    Top = 178
    ParamData = <
      item
        Name = 'USERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'APPNAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object QueryLoggerSettingsID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'LoggerSettingsID'
      KeyFields = 'LoggerSettingsID'
      Origin = 'LoggerSettingsID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QueryUserID: TFMTBCDField
      FieldName = 'UserID'
      Origin = 'UserID'
      Required = True
      Precision = 18
      Size = 0
    end
    object QueryUsername: TStringField
      FieldName = 'Username'
      Size = 128
    end
    object QueryLogDestination: TStringField
      FieldName = 'LogDestination'
      Size = 64
    end
    object QueryFileLogLevel: TStringField
      FieldName = 'FileLogLevel'
      Size = 256
    end
    object QueryDBLogLevel: TStringField
      FieldName = 'DBLogLevel'
      Size = 256
    end
    object QueryLogSql: TBooleanField
      FieldName = 'LogSql'
    end
  end
end
