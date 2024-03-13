object SettingsT: TSettingsT
  Left = 0
  Top = 0
  Width = 922
  Height = 523
  Layout = 'fit'
  LayoutConfig.Width = '0'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  TabOrder = 0
  ParentColor = False
  ParentBackground = False
  object GridUsers: TUniDBGrid
    Left = 0
    Top = 0
    Width = 922
    Height = 523
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    BodyRTL = False
    ClientEvents.UniEvents.Strings = (
      
        'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
        'r.getDockedItems()[1]; //Remove the ToolBar fixed in the bottom'#13 +
        #10'  toolbar.items.getAt(10).hide(); //Remove the Refresh button i' +
        'n the ToolBar, number 10, hide him'#13#10#13#10'}'
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
        'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
        'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
        'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
        'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
        'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
        't.body.removeChild(el);'#13#10'    };'#13#10'}')
    RowEditor = True
    DataSource = DataSource
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgFilterClearButton]
    WebOptions.PageSize = 50
    WebOptions.AppendPosition = tpCurrentRow
    WebOptions.FetchAll = True
    LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
    LoadMask.Color = clActiveCaption
    LayoutConfig.Height = '100'
    LayoutConfig.Width = '100'
    Align = alClient
    Anchors = []
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    OnKeyDown = GridUsersKeyDown
    Columns = <
      item
        FieldName = 'Name'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Title.Font.Height = -13
        Width = 426
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'Val'
        Title.Alignment = taCenter
        Title.Caption = #1047#1085#1072#1095#1077#1085#1080#1077
        Title.Font.Height = -13
        Width = 463
        Sortable = True
        CheckBoxField.FieldValues = '1;0'
        CheckBoxField.DisplayValues = #1044#1072';'#1053#1077#1090
      end
      item
        FieldName = 'Brief'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
        Title.Font.Height = -13
        Width = 344
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'Comment'
        Title.Alignment = taCenter
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        Title.Font.Height = -13
        Width = 512
        Sortable = True
      end>
  end
  object Query: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshDelete, uvCountUpdatedRecords]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.UpdateTableName = 'tSettings'
    UpdateOptions.KeyFields = 'SettingsID'
    SQL.Strings = (
      'SELECT [SettingsID]'
      '      ,[Brief]'
      '      ,[Name]'
      '      ,[Comment]'
      '      ,[Val]'
      '      ,[SettingType]'
      '  FROM [tSettings] (nolock)'
      ' where [GroupID] = :GroupID')
    Left = 684
    Top = 103
    ParamData = <
      item
        Name = 'GROUPID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QuerySettingsID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'SettingsID'
      Origin = 'SettingsID'
      ProviderFlags = [pfInWhere]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QueryBrief: TWideStringField
      FieldName = 'Brief'
      Origin = 'Brief'
      Required = True
      Size = 64
    end
    object QueryName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 128
    end
    object QueryComment: TWideStringField
      FieldName = 'Comment'
      Origin = 'Comment'
      Required = True
      Size = 256
    end
    object QueryVal: TWideStringField
      FieldName = 'Val'
      Origin = 'Val'
      Required = True
      Size = 256
    end
    object QuerySettingType: TIntegerField
      FieldName = 'SettingType'
      Origin = 'SettingType'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 686
    Top = 173
  end
  object PopupMenu: TUniPopupMenu
    Left = 225
    Top = 275
    object N1: TUniMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 1
    end
    object N2: TUniMenuItem
      Action = actEdit
    end
    object N3: TUniMenuItem
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      ImageIndex = 2
    end
    object N4: TUniMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 0
    end
    object N5: TUniMenuItem
      Caption = '-'
    end
    object N6: TUniMenuItem
      Action = actRefreshAll
    end
    object N7: TUniMenuItem
      Caption = '-'
    end
    object N8: TUniMenuItem
      Caption = #1055#1088#1072#1074#1072' '#1085#1072' '#1080#1085#1090#1077#1088#1092#1077#1081#1089
      Hint = #1055#1088#1072#1074#1072' '#1085#1072' '#1080#1085#1090#1077#1088#1092#1077#1081#1089' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
    end
  end
  object ActionList: TUniActionList
    Left = 222
    Top = 196
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 3
    end
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      OnExecute = actRefreshAllExecute
    end
  end
  object UpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    ModifySQL.Strings = (
      'UPDATE [tSettings] '
      '   SET --Brief       = :NEW_Brief,'
      '       --Name        = :NEW_Name, '
      '       --Comment     = :NEW_Comment,'
      '       Val         = :NEW_Val'
      '       --SettingType = :NEW_SettingType'
      ' WHERE SettingsID  = :SettingsID')
    FetchRowSQL.Strings = (
      'SELECT [SettingsID]'
      '      ,[Brief]'
      '      ,[Name]'
      '      ,[Comment]'
      '      ,[Val]'
      '      ,[SettingType]'
      '  FROM [tSettings] (nolock)'
      ' where [SettingsID] = :SettingsID')
    Left = 748
    Top = 101
  end
end
