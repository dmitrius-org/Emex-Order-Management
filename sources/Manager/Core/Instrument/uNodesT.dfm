object NodesT: TNodesT
  Left = 0
  Top = 0
  Width = 1065
  Height = 574
  OnCreate = UniFrameCreate
  Layout = 'fit'
  LayoutConfig.Width = '0'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  ShowHint = True
  ParentShowHint = False
  TabOrder = 0
  object hdFilter: TUniHiddenPanel
    Left = 29
    Top = 330
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
      TabOrder = 2
      EmptyText = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'...'
    end
    object fBrief: TUniEdit
      Left = 19
      Top = 40
      Width = 121
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 3
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
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1059
    Height = 67
    Hint = ''
    Margins.Bottom = 0
    ShowHint = True
    Align = alTop
    TabOrder = 1
    BorderStyle = ubsNone
    Caption = '1234'
    Color = clBtnShadow
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'fit'
    LayoutAttribs.Align = 'top'
    LayoutAttribs.Pack = 'start'
    LayoutConfig.Width = '100'
    LayoutConfig.Region = 'north'
    object ToolBar: TUniToolBar
      Left = 0
      Top = 0
      Width = 1059
      Height = 67
      Hint = ''
      ShowHint = True
      ButtonHeight = 60
      ButtonWidth = 110
      Images = UniMainModule.BaseImage
      ShowCaptions = True
      ButtonAutoWidth = True
      LayoutConfig.Padding = '0px 0px 0px 5px'
      LayoutConfig.IgnorePosition = False
      LayoutConfig.DockWhenAligned = False
      Align = alClient
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      OverflowHandler = ohMenu
      object UniToolButton1: TUniToolButton
        Left = 0
        Top = 0
        ShowHint = True
        Action = actInsert
        ImageIndex = 0
        TabOrder = 2
      end
      object UniToolButton2: TUniToolButton
        Left = 110
        Top = 0
        ShowHint = True
        Action = actEdit
        ImageIndex = 1
        TabOrder = 1
      end
      object UniToolButton4: TUniToolButton
        Left = 220
        Top = 0
        ShowHint = True
        Action = actDelete
        ImageIndex = 2
        TabOrder = 3
        ExplicitLeft = 330
      end
      object UniToolButton5: TUniToolButton
        Left = 330
        Top = 0
        ShowHint = True
        Action = actRefreshAll
        ImageIndex = 3
        TabOrder = 4
        ExplicitLeft = 440
      end
    end
  end
  object UniPanel2: TUniPanel
    Left = 0
    Top = 70
    Width = 1065
    Height = 504
    Hint = ''
    ShowHint = True
    Align = alClient
    TabOrder = 2
    BorderStyle = ubsNone
    Caption = 'UniPanel2'
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'fit'
    LayoutAttribs.Align = 'stretch'
    LayoutAttribs.Pack = 'start'
    LayoutConfig.Flex = 1
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'center'
    object Grid: TUniDBGrid
      Left = 0
      Top = 0
      Width = 1065
      Height = 504
      Hint = ''
      ShowHint = True
      BodyRTL = False
      ClientEvents.ExtEvents.Strings = (
        
          'columnhide=function columnhide(ct, column, eOpts)'#13#10'{'#13#10'  if (colu' +
          'mn.dataIndex >= 0) { //column.dataIndex >= 0 '#1080#1089#1087#1088#1072#1074#1083#1077#1085#1080#1077' Argumen' +
          't out of range'#13#10'    ajaxRequest(this, '#39'_columnhide'#39', ["column=" ' +
          '+ column.dataIndex, "hidden=" + column.hidden]);'#13#10'  }'#13#10'}'
        
          'columnshow=function columnshow(ct, column, eOpts)'#13#10'{'#13#10'  ajaxRequ' +
          'est(this, '#39'_columnshow'#39', ["column=" + column.dataIndex, "hidden=' +
          '" + column.hidden]);'#13#10'}')
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
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgFilterClearButton]
      WebOptions.PageSize = 50
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Color = clActiveCaption
      EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
      LayoutConfig.ComponentCls = 'grid-status'
      LayoutConfig.Height = '100'
      LayoutConfig.Width = '100'
      BorderStyle = ubsNone
      Align = alClient
      Anchors = []
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      DragDrop.Enabled = True
      DragDrop.EnableDrag = True
      DragDrop.EnableDrop = True
      DragDrop.PromptText = '%d '#1079#1072#1087#1080#1089#1100' '#1073#1091#1076#1077#1090' '#1087#1077#1088#1077#1084#1077#1097#1077#1085#1072'. '#1055#1088#1086#1076#1086#1083#1078#1080#1090#1100'?'
      DragDrop.Mode = dmCopy
      OnAjaxEvent = GridAjaxEvent
      OnColumnSort = GridColumnSort
      OnColumnMove = GridColumnMove
      OnClearFilters = GridClearFilters
      OnCellContextClick = GridCellContextClick
      OnDrawColumnCell = GridDrawColumnCell
      OnColumnResize = GridColumnResize
      OnDropRowsEvent = GridDropRowsEvent
      OnColumnFilter = GridColumnFilter
      Columns = <
        item
          FieldName = 'NodeID'
          Title.Alignment = taCenter
          Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
          Width = 125
          Visible = False
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'Flag'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089#1099
          Width = 78
          Visible = False
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'Brief'
          Filtering.Enabled = True
          Filtering.Editor = flNodeBrief
          Title.Caption = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077
          Width = 200
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'Name'
          Filtering.Enabled = True
          Filtering.Editor = flNodeName
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 325
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'TypeDescription'
          Filtering.Enabled = True
          Filtering.Editor = cbNodeType
          Title.Caption = #1058#1080#1087
          Width = 115
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'Comment'
          Title.Alignment = taCenter
          Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          Width = 508
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'ColorID'
          Title.Caption = 'ColorID'
          Width = 196
          Visible = False
          ReadOnly = True
          Sortable = True
        end
        item
          AllowHTML = False
          FieldName = 'Color'
          Title.Alignment = taCenter
          Title.Caption = #1062#1074#1077#1090
          Width = 148
          Visible = False
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'N'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1088#1103#1076#1082#1086#1074#1099#1081' '#1085#1086#1084#1077#1088
          Width = 80
          Hint = #1053#1086#1084#1077#1088' '#1076#1083#1103' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080' '#1074#1099#1074#1086#1076#1072
          Sortable = True
        end>
    end
  end
  object UniHiddenPanel1: TUniHiddenPanel
    Left = 582
    Top = 174
    Width = 160
    Height = 256
    Hint = ''
    Visible = True
    ShowHint = True
    object cbNodeType: TUniComboBox
      Left = 12
      Top = 32
      Width = 117
      Hint = ''
      ShowHint = True
      Text = 'cbNodeType'
      Items.Strings = (
        #1057#1086#1089#1090#1086#1103#1085#1080#1077
        #1044#1077#1081#1089#1090#1074#1080#1077)
      ItemIndex = 0
      TabOrder = 1
      EmptyText = #1058#1080#1087'...'
      ClearButton = True
      IconItems = <>
    end
    object flNodeBrief: TUniEdit
      Left = 10
      Top = 60
      Width = 119
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 2
      EmptyText = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077'...'
      ClearButton = True
    end
    object flNodeName: TUniEdit
      Left = 11
      Top = 88
      Width = 118
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 3
      EmptyText = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'...'
      ClearButton = True
    end
  end
  object Query: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    FormatOptions.AssignedValues = [fvDefaultParamDataType]
    FormatOptions.DefaultParamDataType = ftString
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.UpdateTableName = 'tNodes'
    UpdateOptions.KeyFields = 'NodeID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'SELECT n.*'
      '  FROM vNodes as n'
      ' where 1=1'
      ' '
      '  -- and n.Type  = isnull(nullif(:TypeDescription, -1), n.Type)'
      ''
      
        '   and n.TypeDescription   like isnull(:TypeDescription, n.TypeD' +
        'escription)'
      '   and n.Brief   like isnull(:Brief, n.Brief)'
      '   and n.Name   like isnull(:Name, n.Name)'
      ' '
      ' order by n.Type, n.N')
    Left = 684
    Top = 120
    ParamData = <
      item
        Name = 'TYPEDESCRIPTION'
        ParamType = ptInput
      end
      item
        Name = 'BRIEF'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object QueryNodeID: TFMTBCDField
      FieldName = 'NodeID'
      Origin = 'NodeID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      Required = True
      Precision = 18
      Size = 0
    end
    object QueryFlag: TIntegerField
      FieldName = 'Flag'
      Origin = 'Flag'
      ReadOnly = True
    end
    object QueryBrief: TWideStringField
      FieldName = 'Brief'
      Origin = 'Brief'
      ReadOnly = True
      Required = True
      Size = 128
    end
    object QueryName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      ReadOnly = True
      Required = True
      Size = 128
    end
    object QueryDescription: TWideStringField
      FieldName = 'Comment'
      Origin = 'Description'
      ReadOnly = True
      Size = 512
    end
    object QueryColorID: TWideStringField
      FieldName = 'ColorID'
      Origin = 'ColorID'
      ReadOnly = True
      Visible = False
      Size = 32
    end
    object QueryColor: TWideStringField
      FieldName = 'Color'
      Origin = 'Color'
      ReadOnly = True
      Visible = False
      Size = 60
    end
    object QueryTypeDescription: TStringField
      FieldName = 'TypeDescription'
      Origin = 'TypeDescription'
      ReadOnly = True
      Required = True
      Size = 9
    end
    object QueryN: TIntegerField
      FieldName = 'N'
    end
    object QueryType: TIntegerField
      FieldName = 'Type'
      Origin = 'Type'
      ReadOnly = True
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 683
    Top = 178
  end
  object ActionList: TUniActionList
    Left = 221
    Top = 195
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 1
      OnExecute = actEditExecute
    end
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 3
      OnExecute = actRefreshAllExecute
    end
    object actInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 0
      OnExecute = actInsertExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnExecute = actDeleteExecute
    end
    object actView: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      OnExecute = actViewExecute
    end
  end
  object PopupMenu: TUniPopupMenu
    Images = UniMainModule.BaseImage
    Left = 218
    Top = 271
    object N1: TUniMenuItem
      Action = actInsert
    end
    object N2: TUniMenuItem
      Action = actEdit
    end
    object N4: TUniMenuItem
      Action = actView
    end
    object N3: TUniMenuItem
      Action = actDelete
    end
    object N5: TUniMenuItem
      Caption = '-'
    end
    object N6: TUniMenuItem
      Action = actRefreshAll
    end
  end
  object UpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    InsertSQL.Strings = (
      'select 0')
    ModifySQL.Strings = (
      'UPDATE tNodes'
      '   SET N = :NEW_N'
      ' WHERE NodeID = :OLD_NodeID')
    DeleteSQL.Strings = (
      'select 0')
    FetchRowSQL.Strings = (
      'select * '
      '  from tNodes   (nolock)'
      'WHERE NodeID = :OLD_NodeID')
    Left = 532
    Top = 120
  end
end
