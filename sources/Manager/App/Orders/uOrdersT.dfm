object OrdersT: TOrdersT
  Left = 0
  Top = 0
  Width = 1640
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
  Anchors = []
  ShowHint = True
  ParentShowHint = False
  TabOrder = 0
  object UniPanel2: TUniPanel
    Left = 0
    Top = 0
    Width = 1640
    Height = 596
    Hint = ''
    Margins.Bottom = 0
    ShowHint = True
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = 'UniPanel2'
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'fit'
    LayoutConfig.Flex = 1
    LayoutConfig.Width = '100'
    object Grid: TUniDBGrid
      Left = 0
      Top = 113
      Width = 1640
      Height = 483
      Hint = ''
      Margins.Bottom = 0
      ShowHint = True
      BodyRTL = False
      ClientEvents.ExtEvents.Strings = (
        
          'beforerender=function beforerender(sender, eOpts)'#13#10'{'#13#10'    var me' +
          '=sender.checkboxModel;'#13#10'    if (me) {'#13#10'        // '#1089#1082#1088#1099#1074#1072#1077#1084' Check' +
          'box '#1089' '#1079#1072#1075#1086#1083#1086#1074#1082#1072' '#1090#1072#1073#1083#1080#1094#1099#13#10'        me.showHeaderCheckbox=true;'#13#10'  ' +
          '  }'#13#10'}'
        
          'columnhide=function columnhide(ct, column, eOpts)'#13#10'{'#13#10'  if (colu' +
          'mn.dataIndex >= 0) { //column.dataIndex >= 0 '#1080#1089#1087#1088#1072#1074#1083#1077#1085#1080#1077' Argumen' +
          't out of range'#13#10'    ajaxRequest(this, '#39'_columnhide'#39', ["column=" ' +
          '+ column.dataIndex, "hidden=" + column.hidden]);'#13#10'  }'#13#10'}'
        
          'columnshow=function columnshow(ct, column, eOpts)'#13#10'{'#13#10'  ajaxRequ' +
          'est(this, '#39'_columnshow'#39', ["column=" + column.dataIndex, "hidden=' +
          '" + column.hidden]);'#13#10'}')
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
          'r.getDockedItems()[1];'#13#10'  toolbar.items.getAt(9).hide();'#13#10'  tool' +
          'bar.items.getAt(10).hide();'#13#10'  '#13#10'  // '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1074' '#1087#1072#1085#1077#1083#1100' ' +
          #1085#1072#1074#1080#1075#1072#1094#1080#1080#13#10'  if (!toolbar.exportBtn) {'#13#10'     toolbar.exportBtn =' +
          ' toolbar.insert('#13#10'       0, '#13#10'       //{ xtype: '#39'tbseparator'#39' }'#13 +
          #10'       {xtype: '#39'button'#39', text: '#39#39', tooltip : '#39#1054#1087#1080#1089#1072#1085#1080#1077' '#1089#1090#1072#1090#1091#1089#1086#1074 +
          ' '#1079#1072#1082#1072#1079#1086#1074#39', handler: function() {'#13#10'          ajaxRequest(sender, ' +
          '"btnStatusFormShow", {})'#13#10'       }}'#13#10'     );'#13#10'     toolbar.expor' +
          'tBtn.setIconCls('#39'StatusIcons'#39');// icon...'#13#10'  }  '#13#10'}'
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
          'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
          'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
          'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
          't.body.removeChild(el);'#13#10'    };'#13#10'}'#13#10#13#10
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'  config.displayInfo=true;'#13#10'}')
      HeaderTitleAlign = taCenter
      PagingBarAuxControl = pnlGridSelectedCount
      DataSource = DataSource
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgRowSelect, dgCheckSelect, dgCheckSelectCheckOnly, dgAlwaysShowSelection, dgMultiSelect, dgTabs, dgDontShowSelected, dgRowNumbers]
      WebOptions.PageSize = 500
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      Grouping.ShowCaption = False
      Grouping.ShowValue = False
      LoadMask.WaitData = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Target = Owner
      LoadMask.Color = 13421772
      EmptyText = 
        '<div style="text-align: center;"><i class="fas fa-exclamation"><' +
        '/i> '#1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ... </div>'
      LayoutConfig.ComponentCls = 'grid-order'
      BorderStyle = ubsNone
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
      OnDblClick = GridDblClick
      OnCellContextClick = GridCellContextClick
      OnDrawColumnCell = GridDrawColumnCell
      OnColumnResize = GridColumnResize
      Columns = <
        item
          FieldName = 'Flag'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089#1099' (Flag)'
          Width = 64
          Visible = False
          ReadOnly = True
          Hint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1087#1088#1080#1079#1085#1072#1082#1080' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1079#1091#1102#1097#1080#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077' '#1079#1072#1082#1072#1079#1072' (Flag)'
          Sortable = True
        end
        item
          FieldName = 'Status'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089#1099
          Width = 64
          Alignment = taLeftJustify
          Hint = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1087#1088#1080#1079#1085#1072#1082#1080' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1079#1091#1102#1097#1080#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077' '#1079#1072#1082#1072#1079#1072
        end
        item
          ShowToolTip = True
          FieldName = 'OrderID'
          Title.Alignment = taCenter
          Title.Caption = #1048#1044' '#1047#1072#1082#1072#1079#1072
          Width = 95
          ReadOnly = True
          Hint = #1048#1044' '#1047#1072#1082#1072#1079#1072
          Sortable = True
        end
        item
          FieldName = 'ClientID'
          Title.Alignment = taCenter
          Title.Caption = #1048#1044' '#1050#1083#1080#1077#1085#1090#1072
          Width = 85
          Visible = False
          ReadOnly = True
          Hint = #1048#1044' '#1050#1083#1080#1077#1085#1090#1072
          Sortable = True
        end
        item
          FieldName = 'ClientName'
          Title.Alignment = taCenter
          Title.Caption = #1050#1083#1080#1077#1085#1090
          Width = 96
          ReadOnly = True
          Hint = #1050#1083#1080#1077#1085#1090
          Sortable = True
        end
        item
          FieldName = 'OrderDate'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072
          Width = 97
          ReadOnly = True
          Hint = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072
          Sortable = True
        end
        item
          ShowToolTip = True
          FieldName = 'PriceLogo'
          Title.Alignment = taCenter
          Title.Caption = #1051#1086#1075#1086' '#1087#1088#1072#1081#1089#1072' '#1082#1083#1080#1077#1085#1090#1072
          Width = 86
          ReadOnly = True
          Hint = #1051#1086#1075#1086' '#1087#1088#1072#1081#1089#1072' '#1082#1083#1080#1077#1085#1090#1072
          Sortable = True
        end
        item
          FieldName = 'OrderNum'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072
          Width = 103
          ReadOnly = True
          Hint = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072' (OrderNum)'
          Sortable = True
        end
        item
          FieldName = 'StatusName'
          Title.Alignment = taCenter
          Title.Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077
          Width = 173
          ReadOnly = True
          Hint = #1057#1090#1072#1090#1091#1089
          Sortable = True
        end
        item
          FieldName = 'isCancel'
          Title.Alignment = taCenter
          Title.Caption = #1054#1090#1082#1072#1079
          Width = 84
          ReadOnly = True
          Hint = #1054#1090#1082#1072#1079
          Sortable = True
        end
        item
          FieldName = 'MakeLogo'
          Title.Alignment = taCenter
          Title.Caption = #1041#1088#1077#1085#1076' '#1051#1086#1075#1086
          Width = 65
          ReadOnly = True
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
          Filtering.Enabled = True
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
          Width = 135
          ReadOnly = True
          Hint = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' (DetailNumber)'
          Sortable = True
        end
        item
          ShowToolTip = True
          ShowToolTipAlways = False
          FieldName = 'DetailName'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1077#1090#1072#1083#1080
          Width = 150
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'DetailID'
          Title.Alignment = taCenter
          Title.Caption = 'ID '
          Width = 112
          ReadOnly = True
          Hint = 'ID (DetailID)'
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
          Title.Caption = #1062#1077#1085#1072' '#1087#1088#1086#1076#1072#1078#1080
          Width = 108
          ReadOnly = True
          Hint = #1062#1077#1085#1072' '#1087#1088#1086#1076#1072#1078#1080' (Price)'
          Sortable = True
        end
        item
          FieldName = 'Amount'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1087#1088#1086#1076#1072#1078#1080
          Width = 110
          ReadOnly = True
          Hint = #1057#1091#1084#1084#1072' '#1087#1088#1086#1076#1072#1078#1080' (Amount)'
          Sortable = True
        end
        item
          FieldName = 'PricePurchase'
          Title.Alignment = taCenter
          Title.Caption = #1062#1077#1085#1072' '#1079#1072#1082#1091#1087#1082#1080
          Width = 100
          ReadOnly = True
          Hint = #1062#1077#1085#1072' '#1079#1072#1082#1091#1087#1082#1080' (PricePurchase)'
          Sortable = True
        end
        item
          FieldName = 'AmountPurchase'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1079#1072#1082#1091#1087#1082#1080
          Width = 100
          ReadOnly = True
          Hint = #1057#1091#1084#1084#1072' '#1079#1072#1082#1091#1087#1082#1080' (AmountPurchase)'
          Sortable = True
        end
        item
          FieldName = 'PricePurchaseF'
          Title.Alignment = taCenter
          Title.Caption = #1062#1077#1085#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1092#1072#1082#1090
          Width = 100
          ReadOnly = True
          Hint = #1062#1077#1085#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1092#1072#1082#1090' (PricePurchaseF)'
          Sortable = True
        end
        item
          FieldName = 'AmountPurchaseF'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1092#1072#1082#1090
          Width = 100
          ReadOnly = True
          Hint = #1057#1091#1084#1084#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1092#1072#1082#1090' (AmountPurchaseF)'
          Sortable = True
        end
        item
          FieldName = 'WeightKG'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1080#1079' '#1087#1088#1072#1081#1089#1072
          Width = 100
          ReadOnly = True
          Hint = #1042#1077#1089' '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1080#1079' '#1087#1088#1072#1081#1089#1072' (WeightKG)'
          Sortable = True
        end
        item
          FieldName = 'VolumeKG'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1054#1073#1098#1077#1084#1085#1099#1081' '#1080#1079' '#1087#1088#1072#1081#1089#1072
          Width = 100
          ReadOnly = True
          Hint = #1042#1077#1089' '#1054#1073#1098#1077#1084#1085#1099#1081' '#1080#1079' '#1087#1088#1072#1081#1089#1072' (VolumeKG)'
          Sortable = True
        end
        item
          FieldName = 'WeightKGF'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1092#1072#1082#1090
          Width = 100
          ReadOnly = True
          Hint = #1042#1077#1089' '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1092#1072#1082#1090
          Sortable = True
        end
        item
          FieldName = 'VolumeKGF'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089' '#1054#1073#1098#1077#1084#1085#1099#1081' '#1092#1072#1082#1090
          Width = 100
          ReadOnly = True
          Hint = #1042#1077#1089' '#1054#1073#1098#1077#1084#1085#1099#1081' '#1092#1072#1082#1090
          Sortable = True
        end
        item
          FieldName = 'Margin'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1094#1077#1085#1082#1072' '#1080#1079' '#1087#1088#1072#1081#1089#1072
          Width = 100
          ReadOnly = True
          Hint = #1053#1072#1094#1077#1085#1082#1072' '#1080#1079' '#1087#1088#1072#1081#1089#1072
          Sortable = True
        end
        item
          FieldName = 'MarginF'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1094#1077#1085#1082#1072' '#1092#1072#1082#1090
          Width = 100
          ReadOnly = True
          Hint = #1053#1072#1094#1077#1085#1082#1072' '#1092#1072#1082#1090
          Sortable = True
        end
        item
          FieldName = 'Profit'
          Title.Alignment = taCenter
          Title.Caption = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
          Width = 100
          ReadOnly = True
          Hint = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
          Sortable = True
        end
        item
          FieldName = 'Income'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1093#1086#1076' '#8381
          Width = 100
          ReadOnly = True
          Hint = #1044#1086#1093#1086#1076
          Sortable = True
        end
        item
          FieldName = 'DeliveryPlanDateSupplier'
          Title.Alignment = taCenter
          Title.Caption = #1055#1083#1072#1085#1086#1074#1072#1103' '#1076#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1085#1072' '#1089#1082#1083#1072#1076' '#1074' '#1054#1040#1069
          Width = 100
          ReadOnly = True
          Hint = #1055#1083#1072#1085#1086#1074#1072#1103' '#1076#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091' (DeliveryPlanDateSupplier)'
          Sortable = True
        end
        item
          FieldName = 'DeliveryTermSupplier'
          Title.Alignment = taCenter
          Title.Caption = #1057#1088#1086#1082' '#1076#1086' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1085#1072' '#1089#1082#1083#1072#1076' '#1074' '#1054#1040#1069
          Width = 100
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'DeliveryRestTermSupplier'
          Title.Alignment = taCenter
          Title.Caption = #1054#1089#1090#1072#1090#1086#1082' '#1089#1088#1086#1082#1072' '#1076#1086' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1085#1072' '#1089#1082#1083#1072#1076' '#1074' '#1054#1040#1069
          Width = 100
          ReadOnly = True
          Hint = 
            #1054#1089#1090#1072#1090#1086#1082' '#1089#1088#1086#1082#1072' '#1076#1086' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091' (DeliveryRestTermSupplie' +
            'r)'
          Sortable = True
        end
        item
          FieldName = 'DeliveredDateToSupplier'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1089#1090#1072#1074#1083#1077#1085#1072' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Width = 100
          ReadOnly = True
          Hint = #1044#1072#1090#1072' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Sortable = True
        end
        item
          FieldName = 'DeliveryDaysReserve'
          Title.Alignment = taCenter
          Title.Caption = #1044#1085#1077#1081' '#1079#1072#1087#1072#1089#1072' '#1076#1086' '#1074#1099#1083#1077#1090#1072
          Width = 100
          ReadOnly = True
          Hint = #1044#1085#1077#1081' '#1079#1072#1087#1072#1089#1072' '#1076#1086' '#1074#1099#1083#1077#1090#1072' (DeliveryDaysReserve)'
          Sortable = True
        end
        item
          FieldName = 'DeliveryNextDate'
          Title.Alignment = taCenter
          Title.Caption = #1041#1083#1080#1078#1072#1081#1096#1072#1103' '#1076#1072#1090#1072' '#1074#1099#1083#1077#1090#1072
          Width = 100
          ReadOnly = True
          Hint = #1041#1083#1080#1078#1072#1081#1096#1072#1103' '#1076#1072#1090#1072' '#1074#1099#1083#1077#1090#1072' (DeliveryNextDate)'
          Sortable = True
        end
        item
          FieldName = 'DeliveryDateToCustomer'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1082#1083#1080#1077#1085#1090#1091
          Width = 100
          ReadOnly = True
          Hint = #1044#1072#1090#1072' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1082#1083#1080#1077#1085#1090#1091
          Sortable = True
        end
        item
          FieldName = 'DeliveryTermToCustomer'
          Title.Alignment = taCenter
          Title.Caption = #1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1082#1083#1080#1077#1085#1090#1091
          Width = 100
          ReadOnly = True
          Hint = #1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1082#1083#1080#1077#1085#1090#1091
          Sortable = True
        end
        item
          FieldName = 'DeliveryRestToCustomer'
          Title.Alignment = taCenter
          Title.Caption = #1054#1089#1090#1072#1090#1086#1082' '#1089#1088#1086#1082#1072' '#1076#1086' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1082#1083#1080#1077#1085#1090#1091
          Width = 100
          ReadOnly = True
          Hint = #1054#1089#1090#1072#1090#1086#1082' '#1089#1088#1086#1082#1072' '#1076#1086' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1082#1083#1080#1077#1085#1090#1091
          Sortable = True
        end
        item
          FieldName = 'Invoice'
          Title.Alignment = taCenter
          Title.Caption = #1048#1085#1074#1086#1081#1089
          Width = 100
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'CustomerPriceLogo'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1072#1081#1089#1072' '#1080#1079' '#1079#1072#1082#1072#1079#1072
          Width = 388
          ReadOnly = True
          Hint = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1072#1081#1089#1072' '#1080#1079' '#1079#1072#1082#1072#1079#1072' (CustomerPriceLogo)'
          Sortable = True
        end
        item
          FieldName = 'DestinationName'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
          Width = 124
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'FileDate'
          Title.Alignment = taCenter
          Title.Caption = #1042#1088#1077#1084#1103' '#1079#1072#1082#1072#1079#1072
          Width = 135
          ReadOnly = True
          Hint = #1042#1088#1077#1084#1103' '#1092#1072#1081#1083#1072' '#1079#1072#1082#1072#1079#1072
          Sortable = True
        end
        item
          FieldName = 'Warning'
          Title.Caption = #1055#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1077
          Width = 188
          ReadOnly = True
          Hint = 
            '<div style='#39'text-align: center;'#39'><i class='#39'fas fa-question'#39'></i>' +
            ' '#1058#1077#1082#1089#1090#1086#1074#1086#1077' '#1087#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1077' '#1086' '#1087#1088#1086#1073#1083#1077#1084#1072#1093' '#1089' '#1087#1086#1079#1080#1094#1080#1077#1081'</div>'
          Sortable = True
        end
        item
          FieldName = 'OverPricing'
          Title.Caption = #1055#1088#1077#1074#1099#1096#1077#1085#1080#1077' '#1094#1077#1085#1099
          Width = 129
          ReadOnly = True
          Hint = #1055#1088#1077#1074#1099#1096#1077#1085#1080#1077' '#1094#1077#1085#1099
          Sortable = True
        end
        item
          FieldName = 'IncomePRC'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1093#1086#1076' %'
          Width = 64
          ReadOnly = True
          Sortable = True
        end
        item
          FieldName = 'OverVolume'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1077#1074#1099#1096#1077#1085#1080#1077' '#1086#1073#1098#1077#1084#1072
          Width = 123
          Hint = #1056#1072#1079#1085#1080#1094#1072': '#1054#1073#1098#1077#1084#1085#1099#1081' '#1074#1077#1089' - '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1074#1077#1089' '#1087#1086' '#1076#1072#1085#1085#1099#1084' '#1087#1088#1072#1081#1089'-'#1083#1080#1089#1090#1072'.'
          Sortable = True
        end
        item
          FieldName = 'DateDeparture'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1074#1099#1083#1077#1090#1072
          Width = 145
          Hint = #1044#1072#1090#1072' '#1074#1099#1083#1077#1090#1072'/'#1086#1090#1087#1088#1072#1074#1082#1080' (DateDeparture)'
          Sortable = True
        end
        item
          FieldName = 'DaysInWork'
          Title.Caption = #1044#1085#1077#1081' '#1074' '#1088#1072#1073#1086#1090#1077
          Width = 106
          Sortable = True
        end
        item
          FieldName = 'inDatetime'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103
          Width = 135
          ReadOnly = True
          Hint = #1044#1072#1090#1072' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103
          Sortable = True
        end
        item
          FieldName = 'updDatetime'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1089#1090#1072#1090#1091#1089#1072
          Width = 135
          Visible = False
          ReadOnly = True
          Hint = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
          Sortable = True
        end
        item
          FieldName = 'UserID'
          Title.Alignment = taCenter
          Title.Caption = #1048#1044' '#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
          Width = 118
          Visible = False
          ReadOnly = True
          Hint = #1048#1044' '#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
          Sortable = True
        end
        item
          FieldName = 'UserName'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Width = 200
          Visible = False
          ReadOnly = True
          Hint = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Sortable = True
        end
        item
          FieldName = 'OrderUniqueCount'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1091#1085#1080#1082#1072#1083#1100#1085#1099#1093' '#1079#1072#1082#1072#1079#1086#1074
          Width = 194
          Sortable = True
        end
        item
          FieldName = 'PercentSupped'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1087#1086#1089#1090#1072#1074#1082#1080
          Width = 100
          Sortable = True
        end
        item
          FieldName = 'OrderDetailSubId'
          Title.Alignment = taCenter
          Title.Caption = #1064#1090#1088#1080#1093#1082#1086#1076
          Width = 130
          Sortable = True
        end
        item
          FieldName = 'DeliveryTermFromSupplier'
          Title.Alignment = taCenter
          Title.Caption = #1057#1088#1086#1082' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1086#1090' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
          Width = 169
        end
        item
          FieldName = 'LastDateShipment'
          Title.Alignment = taCenter
          Title.Caption = #1050#1088#1072#1081#1085#1103#1103' '#1076#1072#1090#1072' '#1086#1090#1075#1088#1091#1079#1082#1080' '#1089#1086' '#1089#1082#1083#1072#1076#1072' '#1074' '#1054#1040#1069
          Width = 112
        end
        item
          FieldName = 'LastTermShipment'
          Title.Alignment = taCenter
          Title.Caption = #1044#1085#1077#1081' '#1076#1086' '#1082#1088#1072#1081#1085#1077#1081' '#1076#1072#1090#1099' '#1086#1090#1075#1088#1091#1079#1082#1080' '#1089#1086' '#1089#1082#1083#1072#1076#1072' '#1074' '#1054#1040#1069
          Width = 129
        end>
    end
    object pFilter: TUniPanel
      Left = 0
      Top = 0
      Width = 1640
      Height = 113
      Hint = ''
      ShowHint = True
      Align = alTop
      TabOrder = 0
      ShowCaption = False
      Caption = 'pFilter'
      AlignmentControl = uniAlignmentClient
      ParentAlignmentControl = False
      LayoutAttribs.Align = 'top'
      LayoutAttribs.Pack = 'start'
      LayoutConfig.Region = 'north'
      object gbFilter: TUniGroupBox
        AlignWithMargins = True
        Left = 2
        Top = 3
        Width = 1636
        Height = 108
        Hint = ''
        Margins.Left = 1
        Margins.Top = 2
        Margins.Right = 1
        Margins.Bottom = 1
        ShowHint = True
        Caption = #1060#1080#1083#1100#1090#1088
        Align = alClient
        LayoutConfig.Width = '0'
        TabOrder = 1
        object lblStatys: TUniLabel
          Left = 6
          Top = 14
          Width = 36
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1057#1090#1072#1090#1091#1089':'
          TabOrder = 13
        end
        object lblPrice: TUniLabel
          Left = 219
          Top = 58
          Width = 36
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1055#1088#1072#1081#1089':'
          TabOrder = 18
        end
        object lblClient: TUniLabel
          Left = 6
          Top = 58
          Width = 40
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1050#1083#1080#1077#1085#1090':'
          TabOrder = 17
        end
        object fCancel: TUniBitBtn
          Left = 794
          Top = 33
          Width = 146
          Height = 24
          ShowHint = True
          Action = actFilterClear
          TabOrder = 9
          ImageIndex = 16
        end
        object fOk: TUniBitBtn
          Left = 794
          Top = 75
          Width = 146
          Height = 24
          ShowHint = True
          Action = actFilter
          TabOrder = 10
          IconPosition = ipButtonEdge
          ScreenMask.ShowMessage = False
          ScreenMask.Message = #1046#1076#1080#1090#1077', '#1086#1087#1077#1088#1072#1094#1080#1103' '#1074#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103
          ScreenMask.Target = Owner
          ImageIndex = 15
        end
        object fOrderNum: TUniEdit
          Left = 527
          Top = 33
          Width = 148
          Hint = ''
          ShowHint = True
          Text = ''
          TabOrder = 2
          EmptyText = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072
          CheckChangeDelay = 200
          ClearButton = True
          OnKeyDown = fStatus2KeyDown
        end
        object lblOrderNumber: TUniLabel
          Left = 527
          Top = 14
          Width = 76
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072':'
          TabOrder = 15
        end
        object lblIsCancel: TUniLabel
          Left = 681
          Top = 58
          Width = 34
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1054#1090#1082#1072#1079':'
          TabOrder = 21
        end
        object cbCancel: TUniComboBox
          Left = 681
          Top = 75
          Width = 107
          Height = 23
          Hint = ''
          ShowHint = True
          Text = ''
          Items.Strings = (
            #1053#1077#1090
            #1044#1072
            #1047#1072#1087#1088#1086#1096#1077#1085' '#1086#1090#1082#1072#1079)
          TabOrder = 8
          EmptyText = #1054#1090#1082#1072#1079
          ClearButton = True
          IconItems = <>
          OnKeyDown = fStatus2KeyDown
        end
        object fStatus2: TUniCheckComboBox
          Left = 6
          Top = 33
          Width = 306
          Hint = ''
          ShowHint = True
          Text = ''
          TabOrder = 0
          ClientEvents.UniEvents.Strings = (
            'ajaxRequest=function ajaxRequest(sender, url, data)'#13#10'{'#13#10#13#10'}'
            
              'store.afterCreate=function store.afterCreate(sender)'#13#10'{'#13#10#13#10'   /*' +
              ' var done = new Ext.Button({'#13#10'        text: '#39#1047#1072#1082#1088#1099#1090#1100#39','#13#10'        ' +
              'renderTo: sender.getPicker(),'#13#10'        style: '#39'position: absolut' +
              'e; bottom: 0px; width: 100%;'#39#13#10'    });'#13#10#13#10' */   sender.getSelIds' +
              ' = function(sender) {'#13#10'        let Ids = "";'#13#10'        if (sender' +
              '.getSelection() == null) return "";'#13#10'        sender.getSelection' +
              '().forEach(function(item) {'#13#10'            Ids += item.id + ","'#13#10' ' +
              '       });'#13#10'        return Ids.slice(0, -1);'#13#10'    };'#13#10#13#10'}')
          EmptyText = #1057#1090#1072#1090#1091#1089' '#1079#1072#1082#1072#1079#1072
          ForceSelection = True
          CheckChangeDelay = 100
          ClearButton = True
          Triggers = <
            item
              ImageIndex = 3
              ButtonId = 0
              HandleClicks = True
              Hint = #1054#1095#1080#1089#1090#1080#1090#1100
            end
            item
              ImageIndex = 2
              ButtonId = 1
              HandleClicks = True
              Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100
            end>
          HideTrigger = True
          HideDefaultTrigger = False
          IconItems = <>
          OnSelect = fStatus2Select
          OnKeyDown = fStatus2KeyDown
        end
        object lblDEtailNumber: TUniLabel
          Left = 478
          Top = 58
          Width = 78
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080':'
          TabOrder = 20
        end
        object lblOrderDate: TUniLabel
          Left = 322
          Top = 14
          Width = 65
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072':'
          TabOrder = 14
        end
        object edtUpdDate: TUniDateTimePicker
          Left = 322
          Top = 75
          Width = 150
          Hint = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
          ShowHint = True
          DateTime = 45257.000000000000000000
          DateFormat = 'dd/MM/yyyy'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 6
          ClearButton = True
          EmptyText = #1044#1072#1090#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
          OnKeyDown = fStatus2KeyDown
        end
        object lblUpdDate: TUniLabel
          Left = 322
          Top = 58
          Width = 97
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1044#1072#1090#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103':'
          TabOrder = 19
        end
        object edtInvoice: TUniEdit
          Left = 681
          Top = 33
          Width = 107
          Hint = ''
          ShowHint = True
          Text = ''
          TabOrder = 3
          EmptyText = #1053#1086#1084#1077#1088' '#1080#1085#1074#1086#1081#1089#1072
          CheckChangeDelay = 200
          ClearButton = True
          OnKeyDown = fStatus2KeyDown
        end
        object lblInvoce: TUniLabel
          Left = 681
          Top = 14
          Width = 87
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1053#1086#1084#1077#1088' '#1080#1085#1074#1086#1081#1089#1072':'
          TabOrder = 16
        end
        object fDetailNum: TUniEdit
          Left = 478
          Top = 75
          Width = 197
          Hint = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
          ShowHint = True
          Text = ''
          TabOrder = 7
          EmptyText = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
          CheckChangeDelay = 200
          ClearButton = True
          OnKeyDown = fStatus2KeyDown
        end
        object edtOrderDate: TUniDateRangePicker
          Left = 322
          Top = 33
          Width = 199
          Hint = ''
          ShowHint = True
          Text = 'edtOrderDate'
          TabOrder = 1
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
          DatePickerOptions.Opens = ooCenter
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
        object fClient: TUniExCheckComboBox
          Left = 6
          Top = 75
          Width = 203
          Hint = ''
          ShowHint = True
          ShowSelectButton = True
          ShowSearch = True
          Text = ''
          TabOrder = 4
          ClientEvents.ExtEvents.Strings = (
            
              'afterrender=function afterrender(sender, eOpts) {  '#13#10'initComboBo' +
              'xSelectButtons(sender, "id");'#13#10'initComboBoxSearch(sender, "id", ' +
              '"val");  '#13#10'}')
          EmptyText = #1050#1083#1080#1077#1085#1090
          ClearButton = True
          IconItems = <>
          OnKeyDown = fStatus2KeyDown
        end
        object fPriceLogo: TUniExCheckComboBox
          Left = 219
          Top = 75
          Width = 97
          Hint = ''
          ShowHint = True
          ShowSelectButton = True
          ShowSearch = True
          Text = ''
          TabOrder = 5
          ClientEvents.ExtEvents.Strings = (
            
              'afterrender=function afterrender(sender, eOpts) {  '#13#10'initComboBo' +
              'xSelectButtons(sender, "id");'#13#10'initComboBoxSearch(sender, "id", ' +
              '"val");  '#13#10'}')
          EmptyText = #1055#1088#1072#1081#1089
          ClearButton = True
          IconItems = <>
          OnKeyDown = fStatus2KeyDown
        end
        object btnNotification: TUniBitBtn
          Left = 1098
          Top = 75
          Width = 127
          Height = 24
          Hint = ''
          ShowHint = True
          Caption = '<i class="order fa fa-bell"></i> '#1059#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
          TabOrder = 11
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
          IconPosition = ipButtonEdge
          LayoutConfig.Cls = 'order-notification-btn'
          LayoutConfig.DockWhenAligned = False
          OnClick = btnNotificationClick
        end
      end
    end
    object pnlGridSelectedCount: TUniPanel
      AlignWithMargins = True
      Left = 29
      Top = 420
      Width = 700
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
      LayoutAttribs.Columns = 4
      LayoutConfig.Width = '100'
      LayoutConfig.Region = 'center'
      LayoutConfig.ColumnWidth = 175.000000000000000000
      object UniPanel3: TUniPanel
        Left = 0
        Top = 0
        Width = 161
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
          Left = 5
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
        Left = 161
        Top = 0
        Width = 200
        Height = 40
        Hint = ''
        ShowHint = True
        Align = alLeft
        TabOrder = 2
        BorderStyle = ubsNone
        ShowCaption = False
        Caption = 'UniPanel4'
        object lblSelRowSum: TUniLabel
          AlignWithMargins = True
          Left = 5
          Top = 3
          Width = 73
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1057#1091#1084#1084#1072' '#1089#1090#1088#1086#1082': '
          ParentColor = False
          Color = clBtnFace
          TabOrder = 1
        end
        object lblRowSum2: TUniLabel
          AlignWithMargins = True
          Left = 90
          Top = 24
          Width = 6
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = ': '
          ParentFont = False
          TabOrder = 3
        end
        object lblRowSum1: TUniLabel
          AlignWithMargins = True
          Left = 90
          Top = 3
          Width = 6
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = ': '
          ParentFont = False
          TabOrder = 2
        end
      end
      object UniPanel5: TUniPanel
        Left = 361
        Top = 0
        Width = 164
        Height = 40
        Hint = ''
        ShowHint = True
        Align = alClient
        TabOrder = 3
        BorderStyle = ubsNone
        ShowCaption = False
        Caption = 'UniPanel5'
        object UniLabel7: TUniLabel
          AlignWithMargins = True
          Left = 5
          Top = 3
          Width = 73
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1057#1091#1084#1084#1072' '#1074#1077#1089#1086#1074': '
          ParentColor = False
          Color = clBtnFace
          TabOrder = 1
        end
        object lblWeightKG: TUniLabel
          AlignWithMargins = True
          Left = 90
          Top = 3
          Width = 6
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = ': '
          ParentFont = False
          TabOrder = 2
        end
        object lblVolumeKG: TUniLabel
          AlignWithMargins = True
          Left = 90
          Top = 24
          Width = 6
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = ': '
          ParentFont = False
          TabOrder = 3
        end
      end
      object UniPanel1: TUniPanel
        Left = 525
        Top = 0
        Width = 175
        Height = 40
        Hint = ''
        ShowHint = True
        Align = alRight
        TabOrder = 4
        BorderStyle = ubsNone
        ShowCaption = False
        Caption = 'UniPanel1'
        object UniLabel9: TUniLabel
          AlignWithMargins = True
          Left = 5
          Top = 3
          Width = 76
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1055#1088#1077#1074#1099#1096#1077#1085#1080#1077': '
          ParentColor = False
          Color = clBtnFace
          TabOrder = 1
        end
        object lblOverVolume: TUniLabel
          AlignWithMargins = True
          Left = 93
          Top = 3
          Width = 6
          Height = 13
          Hint = #1056#1072#1079#1085#1080#1094#1072': '#1054#1073#1098#1077#1084#1085#1099#1081' '#1074#1077#1089' - '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1074#1077#1089' '#1087#1086' '#1076#1072#1085#1085#1099#1084' '#1087#1088#1072#1081#1089'-'#1083#1080#1089#1090#1072'.'
          ShowHint = True
          Caption = ': '
          ParentFont = False
          TabOrder = 2
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
    SecurityOptions.AllowedCommandKinds = [skUnknown, skSelect, skSelectForLock, skSelectForUnLock, skInsert, skMerge, skUpdate, skCreate, skAlter, skStoredProc, skStoredProcWithCrs, skStoredProcNoCrs, skExecute, skStartTransaction, skCommit, skRollback, skSet, skSetSchema, skOther, skNotResolved]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.KeyFields = 'OrderID'
    UpdateOptions.AutoIncFields = 'OrderID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'SELECT '
      '       o.[OrderID]'
      '      ,o.[Flag]              Status '
      '      ,o.[ClientID]'
      '      ,o.[ClientName]'
      '      ,o.[OrderDate]'
      '      ,o.[PriceLogo]'
      '      ,o.[CustomerPriceLogo] -- '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1072#1081#1089#1072' '#1080#1079' '#1079#1072#1082#1072#1079#1072
      '      ,o.[OrderNum]'
      '      ,o.[StatusID]'
      '      ,o.[StatusName]'
      '      ,o.[isCancel]'
      '      ,o.[MakeLogo]'
      '      ,o.[Manufacturer]'
      '      ,o.[DetailNumber]'
      '      ,o.[DetailName]'
      '      ,o.[DetailID]'
      '      ,o.[Quantity]'
      '      ,o.[Price]'
      '      ,o.[Amount]'
      '      ,o.[PricePurchase]'
      '      ,o.[AmountPurchase]'
      '      ,o.[PricePurchaseF]'
      '      ,o.[AmountPurchaseF]'
      '      ,o.[WeightKG]'
      '      ,o.[VolumeKG]'
      '      ,o.[WeightKGF]'
      '      ,o.[VolumeKGF]'
      '      ,o.[Margin]'
      '      ,o.[MarginF]'
      '      ,o.[Profit]'
      '      ,o.[Income]'
      '      ,o.[IncomePRC] -- '#1076#1086#1093#1086#1076' '#1074' '#1087#1088#1086#1094#1077#1085#1090#1072#1093
      
        '      ,o.[DeliveryPlanDateSupplier] -- '#1055#1083#1072#1085#1086#1074#1072#1103' '#1076#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103 +
        ' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
      '      ,o.[DeliveryPlanDateSupplier2]'
      
        '      ,o.[DeliveryTermSupplier]     -- '#1057#1088#1086#1082' '#1076#1086' '#1087#1086#1089#1090#1091#1087#1076#1077#1085#1080#1103' '#1087#1086#1089#1090#1074 +
        #1097#1080#1082#1091
      
        '      ,o.[DeliveryTermSupplier2]    -- '#1057#1088#1086#1082' '#1076#1086' '#1087#1086#1089#1090#1091#1087#1076#1077#1085#1080#1103' '#1087#1086#1089#1090#1074 +
        #1097#1080#1082#1091'  '#1087#1086#1089#1083#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      
        '      ,o.[DeliveryRestTermSupplier] -- '#1054#1089#1090#1072#1090#1086#1082' '#1089#1088#1086#1082#1072' '#1076#1086' '#1087#1086#1089#1090#1091#1087#1083#1077 +
        #1085#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
      '      ,o.[DeliveredDateToSupplier]  -- '#1044#1086#1089#1090#1072#1074#1083#1077#1085#1072' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
      '      ,o.[DeliveryDaysReserve]'
      '      ,o.[DeliveryDaysReserve2]'
      '      ,o.[DeliveryNextDate]         -- '#1041#1083#1080#1078#1072#1081#1096#1072#1103' '#1076#1072#1090#1072' '#1074#1099#1083#1077#1090#1072' '
      '      ,o.[DeliveryNextDate2]        -- '#1041#1083#1080#1078#1072#1081#1096#1072#1103' '#1076#1072#1090#1072' '#1074#1099#1083#1077#1090#1072
      '      ,o.[DeliveryDateToCustomer]   -- '#1044#1072#1090#1072' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1082#1083#1080#1077#1085#1090#1091
      
        '      ,o.[DeliveryDateToCustomer2]  -- '#1044#1072#1090#1072' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1082#1083#1080#1077#1085#1090#1091' '#1087#1086#1089 +
        #1083#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      '      ,o.[DeliveryTermToCustomer]   -- '#1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1082#1083#1080#1077#1085#1090#1091
      
        '      ,o.[DeliveryTermToCustomer2]  -- '#1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1082#1083#1080#1077#1085#1090#1091' '#1087#1086#1089 +
        #1083#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      '      ,o.[DeliveryRestToCustomer]'
      '      ,o.[UserID]'
      '      ,o.[UserName]'
      '      ,o.[inDatetime]'
      '      ,o.[updDatetime]      '
      '      ,o.[OverPricing] -- '#1087#1088#1077#1074#1099#1096#1077#1085#1080#1077
      '      ,o.[Warning]'
      '      ,o.[ReplacementMakeLogo]'
      '      ,o.[ReplacementDetailNumber]'
      '      ,o.[ReplacementManufacturer]    '
      '      ,o.ReplacementPrice  '
      '     -- ,o.[DestinationLogo] -- '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
      '      ,o.[DestinationName]'
      '      ,o.[Invoice]'
      '      ,o.[FileDate]'
      '      ,o.[Flag]'
      '      ,o.[NoAir]'
      
        '      ,o.[OverVolume]      -- '#1087#1088#1077#1074#1099#1096#1077#1085#1080#1077' '#1086#1073#1098#1077#1084#1072', '#1088#1072#1079#1085#1080#1094#1072' '#1054#1073#1098#1077#1084#1085#1099 +
        #1081' '#1074#1077#1089' - '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1074#1077#1089' '#1087#1086' '#1076#1072#1085#1085#1099#1084' '#1087#1088#1072#1081#1089'-'#1083#1080#1089#1090#1072'.'
      '      ,o.[DateDeparture]   -- '#1044#1072#1090#1072' '#1074#1099#1083#1077#1090#1072
      '      ,o.[DaysInWork]      -- '#1044#1085#1077#1081' '#1074' '#1088#1072#1073#1086#1090#1077
      '      ,o.[Fragile]'
      '      ,o.[OrderUniqueCount]'
      '      ,o.[PercentSupped]'
      '      ,o.[ReceiptDate]     -- '#1054#1078#1080#1076#1072#1077#1084#1072#1103' '#1076#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
      '      ,o.[OrderDetailSubId]'
      
        '      ,o.DeliveryTermFromSupplier  -- '#1057#1088#1086#1082' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1086#1090' '#1087#1086#1089#1090#1072#1074#1097#1080#1082 +
        #1072' '#1089' '#1087#1088#1086#1092#1080#1083#1103' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
      '      ,o.DeliveryTermFromSupplier2'
      '      ,o.LastDateShipment'
      '      ,o.LastTermShipment'
      '  FROM !Form  '
      ' where 1=1'
      '          '
      '   !Status'
      '   '
      '   !PriceLogo'
      '   '
      '   !Client'
      '   '
      '   !OrderNum'
      ''
      '   !DetailNum'
      '   '
      '   !isCancel'
      '   '
      '   !OrderDate'
      '   '
      '   !updDateTime'
      '   '
      '   !Invoice   '
      '   '
      '   !Flags   '
      '               '
      '  order by  o.[OrderID]  '
      '   ')
    Left = 575
    Top = 254
    MacroData = <
      item
        Value = Null
        Name = 'FORM'
      end
      item
        Value = ''
        Name = 'STATUS'
      end
      item
        Value = ''
        Name = 'PRICELOGO'
      end
      item
        Value = ''
        Name = 'CLIENT'
      end
      item
        Value = ''
        Name = 'ORDERNUM'
      end
      item
        Value = ''
        Name = 'DETAILNUM'
      end
      item
        Value = Null
        Name = 'ISCANCEL'
      end
      item
        Value = ''
        Name = 'ORDERDATE'
      end
      item
        Value = ''
        Name = 'UPDDATETIME'
      end
      item
        Value = ''
        Name = 'INVOICE'
      end
      item
        Value = Null
        Name = 'FLAGS'
      end>
    object QueryOrderID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'OrderID'
      KeyFields = 'OrderID'
      Origin = 'OrderID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Precision = 18
      Size = 0
    end
    object QueryFlag: TIntegerField
      FieldName = 'Flag'
    end
    object QueryisCancel: TBooleanField
      FieldName = 'isCancel'
      Origin = 'isCancel'
    end
    object QueryStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = QueryStatusGetText
    end
    object QueryClientID: TFMTBCDField
      FieldName = 'ClientID'
      Origin = 'ClientID'
      ReadOnly = True
      Required = True
      Precision = 18
      Size = 0
    end
    object QueryClientName: TWideStringField
      FieldName = 'ClientName'
      Origin = 'ClientName'
      ReadOnly = True
      Size = 32
    end
    object QueryOrderDate: TSQLTimeStampField
      FieldName = 'OrderDate'
      Origin = 'OrderDate'
      Required = True
    end
    object QueryOrderNum: TWideStringField
      FieldName = 'OrderNum'
      Origin = 'OrderNum'
      ReadOnly = True
      Size = 32
    end
    object QueryPriceLogo: TWideStringField
      FieldName = 'PriceLogo'
      Origin = 'PriceLogo'
      ReadOnly = True
      Size = 32
    end
    object QueryStatusID: TFMTBCDField
      FieldName = 'StatusID'
    end
    object QueryStatusName: TWideStringField
      FieldName = 'StatusName'
      Origin = 'StatusName'
      Size = 64
    end
    object QueryMakeLogo: TWideStringField
      FieldName = 'MakeLogo'
      OnGetText = QueryMakeLogoGetText
      Size = 32
    end
    object QueryManufacturer: TWideStringField
      FieldName = 'Manufacturer'
      Origin = 'Manufacturer'
      OnGetText = QueryManufacturerGetText
      Size = 64
    end
    object QueryDetailNumber: TWideStringField
      FieldName = 'DetailNumber'
      Origin = 'DetailNumber'
      OnGetText = QueryDetailNumberGetText
      Size = 32
    end
    object QueryDetailName: TWideStringField
      FieldName = 'DetailName'
      Size = 256
    end
    object QueryDetailID: TWideStringField
      FieldName = 'DetailID'
      Origin = 'DetailID'
      Size = 30
    end
    object QueryQuantity: TIntegerField
      FieldName = 'Quantity'
      Origin = 'Quantity'
    end
    object QueryAmount: TCurrencyField
      FieldName = 'Amount'
      Origin = 'Amount'
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryAmountPurchase: TCurrencyField
      FieldName = 'AmountPurchase'
      Origin = 'AmountPurchase'
      DisplayFormat = '###,##0.00 $'
    end
    object QueryPrice: TCurrencyField
      FieldName = 'Price'
      Origin = 'Price'
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryPricePurchase: TCurrencyField
      FieldName = 'PricePurchase'
      Origin = 'PricePurchase'
      OnGetText = QueryPricePurchaseGetText
      DisplayFormat = '###,##0.00 $'
    end
    object QueryPricePurchaseF: TCurrencyField
      FieldName = 'PricePurchaseF'
      Origin = 'PricePurchaseF'
      OnGetText = QueryPricePurchaseFGetText
      DisplayFormat = '###,##0.00 $'
    end
    object QueryAmountPurchaseF: TCurrencyField
      FieldName = 'AmountPurchaseF'
      Origin = 'AmountPurchaseF'
      DisplayFormat = '###,##0.00 $'
    end
    object QueryWeightKG: TCurrencyField
      FieldName = 'WeightKG'
      Origin = 'WeightKG'
      DisplayFormat = '###,##0.000 '#1082#1075
    end
    object QueryVolumeKG: TCurrencyField
      FieldName = 'VolumeKG'
      Origin = 'VolumeKG'
      DisplayFormat = '###,##0.000'
    end
    object QueryWeightKGF: TCurrencyField
      FieldName = 'WeightKGF'
      Origin = 'WeightKGF'
      ReadOnly = True
      DisplayFormat = '###,##0.000 '#1082#1075
    end
    object QueryVolumeKGF: TCurrencyField
      FieldName = 'VolumeKGF'
      Origin = 'VolumeKGF'
      ReadOnly = True
      DisplayFormat = '###,##0.000'
    end
    object QueryOverVolume: TCurrencyField
      FieldName = 'OverVolume'
      Origin = 'OverVolume'
      DisplayFormat = '###,##0.000'
    end
    object QueryMargin: TCurrencyField
      FieldName = 'Margin'
      Origin = 'Margin'
      DisplayFormat = '###,##0 %'
    end
    object QueryMarginF: TCurrencyField
      FieldName = 'MarginF'
      Origin = 'MarginF'
      DisplayFormat = '###,##0.00 %'
    end
    object QueryProfit: TCurrencyField
      FieldName = 'Profit'
      Origin = 'Profit'
      DisplayFormat = '###,##0.00 %'
    end
    object QueryIncome: TCurrencyField
      FieldName = 'Income'
      Origin = 'Income'
    end
    object QueryIncomePRC: TCurrencyField
      FieldName = 'IncomePRC'
      DisplayFormat = '###,##0.00 %'
    end
    object QueryDeliveryPlanDateSupplier: TSQLTimeStampField
      FieldName = 'DeliveryPlanDateSupplier'
      Origin = 'DeliveryPlanDateSupplier'
      OnGetText = QueryDeliveryPlanDateSupplierGetText
    end
    object QueryDeliveryPlanDateSupplier2: TSQLTimeStampField
      FieldName = 'DeliveryPlanDateSupplier2'
    end
    object QueryDeliveryTermSupplier: TIntegerField
      FieldName = 'DeliveryTermSupplier'
      OnGetText = QueryDeliveryTermSupplierGetText
    end
    object QueryDeliveryTermSupplier2: TIntegerField
      FieldName = 'DeliveryTermSupplier2'
    end
    object QueryDeliveryRestTermSupplier: TIntegerField
      FieldName = 'DeliveryRestTermSupplier'
    end
    object QueryDeliveredDateToSupplier: TSQLTimeStampField
      FieldName = 'DeliveredDateToSupplier'
      Origin = 'DeliveredDateToSupplier'
    end
    object DeliveryDaysReserve: TIntegerField
      FieldName = 'DeliveryDaysReserve'
      Origin = 'DaysReserveDeparture'
      OnGetText = DeliveryDaysReserveGetText
    end
    object QueryDeliveryDaysReserve2: TIntegerField
      FieldName = 'DeliveryDaysReserve2'
    end
    object QueryNextDateDeparture: TSQLTimeStampField
      FieldName = 'DeliveryNextDate'
      Origin = 'DeliveryNextDate'
      OnGetText = QueryNextDateDepartureGetText
      DisplayFormat = 'dd.mm.yyyy'
    end
    object QueryDeliveryNextDate2: TSQLTimeStampField
      FieldName = 'DeliveryNextDate2'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object QueryDateDeliveryToCustomer: TSQLTimeStampField
      FieldName = 'DeliveryDateToCustomer'
      Origin = 'DeliveryDateToCustomer'
      OnGetText = QueryDateDeliveryToCustomerGetText
    end
    object QueryDeliveryDateToCustomer2: TSQLTimeStampField
      FieldName = 'DeliveryDateToCustomer2'
    end
    object QueryTermDeliveryToCustomer: TIntegerField
      FieldName = 'DeliveryTermToCustomer'
      Origin = 'DeliveryTermToCustomer'
      OnGetText = QueryTermDeliveryToCustomerGetText
    end
    object QueryDeliveryTermToCustomer2: TIntegerField
      FieldName = 'DeliveryTermToCustomer2'
    end
    object QueryRestDeliveryToCustomer: TIntegerField
      FieldName = 'DeliveryRestToCustomer'
      Origin = 'DeliveryRestToCustomer'
    end
    object QueryOverPricing: TCurrencyField
      FieldName = 'OverPricing'
      DisplayFormat = '###,##0.00 %'
    end
    object QueryWarning: TWideStringField
      FieldName = 'Warning'
      Size = 128
    end
    object QueryReplacementPrice: TCurrencyField
      FieldName = 'ReplacementPrice'
    end
    object QueryReplacementMakeLogo: TWideStringField
      FieldName = 'ReplacementMakeLogo'
      Size = 32
    end
    object QueryReplacementDetailNumber: TWideStringField
      FieldName = 'ReplacementDetailNumber'
      Size = 32
    end
    object QueryReplacementManufacturer: TWideStringField
      FieldName = 'ReplacementManufacturer'
      Size = 32
    end
    object QueryCustomerPriceLogo: TWideStringField
      FieldName = 'CustomerPriceLogo'
      Size = 10
    end
    object QueryDestinationLogo: TWideStringField
      FieldName = 'DestinationName'
      Size = 32
    end
    object QueryInvoice: TWideStringField
      FieldName = 'Invoice'
      Size = 32
    end
    object QueryFileDate: TSQLTimeStampField
      FieldName = 'FileDate'
    end
    object QueryDateDeparture: TSQLTimeStampField
      FieldName = 'DateDeparture'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object QueryDaysInWork: TIntegerField
      FieldName = 'DaysInWork'
    end
    object QueryFragile: TBooleanField
      FieldName = 'Fragile'
    end
    object QueryOrderUniqueCount: TIntegerField
      FieldName = 'OrderUniqueCount'
    end
    object QueryPercentSupped: TIntegerField
      FieldName = 'PercentSupped'
      DisplayFormat = '##0 %'
    end
    object QueryReceiptDate: TSQLTimeStampField
      FieldName = 'ReceiptDate'
    end
    object QueryUserID: TFMTBCDField
      FieldName = 'UserID'
      Origin = 'UserID'
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QueryUserName: TWideStringField
      FieldName = 'UserName'
      Origin = 'UserName'
      Size = 64
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
      Size = 32
    end
    object QueryDeliveryTermFromSupplier: TIntegerField
      FieldName = 'DeliveryTermFromSupplier'
      OnGetText = QueryDeliveryTermFromSupplierGetText
    end
    object QueryDeliveryTermFromSupplier2: TIntegerField
      FieldName = 'DeliveryTermFromSupplier2'
    end
    object QueryNoAir: TBooleanField
      FieldName = 'NoAir'
    end
    object QueryLastTermShipment: TIntegerField
      FieldName = 'LastTermShipment'
    end
    object QueryLastDateShipment: TSQLTimeStampField
      FieldName = 'LastDateShipment'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 648
    Top = 255
  end
  object actMain: TUniActionList
    Left = 102
    Top = 281
    object actEdit: TAction
      Category = 'Action'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1082#1072#1079
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1082#1072#1079
      ImageIndex = 1
      OnExecute = actEditExecute
    end
    object actRefreshAll: TAction
      Category = 'Action'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 3
      OnExecute = actRefreshAllExecute
    end
    object actExecuteActionEnabled: TAction
      Category = 'Action'
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077
      Hint = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077
    end
    object actExecuteActionRollback: TAction
      Category = 'Action'
      Caption = #1054#1090#1084#1077#1085#1072' '#1076#1077#1081#1089#1090#1074#1080#1103
      OnExecute = actExecuteActionRollbackExecute
    end
    object actExecuteAction: TAction
      Tag = -1
      Category = 'Action'
      OnExecute = actExecuteActionExecute
    end
    object actProtocol: TAction
      Category = 'Grid'
      Caption = #1055#1088#1086#1090#1086#1082#1086#1083' '#1079#1072#1082#1072#1079#1072
      Hint = #1055#1088#1086#1090#1086#1082#1086#1083
      OnExecute = actProtocolExecute
    end
    object actFilter: TAction
      Category = 'Filter'
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      ImageIndex = 15
      OnExecute = actFilterExecute
    end
    object actFilterClear: TAction
      Category = 'Filter'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1103' '#1092#1080#1083#1100#1090#1088#1072
      ImageIndex = 16
      OnExecute = actFilterClearExecute
    end
    object actSelect: TAction
      Category = 'Grid'
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      OnExecute = actSelectExecute
    end
    object actUnselect: TAction
      Category = 'Grid'
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077' '#1086#1090#1084#1077#1090#1082#1080
      Hint = #1057#1085#1103#1090#1100' '#1074#1089#1077' '#1086#1090#1084#1077#1090#1082#1080
      OnExecute = actUnSelectExecute
    end
    object actGridSettingDefault: TAction
      Category = 'Grid'
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      OnExecute = actGridSettingDefaultExecute
    end
    object actSetComment: TAction
      Caption = #1053#1072#1087#1080#1089#1072#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077' '#1082#1083#1080#1077#1085#1090#1091
      Hint = #1053#1072#1087#1080#1089#1072#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077' '#1082#1083#1080#1077#1085#1090#1091
      ImageIndex = 20
      OnExecute = actSetCommentExecute
    end
    object actGroupAction: TAction
      Caption = #1043#1088#1091#1087#1087#1086#1074#1099#1077' '#1086#1087#1077#1088#1072#1094#1080#1080
    end
    object actGroupDetailNameEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103' '#1076#1077#1090#1072#1083#1080
      OnExecute = actGroupDetailNameEditExecute
    end
    object actGroupSetFragileSign: TAction
      Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1088#1080#1079#1085#1072#1082#1072' Fragile'
      Hint = #1043#1088#1091#1087#1087#1086#1074#1086#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1088#1080#1079#1085#1072#1082#1072' [B]Fragile[/B] ('#1061#1088#1091#1087#1082#1080#1081')'
      OnExecute = actGroupSetFragileSignExecute
    end
    object actCancellation: TAction
      Caption = #1055#1088#1086#1089#1090#1072#1074#1080#1090#1100' '#1087#1088#1080#1079#1085#1072#1082': '#1047#1072#1087#1088#1086#1096#1077#1085' '#1086#1090#1082#1072#1079
      OnExecute = actCancellationExecute
    end
    object actRequestClosed: TAction
      Caption = #1055#1088#1086#1089#1090#1072#1074#1080#1090#1100' '#1087#1088#1080#1079#1085#1072#1082': '#1054#1073#1088#1072#1097#1077#1085#1080#1077' '#1079#1072#1082#1088#1099#1090#1086
      OnExecute = actRequestClosedExecute
    end
    object actRequestOpen: TAction
      Caption = #1055#1088#1086#1089#1090#1072#1074#1080#1090#1100' '#1087#1088#1080#1079#1085#1072#1082': '#1054#1073#1088#1072#1097#1077#1085#1080#1077' '#1086#1090#1082#1088#1099#1090#1086
      OnExecute = actRequestOpenExecute
    end
    object actPartProtocol: TAction
      Caption = #1055#1088#1086#1090#1086#1082#1086#1083' '#1076#1077#1090#1072#1083#1080
      OnExecute = actPartProtocolExecute
    end
    object actSupplierSpecifyDeliveryTime: TAction
      Caption = #1059#1090#1086#1095#1085#1080#1090#1100' '#1089#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080
      OnExecute = actSupplierSpecifyDeliveryTimeExecute
    end
    object actDelete: TAction
      Category = 'Action'
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1082#1072#1079
      ImageIndex = 2
      OnExecute = actDeleteExecute
    end
  end
  object ppMain: TUniPopupMenu
    OnPopup = ppMainPopup
    Left = 101
    Top = 218
    object ppExecuteAction: TUniMenuItem
      Action = actExecuteActionEnabled
    end
    object ppExecuteActionRollback: TUniMenuItem
      Action = actExecuteActionRollback
    end
    object N1: TUniMenuItem
      Caption = '-'
    end
    object ppEdit: TUniMenuItem
      Action = actEdit
    end
    object ppDelete: TUniMenuItem
      Action = actDelete
    end
    object N13: TUniMenuItem
      Action = actSupplierSpecifyDeliveryTime
    end
    object N8: TUniMenuItem
      Action = actCancellation
    end
    object N10: TUniMenuItem
      Action = actRequestOpen
    end
    object N9: TUniMenuItem
      Action = actRequestClosed
    end
    object N14: TUniMenuItem
      Action = actSetComment
    end
    object N15: TUniMenuItem
      Action = actGroupAction
      object N16: TUniMenuItem
        Action = actGroupDetailNameEdit
      end
      object Fragile1: TUniMenuItem
        Action = actGroupSetFragileSign
      end
    end
    object N5: TUniMenuItem
      Caption = '-'
    end
    object N2: TUniMenuItem
      Action = actProtocol
    end
    object actPartProtocol1: TUniMenuItem
      Action = actPartProtocol
    end
    object N4: TUniMenuItem
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
    ModifySQL.Strings = (
      'select :OLD_OrderID as OrderID  ')
    DeleteSQL.Strings = (
      'select :OLD_OrderID as OrderID  ')
    FetchRowSQL.Strings = (
      'SELECT *'
      '      ,Flag as Status -- '#1080#1082#1086#1085#1082#1080
      '  FROM vOrders'
      ' WHERE OrderID = :OrderID')
    Left = 497
    Top = 255
  end
  object qStatus: TFDQuery
    AutoCalcFields = False
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
      ' exec OrderFilter_Status ')
    Left = 575
    Top = 316
  end
  object qPriceLogo: TFDQuery
    AutoCalcFields = False
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
      'SELECT distinct'
      '       PriceLogo PriceLogo'
      '  FROM [tOrders] (nolock)'
      ' where PriceLogo is not null'
      ' order by PriceLogo')
    Left = 574
    Top = 379
    object qPriceLogoPriceLogo: TWideStringField
      FieldName = 'PriceLogo'
      Size = 64
    end
  end
  object dsStatus: TDataSource
    DataSet = qStatus
    Left = 649
    Top = 315
  end
  object dsPriceLogo: TDataSource
    DataSet = qPriceLogo
    Left = 650
    Top = 377
  end
  object dsClient: TDataSource
    Left = 652
    Top = 432
  end
  object TimerProcessedShow: TUniTimer
    Enabled = False
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = TimerProcessedShowTimer
    Left = 862
    Top = 169
  end
  object ppExecute: TUniPopupMenu
    ScreenMask.ShowMessage = False
    Left = 210
    Top = 218
  end
end
