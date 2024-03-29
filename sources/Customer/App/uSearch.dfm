object SearchF: TSearchF
  Left = 0
  Top = 0
  Width = 1247
  Height = 618
  Margins.Left = 100
  Margins.Right = 100
  OnCreate = UniFrameCreate
  OnDestroy = UniFrameDestroy
  OnReady = UniFrameReady
  Layout = 'fit'
  LayoutConfig.IgnorePosition = False
  LayoutConfig.Width = '0'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  TabOrder = 0
  ParentColor = False
  ParentBackground = False
  object TopPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 1247
    Height = 55
    Hint = ''
    Align = alTop
    TabOrder = 0
    BorderStyle = ubsNone
    ShowCaption = False
    Caption = 'TopPanel'
    LayoutConfig.Width = '0'
    DesignSize = (
      1247
      55)
    object btnSearch: TUniButton
      Left = 1127
      Top = 12
      Width = 106
      Height = 30
      Hint = ''
      Caption = #1053#1072#1081#1090#1080
      Anchors = [akTop, akRight]
      TabOrder = 1
      ScreenMask.Message = #1054#1087#1077#1088#1072#1094#1080#1103' '#1074#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103
      ScreenMask.Target = Owner
      ScreenMask.Color = clMoneyGreen
      OnClick = btnSearchClick
    end
    object edtSearch: TUniComboBox
      Left = 12
      Top = 12
      Width = 1102
      Height = 30
      Hint = ''
      MaxLength = 40
      Text = ''
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      EmptyText = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
      MinQueryLength = 2
      RemoteQuery = True
      LayoutConfig.Height = '30'
      Images = UniImageList1
      HideTrigger = True
      IconItems = <>
      OnKeyDown = edtSearchKeyDown
      OnRemoteQuery = edtSearchRemoteQuery
    end
  end
  object MainPanel: TUniPanel
    Left = 0
    Top = 55
    Width = 1247
    Height = 563
    Hint = ''
    Align = alClient
    TabOrder = 1
    BorderStyle = ubsNone
    ShowCaption = False
    Caption = 'MainPanel'
    LayoutConfig.Width = '0'
    object SearchGrid: TUniDBGrid
      Left = 0
      Top = 0
      Width = 1247
      Height = 563
      Hint = ''
      ClientEvents.UniEvents.Strings = (
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
          'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
          'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
          'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
          't.body.removeChild(el);'#13#10'    };'#13#10'    '#13#10'  config.updateRowSpan = ' +
          'function() {'#13#10'        var columns = sender.getColumns(),'#13#10'      ' +
          '  view = sender.getView(),'#13#10'        store = sender.getStore(),'#13#10 +
          '        rowCount = store.getCount();'#13#10'        //console.log(colu' +
          'mns);  '#13#10'        for (var col = 0; col < columns.length; ++col) ' +
          '{     '#13#10'            var colIndx = col; // second column for exam' +
          'ple'#13#10'            var column = columns[colIndx];'#13#10'            var' +
          ' dataIndex = column.dataIndex,'#13#10'            spanCell = null,'#13#10'  ' +
          '          spanCount = null,'#13#10'            spanValue = null;'#13#10'    ' +
          '        '#13#10'            for (var row = 0; row < rowCount; ++row) {' +
          #13#10'                var cell = view.getCellByPosition({ row: row, ' +
          'column: colIndx }).dom,'#13#10'                record = store.getAt(ro' +
          'w),'#13#10'                value = record.get(dataIndex);'#13#10#13#10'         ' +
          '       if (col < 5) {'#13#10'                    if (spanValue != valu' +
          'e) {'#13#10'                        if (spanCell !== null) {'#13#10'        ' +
          '                    spanCell.rowSpan = spanCount;'#13#10'             ' +
          '           }'#13#10#13#10'                        Ext.fly(cell).query('#39'.x-' +
          'grid-cell-inner'#39')[0].style.display='#39#39';'#13#10'                        ' +
          'spanCell = cell;'#13#10'                        spanCount = 1;'#13#10'      ' +
          '                  spanValue = value;'#13#10'                    } else' +
          ' {'#13#10'                        spanCount++;'#13#10'                    //' +
          '  Ext.fly(cell).setStyle('#39'display'#39', '#39'none'#39');     '#13#10'             ' +
          '           Ext.fly(cell).query('#39'.x-grid-cell-inner'#39')[0].style.di' +
          'splay='#39'none'#39';'#13#10'                    }'#13#10'                }'#13#10'       ' +
          '         else {'#13#10'                '#13#10'                    if (row =' +
          '= 0) {'#13#10'                        Ext.fly(cell).query('#39'.x-grid-cel' +
          'l-inner'#39')[0].style.display='#39#39#13#10'                    }'#13#10'          ' +
          '          else { '#13#10'                '#13#10'                        Ext' +
          '.fly(cell).setStyle('#39'border-style'#39', '#39'solid'#39');'#13#10'                 ' +
          '       Ext.fly(cell).setStyle('#39'border-width'#39', '#39'1px 0 0'#39');'#13#10'     ' +
          '                   Ext.fly(cell).setStyle('#39'border-color'#39', '#39'#cfcf' +
          'cf'#39');  '#13#10'                    }'#13#10'                }  //if (col < 4' +
          ') {'#13#10'                '#13#10'            }'#13#10'            '#13#10'            ' +
          'if (spanCell !== null) {'#13#10'                spanCell.rowSpan = spa' +
          'nCount;'#13#10'            }'#13#10'        };'#13#10#13#10'    }; '#13#10'}'
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  sender.getView().' +
          'on('#39'refresh'#39', sender.updateRowSpan, sender);'#13#10'}')
      DataSource = DataSource
      Options = [dgTitles, dgColumnResize, dgTabs, dgDontShowSelected]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.CustomizableCells = False
      WebOptions.FetchAll = True
      LoadMask.WaitData = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093
      LoadMask.Color = clInactiveCaption
      EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093
      EnableColumnHide = False
      LayoutConfig.ComponentCls = 'grid-search'
      BorderStyle = ubsNone
      StripeRows = False
      Align = alClient
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      OnKeyDown = SearchGridKeyDown
      OnAjaxEvent = SearchGridAjaxEvent
      OnCellClick = SearchGridCellClick
      OnColumnSort = SearchGridColumnSort
      OnDblClick = SearchGridDblClick
      OnCellContextClick = SearchGridCellContextClick
      Columns = <
        item
          FieldName = 'MakeName'
          Title.Alignment = taCenter
          Title.Caption = #1041#1088#1077#1085#1076
          Title.Font.Height = -13
          Width = 166
          Alignment = taCenter
          MemoOptions.ConvertNewLineToBreak = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'DetailNum'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
          Title.Font.Height = -13
          Width = 149
          Alignment = taCenter
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'PartNameRus'
          Title.Alignment = taCenter
          Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          Title.Font.Height = -13
          Width = 364
          Alignment = taCenter
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'Weight'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089
          Title.Font.Height = -13
          Width = 64
        end
        item
          FieldName = 'VolumeAdd'
          Title.Alignment = taCenter
          Title.Caption = #1054#1073#1098#1077#1084
          Title.Font.Height = -13
          Width = 64
        end
        item
          FieldName = 'DeliveryType'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1089#1090#1072#1074#1082#1072
          Title.Font.Height = -13
          Width = 97
          Alignment = taCenter
          ReadOnly = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'Delivery'
          Title.Alignment = taCenter
          Title.Caption = #1057#1088#1086#1082' '#1076#1086#1089#1090#1072#1074#1082#1080
          Title.Font.Height = -13
          Width = 109
          Sortable = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'Rating'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1087#1086#1089#1090#1072#1074#1082#1080
          Title.Font.Height = -13
          Width = 170
          Alignment = taCenter
          ReadOnly = True
          Sortable = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'PriceRub'
          Title.Alignment = taCenter
          Title.Caption = #1062#1077#1085#1072
          Title.Font.Height = -13
          Width = 115
          Sortable = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'Available'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1083#1080#1095#1080#1077
          Title.Font.Height = -13
          Width = 76
          Alignment = taRightJustify
          Sortable = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          ActionColumn.Buttons = <
            item
              ButtonId = 0
            end>
          WidgetColumn.Enabled = True
          WidgetColumn.Widget = btnAddBasket
          WidgetColumn.Height = 26
          Title.Caption = ' '
          Title.Font.Height = -13
          Width = 120
          Alignment = taCenter
        end>
    end
    object UniHiddenPanel1: TUniHiddenPanel
      Left = 424
      Top = 275
      Width = 160
      Height = 256
      Hint = ''
      Visible = True
      object btnAddBasket: TUniButtonWidget
        AlignWithMargins = True
        Left = 17
        Top = 29
        Width = 120
        Height = 22
        Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1077#1090#1072#1083#1100' '#1074' '#1082#1086#1088#1079#1080#1085#1091
        Margins.Top = 5
        Margins.Bottom = 5
        ShowHint = True
        ParentShowHint = False
        ShowCaption = True
        ShowValue = False
        OnClick = btnAddBasketClick
        Caption = #1042' '#1082#1086#1088#1079#1080#1085#1091
      end
    end
  end
  object UniImageList1: TUniImageList
    Left = 809
    Top = 429
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 648
    Top = 245
  end
  object Query: TFDQuery
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evItems, evAutoFetchAll]
    FetchOptions.Items = []
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    SQL.Strings = (
      'Select *'
      '  from vFindByNumber'
      ' where DestinationLogo = :DestinationLogo  '
      'order by N  '
      ''
      '')
    Left = 575
    Top = 255
    ParamData = <
      item
        Name = 'DESTINATIONLOGO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object QueryID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QueryMakeName: TWideStringField
      FieldName = 'MakeName'
      Origin = 'MakeName'
      Size = 64
    end
    object QueryDetailNum: TWideStringField
      FieldName = 'DetailNum'
      Origin = 'DetailNum'
      Size = 64
    end
    object QueryPartNameRus: TWideStringField
      FieldName = 'PartNameRus'
      Origin = 'PartNameRus'
      Size = 256
    end
    object QueryDeliveryType: TIntegerField
      FieldName = 'DeliveryType'
      Origin = 'DeliveryType'
      ReadOnly = True
      Required = True
      OnGetText = QueryDeliveryTypeGetText
    end
    object QueryDelivery: TIntegerField
      FieldName = 'Delivery'
      Origin = 'Delivery'
    end
    object QueryPercentSupped: TIntegerField
      FieldName = 'PercentSupped'
      Origin = 'PercentSupped'
    end
    object QueryPrice: TCurrencyField
      FieldName = 'PriceRub'
      Origin = 'PriceRub'
    end
    object QueryAvailable: TWideStringField
      FieldName = 'Available'
      Origin = 'Available'
      Size = 128
    end
    object QueryRating: TStringField
      FieldName = 'Rating'
      Size = 1048
    end
    object QueryWeight: TCurrencyField
      FieldName = 'Weight'
      DisplayFormat = '###,##0.000'
    end
    object QueryVolumeAdd: TCurrencyField
      FieldName = 'VolumeAdd'
      DisplayFormat = '###,##0.00'
    end
  end
  object qSearchHistory: TFDQuery
    AutoCalcFields = False
    Filtered = True
    FilterOptions = [foCaseInsensitive]
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'select top 20 *'
      '  from tSearchHistory sh with (nolock index=ao1)'
      ' where sh.ClientID  = :ClientID'
      '   --and sh.DetailNum = :DetailNum')
    Left = 767
    Top = 220
    ParamData = <
      item
        Name = 'CLIENTID'
        ParamType = ptInput
      end>
  end
end
