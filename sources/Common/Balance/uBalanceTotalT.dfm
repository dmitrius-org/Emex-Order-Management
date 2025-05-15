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
        end
        item
          Action = actLegend
          ButtonId = 1
          ImageIndex = 2
          Hint = #1054#1087#1080#1089#1072#1085#1080#1077' '#1089#1090#1072#1090#1091#1089#1086#1074
          ToolType = 'help'
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
          FieldName = 'Sep'
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
          'e, oldColumns, eOpts)'#13#10'{'#13#10'    dataColIndx = 4;   '#13#10'    actionCol' +
          'Indx = 7;'#13#10'    actionItemsIndx = 0;'#13#10'             '#13#10'    columns[' +
          'actionColIndx].items[actionItemsIndx].getClass = function (v, me' +
          'tadata, record) {'#13#10'        if (record.data[dataColIndx] == "") {' +
          #13#10'            return '#39'x-hidden'#39#13#10'        } else {'#13#10'            r' +
          'eturn '#39#39';    //x-uni-action-cls'#13#10'        }'#13#10'    };  '#13#10'}')
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
      Images = ImageList
      EmptyText = 
        '<div style="text-align: center;"><i class="fas fa-inbox"></i> '#1053#1077 +
        #1090' '#1076#1072#1085#1085#1099#1093' '#1087#1086' '#1086#1090#1075#1088#1091#1079#1082#1072#1084'</div>'#13#10
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
      OnDrawColumnCell = ShipmentsGridDrawColumnCell
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
          FieldName = 'Sep'
          Title.Caption = ' '
          Title.Font.Height = -13
          Width = 43
          CheckBoxField.Enabled = False
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
          FieldName = 'ReceiptDate'
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
              ImageIndex = 0
            end>
          FieldName = 'Sep'
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
      '      ,'#39#39' Sep'
      '  from vBalanceTotal'
      ' order by StatusID  ')
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
    object QuerySep: TStringField
      FieldName = 'Sep'
      Size = 1
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
      'exec BalanceShipmentsCalc'
      '       @ClientID = :ClientID,'
      '       @IsPlan   = :IsPlan'
      ''
      ''
      'select * '
      '      , '#39#39' Sep      '
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
      end
      item
        Name = 'ISPLAN'
        ParamType = ptInput
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
    object qShipmentsReceiptDate: TSQLTimeStampField
      FieldName = 'ReceiptDate'
      OnGetText = qShipmentsReceiptDateGetText
    end
    object qShipmentsReceiptDate2: TSQLTimeStampField
      FieldName = 'ReceiptDate2'
    end
    object qShipmentsFlag: TIntegerField
      FieldName = 'Flag'
    end
    object qShipmentsSep: TStringField
      FieldName = 'Sep'
      Size = 1
    end
  end
  object dsShipments: TDataSource
    DataSet = qShipments
    Left = 802
    Top = 397
  end
  object actMain: TUniActionList
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
    object actLegend: TAction
      Category = 'Action'
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077
      ImageIndex = 2
      OnExecute = actLegendExecute
    end
  end
  object ImageList: TUniNativeImageList
    Left = 520
    Top = 352
    Images = {
      01000000FFFFFF1F057E04000000000100010010102000000000006804000016
      0000002800000010000000200000000100200000000000000400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000006A6A6AEF717171FF71
      7171FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF6B
      6B6BF10000000000000000000000000000000000000000717171FF0000000000
      0000000000000000000000000000000000000000000000000000000000000071
      7171FF0000000000000000000000000000000000000000717171FF0000000000
      0000000000000000000000000000000000000000000000000000000000000071
      7171FF0000000000000000000000000000000000000000717171FF0000000000
      0000000000000000000000000000000000000000000000000000000000000071
      7171FF0000000000000000000000000000000000000000717171FF0000000000
      0000000000000000000000000000000000000000000000000000000000000071
      7171FF000000000000000000000000548A06F2589106FF589106FF589106FF58
      9106FF589106FF589106FF589106FF538B06F4578E06FC589106FF589106FF58
      9106FF589106FF538B06F400000000589106FF1D3001553B6104AD192B024C42
      6B03BC090D00181B2D01502A47027D2035025D0E18002A3A5F05A7111D013445
      7204C81524013F589006FE00000000589106FF508205E70E18002A1D31025758
      9106FF0D170028589106FF589106FF3C6304B00A130121457204C9294502780B
      11011E487705D1589106FF00000000589106FF4F8105E50C1601261E32025758
      9106FF0D170028589106FF446F04C50D1700294D7E05E0569006FD264003710A
      120121487705D1589106FF00000000589106FF2A450279365A039F233A036645
      7206C91A2A024A589106FF508606EB192A0149192A01493F6704B61320023947
      7705D21E320258589106FF00000000538806F0589106FF589106FF589106FF58
      9106FF589106FF589106FF589106FF589106FF589106FF589106FF589106FF58
      9106FF589106FF548A06F2000000000000000000000000717171FF0000000000
      0000000000000000000000000000000000000000000000000000000000000071
      7171FF0000000000000000000000000000000000000000717171FF0000000000
      0000000000000000000000000000000000000000000000000000000000000071
      7171FF0000000000000000000000000000000000000000696969ED717171FF71
      7171FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF6A
      6A6AEF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000E0030000EFFB0000EFFB0000EFFB0000EF
      FB0000800000008000000080000000800000008000000080000000EFFB0000EF
      FB0000E0030000FFFF0000}
  end
end
