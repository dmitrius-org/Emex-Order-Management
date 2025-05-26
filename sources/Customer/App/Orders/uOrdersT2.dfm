object OrdersT2: TOrdersT2
  Left = 0
  Top = 0
  Width = 1735
  Height = 596
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
  object UniPanel2: TUniPanel
    Left = 0
    Top = 57
    Width = 1735
    Height = 539
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
    object Grid: TUniDBGrid
      Left = 0
      Top = 86
      Width = 1735
      Height = 453
      Hint = ''
      ShowHint = True
      CustomAttribs.Strings = (
        'testAttr')
      BodyRTL = False
      ClientEvents.ExtEvents.Strings = (
        
          'beforerender=function beforerender(sender, eOpts)'#13#10'{'#13#10'    var me' +
          '=sender.checkboxModel;'#13#10'    if (me) {        '#13#10'        me.showHe' +
          'aderCheckbox=true; // '#1089#1082#1088#1099#1074#1072#1077#1084' Checkbox '#1089' '#1079#1072#1075#1086#1083#1086#1074#1082#1072' '#1090#1072#1073#1083#1080#1094#1099#13#10'   ' +
          ' }'#13#10'}'
        
          'columnhide=function columnhide(ct, column, eOpts)'#13#10'{'#13#10'  if (colu' +
          'mn.dataIndex >= 0) { //column.dataIndex >= 0 '#1080#1089#1087#1088#1072#1074#1083#1077#1085#1080#1077' Argumen' +
          't out of range'#13#10'    ajaxRequest(this, '#39'_columnhide'#39', ["column=" ' +
          '+ column.dataIndex, "hidden=" + column.hidden]);'#13#10'  }'#13#10'}'
        
          'columnshow=function columnshow(ct, column, eOpts)'#13#10'{'#13#10' ajaxReque' +
          'st(this, '#39'_columnshow'#39', ["column=" + column.dataIndex, "hidden="' +
          ' + column.hidden]);'#13#10'}')
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
          'r.getDockedItems()[1];'#13#10#13#10'  toolbar.items.getAt(0).hide(); '#13#10'  t' +
          'oolbar.items.getAt(1).hide(); '#13#10'  toolbar.items.getAt(2).hide();' +
          ' '#13#10'  toolbar.items.getAt(3).hide(); '#13#10'  toolbar.items.getAt(4).h' +
          'ide(); '#13#10'  toolbar.items.getAt(5).hide(); '#13#10'  toolbar.items.getA' +
          't(6).hide(); '#13#10'  toolbar.items.getAt(7).hide(); '#13#10'  toolbar.item' +
          's.getAt(8).hide(); '#13#10'  toolbar.items.getAt(9).hide(); '#13#10'  toolba' +
          'r.items.getAt(10).hide();   '#13#10'}'
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'        el.value = document.activeElement.inne' +
          'rText;'#13#10'        document.body.appendChild(el);'#13#10'        el.selec' +
          't();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        document.bo' +
          'dy.removeChild(el);'#13#10'    };'#13#10'         '#13#10'}'
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'  config.displayInfo=false;'#13#10'}')
      HeaderTitleAlign = taCenter
      PagingBarAuxControl = pnlGridInfo
      DataSource = DataSource
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgRowSelect, dgCheckSelect, dgCheckSelectCheckOnly, dgMultiSelect, dgAutoRefreshRow, dgDontShowSelected]
      WebOptions.PageSize = 100
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      LoadMask.WaitData = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Color = 13421772
      Images = UniImageList
      EmptyText = 
        '<div style="text-align: center;"><i class="fas fa-exclamation"><' +
        '/i> '#1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ... </div>'
      LayoutConfig.ComponentCls = 'grid-order'
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
      OnAjaxEvent = GridAjaxEvent
      OnSelectionChange = GridSelectionChange
      OnCellClick = GridCellClick
      OnColumnSort = GridColumnSort
      OnColumnMove = GridColumnMove
      OnCellContextClick = GridCellContextClick
      OnDrawColumnCell = GridDrawColumnCell
      OnColumnResize = GridColumnResize
      OnColumnActionClick = GridColumnActionClick
      Columns = <
        item
          FieldName = 'UnreadMessagesCount'
          Title.Caption = ' '
          Width = 43
          Alignment = taLeftJustify
          ReadOnly = True
          Hint = #1044#1077#1081#1089#1090#1074#1080#1103
        end
        item
          ShowToolTip = True
          FieldName = 'OrderID'
          Title.Alignment = taCenter
          Title.Caption = #1048#1044' '#1047#1072#1082#1072#1079#1072
          Width = 95
          Visible = False
          ReadOnly = True
          Hint = #1048#1044' '#1047#1072#1082#1072#1079#1072
          Sortable = True
        end
        item
          FieldName = 'OrderDate'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072
          Width = 85
          ReadOnly = True
          Hint = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072
          Sortable = True
        end
        item
          FieldName = 'OrderNum'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072
          Width = 120
          Visible = False
          ReadOnly = True
          Hint = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072
          Sortable = True
        end
        item
          FieldName = 'Manufacturer'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
          Width = 161
          ReadOnly = True
          Hint = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
          Sortable = True
        end
        item
          FieldName = 'DetailNumber'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
          Width = 135
          ReadOnly = True
          Hint = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
          Sortable = True
        end
        item
          FieldName = 'DetailName'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1077#1090#1072#1083#1080
          Width = 258
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'Quantity'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Width = 92
          ReadOnly = True
          Hint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Sortable = True
        end
        item
          FieldName = 'Price'
          Title.Alignment = taCenter
          Title.Caption = #1062#1077#1085#1072' '#1079#1072' 1 '#1096#1090'.'
          Width = 108
          ReadOnly = True
          Hint = #1062#1077#1085#1072' '#1079#1072' 1 '#1096#1090'.'
          Sortable = True
        end
        item
          FieldName = 'Amount'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1087#1088#1086#1076#1072#1078#1080
          Width = 110
          ReadOnly = True
          Hint = #1057#1091#1084#1084#1072' '#1087#1088#1086#1076#1072#1078#1080
          Sortable = True
        end
        item
          FieldName = 'DestinationName'
          Title.Alignment = taCenter
          Title.Caption = #1057#1087#1086#1089#1086#1073' '#1076#1086#1089#1090#1072#1074#1082#1080
          Width = 100
          ReadOnly = True
        end
        item
          FieldName = 'DeliveryTermToCustomer'
          Title.Alignment = taCenter
          Title.Caption = #1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080
          Width = 80
          ReadOnly = True
          Hint = #1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080
          Sortable = True
        end
        item
          FieldName = 'DeliveryRestToCustomer'
          Title.Alignment = taCenter
          Title.Caption = #1054#1089#1090#1072#1090#1086#1082' '#1089#1088#1086#1082#1072' '#1076#1086' '#1087#1086#1089#1090#1072#1074#1082#1080
          Width = 90
          ReadOnly = True
          Hint = #1054#1089#1090#1072#1090#1086#1082' '#1089#1088#1086#1082#1072' '#1076#1086' '#1087#1086#1089#1090#1072#1074#1082#1080
          Sortable = True
        end
        item
          FieldName = 'DeliveryDateToCustomer'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1072#1074#1082#1080
          Width = 100
          ReadOnly = True
          Hint = #1044#1072#1090#1072' '#1087#1086#1089#1090#1072#1074#1082#1080
          Sortable = True
        end
        item
          FieldName = 'StatusName'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Width = 173
          ReadOnly = True
          Hint = #1057#1090#1072#1090#1091#1089' ('#1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1079#1072#1082#1072#1079#1072')'
          Sortable = True
        end
        item
          ShowToolTip = True
          FieldName = 'PriceLogo'
          Title.Alignment = taCenter
          Title.Caption = #1051#1086#1075#1086' '#1087#1088#1072#1081#1089#1072' '#1082#1083#1080#1077#1085#1090#1072
          Width = 86
          Visible = False
          ReadOnly = True
          Hint = #1051#1086#1075#1086' '#1087#1088#1072#1081#1089#1072' '#1082#1083#1080#1077#1085#1090#1072
          Sortable = True
        end
        item
          FieldName = 'WeightKG'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1080#1079' '#1087#1088#1072#1081#1089#1072
          Width = 100
          Visible = False
          ReadOnly = True
          Hint = #1042#1077#1089' '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1080#1079' '#1087#1088#1072#1081#1089#1072
          Sortable = True
        end
        item
          FieldName = 'VolumeKG'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1054#1073#1098#1077#1084#1085#1099#1081' '#1080#1079' '#1087#1088#1072#1081#1089#1072
          Width = 100
          Visible = False
          ReadOnly = True
          Hint = #1042#1077#1089' '#1054#1073#1098#1077#1084#1085#1099#1081' '#1080#1079' '#1087#1088#1072#1081#1089#1072
          Sortable = True
        end
        item
          FieldName = 'WeightKGF'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1092#1072#1082#1090
          Width = 100
          Visible = False
          ReadOnly = True
          Hint = #1042#1077#1089' '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1092#1072#1082#1090
          Sortable = True
        end
        item
          FieldName = 'VolumeKGF'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1054#1073#1098#1077#1084#1085#1099#1081' '#1092#1072#1082#1090
          Width = 100
          Visible = False
          ReadOnly = True
          Hint = #1042#1077#1089' '#1054#1073#1098#1077#1084#1085#1099#1081' '#1092#1072#1082#1090
          Sortable = True
        end
        item
          FieldName = 'DeliveryPlanDateSupplier'
          Title.Alignment = taCenter
          Title.Caption = #1055#1083#1072#1085#1086#1074#1072#1103' '#1076#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Width = 100
          Visible = False
          ReadOnly = True
          Hint = #1055#1083#1072#1085#1086#1074#1072#1103' '#1076#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Sortable = True
        end
        item
          FieldName = 'DeliveryTermSupplier'
          Title.Alignment = taCenter
          Title.Caption = #1057#1088#1086#1082' '#1076#1086' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Width = 100
          Visible = False
          ReadOnly = True
        end
        item
          FieldName = 'DeliveryRestTermSupplier'
          Title.Alignment = taCenter
          Title.Caption = #1054#1089#1090#1072#1090#1086#1082' '#1089#1088#1086#1082#1072' '#1076#1086' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Width = 100
          Visible = False
          ReadOnly = True
          Hint = #1054#1089#1090#1072#1090#1086#1082' '#1089#1088#1086#1082#1072' '#1076#1086' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Sortable = True
        end
        item
          FieldName = 'DeliveredDateToSupplier'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1089#1090#1072#1074#1083#1077#1085#1072' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Width = 134
          Visible = False
          ReadOnly = True
          Hint = #1044#1086#1089#1090#1072#1074#1083#1077#1085#1072' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Sortable = True
        end
        item
          FieldName = 'DeliveryNextDate'
          Title.Alignment = taCenter
          Title.Caption = #1041#1083#1080#1078#1072#1081#1096#1072#1103' '#1076#1072#1090#1072' '#1074#1099#1083#1077#1090#1072
          Width = 100
          Visible = False
          ReadOnly = True
          Hint = #1041#1083#1080#1078#1072#1081#1096#1072#1103' '#1076#1072#1090#1072' '#1074#1099#1083#1077#1090#1072
          Sortable = True
        end
        item
          ShowToolTipAlways = False
          FieldName = 'Flag'
          Title.Caption = ' '#1057#1090#1072#1090#1091#1089#1099
          Width = 70
          Alignment = taLeftJustify
          ReadOnly = True
          Hint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1087#1088#1080#1079#1085#1072#1082#1080' '#1087#1086' '#1089#1090#1072#1090#1091#1089#1091' '#1079#1072#1082#1072#1079#1072
        end
        item
          ShowToolTip = True
          FieldName = 'Comment'
          Title.Alignment = taCenter
          Title.Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
          Width = 300
          ReadOnly = True
          Sortable = True
        end
        item
          ShowToolTip = True
          FieldName = 'Comment2'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
          Width = 300
          Sortable = True
        end
        item
          FieldName = 'updDatetime'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' c'#1090#1072#1090#1091#1089#1072
          Width = 148
          ReadOnly = True
          Sortable = True
        end>
    end
    object pFilter: TUniPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 1729
      Height = 80
      Hint = ''
      ShowHint = True
      Align = alTop
      TabOrder = 1
      BorderStyle = ubsNone
      ShowCaption = False
      Caption = 'pFilter'
      ParentAlignmentControl = False
      object gbFilter: TUniGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1723
        Height = 74
        Hint = ''
        ShowHint = True
        AlignmentControl = uniAlignmentClient
        Caption = #1060#1080#1083#1100#1090#1088
        Align = alClient
        LayoutConfig.Width = '0'
        TabOrder = 1
        object UniLabel1: TUniLabel
          Left = 15
          Top = 20
          Width = 36
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1057#1090#1072#1090#1091#1089':'
          TabOrder = 1
        end
        object fCancel: TUniBitBtn
          Left = 988
          Top = 39
          Width = 100
          Height = 24
          ShowHint = True
          Action = actFilterClear
          Caption = '<i class="fa fa-times red"></i> '#1054#1095#1080#1089#1090#1080#1090#1100
          TabOrder = 7
        end
        object fOk: TUniBitBtn
          Left = 1093
          Top = 39
          Width = 100
          Height = 24
          ShowHint = True
          Action = actFilter
          Caption = '<i class="fa fa-filter"></i> '#1055#1088#1080#1084#1077#1085#1080#1090#1100
          TabOrder = 8
          IconPosition = ipButtonEdge
        end
        object UniLabel5: TUniLabel
          Left = 892
          Top = 20
          Width = 34
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1054#1090#1082#1072#1079':'
          TabOrder = 4
        end
        object cbCancel: TUniComboBox
          Left = 892
          Top = 39
          Width = 81
          Hint = ''
          ShowHint = True
          Text = ''
          Items.Strings = (
            #1053#1077#1090
            #1044#1072)
          TabOrder = 6
          EmptyText = #1054#1090#1082#1072#1079
          ClearButton = True
          IconItems = <>
          OnSelect = cbCancelSelect
        end
        object UniLabel6: TUniLabel
          Left = 511
          Top = 20
          Width = 78
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080':'
          TabOrder = 3
        end
        object fDetailNum: TUniEdit
          Left = 511
          Top = 39
          Width = 171
          Hint = ''
          ShowHint = True
          Text = ''
          TabOrder = 5
          EmptyText = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
          CheckChangeDelay = 200
          ClearButton = True
        end
        object UniLabel8: TUniLabel
          Left = 309
          Top = 20
          Width = 65
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072':'
          TabOrder = 2
        end
        object btnCancel: TUniBitBtn
          AlignWithMargins = True
          Left = 1336
          Top = 39
          Width = 113
          Height = 24
          ShowHint = True
          Action = actCancelRequest
          TabOrder = 9
        end
        object edtComment2: TUniEdit
          Left = 688
          Top = 39
          Width = 198
          Hint = ''
          ShowHint = True
          Text = ''
          TabOrder = 10
          EmptyText = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
          CheckChangeDelay = 200
          ClearButton = True
        end
        object UniLabel2: TUniLabel
          Left = 688
          Top = 20
          Width = 77
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
          TabOrder = 11
        end
        object fOrderDate: TUniDateRangePicker
          Left = 309
          Top = 39
          Width = 196
          Hint = ''
          ShowHint = True
          Text = 'fOrderDate'
          TabOrder = 12
          EmptyText = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072
          Triggers = <
            item
              ButtonId = 0
              IconCls = 'x-form-clear-trigger'
              HandleClicks = True
            end
            item
              ButtonId = 1
              IconCls = 'x-form-date-trigger'
              HandleClicks = True
            end>
          DateFormat = 'DD/MM/YYYY'
          DatePickerOptions.AutoUpdateInput = False
          DatePickerOptions.Opens = ooCenter
          DatePickerOptions.RangesEnabled = True
          DatePickerOptions.Ranges.Strings = (
            #1057#1077#1075#1086#1076#1085#1103'=[moment(), moment()]'
            
              #1042#1095#1077#1088#1072'=[moment().subtract(1, "days"), moment().subtract(1, "days"' +
              ')]'
            #1055#1086#1089#1083#1077#1076#1085#1080#1077' 7 '#1076#1085#1077#1081'=[moment().subtract(6, "days"), moment()]'
            #1055#1086#1089#1083#1077#1076#1085#1080#1077' 30 '#1076#1085#1077#1081'=[moment().subtract(29, "days"), moment()]'
            #1069#1090#1086#1090' '#1084#1077#1089#1103#1094'=[moment().startOf("month"), moment().endOf("month")]'
            
              #1055#1088#1086#1096#1083#1099#1081' '#1084#1077#1089#1103#1094'=[moment().subtract(1, "month").startOf("month"), m' +
              'oment().subtract(1, "month").endOf("month")]')
        end
        object btnNotification: TUniBitBtn
          AlignWithMargins = True
          Left = 1211
          Top = 39
          Width = 119
          Height = 24
          Hint = #1060#1080#1083#1100#1090#1088' '#1087#1086' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103#1084
          ShowHint = True
          Caption = '<i class="icon-notification"></i> '#1059#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
          TabOrder = 13
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.styl' +
              'e={'#39'overflow'#39': '#39'visible'#39'};'#13#10'  sender.action = '#39'badgetext'#39'; '#13#10'  s' +
              'ender.plugins = ['#13#10'                        {'#13#10'                  ' +
              '          ptype:'#39'badgetext'#39','#13#10'                            defaul' +
              'tText: 12,'#13#10'                            textSize: 12,'#13#10'         ' +
              '                   disableOpacity:1,'#13#10'                          ' +
              '  disableBg: '#39'grey'#39','#13#10'                            enableBg: '#39'gre' +
              'y'#39','#13#10'                            align:'#39'right'#39','#13#10'               ' +
              '             top:-15'#13#10'                        }'#13#10'               ' +
              '   ];'#13#10'}')
          LayoutConfig.ComponentCls = 'order-notification-btn'
          OnClick = btnNotificationClick
        end
        object fStatus2: TUniExCheckComboBox
          Left = 15
          Top = 39
          Width = 288
          Hint = ''
          ShowHint = True
          ShowSelectButton = True
          ShowSearch = True
          Text = ''
          TabOrder = 14
          ClientEvents.ExtEvents.Strings = (
            
              'afterrender=function afterrender(sender, eOpts) {  '#13#10'  initCombo' +
              'BoxSelectButtons(sender, "id");'#13#10'  initComboBoxSearch(sender, "i' +
              'd", "val");  '#13#10'}')
          EmptyText = #1057#1090#1072#1090#1091#1089
          ClearButton = True
          IconItems = <>
        end
      end
    end
    object pnlGridInfo: TUniPanel
      AlignWithMargins = True
      Left = 253
      Top = 414
      Width = 988
      Height = 40
      Hint = ''
      Margins.Right = 50
      ShowHint = True
      ParentShowHint = False
      TabOrder = 3
      BorderStyle = ubsNone
      Alignment = taLeftJustify
      ShowCaption = False
      Caption = ''
      Layout = 'hbox'
      LayoutConfig.Padding = '2'
      LayoutConfig.Width = '100'
      object pnlInfo: TUniContainerPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 623
        Height = 34
        Hint = ''
        ShowHint = True
        ParentColor = False
        Align = alClient
        TabOrder = 1
        object lblRow: TUniLabel
          AlignWithMargins = True
          Left = 3
          Top = 10
          Width = 56
          Height = 17
          Hint = ''
          Margins.Top = 10
          Margins.Bottom = 8
          ShowHint = True
          Alignment = taRightJustify
          Caption = #1057#1090#1088#1072#1085#1080#1094#1072
          Align = alClient
          ParentFont = False
          Font.Height = -13
          ParentColor = False
          Color = clBtnFace
          TabOrder = 1
          LayoutConfig.Margin = '1'
        end
      end
      object pnlNavigation: TUniContainerPanel
        AlignWithMargins = True
        Left = 632
        Top = 3
        Width = 353
        Height = 34
        Hint = ''
        ShowHint = True
        ParentColor = False
        Align = alRight
        TabOrder = 2
        object pnlPageR: TUniPanel
          Left = 280
          Top = 0
          Width = 73
          Height = 34
          Hint = ''
          ShowHint = True
          Align = alRight
          TabOrder = 1
          BorderStyle = ubsNone
          ShowCaption = False
          Caption = 'UniPanel3'
          object btnLast: TUniButton
            AlignWithMargins = True
            Left = 40
            Top = 5
            Width = 30
            Height = 24
            Hint = ''
            Margins.Top = 5
            Margins.Bottom = 5
            ShowHint = True
            Caption = '>>'
            Align = alRight
            TabStop = False
            TabOrder = 1
            LayoutConfig.Padding = '1'
            LayoutConfig.Margin = '1'
            OnClick = btnLastClick
          end
          object btnNext: TUniButton
            AlignWithMargins = True
            Left = 4
            Top = 5
            Width = 30
            Height = 24
            Hint = ''
            Margins.Top = 5
            Margins.Bottom = 5
            ShowHint = True
            Caption = '>'
            Align = alRight
            TabStop = False
            TabOrder = 2
            LayoutConfig.Padding = '1'
            LayoutConfig.Margin = '1'
            OnClick = btnNextClick
          end
        end
        object pnlPageL: TUniPanel
          Left = 0
          Top = 0
          Width = 73
          Height = 34
          Hint = ''
          ShowHint = True
          Align = alLeft
          TabOrder = 2
          BorderStyle = ubsNone
          ShowCaption = False
          Caption = 'pnlPageL'
          object btnPrevious: TUniButton
            AlignWithMargins = True
            Left = 40
            Top = 5
            Width = 30
            Height = 24
            Hint = ''
            Margins.Top = 5
            Margins.Bottom = 5
            ShowHint = True
            Caption = '<'
            Align = alRight
            TabStop = False
            TabOrder = 2
            LayoutConfig.Padding = '1'
            LayoutConfig.Margin = '1'
            OnClick = btnPreviousClick
          end
          object btnFirst: TUniButton
            AlignWithMargins = True
            Left = 4
            Top = 5
            Width = 30
            Height = 24
            Hint = ''
            Margins.Top = 5
            Margins.Bottom = 5
            ShowHint = True
            Caption = '<<'
            Align = alRight
            TabStop = False
            TabOrder = 1
            LayoutConfig.Padding = '1'
            LayoutConfig.Margin = '1'
            OnClick = btnFirstClick
          end
        end
        object pnlPage: TUniPanel
          Left = 73
          Top = 0
          Width = 207
          Height = 34
          Hint = ''
          ShowHint = True
          Align = alClient
          TabOrder = 3
          BorderStyle = ubsNone
          ShowCaption = False
          Caption = 'UniPanel3'
          Layout = 'column'
          LayoutAttribs.Columns = 3
          LayoutConfig.Cls = 'order-page'
          object UniContainerPanel1: TUniContainerPanel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 70
            Height = 28
            Hint = ''
            ShowHint = True
            ParentColor = False
            Align = alLeft
            TabOrder = 1
            object UniLabel3: TUniLabel
              AlignWithMargins = True
              Left = 3
              Top = 10
              Width = 56
              Height = 17
              Hint = ''
              Margins.Top = 10
              Margins.Bottom = 8
              ShowHint = True
              Alignment = taCenter
              Caption = #1057#1090#1088#1072#1085#1080#1094#1072
              Align = alClient
              ParentFont = False
              Font.Height = -13
              ParentColor = False
              Color = clBtnFace
              TabOrder = 1
              LayoutConfig.Margin = '1'
            end
          end
          object edtPage: TUniSpinEdit
            AlignWithMargins = True
            Left = 79
            Top = 8
            Width = 69
            Hint = ''
            Margins.Top = 8
            Margins.Bottom = 8
            ShowHint = True
            TabOrder = 3
            Align = alClient
            Alignment = taCenter
            LayoutConfig.Height = '100%'
            OnKeyDown = edtPageKeyDown
          end
          object UniContainerPanel2: TUniContainerPanel
            AlignWithMargins = True
            Left = 154
            Top = 3
            Width = 50
            Height = 28
            Hint = ''
            ShowHint = True
            ParentColor = False
            Align = alRight
            TabOrder = 2
            object lblAllCount: TUniLabel
              AlignWithMargins = True
              Left = 3
              Top = 10
              Width = 24
              Height = 17
              Hint = ''
              Margins.Top = 10
              Margins.Bottom = 8
              ShowHint = True
              Alignment = taCenter
              Caption = #1080#1079' 0'
              Align = alClient
              ParentFont = False
              Font.Height = -13
              ParentColor = False
              Color = clBtnFace
              TabOrder = 1
              LayoutConfig.Margin = '1'
            end
          end
        end
      end
    end
  end
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1729
    Height = 51
    Hint = ''
    Visible = False
    ShowHint = True
    Align = alTop
    TabOrder = 0
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
  end
  object Query: TFDQuery
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evItems, evAutoFetchAll]
    FetchOptions.Items = []
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.EnableInsert = False
    UpdateOptions.LockWait = True
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.UpdateTableName = 'vCustomerUpdateOrders'
    UpdateOptions.KeyFields = 'OrderID'
    UpdateOptions.AutoIncFields = 'OrderID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'exec CustomerOrdersSelect @Page = :Page')
    Left = 575
    Top = 255
    ParamData = <
      item
        Name = 'PAGE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QueryOrderID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'OrderID'
      KeyFields = 'OrderID'
      Origin = 'OrderID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QueryFlag: TIntegerField
      FieldName = 'Flag'
      ReadOnly = True
      OnGetText = QueryFlagGetText
    end
    object QueryOrderDate: TSQLTimeStampField
      FieldName = 'OrderDate'
      Origin = 'OrderDate'
      ReadOnly = True
      Required = True
    end
    object QueryPriceLogo: TWideStringField
      FieldName = 'PriceLogo'
      Origin = 'PriceLogo'
      ReadOnly = True
      Size = 32
    end
    object QueryStatusID: TFMTBCDField
      FieldName = 'StatusID'
      ReadOnly = True
    end
    object QueryStatusName: TWideStringField
      FieldName = 'StatusName'
      Origin = 'StatusName'
      ReadOnly = True
      Size = 64
    end
    object QueryManufacturer: TWideStringField
      FieldName = 'Manufacturer'
      Origin = 'Manufacturer'
      ReadOnly = True
      OnGetText = QueryManufacturerGetText
      Size = 64
    end
    object QueryDetailNumber: TWideStringField
      FieldName = 'DetailNumber'
      Origin = 'DetailNumber'
      ReadOnly = True
      OnGetText = QueryDetailNumberGetText
      Size = 32
    end
    object QueryDetailName: TWideStringField
      FieldName = 'DetailName'
      ReadOnly = True
      Size = 256
    end
    object QueryQuantity: TIntegerField
      FieldName = 'Quantity'
      Origin = 'Quantity'
      ReadOnly = True
    end
    object QueryPrice: TCurrencyField
      FieldName = 'Price'
      Origin = 'Price'
      ReadOnly = True
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryAmount: TCurrencyField
      FieldName = 'Amount'
      Origin = 'Amount'
      ReadOnly = True
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryWeightKG: TCurrencyField
      FieldName = 'WeightKG'
      Origin = 'WeightKG'
      ReadOnly = True
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QueryVolumeKG: TCurrencyField
      FieldName = 'VolumeKG'
      Origin = 'VolumeKG'
      ReadOnly = True
      DisplayFormat = '###,##0.00'
    end
    object QueryWeightKGF: TCurrencyField
      FieldName = 'WeightKGF'
      Origin = 'WeightKGF'
      ReadOnly = True
      DisplayFormat = '###,##0.00 '#1082#1075
    end
    object QueryVolumeKGF: TCurrencyField
      FieldName = 'VolumeKGF'
      Origin = 'VolumeKGF'
      ReadOnly = True
      DisplayFormat = '###,##0.00'
    end
    object QueryDeliveryPlanDateSupplier: TSQLTimeStampField
      FieldName = 'DeliveryPlanDateSupplier'
      Origin = 'DeliveryPlanDateSupplier'
      ReadOnly = True
      OnGetText = QueryDeliveryPlanDateSupplierGetText
      DisplayFormat = 'dd.mm.yyyy'
    end
    object QueryDeliveryPlanDateSupplier2: TSQLTimeStampField
      FieldName = 'DeliveryPlanDateSupplier2'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object QueryDeliveryTermSupplier: TIntegerField
      FieldName = 'DeliveryTermSupplier'
      ReadOnly = True
      OnGetText = QueryDeliveryTermSupplierGetText
    end
    object QueryDeliveryTermSupplier2: TIntegerField
      FieldName = 'DeliveryTermSupplier2'
    end
    object QueryDeliveryRestTermSupplier: TIntegerField
      FieldName = 'DeliveryRestTermSupplier'
      ReadOnly = True
    end
    object QueryDeliveredDateToSupplier: TSQLTimeStampField
      FieldName = 'DeliveredDateToSupplier'
      Origin = 'DeliveredDateToSupplier'
      ReadOnly = True
      DisplayFormat = 'dd.mm.yyyy'
    end
    object QueryDeliveryDaysReserve2: TIntegerField
      FieldName = 'DeliveryDaysReserve2'
      ReadOnly = True
    end
    object QueryDeliveryNextDate: TSQLTimeStampField
      FieldName = 'DeliveryNextDate'
      Origin = 'DeliveryNextDate'
      ReadOnly = True
      OnGetText = QueryDeliveryNextDateGetText
      DisplayFormat = 'dd.mm.yyyy'
    end
    object QueryDeliveryNextDate2: TSQLTimeStampField
      FieldName = 'DeliveryNextDate2'
      ReadOnly = True
      DisplayFormat = 'dd.mm.yyyy'
    end
    object QueryDeliveryDateToCustomer: TSQLTimeStampField
      FieldName = 'DeliveryDateToCustomer'
      Origin = 'DeliveryDateToCustomer'
      ReadOnly = True
      OnGetText = QueryDeliveryDateToCustomerGetText
      DisplayFormat = 'dd.mm.yyyy'
    end
    object QueryDeliveryDateToCustomer2: TSQLTimeStampField
      FieldName = 'DeliveryDateToCustomer2'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object QueryDeliveryTermToCustomer: TIntegerField
      FieldName = 'DeliveryTermToCustomer'
      Origin = 'DeliveryTermToCustomer'
      ReadOnly = True
      OnGetText = QueryDeliveryTermToCustomerGetText
    end
    object QueryDeliveryTermToCustomer2: TIntegerField
      FieldName = 'DeliveryTermToCustomer2'
    end
    object QueryDeliveryRestToCustomer: TIntegerField
      FieldName = 'DeliveryRestToCustomer'
      ReadOnly = True
    end
    object QueryReplacementDetailNumber: TWideStringField
      FieldName = 'ReplacementDetailNumber'
      ReadOnly = True
      Size = 32
    end
    object QueryReplacementManufacturer: TWideStringField
      FieldName = 'ReplacementManufacturer'
      ReadOnly = True
      Size = 32
    end
    object QueryComment: TWideStringField
      FieldName = 'Comment'
      ReadOnly = True
      Size = 512
    end
    object QueryOrderNum: TWideStringField
      FieldName = 'OrderNum'
      ReadOnly = True
      Size = 32
    end
    object QueryDestinationName: TWideStringField
      FieldName = 'DestinationName'
      ReadOnly = True
      Size = 60
    end
    object QueryReceiptDate: TSQLTimeStampField
      FieldName = 'ReceiptDate'
      ReadOnly = True
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
    object QueryOrderDetailSubId: TWideStringField
      FieldName = 'OrderDetailSubId'
      ReadOnly = True
      Size = 32
    end
    object QueryAllMessageCount: TIntegerField
      FieldName = 'AllMessageCount'
    end
    object QueryUnreadMessagesCount: TIntegerField
      FieldName = 'UnreadMessagesCount'
      ReadOnly = True
      OnGetText = QueryUnreadMessagesCountGetText
    end
    object QueryComment2: TStringField
      FieldName = 'Comment2'
      Size = 128
    end
    object QueryisCancel: TBooleanField
      FieldName = 'isCancel'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 648
    Top = 253
  end
  object actMain: TUniActionList
    Images = UniImageListAdapter
    Left = 101
    Top = 270
    object actCancelRequest: TAction
      Category = 'Action'
      Caption = #1047#1072#1087#1088#1086#1089' '#1086#1090#1082#1072#1079#1072
      Hint = #1047#1072#1087#1088#1086#1089#1080#1090#1100' '#1086#1090#1084#1077#1085#1091' '#1087#1086' '#1087#1086#1079#1080#1094#1080#1080
      OnExecute = actCancelRequestExecute
    end
    object actRefreshAll: TAction
      Category = 'Action'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 1
      OnExecute = actRefreshAllExecute
    end
    object actProtocol: TAction
      Category = 'Grid'
      Caption = #1055#1088#1086#1090#1086#1082#1086#1083
      Hint = #1055#1088#1086#1090#1086#1082#1086#1083
      ImageIndex = 0
      OnExecute = actProtocolExecute
    end
    object actFilter: TAction
      Category = 'Filter'
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      OnExecute = actFilterExecute
    end
    object actFilterClear: TAction
      Category = 'Filter'
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      OnExecute = actFilterClearExecute
    end
    object actSelect: TAction
      Category = 'Grid'
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
    end
    object actUnselect: TAction
      Category = 'Grid'
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077' '#1086#1090#1084#1077#1090#1082#1080
      Hint = #1057#1085#1103#1090#1100' '#1074#1089#1077' '#1086#1090#1084#1077#1090#1082#1080
    end
    object actShowMessage: TAction
      Category = 'Action'
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077' '#1086#1090' '#1084#1077#1085#1077#1076#1078#1077#1088#1072' '#1087#1086' '#1079#1072#1082#1072#1079#1091
      ImageIndex = 3
      OnExecute = actShowMessageExecute
    end
    object actCancelСonfirm: TAction
      Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1086#1090#1082#1072#1079
      OnExecute = actCancelСonfirmExecute
    end
    object actReOrder: TAction
      Caption = #1055#1077#1088#1077#1079#1072#1082#1072#1079#1072#1090#1100
      OnExecute = actReOrderExecute
    end
  end
  object UpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    DeleteSQL.Strings = (
      'select 0')
    FetchRowSQL.Strings = (
      'SELECT *'
      '  FROM vCustomerOrders'
      ' WHERE OrderID = :OrderID')
    Left = 498
    Top = 255
  end
  object UniImageListAdapter: TUniImageListAdapter
    UniImageList = UniImageList
    Left = 352
    Top = 253
  end
  object UniImageList: TUniImageList
    Left = 352
    Top = 375
    Bitmap = {
      494C010104001800040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000010B1FFFF10B1
      FFFF10B1FFFF10B1FFFF10B1FFFF10B1FFFF10B1FFFF10B1FFFF10B1FFFF10B1
      FFFF10B1FFFF10B1FFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000001F411B10FF2F130CEC190906B30204075F0000001B0000
      0005000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000010B1FFFF6D6D
      6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D
      6DFF6D6D6DFF10B1FFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000001E643B2AE7B9C7D2FF7789A2FF234082FF040F32AF0000
      0021000000050000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF00000000000000000000000000000000000000000000
      00001C1C1C1D6E6D6C70A79E94B7BB9774EABB9774EAA79E94B76E6D6C701C1C
      1C1D000000000000000000000000000000000000000000000002000000090000
      000E0000000F0000002040261BAE879AB2FFC8E3F5FF1E65B6FF2A6AA8FF0412
      36AD0000001F000000040000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF00000000000000000000000000000000000000003838
      3839A49C93B0B88248FFB88248FFB88248FFB88248FFB88248FFB88248FF4E4E
      4E4F0000000000000000000000000000000000000000000000088B6657C0C38C
      79FFC38C78FFCBA395FFA89894FF478BC3FFDEFEFDFF50B4E3FF1E67B7FF3072
      AEFF051537AA0000001C0000000400000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFF8C8CE8FF8C8CE8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF000000000000000000000000000000001C1C1C1DA49C
      93B0B88248FFADA194BF656464661E1E1E1F1E1E1E1F65646466555454560000
      00004C4C4C4D000000000000000000000000000000000000000CC5917DFFFDFB
      FAFFFCF8F6FFFAF7F5FFECEAE9FF7BA3BFFF469FD2FFDEFEFDFF58BFE9FF206A
      B9FF357AB3FF07163AA70000001A00000004D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF000000000000000010B1FFFF6D6D
      6DFFFFFFFFFF8C8CE8FF1717D1FF1717D1FF8C8CE8FFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF000000000000000000000000000000006E6D6C70B882
      48FFADA194BF2D2D2D2E00000000000000000000000000000000000000004C4C
      4C4DB88248FF4C4C4C4D0000000000000000000000000000000CC79481FFFEFB
      FAFFF9F0EAFFF8F0EAFFF7F0EBFFE8E4E1FF7DA4BFFF4AA5D5FFDEFEFDFF60CA
      EFFF236EBCFF3A83B9FF081A3CA300000018D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFAA5E0ECBAA5C0CCAD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF000000000000000010B1FFFF6D6D
      6DFFFFFFFFFF8F8FE8FF8F8FE8FF8F8FE8FF1717D1FF8C8CE8FFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF00000000000000000000000000000000A79E94B7B882
      48FF6564646600000000000000000000000000000000000000004C4C4C4DB882
      48FFB88248FFB88248FF4C4C4C4D00000000000000000000000BC99786FFFEFC
      FBFFF9F2EDFFF9F2EDFFF9F0EBFFF8F2EDFFEBE7E5FF82A7C2FF4DAAD7FFDEFE
      FDFF67D4F4FF2774BEFF3E8BBEFF091B3E9ED77610FFD77610FFD77610FFD776
      10FFD77610FFCB700FF25D33066F03000003020000035B32066DCA700FF1D776
      10FFD77610FFD77610FFD77610FFD77610FF000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8FE8FF1717D1FF8C8CE8FFFFFF
      FFFF6D6D6DFF10B1FFFF0000000000000000B88248FFB88248FFB88248FFB882
      48FFB88248FFB88248FFB88248FF00000000030303044C4C4C4DB88248FFB882
      48FFB88248FFB88248FFB88248FF4C4C4C4D000000000000000ACB9C8BFFFEFD
      FCFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF8F2EEFFEDE9E7FF85ABC7FF50AE
      DAFFDEFEFDFF6DDDF8FF2B7AC2FF17438BFFD77610FFD77610FFD77610FFD776
      10FF92500CAE180C011C190D021D93500BB094510BB21A0D011F160C021B8F4F
      0AACD77610FFD77610FFD77610FFD77610FF000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8FE8FF8F8FE8FFFFFF
      FFFF6D6D6DFF10B1FFFF00000000000000004C4C4C4DB88248FFB88248FFB882
      48FFB88248FFB88248FF4C4C4C4D0000000000000000B88248FFB88248FFB882
      48FFB88248FFB88248FFB88248FFB88248FF0000000000000009CFA08DFFFEFE
      FDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF8F4EFFFEFECE9FF89AE
      CAFF53B1DCFFDEFEFDFF4EA6D4FF102B4E93D77610FFD77610FFBD680EE24224
      044F030200035E340771CD700FF3D77610FFD77610FFCD700FF3613508730302
      00044023054DBD690EE0D77610FFD77610FF000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF0000000000000000000000004C4C4C4DB88248FFB882
      48FFB88248FF4C4C4C4D00000000000000000000000000000000000000006564
      6466B88248FFA79E94B700000000000000000000000000000009D0A393FFFEFE
      FDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4EFFFFAF6F1FFF3EF
      EDFF83A0B8FF347EBCFF1639598F0000000CD37410FC7742088E0A06000C2C17
      0334AC5F0DCDD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFAD5E
      0DCE2D1803350A04000C7541088CD37310FB000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF000000000000000000000000000000005A59595BB882
      48FF4C4C4C4D00000000000000000000000000000000000000002D2D2D2EADA1
      94BFB88248FF6E6D6C7000000000000000000000000000000008D3A897FFFEFE
      FEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5F1FFFBF5F0FFFAF6
      F3FFE2CCC4FF000000160000000600000001291602320B05010D7A420A90D375
      10FCD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD47510FC7B4309920C07000E28160331000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF000000000000000000000000000000000F0F0F104C4C
      4C4D0101000175737277656464661E1E1E1F1E1E1E1F65646466ADA194BFB882
      48FFA49C93B01C1C1C1D00000000000000000000000000000007D3AB9AFFFFFE
      FEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F2FFFBF6
      F1FFD1A494FF0000000C000000000000000044250551BF690EE3D77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFBF690EE446260553000000000000000010B1FFFF6D6D
      6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D
      6DFF6D6D6DFF10B1FFFF00000000000000000000000000000000000000000101
      00016C6B6A6EB88248FFB88248FFB88248FFB88248FFB88248FFB88248FFA49C
      93B0383838390000000000000000000000000000000000000006D8AE9DFFFFFF
      FEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7F5FFFBF7F4FFFCF7
      F3FFD3A897FF0000000B0000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF000000000000000010B1FFFF10B1
      FFFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D
      6DFF10B1FFFF10B1FFFF00000000000000000000000000000000000000000000
      00001C1C1C1D6E6D6C70A79E94B7BB9774EABB9774EAA79E94B76E6D6C701C1C
      1C1D000000000000000000000000000000000000000000000006D8B0A0FFFFFF
      FFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8F6FFFBF7F6FFFCF7
      F5FFD4AC9BFF0000000A0000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      00006D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D
      6DFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000005D9B3A3FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFEFEFFFEFEFEFFFEFE
      FEFFD7AE9EFF0000000900000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006A6A6A6D8D8D8DEA8B8B8BEB6E6E6E71000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000003A2857AC0DBB5
      A5FFDAB5A4FFDAB5A4FFDAB4A4FFD9B3A3FFD9B3A3FFD9B3A2FFD9B2A2FFD8B2
      A2FF9F8376C20000000600000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C003FFFFF80FFFFFC003FFFFF807FFFF
      C003F00F80030000C003E00F80010000C003C01780000000C003C3E380000000
      C003C7C180000000C003010080000000C003018080000000C00383E380000000
      C003C7C380000000C003C00380030000C003E00780030000C003F00F80030000
      F00FFFFF8003FFFFFC3FFFFF8003FFFF00000000000000000000000000000000
      000000000000}
  end
  object UniImageList32: TUniImageList
    Left = 351
    Top = 315
    Bitmap = {
      494C010104000C00040020002000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000800000004000000001002000000000000080
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000011B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1
      FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1
      FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000001000000030000000B000000160000
      001A000000140000000D00000007000000040000000200000001000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000011B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1
      FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1
      FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000010000000100000001000000020000000600000016442D25FF2315
      0FDA0F0A0688020101350000001C000000110000000900000004000000020000
      0001000000010000000100000001000000010000000100000001000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000010000
      0002000000040000000600000007000000080000000D0000001E4D372ED8A07B
      6EFF534548FF282B46F715244EB5060B195C0000001E000000120000000B0000
      0008000000080000000800000008000000080000000700000005000000020000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000020000
      00070000000F00000017000000190000001B0000001F0000002B271C178D826F
      6BFFADCAE6FF7392BFFF415C99FF2D468AFF101B3EA500000036000000270000
      00200000001E0000001D0000001E0000001D0000001A00000012000000080000
      0002000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000040000
      000F785548C1A57664FFA67565FFA57463FFA47262FFAE887BFFB49D96FF5B5E
      79FFDBE3EFFFA2C2E2FF7796C2FF526CA2FF305094FF586188FFB9A49CFFAF8D
      81FF9D6B5BFF9D6D5CFF9E6C5BFF9E6B5AFF9E6B5AFF6F4B3FC3000000130000
      000400000001000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002727
      27286A69676E998F85A7B2977CD5B78A5CF4B78A5CF4B2977CD5998F85A76A69
      676E272727280000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000050000
      0015A87867FFF9F4F0FFF9F4F0FFF9F3EFFFF8F2EDFFF2ECE7FFE6E4E2FF7B8E
      B5FF8B9FC7FFCED9E9FF1F84DBFF50A9E2FF1451AAFF144A9EFF6B7DA5FFE1DD
      DAFFEDE7E2FFF2E8E2FFF4EBE3FFF4EBE4FFF4EAE3FF9E6C5BFF000000190000
      000700000001000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001A1A1A1B7B787480B297
      78DBB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB882
      49FFB29778DB7B7874801A1A1A1B000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000060000
      0016AA7A69FFF9F4F1FFF3E9E2FFF3E9E1FFF2E8E0FFF0E5DEFFEBE4DFFFB9BE
      C8FF4A6BABFFFFFFFFFF4CA3E5FF2289DFFF55ADE3FF1557ACFF164EA0FF6C7E
      A5FFE1DAD7FFEBE3DDFFEEE2D9FFF1E4DBFFF5EBE5FF9E6E5DFF0000001B0000
      000700000001000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003D3D3D3EA09486B3B88249FFB882
      49FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB882
      49FFB88249FFB88249FFA09486B3363636370000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000050000
      0016AC7C6CFFFAF5F2FFF3EAE2FFF3EAE2FFF4E9E2FFF3E8E0FFEFE6E0FFE7E3
      DFFF8B9BBAFF6890C2FFC2E5F8FF4FA7E6FF2691E0FF5CB1E5FF195CAFFF1852
      A4FF6E82A8FFE2DBD8FFEBE3DDFFEFE2D9FFF4EBE4FFA16F5FFF0000001B0000
      000700000001000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF8A8AE7FF8A8AE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003D3D3D3EAA9884C4B88249FFB88249FFB882
      49FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB882
      49FFB88249FFB88249FFB69473E31B1B1B1C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000050000
      0015AE8070FFFAF6F3FFF4EAE3FFF4EAE3FFF3EAE2FFF2E8E1FFF1E7E0FFF0E7
      E3FFE5E1DDFF81A1C1FF4490D0FFC7E8F8FF55AEE7FF2B97E1FF61B5E6FF1A61
      B2FF1A56A6FF7085ACFFE4DEDAFFECE4DEFFF2EAE4FFA27161FF0000001A0000
      000700000001000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF8A8AE7FF1818D1FF1818D1FF8A8AE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000001A1A1A1BA09486B3B88249FFB88249FFB88249FFB882
      49FFAD9882CB7A77737F3E3E3E3F11111112111111123E3E3E3F7A77737FAD98
      82CBB88249FFB69473E323232324000000004C4B4B4D00000000000000000000
      0000000000000000000000000000000000000000000000000000000000050000
      0014B08372FFFAF7F4FFF4EBE4FFF4EAE4FFF4EAE3FFF4EAE3FFF2E9E2FFF2E8
      E1FFEFE7E3FFE6E3DFFF83A4C5FF4795D2FFCBEBFAFF59B4EBFF309DE4FF66BA
      E7FF1D64B6FF1C5CA9FF7289AEFFE4E0DBFFEFE9E5FFA47262FF0000001A0000
      000600000001000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFF8A8A
      E7FF1818D1FF1818D1FF1818D1FF1818D1FF8A8AE7FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B787480B88249FFB88249FFB88249FFB88249FF8F87
      8198242424250000000000000000000000000000000000000000000000002424
      2425807C788723232324000000004C4B4B4DB88249FF4C4B4B4D000000000000
      0000000000000000000000000000000000000000000000000000000000050000
      0013B18474FFFBF7F5FFF4ECE5FFF6EBE4FFF6EBE4FFF4EBE4FFF4EBE3FFF3EA
      E2FFF2E8E1FFEFE8E3FFE8E4E0FF86A7C7FF4B9AD4FFCFEEFBFF5FB9EDFF35A5
      E9FF6DBEE8FF1F6AB9FF1F60ADFF748CB2FFE8E5E2FFB79488FF0000001A0000
      000700000001000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFF8A8AE7FF1818
      D1FF1818D1FF1818D1FF1818D1FF1818D1FF1818D1FF8A8AE7FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      00000000000027272728B29778DBB88249FFB88249FFB88249FF8F8781980A0A
      0A0B000000000000000000000000000000000000000000000000000000000000
      000005050506000000004C4B4B4DB88249FFB88249FFB88249FF4C4B4B4D0303
      0304000000000000000000000000000000000000000000000000000000040000
      0012B38676FFFCF8F5FFF6ECE6FFF6ECE6FFF6ECE5FFF4EBE5FFF4EBE5FFF4EB
      E4FFF4EBE4FFF2E9E2FFF1E9E4FFE9E6E2FF88AAC9FF4E9FD7FFD3F0FCFF63BE
      EFFF3AABEBFF71C2EAFF2270BCFF2165AFFF7892B7FFC5AFA7FF0000001F0000
      000800000002000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFBD670EE14223044E3E21044ABB660EDFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFF9191E9FF1818
      D1FF1818D1FF9191E9FF9191E9FF1818D1FF1818D1FF1818D1FF8A8AE7FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000006A69676EB88249FFB88249FFB88249FFAD9882CB242424250000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004C4B4B4DB88249FFB88249FFB88249FFB88249FFB88249FF4C4B
      4B4D141414150000000000000000000000000000000000000000000000040000
      0011B58A79FFFCF8F7FFF7EDE8FFF6ECE6FFF4EDE6FFF4ECE6FFF4ECE6FFF6EC
      E5FFF4ECE4FFF4EBE4FFF2E9E2FFF1EAE4FFEBE7E4FF8BAECCFF51A3D8FFD6F2
      FCFF69C5F0FF41B2EBFF76C6ECFF2576C0FF246AB4FF6A7B9EFF000000260000
      000D00000003000000010000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD37410FC7641088D0A06000C00000000000000000904000B743F0989D273
      10FBD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFF9191
      E9FF9191E9FFFFFFFFFFFFFFFFFF9191E9FF1818D1FF1818D1FF1818D1FF8A8A
      E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      000000000000998F85A7B88249FFB88249FFB88249FF7A77737F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004C4B4B4DB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB882
      49FF4C4B4B4D0000000000000000000000000000000000000000000000040000
      0010B78A7AFFFCF9F7FFF7EDE8FFF7EDE9FFF6EDE8FFF6EDE6FFF6EDE6FFF6EC
      E6FFF6ECE5FFF6ECE5FFF6ECE4FFF2E9E2FFF2EBE6FFEDE9E6FF8DB1CEFF55A8
      DAFFD9F4FDFF89D5F6FF46BBEFFF7ACBECFF297CC1FF2770B7FF191C25990000
      001400000007000000020000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFAA5D
      0CCA2A1603310000000000000000000000000000000000000000000000002615
      032EA75C0BC7D77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9191E9FF1818D1FF1818D1FF1818
      D1FF8A8AE7FFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      000000000000B2977CD5B88249FFB88249FFB88249FF3E3E3E3F000000000000
      0000000000000000000000000000000000000000000000000000000000004C4B
      4B4DB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB882
      49FFB88249FF4C4B4B4D00000000000000000000000000000000000000040000
      000FB98D7DFFFCFAF8FFF7EFE9FFF7EFE9FFF7EFE9FFF7EFE8FFF6EDE8FFF6ED
      E8FFF6EDE6FFF6EDE6FFF4ECE6FFF6ECE6FFF3EBE4FFF3ECE7FFEEE9E7FF8FB4
      D0FF59ADDCFFDCF6FDFF73CFF6FF4BC0F0FF80D0EEFF77767AFF784939FF2910
      0A900000000F000000060000000200000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFCB700FF25B32066E0200
      00030000000000000000190D011E96520BB199530AB51B0F0220000000000000
      0000020100025930076AC96F0FF0D77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9191E9FF1818D1FF1818
      D1FF1818D1FF8A8AE7FFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000004C4B4B4DB88249FFB88249FFB882
      49FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB882
      49FFB88249FFB88249FF4C4B4B4D0000000000000000000000004C4B4B4DB882
      49FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB882
      49FFB88249FFB88249FF4C4B4B4D000000000000000000000000000000040000
      000EBB9080FFFCFAF8FFF7F0EAFFF7F0E9FFF6EFE9FFF7EFE9FFF7EFE8FFF7EF
      E9FFF6EDE8FFF7EDE8FFF7EDE6FFF6EDE6FFF6EDE6FFF5EBE4FFF3EDE7FFF0EB
      E8FF91B7D3FF5CB0DEFFDEF8FEFF79D6F7FF90B9C5FFD8C1B3FF996A58FF8150
      40FF180D218D0000000C0000000500000001D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF91500CAD160C021B000000000000
      00000302000460340872CD700FF3D77610FFD77610FFCD700FF5633607760401
      00050000000000000000140B01198D4E0BA9D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9191E9FF1818
      D1FF1818D1FF9191E9FFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF00000000000000000000000000000000000000004C4B4B4DB88249FFB882
      49FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB882
      49FFB88249FF4C4B4B4D0000000000000000000000004C4B4B4DB88249FFB882
      49FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB882
      49FFB88249FFB88249FFB88249FF4C4B4B4D0000000000000000000000030000
      000DBD9283FFFDFBF9FFF8F1EBFFF8F0EBFFF7F0EBFFF7F0EAFFF7F0EAFFF7F0
      E9FFF7EFE9FFF6EFE9FFF7EDE8FFF6EDE8FFF6EDE8FFF6EDE8FFF5EBE5FFF5EE
      E9FFF1EDE9FF93B9D5FF5FB4E0FFE7F7F9FFDBC3B1FFCFB39FFFDBC5B8FF574A
      8BFF201F95FF09093D8B0000000B00000004D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFBD670EE14223044E0000000000000000000000002C18
      0335AD5E0DCED77610FFD77610FFD77610FFD77610FFD77610FFD77610FFAF60
      0DD12F1903380000000000000000000000003E21044ABB660EDFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9191
      E9FF9191E9FFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF0000000000000000000000000000000000000000000000004C4B4B4DB882
      49FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB882
      49FF4C4B4B4D0000000000000000000000000000000000000000000000000000
      000000000000000000003E3E3E3FB88249FFB88249FFB88249FFB2977CD50000
      0000000000000000000000000000000000000000000000000000000000030000
      000DBE9585FFFBF8F7FFF8F2ECFFF8F1EBFFF7F1EBFFF7F1EBFFF7F0EBFFF8F0
      EAFFF7F0EAFFF7EFEAFFF7EFEAFFF7EDE9FFF6EFE8FFF6EFE8FFF6EDE8FFF6EC
      E7FFF5EEE9FFF2EEEBFFA9AEB7FFB58F7DFFFAF0E2FFDFC8B6FF9A97C5FF8791
      E3FF2A2DAAFF24249CFF0E0E458900000006D77610FFD77610FFD77610FFD776
      10FFD37410FC7641088D0A06000C00000000000000000A05000E7A430A91D475
      10FCD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD47410FD7E4509950D06000F00000000000000000904000B743F0989D273
      10FBD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000004C4B
      4B4DB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FF4C4B
      4B4D000000000000000000000000000000000000000000000000000000000000
      000000000000000000007A77737FB88249FFB88249FFB88249FF998F85A70000
      0000000000000000000000000000000000000000000000000000000000030000
      000CC09687FFF8F5F2FFF6EFE9FFF8F2ECFFF8F1ECFFF8F1ECFFF7F1ECFFF7F0
      EBFFF8F1EAFFF8F0EAFFF7F0EAFFF7F0E9FFF7F0E9FFF6EFE9FFF6EDE9FFF7ED
      E9FFF6EEE8FFF6EFECFFF4EFEDFFC2A59DFFBC9788FFF6EEE7FF8B9FEDFF6174
      E1FF98A2E7FF7A85D0FF262996FF00000007D77610FFD77610FFD77610FFAA5D
      0CCA2A16033100000000000000000000000045250552BF690EE4D77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFC26A0EE6472706560000000000000000000000002615
      032EA75C0BC7D77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000001414
      14154C4B4B4DB88249FFB88249FFB88249FFB88249FFB88249FF4C4B4B4D0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000024242425AD9882CBB88249FFB88249FFB88249FF6A69676E0000
      0000000000000000000000000000000000000000000000000000000000030000
      000BC39889FFF6EFEDFFF4EBE6FFF6EFEAFFF8F2EDFFF8F2EDFFF8F1EDFFF8F1
      ECFFF8F1ECFFF8F1EBFFF8F0EBFFF8F0EAFFF7EFEAFFF7F0EAFFF7EFEAFFF7F0
      E9FFF7EFE9FFF5ECE8FFF7EFECFFF5F0EEFFB1A5BDFF6A77D4FFDBE7FCFF8BA0
      EEFFACC0F3FF4D56C3FF21235A8400000004D77610FFCB700FF25B32066E0200
      00030000000000000000190D011E96520BB1D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF99530AB51B0F0220000000000000
      0000020100025930076AC96F0FF0D77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000030303044C4B4B4DB88249FFB88249FFB88249FF4C4B4B4D000000000404
      0405000000000000000000000000000000000000000000000000000000000000
      00000A0A0A0B8F878198B88249FFB88249FFB88249FFB29778DB272727280000
      0000000000000000000000000000000000000000000000000000000000020000
      000AC49A8AFFF1E9E6FFF0E6E2FFF4EBE7FFF5EEEBFFF7F1ECFFF7F1ECFFF8F2
      EDFFF7F0EBFFF8F1EDFFF7F1ECFFF8F1ECFFF7F0EBFFF7F0EAFFF7F0EBFFF7EF
      EAFFF7EFEAFFF7EFEAFFF7EFE9FFF6F1ECFFF9F7F6FF928BBDFF7080DAFFDCE8
      FCFF6574D7FF25296083000000050000000291500CAD160C021B000000000000
      00000302000460340872CD700FF3D77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFCD700FF5633607760401
      00050000000000000000140B01198D4E0BA90000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000004C4B4B4DB88249FF4C4B4B4D000000001F1F1F207F7B
      7785242424250000000000000000000000000000000000000000000000002424
      24258F878198B88249FFB88249FFB88249FFB88249FF7B787480000000000000
      0000000000000000000000000000000000000000000000000000000000020000
      0009C69C8CFFE8DDD8FFE8DBD4FFECDFDBFFEFE4E0FFF1E8E3FFF4EBE8FFF6ED
      E9FFF7F1ECFFF8F2EFFFF8F1EDFFF8F1ECFFF8F1ECFFF8F1ECFFF8F1EBFFF8F1
      EBFFF7F0EBFFF7F0EBFFF7EFEAFFF7EFEAFFFBF8F6FFDAC5BDFF2B3066885660
      CEFF2B3066810000000400000002000000010000000000000000000000002C18
      0335AD5E0DCED77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFAF60
      0DD12F1903380000000000000000000000000000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004C4B4B4D000000001F1F1F20B59674DFB882
      49FFAD9882CB7A77737F3E3E3E3F11111112111111123E3E3E3F7A77737FAD98
      82CBB88249FFB88249FFB88249FFB88249FFA09486B31A1A1A1B000000000000
      0000000000000000000000000000000000000000000000000000000000020000
      0008C79E8DFFD9C4BCFFD9C4B9FFDCC6BEFFDECBC4FFE1CFC8FFE6D5D0FFEDE0
      DAFFF4EBE6FFF8F2EDFFF7F1EEFFF9F2EFFFF8F2EFFFF8F2EDFFF8F1ECFFF8F1
      ECFFF7F1ECFFF7F0EBFFF7F0EBFFF7F1EAFFFCF8F5FFCCAB9FFF0000000F0000
      000500000002000000010000000000000000000000000A05000E7A430A91D475
      10FCD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD47410FD7E4509950D06000F000000000000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000018181819B59674DFB88249FFB882
      49FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB882
      49FFB88249FFB88249FFB88249FFAA9884C43D3D3D3E00000000000000000000
      0000000000000000000000000000000000000000000000000000000000010000
      0006C8A08FFFCDB1A7FFA37262FFA47262FFA47363FFA47463FFA57665FFB38B
      7BFFEEE3DDFFF7EEECFFF9F3EFFFF9F3EFFFF9F2EFFFF9F3EDFFF9F2EDFFF8F1
      EDFFF8F1ECFFF8F1ECFFF8F1ECFFF8F1ECFFFCF9F7FFBE9384FF0000000D0000
      00030000000000000000000000000000000045250552BF690EE4D77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFC26A0EE6472706560000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000035353536A09486B3B88249FFB882
      49FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB882
      49FFB88249FFB88249FFA09486B33D3D3D3E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000010000
      0004553D3583D5B9AEFFFCF9F7FFFEFCFAFFFFFDFCFFFFFEFEFFFFFFFFFFAB7D
      6CFFEADDD7FFF5EEEAFFF9F3F1FFF9F4F0FFF9F3F0FFF9F3F0FFF9F3EFFFF9F3
      EFFFF8F2EFFFF8F2EDFFF8F2EDFFF8F2EDFFFCF9F7FFC09687FF0000000C0000
      000300000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001A1A1A1B7B787480B297
      78DBB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB88249FFB882
      49FFB29778DB7B7874801A1A1A1B000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00020000000559403883D7BAB0FFFCF6F3FFFDF9F7FFFEFBFAFFFFFEFEFFB085
      73FFEADDD6FFF5EEEAFFFAF6F1FFF9F4F1FFF9F4F1FFF9F4F1FFF9F4F0FFF9F3
      EFFFF9F3EFFFF8F3EFFFF9F2EFFFF9F2EFFFFDFAF8FFC29888FF0000000B0000
      000300000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF11B1FFFF11B1FFFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF11B1FFFF11B1FFFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002727
      27286A69676E998F85A7B2977CD5B78A5CF4B78A5CF4B2977CD5998F85A76A69
      676E272727280000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000100000002000000055B433A83D8BCB3FFFBF6F3FFFDF9F6FFFFFEFEFFB68C
      7CFFE9DBD5FFF4EBE7FFF7F3F0FFFAF6F2FFF9F4F2FFF9F4F1FFF9F4F1FFFAF4
      F1FFF9F3F0FFF9F3F0FFF9F3F0FFF8F2EFFFFDFAF9FFC49989FF0000000A0000
      000300000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      000011B1FFFF11B1FFFF11B1FFFF11B1FFFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF11B1FFFF11B1FFFF11B1FFFF11B1
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000002000000045D453D83DBC0B5FFFBF6F3FFFFFEFEFFBC95
      84FFE8DCD5FFF0E8E4FFF5EFEBFFF8F3F0FFFAF6F2FFFAF6F2FFF9F6F1FFF9F6
      F1FFF9F4F1FFF9F4F1FFF9F4F0FFF9F4F0FFFDFAF9FFC59B8BFF000000090000
      000200000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000006E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000001000000045E483F82DDC2B8FFFFFEFEFFC19B
      8BFFE7DAD3FFEEE3DFFFF3EBE6FFF5F0ECFFF8F4F0FFFAF7F3FFFAF7F3FFFAF6
      F2FFF9F4F2FFFAF4F1FFF9F4F1FFFAF4F0FFFDFBFAFFC79D8EFF000000080000
      0002000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E
      6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000100000003604B4382E2CAC2FFDECA
      C3FFE8DAD6FFEEE4E0FFF2EBE9FFF6F1EFFFFAF7F6FFFFFEFEFFFEFEFDFFFEFE
      FDFFFEFEFDFFFEFEFDFFFEFDFDFFFEFDFDFFFEFDFDFFC89F8FFF000000070000
      0002000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006C6C6C73717171FE6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF6E6E6EFF7272
      727B000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000100000003634D4681CEA5
      96FFCEA695FFCDA595FFCDA595FFCDA495FFCDA495FFCDA394FFCDA394FFCDA3
      94FFCBA293FFCBA293FFCBA291FFCBA191FFCAA191FF95766ABF000000040000
      0001000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000043434344919191BA7E7E7EF17C7C7CF2919191BD474747490000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000020000
      0003000000030000000400000004000000040000000400000004000000050000
      0005000000050000000500000005000000050000000500000004000000020000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000400000000100010000000000000400000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F000000FFFFFFFFFFE003FFFFFFFFFFF
      F000000FFFFFFFFFF000003FFFFFFFFFF000000FFFFFFFFFC000000FFFFFFFFF
      F000000FFFFFFFFFC000000FFFFFFFFFF000000FFFFFFFFF8000000700000000
      F000000FFFE007FF8000000700000000F000000FFF8001FF8000000700000000
      F000000FFF0000FF8000000700000000F000000FFE0000FF8000000700000000
      F000000FFC00017FC000000700000000F000000FFC07E23FC000000700000000
      F000000FF80FF40FC000000700000000F000000FF81FF807C000000300018000
      F000000FF83FF007C00000030007E000F000000FF83FE003C0000001000C3000
      F000000F0001C001C000000000300C00F000000F80038000C000000000E00700
      F000000FC007FC1FC000000001800180F000000FE00FFC1FC0000000070000E0
      F000000FE01FF81FC00000000C000030F000000FF02FF01FC00000003000000C
      F000000FFC47E03FC0000000E0000007F000000FFE80003FC000000380000001
      F000000FFF00007FC000000F00000000F000000FFF0000FFC000000F00000000
      F000000FFF8001FFE000000F00000000F000000FFFE007FFE000000F00000000
      F000000FFFFFFFFFF800000F00000000FF0000FFFFFFFFFFFC00000FFFFFFFFF
      FF0000FFFFFFFFFFFE00000FFFFFFFFFFFF00FFFFFFFFFFFFF00000FFFFFFFFF
      FFF81FFFFFFFFFFFFF80001FFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ppMain: TUniPopupMenu
    OnPopup = ppMainPopup
    Left = 241
    Top = 218
    object N2: TUniMenuItem
      Action = actReOrder
    end
    object N1: TUniMenuItem
      Action = actCancelСonfirm
    end
  end
end
