object InstrumentActionT: TInstrumentActionT
  Left = 0
  Top = 0
  Width = 887
  Height = 403
  OnReady = UniFrameReady
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
    Top = 35
    Width = 887
    Height = 368
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    BodyRTL = False
    ClientEvents.UniEvents.Strings = (
      
        'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
        'r.getDockedItems()[1]; //Remove the ToolBar fixed in the bottom'#13 +
        #10'  toolbar.items.getAt(10).hide(); //Remove the Refresh button i' +
        'n the ToolBar, number 10, hide him'#13#10'}'
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
        'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
        'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
        'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
        'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
        'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
        't.body.removeChild(el);'#13#10'    };'#13#10'}')
    RowEditor = True
    DataSource = DataSource
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgFilterClearButton, dgTabs]
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
        FieldName = 'N'
        Title.Caption = #8470
        Width = 64
      end
      item
        FieldName = 'Metod'
        Title.Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1076#1077#1081#1089#1090#1074#1080#1103
        Width = 302
        Editor = cbMetod
      end
      item
        FieldName = 'MetodRollback'
        Title.Caption = #1054#1090#1082#1072#1090' '#1076#1077#1081#1089#1090#1074#1080#1103
        Width = 285
        Editor = cbMetodRollback
      end
      item
        FieldName = 'Comment'
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        Width = 384
      end>
  end
  object UniToolBar1: TUniToolBar
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 881
    Height = 29
    Hint = ''
    ButtonWidth = 110
    ShowCaptions = True
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'north'
    Layout = 'absolute'
    TabOrder = 1
    ParentColor = False
    Color = clBtnFace
    object UniToolButton1: TUniToolButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Margins.Right = 0
      Action = acInsert
      TabOrder = 1
    end
    object UniToolButton2: TUniToolButton
      AlignWithMargins = True
      Left = 116
      Top = 3
      Margins.Right = 0
      Action = actEdit
      ImageIndex = 3
      TabOrder = 2
    end
    object UniToolButton3: TUniToolButton
      AlignWithMargins = True
      Left = 229
      Top = 3
      Margins.Right = 0
      Action = acDelete
      TabOrder = 3
    end
    object UniToolButton4: TUniToolButton
      AlignWithMargins = True
      Left = 342
      Top = 3
      Action = actRefreshAll
      TabOrder = 4
    end
  end
  object UniHiddenPanel1: TUniHiddenPanel
    Left = 504
    Top = 96
    Width = 160
    Height = 256
    Hint = ''
    Visible = True
    object cbMetod: TUniComboBox
      Left = 12
      Top = 48
      Width = 145
      Hint = ''
      Text = 'cbMetod'
      TabOrder = 1
      IconItems = <>
    end
    object cbMetodRollback: TUniComboBox
      Left = 12
      Top = 88
      Width = 145
      Hint = ''
      Text = 'cbMetod'
      TabOrder = 2
      IconItems = <>
    end
  end
  object Query: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.UpdateTableName = 'tModelMetod'
    UpdateOptions.KeyFields = 'ModelMetodID'
    UpdateOptions.AutoIncFields = 'ModelMetodID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'Select *'
      '  from tModelMetod (nolock)'
      ' where ModelID  = :ModelID')
    Left = 683
    Top = 102
    ParamData = <
      item
        Name = 'MODELID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
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
      Action = acInsert
    end
    object N2: TUniMenuItem
      Action = actEdit
    end
    object N4: TUniMenuItem
      Action = acDelete
    end
    object N5: TUniMenuItem
      Caption = '-'
    end
    object N6: TUniMenuItem
      Action = actRefreshAll
    end
  end
  object ActionList: TUniActionList
    Left = 222
    Top = 196
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 3
      OnExecute = actEditExecute
    end
    object acInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnExecute = acInsertExecute
    end
    object acDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = acDeleteExecute
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
    InsertSQL.Strings = (
      'if exists (select 1'
      '             FROM tModelMetod (nolock)'
      '            where ModelID = :ModelID'
      '              and Type    = 0'
      '              and Metod   = :NEW_Metod'
      '           )'
      '  RAISERROR ('#39#1054#1073#1098#1077#1082#1090' '#1089' '#1079#1072#1076#1072#1085#1085#1099#1084' '#1090#1080#1087#1086#1084' '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090'!'#39', 16, 1); '
      ''
      ''
      'INSERT INTO tModelMetod'
      
        '      ( ModelID,  Metod,      MetodRollback,      Comment,      ' +
        'Flag,      Type,     [N] )'
      
        'Select :ModelID, :NEW_Metod, :NEW_MetodRollback, :NEW_Comment, :' +
        'NEW_Flag, :NEW_Type, :NEW_N '
      ''
      '  ')
    ModifySQL.Strings = (
      ''
      ''
      ''
      ''
      'declare @R                 numeric(18, 0)'
      ''
      ''
      'if exists (      select 1'
      '                   FROM tModelMetod (nolock)'
      '                  where ModelID          = :ModelID          '
      '                    and Type             = 0'
      '                    and Metod            = :NEW_Metod'
      '                    and ModelMetodID    <> :OLD_ModelMetodID'
      '           )'
      ''
      '--if @R > 0'
      '--begin'
      ' -- declare @M nvarchar(1024) = dbo.GetRetMsg(@R)'
      ''
      '  RAISERROR ('#39#1054#1073#1098#1077#1082#1090' '#1089' '#1079#1072#1076#1072#1085#1085#1099#1084' '#1090#1080#1087#1086#1084' '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090'!'#39', 16, 1); '
      '--end'
      ''
      'UPDATE tModelMetod'
      '   SET Metod          = :NEW_Metod,   '
      '       MetodRollback  = :NEW_MetodRollback, '
      '       Comment        = :NEW_Comment,'
      '       N              = :NEW_N '
      'WHERE ModelMetodID    = :OLD_ModelMetodID'
      '  and not exists (select 1'
      '                   FROM tModelMetod (nolock)'
      '                  where ModelID          = :ModelID          '
      '                    and Type             = 0'
      '                    and Metod            = :NEW_Metod'
      '                    and ModelMetodID    <> :ModelMetodID'
      '                  )'
      '')
    DeleteSQL.Strings = (
      'DELETE '
      '  FROM tModelMetod '
      ' WHERE ModelMetodID = :OLD_ModelMetodID')
    FetchRowSQL.Strings = (
      'SELECT *'
      '  FROM tModelMetod (nolock)'
      ' WHERE ModelMetodID = :OLD_ModelMetodID')
    Left = 748
    Top = 101
  end
end
