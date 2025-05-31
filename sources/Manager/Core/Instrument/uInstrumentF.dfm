object UnstrumentF: TUnstrumentF
  Left = 0
  Top = 0
  ClientHeight = 408
  ClientWidth = 704
  Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 361
    Width = 698
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    DesignSize = (
      698
      44)
    object btnOk: TUniBitBtn
      Left = 606
      Top = 10
      Width = 85
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      Left = 517
      Top = 10
      Width = 81
      Height = 25
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
  object fsCommon: TUniFieldSet
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 698
    Height = 295
    Hint = ''
    Title = #1054#1073#1097#1080#1077' '#1089#1074#1077#1076#1077#1085#1080#1103
    FieldLabelWidth = 0
    Align = alClient
    TabOrder = 1
    object fInstrumentType: TUniFieldContainer
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 688
      Height = 30
      Hint = ''
      ParentColor = False
      Align = alTop
      TabOrder = 0
      Layout = 'fit'
      LayoutConfig.Width = '0'
      object lkpInstType: TUniDBLookupComboBox
        AlignWithMargins = True
        Left = 146
        Top = 5
        Width = 445
        Height = 23
        Hint = ''
        ListField = 'Name'
        ListSource = dsInstrumentType
        KeyField = 'InstrumentTypeID'
        ListFieldIndex = 0
        ClearButton = True
        TabOrder = 1
        Color = clWindow
        FieldLabel = #1058#1080#1087' '#1086#1073#1098#1077#1082#1090#1072
        FieldLabelWidth = 150
        OnChange = lkpInstTypeChange
      end
      object UniLabel5: TUniLabel
        Left = 27
        Top = 8
        Width = 3
        Height = 13
        Hint = ''
        Caption = ''
        TabOrder = 2
      end
    end
    object fBrief: TUniFieldContainer
      AlignWithMargins = True
      Left = 5
      Top = 54
      Width = 688
      Height = 53
      Hint = ''
      Visible = False
      ParentColor = False
      Align = alTop
      TabOrder = 1
      Layout = 'fit'
      DesignSize = (
        688
        53)
      object edtBrief: TUniEdit
        AlignWithMargins = True
        Left = 145
        Top = 4
        Width = 463
        Hint = ''
        Text = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        ClearButton = True
        FieldLabel = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077
        FieldLabelWidth = 150
      end
      object edtName: TUniEdit
        AlignWithMargins = True
        Left = 145
        Top = 29
        Width = 463
        Hint = ''
        Text = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        ClearButton = True
        FieldLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        FieldLabelWidth = 150
      end
    end
    object fState: TUniFieldContainer
      AlignWithMargins = True
      Left = 5
      Top = 113
      Width = 688
      Height = 50
      Hint = ''
      Visible = False
      ParentColor = False
      Align = alTop
      TabOrder = 5
      Layout = 'fit'
      object lkpState: TUniDBLookupComboBox
        AlignWithMargins = True
        Left = 146
        Top = 4
        Width = 445
        Height = 23
        Hint = ''
        ListField = 'Name'
        ListSource = dsqState
        KeyField = 'NodeID'
        ListFieldIndex = 0
        ClearButton = True
        TabOrder = 1
        Color = clWindow
        FieldLabel = #1057#1086#1089#1090#1086#1103#1085#1080#1077
        FieldLabelWidth = 150
        OnChange = lkpStateChange
      end
      object cbIsStart: TUniCheckBox
        Left = 145
        Top = 30
        Width = 182
        Height = 17
        Hint = ''
        Caption = #1053#1072#1095#1072#1083#1100#1085#1086#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
        TabOrder = 2
      end
    end
    object fObjectType: TUniFieldContainer
      AlignWithMargins = True
      Left = 5
      Top = 169
      Width = 688
      Height = 30
      Hint = ''
      Visible = False
      ParentColor = False
      Align = alTop
      TabOrder = 2
      Layout = 'fit'
      object lkpObject: TUniDBLookupComboBox
        AlignWithMargins = True
        Left = 145
        Top = 3
        Width = 450
        Height = 23
        Hint = ''
        ListField = 'Name'
        ListSource = dsObjectType
        KeyField = 'ObjectTypeID'
        ListFieldIndex = 0
        ClearButton = True
        TabOrder = 1
        Color = clWindow
        FieldLabel = #1054#1073#1098#1077#1082#1090' '#1089#1080#1089#1090#1077#1084#1099
        FieldLabelWidth = 150
      end
    end
    object fNode: TUniFieldContainer
      AlignWithMargins = True
      Left = 5
      Top = 205
      Width = 688
      Height = 85
      Hint = ''
      Visible = False
      ParentColor = False
      Align = alTop
      TabOrder = 4
      Layout = 'fit'
      object lkpNode: TUniDBLookupComboBox
        AlignWithMargins = True
        Left = 145
        Top = 3
        Width = 450
        Height = 23
        Hint = ''
        ListField = 'Name'
        ListSource = dsNode
        KeyField = 'NodeID'
        ListFieldIndex = 0
        ClearButton = True
        TabOrder = 1
        Color = clWindow
        LayoutConfig.Padding = '1 0 0 0'
        FieldLabel = #1044#1077#1081#1089#1090#1074#1080#1077
        FieldLabelWidth = 150
        OnChange = lkpNodeChange
      end
      object lkpTargerState: TUniDBLookupComboBox
        AlignWithMargins = True
        Left = 146
        Top = 32
        Width = 450
        Height = 23
        Hint = ''
        ListField = 'Name'
        ListSource = dsTargerState
        KeyField = 'StateID'
        ListFieldIndex = 0
        ClearButton = True
        TabOrder = 2
        Color = clWindow
        LayoutConfig.Padding = '4 0 0 0'
        FieldLabel = #1062#1077#1083#1077#1074#1086#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
        FieldLabelWidth = 150
        OnChange = lkpNodeChange
      end
      object cbIsCancel: TUniCheckBox
        AlignWithMargins = True
        Left = 322
        Top = 61
        Width = 179
        Height = 17
        Hint = ''
        Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1086#1090#1082#1072#1076' '#1076#1077#1081#1089#1090#1074#1080#1103
        TabOrder = 4
        FieldLabelWidth = 150
      end
      object edtN: TUniSpinEdit
        Left = 145
        Top = 61
        Width = 121
        Hint = ''
        TabOrder = 3
        LayoutConfig.Padding = '1 0 0 0'
        FieldLabel = #1053#1086#1084#1077#1088
        FieldLabelWidth = 150
      end
    end
  end
  object fsAudit: TUniFieldSet
    AlignWithMargins = True
    Left = 3
    Top = 304
    Width = 698
    Height = 51
    Hint = ''
    Title = #1040#1091#1076#1080#1090
    Collapsible = True
    Align = alBottom
    LayoutConfig.Region = 'south'
    TabOrder = 2
    object UniFieldContainer2: TUniFieldContainer
      Left = 2
      Top = 15
      Width = 694
      Height = 34
      Hint = ''
      ParentColor = False
      Align = alClient
      TabOrder = 1
      object edtID: TUniEdit
        AlignWithMargins = True
        Left = 141
        Top = 6
        Width = 138
        Hint = ''
        Text = ''
        TabOrder = 1
        ReadOnly = True
      end
      object edtInDate: TUniDateTimePicker
        Left = 141
        Top = 33
        Width = 138
        Hint = ''
        DateTime = 45098.000000000000000000
        DateFormat = 'dd.MM.yyyy'
        TimeFormat = 'HH:mm:ss'
        ReadOnly = True
        TabOrder = 2
        DateMode = dtmDateTime
      end
      object edtUpdDate: TUniDateTimePicker
        Left = 415
        Top = 33
        Width = 145
        Hint = ''
        DateTime = 45098.000000000000000000
        DateFormat = 'dd.MM.yyyy'
        TimeFormat = 'HH:mm:ss'
        ReadOnly = True
        TabOrder = 3
        DateMode = dtmDateTime
      end
      object UniLabel1: TUniLabel
        Left = 25
        Top = 10
        Width = 89
        Height = 13
        Hint = ''
        Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088':'
        TabOrder = 4
      end
      object UniLabel2: TUniLabel
        Left = 25
        Top = 37
        Width = 80
        Height = 13
        Hint = ''
        Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103':'
        TabOrder = 5
      end
      object UniLabel3: TUniLabel
        Left = 302
        Top = 38
        Width = 90
        Height = 13
        Hint = ''
        Caption = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103':'
        TabOrder = 6
      end
    end
  end
  object dsInstrumentType: TDataSource
    DataSet = qInstrumentType
    Left = 518
    Top = 132
  end
  object qInstrumentType: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshDelete, uvCountUpdatedRecords]
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.KeyFields = 'InstrumentTypeID'
    SQL.Strings = (
      'SELECT [InstrumentTypeID]'
      '      ,[Brief]'
      '      ,[Name]'
      '  FROM [tInstrumentType] (Nolock)'
      ' Where Filters like '#39'%'#39' + :Filters + '#39'%'#39' '
      '  ')
    Left = 514
    Top = 78
    ParamData = <
      item
        Name = 'FILTERS'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object qObjectType: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshDelete, uvCountUpdatedRecords]
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.KeyFields = 'InstrumentTypeID'
    SQL.Strings = (
      'select *'
      '  from tObjectType (nolock)'
      ' where Flag&1>0'
      '  ')
    Left = 371
    Top = 124
    MacroData = <
      item
        Value = Null
        Name = '1'
        DataType = mdIdentifier
      end>
  end
  object dsObjectType: TDataSource
    DataSet = qObjectType
    Left = 620
    Top = 134
  end
  object qState: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshDelete, uvCountUpdatedRecords]
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.KeyFields = 'InstrumentTypeID'
    SQL.Strings = (
      'select NodeID, Brief, Name '
      '  from tNodes (nolock)'
      ' where Type = 0 -- 0 - '#1089#1086#1089#1090#1086#1103#1085#1080#1077'  -- 1 - '#1076#1077#1081#1089#1090#1074#1080#1077)
    Left = 515
    Top = 191
  end
  object dsqState: TDataSource
    DataSet = qState
    Left = 514
    Top = 247
  end
  object qNode: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshDelete, uvCountUpdatedRecords]
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.KeyFields = 'InstrumentTypeID'
    SQL.Strings = (
      'select NodeID, Brief, Name '
      '  from tNodes (nolock)'
      ' where Type = 1 -- 0 - '#1089#1086#1089#1090#1086#1103#1085#1080#1077'  -- 1 - '#1076#1077#1081#1089#1090#1074#1080#1077)
    Left = 621
    Top = 192
  end
  object dsNode: TDataSource
    DataSet = qNode
    Left = 621
    Top = 251
  end
  object qTargerState: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshDelete, uvCountUpdatedRecords]
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.KeyFields = 'InstrumentTypeID'
    SQL.Strings = (
      'select m.StateID, n.Name'
      '  from tModel m (nolock)'
      ' inner join tNodes n (nolock)'
      '         on m.StateID = n.NodeID'
      #9'and n.Type    = 0  --0 - '#1089#1086#1089#1090#1086#1103#1085#1080#1077
      ' where m.InstrumentID = :InstrumentID '
      '   and isnull( m.ActionID, 0)     = 0')
    Left = 29
    Top = 152
    ParamData = <
      item
        Name = 'INSTRUMENTID'
        ParamType = ptInput
      end>
  end
  object dsTargerState: TDataSource
    DataSet = qTargerState
    Left = 93
    Top = 178
  end
end
