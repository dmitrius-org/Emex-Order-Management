object BalanceTotalT: TBalanceTotalT
  Left = 0
  Top = 0
  Width = 1354
  Height = 581
  Layout = 'fit'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  TabOrder = 0
  object pnlOrder: TUniPanel
    Left = 0
    Top = 0
    Width = 1354
    Height = 581
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = 'pnlOrder'
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'fit'
    LayoutAttribs.Align = 'stretch'
    LayoutAttribs.Pack = 'start'
    LayoutConfig.Flex = 1
    LayoutConfig.Width = '100'
    object Grid: TUniDBGrid
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 1348
      Height = 275
      Hint = ''
      ShowHint = True
      CustomAttribs.Strings = (
        'testAttr')
      BodyRTL = False
      ClientEvents.ExtEvents.Strings = (
        
          'beforerender=function beforerender(sender, eOpts)'#13#10'{'#13#10'    var me' +
          '=sender.checkboxModel;'#13#10'    if (me) {'#13#10'        // '#1089#1082#1088#1099#1074#1072#1077#1084' Check' +
          'box '#1089' '#1079#1072#1075#1086#1083#1086#1074#1082#1072' '#1090#1072#1073#1083#1080#1094#1099#13#10'        me.showHeaderCheckbox=false;'#13#10' ' +
          '   }'#13#10'}')
      ClientEvents.UniEvents.Strings = (
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
          'copyToClipboard = str => {'#13#10'        const el = document.createEl' +
          'ement('#39'textarea'#39');'#13#10'        el.value = document.activeElement.in' +
          'nerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.sel' +
          'ect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        document.' +
          'body.removeChild(el);'#13#10'    };'#13#10'}'
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'//  config.displayInfo=true;'#13#10'}'
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  //var toolbar=sen' +
          'der.getDockedItems()[1]; //Remove the ToolBar fixed in the botto' +
          'm'#13#10'  //toolbar.items.getAt(9).hide(); //Remove the Refresh butto' +
          'n in the ToolBar, number 10, hide him'#13#10'  //toolbar.items.getAt(1' +
          '0).hide(); //Remove the Refresh button in the ToolBar, number 10' +
          ', hide him'#13#10'}')
      HeaderTitleAlign = taCenter
      TitleFont.Height = -13
      DataSource = DataSource
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgCheckSelectCheckOnly, dgMultiSelect, dgAutoRefreshRow, dgDontShowSelected]
      WebOptions.Paged = False
      WebOptions.PageSize = 150
      WebOptions.CustomizableCells = False
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      LoadMask.WaitData = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Color = 13421772
      EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
      EnableColumnHide = False
      LayoutConfig.Cls = 'grid-balance-totall'
      LayoutConfig.Height = '100'
      LayoutConfig.Width = '100'
      BorderStyle = ubsNone
      TrackOver = False
      Align = alTop
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      DragDrop.PromptDrop = False
      RowWidget.DestroyOnCollapse = False
      ToolButtons = <
        item
          Action = actRefreshAll
          ButtonId = 0
          IconCls = 'refresh'
          ImageIndex = 0
          Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
          ToolType = 'refresh'
        end>
      OnKeyDown = GridKeyDown
      Columns = <
        item
          FieldName = 'OperDate'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072
          Title.Font.Height = -13
          Width = 100
          Menu.MenuEnabled = False
        end
        item
          FieldName = 'IsCalc'
          Title.Caption = ' '
          Title.Font.Height = -13
          Width = 43
          Menu.MenuEnabled = False
        end
        item
          FieldName = 'StatusName'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Title.Font.Height = -13
          Width = 200
          GroupHeader = #1047#1072#1082#1072#1079#1099
          Menu.MenuEnabled = False
        end
        item
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087
          Title.Font.Height = -13
          Width = 150
          GroupHeader = #1047#1072#1082#1072#1079#1099
          Menu.MenuEnabled = False
        end
        item
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1075#1088#1091#1079#1072
          Title.Font.Height = -13
          Width = 100
          GroupHeader = #1047#1072#1082#1072#1079#1099
          Menu.MenuEnabled = False
        end
        item
          Title.Alignment = taCenter
          Title.Caption = ' '#1044#1072#1090#1072' '#1087#1088#1080#1073#1099#1090#1080#1103
          Title.Font.Height = -13
          Width = 120
          GroupHeader = #1047#1072#1082#1072#1079#1099
          Menu.MenuEnabled = False
        end
        item
          FieldName = 'OrderSum'
          Title.Alignment = taCenter
          Title.Caption = ' '#1057#1091#1084#1084#1072
          Title.Font.Height = -13
          Width = 130
          GroupHeader = #1047#1072#1082#1072#1079#1099
          Menu.MenuEnabled = False
        end
        item
          Title.Caption = ' '
          Width = 25
        end
        item
          FieldName = 'PayType'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087
          Title.Font.Height = -13
          Width = 150
          GroupHeader = #1054#1087#1083#1072#1090#1099
          Menu.MenuEnabled = False
        end
        item
          FieldName = 'PaySum'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072
          Title.Font.Height = -13
          Width = 130
          GroupHeader = #1054#1087#1083#1072#1090#1099
          Menu.MenuEnabled = False
        end
        item
          FieldName = 'BalanceType'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Title.Font.Height = -13
          Width = 150
          GroupHeader = #1041#1072#1083#1072#1085#1089
          Menu.MenuEnabled = False
        end
        item
          FieldName = 'BalanceSum'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '
          Title.Font.Height = -13
          Width = 130
          GroupHeader = #1041#1072#1083#1072#1085#1089
          Menu.MenuEnabled = False
        end>
    end
    object ShipmentsGrid: TUniDBGrid
      AlignWithMargins = True
      Left = 3
      Top = 289
      Width = 1348
      Height = 289
      Hint = ''
      ShowHint = True
      CustomAttribs.Strings = (
        'testAttr')
      BodyRTL = False
      ClientEvents.ExtEvents.Strings = (
        
          'beforerender=function beforerender(sender, eOpts)'#13#10'{'#13#10'    var me' +
          '=sender.checkboxModel;'#13#10'    if (me) {'#13#10'        // '#1089#1082#1088#1099#1074#1072#1077#1084' Check' +
          'box '#1089' '#1079#1072#1075#1086#1083#1086#1074#1082#1072' '#1090#1072#1073#1083#1080#1094#1099#13#10'        me.showHeaderCheckbox=false;'#13#10' ' +
          '   }'#13#10'}'
        
          'reconfigure=function reconfigure(sender, store, columns, oldStor' +
          'e, oldColumns, eOpts)'#13#10'{'#13#10'    //dataColIndx = sender.headerCt.fi' +
          'ndColumnIndex('#39'Invoice'#39');'#13#10'    dataColIndx = 4;   '#13#10'    actionCo' +
          'lIndx = 7;'#13#10'    actionItemsIndx = 0;'#13#10'             '#13#10'    columns' +
          '[actionColIndx].items[actionItemsIndx].getClass = function (v, m' +
          'etadata, record) {'#13#10'        if (record.data[dataColIndx] == "") ' +
          '{'#13#10'            return '#39'x-hidden'#39#13#10'        } else {'#13#10'            ' +
          'return '#39#39';    //x-uni-action-cls'#13#10'        }'#13#10'    };  '#13#10'}')
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  //var toolbar=sen' +
          'der.getDockedItems()[1]; //Remove the ToolBar fixed in the botto' +
          'm'#13#10'  //toolbar.items.getAt(9).hide(); //Remove the Refresh butto' +
          'n in the ToolBar, number 10, hide him'#13#10'  //toolbar.items.getAt(1' +
          '0).hide(); //Remove the Refresh button in the ToolBar, number 10' +
          ', hide him'#13#10'}'
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'        el.value = document.activeElement.inne' +
          'rText;'#13#10'        document.body.appendChild(el);'#13#10'        el.selec' +
          't();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        document.bo' +
          'dy.removeChild(el);'#13#10'    };'#13#10'}'
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'//  config.displayInfo=true;'#13#10'}')
      TitleFont.Height = -13
      DataSource = dsShipments
      Options = [dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgCheckSelectCheckOnly, dgMultiSelect, dgAutoRefreshRow, dgDontShowSelected]
      WebOptions.Paged = False
      WebOptions.PageSize = 150
      WebOptions.CustomizableCells = False
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      LoadMask.WaitData = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Color = 13421772
      EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
      EnableColumnHide = False
      LayoutConfig.ComponentCls = 'grid-balance-totall-detail'
      LayoutConfig.Height = '100'
      LayoutConfig.Width = '100'
      BorderStyle = ubsNone
      TrackOver = False
      Align = alClient
      Anchors = []
      TabOrder = 2
      ParentColor = False
      Color = clBtnFace
      DragDrop.PromptDrop = False
      RowWidget.DestroyOnCollapse = False
      OnKeyDown = GridKeyDown
      OnColumnActionClick = ShipmentsGridColumnActionClick
      Columns = <
        item
          FieldName = 'OperDate'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072
          Title.Font.Height = -13
          Width = 100
          Menu.MenuEnabled = False
        end
        item
          Title.Caption = ' '
          Title.Font.Height = -13
          Width = 43
          Menu.MenuEnabled = False
        end
        item
          FieldName = 'StatusName'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Title.Font.Height = -13
          Width = 200
          Menu.MenuEnabled = False
        end
        item
          FieldName = 'OrderType'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087
          Title.Font.Height = -13
          Width = 150
          Menu.MenuEnabled = False
        end
        item
          FieldName = 'Invoice'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1075#1088#1091#1079#1072
          Title.Font.Height = -13
          Width = 100
          Menu.MenuEnabled = False
        end
        item
          Title.Alignment = taCenter
          Title.Caption = ' '#1044#1072#1090#1072' '#1087#1088#1080#1073#1099#1090#1080#1103
          Title.Font.Height = -13
          Width = 120
          Menu.MenuEnabled = False
        end
        item
          FieldName = 'OrderSum'
          Title.Alignment = taCenter
          Title.Caption = ' '#1057#1091#1084#1084#1072
          Title.Font.Height = -13
          Width = 130
          Menu.MenuEnabled = False
        end
        item
          ActionColumn.Enabled = True
          ActionColumn.Buttons = <
            item
              Action = actShippmentReportPrint
              ButtonId = 0
              Hint = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1087#1086' '#1075#1088#1091#1079#1091
              ImageIndex = 1
            end>
          Title.Caption = ' '
          Width = 25
        end
        item
          FieldName = 'PayType'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087
          Title.Font.Height = -13
          Width = 150
          Menu.MenuEnabled = False
        end
        item
          FieldName = 'PaySum'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072
          Title.Font.Height = -13
          Width = 130
          Menu.MenuEnabled = False
        end
        item
          FieldName = 'BalanceType'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Title.Font.Height = -13
          Width = 150
          Menu.MenuEnabled = False
        end
        item
          FieldName = 'BalanceSum'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '
          Title.Font.Height = -13
          Width = 130
          Menu.MenuEnabled = False
        end>
    end
    object UniPanel1: TUniPanel
      Left = 0
      Top = 281
      Width = 1354
      Height = 5
      Hint = ''
      ShowHint = True
      Align = alTop
      TabOrder = 3
      Caption = ''
      Color = clSilver
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 655
    Top = 162
  end
  object Query: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evItems, evAutoFetchAll]
    FetchOptions.Items = []
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.AutoCommitUpdates = True
    SQL.Strings = (
      'exec BalanceTotalCalc @ClientID = :ClientID'
      ''
      ''
      'select * '
      '  from vBalanceTotal')
    Left = 592
    Top = 162
    ParamData = <
      item
        Name = 'CLIENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QueryID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere]
      Precision = 18
      Size = 0
    end
    object QuerySpid: TIntegerField
      FieldName = 'Spid'
      Origin = 'Spid'
    end
    object QueryClientID: TFMTBCDField
      FieldName = 'ClientID'
      Origin = 'ClientID'
      Precision = 18
      Size = 0
    end
    object QueryStatusName: TStringField
      FieldName = 'StatusName'
      Origin = 'StatusName'
      Size = 255
    end
    object QueryOrderSum: TCurrencyField
      FieldName = 'OrderSum'
      Origin = 'OrderSum'
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryPaySum: TCurrencyField
      FieldName = 'PaySum'
      Origin = 'PaySum'
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryBalanceSum: TCurrencyField
      FieldName = 'BalanceSum'
      Origin = 'BalanceSum'
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryOperDate: TSQLTimeStampField
      FieldName = 'OperDate'
      Origin = 'OperDate'
    end
    object QueryOrderType: TStringField
      FieldName = 'OrderType'
      Origin = 'OrderType'
      Size = 255
    end
    object QueryPayType: TStringField
      FieldName = 'PayType'
      Origin = 'PayType'
      Size = 255
    end
    object QueryBalanceType: TStringField
      FieldName = 'BalanceType'
      Origin = 'BalanceType'
      Size = 255
    end
    object QueryIsCalc: TBooleanField
      FieldName = 'IsCalc'
    end
  end
  object qShipments: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evItems, evAutoFetchAll]
    FetchOptions.Items = []
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.AutoCommitUpdates = True
    SQL.Strings = (
      'exec BalanceShipmentsCalc @ClientID = :ClientID'
      ''
      ''
      'select * '
      '  from vBalanceShipments'
      ' order by OperDateS desc')
    Left = 708
    Top = 396
    ParamData = <
      item
        Name = 'CLIENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FMTBCDField1: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere]
      Precision = 18
      Size = 0
    end
    object IntegerField1: TIntegerField
      FieldName = 'Spid'
      Origin = 'Spid'
    end
    object FMTBCDField2: TFMTBCDField
      FieldName = 'ClientID'
      Origin = 'ClientID'
      Precision = 18
      Size = 0
    end
    object StringField1: TStringField
      FieldName = 'StatusName'
      Origin = 'StatusName'
      Size = 255
    end
    object CurrencyField1: TCurrencyField
      FieldName = 'OrderSum'
      Origin = 'OrderSum'
      DisplayFormat = '###,##0.00 '#8381
    end
    object CurrencyField2: TCurrencyField
      FieldName = 'PaySum'
      Origin = 'PaySum'
      DisplayFormat = '###,##0.00 '#8381
    end
    object CurrencyField3: TCurrencyField
      FieldName = 'BalanceSum'
      Origin = 'BalanceSum'
      DisplayFormat = '###,##0.00 '#8381
    end
    object SQLTimeStampField1: TSQLTimeStampField
      FieldName = 'OperDate'
      Origin = 'OperDate'
    end
    object StringField2: TStringField
      FieldName = 'OrderType'
      Origin = 'OrderType'
      Size = 255
    end
    object StringField3: TStringField
      FieldName = 'PayType'
      Origin = 'PayType'
      Size = 255
    end
    object StringField4: TStringField
      FieldName = 'BalanceType'
      Origin = 'BalanceType'
      Size = 255
    end
    object BooleanField1: TBooleanField
      FieldName = 'IsCalc'
    end
    object qShipmentsInvoice: TStringField
      FieldName = 'Invoice'
      Size = 64
    end
  end
  object dsShipments: TDataSource
    DataSet = qShipments
    Left = 802
    Top = 397
  end
  object actMain: TUniActionList
    Images = UniImageListAdapter
    Left = 472
    Top = 162
    object actRefreshAll: TAction
      Category = 'Action'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 0
      OnExecute = actRefreshAllExecute
    end
    object actShippmentReportPrint: TAction
      Category = 'Action'
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1087#1086' '#1075#1088#1091#1079#1091
      ImageIndex = 1
      OnExecute = actShippmentReportPrintExecute
    end
  end
  object UniImageList: TUniImageList
    Left = 360
    Top = 396
    Bitmap = {
      494C010102001800040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006A6A
      6AEF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF6B6B6BF100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001C1C1C1D6E6D6C70A79E94B7BB9774EABB9774EAA79E94B76E6D6C701C1C
      1C1D000000000000000000000000000000000000000000000000000000007171
      71FF000000000000000000000000000000000000000000000000000000000000
      000000000000717171FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003838
      3839A49C93B0B88248FFB88248FFB88248FFB88248FFB88248FFB88248FF4E4E
      4E4F000000000000000000000000000000000000000000000000000000007171
      71FF000000000000000000000000000000000000000000000000000000000000
      000000000000717171FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001C1C1C1DA49C
      93B0B88248FFADA194BF656464661E1E1E1F1E1E1E1F65646466555454560000
      00004C4C4C4D0000000000000000000000000000000000000000000000007171
      71FF000000000000000000000000000000000000000000000000000000000000
      000000000000717171FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006E6D6C70B882
      48FFADA194BF2D2D2D2E00000000000000000000000000000000000000004C4C
      4C4DB88248FF4C4C4C4D00000000000000000000000000000000000000007171
      71FF000000000000000000000000000000000000000000000000000000000000
      000000000000717171FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A79E94B7B882
      48FF6564646600000000000000000000000000000000000000004C4C4C4DB882
      48FFB88248FFB88248FF4C4C4C4D0000000000000000548A06F2589106FF5891
      06FF589106FF589106FF589106FF589106FF589106FF538B06F4578E06FC5891
      06FF589106FF589106FF589106FF538B06F40000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B88248FFB88248FFB88248FFB882
      48FFB88248FFB88248FFB88248FF00000000030303044C4C4C4DB88248FFB882
      48FFB88248FFB88248FFB88248FF4C4C4C4D00000000589106FF1D3001553B61
      04AD192B024C426B03BC090D00181B2D01502A47027D2035025D0E18002A3A5F
      05A7111D0134457204C81524013F589006FE0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004C4C4C4DB88248FFB88248FFB882
      48FFB88248FFB88248FF4C4C4C4D0000000000000000B88248FFB88248FFB882
      48FFB88248FFB88248FFB88248FFB88248FF00000000589106FF508205E70E18
      002A1D310257589106FF0D170028589106FF589106FF3C6304B00A1301214572
      04C9294502780B11011E487705D1589106FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004C4C4C4DB88248FFB882
      48FFB88248FF4C4C4C4D00000000000000000000000000000000000000006564
      6466B88248FFA79E94B7000000000000000000000000589106FF4F8105E50C16
      01261E320257589106FF0D170028589106FF446F04C50D1700294D7E05E05690
      06FD264003710A120121487705D1589106FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A59595BB882
      48FF4C4C4C4D00000000000000000000000000000000000000002D2D2D2EADA1
      94BFB88248FF6E6D6C70000000000000000000000000589106FF2A450279365A
      039F233A0366457206C91A2A024A589106FF508606EB192A0149192A01493F67
      04B613200239477705D21E320258589106FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000F0F0F104C4C
      4C4D0101000175737277656464661E1E1E1F1E1E1E1F65646466ADA194BFB882
      48FFA49C93B01C1C1C1D000000000000000000000000538806F0589106FF5891
      06FF589106FF589106FF589106FF589106FF589106FF589106FF589106FF5891
      06FF589106FF589106FF589106FF548A06F20000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000101
      00016C6B6A6EB88248FFB88248FFB88248FFB88248FFB88248FFB88248FFA49C
      93B0383838390000000000000000000000000000000000000000000000007171
      71FF000000000000000000000000000000000000000000000000000000000000
      000000000000717171FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001C1C1C1D6E6D6C70A79E94B7BB9774EABB9774EAA79E94B76E6D6C701C1C
      1C1D000000000000000000000000000000000000000000000000000000007171
      71FF000000000000000000000000000000000000000000000000000000000000
      000000000000717171FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006969
      69ED717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF6A6A6AEF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFE00300000000
      F00FEFFB00000000E00FEFFB00000000C017EFFB00000000C3E3EFFB00000000
      C7C18000000000000100800000000000018080000000000083E3800000000000
      C7C3800000000000C003800000000000E007EFFB00000000F00FEFFB00000000
      FFFFE00300000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object UniImageListAdapter: TUniImageListAdapter
    UniImageList = UniImageList
    Left = 483
    Top = 395
  end
end
