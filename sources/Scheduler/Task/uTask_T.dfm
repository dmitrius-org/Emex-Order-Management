object Task_T: TTask_T
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 1173
  Height = 589
  OnCreate = UniFrameCreate
  OnReady = UniFrameReady
  Layout = 'fit'
  LayoutConfig.Width = '100'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  TabOrder = 0
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 4
    Top = 4
    Width = 1166
    Height = 67
    Hint = ''
    Margins.Left = 4
    Margins.Top = 4
    Margins.Bottom = 0
    ShowHint = True
    ParentShowHint = False
    Align = alTop
    TabOrder = 0
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
      Width = 1166
      Height = 67
      Hint = ''
      Margins.Bottom = 0
      ShowHint = True
      ButtonHeight = 60
      ButtonWidth = 168
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
        Margins.Left = 0
        Margins.Right = 0
        ShowHint = True
        Action = actAdd
        ImageIndex = 0
        TabOrder = 1
      end
      object UniToolButton2: TUniToolButton
        Left = 168
        Top = 0
        Margins.Left = 0
        Margins.Right = 0
        ShowHint = True
        Action = actEdit
        ImageIndex = 1
        TabOrder = 2
      end
      object UniToolButton4: TUniToolButton
        Left = 336
        Top = 0
        ShowHint = True
        Action = actDelete
        ImageIndex = 2
        TabOrder = 3
        ExplicitLeft = 504
      end
      object UniToolButton5: TUniToolButton
        Left = 504
        Top = 0
        ShowHint = True
        Action = actRefreshAll
        ImageIndex = 3
        TabOrder = 5
        ExplicitLeft = 672
      end
      object tbActive: TUniToolButton
        Left = 672
        Top = 0
        ShowHint = True
        Action = actTaskActive
        ImageIndex = 13
        TabOrder = 4
        ExplicitLeft = 840
      end
    end
  end
  object UniPanel2: TUniPanel
    Left = 0
    Top = 71
    Width = 1173
    Height = 518
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    Align = alClient
    TabOrder = 1
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
    object pnlCommon: TUniContainerPanel
      Left = 0
      Top = 0
      Width = 1173
      Height = 518
      Hint = ''
      ShowHint = True
      ParentColor = False
      Align = alClient
      TabOrder = 1
      Layout = 'border'
      object pnlTask: TUniContainerPanel
        Left = 0
        Top = 0
        Width = 1173
        Height = 400
        Hint = ''
        ShowHint = True
        ParentColor = False
        Align = alTop
        TabOrder = 1
        Layout = 'fit'
        LayoutConfig.Split = True
        LayoutConfig.Region = 'north'
        object GridTasks: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1173
          Height = 400
          Hint = ''
          ShowHint = True
          BodyRTL = False
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
              'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
              'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
              'data[sender.uniCol+1];'#13#10'        el.value = document.activeElemen' +
              't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
              '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
              'ent.body.removeChild(el);'#13#10'    };'#13#10'}')
          DataSource = dsTask
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgFilterClearButton]
          WebOptions.Paged = False
          WebOptions.PageSize = 50
          WebOptions.AppendPosition = tpCurrentRow
          WebOptions.FetchAll = True
          LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
          LoadMask.Color = clActiveCaption
          LayoutConfig.ComponentCls = 'grid-task'
          LayoutConfig.Height = '100'
          LayoutConfig.Width = '100'
          BorderStyle = ubsNone
          Align = alClient
          Anchors = []
          TabOrder = 1
          ParentColor = False
          Color = clBtnFace
          OnKeyDown = GridTasksKeyDown
          OnCellContextClick = GridTasksCellContextClick
          Columns = <
            item
              FieldName = 'TaskID'
              Title.Alignment = taCenter
              Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
              Title.Font.Height = -13
              Width = 118
              Visible = False
              ReadOnly = True
            end
            item
              FieldName = 'Flag'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1072#1090#1091#1089
              Width = 64
              Alignment = taCenter
            end
            item
              FieldName = 'IsActive'
              Title.Alignment = taCenter
              Title.Caption = ' '#1040#1082#1090#1080#1074#1077#1085
              Title.Font.Height = -13
              Width = 74
              Alignment = taCenter
            end
            item
              FieldName = 'Brief'
              Title.Alignment = taCenter
              Title.Caption = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077
              Title.Font.Height = -13
              Width = 244
            end
            item
              FieldName = 'Name'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              Title.Font.Height = -13
              Width = 335
            end
            item
              FieldName = 'DateBegin'
              Title.Alignment = taCenter
              Title.Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
              Title.Font.Height = -13
              Width = 160
              Visible = False
            end
            item
              FieldName = 'DateExec'
              Title.Alignment = taCenter
              Title.Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1076#1072#1090#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
              Title.Font.Height = -13
              Width = 145
            end
            item
              FieldName = 'inDatetime'
              Title.Alignment = taCenter
              Title.Caption = #1044#1072#1090#1072' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103
              Title.Font.Height = -13
              Width = 150
              Visible = False
            end
            item
              FieldName = 'updDatetime'
              Title.Alignment = taCenter
              Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
              Title.Font.Height = -13
              Width = 150
            end
            item
              FieldName = 'Message'
              Title.Alignment = taCenter
              Title.Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
              Title.Font.Height = -13
              Width = 400
            end>
        end
      end
      object pnlTaskDetail: TUniContainerPanel
        Left = 0
        Top = 400
        Width = 1173
        Height = 118
        Hint = ''
        ShowHint = True
        ParentColor = False
        Align = alClient
        TabOrder = 2
        Layout = 'fit'
        LayoutConfig.Region = 'center'
        object GridDetail: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1173
          Height = 118
          Hint = ''
          ShowHint = True
          BodyRTL = False
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
              'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
              'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
              'data[sender.uniCol+1];'#13#10'        el.value = document.activeElemen' +
              't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
              '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
              'ent.body.removeChild(el);'#13#10'    };'#13#10'}'
            
              'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
              'r.getDockedItems()[1]; //Remove the ToolBar fixed in the bottom'#13 +
              #10'  toolbar.items.getAt(10).hide(); //Remove the Refresh button i' +
              'n the ToolBar, number 10, hide him'#13#10'}')
          HeaderTitle = #1046#1091#1088#1085#1072#1083
          DataSource = dsTDetail
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgFilterClearButton]
          WebOptions.PageSize = 50
          WebOptions.AppendPosition = tpCurrentRow
          WebOptions.FetchAll = True
          LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
          LoadMask.Color = clActiveCaption
          LayoutConfig.ComponentCls = 'grid-task-detail'
          LayoutConfig.Height = '100'
          LayoutConfig.Width = '100'
          BorderStyle = ubsNone
          Align = alClient
          Anchors = []
          TabOrder = 1
          ParentColor = False
          Color = clBtnFace
          OnKeyDown = GridDetailKeyDown
          Columns = <
            item
              FieldName = 'TaskID'
              Title.Alignment = taCenter
              Title.Caption = 'TaskID'
              Width = 118
              Visible = False
              ReadOnly = True
            end
            item
              FieldName = 'Flag'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1072#1090#1091#1089#1099
              Width = 84
            end
            item
              FieldName = 'Comment'
              Title.Alignment = taCenter
              Title.Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
              Width = 840
              DisplayMemo = True
            end
            item
              FieldName = 'InDateTime'
              Title.Alignment = taCenter
              Title.Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103' '#1086#1087#1077#1088#1072#1094#1080#1080
              Width = 181
            end>
        end
      end
    end
  end
  object qTask: TFDQuery
    IndexFieldNames = 'TaskID'
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.UpdateTableName = 'tTask'
    UpdateOptions.KeyFields = 'TaskID'
    UpdateOptions.AutoIncFields = 'TaskID'
    UpdateObject = FDUpdateSQL
    SQL.Strings = (
      'Select *'
      '  from vTask')
    Left = 684
    Top = 119
    object qTaskTaskID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'TaskID'
      Origin = 'TaskID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object qTaskFlag: TIntegerField
      FieldName = 'Flag'
      OnGetText = qTaskFlagGetText
    end
    object qTaskBrief: TWideStringField
      FieldName = 'Brief'
      Origin = 'Brief'
      Size = 60
    end
    object qTaskName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Size = 128
    end
    object qTaskDateBegin: TSQLTimeStampField
      FieldName = 'DateBegin'
      Origin = 'DateBegin'
    end
    object qTaskDateExec: TSQLTimeStampField
      FieldName = 'DateExec'
      Origin = 'DateExec'
    end
    object qTaskinDatetime: TSQLTimeStampField
      FieldName = 'inDatetime'
      Origin = 'inDatetime'
    end
    object qTaskupdDatetime: TSQLTimeStampField
      FieldName = 'updDatetime'
      Origin = 'updDatetime'
    end
    object qTaskIsActive: TBooleanField
      FieldName = 'IsActive'
      Origin = 'IsActive'
    end
    object qTaskMessage: TWideStringField
      FieldName = 'Message'
      Size = 2000
    end
  end
  object dsTask: TDataSource
    DataSet = qTask
    Left = 686
    Top = 181
  end
  object ActionList: TUniActionList
    Left = 222
    Top = 196
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
    object actDateExecClear: TAction
      Caption = #1055#1077#1088#1077#1079#1072#1087#1091#1089#1090#1080#1090#1100' '#1079#1072#1076#1072#1085#1080#1077
      ImageIndex = 12
      OnExecute = actDateExecClearExecute
    end
    object actTaskActive: TAction
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1079#1072#1076#1072#1095
      Checked = True
      ImageIndex = 13
      OnExecute = actTaskActiveExecute
    end
    object actTaskEnabled: TAction
      Caption = #1042#1082#1083#1102#1095#1077#1085#1080#1077'/'#1074#1099#1082#1083#1102#1095#1077#1085#1080#1077' '#1079#1072#1076#1072#1085#1080#1103
      OnExecute = actTaskEnabledExecute
    end
  end
  object PopupMenu: TUniPopupMenu
    Images = UniMainModule.BaseImage
    OnPopup = PopupMenuPopup
    Left = 219
    Top = 271
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
    object actTaskEnabled1: TUniMenuItem
      Action = actTaskEnabled
    end
    object N7: TUniMenuItem
      Action = actDateExecClear
    end
    object N10: TUniMenuItem
      Caption = '-'
    end
    object N6: TUniMenuItem
      Action = actRefreshAll
    end
  end
  object FDUpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    InsertSQL.Strings = (
      '')
    ModifySQL.Strings = (
      'Select :NEW_TaskID as TaskID')
    DeleteSQL.Strings = (
      '--DELETE FROM PRICEDB.dbo.tTask'
      '--WHERE TaskID = :OLD_TaskID')
    FetchRowSQL.Strings = (
      'SELECT *'
      '  FROM vTask'
      ' WHERE TaskID = :OLD_TaskID')
    Left = 751
    Top = 118
  end
  object qTDetail: TFDQuery
    IndexFieldNames = 'TaskID'
    MasterSource = dsTask
    MasterFields = 'TaskID'
    DetailFields = 'TaskID'
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evDetailOptimize, evDetailCascade]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.UpdateTableName = 'tTask'
    UpdateOptions.KeyFields = 'TaskID'
    SQL.Strings = (
      'Select *'
      '  from vTaskDetail'
      ' order by InDateTime desc')
    Left = 868
    Top = 183
    object FMTBCDField1: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'TaskID'
      Origin = 'TaskID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object SQLTimeStampField3: TSQLTimeStampField
      FieldName = 'InDateTime'
      Origin = 'InDateTime'
    end
    object qTDetailComment: TStringField
      FieldName = 'Comment'
      Size = 1024
    end
    object qTDetailFlag: TIntegerField
      FieldName = 'Flag'
    end
  end
  object dsTDetail: TDataSource
    DataSet = qTDetail
    Left = 870
    Top = 237
  end
end
