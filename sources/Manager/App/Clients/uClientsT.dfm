object ClientsT: TClientsT
  Left = 0
  Top = 0
  Width = 1268
  Height = 574
  OnCreate = UniFrameCreate
  Layout = 'fit'
  LayoutConfig.Width = '100'
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
    Left = 0
    Top = 0
    Width = 1268
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
    LayoutConfig.Width = '100'
    LayoutConfig.Region = 'north'
    object ToolBar: TUniToolBar
      Left = 0
      Top = 0
      Width = 1268
      Height = 67
      Hint = ''
      ShowHint = True
      ButtonHeight = 53
      ButtonWidth = 112
      Images = ImageList
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
        ImageIndex = 1
        TabOrder = 1
      end
      object UniToolButton2: TUniToolButton
        AlignWithMargins = True
        Left = 118
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actEdit
        ImageIndex = 3
        TabOrder = 2
      end
      object UniToolButton3: TUniToolButton
        AlignWithMargins = True
        Left = 233
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actView
        ImageIndex = 2
        TabOrder = 3
      end
      object UniToolButton4: TUniToolButton
        AlignWithMargins = True
        Left = 348
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actDelete
        ImageIndex = 0
        TabOrder = 4
      end
      object UniToolButton5: TUniToolButton
        AlignWithMargins = True
        Left = 463
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actRefreshAll
        ImageIndex = 6
        TabOrder = 5
      end
      object UniToolButton9: TUniToolButton
        AlignWithMargins = True
        Left = 578
        Top = 3
        Margins.Left = 0
        Margins.Right = 0
        ShowHint = True
        Action = actClientType
        ImageIndex = 7
        TabOrder = 6
      end
      object tbSeparator: TUniToolButton
        AlignWithMargins = True
        Left = 690
        Top = 3
        Width = 8
        Hint = ''
        Margins.Left = 0
        Margins.Right = 0
        ShowHint = True
        Style = tbsSeparator
        Caption = 'tbSeparator'
        TabOrder = 7
      end
      object UniToolButton6: TUniToolButton
        AlignWithMargins = True
        Left = 698
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actBalance
        ImageIndex = 4
        TabOrder = 8
      end
      object UniToolButton7: TUniToolButton
        AlignWithMargins = True
        Left = 813
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actBalanceAdd
        ImageIndex = 5
        TabOrder = 9
      end
      object tbBalanceTotal: TUniToolButton
        AlignWithMargins = True
        Left = 928
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actBalanceTotal
        ImageIndex = 8
        TabOrder = 10
      end
    end
  end
  object UniPanel2: TUniPanel
    Left = 0
    Top = 67
    Width = 1268
    Height = 507
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
    LayoutConfig.Width = '100'
    LayoutConfig.Region = 'center'
    object Grid: TUniDBGrid
      Left = 0
      Top = 0
      Width = 1268
      Height = 507
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
          'n the ToolBar, number 10, hide him'#13#10'  toolbar.items.getAt(11).hi' +
          'de();'#13#10'}'
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
          'data[sender.uniCol+1];'#13#10'        el.value = document.activeElemen' +
          't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
          '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
          'ent.body.removeChild(el);'#13#10'    };'#13#10'}'
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'    config.displayInfo = true'#13#10'}')
      RowEditor = True
      DataSource = DataSource
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgConfirmDelete]
      WebOptions.PageSize = 300
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Color = clActiveCaption
      EmptyText = 
        '<div style="text-align: center;"><i class="fas fa-exclamation"><' +
        '/i> '#1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ... </div>'
      LayoutConfig.ComponentCls = 'grid-clients'
      LayoutConfig.Flex = 1
      BorderStyle = ubsNone
      Align = alClient
      Anchors = []
      TabOrder = 0
      ParentColor = False
      Color = clBtnFace
      OnKeyDown = GridKeyDown
      OnAjaxEvent = GridAjaxEvent
      OnColumnSort = GridColumnSort
      OnColumnMove = GridColumnMove
      OnClearFilters = GridClearFilters
      OnCellContextClick = GridCellContextClick
      OnColumnResize = GridColumnResize
      OnColumnFilter = GridColumnFilter
      Columns = <
        item
          FieldName = 'ClientID'
          Filtering.Enabled = True
          Filtering.Editor = flClientID
          Title.Alignment = taCenter
          Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
          Width = 125
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'Status'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089#1099
          Width = 64
          Sortable = True
        end
        item
          FieldName = 'IsActive'
          Title.Alignment = taCenter
          Title.Caption = #1040#1082#1090#1080#1074#1085#1099#1081
          Width = 119
          Alignment = taCenter
          ReadOnly = True
          Hint = 
            #1040#1082#1090#1080#1074#1085#1099#1081' '#1087#1088#1086#1092#1080#1083#1100' ('#1054#1090#1082#1083#1102#1095#1072#1077#1090' '#1074#1086#1079#1084#1086#1078#1085#1086#1089#1090#1100' '#1074#1093#1086#1076#1072' '#1082#1083#1080#1077#1085#1090#1072' '#1074' '#1083#1080#1095#1085#1099#1081' '#1082 +
            #1072#1073#1080#1085#1077#1090')'
          Sortable = True
        end
        item
          FieldName = 'Brief'
          Filtering.Enabled = True
          Filtering.Editor = flClientBrief
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 603
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'Name'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 200
          Visible = False
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'ClientTypeName'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087' '#1082#1083#1080#1077#1085#1090#1072
          Width = 273
          Sortable = True
        end
        item
          FieldName = 'Rest'
          Title.Alignment = taCenter
          Title.Caption = #1041#1072#1083#1072#1085#1089
          Width = 120
          Sortable = True
        end>
    end
    object UniHiddenPanel: TUniHiddenPanel
      Left = 774
      Top = 142
      Width = 160
      Height = 256
      Hint = ''
      Visible = True
      ShowHint = True
      object flClientBrief: TUniEdit
        Left = 26
        Top = 76
        Width = 121
        Hint = ''
        ShowHint = True
        Text = ''
        TabOrder = 1
        EmptyText = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'...'
      end
      object flClientID: TUniNumberEdit
        Left = 27
        Top = 36
        Width = 121
        Hint = ''
        ShowHint = True
        TabOrder = 2
        DecimalSeparator = ','
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
    UpdateOptions.UpdateTableName = 'dbo.tClients'
    UpdateOptions.KeyFields = 'ClientID'
    UpdateOptions.AutoIncFields = 'ClientID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'select * '
      '  from vClients c'
      ' where 1=1'
      ' '
      '   and c.ClientID  = isnull(nullif(:ClientID, -1), c.ClientID)'
      '   and c.Brief   like isnull(:Brief, c.Brief)'
      ''
      ' Order by c.ClientID    ')
    Left = 611
    Top = 179
    ParamData = <
      item
        Name = 'CLIENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'BRIEF'
        DataType = ftWideString
        ParamType = ptInput
        Value = Null
      end>
    object QueryClientID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QueryBrief: TWideStringField
      FieldName = 'Brief'
      ReadOnly = True
      Required = True
      Size = 256
    end
    object QueryName: TWideStringField
      FieldName = 'Name'
      ReadOnly = True
      Size = 512
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
    object QueryIsActive: TBooleanField
      FieldName = 'IsActive'
      Origin = 'IsActive'
      ReadOnly = True
    end
    object QueryClientTypeName: TWideStringField
      FieldName = 'ClientTypeName'
      Size = 200
    end
    object QueryRest: TCurrencyField
      FieldName = 'Rest'
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = QueryStatusGetText
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 683
    Top = 181
  end
  object ActionList: TUniActionList
    Left = 220
    Top = 194
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 1
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 3
      OnExecute = actEditExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 0
      OnExecute = actDeleteExecute
    end
    object actView: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      ImageIndex = 2
      Visible = False
      OnExecute = actViewExecute
    end
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 6
      OnExecute = actRefreshAllExecute
    end
    object actLookup: TAction
      Tag = -1
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Hint = #1042#1099#1073#1088#1072#1090#1100
      Visible = False
      OnExecute = actLookupExecute
    end
    object actBalance: TAction
      Caption = #1041#1072#1083#1072#1085#1089
      Hint = #1041#1072#1083#1072#1085#1089
      ImageIndex = 4
      OnExecute = actBalanceExecute
    end
    object actBalanceAdd: TAction
      Caption = #1055#1086#1087#1086#1083#1085#1080#1090#1100' '#1073#1072#1083#1072#1085#1089
      Hint = #1055#1086#1087#1086#1083#1085#1080#1090#1100' '#1073#1072#1083#1072#1085#1089
      ImageIndex = 5
      OnExecute = actBalanceAddExecute
    end
    object actClientType: TAction
      Caption = #1058#1080#1087#1099' '#1082#1083#1080#1077#1085#1090#1086#1074
      Hint = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' "'#1058#1080#1087#1099' '#1082#1083#1080#1077#1085#1090#1086#1074'"'
      ImageIndex = 7
      OnExecute = actClientTypeExecute
    end
    object actBalanceTotal: TAction
      Caption = #1041#1072#1083#1072#1085#1089' '#1080' '#1054#1090#1075#1088#1091#1079#1082#1080
      ImageIndex = 8
      OnExecute = actBalanceTotalExecute
    end
    object actClientAuthorizationClear: TAction
      Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1089#1095#1077#1090#1095#1080#1082' '#1085#1077#1074#1077#1088#1085#1099#1093' '#1087#1086#1087#1099#1090#1086#1082' '#1074#1074#1086#1076#1072' '#1087#1072#1088#1086#1083#1103' '
      OnExecute = actClientAuthorizationClearExecute
    end
    object actPasswordReset: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1076#1083#1103' '#1074#1093#1086#1076#1072' '#1074' '#1083#1080#1095#1085#1099#1081' '#1082#1072#1073#1080#1085#1077#1090
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1076#1083#1103' '#1074#1093#1086#1076#1072' '#1074' '#1083#1080#1095#1085#1099#1081' '#1082#1072#1073#1080#1085#1077#1090
      OnExecute = actPasswordResetExecute
    end
    object actApi: TAction
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' API'
      OnExecute = actApiExecute
    end
    object actRestCalc: TAction
      Caption = #1055#1077#1088#1077#1089#1095#1077#1090' '#1073#1072#1083#1072#1085#1089#1072
      Hint = #1055#1077#1088#1077#1089#1095#1077#1090' '#1073#1072#1083#1072#1085#1089#1072' '#1087#1086' '#1082#1083#1080#1077#1085#1090#1072#1084
      OnExecute = actRestCalcExecute
    end
    object actLogger: TAction
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1103
      OnExecute = actLoggerExecute
    end
  end
  object PopupMenu: TUniPopupMenu
    Images = ImageList16
    Left = 218
    Top = 271
    object N7: TUniMenuItem
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
    object N8: TUniMenuItem
      Action = actBalance
    end
    object N11: TUniMenuItem
      Action = actBalanceTotal
    end
    object N9: TUniMenuItem
      Action = actBalanceAdd
    end
    object N16: TUniMenuItem
      Action = actRestCalc
    end
    object N15: TUniMenuItem
      Caption = '-'
    end
    object Api1: TUniMenuItem
      Action = actApi
    end
    object N10: TUniMenuItem
      Caption = '-'
    end
    object N13: TUniMenuItem
      Action = actClientAuthorizationClear
    end
    object N14: TUniMenuItem
      Action = actPasswordReset
    end
    object N17: TUniMenuItem
      Action = actLogger
    end
    object N12: TUniMenuItem
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
      'declare @R                 numeric(18, 0)'
      '       ,@ClientID          numeric(18, 0)'
      '       ,@OrderFileFormatID numeric(18, 0)'
      ''
      'exec @R = ClientInsert'
      '            @ClientID     = @ClientID out '
      '           ,@Brief        = :NEW_Brief'
      '           ,@Name         = :NEW_Name'
      
        '           ,@emexUsername = :NEW_emexUsername --'#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '#1076#1083#1103 +
        ' '#1080#1085#1090#1077#1075#1088#1072#1094#1080#1080
      
        '           ,@emexPassword = :NEW_emexPassword --'#1055#1072#1088#1086#1083#1100' '#1076#1083#1103' '#1080#1085#1090#1077#1075 +
        #1088#1072#1094#1080#1080
      '           ,@IsActive     = :NEW_IsActive'
      '/*'
      'if @R = 0'
      'begin'
      '   exec @R = OrderFileFormatInsert'
      '                @OrderFileFormatID = @OrderFileFormatID out'
      '               ,@ClientID          = @ClientID         '
      '               ,@Folder            = :NEW_Folder           '
      '               ,@Firstline         = :NEW_Firstline        '
      '               ,@Manufacturer      = :NEW_Manufacturer     '
      '               ,@DetailNumber      = :NEW_DetailNumber       '
      '               ,@Quantity          = :NEW_Quantity         '
      '               ,@DetailID          = :NEW_DetailID         '
      '               ,@PartName          = :NEW_PartName         '
      '               ,@Price             = :NEW_Price            '
      '               ,@Amount            = :NEW_Amount           '
      '               ,@OrderNum          = :NEW_OrderNum         '
      '               ,@OrderDate         = :NEW_OrderDate        '
      '               ,@PriceNum          = :NEW_PriceNum         '
      '               ,@Commission        = :NEW_Commission  '
      #9'       ,@CustomerSubID     = :NEW_CustomerSubID '
      #9'       ,@Reference         = :NEW_Reference '
      '               ,@IsActive          = :NEW_IsLoadOrdersActive   '
      ''
      'end*/'
      ''
      'if @R > 0'
      'begin'
      '  declare @M nvarchar(1024) = dbo.GetRetMsg(@R)'
      ''
      '  RAISERROR (@M, 16, 1); '
      'end'
      ''
      'SELECT @ClientID as CLIENTID '
      ''
      '')
    ModifySQL.Strings = (
      'declare @R         numeric(18, 0)'
      '       ,@ClientID  numeric(18, 0)'
      ''
      'exec @R=ClientUpdate'
      '  @ClientID     = :OLD_ClientID'
      ' ,@Brief        = :NEW_Brief'
      ' ,@Name'#9'        = :NEW_Name'
      
        ' ,@emexUsername = :NEW_emexUsername -- '#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '#1076#1083#1103' '#1080#1085#1090#1077#1075#1088#1072#1094 +
        #1080#1080
      ' ,@emexPassword = :NEW_emexPassword -- '#1055#1072#1088#1086#1083#1100' '#1076#1083#1103' '#1080#1085#1090#1077#1075#1088#1072#1094#1080#1080
      ' ,@IsActive     = :NEW_IsActive '
      '/*'
      'if @R = 0'
      'begin'
      '   exec @R = OrderFileFormatUpdate'
      '                --@OrderFileFormatID = @OrderFileFormatID'
      '                @ClientID          = :OLD_ClientID'
      '               ,@Folder            = :NEW_Folder           '
      '               ,@Firstline         = :NEW_Firstline        '
      '               ,@Manufacturer      = :NEW_Manufacturer     '
      '               ,@DetailNumber      = :NEW_DetailNumber      '
      '               ,@Quantity          = :NEW_Quantity         '
      '               ,@DetailID          = :NEW_DetailID         '
      '               ,@DetailName        = :NEW_DetailName         '
      '               ,@Price             = :NEW_Price            '
      '               ,@Amount            = :NEW_Amount           '
      '               ,@OrderNum          = :NEW_OrderNum         '
      '               ,@OrderDate         = :NEW_OrderDate        '
      '               ,@PriceNum          = :NEW_PriceNum         '
      '               ,@Commission        = :NEW_Commission  '
      #9'       ,@CustomerSubID     = :NEW_CustomerSubID '
      #9'       ,@Reference         = :NEW_Reference '
      
        '               ,@IsActive          = :NEW_IsLoadOrdersActive    ' +
        '        '
      ''
      'end'
      '*/'
      ''
      'if @R > 0'
      'begin'
      ' declare @M nvarchar(1024)'
      ' set @M = dbo.GetRetMsg(@R)'
      ''
      ' RAISERROR (@M, 16, 1); '
      'end'
      ''
      '')
    DeleteSQL.Strings = (
      'select 1')
    FetchRowSQL.Strings = (
      'SELECT *'
      '  FROM dbo.vClients'
      ' WHERE ClientID = :ClientID')
    Left = 611
    Top = 271
  end
  object ImageList: TUniNativeImageList
    Width = 32
    Height = 32
    Left = 360
    Top = 379
    Images = {
      0A000000FFFFFF1F04FE07000089504E470D0A1A0A0000000D49484452000000
      20000000200806000000737A7AF4000007C54944415478DAAD970B5414D719C7
      FF33B3CB22F80A264589C69326BE92134C24C71CDA8624A5C658AB47F3A8D614
      B5265142D51E10ADF88A474468B63531C7281E6B4CA3A1B5CA43ACF8241A430C
      4222B1480E86150D852E6A0496DD9D7DCCABF7CECCEE0E03627B4E2FCC99BBF7
      DEB9DFEF7E8FFFEC32E8D99839699995D366A73D070550183240EF744651C090
      3F45FBA4DD1575585DA776482BD8F046AEA3F1EB4DA42B437B54413F8D31F599
      0F8B2F4A0B5E7C02776BC1A0084192210A120282089F4F4487CB07DE2F60C1AB
      B3365FBDA2424877833003B07B8B2F8A0B09802429915945EB2B0A133EBD24CA
      90641902B907088C970FA2E2EC15FCF6D7C938FDB903E98B5ECE6B6EBA4421C4
      FE20CC00DCDE435F090B5F9A440064DDA8CE105AA544C2204B1244021A088870
      797C283DD980AC4529F0FA4554D536E3CDD75ED972DDF1CF1084DC178419C0B2
      E7E097C1452F27A91B2BBA65D524A3F5436374960E8904D44F3CD049DC7FA0BC
      0E3919A9F00BB27A804FCF372163C99CFC96ABF51442E80BA237C0DF6B838B5E
      7952752D6D7B4BEA7A229BCF403E7B783F66A68EC787C535C8CD9CA6C24BB2A2
      DE2BAB1AB16CF1DCFC7F5DBFDC278419C0BAFB406DE0F55FEA00F4F44CC84EA4
      24941EF6892172E2F69B6E141655C19E33530D9BAC5E8AEA89639F3460D99279
      F96D2D0D1B0DE1E805C052805D7FABF52F9EF3248282B666CFA18B86A3876894
      F0086D1EAF1F73672462DFC16ADCB8E5510D874A9476A6A48C43739B0B2B5E4B
      89250301BD3AFA04882A2CBAE05BF2ABC90440520DB00CD3EBC4DA8096148AAC
      E58AC727C0E309A8E108040552258A9A1F822881234B6B2EB5217BF13383C952
      BE5F809D1F57FBD2E73D456A5B03D873E02B44CECB984A5233CEE827D586B471
      EA9579331F8748005832547CAC1EABD29F1BA203887702B0BDBFBF9ACF78F529
      F8829A86B02C1BA9C59017944838422A191A51F408C9B2561D343F2C1CF0C1C1
      1AAC4E4F1D4AA6BDFD01446FFFE8BC37232D19FE80A49E6FF7812FC389C784E4
      D7F858C823A60A71135D58BAF047AAA059490C767E741E6B96A6DE43A3752700
      8E02BCF7972ACFD2F93F868F88099DE51883FE9B45C9548E4AD805DA8DE60055
      4B1BC762DB07E7B06EF99438CAD61FC08077F756B9972F200044DDE826BB8A6A
      F4C4D377370A522406FA6E4CB8DBEDE591495491369B95C5D6DD67B07EF9D461
      74AA3F80D83FFDF95357A62EA7D430C71ADD1D31AC8459F4E028BDFD42B5848E
      C64673D8F2FE69E4664DBB8F7C7421F27EE8016021578C7DD759D78A37524859
      E91EF8F8822EBB8CC11388BCA7F56D14C65811C40AEFC30A7210FA2405C8DB7E
      1279D9D37F40A6BAFA03887DBBF04C17A957B809003D2647E2D7D3DD7A153091
      CC8B9CDDA011E49F6A09EDC41080DCF74EA260D5DD010616EC3CDDB972C94FE1
      F60AEA610BF757470CEB9510AE0273EAABBAAD05A6DBCD238B1C4405B059540F
      E4AF9C1EAF030877021894B7FD54C76AF24673F3821A67EA01B331E389438214
      65614125432699CF926768FC79BFACE20E8EB1C271ED0612278C1C45167790CB
      0FFD7D600618BC79DBA9DB39CB52E1F206554B3BF6556B8BD4F087D5404F0145
      95EAC4F1F198F0D0BD103F3B0DEEE217E0273F83D8E4A711173758DD78809581
      E348056E961675E69CAD2AAC713AE99B91BE1314238095026C7AE7F8F76B973F
      AF02500F582D6C8FBA372A5FA81CA24999DD2A2F4534FF3D86243D8AE6E20A70
      89C91831F505F55DE1FAFC1CB8A67A0C7B7632BA6AEB3163EDE6821A67FB061A
      0A33C0908D5B8FDD5AFFBBA9E8F20455233B8882198D3326496048F1CE9E321E
      927D03C6FC663A64E73558E247A1B1EC1CD8C7933160602CA29A1B303C652284
      EB8D24CBEEC5B9C292AE9F971D4E208FFB42008C1E82A1EBFE58717363E60B04
      20A01AB4729C21F32359AE1844219AB8F8BB23E5F09FADC0C3532641EEEE42D4
      030FA1FED0190C1B198FFB9F4D42D071997803A83F5A8BB9874FAC680D04B693
      478366807BD6D88FDED894350D9DEE602F71E9E57EED23513A061602E7282981
      EF44291E994A2078176CA3C792C26010B8FE2D5927A3AEBC060B2ABF58DD2604
      A971DE9803AC0E10B732FF8873CBCAE9E8E8F693595D7E0CFA1E311C9165DAA2
      481E70A4BCBF29FA2B02C74AF0D8CF1E81E8EA0C9765DDA906A49FAFFB438B28
      D8F552948C55C0E83910979D77D899FFFB5FE07677A0C729C392630E815E2236
      2B075611D0545C0AB9EA241EF8610CA4CEAEF01EADED0AD20E1FB75FF57AEC7A
      29F60930342BB7EC4641CE0CF24542367C0336D6BC76FA882C50B56420090134
      1E2C81BFF228C6248D82B7A1C1F0BB82E4C983A371F5D24DCCFFC789F52D7E7E
      1BB4EF05B2118066DBA0A79F9F5F36E927B35318DD48E87B1DE555F470847F96
      516A1B87852F26A1ED6839A2AA8E63ECC411E01D4DEA865FD73483B14661E213
      235523B6E109F8B6F1365EFFE4B3B5AD41DF3BC62A08E54114D50DBA560762D0
      53AC600036F663F3121EBEF0D2ACA481425B8B5AFB97EB5BB1EA3BE7563AFFF6
      E8FB331F4B4CD0160F8943596553F7BA7F378DA6B9D0EBB7A10EC2FE17868D2D
      7A42544CDE9647C7668CBACF822BDF3891DDEA7CCB0979179D4C602D6FDA478E
      786BDCB8E16869E7B1E6CAB51D8D417E150DC39D36FC5F1B051E3486B3E5CE8A
      1996B6CFDD6E6F874C4BCDA3CF0F1ACE70CBD206C66797FA3AF63B443F55C12E
      630EFCBF20A2F53006F44B36CDD18BBC64E0835E05FF01DB96255D79FC0CFF00
      00000049454E44AE426082FFFFFF1F040D07000089504E470D0A1A0A0000000D
      4948445200000020000000200806000000737A7AF4000006D44944415478DA95
      97796C15451CC7BF0F0A7288E536F10FFF800A845411E4526290F80720201408
      CA0D4269B8292091A6B50814832D6011486939E52A57CBA9209548B95A04046A
      5B2B2069B82AF4EEBBDFEEACBF999DDDB7EFB5D0BAC9EC313B3BF399EFEF9859
      1B020F1B9546F26A0BAAAFEBDE78D66451A93079DFA023B8E346119131598322
      667CA4C92E35FD24AE5AC033154D13853F7869D8D8B1DD5A50B54F8234082218
      2024F9F47DEF824F3A357402E6117BB0086FB60E41D490B0FF05110CD0E4FB53
      F73D0B8775822A24B0F95590873E73F8FB9697F8434518D6A31DE256275DFA2D
      3D713055791B026105E0B66FB2E1E43DF7A2E19D6B0130ABC125806821CD1177
      A010B163BAE0D63F15884F48BA6C81505E06110CD074FDC9BBAEE8E16150585D
      B3F6D748D39B5DC7EC2FC0FAA9E128B77B71FB018748BC7CF1E0BA21F4CA03BF
      73D60BF0CABA137F3B178F780B3E02E02F379F2E920369D2D535530543A4D943
      BB61F99E3C24CFE801B78FA1C2E945DE834AAC5EB3EECAC5C34943A9955B2AC1
      EA03689678ACC8B17464170160CED694C11F6F863486124B77DEC196A877E1A0
      70501843658D0FF9C595287A5489C511DDDB5213A7744EF62280C61CE0BBCC22
      FB97A30840D507DE74AAD0C4D0980549F383CC1BDE1DA967EE238F0654540646
      002A4D80178D4A688B106C5BF87EA884505E06D07CEDD1C29A65A3BBC1ABEAA3
      691667AFAD84F152EFA6BCBC1435763B149F029FA240A1E2747BB1FD4C11F6AD
      9AD49E9A544B155E08D0E2DB2385D55F8D21004507483E5168BABE169C984494
      E8C928303235CC1F192E9E9D6E056B0FDF417254BF8EF4AAB23E80960987F3AB
      62C67687879CC926272766CBE4D5C643CF98BB4D0EEE57423CDB649624333A3D
      0A2EE69760FCC0CE6F508B0A1915DA8B005E5D7530BF32769C0EC08F0DC7F3CD
      B0334437EF35BF323006D5F4A5610129B0F25C140A4AAE8309676528CE2ABF70
      2FB3E4631996B5004238C0CAF4BC8AB8CFC24538050C6634B5AC0B660FF42082
      C6A62BC09393A2AA18BFAF378E47665352F35154B9119132181716FED5D46A86
      6080562B0EDC298FFFFC6D380D0532F32CB6F7DBDF905F959EAA59E188661129
      30617F1F64469E476E790AECEE0AACCFF819D9D145CDA067488BFBFA015E8BDD
      7BBB6CD5C477E0F43269A8C08C685D09ADA128604408D295E466A4C094F4FE38
      3AEB2CAE966D81DD558D8DC77FC1C5E8BBADA4025A3040130E10B3F776690201
      38BCBA994A972DA6CE785CABA2539531FD99DF53614C150387A5EDC2AAACD928
      784636E70E4B270E7528F224729EA790097C483AF293A8E7EF1941965CA8CA0E
      06085DFEE31FCFD74CA68CE631FD447722692FE6F7388B2FD8E0F3F93039BD2F
      8E499BAB9A178AE6A1ACE841CEB354BAFAA828E81E3A8CF60E2E52B806D1BB57
      2318A0F5B25D379FAD9DDA5300F0BE4BA2E79B3317B336941072AB521D864EDB
      F660CA817EC89CF5ABB0B9A2D2E0AA57CC5C95833355D1BFD754B8BC6EA49EB8
      560BA0CDD21D37FE4D9CDE0B7609602E3A86475842D0C88E5C6AA1C0FEBE381C
      498E56B28132A10F212121627095067678ECBA6F08D330A1DED6E3B901003C3C
      DA2CD97EBD24E98BF750E3D6011ECD8B0AB0B598B5548331268B86AEBBF62321
      6B2EFE7C9AAB3B24D333E4FC5183C4CC1D1E27524FE608136AE21DF781EAF3C1
      006DA3D3AE3D5D3FB30FAA5C8AB9DB34666EEE03CD98B099F940002AAA887F3E
      53AFC78B69070760EBF475B85D9A41367721ED442EAEC7167780BE3CF32F9560
      80760B52739F2447F61500FC4848BF2106B159650FDC9DC8674B66E499F0D370
      4CDCDB1B9BA6AD417ED92969F35CDC8C7BC8574507E4B26C00D8A40FB49F9F92
      F37863543F01A005CC3C201BE8194F6099357A36D4F44871B95C98B0BB171227
      C5A0A0ECAC6EF363B9B815FFE8356A65373EB3027005DACFD97CF5D1E639FD51
      C915A026AB0FFC6E911D724FA0A7664315199F60E61F02C392313DF1CDE948DC
      797A555FC8B8CDB36B2E3CCDAA32764875027498BDE9F2C32D733FA06D95AFF6
      0EC8F0016B06B46448A382E329DC1F683F505EE5426EC113CC8DE8D593DE1653
      A9816553120CF07AD40F978A53E60D40B9C36749BF5AA0330601586F342B249D
      AA1D5E7CBDF30A8EC6D3C6117848C565FDAC164064F2A5E2D405035026011034
      63A6052A624C5F57C256AB7D35F513B7E33232E28774E551FD3200EE841D676E
      C87E98B6E84314973A03938EDC0FAA5AE0D7CC42240353EC09AC0B59DCF62BC8
      5831248C6E1FE3051B12F15B4625B4CF8839C7C2078E1BC08CF032B6E34CFF39
      F1879A252758B665D6F7E24A4BCABD9C8C9CBC7369A3A9A60CFE953000801FE2
      BF804A4B2ACDA522467D5DED1BFAF7CC077448E7E3DEAFE2251FF2D2580EDA08
      F51FB606B4317EDBEBFC75FF0F46E3DC408E595EEE0000000049454E44AE4260
      82FFFFFF1F049E06000089504E470D0A1A0A0000000D49484452000000200000
      00200806000000737A7AF4000006654944415478DAC596795055551CC77F1778
      B1652ED95E3653333553334D22936326A58C0B651A8AE112689842A438A0A9A8
      200322202E489A38E646EAE4C228A2628A89460E828A66CC682EE3E830E50288
      BCFDBE7B4FBF73DEB9F79DFB78CFA1FEE9CEBC77CF72EFFD7DCEF7B79C23C1FF
      7C49DEFDF884F41331B109438100109C95E89DCE10820F4BD826AC4F5F642DC2
      A6D8B3AC815761F68CBCEB572EE6625305F7EBA43B00B42D6DABB8A04C1DD7BF
      5BF44EA70B64450597AC80437681CDE682B60E1B58ED324C9DF2D9B21B571984
      F238086F8080AD15175CD3104051085F26D16709713F4EF8B714970A8AAA828C
      7707C258AC4E38527B15BEF96210D4FC761D5292E2F26F5EBB44215CFE20BC01
      02B7EE3B2F4F1B1F8100AAE169BD4D2401013556147021ACC3E1820EB30DF61F
      6B868CA428B0D85D50D77813BE9E3E61F9ADEBBF6B10AA37843740D0E6BDE79C
      497103D847E9E2CB2B9B3C10CCDF4493C340373EE62D6847F9771F6C82CCD468
      B0CB2A5BC4A933D7203539BEE0F68DCB1442F686E80AB0A7D199342192C94A84
      0744BBA20684FFD91C32B4B659605B4503E4A5C7B005282A61F713755760F6CC
      8905776EFDD105C21BC0B46977A3E3ABCF39005ABB33F27D83CFF48C900CE101
      7DAB7E8507AD1628DB5507C59963D89CCA7E842951FD4B33CC4E9E5CD072BB39
      477087012080026CFCA9D13E333E129CB22A785AD34CB3EA964383A16D1933E1
      21C6C08F7BEBE1EE7D3333ACA5286D0C8F7A136EB674C0DCE951E138E0E0D9D1
      05E089B25D676DC993DE430085BDBCA3EA52B76260D29877D00D2E309B1D60B6
      DA312B64CC12EA029A250A04E22B0D975A60DECC0F9FC237AC7E0136ECACB7A5
      4C1E8879ED06D0CC488474CD23E2D18296292A3535A8A2F6B43E28B2C2FA2E04
      08404B15D597617ECAD09E1CC0E50B2078FD8E7A6BEA948160733240B83D2C52
      37E489464FF069FD7EB5E76167E54577780AA4E362DEC642A5425020C096BD0D
      B03025BA170E5BFC0184AC2B3F63494D18047687C2D665B3BBB85D3DFC050E5E
      96F5522CC68BFB329902585133A10F36949F8145B3A27BE3B0D91740200528DD
      5E679E95385837BCF3A0160344773B112421BA14128F0F63784C1EFB2EAB96C1
      8101B076CB69589236BC0F0E77FA03082DD95AD7993675300B2895E7B74173E2
      A3A66A81C9151101428283D83D189558BDE92464A58D7C1ABB8FFC0184ADD97C
      FAD19C2F87801501E88A761C68E2362488437FB67CD4DF00642C4C9A2FDC7D3A
      F75A7D33BB878504C18AEF6B6069FAA8BE1C40F60510BEEA87531DE9BC96B318
      B0C9823D62DC1F3C91A9BB40D782CF858698D8587848202C5F5F03791931CF60
      B7832B404400AA5558F1C6DA8EB933A2C06C73C740F9FE26DD9A27F0240F8C18
      78A46BE94A888D60CF5380FC75C7207FDE27CFE2F0437F00E12BCA4E3EC46201
      9D36173368B53BC1EB9B9E830818B767D12D9AB8A12141AC1D860079A5C7A070
      FEE3019E2CDC50D3FE6DF230E8B4B8A5FF73C01BDC182FC644F32FCF3B09C020
      8527569922AF375D73036030E695FE0C450B463FC701645F003DF2D71D6F5B88
      DB69A755665960E531A0BB4114435FB16400D093822A106C62C0E1A8446EC951
      285E34E6791C6EF707F0D4B2B5C75B3367474387C5C93EB47DDF79A3BCCCFFE2
      910484FA00824AEE2B312E82DDC351819C926A58B578EC0BD86DF30560A200B9
      6B8E3E589C36C20D800316ABA080106C06D189674730946D1AD5A126364D1558
      BAFA30ACC98A7D11875BFD01F4CC595D7D3F6BCE48DC5ADD00DBF69C33482E6E
      3EB4A78A649218806E8C6971910C308C011C8192ECD8973880530490B80B7A2D
      5979E45E4EFA28047030DF9A8202F82289515B61C5BA7DF05449898FD35D9529
      81F5207B651594E68C7F19BB0FFC01F45E547CF86E6E460CB4773A99D1721E03
      FF5581C4710398159A054B5754C1777971AFE0F07D5F00D405BD17141DFA7BD9
      DC8FA1DD6C379C8089FEA8107E7A304A4600E101AD568406074276D121589F1F
      D70FBBF7FC01F499975FF957C182D1D0FAC8E123CAFDB840124E4A1A98D71E1D
      8A0A2C29AC84B282F8573980C31740AF8CBC03770B333FC5538C6A90DD93EF60
      8C76E15CA01FD9F8894D3CB4D05B560102144DF41B037433EA316444E281880F
      62A3F42398F615C5B3C37581E03211CD0D7A60807E46A057D3D983750DB5BB62
      C1CF66C4CE84542DFC057320098C3BA647FFC7F7BDC728054D070C2C761CA3F2
      7739966BC602F8AF3B86FFCD45B851EDC7A4F907F63EF44E97B043F300000000
      49454E44AE426082FFFFFF1F04A608000089504E470D0A1A0A0000000D494844
      5200000020000000200806000000737A7AF40000086D4944415478DA9597095C
      14D71DC77FB32C0B4410C1338D3590A3367E72D4235AA2F2D1984A4C6A12E381
      47BC3091D456F35143A251FC100E8180C1E0813612D1586D1454BC2D6AD02222
      78216A311E455A8F15960D2C7BCED5F766DFCCAC96A21D1DE67DDECE7BEFFBBF
      7EEF0D07FDE2D88D87FADABADAEA97C92DB1E7635FEA445CECD4F947478D993A
      9C0E97492F27B3996499BCC491B6CC66F6FE20B3F79406B932967D9472BDF642
      B20FC46381A856730545E7C4E9EFF77DE4008F47002F4A1078116E5E80D329A0
      A9D909878BC7F429EFA5DEB8AA40888F0BA1021836169D13661000519475BFC8
      DEB62C73CC7619A220419424F0E4E92630768707074AAFE28F1F44E1C8C9EBF8
      386E5CDACD6BD51442781C0815C06F63E1597EC6D87E0440628BEA81F5363886
      407C2C8A1008A8DB2DA0B9D5895D7FBB8C0571D1B0BB049455DDC41F668D5F5E
      77FDA20AD16E5EA800C6FC1D673C71E3FA2B13D3B70B7FBC0A5962512734B42D
      330459F23EDF19FA1CACC4FD3FEC398FC57346C0C54B8A01C7CBAF614E7C6C7A
      FD8D1A0AC1B707A1036CAFF2C48D1FA0B856B55CCB314E8B869E8CE48FD3CDC3
      D2644741512552E68F52E045024A9F47CB6A3177F6C4F47FD55D6A174205F0FF
      F6872AF78713180079AD3E264AF5BDD703B29EF1B2ECAD84EE07CBD168B163DD
      D632642D7E47F959526E59F1C4C1639731377E72FAEDFACB493E89A905550DAC
      8102ACFF6B956B76EC007878D5035AD1E92E507A39CD2D3CA9849F490E7CBFA3
      02E686566561B54469E377D1BD71F3763316CE8A0EA65E18D0ADF39282118397
      CD387A32F9CC7D4B0AF58A0A605AB7F5B4337ED24002202A8B6E3D7459B3DCFB
      6400CC42DAF8E0ED57481804B4B6BAD1EA7091AAE04995D010D02A11C9C4322A
      ABFF8D84F8E1E1FD3A872D289A3D7169AF79F35197918AF15BF6A69EB3589335
      80BCBF54383F9E3C88D4B6A8C558B153961FAC25B59F7983BA9A2E2811DF537D
      1079D10B403482BE53B8BF1AF9C971D9FBA78CFCF4B984CFE0385804BFC86750
      93FB1D66FF5891A60204ACD952E1983365109C1E6FA8EA86F567516269C73CA1
      E500895444D905E4EF3CCB2AC45B29AA864C18F922799147724E0922227A60E6
      A42804EFCC81FD620D8C7D07C35C5F878A4D3BA00204AEDE5C6E9F33350A2EB7
      A8C55FB1534F7FBD24C1A4DAB75F7510112937CF138DF0C05EBD099BAFF4417C
      DC085CAABD83CE670E20D2DD808A750568717A9062367FA5881005C8DD54D6FA
      A76983E124624217DC587C5ECB76FA9498372496EA32AB0E89C5CB5B4E1CFABE
      F0247A4784C17A7623C2C50A741D998BFD554E58ACADF84578306ABFFC0C2135
      E5486F68C8BE290A492A40D0CA8D65B679D3072B49A5559C66A1ACC55ECF05FD
      05DAA2B920128574BB9D68ACC847179CC653319990EBF35055DF1366D3686CDE
      7602F7EEDC43EDE1CC15168F8D96A65B05782227FF44CB273387C24100E8E41B
      686C59F67F38F655DC18D88741907FCCFF0A829F1FE4802084CC9C8D80F7C6A3
      E9D40684B9FE8E88315F43B85508B1F118844E8390F6BD84926A232E9CC8CF11
      5C66BAB88B4AB50AD061C586E3CDF3999ECB3E8155B764D9C7704D11693448CC
      3D24E64E871D9653C47265F12CB8AFAC8468B902E9C921F8C7CE22D86D12620B
      AC2B1B5A14CB9DEA3EA1C830F540D6FAD2E6851F45A3D5E90DC19FB79F7E4003
      1ED603FADF6834A0EFAF7B20B26747349EC8431777399E199B09E799AF8096AB
      10BABF86DA3D7B61B3C958B8EBFEAA8B669E2E6E67D2AC29210508CEC83B624D
      887F1D363BAF1F48385DD57C3DA2941DF98127C263B3DB602ECD43D796523C3F
      65051C9519E0CD97C1450E43CDF662D83D062CD967D970DECC2792A1CD34EEF0
      49271520246D7549D322B2A3D91CBCB2E8F5FEBF62564B6C5362324CAA960B30
      C1BFFF40042767E1D6E14DE8E0BC865763A7C2767A0504F325F8F58A42756109
      5A5C326A108DC4ADBB5E2003EF30EB1FD89454808EA9DF945816CF1D8166BB47
      8F3DF41CF06A9FB7CEA9EA395D4EDCBD5285FB452BF06E5E099AB6BC01D15A0B
      436414AAB61D21C9CCC1D86F0A0ED906222F635A24197A8FDC1E06F0C06EE84F
      0192730E352E99375201A0EBADDE52A6582DFAB89CE218380E2141468C8A7E16
      75C56BD1BD4B38225E7B037CE19BF0EFF35B546E2B255E245EEA3B19FDE3BE40
      EE77A7B02A35F6976470030390DB02084DFAFA6043E227316477F3B49DF1AC8F
      D6BB8B587FFBF65D1C5C958E84E549B0DF2CC3AD4B97D078783D6C1E0ED22B93
      F0D2B445E8D1351CE96B8FE19BA4B13DC9D0C6F6003A2DCD3E703F69FE9B04C0
      ADBCB1B2E0B8F7E423EBAA6720591960E21033E4599C2CAFC48DABFF44D2D4DE
      F8E954197EAA380BA1D58AC0DE517869FA22740C0D45586808BECCDE8FDC9471
      8F0408FB226BBF3979C128586D1E6DD3F13D398095204F6ADEFAB31589C96BF0
      54AF9771BD6A37022CD7F0D6A017E11FD605BF993C17A1A19D600A0C44709009
      4959FBB02A655CBB21305180CF33F7DD4B5DF816ACAD2EA5FEB2F38F91648392
      33EA19C0409E267F0E9347BF8C77DF9F85900E060C1F36143131AFA35BD76E30
      10550C0EEE007F5320FC48FB8940239665EEC39AB471BDC844F7DB03084F48DF
      7B7779C2DB686A7191F5D9A788AE392C27BC874EB7C70587DD014110E0EF6F82
      292000269351A90EA3D14412956CB0640E0A9098598CB569139E26C3CDED027C
      9A567C37FDF3DFC3D2E2D65DAFE98F4E413D2129071091B425B2981F38834159
      94F492090D746DE50A0A3062694631D6A5C73ECD3CE0FE5F009D16A4EC36672C
      1E4DAC921E3811798F61FA8789224E927A3ED421D5A3A2269C6CFF484C270099
      13DB4D424509878E9CB6BBDF9031D1DA114C9D49D41786A688BA8B64763A917D
      E4C53789CF9FDE535659BA750CBC322CB40560605E08227700BCBB635B5FCA78
      A8EF51BF2BC70478B75D3B73BFD4D600EDFB90DD8F9AF8FFB9D44F76F5FEAF0F
      93FF00457211E90358A7970000000049454E44AE426082FFFFFF1F0404020000
      89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
      F4000001CB4944415478DA63641860C038EA8051078C3A60F038A0406227930E
      971B5D6CBDF9E3E0BFEE670E280E609AA3F49F9E3EFF97728F91B0037EFFFBF9
      2FF301072516314D56F8C0C0C9C44F9603FE5DFEB68D61E20B6F8ABC9A25BE96
      C9883B8874077CFFF7E95FFB336B8667BFAE60182AC6A2C2102CD4CEA4C1E5C2
      C0C4C0F8EFFAF77D0CEBDE5531BCF87D0343AD04AB3A53A5F409066E2601E21C
      000AF61B3FF632AE7E57FE1FBBE5AA4C9552C71978598451C4BFFEFBF0AFE3A9
      35C3F3DFD730F448B26A30840875316972B932B03172E075004C0227C8145BCD
      64CC13824DEADFA5EF5B18263DF7C5A71DDD1E921DC03451E13D7A70C2C1AFFF
      3FFE65DDE7A4AD0370A46A302022D750EC0060AA5E074CD58158A3E0F2B7EDC0
      5CE345910380A9FF233055EF85A6EA9B182648B06A0053F5718C68F8FEEFF3BF
      4E60227CF2FB32861E311665C620E176464D4E17A03E41FC0E800148AAB604A6
      6A6C594B9321540498AA395C1818FF330273CD3EC6B56FCBFFE3B01C986B4EA2
      E71AE20AA28B5F37334C7EE9C7400160CC105FC568C21D8A613651453111A99A
      1000E69A77B06027DD013404980E28953CC8A0CE694717DBEFFD38F9AFED9905
      8A03060A8C3A60D401A30E18700700006FB2E7219CD630500000000049454E44
      AE426082FFFFFF1F047704000089504E470D0A1A0A0000000D49484452000000
      20000000200806000000737A7AF40000043E4944415478DAED976B6C54451480
      CFCC76777BBDDDDAC776E9D296D2F2905411752BA6D09644A30822828BC1600C
      48780515C2A3885A041BCAA304AA3F1A45051562C04ADBF08342508C064A8442
      09CF8040BB40BB7D6EB7EDBEBADB76C6D96BB649ED9DBBBB0563483CC9FD3377
      CE9CEF9C3967CE0C82FF58D043038092D4E391496726A3B5D938513D0E44559C
      F4C3D5D74E9A7BFEC4B7BB4F91F3AE32B8E7BBF86001C66A73F1ACF8CD303632
      27A4156F779FA615F60DF4BAE7D7FB03508380DED417A3DCE8256C56D85B454F
      3AF7D2032D2BC007AEF0011E41B17845E211182D64856B7880DCF19E23C58DD3
      C049DA4207609EE335C613C18C9345B5922EFE269D0681384F8AAC53C04B6523
      310800BDADFF124D895E1ACCB9900198D0D38EEFE9DED605C101FC099797F41B
      77CF5DA48B1CB11740B5F347B0F7D54B6399E21CC88E5E849F10A62A42ECB2BE
      44AF75FFAC0880F38CBFC36342AEEC0A5EE2A485D62C6AF55D91FB8DDF882B82
      A931795C823ADF595258FF1C1740AAF34F532E711738DEB99394DAD682519D01
      73E38BE1B326C963FC7AEC165261CF0715A8F18ED4BBA05319B851D8DC30915A
      BCD5B2007866DC269819B391ABBCBB652EAD7696A285867D28533493E575A2A4
      C77280943499E182BB1C960F2BC7CF88B3B94E1CEDDC4ECA6CEBE5B760B5F117
      9C21BCC005F8B6F51D5AE5F80E4CA2192F4EF8812CB3440600586E7480877D22
      8E6735A4E302DC64A7E5766B8E2C002E4AAD873855124F975C711F67617FD9CF
      82866B1E67B970B51F205471101B5965D1CB0394A4B9418B04257D7AB26B0F2D
      B5AD060FEDEA1FD4E10434417C154D7FF4633068D215010850B2A4160F194012
      17B1D31A7705FDA96D0DB859D803A2C551786562A562CF500408B20583D65A7F
      370DDA7A2DF05EE26138645B074D3D376084E669FC4972CD90B600D61A4FE071
      C2F3E1024839D0D2738B7C746F0C6050E1AFD27BB94AAC5392ADD6C9F2119815
      5B00336237F07403358CF393CEC248EDB303003CC441DEB744830A69F0EE342F
      17E058C70E72A87D9D7C0452344FE18DC917B81E97B7E74365472124A8D3F132
      4329F9A2798E04B033B5911EB4ADF49F1190AC7E126F4AE15E48E896862C5AEB
      FD431EC01F850F8757C1A8C849B2DA1ED24959F802E537483044C0BBC60A3C41
      98216BDCE2AD615134FD737C0000623980582E7043C8205833DACA9AD141B0F5
      DD91C634ECE2324A988C5E8B29506AE1E4F3C657E0B2A75211401A986FD88372
      A2164210E9CF816D23EA401F3152692E3DE33C40BF6E9927F76F70DBD5B003F5
      03D69253B5990F0280D6FB2ED16D0DD9D04D1DA101F8250AEBF12AE331066182
      FB10C938BB07401769E6CDE15F36B548446FE94BD024DDFC2119F7877D7FEB52
      9EE7C1010213328417D16C762D4FD34C0CC9B03FDB0FB392BDEC391ACAFCD01F
      26ECF041A628338CD166C3B008F63089F8FB61E2EE6D87E6DE1BACD556D11A57
      19ABF333E144EAE1799AFD0FF06FC95F5904D130A5C8F4460000000049454E44
      AE426082FFFFFF1F043409000089504E470D0A1A0A0000000D49484452000000
      20000000200806000000737A7AF4000008FB4944415478DAAD570B5414D719FE
      676677675990D78A8014088804798A485051C157D50DAB41087ADA13EB23B64A
      4DA3E461DA637B4ECCF1013127E7C4F6A45ADB6A344A4DB48A22965734080610
      1415140464792FFB02F6353B3BB3D33BEB2E67CF464EAC75E09E99BBF7BFF7FB
      EEFF7FF7FF6730783917E6D6E75E74E28B5EF8C1E2A56CDBED91CBA527BB0AB4
      2A73B783C44F12791904F835F003679630F2053BA1BCE16BEACA99A6A2EF2FF7
      16B22C47FD14911721803DA38F7F723AC3FA4EEE67403346B8F3A81EAE5DBFD0
      5D72B2FDDDAEFBBA6B68DC361991E72580B9DCB167FC867F7C7231B523671F68
      CD77C04314022CE505D79B2E4169694D49C5D9CE82712DAD781611EC79417DA4
      64785C6AC01BD323BC5F930689A34562C24B1A2499091C079A61E363DF40C9CC
      FCDCBD306268B44F2270317893913030AC83CA5B17A8ABE75A0A1BCAFB0FB32C
      985D884C4AC0B9533C7E5EC086D425D3B7C6CD09CD0C0F8C81E953A340EA130C
      22A1187CBDA6DA8D47F56AA0AC6698E245C090BE6E62111EC14320052F511434
      B73640597579674571C7EEDE47E3FF41432C6F824D024E04857BCD59BB29FA2F
      C9A9317393A2164164481C586D0630D12A30336AB0B246D40CC0D86810E01E20
      C42540DBFBD48483591B03067A0C8CD428787B06C3147C0634DE69868AB2E67F
      979DE8CCE34DDC09E07C4BCE08DE96B72DFEC86B894B89B0E050D0983A6078BC
      0D2D6E012121468022C071010225ED609C03D1CA5A908D15AC8C052C0C051412
      A4938C88F040BA104353A312EA2ABB4A6E978DE4B813E0C189B49F87EC5ABF2D
      A56859DA1A60700DF48DDE0603A541A1C610B010040409042640C604F2156E07
      E738CEE1720EC64C232E7D5E0B2210621EF0B0550D75D58A9E7BD735059A7ECB
      5534C4F05A70151A119DEC9FBDF983B473599979306A69837EDD03B42B0A0193
      803407232A23287AB4A05619403F4E81856291277090488430232A10629302EC
      0478641C91238512E8EF3541ED773D96FB37359FF73F321D612C369D039C7525
      80E304E6B9B3686EFB9BB20DC1400E834273C71E4352E805EA211A1AEA7B60A8
      4F3FD4DB66FC4A374CD7D3664E35AEB53CE4E7FA4AC9F8B7F62455AF952F864E
      65BD3D4C660386809F40538DF2DA9366C34716A3ED494C42CABC90C4955BAB8B
      0BB7712C129183807DF7B169011BDFFDA3ECEF2949B1D0A9AA01336D00522081
      D6160D34D4F58EB454E9768EF450A54EE62EE799E043BCF370AA7E7DF64A783C
      DC04771A07E166B9A2A7BBC9F8D198D27ACD738A975FECA29CFC95D99B7FE7E3
      3D853C5AF8E1DB9DCD55A778D9608ED80BD7EF8ABDB675F3864C56D8070363ED
      48606250F6D370F57C7BFB0F25AA6CCAC074BB81BB6A87CC2F9C6B8C8F8D86E2
      E24A4B7BA3EE0B753776986568734442BA3C23F79D432B325342936382413134
      067F3EFAF58DD22F3F5C8DE659B089058A52FB7EB16EADB477B41E894E079EA4
      1F549575C3A5A35D72CD0055C9B37503E65CF423DA7E20C55C76A1B57CA895DE
      439B6DEDFCB85F5044D25B7BFFF9C3A63589800985303866018AB6C2F9F3359A
      331FE7BD826CCC4E02E2F78ECC33E6C8B3A075A012C5DE0A53487FB8F44D3B9C
      FBB4633A1AD738768F3B5CCE39FAAC8304E1689833C1F0B6029138E0EDC2D2FE
      5FE5A44297DA84046D431B23E0E2C54638F3A72C6F6463C21C13C5BFF9244591
      9BB354DAA9AEB39F6F8B09875BD58370FA505B1A1ABFC72FE8ED1F1C357F5D7E
      6178EC8255C70A96497817BA79C235998982221296E7BDF74549EEEBC9F078C4
      F8D490B1C1A56FAB34973FDF14E124600F41F6F657CBD6AC5B904178ABE1D103
      25DCBEA91C7CDC38FE8727ADBA8B1841904999EB772D59B7A5409E114B9E2EBD
      0FFFD8B392DF81D9C50B13E91B3581909404C9761CBEF2CB3757C57A4FF5811E
      8D191D3500DDC8285C3C79B6E6D6F9FD326708EC6C510ED8B82437F298615CCF
      345D57FEF57193B988652CE690E8B92BD2B3771E942D9F17BE684EB85D08FBBF
      FC0E4EED9549F91D3808602EE11106CE485A962ACF2FCA5AB130323E2E04BA54
      26D0535694C40868BCD90A578FEFCB1FEAA83DE114A13D0C048179CD5E263DDE
      5E3F76D83066ED92F80684A6AEDEBE7FB92C6B55564634483C49501A69946601
      FEF6550D541E7F5FA61EE868E64F857F4854A2884433C2E2E787252EC97B2532
      3274F9BC19306D9A2F74694CA035D0769051CD38545CAA56D69E2E48E26CAC96
      0F88336E76E67C288442D26766DA9A1D0BE55B76BFB13C9E8C8E980A6A931535
      C62E2252804145F97D30A37D9B4C34B0A8BE0A091C55480F0899E60D91A1FE10
      36DD1794085481DC6EB43CD5A40D31AF2A6D80868B9F6ED2F6DEFDC6A11F76C2
      037CE50C8C98BD1A611F5ABB7A6144FADC7030593918D6D3E86E7B2A20940144
      88C0544F21F8A3F4CBFFC822526818BD09D9406F614067B0A277020B9810B00D
      D50402C7C0ACA7E0665513DCAB3CB96FE861C5670EED30CE72CCC74E343FFB83
      738B57C9E56B97CE028997070C23778F9B1960F96A871662D0036BE3C08AD0AC
      088C66780098A886F667C79DB7C7F93FB4BAE2C920DCBDD5C6B6DF38F17B5577
      ED3157705702E46CD9EE6F17AE90C916A5C78081C391EB18E09C00DCD382FB74
      71E4328CB3DF7942761B471F47CEE4D033FA87C15E153CBADF0D8AB696D69E86
      D3BBA9B1817A6449B982BB1E1D011F02BF9F2564C52CDE7830253D2D2C3A2E0C
      C91BB3BB9873EC92BFF31A18D519D13913805842DAC919F566A0CC16D0690DA0
      1AD4C060FF08A8140F1AB5DDB5A7747DCD671CC0B44B92FAD13BA1938408C309
      9F90F855EFC72CC8F96DF2820451504800121F3BE15A91008792E21AA0F4EA61
      861506F12B5146CD104B19B4B441A530E8FA5AC607EF96584DBA0E07A813D8E6
      96C27F44C0595878226291C43F266C4EEE81B8F92B9626A6CD02B1A7074A6236
      F46683C3E5E21B507762CB4C6467742B50CEF4CC385F3826037627E0DA9F1026
      1F16EFC0596B42E7E47D9C949E161A953003B91E872B67BF8786535B43D0F898
      5B91E2DCDAA4C09311785658489C104AFD2217EF8E4A916F4F5C98226AAA7D08
      CD677F1DC8E7160701F7EBA57C1BBA26299E884428F18F9346BFBE2FF0D5F4CC
      967F6DF743BF195C84F542D7F37C19B9262B3E2C4207209FC96878CE8FD0FF87
      80AB1DEEF23CE9F7DEFF72FD17344D3F749C5207900000000049454E44AE4260
      82FFFFFF1F041909000089504E470D0A1A0A0000000D49484452000000200000
      00200806000000737A7AF4000008E04944415478DAED576B7013D715FE56ABC7
      4AB26CE3B78D1FD8D8183098D81018A04E79BF6920E195328181A68542683B19
      9209E924344D6648679849DB69A7E99432A424944009E511081008259831E661
      F003E4A76C5992255996ADE7BEB4BBBDB245AAB68099E447FF7467CE68EFEE3D
      DFF9EEB9E77C7745E17F7C51FF27F0B087098C2A697AC988C565B9C619C519C6
      8A9C245D71B29ECEB27AB8B65B9DBE4B7FBFEDF94D773F77EFDBFA3C9440925E
      93FEC72D15D5E3CB2B4A7449E9481A35053A531A14258281AE7B70996BD0D250
      1FD87DECFEEC4E2F7FEB9BFA3C92C0BAA999AFBFB163FD9E82694BD175FD3472
      272F8210F221E86887C37C07FD4E0742C110CED775FEEDC04DEFEA6FEAF34802
      3B17E47DBA79EBB695221740C3C5B3C8282884318181C8B270BB0620C8346826
      018E30D554EDA4DE8AFAAC284F7B6DD68279D34436807B97CF40CFA8A1D7D383
      3EF64E1BFAFBBCE0391E4DB6F0D5FDF5DEAAC71278F9BB59A79F7F6EC5D2969A
      CBA858BE066DB53570757521AD680274C66468691108BA210B7E9F5A11F9049A
      CB602595A8669235ACC260CCFC35E8EDEAC49DF3C7E1F3B849041A6A2D837038
      84065BE0E4890EF6D9C712585996FCBB25D3C66FA76409DFDBB90B6A0D59092F
      23ECEA80BDFA14148143EEC4A741195361C81A0D8D2905811E0B7A5B6EC2DA78
      17BEFE10E6FCE41D3046033CF527497C3D6A2FDD466DF56DDC70F3EFD5BAC55D
      8F255098A25BB4BE6CC4D909532AB1ECA73F834EA7834227E0EE5FF792C911A4
      1495C0626E47E5EC65904083F5B9E1EFE9C4408F153EB70BEE6E1B98CC523CF7
      F33DF0377C0AA84D38F5D1495CAF69E48EB686ABFAB8C8CDC712A0284AB7BA32
      7FDF9AF915EB976CD942A9D43479CAE0D4DBDB30BE6A263C560B3A5BAD28AF2C
      87293B0F82C0C3E7EA419FCD0AAFC30996E51190F478F9830F11683E0F85D2E3
      F09F8E2AA71ADC7B2F35F7FE4292A4F0703AA0D26AB5196FAD7AFAD28697D68D
      4BCD4E87242AF8F8CD9D98BE70366ABEB80A2A351F7AD685E44403208B08F8C3
      18F085C93C1E0A8164A9446CFBD5BBE07BCD7039FAB0EFC3CF5BFE50ED98CFF3
      BC9DE04BC30A114DD309B3CAF276BDBAAAE28DCAA925D0A64FC4C15FEE46D198
      5C3436D9B060FB0ED8CDF75177E12282FDFDA43314B2520D92B51C3414858CD1
      E3B06AFB5608DE765C39FB15DE3FDDB4F7BAC5FB0E59BD7F58218A5D1AA3C930
      E1CD179EBA519E994A175456E1CB2387A11203508C6958B393D406A381AFB717
      7E7B0742BD4E787D22CE1C3903935646F9ECC51837A9141DB7AB51DBD523FDF6
      8C654628C4DD511445188E808A983A25D350BA71C7D403F3C64DA9745EEF0063
      48011708C2FCD5797C67C97C2CD8B0161A521BB2C881755949113A1014681CD9
      7F14C16018737FF40A3AEB6AE0ED752390A8E0BECA71EBC221C7A6902FD24AF0
      C5F86DA0E2026BB20B122BE7AF18F3CAF439252B476616D04E4B3B466B0B41B3
      0C02B206EE865BC836E930EFFB2BC9DE4B887041849CDDA4137CA098113871F0
      187C4C22166CDA88FED616983B9A51D7578F9259C5B03B7AE4BBD75C271AAF06
      DF1FE815A372CC1193A304548C81CE7961DBE40F66CE19BBB430A71419E999F0
      737674D93BD1646E46B7D581B4940C54144F077DB9058B562F844E4B830F7811
      262A272B6AF0920A473F3A8E31DB37A0D17E191D960E188C0CF20B93909B9709
      4693005BB713F75B3A70EF46DFC5EB9F05374578C51125A05DB2A1E0D0E62D4B
      9F2FCE9F8490E04188EB85445628C9024439824884B45AB80F29BA09F09E69C1
      A40C029A9F8E08CF2322468818A5A1A9AE11F5EE002A7EB0080198633E1EF011
      164A144B5240AB754449B5B076B970EA2FE6C3772FB19BA3040C9B769774AC5A
      B124B39FB392097AD2055A921C191C71E6449610F2234288A430C5106D6AE8AE
      B561D6DCA9831BA8D2E889CE7338F6F10964AE5D82A4D180876D43981FF28906
      97074D81A4C8C4452115A0C317C7EB1D170FB2E3A2048C9BDE1EED5CB17C6E82
      DDDB4C2629647B8903A24E32019011916418997424EB4721EC8FC072AE01791E
      0E5939198373DB495ADBD2F598B96E36F48914BCA10EF859770C83E0114C28A4
      6662F77A42FACA67F7D973FBB891831958B37364EBA8A2F41C45CD43C350D092
      FD9548608D8E46922107C9863CA8292D5C51A975F660E3944DB85F5D8B7BD76E
      922D10A0D51BC8F9AF426B9E1F4525A5C8193992A43E84FEB0051EBF037C5824
      EB56C0B302B108F8A0048F23143CF7E72102B44A458DC82AD42C4ECD524F36A6
      AA4A134C28C8CC28D2941415E7AAB51A262CF423287A302A67144C0613FAEC0E
      4CCE180F86A5E0EAB4A3979C0766D98D8CB27CF8823E7493624B1F918B94A42C
      720AB29CC5D26AEF717789219F6C0D0E281D036EE586C7269D2549E9A5E2DA51
      1D251367EAF219693F9CB92CFBB5491326A64C2E9B02BD410BAFDF89368B0596
      AE6ED87BEC240332D25293909F978DD14579D0E935B03BEDB873A7058D75B69E
      961BECEFBBCDE27E82C7138BC459540F948729E1605626CE4CDDBEF5D5677E3D
      F5A919E448151016BC640F7922181439B034E0C530493347462A522322197308
      926265852054E4A345AD3640E024DCBDDD8653FBBB7FEC6C8F1C20B851255462
      F6E8C3282A4A2FBE3EB679EDBAAA02015EB2473AD02468B49A79D25E61C10F5E
      6007EB4492E22C5AE971638A2455E454F8FC93FABBB5A7F967086E282A3E4F42
      40B775CFD8F0CA6767C1DEDF3C18487E00FEA0A5A4A1EE90A507CFA363E56B52
      F2200905062240FF38DDE0B9F289504A7003B1F40F4B8079E9DD92D0F2A53361
      ED6B8EAD6CA82D25E23E4882808BF2BF0245E7C83122430495C1F909BA44D45E
      34072E1FE247115C7FEC1C18968076E18BD9E7F3C71AABB47A92482D319D8A28
      193518245A39B496FA7AF5D1DE8EB65A4418DA0681132190761338D27221118E
      56F15CFD97E21A821B7E120254AC0BB48C41959B59A89B671AA12E4D48A68BF5
      26258F84A3D42ACAA44F44814C944D9186C42534205B45410E4435271C946D9C
      0FED419FD2E6B5C917045EB1113C3656F9F2937C0F50B14C3C68C907F70F9EC7
      FFC65F4A9C49318BC4DDFF5B073C8E40FC7B2A6E1EF51F3EF1F74A6C1C1F4479
      C8F8BF020C777DDB3FB0CAE35EFE131F68F89AE61197D40000000049454E44AE
      426082FFFFFF1F046709000089504E470D0A1A0A0000000D4948445200000020
      000000200806000000737A7AF40000092E4944415478DAC557096C54D7153DB3
      8FC7F6CCD878C33660033618E20D8CB1212C81B2142850A426219888B649CBA2
      A695AAAA4D5304A5ADA82069500B213451A4440D41A85252D2104C48CC621B1B
      03051B6F601BBC60335E66F5CC9F99BFF5BE3F7F2C8BA4346D14C5D2D39FF9F3
      FF3BE79E7BEE7DD71A7CC37F9AAF711FF9EB24A089356A1317CFB0552CC9B33D
      6B35EB13AFDDF57D74A367F45C6B7FE06280973DE3088C27F23952FF13017A58
      9B9316336F5541E2CED58F673F3529BFC06449C881D67511B6A438B886BC686B
      E8C6C5AB0F2E35DFE7CEB73AB8AAAE9170B5FABAA41290C713F952042C46AD6D
      D96313B62C2FB03FBF74E5BC227B5A3A8C71768438096E9701A1EED348498F83
      C96284C1A8A75DB5F08FF2B8DF35822BD53DFE9B5D9EBA8E91D085E6C1F0494F
      48EC1847E691043433D22D73D794246F5F5D9EBD796AD12C4B6C4212F4A618F8
      BD7E38FA86100CC808F326041F3422352B155A8D04A35907835E4BDB0B301A75
      744F86566B80411BC0B10335D877C161A6BD7995C4E709506E6DCB8B9336AF29
      4EFE51F992A2626B5A2A62AD09D0E87490E895704843913950B07C05243E0039
      EC811876430A8E420C3A218539BA1F24FC10642201214C4816F4D537E0D4673E
      ECAF1D8E2598102D713C014D6E666CF1C6F2F41F7FBB3CEB99A9734BE3CCB60C
      98EDE9CA031A9D11A2A841980BC233E24477EB2D94AD5E08DED30A29E48618F2
      12705005A6E04481C02568F536B85AAE2334EC84DB2BE3CC550907EA9DF1B425
      379E80B2EA0F2D16B356FC103A633242236D10FC0310F91045E78124CA08F99C
      E0DC6EB807472159A761E1F7D68177B510A80F221750C1C30AB8D69C04EF9D1B
      E0060720876422475EF10195D7451C6870595502C27802BABA438BF9FC27D740
      1092A18B29A11C1A00E779C053470442E0033C021E0E0FEEBB21C4CD42DE827C
      52A09DA40F10494E01D7C7A462B4A711DC400FDD1315E25250A2402478473538
      7D9587DB64BFE6F20B9DA76EF57F5F14652E4A405FF7EAA2F09C2DEBC81A42C4
      A0DA44E8E216416B980471E853703D1FC3EF7460A0DB05637A29264EB11181BB
      145D8008A72138D4015F7713E4A00C59121550893E2B5741868F0CFB6183889B
      01FD9FDC7EA12333C13CFF9F4D8EE71938591686CBAF2C0CCEADF88EE25EB681
      2CD3466298B51CE86D8BA1B71422ECA84777EDDB30A6E622D6304211EA2170FD
      F0DDAD27A9054A8344A664A0143D5D258188285722E0074E5D1570B233B4CCC3
      095DBB9EC8BEF1CA271D93A2044CB52F97074AB6AC8544C084AC80CB647B59E4
      21D386B286CACBBE089C9C07FEC179C8A3CDF0769E21400211089C53C1D93B8C
      40304244264F4AA204CF2811200F1C69F4669A0C5AC30B4BA7371EFCE4F61425
      FFB4CC3507CA474B2AD690F8F41231972502666E16228E96586A7801E6CC6DE8
      AB7A4E0166E692827465CF10B81C6264A4B1E895ABAA80976CF7C13511479BBC
      999312634A9F9891BAFB9DCBF796470958AAFF58E69DF7EC6A622B468059E48C
      842447BEF30C8447CC94ADE83DB72B126538021E8D9E1155CC17625749B1932C
      484A1ABC410D3E20058EDDF2E6AECD4FDBDFEFE69AFED5EB79593120EB3F97F6
      97BA4B2A5611A0A09492A4444F1BCBAA12141DDBD194F934EE9FFB19E55B5472
      2E8518D98772CF08D0AA0BCFC1716E0304AA0691FA83180AC179FD6F87374D0B
      3D79A4AAF3715192BBA204E22FFCA1C4595AB142915A915D12151030254406CE
      2BD1C5646C42DFF917232960D1131073BEC87C434A8882AC2853179883CAF85D
      C89E910F8D4643FB52197B9DD055EF47535BC799BAE696AD843BCC0850C1C35A
      B56FEEF0FCADCB23A044628C881055845722364F5C8BFE8BFBC6E497A9CE6521
      123D939D359EDAD1A231F05122D8D5DE025F6F23D20D4E4CD5F5E1C3DE14DCAB
      3E3699D4EE63048CB4123EDB3BE74169C512B0862F0A2CF2B06246B028D91223
      8A9853BF85819A0391140499CB238D466639E76554FB0A5169D985AC9C3C78A9
      798D7883E86F3A8FA5EE77604CC946937D3DDA9A9A88C06B3954699D510213CE
      ED2EEA2F230252D480B4A9A2047333CF2B6422041663E0F29FE93E1F693A2CF7
      62A422AA3D453863DE89CCEC1C68041F9263B5D480C2B8D73D402A342233C50E
      FB9459A839FB317A6A8FCE249CDB8C808956D2D9970AFBCA9E59A4E49E451DAD
      7F5164279A18713733E184F9705C3916C93D733EFDC613788D872227F0C9D3F2
      E86C7061E79A2CD8E34CC848B662F75F6B70EB7E90BEEBE1F20470F3C269F45D
      79638C80A240E5AF0BFA67AD2A46BCD5A0442EAB804C0139AC2A41CB94580447
      C3DB4A9F67B28B64BC4B24FB19C3766450E42E3A754A261BB179D9346CFCC549
      54BDBE15EF9F6FC79B95F7941160F86E337AEB4F1CF20F35EFA11BBEB12A5890
      63ADD8B13273CFAC39191326CF4C8196B5635152BA9CD209C3A252A28684D918
      BC7E52899EA5E482AB0095861D247B2EB26C616C289F849FBC7A011F1D5C8F9F
      1E3A8B95F3B271F0C40DE8F4060C77B7A2E7CA7B7F090CB6FC8E309DEC488E1E
      464C85F8189336BBA23CE9A5EF964FDC30BD3803F6C418A58D4A4181F553A519
      E96CD331D27C4A49014FBDE137BD2F2073EE7AF8E9F3EA3C0396146660D3AFDE
      C71B2FAE4475631F8E57DD838E8699E1BBAD24FB89C3A343CD0C7CE4E18144AB
      2A61A165CF4D8B59B1FDF194BD854529E9D36726C3C0EA58ED0D3ACB14385B2B
      95DC73247F87D386B7C2DB61C828C31C3A5AF66C9B8781611FD946C2DEB76AD1
      E908C2D9DD86EE86E34738472B031F8E823F3C9245DBB2A2865E83F4B5F9D69F
      6F989BF2747E618A2E75422C7942843E2E03AEF64FE1F789085315DC7788A86C
      8FE36E663D8799C50B6292E3346C88C5D5B64104284DCEBEDBE8BD72E235FF60
      F3BE87C1BF68261C9B0F543512D3ACFAB2A70A13F62CCC4FCC7D6C76324CF169
      70B4D62040D137DF1170AE2DD870AEDBFF5BC19468CE59BAE3CDE4E9A5764939
      CA45CA7933033FEA1F6C61E0430F833F6A2A1EAF061BA152CA269B776C9C6DFF
      41414196911BE9427D73D8FF8FDBFEC3ED23FCBBF4FB201B340D968492ECF26D
      7F4FC92DB30DF7DE21B7BFF73AB97D9FFABBF89F80F00812E3D59860356AF257
      4FB7FC921D0DA73BFDFB3801EDAA9BFD2A408CCE645D949CB7EE5D5FFFCD1324
      FBEF1F05FEDF088C7F46AB36AC58950C54D000ADB00A20ABCFB2B93F5EBD4F63
      4864F8FC2A04C63FA7531754D068645FEA1FD1AF42E08BDEF9BF41C7FFFD1B54
      70B0B37AADC2B60000000049454E44AE426082FFFFFF1F046F03000089504E47
      0D0A1A0A0000000D4948445200000020000000200806000000737A7AF4000003
      364944415478DA63641860C038E81DC02326AF2DAA64E02C20A365C92BA1A0C7
      CD2F260F12FFFAF1D5C3CF2F1E5CFAF0E4DAF1D7F72EECFDF2EAE155AA3A804B
      405C41D6D03541CEC82D9E9D5F4C019F213F3FBE7AF0E8DCAE858FCFEF5EF0ED
      C3CB07143B405851CF41C92AB0585CDDD207C49713E56130501466D090E16750
      10E305AB79F0EA33C38D271F192EDC7FCBF0E8F517B0D8CB9BC7B7DC3BB6BEF7
      EDFD4B07C87600C8726DF7A40E3E290D7331014E06177D6906071D490649212E
      AC063C7FF78DE1C095E70C7B2E3E6578F5E13BC3A767374E5EDD39AF825847A0
      380014ECDADE1993413ED795176208B4546030551545D1E0DBBC134C6FAE7547
      113F7DFB35C3FAE30F182E3F7C070E89AB5B67E412131D280E50778C6950758C
      A907F93CC34313C3727C0E803962C68EEBE090B8BD7F49E3CDFD4B1A88760028
      B55BC6366F0125B8287B1586483B65AC1AF0390004961FBACBB0ECE01D70C23C
      BEB8D68750EE4009816420980304F834107200284DB4AC3A0F4E9857B74DCFBF
      7F62E324A21D306FDE82458989F1B19438000466EFBCC1B0E9D44386A7970EAE
      38BFA63D92280730B371F2E44DDAFAAC27CD8197891177F9448C030E5F7DCED0
      B5EE12C3A7570FAF1D9A92AE4D9403D45D12DB54EDC22BB3BCB4183C8D65093A
      001B8039EA3130F8B3661C65F8FBF3FBD7EDAD813C041DC02928AEE8983BEB1A
      130B3B072F272BC3AC1C5B061E0E56FA39C034B26E9DB8A655204CD0CF4C9E21
      D55D83815C405214004B3E47CBC4AE7DC882CC4C8C0C93D3AC1864457918C801
      242542FB9C699779C59474D0250C9584199AA24D48B69CEC6C486C41442CB87F
      FFFE035F5F5F9FAB40409403408098A21817B899EC42508DC6BCBD18F99BE4CA
      885407C02CBD91E4FC9FA00340809CEA1824479510407604290D92A919D6443B
      001412041D008B0E629B649362D41EFC6A49C5AB866407C000318D52AECF77F6
      AE3597B8428A0360D141B56639BACFE8EE00521D4A550710E37B64F0FBEFFFDF
      BA0BF7B10D1F07C0002B2323DBEFFFFF7F91224F3507D458A84D89D292CD5A78
      E5D184CE53B78B8895A79A03CEC73A7CE56465E6FAFEFBEF37C3C507B88995A7
      9A03720C14EBC334A4D3975C7B3C79D6A587EDC4CA03006197CA2858A8D32500
      00000049454E44AE426082}
  end
  object ImageList16: TUniNativeImageList
    Left = 456
    Top = 379
    Images = {
      0A000000FFFFFF1F04EF02000089504E470D0A1A0A0000000D49484452000000
      100000001008060000001FF3FF61000002B64944415478DA7592694854511480
      CF9DE7A8A9590D6EBFD2A9314B0303B5C010A268D5326DCC10B73445D2B288FA
      532452A14224FD9081A8505CB01F914A6AE9980836663631E9808A63451138D8
      2C3A3A2E6FEBDE798B43D45DDE79EF9D7BBE7B3604C240D979D7F42732F20F23
      1E7FF164E1C9932DBCD7DE2DB96799325509DA8D8144493D7DF1912ED42620C1
      801C43C0B22CD00C0BBD43539075321EF6C4253E989E3456632DFD37C0E749FB
      E87AA1360989D6A2E081613978D93B0EB9671360ECCB4FC8D2A6D6FC989DB883
      B59C3740A96BFDB0569495840647BFC9EE7942C0D26AB57B602C2B8455597A2A
      DDBDE4ECC62A5602F836341B568BB3F72305129CE0854400CFF130EF708373D1
      0DAEA53558A719C84C3D58E0B0595BBD017E8F1B87572E5D3880DE8D7CF5DC26
      7880049498364D940A42B605424CF48E8B4EBBB505FF6224807FFDF32177694E
      32A2B0079C049042111F0C4B72C282461D558401CDDE80C03ADD80AB2C3F050D
      BCB778E2F4A44704916C91F2EED6844278683044AB234B9C0E6B13A9860CA869
      D0BB2E17A4208A52C82EF37245847C30381F1CA6FD0BB0B9BAFECDC295E243A8
      7FD8B291033C119EC911588E7F02657A36900BEA0B720CCFFAFB7473CBCB2D12
      20B8EA61B7F36AC911A4F451885510CA4860AB1D2DA0DAA781C58048F00B0B07
      34F61696BFFF8288A20A4A026CBD5DDB65AF2C3B2A96512CA1D895F6BE2E608D
      831016AB06CA2F00E64D9FA1BCA9A76D60CE9A2B015437EF77FCBE517EDC63CE
      7120874096BF9287C9B636D8B960049EA621EFD1AB4EBDC3518C8FD8E410D2CE
      DF1AC93897194B0C38F16A2229ECE4AE293D842C58C0366106F70A03DBE334D0
      689836D799CDF17227E21D44AAE1D5DE52AB23FD996333E1C8E553D1677A3DBB
      BA3ED37B3AE93ADAA282BDCD3DBEDE87FF3B14003141884A5CE4D976D2169B00
      A5D1C0DB1800C31FA7DF532A97F5F1410000000049454E44AE426082FFFFFF1F
      043E03000089504E470D0A1A0A0000000D494844520000001000000010080600
      00001FF3FF61000003054944415478DA6D525B489441149EF9E7DF5D6BC55691
      EE14AE4949424FD14320482FF9124541666AD2834476B3BC3E88486278C9D287
      C232EF68DE3049444A5229CA0BA2652E6BBBBA8AD95AA2A9B9FAEFFE7B669A7F
      75B7153A7060E69C39DFF9E63B07A37FB60363BC8D3184157307953B4274911F
      D7B92B71E655E30AB88229F9D5C6E41BB1871D765E4136EA19A548A6022AAD6C
      B4E4A744473280711E26DCC11BC06599C575A6ACC40B412BABEB4044226041C0
      BC3D5BF86D8365F0D53435D41B72D313CE320AA6FF32482FAC3666DF8A0A1999
      98078A04C53050CA9C3265224134E4E06E7576DE93CFA5F929D764BBD4E7AEF3
      30C828AA35E5DCBE14DCF4C10C0E9923108225BBCCF6046C474B3627FE6AFE21
      FB0704AA073FF64C3517258633466714100F405A618D2937293A78C8F4139817
      03C5193041926C107AC01FBDEC78337FEF6A4C04FF9EA287E001482DA835E725
      5F0EAEED3683C40B449160A79363F1318013508056C7D648379D5EFB84DB2BBA
      7A07EB8DA7B688989C57C50162F4C3A316E0837289080A0027497D3478595A61
      A3D60E883D1D2E2697A47DAF49EA09F506C077732B4C056971FA89B27260AB36
      81628425699DA9357E68380C63331B67BEA296858785A296A11A989BC2AB8651
      F32F378090F4A0CAF4303D4E3FFBAE07048743607C99EC0E89A9D4BEA85B6DC0
      478EEE620BF631649396A84457889FCE1FB5BEEFF330203773CABF3DCEB81234
      F2AC12A86D5550B83BF856893EBEC87A6C27EE9EEFA5CB6B93E87C4428AA7DFD
      76B9B3CCD046FF20AB1B40BC7EFFC57849467C50FB97397032C2A7286065007C
      5C08490EAC53E9D8B0B502020F19550DCD5DB39D59E6FDDE1AA812329F8E1571
      062D3D4690419923C614783D7F015C0F0D11A9463B8DDA06EAECEDC5AF8A6D33
      EBD9DE7BA0BE93576F79941AB5D7A9D0E14E379D6D76B1F38496279E370E2E24
      5C3C719C672CDE00E464645CEBD97367C21697966482091791081481EB078A1E
      E09441ABD5AAFA07FA673AEB4AE2F97E4C6ED9447ED42326EEDB68AC10F7E4F0
      E69DF213E740171003038F2B64D15F059A8FC9C988DCD80000000049454E44AE
      426082FFFFFF1F04E802000089504E470D0A1A0A0000000D4948445200000010
      0000001008060000001FF3FF61000002AF4944415478DA6D935B4854411CC6BF
      B337CB304D9375CFBA950FB284A2101484410F3D442F11616574F12584A82008
      5468CB524C092B0CB4272992445F929594D46A352C4A4CF29E6B5BA2EB6AEB0D
      2FBBB89E73669A73D925CD8161AEFFDF7CF3FD6738A845A7B51C3696F09868F5
      BF226FE07E4F2E923D7C6C6486524014242C0743585D0DA16FC0ED75DC2EC81F
      FAFEB19EEDA05B001688CD12ABAC28AB546D038110169783E0CD71E8F8E2C189
      A376239B96FE852800CF840A987BE0509688A4AA8D3A79164B89FB90628B87C4
      643534764C15390A0B7F8D76BFD2E2A90CD03180949CC41450A229A0ACE52049
      140B4CC1A367EDCAB5D2EC16044204ADF773CE571C39589751E7342A80B1F179
      299929F0DF2B5482095515C4645FC4A7D51D10441184501C4AB3A0B2A613770F
      7310BBDAF0C6D5EB5500EEF139A6208EC552A5AA22589FE3227E5042303BD482
      E79FA371DCBC06FB4C3FEE943C6E9201FA51CFAC68E5E3F09E192507A639AB94
      207628381D87ED7937B0E2EF45EA5E11F0BF466E4D165C1FDA9B677EBE3DA500
      7E78FCA2D5B24B3D553B4D16228F09EB7B7B1AB173AA16669E424AC840DED5BA
      96FA6EDF05B67549061886DCD382958F87AFE0A662A42A9BC3B64B57F0C7EF46
      7AA21BA2C789BEAFF3185E49C1F5979DD12C6E2D9C05C3E0E8B4C0F34C01D114
      505585776C10132F1CC8CAF482B3A6A3AB3384366336AACB2ECBEF410CBF0363
      FF886F5D0634BB46D414B2AAD7039E1E17AE9DC9446B593E488C19C74A1AF0B0
      EA1D2A8BB30DDA8352017D2353EBBC25219201F9DE8220A0A8AC16BEE10E9CCE
      D88D03B9B760B325A3F4490B9E6E02987A07BD219E79A0C547CC0B0603D0E9F4
      309A4CE0381DA24C06145734A1AAF4DC46C0B781C9D0FED424256DB27D84AA3E
      907036107E0B1445E54E5497E76C00C8557655BFC537DEFCBD89665E303CF117
      353964533B5601480000000049454E44AE426082FFFFFF1F04B102000089504E
      470D0A1A0A0000000D49484452000000100000001008060000001FF3FF610000
      02784944415478DAA5936D4814411CC69F39BDAB0BA3948A0C8B203F45449C92
      99F402465F4A092D3C45EF32D1B257E84229B038951332BF1C4A201A25A16411
      127AA8579987068711642005124805D99D2FD5E9712FBBD3ECECCE75097D6AD8
      99DDFF7F767EF3CC333304FF5988F6D6753E7E133D5D6822A0501E5E24494624
      2A617E6119E36F67D0F3A0B5F1D9938E7AD615590948E8EC9D88580A4C3CE600
      AAB0286449826F7E09BDAE491CCADA019BADC6E119EEAE637FC8F180C4F61E6F
      D85A9841E69A6E720455291C26575D475B97078DD78E419229F24E581D6ED743
      3BEB0A0B80FE6EB737547E32832823A9C2A5545342B11808E15ECF38667DBF38
      78D7CE349C2BC94E62BD4B02B0AAB5EB75F04CD15EE26FB8012A5315A0A9F095
      5EC5F7B900A4A88CCCDD69F078A7519C674AA6942EC600CEFB63C10A73160906
      23AA70CED054682B55BEF57A1D9E7B3EA2E8F89E14162E08C09A968ED1405549
      3679E5FD84F46D1B409C76069085A35C8D52531D2D707B3EC09C6FDAC826F0C7
      00CDED2381B3A539AA022E5F2C214E096B8C46038647A7509C6FDAC4323E0148
      6A6A73FFACB61C249F6BAF30DBD599152BB87A4E621096DED2ECC4E0C8142C05
      999B59725600D63638877E5C2C3F4C9696C3B11DA071F28507C6D5060CBE7C0F
      EBA9AC54D6F14D00D6DDBA33B070A93297BC189B56D78B3FE720662AFBCEDD9F
      0E977B1215E67D692CFC2A00EBEB6EF7CF5FAE3A42F4893AE5FCC506206E76A5
      0945240C30406571F65696F9220029358D7D7EDBF9A33C96E39D8730121A94A2
      7FE81DAACB72B6B3CC8C0024DBEC4FE7EA6BF348CC3C0EA29A99EAAEC89A8A47
      7D13B8603DF0978204E58CB06A5871C9F08F38CA6A48B995BF010DA03C20F6E3
      883B0000000049454E44AE426082FFFFFF1F041F01000089504E470D0A1A0A00
      00000D49484452000000100000001008060000001FF3FF61000000E649444154
      78DA6364A010300E130398262ABE65E066142249E7D77F1FFEE53F1084183047
      E93F58F0CBDF37FF0A1E8AE2D3C7D423FF9C41805902C4FE97728F11610048F3
      C2D7E90CE7BFAD03ABD4E7F2658A139DC9F09F81F1DFD2D79940F10D6071436E
      7FA65891D90C7CCCA2280680382836F5CA3D63E0679104733EFD7DFDAFE8A118
      8A3C540F6E03909C8ACD6B1806307CF8FBE2DFD237190CE7BF6E8438952B8029
      5674160313D00B8B81E267BFAE857ACD07E885590C022C92A806E0702A4620F6
      CA3F65E06796420DC4490AEF19B89804488AC6EFFF3EFDCB7DC03F4852E2801A
      0000661F6D114DCAFC540000000049454E44AE426082FFFFFF1F042D02000089
      504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF61
      000001F44944415478DA6364A010306208A8733AFC77E4CD6652E5B461E06112
      66F8FAEFDDBFDB3F8F30EEFF38EDFF8DEFFB701BC0CCC8C2182D3495D18E3F0D
      976DFF0F7F9AF77FC99B0C86BF0CBF310C608C139E89AEF95FCA3D46A6394AFF
      510DF932FFFFC257492806809CCD582AB91FAEEACE8FA3FFE6BD4A6078F5E70E
      A32687336382D87C06611659B821BDCF5DFF5FFFBE07614086F82A4613EE50B8
      CDEDCFAC18EDF852FFCF07DAE42150C6F0EDEF27A638D1E970F9735FD7334C7B
      19043780A957FE39033FB304DC86BEE71E0CFC2C62FF8F7F5ECC3453F137C3EF
      FF3F193898B8E12EFCF2F7CDBF8287A20803408A80810857F0F1EFF3FF9BDE35
      FC3FF2651E033F93144398702F93094F08222018FEFF4BBDC78430A04FFE0503
      1FB3387AA8FFCB7B20C89020368761DECB44A6298A9FE0129FFFBCFD57F84804
      110B99126B988CB982E11AEB9EE832040836312C789DC4542CB9FB5FF7332764
      03FE9DFFB29161EAAB0044206A703A319648EE85DB70FBC7917F0B5E2733BCFC
      7D0B94981843857B18AD7913E03EE87FEEFEFFEAF75DA8E9205E6C2EA32D4F12
      BA1798DAE5EE33703309C0351FFBB4E8FFBC37F1585222032B638CD84CA02189
      38532248F3C2B7A90C7FFFFFC2340026A0C9E9F2DF812F9B499DC386819B5998
      E1CB9F77FFEEFC38C278E0F33498B351D433500828360000C0CEC41169404033
      0000000049454E44AE426082FFFFFF1F040703000089504E470D0A1A0A000000
      0D49484452000000100000001008060000001FF3FF61000002CE4944415478DA
      6364A01030E2114797FB0FC5380D80B19964F59DE26DBDC313645475CC4102CF
      6E5F3975FDCCDE7517F6AE9FF9F7EFEFEFC806C1343172F10BCB8457CED8BBA6
      3BD78B954B44C53FAF6B6B638613131350C9E3D75F186E3D7ECFB067DFB1CBEB
      2615077C7DFFFA0150CF3F64035803F2FBB6D716253A97364D3FBC7F5EB5B79C
      59788B8CA1771E3B1B3383969A04436AA819C39D87EF19D66E39707D656BA2C5
      DFBF7F3E835C02328045C721B4B8ACB1A3C3DC4C8161FFBEEB0C9D8D350DF7CF
      6CEA6566E512666262E11051B18E57B10A2B69AB0D623D7FE929C3ACCEAACA2B
      07D7F500F5FE61E417933749695F713C33C284E5C33F46063EC67F0CCD1377FC
      59D79FEFF6F5CDFDC350A7B24B687BD6BA2614567A39EB322C98BBEACCCEA9F9
      7640F1EF8C06412D97B904E474649425193293AC19E62D39C970EBDA4386EF1F
      9EDDBDB4BE4A0B640B1073B2B0F3AA98C74EB9505C15CCB074D1C1DF6B1BBCE5
      80E29F405EE000621EEFCA4DCF8A729D5967CC3DCEB0AE39C0F0EFAF2F774036
      80BC68973AED1C9FB892161B2B33837F8439C3EAC5C7C0F1F0E5CD93FBB040E4
      328DEE3A969C15A97FE7C60B860D73BB7BEF1C5BD5003580994758DED6B764DE
      8EE4386B9697BF18184459FF33B436ACFC7B7C657500CC0076293D9F6AAFCCDA
      5A7B6B65860DEBCFFCB9B06D56FFE3AB0796FDFFFBE7FBEFEF9F3F49EB79E77B
      E537959BD96B30EC5E758461EBD496495F9F1EAA81271E06461671AD908EC376
      3EAECAB6A60A0C274EDC6578F1E213C3EF3F7F19CE6E5FB2FCF1F1F9352A5EB5
      2BC3F2534DA614D45CF8747D911750DF2BE494C8CACA29A8AFE05AB952D7C65A
      4953539C41565E18ECD7554B8E339C5C5A9EFCF3DDE3EB4AEEF52B6E6DAD8F64
      F8F3E90C50CF2FF4F4CEC6C0C82C26A0E69ACF2B6DE2CE29A6A50B32E1FBEB9B
      573F3E38B2FCD3DD7D53A0C9F8271463CD4CCCD098E1001B0851F30B1AA03F80
      F82F31B99168000025FA18D57E25A7200000000049454E44AE426082FFFFFF1F
      047403000089504E470D0A1A0A0000000D494844520000001000000010080600
      00001FF3FF610000033B4944415478DA85936D68536714C7FF3737BD4DD2C6A9
      23A61A6DD4BE6455A7C98C31D695BAA10575CEF96115E7A6A232CA108A1419E8
      0737411415155FC698FB20822F481C7E98C3B7A9D5F9D2A6B4D4D6DA2CA94D62
      6C67D2A4B9E9EDBD37F72DDE540333203E70E09CE77FCE0F9EFFC321F0F621F2
      EACCFBB4B14B82203435E513367EED9CBCC33C9E9A118E73A1AB8FE3A76EF6C6
      8EAA5AE65D9A3A2AE7008527D756252CD6A97AEBF429049B8CA3B5CD879D7FF6
      5B38418ABF4B63D3E2C018802449E3BE2FCBE34BEA3714C4424F41EA4D18A679
      F9463FDF242B8A506F2F393ED36E27836DD730E8F721D0FF423AD4FC9F451084
      680E50BC7DA5E3EFAD3F6C7259674EC7D347FFE0A5AF85D388ACA891D345D174
      9154EA5A5138DFED40C795B3F8EDE2FD7B67BD91D592240DE700BADAB9650D3F
      7FBFFC8863B11BD77F3D80326735928924264E9E8258B00F0F9ADBB16DFF5EDC
      397F1A7B3C5D8D9DE1D8EFB22CB3C46B0B8802834157F1D3D66AEFC7B645FA67
      B72FC052390B0A34F075FB31DE4821181E42CDDA0D78E0FD8B3B72B1D7CDB29C
      4F9D15B200FD1CB7F99BDA95339ABE5AB5BACA64B4E1EEC163282DB1A0AEA111
      23CF5AE1F9E50CD80F3EC4E78D5B108E7BF1C7A52BBD8FAE458E06BAE973C4FA
      ED736FD52E9DF75999D586041784413B157C920279AB03CBB634800DB7C373EA
      02267DB706DA090CA2740084A4438F2F80F67BC1BB44D3B145B2DBE9D444E908
      F834834C868089FA04C9DB1DF8D4BE00CCA01F77BA7CA8F8761506465B40A746
      C0712248F5793D9DCF15C2555772C26CD5D7505A4A67AB986D29319516B1A3AC
      3038DC455A131499E679F88B05A9D2BA40D217E975A1813EBEBBBB2BC2300C3F
      F442B83FE6811A05D9CF304EA4AC0BBF98F4A3BDDABCA6C6E52C24490DA24C08
      1CCFE16173487CD2327CD9F73075984DC97DAAF162CEC4DCD1AEDB55D159B7CC
      316B9AC5043193C64B3A084E64A0280A880C89C19084AB9E7FFDDECBF43CB59F
      CB5F106AF381CAB4CB61038F0458610485068C0DD3B4005190C1A424B45C8FA3
      CDC318D57E261FA0FD68A171E73873818B3210A54A46D153C52897D20A5231B9
      4F92647E949622A349A5732820EF56FBF97C403627FF17D95A93B7BE4A7603D5
      10DFE47805174F867806D57E230000000049454E44AE426082FFFFFF1F044F03
      000089504E470D0A1A0A0000000D49484452000000100000001008060000001F
      F3FF61000003164944415478DA8D937B4853511CC7BFD7B96C2D37733E52A7A6
      D524DBDC5C2FCAD572CBA207D90BC4B0A762F6477F14452F8420831E44105466
      90210505153D4CF331CAF241A5A388AC997ACDB74D97AF9CBB773BB7EBFD23CB
      0AFAC1E1C039E7F339E7F73BE750F8476822A486EDC6E01C11384991D5915769
      1BBA33EA26C313D7511307E266480D3B4DC139CB17461889B31F9314120C740E
      816E768E58DEF5DF7CDE3098F7E51B5BF787401B2535642485E4984C738D619A
      185094088D25C5981C2205615D00CB826183515DFA11FBEEB5FDE4285DB4D490
      B92A34C76CD61A4334B321F2F6868775F3104163790924BC402C990E797812FA
      3FD5E0C9ED721C78D4312EA839AFE76625AE834F8019FDB4157DF58F78C10828
      E206E52D46A86107BC3015ED965C8CF676E1C55B278E14778D0BAA4EC7739AE4
      95206E0EDEF24510F9C6A1B7E91EE076C13F6A037A5E15C06E1D9312FE541E3C
      AB7322DBD2332EA838A5E5B46B4DFC0216846100911FFCF5D9186AA9416BE949
      8C3A7A04906539E4772E47EDF06C1EE3E01CE8AEA72BAF9B29CB89382E7ECD52
      7818966F8CD0FBA9B360BB95098F9B08B5601982FCF665B047A6C13720180CE3
      C2B0A30F0D550FEBA992636A4EBF7A31DC3C4C04090BF99C347CBE7B984F8BF0
      9970B8D69600B13A1567B20CF8D0D8890EFB106EBC70A0A9B61C54E1A1582E2E
      51C7178A135218BB01D9CCF5682E3A0BD64590472F416FE4561CDD3C13D6C65E
      18B5A1904D9520E3C26BD0565E6050F9A664AE08BBA4D62815D31453F85DDD90
      2A97A1E5593EAED8164065DE0D5584021C47D0ED18C1AC50196A6D5F51584DA3
      E5F583A74235653E5E81DB17075E35C7076D54C50641AED4E178411BECE13BB0
      2B498998087FDCA968C6C19479D872B20283F60EB4BC795C66FF5494FCDB53D6
      8549B6A4EA15B909893A456E05D019BE0D7A7518CEED4910E62BAD9FB1FFE273
      D0AFEE97F53594268310E71F7F412AA602D7A96457190F615E329A6155627AFA
      7C4D2406BFBBF0DED606BAE67E99A3A95C80FFFA9926865CB9E872B42175AF97
      D80774350FD3969FF07F09845385E82F8B7CA45183AD559B7E85C7E207691A68
      FBA4598AC20000000049454E44AE426082FFFFFF1F048501000089504E470D0A
      1A0A0000000D49484452000000100000001008060000001FF3FF610000014C49
      44415478DA6364A01030227338F8456525B5AC83C5548CDDF925D58C41621F9F
      DF3AFBEACED99DCFAF1D5DFBE3E3EBC7380D1090D5B054B1092B93919210B5D6
      9262F6B6335004896F3D74E1FED16BCFFE3E79F6E2F59D23ABBA3E3CBE711CC3
      0090CD3A5E99938C34640566D6A53860736A7AD39C03E76E3CFE7065DBF43C64
      97800D50B40C28D0B7720B59DF93690D93F06DDEC9B0B9D61DC590C092E9472F
      1EDBB5E6FEF10D1330BCB06AD5AAD5A1A1A121F80CE899B7F1C49A03973F9C5C
      5CEB0937804F4AD5D82E63F2991A7F9537E67ACA22F80CB87EE7E1CB82D92799
      7675858BC10DF069DAF1FFD7978FAFD978F8459135800C40062039AC068008F3
      D8E6ED210EBA022549FE16F8E21CAB1770052232B899EC82C2D798B79711C500
      42D188CD801B49CEFF894E48BE47275B60330044939D94B11A800BC09C8B0E88
      36001F20DA009893D1D900DE81BD8DA9ECDE960000000049454E44AE426082}
  end
end
