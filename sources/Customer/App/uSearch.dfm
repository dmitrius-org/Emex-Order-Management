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
    Height = 49
    Hint = ''
    Align = alTop
    TabOrder = 0
    BorderStyle = ubsNone
    ShowCaption = False
    Caption = 'TopPanel'
    LayoutConfig.Padding = '5'
    LayoutConfig.Width = '0'
    OnClick = TopPanelClick
    object btnSearch: TUniButton
      AlignWithMargins = True
      Left = 1138
      Top = 5
      Width = 106
      Height = 39
      Hint = ''
      Margins.Top = 5
      Margins.Bottom = 5
      Caption = #1053#1072#1081#1090#1080
      Align = alRight
      TabOrder = 2
      ScreenMask.ShowMessage = False
      ScreenMask.Color = clHighlight
      OnClick = btnSearchClick
    end
    object edtSearch: TUniComboBox
      AlignWithMargins = True
      Left = 3
      Top = 5
      Width = 1017
      Height = 39
      Hint = ''
      Margins.Top = 5
      Margins.Bottom = 5
      MaxLength = 40
      Text = ''
      Align = alClient
      TabOrder = 1
      EmptyText = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
      MinQueryLength = 0
      RemoteFilter = False
      RemoteQueryCache = False
      LayoutConfig.Height = '30'
      HideTrigger = True
      IconItems = <>
      OnKeyDown = edtSearchKeyDown
      OnClick = edtSearchClick
      OnRemoteQuery = edtSearchRemoteQuery
    end
    object btnRefresh: TUniButton
      AlignWithMargins = True
      Left = 1026
      Top = 5
      Width = 106
      Height = 39
      Hint = ''
      Margins.Top = 5
      Margins.Bottom = 5
      Visible = False
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Align = alRight
      TabOrder = 3
      ScreenMask.ShowMessage = False
      ScreenMask.Color = clHighlight
      OnClick = btnRefreshClick
    end
  end
  object MainPanel: TUniPanel
    Left = 0
    Top = 49
    Width = 1247
    Height = 569
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
      Height = 569
      Hint = ''
      ClientEvents.ExtEvents.Strings = (
        
          'beforeedit=function beforeedit(editor, context, eOpts)'#13#10'{'#13#10'  if ' +
          '(context.colIdx==4 && context.rowIdx == 0){'#13#10'     ajaxRequest(th' +
          'is, '#39'VKGPanelLeft'#39', ['#39'VKGPanelLeft='#39' + context.cell.offsetLeft])' +
          ';'#13#10'  } '#13#10#13#10'  return (context.rowIdx == 0);'#13#10'  '#13#10'}'
        
          'click=function click(sender, eOpts)'#13#10'{'#13#10'  if (SearchF.MakeLogoPa' +
          'nel.isVisible()){'#13#10'    ajaxRequest(this, '#39'MakeLogoPanelVisibleFa' +
          'lse'#39', []);'#13#10'  }  '#13#10'  '#13#10'  if (SearchF.VKGPanel.isVisible()){'#13#10'   ' +
          ' ajaxRequest(this, '#39'VKGPanelVisibleFalse'#39', []);'#13#10'  }  '#13#10'}'
        
          'reconfigure=function reconfigure(sender, store, columns, oldStor' +
          'e, oldColumns, eOpts) {'#13#10'    var startCol = 0; // zero based'#13#10'  ' +
          '  '#13#10'    // '#1059#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1077#1084' '#1088#1077#1085#1076#1077#1088#1077#1088' '#1076#1083#1103' '#1087#1077#1088#1074#1086#1081' '#1082#1086#1083#1086#1085#1082#1080#13#10'    column' +
          's[startCol].renderer = function(value, metaData, record) {'#13#10#13#10'  ' +
          '      if (record.id !== 0) {  // '#1055#1088#1086#1087#1091#1089#1090#1080#1090#1100' '#1087#1077#1088#1074#1091#1102' '#1089#1090#1088#1086#1082#1091#13#10'     ' +
          '       metaData.tdCls = '#39'span-columns'#39';'#13#10'            metaData.td' +
          'Attr = '#39'colspan=6'#39';'#13#10'            '#13#10'            if (record.id == ' +
          '1){'#13#10'                return `'#13#10'                       <form meth' +
          'od="post" action="" id="makereplacement">'#13#10'                     ' +
          '     <span class="makelogo-caret-down">'#13#10'                       ' +
          '        <a>'#13#10'                               <button type="button' +
          '" onclick="setMakelogo()" class="makelogo-label" data-tabindex-v' +
          'alue="none" tabindex="-1" data-tabindex-counter="1">'#1048#1084#1077#1102#1090#1089#1103' '#1079#1072#1084#1077 +
          #1085#1099'</button>'#13#10'                               </a>'#13#10'              ' +
          '            </span>'#13#10'                       </form>'#13#10'           ' +
          '     `;'#13#10'            }            '#13#10'            else {'#13#10'        ' +
          '        return '#39#39';'#13#10'            }'#13#10'        }'#13#10'        return val' +
          'ue;'#13#10'    };'#13#10'    '#13#10'    startCol += 1;'#13#10'    '#13#10'    for (let i = st' +
          'artCol; i < 6; i++) {  '#13#10'        if (columns[i].widget) {'#13#10'     ' +
          '       columns[i].onWidgetAttach = function(column, widget, reco' +
          'rd) {'#13#10'                if (record.id !== 0) {  // '#1055#1088#1086#1087#1091#1089#1090#1080#1090#1100' '#1087#1077#1088 +
          #1074#1091#1102' '#1089#1090#1088#1086#1082#1091#13#10'                    widget.element.up('#39'td'#39').addCls('#39 +
          'hide-column'#39');'#13#10'                }'#13#10'            };'#13#10'        } els' +
          'e {'#13#10'            columns[i].renderer = function(value, metaData,' +
          ' record) {'#13#10'                if (record.id !== 0) {  // '#1055#1088#1086#1087#1091#1089#1090#1080#1090 +
          #1100' '#1087#1077#1088#1074#1091#1102' '#1089#1090#1088#1086#1082#1091#13#10'                    metaData.tdCls = '#39'hide-colu' +
          'mn'#39';'#13#10'                    return '#39#39';'#13#10'                }         ' +
          '   '#13#10'                return value;'#13#10'            };'#13#10'        }'#13#10' ' +
          '   }'#13#10'}'#13#10)
      ClientEvents.UniEvents.Strings = (
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
          'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
          'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
          'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
          't.body.removeChild(el);'#13#10'    };        '#13#10#13#10#13#10'}')
      ClicksToEdit = 1
      DataSource = DataSource
      Options = [dgEditing, dgTitles, dgColumnResize, dgTitleClick]
      WebOptions.Paged = False
      WebOptions.PageSize = 1000
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      WebOptions.RetainCursorOnSort = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Color = clInactiveCaption
      EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093
      ForceFit = True
      EnableColumnHide = False
      LayoutConfig.ComponentCls = 'grid-search'
      BorderStyle = ubsNone
      Align = alClient
      TabOrder = 0
      ParentColor = False
      Color = clBtnFace
      PreventWrap = True
      OnKeyDown = SearchGridKeyDown
      OnAjaxEvent = SearchGridAjaxEvent
      OnCellClick = SearchGridCellClick
      OnColumnSort = SearchGridColumnSort
      OnDblClick = SearchGridDblClick
      OnCellContextClick = SearchGridCellContextClick
      OnDrawColumnCell = SearchGridDrawColumnCell
      OnAfterLoad = SearchGridAfterLoad
      Columns = <
        item
          FieldName = 'MakeName'
          Title.Alignment = taCenter
          Title.Caption = #1041#1088#1077#1085#1076
          Title.Font.Height = -13
          Width = 166
          Alignment = taCenter
          ReadOnly = True
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
          ReadOnly = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          ShowToolTip = True
          FieldName = 'PartNameRus'
          Title.Alignment = taCenter
          Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          Title.Font.Height = -13
          Width = 325
          Alignment = taCenter
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'Weight'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089
          Title.Font.Height = -13
          Width = 83
          Editor = edtWeight
        end
        item
          FieldName = 'VolumeAdd'
          Title.Alignment = taCenter
          Title.Caption = #1054#1073#1098#1077#1084
          Title.Font.Height = -13
          Width = 85
          Editor = edtVolumeAdd
        end
        item
          FieldName = 'DeliveryType'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1089#1090#1072#1074#1082#1072
          Title.Font.Height = -13
          Width = 100
          Alignment = taCenter
          ReadOnly = True
          ImageOptions.Visible = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'OurDelivery'
          Title.Alignment = taCenter
          Title.Caption = #1057#1088#1086#1082' '#1076#1086#1089#1090#1072#1074#1082#1080
          Title.Font.Height = -13
          Width = 142
          ReadOnly = True
          Sortable = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'PercentSupped'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1087#1086#1089#1090#1072#1074#1082#1080
          Title.Font.Height = -13
          Width = 175
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
          Width = 100
          ReadOnly = True
          Sortable = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'Packing'
          Title.Alignment = taCenter
          Title.Caption = #1042' '#1091#1087#1072#1082#1086#1074#1082#1077
          Title.Font.Height = -13
          Width = 90
          ReadOnly = True
        end
        item
          FieldName = 'Available'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1083#1080#1095#1080#1077
          Title.Font.Height = -13
          Width = 100
          ReadOnly = True
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
          ShowToolTipAlways = False
          Title.Caption = ' '
          Title.Font.Height = -13
          Width = 90
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
      object UniComboBox1: TUniComboBox
        Left = 12
        Top = 96
        Width = 145
        Height = 23
        Hint = ''
        Text = 'UniComboBox1'
        Items.Strings = (
          '1'
          '2'
          '3'
          '4')
        TabOrder = 2
        IconItems = <>
      end
      object UniCheckBox1: TUniCheckBox
        Left = 32
        Top = 144
        Width = 97
        Height = 17
        Hint = ''
        Caption = 'UniCheckBox1'
        TabOrder = 3
      end
      object edtWeight: TUniFormattedNumberEdit
        Left = 15
        Top = 168
        Width = 121
        Hint = ''
        FormattedInput.DefaultCurrencySign = False
        TabOrder = 4
        DecimalPrecision = 3
        DecimalSeparator = ','
        ThousandSeparator = #160
      end
      object edtVolumeAdd: TUniFormattedNumberEdit
        Left = 15
        Top = 192
        Width = 121
        Hint = ''
        FormattedInput.DefaultCurrencySign = False
        TabOrder = 5
        DecimalPrecision = 3
        DecimalSeparator = ','
        ThousandSeparator = #160
      end
    end
    object MakeLogoPanel: TUniContainerPanel
      Left = 3
      Top = 56
      Width = 705
      Height = 177
      Hint = ''
      Visible = False
      ParentColor = False
      TabOrder = 2
      ScrollDirection = sdVertical
      object MakeLogoGrid: TUniDBGrid
        Left = 0
        Top = 0
        Width = 705
        Height = 177
        Hint = ''
        DataSource = dsMakeLogo
        Options = [dgRowSelect]
        WebOptions.Paged = False
        WebOptions.CustomizableCells = False
        LoadMask.Message = 'Loading data...'
        ForceFit = True
        EnableColumnHide = False
        Align = alClient
        ParentFont = False
        TabOrder = 1
        ParentColor = False
        Color = clBtnFace
        PreventWrap = True
        OnDblClick = MakeLogoGridDblClick
        Columns = <
          item
            ShowToolTip = True
            FieldName = 'MakeName'
            Title.Caption = 'MakeName'
            Width = 120
            Alignment = taCenter
          end
          item
            FieldName = 'DetailNum'
            Title.Caption = 'DetailNum'
            Width = 120
            Alignment = taCenter
          end
          item
            FieldName = 'PartNameRus'
            Title.Caption = 'PartNameRus'
            Width = 155
            Alignment = taCenter
          end
          item
            FieldName = 'PriceRub'
            Title.Caption = 'PriceRub'
            Title.Font.Style = [fsBold]
            Width = 125
          end>
      end
    end
    object VKGPanel: TUniGroupBox
      AlignWithMargins = True
      Left = 795
      Top = 56
      Width = 126
      Height = 169
      Hint = 
        '|('#1044#1083#1080#1085#1072' (1-'#1103' '#1075#1088#1072#1092#1072') '#1061' '#1064#1080#1088#1080#1085#1072' (2-'#1103' '#1075#1088#1072#1092#1072') '#1061' '#1042#1099#1089#1086#1090#1072' (3-'#1103' '#1075#1088#1072#1092#1072')) /' +
        ' 5000'#13#10#1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1086#1082#1088#1091#1075#1083#1103#1077#1084' '#1076#1086' '#1076#1077#1089#1103#1090#1099#1093' '
      Visible = False
      ShowHint = True
      ParentShowHint = False
      Caption = #1054#1073#1098#1105#1084#1085#1099#1081' '#1074#1077#1089
      Layout = 'vbox'
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'start'
      LayoutAttribs.Padding = '1'
      LayoutConfig.Padding = '0'
      LayoutConfig.Margin = '0'
      TabOrder = 3
      object edtL: TUniFormattedNumberEdit
        Left = 3
        Top = 15
        Width = 121
        Hint = ''
        ShowHint = True
        FormattedInput.DefaultCurrencySign = False
        TabOrder = 2
        FieldLabel = 'L'
        FieldLabelWidth = 20
        DecimalSeparator = ','
        ThousandSeparator = #160
        OnChange = edtLChange
      end
      object edtW: TUniFormattedNumberEdit
        Left = 3
        Top = 39
        Width = 121
        Hint = ''
        ShowHint = True
        FormattedInput.DefaultCurrencySign = False
        TabOrder = 3
        FieldLabel = 'W'
        FieldLabelWidth = 20
        DecimalSeparator = ','
        ThousandSeparator = #160
        OnChange = edtLChange
      end
      object edtH: TUniFormattedNumberEdit
        Left = 3
        Top = 63
        Width = 121
        Hint = ''
        ShowHint = True
        FormattedInput.DefaultCurrencySign = False
        TabOrder = 4
        FieldLabel = 'H'
        FieldLabelWidth = 20
        DecimalSeparator = ','
        ThousandSeparator = #160
        OnChange = edtLChange
      end
      object edtVKG: TUniFormattedNumberEdit
        Left = 3
        Top = 90
        Width = 121
        Hint = ''
        ShowHint = True
        FormattedInput.DefaultCurrencySign = False
        TabOrder = 5
        FieldLabel = 'VKG'
        FieldLabelWidth = 30
        DecimalPrecision = 3
        DecimalSeparator = ','
        ThousandSeparator = #160
        OnChange = edtVKGChange
      end
      object VolumeSave: TUniButton
        AlignWithMargins = True
        Left = 6
        Top = 118
        Width = 106
        Height = 25
        Hint = ''
        Margins.Top = 15
        Enabled = False
        ShowHint = True
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        TabOrder = 1
        ScreenMask.ShowMessage = False
        ScreenMask.Color = clHighlight
        LayoutConfig.Margin = '3'
        OnClick = VolumeSaveClick
      end
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 648
    Top = 245
  end
  object Query: TFDQuery
    BeforeOpen = QueryBeforeOpen
    AfterOpen = QueryAfterOpen
    IndexFieldNames = 'ID'
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evItems, evAutoFetchAll]
    FetchOptions.Items = []
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.AutoIncFields = 'ID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'Select *'
      '  from vFindByNumber'
      ' where MakeName  = :MakeName '
      '   and DetailNum = :DetailNum'
      '   and ProfilesCustomerID = :ProfilesCustomerID  '
      '   '
      'order by N  '
      ''
      '')
    Left = 576
    Top = 255
    ParamData = <
      item
        Name = 'MAKENAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DETAILNUM'
        ParamType = ptInput
      end
      item
        Name = 'PROFILESCUSTOMERID'
        ParamType = ptInput
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
      ReadOnly = True
      OnGetText = QueryMakeNameGetText
      Size = 64
    end
    object QueryDetailNum: TWideStringField
      FieldName = 'DetailNum'
      Origin = 'DetailNum'
      ReadOnly = True
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
    object QueryPercentSupped: TIntegerField
      FieldName = 'PercentSupped'
      Origin = 'PercentSupped'
      ReadOnly = True
      OnGetText = QueryPercentSuppedGetText
    end
    object QueryPrice: TCurrencyField
      FieldName = 'PriceRub'
      Origin = 'PriceRub'
      ReadOnly = True
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryWeight: TCurrencyField
      FieldName = 'Weight'
      DisplayFormat = '###,##0.000'
    end
    object QueryVolumeAdd: TCurrencyField
      FieldName = 'VolumeAdd'
      DisplayFormat = '###,##0.00'
      MaxValue = 1000.000000000000000000
    end
    object QueryOurDelivery: TIntegerField
      FieldName = 'OurDelivery'
      Origin = 'OurDelivery'
      ReadOnly = True
      OnGetText = QueryOurDeliveryGetText
    end
    object QueryOurDeliverySTR: TWideStringField
      FieldName = 'OurDeliverySTR'
      ReadOnly = True
      Size = 256
    end
    object QueryPriceLogo: TWideStringField
      FieldName = 'PriceLogo'
      Size = 128
    end
    object QueryPacking: TIntegerField
      FieldName = 'Packing'
      ReadOnly = True
    end
    object QueryAvailable: TIntegerField
      FieldName = 'Available'
      OnGetText = QueryAvailableGetText
    end
    object QueryMakeLogo: TWideStringField
      FieldName = 'MakeLogo'
      Size = 30
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
      'select top 10 DetailNum '
      '  from vSearchHistory '
      ' where ClientID  = :ClientID'
      ' order by SearchHistoryID desc')
    Left = 767
    Top = 220
    ParamData = <
      item
        Name = 'CLIENTID'
        ParamType = ptInput
      end>
  end
  object qMakeLogo: TFDQuery
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
      'select p.MakeName,'
      '       p.DetailNum,'
      '       p.PartNameRus,'
      
        '       min(p.PriceRub) PriceRub -- '#1094#1077#1085#1072' '#1076#1077#1090#1072#1083#1080', '#1087#1086#1082#1072#1079#1072#1074#1072#1077#1084#1072#1103' '#1085#1072' ' +
        #1089#1072#1081#1090#1077'     '
      '  from vFindByNumber p '
      ' where 1=1 --p.MakeName       <> :MakeName '
      '   and p.ProfilesCustomerID = :ProfilesCustomerID  '
      ' group by p.MakeName, '
      '          p.DetailNum, '
      '          p.PartNameRus'
      ' order by case'
      '            when p.DetailNum = :DetailNum then 1'
      '            else 2'
      '          end '
      '         ,case'
      '            when p.MakeName = :MakeName then 1'
      '            else 2'
      '          end '
      '         ,PriceRub'
      ''
      '')
    Left = 679
    Top = 359
    ParamData = <
      item
        Name = 'PROFILESCUSTOMERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DETAILNUM'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MAKENAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object WideStringField1: TWideStringField
      FieldName = 'MakeName'
      Origin = 'MakeName'
      Size = 64
    end
    object WideStringField2: TWideStringField
      FieldName = 'DetailNum'
      Origin = 'DetailNum'
      Size = 64
    end
    object qMakeLogoPriceRub: TCurrencyField
      FieldName = 'PriceRub'
      Origin = 'PriceRub'
      DisplayFormat = #1086#1090' ###,##0 '#1088#1091#1073
    end
    object WideStringField3: TWideStringField
      FieldName = 'PartNameRus'
      Origin = 'PartNameRus'
      Size = 256
    end
  end
  object dsMakeLogo: TDataSource
    DataSet = qMakeLogo
    Left = 760
    Top = 357
  end
  object UpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    ModifySQL.Strings = (
      'select 1')
    DeleteSQL.Strings = (
      
        'Delete tBasket from tBasket (rowlock) where BasketID=:OLD_Basket' +
        'ID')
    FetchRowSQL.Strings = (
      'select *'
      '  from pFindByNumber (nolock)'
      ' where spid = @@spid'
      '   and ID   = :ID')
    Left = 497
    Top = 254
  end
end
