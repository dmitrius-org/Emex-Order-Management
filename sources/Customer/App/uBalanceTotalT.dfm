object BalanceTotalT: TBalanceTotalT
  Left = 0
  Top = 0
  Width = 1354
  Height = 480
  Layout = 'fit'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  TabOrder = 0
  object pnlOrder: TUniPanel
    Left = 0
    Top = 0
    Width = 1354
    Height = 480
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
      Left = 0
      Top = 0
      Width = 1354
      Height = 480
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
      LayoutConfig.ComponentCls = 'grid-balance-totall'
      LayoutConfig.Height = '100'
      LayoutConfig.Width = '100'
      BorderStyle = ubsNone
      TrackOver = False
      Align = alClient
      Anchors = []
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      DragDrop.PromptDrop = False
      RowWidget.DestroyOnCollapse = False
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
          Width = 100
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
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 648
    Top = 253
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
    Left = 577
    Top = 255
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
end
