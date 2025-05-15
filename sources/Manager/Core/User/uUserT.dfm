object UsersT: TUsersT
  Left = 0
  Top = 0
  Width = 1065
  Height = 574
  OnCreate = UniFrameCreate
  OnReady = UniFrameReady
  Layout = 'fit'
  LayoutConfig.Width = '0'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  ShowHint = True
  ParentShowHint = False
  TabOrder = 0
  object UniPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 1065
    Height = 67
    Hint = ''
    ShowHint = True
    Align = alTop
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    Color = clBtnShadow
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'fit'
    LayoutAttribs.Align = 'top'
    LayoutAttribs.Pack = 'start'
    LayoutConfig.Width = '0'
    object ToolBar: TUniToolBar
      Left = 0
      Top = 0
      Width = 1065
      Height = 67
      Hint = ''
      ShowHint = True
      ButtonHeight = 60
      ButtonWidth = 121
      Images = UniMainModule.BaseImage
      ShowCaptions = True
      ButtonAutoWidth = True
      LayoutConfig.Padding = '0px 0px 0px 5px'
      LayoutConfig.Width = '0'
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      OverflowHandler = ohMenu
      object UniToolButton1: TUniToolButton
        AlignWithMargins = True
        Left = 3
        Top = 3
        ShowHint = True
        Action = actAdd
        ImageIndex = 0
        TabOrder = 2
      end
      object UniToolButton2: TUniToolButton
        AlignWithMargins = True
        Left = 127
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actEdit
        ImageIndex = 1
        TabOrder = 3
      end
      object UniToolButton4: TUniToolButton
        AlignWithMargins = True
        Left = 251
        Top = 3
        Margins.Left = 0
        Margins.Right = 0
        ShowHint = True
        Action = actDelete
        ImageIndex = 2
        TabOrder = 4
        ExplicitLeft = 375
      end
      object UniToolButton6: TUniToolButton
        AlignWithMargins = True
        Left = 372
        Top = 3
        Width = 8
        Hint = ''
        Margins.Left = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Style = tbsSeparator
        Caption = 'UniToolButton6'
        TabOrder = 1
        ExplicitLeft = 499
        ExplicitTop = 0
      end
      object UniToolButton7: TUniToolButton
        AlignWithMargins = True
        Left = 380
        Top = 3
        Margins.Left = 0
        Margins.Bottom = 0
        ShowHint = True
        Action = actGroup
        ImageIndex = 4
        TabOrder = 5
        ExplicitLeft = 507
      end
      object UniToolButton5: TUniToolButton
        AlignWithMargins = True
        Left = 504
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actGrant
        ImageIndex = 5
        LayoutConfig.Padding = '0px 0px 0px 3px'
        TabOrder = 6
        ExplicitLeft = 631
      end
    end
  end
  object UniPanel2: TUniPanel
    Left = 0
    Top = 67
    Width = 1065
    Height = 507
    Hint = ''
    ShowHint = True
    Align = alClient
    TabOrder = 1
    BorderStyle = ubsNone
    Caption = ''
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'fit'
    LayoutAttribs.Align = 'stretch'
    LayoutAttribs.Pack = 'start'
    LayoutConfig.Flex = 1
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'center'
    ExplicitTop = 76
    ExplicitHeight = 498
    object GridUsers: TUniDBGrid
      Left = 0
      Top = 0
      Width = 1065
      Height = 507
      Hint = ''
      ShowHint = True
      BodyRTL = False
      ClientEvents.UniEvents.Strings = (
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
          'data[sender.uniCol+1];'#13#10'        el.value = document.activeElemen' +
          't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
          '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
          'ent.body.removeChild(el);'#13#10'    };'#13#10'}'
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
          'r.getDockedItems()[1]; //Remove the ToolBar fixed in the bottom'#13 +
          #10'  toolbar.items.getAt(10).hide(); //Remove the Refresh button i' +
          'n the ToolBar, number 10, hide him'#13#10#13#10'}')
      DataSource = DataSource
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgFilterClearButton]
      WebOptions.PageSize = 50
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Color = clActiveCaption
      LayoutConfig.ComponentCls = 'grid-users'
      LayoutConfig.IgnorePosition = False
      LayoutConfig.Height = '100'
      LayoutConfig.Width = '100'
      Align = alClient
      Anchors = []
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      OnKeyDown = GridUsersKeyDown
      OnClearFilters = GridUsersClearFilters
      OnCellContextClick = GridUsersCellContextClick
      OnColumnFilter = GridUsersColumnFilter
      Columns = <
        item
          FieldName = 'Status'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089#1099
          Width = 64
        end
        item
          FieldName = 'UserID'
          Filtering.Enabled = True
          Filtering.Editor = fUserID
          Title.Alignment = taCenter
          Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
          Title.Font.Height = -13
          Width = 138
          Visible = False
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'Brief'
          Filtering.Enabled = True
          Filtering.Editor = fBrief
          Title.Alignment = taCenter
          Title.Caption = #1051#1086#1075#1080#1085
          Title.Font.Height = -13
          Width = 169
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'Name'
          Filtering.Enabled = True
          Filtering.Editor = fName
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Title.Font.Height = -13
          Width = 410
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'isAdmin'
          Filtering.Enabled = True
          Filtering.Editor = fisAdmin
          Title.Alignment = taCenter
          Title.Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
          Title.Font.Height = -13
          Width = 122
          ReadOnly = True
          Sortable = True
          CheckBoxField.FieldValues = '1;0'
          CheckBoxField.DisplayValues = #1044#1072';'#1053#1077#1090
        end
        item
          FieldName = 'isBlock'
          Filtering.Enabled = True
          Filtering.Editor = fisBlock
          Title.Alignment = taCenter
          Title.Caption = #1047#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085
          Title.Font.Height = -13
          Width = 121
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'DateBlock'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
          Title.Font.Height = -13
          Width = 146
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'inDatetime'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103
          Title.Font.Height = -13
          Width = 147
          Visible = False
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'updDatetime'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
          Title.Font.Height = -13
          Width = 145
          Visible = False
          ReadOnly = True
          Sortable = True
        end>
    end
  end
  object hdFilter: TUniHiddenPanel
    Left = 30
    Top = 200
    Width = 160
    Height = 161
    Hint = ''
    Visible = True
    ShowHint = True
    object fUserID: TUniEdit
      Left = 17
      Top = 14
      Width = 121
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 1
      EmptyText = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088'...'
    end
    object fName: TUniEdit
      Left = 18
      Top = 68
      Width = 121
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 3
      EmptyText = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'...'
    end
    object fBrief: TUniEdit
      Left = 19
      Top = 40
      Width = 121
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 2
      EmptyText = #1051#1086#1075#1080#1085'...'
    end
    object fisAdmin: TUniCheckBox
      Left = 20
      Top = 95
      Width = 97
      Height = 17
      Hint = ''
      ShowHint = True
      Caption = ''
      TabOrder = 4
    end
    object fisBlock: TUniCheckBox
      Left = 20
      Top = 118
      Width = 97
      Height = 17
      Hint = ''
      ShowHint = True
      Caption = ''
      TabOrder = 5
    end
  end
  object Query: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.KeyFields = 'UserID'
    UpdateOptions.AutoIncFields = 'UserID'
    UpdateObject = FDUpdateSQL
    SQL.Strings = (
      'select * '
      '  from vUsers u'
      ' where 1=1'
      '   -- filter'
      '   and u.UserID  like isnull(:UserID, u.UserID)'
      '   and u.Brief   like isnull(:Brief, u.Brief)'
      '   and u.Name    like isnull(:Name, u.Name)'
      
        '   and isnull(u.isAdmin, 0) = isnull(:isAdmin, isnull(u.isAdmin,' +
        ' 0))'
      
        '   and isnull(u.isBlock, 0) = isnull(:isBlock, isnull(u.isBlock,' +
        ' 0))')
    Left = 692
    Top = 119
    ParamData = <
      item
        Name = 'USERID'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Position = 1
        Name = 'BRIEF'
        DataType = ftWideString
        ParamType = ptInput
        Value = Null
      end
      item
        Position = 2
        Name = 'NAME'
        DataType = ftWideString
        ParamType = ptInput
        Value = Null
      end
      item
        Position = 3
        Name = 'ISADMIN'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end
      item
        Position = 4
        Name = 'ISBLOCK'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end>
    object QueryStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = QueryStatusGetText
    end
    object QueryUserID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'UserID'
      KeyFields = 'UserID'
      Origin = 'UserID'
      ProviderFlags = [pfInWhere, pfInKey]
      Precision = 18
      Size = 0
    end
    object QueryBrief: TWideStringField
      FieldName = 'Brief'
      Origin = 'Brief'
      Size = 200
    end
    object QueryName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Size = 512
    end
    object QueryDateBlock: TSQLTimeStampField
      FieldName = 'DateBlock'
      Origin = 'DateBlock'
    end
    object QueryinDatetime: TSQLTimeStampField
      FieldName = 'inDatetime'
      Origin = 'inDatetime'
    end
    object QueryupdDatetime: TSQLTimeStampField
      FieldName = 'updDatetime'
      Origin = 'updDatetime'
    end
    object QueryisAdmin: TBooleanField
      FieldName = 'isAdmin'
      Origin = 'isAdmin'
    end
    object QueryisBlock: TBooleanField
      FieldName = 'isBlock'
      Origin = 'isBlock'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 686
    Top = 173
  end
  object ActionList: TUniActionList
    Tag = -1
    Left = 222
    Top = 204
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 0
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 1
      OnExecute = actEditExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnExecute = actDeleteExecute
    end
    object actView: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      OnExecute = actViewExecute
    end
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 3
      OnExecute = actRefreshAllExecute
    end
    object actGrant: TAction
      Caption = #1055#1088#1072#1074#1072' '#1085#1072' '#1080#1085#1090#1077#1088#1092#1077#1081#1089
      Hint = #1055#1088#1072#1074#1072' '#1085#1072' '#1080#1085#1090#1077#1088#1092#1077#1081#1089' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
      ImageIndex = 5
      OnExecute = actGrantExecute
    end
    object actLookup: TAction
      Tag = -1
      Caption = #1042#1099#1073#1088#1072#1090#1100
      OnExecute = actLookupExecute
    end
    object actGroup: TAction
      Caption = #1043#1088#1091#1087#1087#1099
      Hint = #1043#1088#1091#1087#1087#1099' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1083#1077#1081
      ImageIndex = 4
      OnExecute = actGroupExecute
    end
    object actGrantCopy: TAction
      Caption = #1053#1072#1089#1083#1077#1076#1086#1074#1072#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1080#1085#1090#1077#1088#1092#1077#1081#1089#1072' '#1080' '#1087#1088#1072#1074
      Hint = #1053#1072#1089#1083#1077#1076#1086#1074#1072#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1080#1085#1090#1077#1088#1092#1077#1081#1089#1072' '#1080' '#1087#1088#1072#1074#1072' '#1089' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 6
      OnExecute = actGrantCopyExecute
    end
    object actEmployeeParameters: TAction
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1079#1072#1082#1072#1079#1086#1074
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1079#1072#1082#1072#1079#1086#1074
      ImageIndex = 9
      OnExecute = actEmployeeParametersExecute
    end
    object actEmployeeOrdersProcessed: TAction
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1079#1072#1082#1072#1079#1086#1074
      ImageIndex = 8
      OnExecute = actEmployeeOrdersProcessedExecute
    end
    object actLogger: TAction
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1103
      ImageIndex = 7
      OnExecute = actLoggerExecute
    end
  end
  object PopupMenu: TUniPopupMenu
    Images = UniMainModule.BaseImage
    Left = 226
    Top = 271
    object N9: TUniMenuItem
      Action = actLookup
    end
    object N1: TUniMenuItem
      Action = actAdd
    end
    object N2: TUniMenuItem
      Action = actEdit
    end
    object N3: TUniMenuItem
      Action = actView
    end
    object N4: TUniMenuItem
      Action = actDelete
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
    object N10: TUniMenuItem
      Action = actGroup
    end
    object N8: TUniMenuItem
      Action = actGrant
    end
    object N11: TUniMenuItem
      Action = actGrantCopy
    end
    object N12: TUniMenuItem
      Caption = '-'
    end
    object N13: TUniMenuItem
      Action = actEmployeeOrdersProcessed
    end
    object N14: TUniMenuItem
      Action = actEmployeeParameters
    end
    object N16: TUniMenuItem
      Caption = '-'
    end
    object N15: TUniMenuItem
      Action = actLogger
    end
  end
  object FDUpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    ModifySQL.Strings = (
      '--Update o'
      '  ')
    FetchRowSQL.Strings = (
      'select * '
      '  from vUsers u'
      ' where u.UserID = :UserID')
    Left = 847
    Top = 118
  end
end
