object ShipmentsT: TShipmentsT
  Left = 0
  Top = 0
  Width = 1402
  Height = 596
  Margins.Bottom = 0
  OnCreate = UniFrameCreate
  OnDestroy = UniFrameDestroy
  OnReady = UniFrameReady
  Layout = 'fit'
  LayoutConfig.IgnorePosition = False
  LayoutConfig.Width = '0'
  LayoutConfig.DockWhenAligned = False
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  ShowHint = True
  ParentShowHint = False
  TabOrder = 0
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1396
    Height = 46
    Hint = ''
    Visible = False
    ShowHint = True
    Align = alTop
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    Color = clBtnShadow
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'auto'
    LayoutAttribs.Align = 'top'
    LayoutAttribs.Pack = 'start'
    LayoutConfig.IgnorePosition = False
    LayoutConfig.Height = '0'
    LayoutConfig.Width = '100'
    object ToolBar: TUniToolBar
      AlignWithMargins = True
      Left = 3
      Top = 0
      Width = 1393
      Height = 46
      Hint = ''
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ShowHint = True
      ButtonHeight = 37
      ButtonWidth = 146
      ShowCaptions = True
      ButtonAutoWidth = True
      LayoutConfig.IgnorePosition = False
      LayoutConfig.Width = '100'
      LayoutConfig.DockWhenAligned = False
      Layout = 'hbox'
      Align = alClient
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      OverflowHandler = ohMenu
    end
  end
  object UniPanel2: TUniPanel
    Left = 0
    Top = 52
    Width = 1402
    Height = 544
    Hint = ''
    Margins.Bottom = 0
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
    object Grid: TUniDBGrid
      Left = 0
      Top = 78
      Width = 1402
      Height = 466
      Hint = ''
      Margins.Bottom = 0
      ShowHint = True
      BodyRTL = False
      ClientEvents.ExtEvents.Strings = (
        'afterrender=function afterrender(sender, eOpts) {'#13#10#13#10'}'#13#10
        
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
          'n the ToolBar, number 10, hide him'#13#10'}'
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
          'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
          'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
          'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
          't.body.removeChild(el);'#13#10'    };     '#13#10'}'#13#10#13#10
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'  config.displayInfo=true;'#13#10'}')
      HeaderTitleAlign = taCenter
      PagingBarAuxControl = pnlGridSelectedCount
      DataSource = DataSource
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgRowSelect, dgCheckSelect, dgCheckSelectCheckOnly, dgAlwaysShowSelection, dgMultiSelect, dgTabs, dgCancelOnExit, dgDontShowSelected, dgRowNumbers]
      WebOptions.PageSize = 500
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      Grouping.ShowCaption = False
      Grouping.ShowValue = False
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Color = 13421772
      EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
      LayoutConfig.ComponentCls = 'grid-shipments'
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
      OnAjaxEvent = GridAjaxEvent
      OnSelectionChange = GridSelectionChange
      OnColumnSort = GridColumnSort
      OnColumnMove = GridColumnMove
      OnCellContextClick = GridCellContextClick
      OnDrawColumnCell = GridDrawColumnCell
      OnColumnResize = GridColumnResize
      Columns = <
        item
          FieldName = 'ShipmentsID'
          Title.Alignment = taCenter
          Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
          Width = 118
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'Flag'
          Title.Caption = ' '
          Width = 64
          Alignment = taLeftJustify
          ReadOnly = True
        end
        item
          FieldName = 'StatusName'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'SupplierBrief'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
          Width = 165
          ReadOnly = True
          Hint = #1055#1086#1089#1090#1072#1074#1097#1080#1082'. '#1040#1082#1082#1072#1091#1085#1090' '#1080#1079' '#1082#1086#1090#1086#1088#1086#1075#1086' '#1089#1076#1077#1083#1072#1085#1072' '#1086#1090#1075#1088#1091#1079#1082#1072
          Sortable = True
        end
        item
          FieldName = 'ShipmentsDate'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1086#1090#1075#1088#1091#1079#1082#1080
          Width = 135
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'ReceiptDate'
          Title.Alignment = taCenter
          Title.Caption = #1054#1078#1080#1076#1072#1077#1084#1072#1103' '#1076#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '
          Width = 100
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'Invoice'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1080#1085#1074#1086#1081#1089#1072
          Width = 100
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'DestinationName'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087' '#1086#1090#1087#1088#1072#1074#1082#1080
          Width = 120
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'ShipmentsAmount'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1086#1090#1075#1088#1091#1079#1082#1080' ($)'
          Width = 107
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'ShipmentsAmountR'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1086#1090#1075#1088#1091#1079#1082#1080' ('#1088#1091#1073')'
          Width = 124
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'DetailCount'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1077#1090#1072#1083#1077#1081
          Width = 115
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'WeightKG'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1092#1080#1079#1080#1095#1077#1089#1082#1080#1081' ('#1087#1088#1072#1081#1089')'
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'VolumeKG'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1086#1073#1098#1077#1084' ('#1087#1088#1072#1081#1089')'
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'WeightKGDiff'
          Title.Alignment = taCenter
          Title.Caption = #1056#1072#1079#1085#1080#1094#1072' '#1089#1091#1084#1084' '#1074#1077#1089' '#1092#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1092#1072#1082#1090' '#1084#1080#1085#1091#1089' '#1074#1077#1089' '#1092#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1080#1079' '#1087#1088#1072#1081#1089#1072
          Width = 150
          ReadOnly = True
          Hint = #1056#1072#1079#1085#1080#1094#1072' '#1089#1091#1084#1084' '#1074#1077#1089' '#1092#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1092#1072#1082#1090' '#1084#1080#1085#1091#1089' '#1074#1077#1089' '#1092#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1080#1079' '#1087#1088#1072#1081#1089#1072
          Sortable = True
        end
        item
          FieldName = 'WeightKGF'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1092#1080#1079#1080#1095#1077#1089#1082#1080#1081' ('#1092#1072#1082#1090')'
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'VolumeKGF'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1086#1073#1098#1077#1084#1085#1099#1081' ('#1092#1072#1082#1090')'
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'VolumeKGDiff'
          Title.Alignment = taCenter
          Title.Caption = #1056#1072#1079#1085#1080#1094#1072' '#1089#1091#1084#1084' '#1074#1077#1089' '#1086#1073#1098#1077#1084#1085#1099#1081' '#1092#1072#1082#1090' '#1084#1080#1085#1091#1089' '#1074#1077#1089' '#1086#1073#1098#1077#1084#1085#1099#1081' '#1080#1079' '#1087#1088#1072#1081#1089#1072
          Width = 150
          ReadOnly = True
          Hint = #1056#1072#1079#1085#1080#1094#1072' '#1089#1091#1084#1084' '#1074#1077#1089' '#1086#1073#1098#1077#1084#1085#1099#1081' '#1092#1072#1082#1090' '#1084#1080#1085#1091#1089' '#1074#1077#1089' '#1086#1073#1098#1077#1084#1085#1099#1081' '#1080#1079' '#1087#1088#1072#1081#1089#1072
          Sortable = True
        end
        item
          FieldName = 'WeightKGAmount'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1082#1075' '#1092#1080#1079#1080#1095#1077#1089#1082#1086#1075#1086'  '#1074#1077#1089#1072
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'VolumeKGAmount'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1082#1075' '#1086#1073#1098#1077#1084#1085#1086#1075#1086' '#1074#1077#1089#1072
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'Amount'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1076#1086#1089#1090#1072#1074#1082#1080' ('#1087#1088#1072#1081#1089')'
          Width = 283
        end
        item
          FieldName = 'AmountF'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1076#1086#1089#1090#1072#1074#1082#1080' ('#1092#1072#1082#1090')'
          Width = 277
        end
        item
          FieldName = 'DeliverySumF'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1076#1086#1089#1090#1072#1074#1082#1080' ('#1080#1090#1086#1075')'
          Width = 150
          ReadOnly = True
          Hint = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1072#1103' '#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1080#1089#1093#1086#1076#1103' '#1080#1079' '#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080#1093' '#1076#1072#1085#1085#1099#1093
          Sortable = True
        end
        item
          FieldName = 'SupplierWeightKG'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1092#1080#1079#1080#1095#1077#1089#1082#1080#1081' ('#1087#1086#1089#1090#1072#1074#1097#1080#1082')'
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'SupplierVolumeKG'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1086#1073#1098#1077#1084#1085#1099#1081' ('#1087#1086#1089#1090#1072#1074#1097#1080#1082')'
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'SupplierDiffVolumeWeigh'
          Title.Alignment = taCenter
          Title.Caption = #1056#1072#1079#1085#1080#1094#1072' '#1089#1091#1084#1084' '#1074#1077#1089' '#1086#1073#1098#1077#1084#1085#1099#1081' '#1080' '#1074#1077#1089' '#1092#1080#1079' '#1092#1072#1082#1090' '#1087#1086' '#1076#1072#1085#1085#1099#1084' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'SupplierAmount'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1076#1086#1089#1090#1072#1074#1082#1080' ('#1087#1086#1089#1090#1072#1074#1097#1080#1082')'
          Width = 150
          Sortable = True
        end
        item
          FieldName = 'TransporterWeightKG'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1092#1080#1079#1080#1095#1077#1089#1082#1080#1081' ('#1087#1077#1088#1077#1074#1086#1079#1095#1080#1082')'
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'TransporterVolumeKG'
          Title.Alignment = taCenter
          Title.Caption = ' '#1042#1077#1089' '#1086#1073#1098#1077#1084#1085#1099#1081' ('#1087#1077#1088#1077#1074#1086#1079#1095#1080#1082')'
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'TransporterDiffVolumeWeigh'
          Title.Alignment = taCenter
          Title.Caption = #1056#1072#1079#1085#1080#1094#1072' '#1089#1091#1084#1084' '#1074#1077#1089' '#1086#1073#1098#1077#1084#1085#1099#1081' '#1080' '#1074#1077#1089' '#1092#1080#1079' '#1092#1072#1082#1090' '#1087#1086' '#1076#1072#1085#1085#1099#1084' '#1087#1077#1088#1077#1074#1086#1079#1095#1080#1082#1072
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'TransporterAmount'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1076#1086#1089#1090#1072#1074#1082#1080' ('#1087#1077#1088#1077#1074#1086#1079#1095#1080#1082')'
          Width = 150
          Sortable = True
        end
        item
          FieldName = 'TransporterNumber'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1075#1088#1091#1079#1072
          Width = 118
          ReadOnly = True
          Sortable = True
        end>
    end
    object pFilter: TUniPanel
      Left = 0
      Top = 0
      Width = 1402
      Height = 78
      Hint = ''
      ShowHint = True
      Align = alTop
      TabOrder = 2
      ShowCaption = False
      Caption = 'pFilter'
      ParentAlignmentControl = False
      object gbFilter: TUniGroupBox
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 1394
        Height = 70
        Hint = ''
        ShowHint = True
        AlignmentControl = uniAlignmentClient
        Caption = #1060#1080#1083#1100#1090#1088
        Align = alClient
        LayoutConfig.Width = '0'
        TabOrder = 1
        object fCancel: TUniBitBtn
          Left = 1133
          Top = 35
          Width = 128
          Height = 24
          ShowHint = True
          Action = actFilterClear
          TabOrder = 1
          Images = UniMainModule.BaseImage16
          ImageIndex = 16
        end
        object fOk: TUniBitBtn
          Left = 990
          Top = 35
          Width = 137
          Height = 24
          ShowHint = True
          Action = actFilter
          TabOrder = 2
          IconPosition = ipButtonEdge
          Images = UniMainModule.BaseImage16
          ImageIndex = 15
        end
        object fShipmentsDate: TUniDateTimePicker
          Left = 408
          Top = 35
          Width = 130
          Height = 21
          Hint = ''
          ShowHint = True
          DateTime = 45257.000000000000000000
          DateFormat = 'dd/MM/yyyy'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 3
          ClearButton = True
          EmptyText = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072
        end
        object UniLabel8: TUniLabel
          Left = 408
          Top = 16
          Width = 78
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1044#1072#1090#1072' '#1086#1090#1075#1088#1091#1079#1082#1080':'
          TabOrder = 4
        end
        object edtInvoice: TUniEdit
          Left = 263
          Top = 35
          Width = 139
          Hint = ''
          ShowHint = True
          Text = ''
          TabOrder = 5
          EmptyText = #1053#1086#1084#1077#1088' '#1080#1085#1074#1086#1081#1089#1072
          CheckChangeDelay = 200
          ClearButton = True
        end
        object UniLabel4: TUniLabel
          Left = 263
          Top = 16
          Width = 87
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1053#1086#1084#1077#1088' '#1080#1085#1074#1086#1081#1089#1072':'
          TabOrder = 6
        end
        object UniLabel3: TUniLabel
          Left = 544
          Top = 16
          Width = 62
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
          TabOrder = 7
        end
        object edtTransporterNumber: TUniEdit
          Left = 11
          Top = 35
          Width = 120
          Hint = ''
          ShowHint = True
          Text = ''
          TabOrder = 8
          EmptyText = #1053#1086#1084#1077#1088' '#1075#1088#1091#1079#1072
          CheckChangeDelay = 200
          ClearButton = True
        end
        object UniLabel1: TUniLabel
          Left = 11
          Top = 16
          Width = 70
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1053#1086#1084#1077#1088' '#1075#1088#1091#1079#1072':'
          TabOrder = 9
        end
        object lblStatys: TUniLabel
          Left = 758
          Top = 16
          Width = 36
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1057#1090#1072#1090#1091#1089':'
          TabOrder = 10
        end
        object fStatus2: TUniExCheckComboBox
          Left = 758
          Top = 35
          Width = 209
          Hint = ''
          ShowHint = True
          ShowSelectButton = True
          ShowSearch = True
          Text = ''
          TabOrder = 11
          ClientEvents.ExtEvents.Strings = (
            ''
            
              'afterrender=function afterrender(sender, eOpts) {'#13#10'   initComboB' +
              'oxSearch(sender, "id", "val");'#13#10'}')
          EmptyText = #1057#1090#1072#1090#1091#1089
          ClearButton = True
          IconItems = <>
        end
        object edtBox: TUniEdit
          Left = 137
          Top = 35
          Width = 120
          Hint = ''
          ShowHint = True
          Text = ''
          TabOrder = 12
          EmptyText = #1050#1086#1088#1086#1073#1082#1072
          CheckChangeDelay = 200
          ClearButton = True
        end
        object UniLabel2: TUniLabel
          Left = 137
          Top = 16
          Width = 49
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1050#1086#1088#1086#1073#1082#1072':'
          TabOrder = 13
        end
        object fSupplier: TUniExCheckComboBox
          Left = 544
          Top = 35
          Width = 209
          Hint = ''
          ShowHint = True
          ShowSelectButton = True
          ShowSearch = True
          Text = ''
          TabOrder = 14
          ClientEvents.ExtEvents.Strings = (
            ''
            
              'afterrender=function afterrender(sender, eOpts) {'#13#10'   initComboB' +
              'oxSearch(sender, "id", "val");'#13#10'}')
          EmptyText = #1057#1090#1072#1090#1091#1089
          ClearButton = True
          IconItems = <>
        end
      end
    end
    object pnlGridSelectedCount: TUniPanel
      AlignWithMargins = True
      Left = 29
      Top = 420
      Width = 444
      Height = 40
      Hint = ''
      Margins.Right = 50
      ShowHint = True
      ParentShowHint = False
      TabOrder = 3
      BorderStyle = ubsNone
      ShowCaption = False
      Caption = ''
      Layout = 'column'
      LayoutAttribs.Columns = 3
      LayoutConfig.Width = '100'
      LayoutConfig.ColumnWidth = 300.000000000000000000
      object UniPanel3: TUniPanel
        Left = 0
        Top = 0
        Width = 180
        Height = 40
        Hint = ''
        ShowHint = True
        Align = alLeft
        TabOrder = 1
        BorderStyle = ubsNone
        ShowCaption = False
        Caption = 'UniPanel3'
        object lblSelRowCunt: TUniLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 92
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1042#1099#1076#1077#1083#1077#1085#1086' '#1089#1090#1088#1086#1082': '
          ParentColor = False
          Color = clBtnFace
          TabOrder = 1
        end
      end
      object UniPanel4: TUniPanel
        Left = 180
        Top = 0
        Width = 264
        Height = 40
        Hint = ''
        ShowHint = True
        Align = alClient
        TabOrder = 2
        BorderStyle = ubsNone
        ShowCaption = False
        Caption = 'UniPanel3'
        object lblSelRowSum: TUniLabel
          AlignWithMargins = True
          Left = 46
          Top = 3
          Width = 40
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1057#1091#1084#1084#1072': '
          ParentColor = False
          Color = clBtnFace
          TabOrder = 1
        end
        object lblRowSum2: TUniLabel
          AlignWithMargins = True
          Left = 92
          Top = 24
          Width = 6
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = ': '
          TabOrder = 2
        end
        object lblRowSum1: TUniLabel
          AlignWithMargins = True
          Left = 92
          Top = 3
          Width = 6
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = ': '
          TabOrder = 3
        end
      end
    end
  end
  object Query: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evItems, evAutoFetchAll]
    FetchOptions.Items = []
    FormatOptions.AssignedValues = [fvSortOptions]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.KeyFields = 'ShipmentsID'
    UpdateOptions.AutoIncFields = 'ShipmentsID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      ''
      'exec ShipmentsSelect'
      '       @TransporterNumber = :TransporterNumber'
      '      ,@ShipmentsDate     = :ShipmentsDate'
      '      ,@Invoice           = :Invoice'
      '      ,@SupplierIdList    = :Supplier'
      '      ,@StatusIdList      = :Status'
      '      ,@BoxNumber         = :Box'
      '      ')
    Left = 582
    Top = 172
    ParamData = <
      item
        Name = 'TRANSPORTERNUMBER'
        ParamType = ptInput
      end
      item
        Name = 'SHIPMENTSDATE'
        ParamType = ptInput
      end
      item
        Name = 'INVOICE'
        ParamType = ptInput
      end
      item
        Name = 'SUPPLIER'
        ParamType = ptInput
      end
      item
        Name = 'STATUS'
        ParamType = ptInput
      end
      item
        Name = 'BOX'
        ParamType = ptInput
      end>
    object QueryShipmentsID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'ShipmentsID'
      Origin = 'ShipmentsID'
      ProviderFlags = [pfInWhere, pfInKey]
      Precision = 18
      Size = 0
    end
    object QueryFlag: TIntegerField
      FieldName = 'Flag'
      OnGetText = QueryFlagGetText
    end
    object QueryShipmentsDate: TSQLTimeStampField
      FieldName = 'ShipmentsDate'
      Origin = 'ShipmentsDate'
      Required = True
    end
    object QuerySupplierBrief: TWideStringField
      FieldName = 'SupplierBrief'
      Origin = 'SupplierBrief'
      ReadOnly = True
      Size = 256
    end
    object QueryReceiptDate: TSQLTimeStampField
      FieldName = 'ReceiptDate'
      Origin = 'ReceiptDate'
      ReadOnly = True
      OnGetText = QueryReceiptDateGetText
    end
    object QueryReceiptDate2: TSQLTimeStampField
      FieldName = 'ReceiptDate2'
      ReadOnly = True
    end
    object QueryInvoice: TWideStringField
      FieldName = 'Invoice'
      Origin = 'Invoice'
      Size = 64
    end
    object QueryShipmentsType: TWideStringField
      FieldName = 'DestinationName'
      Origin = 'ShipmentsType'
      Size = 120
    end
    object QueryShipmentsAmount: TCurrencyField
      FieldName = 'ShipmentsAmount'
      Origin = 'ShipmentsAmount'
      DisplayFormat = '###,##0.00 $'
    end
    object QueryShipmentsAmountR: TCurrencyField
      FieldName = 'ShipmentsAmountR'
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryDetailCount: TIntegerField
      FieldName = 'DetailCount'
      Origin = 'DetailCount'
      DisplayFormat = '###,##0.00 '#1096#1090
    end
    object QueryWeightKG: TCurrencyField
      FieldName = 'WeightKG'
      Origin = 'WeightKG'
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QueryVolumeKG: TCurrencyField
      FieldName = 'VolumeKG'
      Origin = 'VolumeKG'
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QueryWeightKGDiff: TCurrencyField
      FieldName = 'WeightKGDiff'
      Origin = 'WeightKGDiff'
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QueryWeightKGF: TCurrencyField
      FieldName = 'WeightKGF'
      Origin = 'WeightKGF'
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QueryVolumeKGF: TCurrencyField
      FieldName = 'VolumeKGF'
      Origin = 'VolumeKGF'
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QueryVolumeKGDiff: TCurrencyField
      FieldName = 'VolumeKGDiff'
      Origin = 'VolumeKGDiff'
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QueryAmount: TCurrencyField
      FieldName = 'Amount'
      Origin = 'Amount'
      DisplayFormat = '###,##0.00 $'
    end
    object QueryAmountF: TCurrencyField
      FieldName = 'AmountF'
      DisplayFormat = '###,##0.00 $'
    end
    object QuerySupplierWeightKG: TCurrencyField
      FieldName = 'SupplierWeightKG'
      Origin = 'SupplierWeightKG'
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QuerySupplierVolumeKG: TCurrencyField
      FieldName = 'SupplierVolumeKG'
      Origin = 'SupplierVolumeKG'
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QuerySupplierDiffVolumeWeigh: TCurrencyField
      FieldName = 'SupplierDiffVolumeWeigh'
      Origin = 'SupplierDiffVolumeWeigh'
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QuerySupplierAmount: TCurrencyField
      FieldName = 'SupplierAmount'
      Origin = 'SupplierAmount'
      DisplayFormat = '###,##0.00 $'
    end
    object QueryTransporterWeightKG: TCurrencyField
      FieldName = 'TransporterWeightKG'
      Origin = 'TransporterWeightKG'
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QueryTransporterVolumeKG: TCurrencyField
      FieldName = 'TransporterVolumeKG'
      Origin = 'TransporterVolumeKG'
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QueryTransporterDiffVolumeWeigh: TCurrencyField
      FieldName = 'TransporterDiffVolumeWeigh'
      Origin = 'TransporterDiffVolumeWeigh'
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QueryTransporterAmount: TCurrencyField
      FieldName = 'TransporterAmount'
      Origin = 'TransporterAmount'
      DisplayFormat = '###,##0.00 $'
    end
    object QueryWeightKGAmount: TCurrencyField
      FieldName = 'WeightKGAmount'
      Origin = 'WeightKGAmount'
      DisplayFormat = '###,##0.00 $'
    end
    object QueryVolumeKGAmount: TCurrencyField
      FieldName = 'VolumeKGAmount'
      Origin = 'VolumeKGAmount'
      DisplayFormat = '###,##0.00 $'
    end
    object QueryupdDatetime: TSQLTimeStampField
      FieldName = 'updDatetime'
      Origin = 'updDatetime'
    end
    object QueryTransporterNumber: TWideStringField
      FieldName = 'TransporterNumber'
      Size = 64
    end
    object QueryStatusName: TWideStringField
      FieldName = 'StatusName'
      Size = 64
    end
    object QueryDeliverySumF: TCurrencyField
      FieldName = 'DeliverySumF'
      DisplayFormat = '###,##0.00 $'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 660
    Top = 173
  end
  object actMain: TUniActionList
    Left = 102
    Top = 281
    object actRefreshAll: TAction
      Category = 'Action'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 3
      OnExecute = actRefreshAllExecute
    end
    object actFilter: TAction
      Category = 'Filter'
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      ImageIndex = 12
      OnExecute = actFilterExecute
    end
    object actFilterClear: TAction
      Category = 'Filter'
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      ImageIndex = 16
      OnExecute = actFilterClearExecute
    end
    object actGridSettingDefault: TAction
      Category = 'Grid'
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      OnExecute = actGridSettingDefaultExecute
    end
    object actExportData: TAction
      Tag = -1
      Category = 'Grid'
      Caption = #1069#1082#1089#1087#1086#1088#1090
      OnExecute = actExportDataExecute
    end
    object actSetTransporterNumber: TAction
      Category = 'Action'
      Caption = #1059#1082#1072#1079#1072#1090#1100' '#1085#1086#1084#1077#1088' '#1075#1088#1091#1079#1072
      OnExecute = actSetTransporterNumberExecute
    end
    object actSetReceiptDate: TAction
      Category = 'Action'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1076#1072#1090#1091' '#1076#1086#1089#1090#1072#1074#1082#1080
      OnExecute = actSetReceiptDateExecute
    end
    object actSetReceivedStatus: TAction
      Category = 'Action'
      Caption = #1055#1086#1083#1091#1095#1077#1085
      OnExecute = actSetReceivedStatusExecute
    end
    object actSetTransporterData: TAction
      Caption = #1059#1082#1072#1079#1072#1090#1100' '#1074#1077#1089' '#1087#1086' '#1076#1072#1085#1085#1099#1084' '#1087#1077#1088#1077#1074#1086#1079#1095#1080#1082#1072
      OnExecute = actSetTransporterDataExecute
    end
    object actProtocol: TAction
      Caption = #1055#1088#1086#1090#1086#1082#1086#1083
      Hint = #1055#1088#1086#1090#1086#1082#1086#1083
      OnExecute = actProtocolExecute
    end
    object actDataEdit: TAction
      Caption = #1059#1082#1072#1079#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1086#1090#1075#1088#1091#1079#1082#1077
      OnExecute = actDataEditExecute
    end
    object actShipmentsBoxes: TAction
      Category = 'Action'
      Caption = #1050#1086#1088#1086#1073#1082#1080
      OnExecute = actShipmentsBoxesExecute
    end
    object actFrigileData: TAction
      Category = 'Grid'
      Caption = #1061#1088#1091#1087#1082#1086#1077
      Hint = #1055#1086#1079#1074#1086#1083#1103#1077#1090' '#1087#1088#1086#1089#1084#1072#1090#1080#1088#1080#1074#1072#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1076#1077#1090#1072#1083#1077#1081' '#1089' '#1087#1088#1080#1079#1085#1072#1082#1086#1084' "'#1061#1088#1091#1087#1082#1086#1077'"'
      OnExecute = actFrigileDataExecute
    end
  end
  object ppMain: TUniPopupMenu
    Images = UniMainModule.BaseImage
    OnPopup = ppMainPopup
    ScreenMask.Enabled = True
    Left = 101
    Top = 217
    object N16: TUniMenuItem
      Action = actDataEdit
    end
    object N3: TUniMenuItem
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077
      object N5: TUniMenuItem
        Action = actSetReceivedStatus
      end
      object N15: TUniMenuItem
        Caption = '-'
      end
      object N4: TUniMenuItem
        Action = actSetTransporterNumber
      end
      object N10: TUniMenuItem
        Action = actSetReceiptDate
      end
      object N12: TUniMenuItem
        Action = actSetTransporterData
      end
    end
    object N17: TUniMenuItem
      Action = actShipmentsBoxes
    end
    object N2: TUniMenuItem
      Action = actExportData
    end
    object N8: TUniMenuItem
      Action = actFrigileData
    end
    object N14: TUniMenuItem
      Caption = '-'
    end
    object N13: TUniMenuItem
      Action = actProtocol
    end
    object N1: TUniMenuItem
      Caption = '-'
    end
    object N6: TUniMenuItem
      Action = actRefreshAll
    end
    object N7: TUniMenuItem
      Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1080
      object N11: TUniMenuItem
        Action = actGridSettingDefault
      end
    end
  end
  object UpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    FetchRowSQL.Strings = (
      'SELECT '
      '       SupplierWeightKG, '
      '       SupplierVolumeKG,  '
      '       SupplierDiffVolumeWeigh, '
      '       SupplierAmount,'
      '       '
      '       TransporterWeightKG, '
      '       TransporterVolumeKG, '
      '       TransporterDiffVolumeWeigh, '
      '       TransporterAmount,'
      '       TransporterNumber,'
      ''
      '       ReceiptDate,'
      '       ReceiptDate2,'
      '      '
      '       DeliverySumF,'
      '       StatusName,'
      '       '
      '       updDatetime      '
      ''
      '  from vShipments '
      ' where ShipmentsID = :ShipmentsID'
      '')
    Left = 520
    Top = 171
  end
end
