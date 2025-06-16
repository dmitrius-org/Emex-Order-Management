object SuppliersT: TSuppliersT
  Left = 0
  Top = 0
  Width = 1027
  Height = 502
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
  ClientEvents.UniEvents.Strings = (
    
      'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
      'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
      'ent('#39'textarea'#39');'#13#10'        el.value = sender.getSelection()[0].da' +
      'ta[sender.uniCol+1];'#13#10'       // el.value = document.activeElemen' +
      't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
      '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
      'ent.body.removeChild(el);'#13#10'    };'#13#10'}')
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
    Left = 0
    Top = 0
    Width = 1027
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
      Width = 1027
      Height = 67
      Hint = ''
      ShowHint = True
      ButtonHeight = 60
      ButtonWidth = 90
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
        Left = 99
        Top = 3
        ShowHint = True
        Action = actEdit
        ImageIndex = 1
        TabOrder = 2
      end
      object UniToolButton4: TUniToolButton
        AlignWithMargins = True
        Left = 195
        Top = 3
        ShowHint = True
        Action = actDelete
        ImageIndex = 2
        TabOrder = 3
      end
    end
  end
  object UniPanel2: TUniPanel
    Left = 0
    Top = 67
    Width = 1027
    Height = 435
    Hint = ''
    ShowHint = True
    Align = alClient
    TabOrder = 2
    BorderStyle = ubsNone
    Caption = 'UniPanel2'
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'fit'
    LayoutConfig.Flex = 1
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'center'
    object Grid: TUniDBGrid
      Left = 0
      Top = 0
      Width = 1027
      Height = 435
      Hint = ''
      ShowHint = True
      BodyRTL = False
      ClientEvents.UniEvents.Strings = (
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
          'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
          'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
          'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
          't.body.removeChild(el);'#13#10'    };'#13#10'}'
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
          'r.getDockedItems()[1]; //Remove the ToolBar fixed in the bottom'#13 +
          #10'  toolbar.items.getAt(10).hide(); //Remove the Refresh button i' +
          'n the ToolBar, number 10, hide him'#13#10#13#10'}')
      RowEditor = True
      DataSource = DataSource
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgFilterClearButton]
      WebOptions.PageSize = 50
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Color = clActiveCaption
      EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
      LayoutConfig.Height = '100'
      LayoutConfig.Width = '100'
      BorderStyle = ubsNone
      Align = alClient
      Anchors = []
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      OnKeyDown = GridKeyDown
      OnClearFilters = GridClearFilters
      OnCellContextClick = GridCellContextClick
      OnColumnFilter = GridColumnFilter
      Columns = <
        item
          FieldName = 'SuppliersID'
          Title.Alignment = taCenter
          Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
          Width = 134
          ReadOnly = True
        end
        item
          FieldName = 'Brief'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
          Width = 718
        end
        item
          FieldName = 'Name'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 200
          Visible = False
        end
        item
          FieldName = 'GroupName'
          Title.Alignment = taCenter
          Title.Caption = #1043#1088#1091#1087#1087#1072
          Width = 388
          Sortable = True
        end
        item
          FieldName = 'UserID'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Width = 118
          Visible = False
          ReadOnly = True
        end
        item
          FieldName = 'inDatetime'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
          Width = 208
          Visible = False
          ReadOnly = True
        end
        item
          FieldName = 'updDatetime'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
          Width = 208
          Visible = False
          ReadOnly = True
        end>
    end
  end
  object Query: TFDQuery
    AfterPost = QueryAfterPost
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.UpdateTableName = 'dbo.tSuppliers'
    UpdateOptions.KeyFields = 'SuppliersID'
    UpdateOptions.AutoIncFields = 'SuppliersID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'SELECT [SuppliersID]'
      '      ,[Brief]'
      '      ,[Name]'
      '      ,[GroupName]'
      '      ,[UserID]'
      '      ,[inDatetime]'
      '      ,[updDatetime]'
      '  FROM vSuppliers')
    Left = 686
    Top = 102
    object QuerySuppliersID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'SuppliersID'
      Origin = 'SuppliersID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QueryBrief: TWideStringField
      FieldName = 'Brief'
      Origin = 'Brief'
      Required = True
      Size = 256
    end
    object QueryName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Size = 512
    end
    object QueryUserID: TFMTBCDField
      FieldName = 'UserID'
      Origin = 'UserID'
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QueryinDatetime: TSQLTimeStampField
      FieldName = 'inDatetime'
      Origin = 'inDatetime'
      ReadOnly = True
    end
    object QueryupdDatetime: TSQLTimeStampField
      FieldName = 'updDatetime'
      Origin = 'updDatetime'
      ReadOnly = True
    end
    object QueryGroupName: TStringField
      FieldName = 'GroupName'
      Size = 64
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 683
    Top = 178
  end
  object ActionList: TUniActionList
    Left = 221
    Top = 196
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
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
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 3
      OnExecute = actRefreshAllExecute
    end
  end
  object PopupMenu: TUniPopupMenu
    Images = UniMainModule.BaseImage
    Left = 218
    Top = 270
    object N1: TUniMenuItem
      Action = actAdd
    end
    object N2: TUniMenuItem
      Action = actEdit
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
  end
  object UpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    InsertSQL.Strings = (
      '/*'
      'declare @R numeric(18, 0)'
      ''
      'if exists (select 1'
      '             from tSuppliers (nolock)'
      '            where Brief     = :NEW_Brief'
      '              and PriceName = :NEW_PriceName)'
      'begin'
      
        '   select @r = 200 --'#39#1055#1086#1089#1090#1072#1074#1097#1080#1082' '#1089' '#1079#1072#1076#1072#1085#1085#1099#1084' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077#1084' '#1080' '#1087#1088#1072#1081#1089 +
        #1086#1084' '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090'!'#39
      'end'
      ''
      'if @R > 0'
      'begin'
      ' declare @M nvarchar(1024)'
      ' set @M = dbo.GetRetMsg(@R)'
      ''
      ' RAISERROR (@M, 16, 1); '
      'end'
      ''
      ''
      ''
      ''
      'INSERT INTO tSuppliers'
      '       (Brief, Name, PriceName)'
      'VALUES (:NEW_Brief, :NEW_Name, :NEW_PriceName);'
      ''
      'SELECT SCOPE_IDENTITY() AS SuppliersID'
      '--*/')
    ModifySQL.Strings = (
      '/*'
      'declare @R numeric(18, 0)'
      ''
      'if exists (select 1'
      '             from tSuppliers (nolock)'
      '            where SuppliersID <> :OLD_SuppliersID'
      '              and Brief        = :NEW_Brief'
      '              and PriceName    = :NEW_PriceName)'
      'begin'
      
        '   select @r = 200 --'#39#1055#1086#1089#1090#1072#1074#1097#1080#1082' '#1089' '#1079#1072#1076#1072#1085#1085#1099#1084' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077#1084' '#1080' '#1087#1088#1072#1081#1089 +
        #1086#1084' '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090'!'#39
      'end'
      ''
      'if @R > 0'
      'begin'
      ' declare @M nvarchar(1024)'
      ' set @M = dbo.GetRetMsg(@R)'
      ''
      ' RAISERROR (@M, 16, 1); '
      'end'
      ''
      ''
      'UPDATE tSuppliers'
      '   SET Brief       = :NEW_Brief, '
      '       Name        = :NEW_Name, '
      '       PriceName   = :NEW_PriceName, '
      '       updDatetime = getDate()'
      ' WHERE SuppliersID = :OLD_SuppliersID;'
      ' '
      'SELECT SuppliersID'
      '  FROM tSuppliers (nolock)'
      ' WHERE SuppliersID = :SuppliersID'
      '---*/')
    DeleteSQL.Strings = (
      '/*'
      'declare @R numeric(18, 0)'
      ''
      'if exists (select 1'
      '             from tSuppliers (nolock)'
      '            where SuppliersID <> :OLD_SuppliersID'
      '              and Brief        = :NEW_Brief'
      '              and PriceName    = :NEW_PriceName)'
      'begin'
      
        '   select @r = 7 --'#39#1055#1086#1089#1090#1072#1074#1097#1080#1082' '#1089' '#1079#1072#1076#1072#1085#1085#1099#1084' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077#1084' '#1080' '#1087#1088#1072#1081#1089#1086#1084 +
        ' '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090'!'#39
      'end'
      ''
      'if @R > 0'
      'begin'
      ' declare @M nvarchar(1024)'
      ' set @M = dbo.GetRetMsg(@R)'
      ''
      ' RAISERROR (@M, 16, 1); '
      'end'
      ''
      ''
      ''
      'DELETE FROM dbo.tSuppliers'
      ' WHERE SuppliersID = :OLD_SuppliersID'
      '--*/')
    FetchRowSQL.Strings = (
      
        'SELECT SuppliersID, Brief, Name, GroupName, UserID, inDatetime, ' +
        'updDatetime'
      '  FROM vSuppliers'
      ' WHERE SuppliersID = :SuppliersID')
    Left = 794
    Top = 101
  end
end
