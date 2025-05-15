object GroupsT: TGroupsT
  Left = 0
  Top = 0
  Width = 946
  Height = 574
  OnCreate = UniFrameCreate
  Layout = 'fit'
  LayoutConfig.Width = '0'
  LayoutConfig.Region = 'center'
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
    Width = 946
    Height = 76
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
    LayoutConfig.Region = 'north'
    object ToolBar: TUniToolBar
      Left = 0
      Top = 0
      Width = 946
      Height = 75
      Hint = ''
      ShowHint = True
      ButtonHeight = 60
      ButtonWidth = 121
      Images = UniMainModule.BaseImage
      HotImages = UniMainModule.BaseImage
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
        TabOrder = 1
      end
      object UniToolButton2: TUniToolButton
        AlignWithMargins = True
        Left = 127
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actEdit
        ImageIndex = 1
        TabOrder = 2
      end
      object UniToolButton4: TUniToolButton
        AlignWithMargins = True
        Left = 251
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actDelete
        ImageIndex = 2
        TabOrder = 3
        ExplicitLeft = 375
      end
      object UniToolButton6: TUniToolButton
        AlignWithMargins = True
        Left = 375
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actGrant
        ImageIndex = 5
        Scale = bbsLarge
        TabOrder = 4
        ExplicitLeft = 499
      end
    end
  end
  object UniPanel2: TUniPanel
    Left = 0
    Top = 76
    Width = 946
    Height = 498
    Hint = ''
    Margins.Bottom = 0
    ShowHint = True
    Align = alClient
    TabOrder = 2
    BorderStyle = ubsNone
    Caption = ''
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'border'
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'center'
    object pUser: TUniPanel
      Left = 0
      Top = 240
      Width = 946
      Height = 258
      Hint = ''
      ShowHint = True
      Align = alBottom
      TabOrder = 1
      Caption = 'pUser'
      Layout = 'fit'
      LayoutConfig.Split = True
      LayoutConfig.Region = 'south'
      object GridUser: TUniDBGrid
        Left = 1
        Top = 35
        Width = 944
        Height = 222
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
          
            'afterCreate=function afterCreate(sender)'#13#10'{'#13#10' // var toolbar=sen' +
            'der.getDockedItems()[1]; //Remove the ToolBar fixed in the botto' +
            'm'#13#10' // toolbar.items.getAt(10).hide(); //Remove the Refresh butt' +
            'on in the ToolBar, number 10, hide him'#13#10#13#10'}')
        HeaderTitle = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
        DataSource = dsUser
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgFilterClearButton]
        WebOptions.Paged = False
        WebOptions.PageSize = 50
        WebOptions.CustomizableCells = False
        WebOptions.AppendPosition = tpCurrentRow
        WebOptions.FetchAll = True
        LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
        LoadMask.Color = clActiveCaption
        LayoutConfig.ComponentCls = 'grid-users'
        LayoutConfig.Height = '0'
        LayoutConfig.Width = '100'
        Align = alClient
        TabOrder = 1
        ParentColor = False
        Color = clBtnFace
        OnKeyDown = GridUserKeyDown
        OnClearFilters = GridUserClearFilters
        OnCellContextClick = GridUserCellContextClick
        OnColumnFilter = GridUserColumnFilter
        Columns = <
          item
            FieldName = 'UserID'
            Filtering.Enabled = True
            Title.Alignment = taCenter
            Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            Title.Font.Height = -13
            Width = 138
            ReadOnly = True
            Sortable = True
          end
          item
            FieldName = 'UserBrief'
            Filtering.Enabled = True
            Filtering.Editor = fUserBrief
            Title.Alignment = taCenter
            Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
            Title.Font.Height = -13
            Width = 224
            ReadOnly = True
            Sortable = True
          end
          item
            FieldName = 'UserName'
            Filtering.Enabled = True
            Filtering.Editor = fUserName
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Title.Font.Height = -13
            Width = 486
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
      object UniToolBar1: TUniToolBar
        Left = 1
        Top = 1
        Width = 944
        Height = 34
        Hint = ''
        ShowHint = True
        ButtonHeight = 28
        ButtonWidth = 189
        ShowCaptions = True
        ButtonAutoWidth = True
        LayoutConfig.Padding = '0px 0px 0px 5px'
        TabOrder = 2
        ParentColor = False
        Color = clBtnFace
        object UniToolButton5: TUniToolButton
          Left = 0
          Top = 0
          ShowHint = True
          Action = actUserAdd
          ImageIndex = 10
          TabOrder = 1
        end
        object UniToolButton7: TUniToolButton
          Left = 189
          Top = 0
          ShowHint = True
          Action = actUserDelete
          ImageIndex = 11
          TabOrder = 2
          ExplicitHeight = 53
        end
      end
    end
    object pGroup: TUniPanel
      Left = 0
      Top = 0
      Width = 946
      Height = 240
      Hint = ''
      ShowHint = True
      Align = alClient
      TabOrder = 2
      ShowCaption = False
      Caption = 'pGroup'
      LayoutConfig.Region = 'center'
      object GridGroups: TUniDBGrid
        Left = 1
        Top = 1
        Width = 944
        Height = 238
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
          
            'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  //var toolbar=sen' +
            'der.getDockedItems()[1]; //Remove the ToolBar fixed in the botto' +
            'm'#13#10' // toolbar.items.getAt(10).hide(); //Remove the Refresh butt' +
            'on in the ToolBar, number 10, hide him'#13#10#13#10'}')
        DataSource = DataSource
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgFilterClearButton]
        WebOptions.Paged = False
        WebOptions.PageSize = 50
        WebOptions.CustomizableCells = False
        WebOptions.AppendPosition = tpCurrentRow
        WebOptions.FetchAll = True
        LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
        LoadMask.Color = clActiveCaption
        LayoutConfig.ComponentCls = 'grid-users'
        LayoutConfig.IgnorePosition = False
        LayoutConfig.Height = '0'
        LayoutConfig.Width = '100'
        Align = alClient
        Anchors = []
        TabOrder = 1
        ParentColor = False
        Color = clBtnFace
        OnKeyDown = GridGroupsKeyDown
        OnClearFilters = GridGroupsClearFilters
        OnCellContextClick = GridGroupsCellContextClick
        OnColumnFilter = GridGroupsColumnFilter
        Columns = <
          item
            FieldName = 'GroupID'
            Filtering.Enabled = True
            Filtering.Editor = fGroupID
            Title.Alignment = taCenter
            Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
            Title.Font.Height = -13
            Width = 138
            ReadOnly = True
            Sortable = True
          end
          item
            FieldName = 'Brief'
            Filtering.Enabled = True
            Filtering.Editor = fBrief
            Title.Alignment = taCenter
            Title.Caption = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
            Title.Font.Height = -13
            Width = 228
            ReadOnly = True
            Sortable = True
          end
          item
            FieldName = 'Name'
            Filtering.Enabled = True
            Filtering.Editor = fName
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
            Title.Font.Height = -13
            Width = 488
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
  end
  object hdFilter: TUniHiddenPanel
    Left = 37
    Top = 130
    Width = 160
    Height = 180
    Hint = ''
    Visible = True
    ShowHint = True
    object fGroupID: TUniEdit
      Left = 17
      Top = 14
      Width = 121
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 1
      EmptyText = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088'...'
      ClearButton = True
    end
    object fName: TUniEdit
      Left = 18
      Top = 68
      Width = 121
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 2
      EmptyText = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'...'
      ClearButton = True
    end
    object fBrief: TUniEdit
      Left = 19
      Top = 40
      Width = 121
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 3
      EmptyText = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077'...'
      ClearButton = True
    end
    object fUserBrief: TUniEdit
      Left = 19
      Top = 105
      Width = 121
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 4
      EmptyText = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100'...'
      ClearButton = True
    end
    object fUserName: TUniEdit
      Left = 19
      Top = 133
      Width = 121
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 5
      EmptyText = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'...'
    end
  end
  object Query: TFDQuery
    IndexFieldNames = 'GroupID'
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.KeyFields = 'GroupID'
    UpdateOptions.AutoIncFields = 'GroupID '
    SQL.Strings = (
      'select * '
      '  from vGroups u'
      ' where 1=1'
      '   -- filter'
      '   and u.GroupID like isnull(:GroupID, u.GroupID)'
      '   and u.Brief   like isnull(:Brief, u.Brief)'
      '   and u.Name    like isnull(:Name, u.Name)'
      '')
    Left = 684
    Top = 103
    ParamData = <
      item
        Name = 'GROUPID'
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
      end>
    object QueryGroupID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'GroupID'
      KeyFields = 'GroupID'
      Origin = 'GroupID'
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
    object QueryinDatetime: TSQLTimeStampField
      FieldName = 'inDatetime'
      Origin = 'inDatetime'
    end
    object QueryupdDatetime: TSQLTimeStampField
      FieldName = 'updDatetime'
      Origin = 'updDatetime'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 686
    Top = 173
  end
  object ActionList: TUniActionList
    Left = 222
    Top = 196
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
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
    object actUserAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1074' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 10
      OnExecute = actUserAddExecute
    end
    object actUserDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1080#1079' '#1075#1088#1091#1087#1087#1099
      ImageIndex = 11
      OnExecute = actUserDeleteExecute
    end
  end
  object PopupMenu: TUniPopupMenu
    Images = UniMainModule.BaseImage
    Left = 361
    Top = 149
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
    object N8: TUniMenuItem
      Action = actGrant
    end
  end
  object FDUpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    ModifySQL.Strings = (
      '--Update o'
      '  ')
    FetchRowSQL.Strings = (
      'Select * from vGroups where GroupID = :GroupID ')
    Left = 865
    Top = 98
  end
  object qUser: TFDQuery
    IndexFieldNames = 'GroupID'
    MasterSource = DataSource
    MasterFields = 'GroupID'
    DetailFields = 'GroupID'
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    SQL.Strings = (
      'select * '
      '  from vUserRelated'
      ' where 1=1'
      '   -- filter'
      '  -- and u.GroupID like isnull(:GroupID, u.GroupID)'
      '   and UserBrief   like isnull(:UserBrief, UserBrief)'
      '   and UserName    like isnull(:UserName,  UserName)')
    Left = 695
    Top = 394
    ParamData = <
      item
        Name = 'USERBRIEF'
        DataType = ftWideString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'USERNAME'
        DataType = ftWideString
        ParamType = ptInput
        Value = Null
      end>
    object qUserUserID: TFMTBCDField
      FieldName = 'UserID'
      Origin = 'UserID'
      Required = True
      Precision = 18
      Size = 0
    end
    object qUserUserBrief: TWideStringField
      FieldName = 'UserBrief'
      Origin = 'UserBrief'
      Required = True
      Size = 512
    end
    object qUserUserName: TWideStringField
      FieldName = 'UserName'
      Origin = 'UserName'
      Size = 512
    end
    object qUserGroupID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'GroupID'
      Origin = 'GroupID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Precision = 18
      Size = 0
    end
  end
  object dsUser: TDataSource
    DataSet = qUser
    Left = 696
    Top = 448
  end
  object ppUser: TUniPopupMenu
    Images = UniMainModule.BaseImage
    Left = 368
    Top = 414
    object UniMenuItem1: TUniMenuItem
      Action = actUserAdd
    end
    object UniMenuItem4: TUniMenuItem
      Action = actUserDelete
    end
  end
end
