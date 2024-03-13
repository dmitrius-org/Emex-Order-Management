object InstrumentStateT: TInstrumentStateT
  Left = 0
  Top = 0
  Width = 887
  Height = 403
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
    Width = 887
    Height = 403
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    BodyRTL = False
    ClientEvents.UniEvents.Strings = (
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
        'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
        'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
        'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
        'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
        'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
        't.body.removeChild(el);'#13#10'    };'#13#10'}'
      
        'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'    var toolbar=sen' +
        'der.getDockedItems()[1]; //Remove the ToolBar fixed in the botto' +
        'm'#13#10'    toolbar.items.getAt(10).hide(); //Remove the Refresh butt' +
        'on in the ToolBar, number 10, hide him'#13#10'}')
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
        FieldName = 'Type'
        Title.Caption = #1058#1080#1087
        Width = 145
      end
      item
        FieldName = 'Brief'
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 302
      end
      item
        FieldName = 'Comment'
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        Width = 384
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
      'Select *'
      '  from tNodeExt (nolock)'
      ' where NodeID = :NodeID')
    Left = 683
    Top = 103
    ParamData = <
      item
        Name = 'NODEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QueryNodeExtID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'NodeExtID'
      Origin = 'NodeExtID'
      ProviderFlags = [pfInWhere]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QueryNodeID: TFMTBCDField
      FieldName = 'NodeID'
      Origin = 'NodeID'
      Precision = 18
      Size = 0
    end
    object QueryBrief: TWideStringField
      FieldName = 'Brief'
      Origin = 'Brief'
      Required = True
      Size = 128
    end
    object QueryComment: TWideStringField
      FieldName = 'Comment'
      Origin = 'Comment'
      Size = 512
    end
    object QueryFlag: TIntegerField
      FieldName = 'Flag'
      Origin = 'Flag'
    end
    object QueryType: TIntegerField
      FieldName = 'Type'
      Origin = 'Type'
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
    InsertSQL.Strings = (
      'INSERT INTO tNodeExt'
      '       (NodeID, Brief, Comment, Flag, Type)'
      
        'Select :NEW_NodeID, :NEW_Brief, :NEW_Comment, :NEW_Flag, :NEW_Ty' +
        'pe'
      ' where not exists (select 1'
      '                     FROM tNodeExt (nolock)'
      '                    where Type = :NEW_Type'
      '                      and Brief= :NEW_Brief'
      '                  )'
      '  '
      ''
      '     /*'
      'SELECT SCOPE_IDENTITY() AS NodeExtID, Flag'
      '  FROM PRICEDB.dbo.tNodeExt'
      
        ' WHERE NodeExtID = SCOPE_IDENTITY() AND NodeID = :NEW_NodeID AND' +
        ' Brief = :NEW_Brief AND '
      '  Comment = :NEW_Comment AND Type = :NEW_Type     */')
    ModifySQL.Strings = (
      'UPDATE tNodeExt'
      '   SET Brief    = :NEW_Brief,  '
      '       Type     = :NEW_Type,'
      '       Comment  = :NEW_Comment'
      'WHERE NodeExtID = :OLD_NodeExtID '
      ''
      '/*'
      'SELECT Flag'
      'FROM PRICEDB.dbo.tNodeExt'
      
        'WHERE NodeExtID = :NEW_NodeExtID AND NodeID = :NEW_NodeID AND Br' +
        'ief = :NEW_Brief AND '
      
        '  Comment = :NEW_Comment AND Flag = :NEW_Flag AND Type = :NEW_Ty' +
        'pe'
      '  */')
    DeleteSQL.Strings = (
      'DELETE FROM tNodeExt'
      'WHERE NodeExtID = :OLD_NodeExtID')
    FetchRowSQL.Strings = (
      'SELECT NodeExtID, NodeID, Brief, Comment, Flag, Type'
      '  FROM tNodeExt (nolock)'
      ' WHERE NodeExtID = :OLD_NodeExtID')
    Left = 748
    Top = 101
  end
end
