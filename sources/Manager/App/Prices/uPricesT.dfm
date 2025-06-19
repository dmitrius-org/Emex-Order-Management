object PricesT: TPricesT
  Left = 0
  Top = 0
  Width = 1027
  Height = 502
  OnCreate = UniFrameCreate
  OnDestroy = UniFrameDestroy
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
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1021
    Height = 67
    Hint = ''
    Margins.Bottom = 0
    ShowHint = True
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
      Width = 1021
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
      LayoutConfig.Region = 'center'
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
        TabOrder = 0
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
    Top = 70
    Width = 1027
    Height = 432
    Hint = ''
    ShowHint = True
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
    object Grid: TUniDBGrid
      Left = 0
      Top = 0
      Width = 1027
      Height = 432
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
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgFilterClearButton]
      WebOptions.PageSize = 50
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Color = clActiveCaption
      EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
      LayoutConfig.ComponentCls = 'grid-prices'
      LayoutConfig.Height = '100'
      LayoutConfig.Width = '100'
      BorderStyle = ubsNone
      Align = alClient
      Anchors = []
      TabOrder = 0
      ParentColor = False
      Color = clBtnFace
      OnKeyDown = GridKeyDown
      OnColumnSort = GridColumnSort
      OnClearFilters = GridClearFilters
      OnCellContextClick = GridCellContextClick
      OnColumnFilter = GridColumnFilter
      Columns = <
        item
          FieldName = 'SupplierBrief'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
          Width = 200
          Editor = cbSuppliers
          Sortable = True
        end
        item
          FieldName = 'Name'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1072#1081#1089#1072
          Width = 200
          Sortable = True
        end
        item
          FieldName = 'DeliveryTerm'
          Title.Alignment = taCenter
          Title.Caption = #1057#1088#1086#1082' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1087#1086' '#1087#1088#1072#1081#1089#1091
          Width = 172
          Sortable = True
        end
        item
          FieldName = 'DeliveryType'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087' '#1089#1088#1086#1082#1072' '#1076#1086#1089#1090#1072#1074#1082#1080
          Width = 184
          Editor = cbDeliveryType
          Sortable = True
        end
        item
          FieldName = 'InWorkingDays'
          Title.Alignment = taCenter
          Title.Caption = #1057#1088#1086#1082' '#1091#1082#1072#1079#1072#1085' '#1074' '#1088#1072#1073#1086#1095#1080#1093' '#1076#1085#1103#1093
          Width = 103
          Hint = #1057#1088#1086#1082' '#1091#1082#1072#1079#1072#1085' '#1074' '#1088#1072#1073#1086#1095#1080#1093' '#1076#1085#1103#1093
          Sortable = True
          CheckBoxField.AutoPost = True
        end
        item
          FieldName = 'ShowInSearch'
          Title.Alignment = taCenter
          Title.Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074' '#1087#1086#1080#1089#1082#1077
          Width = 110
          Sortable = True
          CheckBoxField.AutoPost = True
        end
        item
          FieldName = 'Comment'
          Title.Alignment = taCenter
          Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          Width = 400
          Sortable = True
        end>
    end
    object UniHiddenPanel1: TUniHiddenPanel
      Left = 814
      Top = 126
      Width = 160
      Height = 256
      Hint = ''
      Visible = True
      ShowHint = True
      object cbDeliveryType: TUniComboBox
        Left = 26
        Top = 29
        Width = 114
        Height = 23
        Hint = ''
        ShowHint = True
        Style = csOwnerDrawFixed
        Text = ''
        Items.Strings = (
          'Days'
          'Months  ')
        TabOrder = 1
        IconItems = <>
      end
      object cbSuppliers: TUniExComboBox
        Left = 24
        Top = 72
        Width = 109
        Hint = ''
        ShowHint = True
        Style = csOwnerDrawFixed
        Text = ''
        TabOrder = 2
        AnyMatch = True
        IconItems = <>
        Value = '-1'
      end
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
    UpdateOptions.KeyFields = 'SupplierPricesID'
    UpdateOptions.AutoIncFields = 'SupplierPricesID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'select * '
      '  from vSuppliersPrices')
    Left = 686
    Top = 101
    object QuerySupplierBrief: TStringField
      FieldName = 'SupplierBrief'
      Size = 128
    end
    object QueryDeliveryType: TStringField
      FieldName = 'DeliveryType'
      Required = True
      Size = 30
    end
    object QueryName: TStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 30
    end
    object CommentName: TStringField
      FieldName = 'Comment'
      Origin = 'Comment'
      Size = 256
    end
    object QueryDeliveryTerm: TIntegerField
      FieldName = 'DeliveryTerm'
      Required = True
    end
    object QueryInWorkingDays: TBooleanField
      FieldName = 'InWorkingDays'
    end
    object QueryShowInSearch: TBooleanField
      FieldName = 'ShowInSearch'
    end
    object QuerySupplierPricesID: TFMTBCDField
      FieldName = 'SupplierPricesID'
    end
    object QuerySuppliersID: TFMTBCDField
      FieldName = 'SuppliersID'
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
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
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
      'declare @R       numeric(18, 0)'
      '       ,@Name    nvarchar(30)'
      ''
      'select @Name = :NEW_Name'
      ''
      'if isnull(@Name , '#39#39') = '#39#39
      'begin'
      ' RAISERROR ('#39#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1072#1081#1089#1072#39', 16, 1); '
      'end'
      ''
      'if exists (select 1'
      '             from vSupplierPrices (nolock)'
      '            where SuppliersID = :SuppliersID'
      '              and Name= @Name)'
      'begin'
      
        '   select @R = 600 -- '#39#1055#1088#1072#1081#1089#1083#1080#1089#1090' '#1089' '#1079#1072#1076#1072#1085#1085#1099#1084' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077#1084' '#1089#1091#1097#1077#1089#1090 +
        #1074#1091#1102#1090'!'#39
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
      'INSERT INTO tSupplierPrices '
      '           ([Name]'
      '           ,[Comment]'
      '           ,[DeliveryTerm]'
      '           ,[DeliveryType]'
      '           ,[Flag]'
      '           ,[InWorkingDays]'
      '           ,[ShowInSearch]  '
      '           ,[SuppliersID] '
      '           )'
      '     VALUES'
      '           (@Name '
      '           ,:NEW_Comment'
      '           ,:NEW_DeliveryTerm'
      '           ,:NEW_DeliveryType'
      '           ,:NEW_Flag'
      '           ,:New_InWorkingDays'
      '           ,:NEW_ShowInSearch'
      '           ,:NEW_SuppliersID'
      '           )'
      ''
      'SELECT @Name AS Name')
    ModifySQL.Strings = (
      'declare @R       numeric(18, 0)'
      '       ,@Name    nvarchar(30)'
      ''
      'select @Name = :NEW_Name'
      ''
      'if isnull(@Name , '#39#39') = '#39#39
      'begin'
      ' RAISERROR ('#39#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1072#1081#1089#1072#39', 16, 1); '
      'end'
      ''
      'if exists (select 1'
      '             from tSupplierPrices (nolock)'
      '            where SuppliersID = :OLD_SuppliersID'
      '              and Name        = @Name'
      '              and Name       <> :OLD_Name)'
      'begin'
      
        '   select @r = 600 -- '#39#1055#1088#1072#1081#1089#1083#1080#1089#1090' '#1089' '#1079#1072#1076#1072#1085#1085#1099#1084' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077#1084' '#1089#1091#1097#1077#1089#1090 +
        #1074#1091#1102#1090'!'#39
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
      'UPDATE tSupplierPrices'
      '   SET Name             = @Name'
      '      ,Comment          = :NEW_Comment'
      '      ,DeliveryTerm     = :NEW_DeliveryTerm'
      '      ,DeliveryType     = :NEW_DeliveryType'
      '      ,Flag             = :NEW_Flag'
      '      ,InWorkingDays    = :NEW_InWorkingDays'
      '      ,ShowInSearch     = :NEW_ShowInSearch'
      ' WHERE SupplierPricesID = :OLD_SupplierPricesID;'
      ' '
      'SELECT @Name as Name        '
      '')
    DeleteSQL.Strings = (
      'exec SupplierPricesDelete'
      '       @SupplierPricesID= :OLD_SupplierPricesID ')
    FetchRowSQL.Strings = (
      'SELECT * '
      '  FROM vSuppliersPrices'
      ' WHERE SupplierPricesID = :SupplierPricesID')
    Left = 794
    Top = 101
  end
end
