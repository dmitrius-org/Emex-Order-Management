object OrdersT: TOrdersT
  Left = 0
  Top = 0
  Width = 1640
  Height = 596
  Margins.Bottom = 0
  OnCreate = UniFrameCreate
  OnDestroy = UniFrameDestroy
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
      Top = 121
      Width = 1640
      Height = 475
      Hint = ''
      Margins.Bottom = 0
      ShowHint = True
      BodyRTL = False
      ClientEvents.ExtEvents.Strings = (
        
          'beforerender=function beforerender(sender, eOpts)'#13#10'{'#13#10'    var me' +
          '=sender.checkboxModel;'#13#10'    if (me) {'#13#10'        // '#1089#1082#1088#1099#1074#1072#1077#1084' Check' +
          'box '#1089' '#1079#1072#1075#1086#1083#1086#1074#1082#1072' '#1090#1072#1073#1083#1080#1094#1099#13#10'        me.showHeaderCheckbox=true;'#13#10'  ' +
          '  }'#13#10'}'
        'hide=function hide(sender, eOpts)'#13#10'{'#13#10#13#10'}'
        
          'columnhide=function columnhide(ct, column, eOpts)'#13#10'{'#13#10'  if (colu' +
          'mn.dataIndex >= 0) { //column.dataIndex >= 0 '#1080#1089#1087#1088#1072#1074#1083#1077#1085#1080#1077' Argumen' +
          't out of range'#13#10'    ajaxRequest(this, '#39'_columnhide'#39', ["column=" ' +
          '+ column.dataIndex, "hidden=" + column.hidden]);'#13#10'  }'#13#10'}'
        
          'columnshow=function columnshow(ct, column, eOpts)'#13#10'{'#13#10'  //consol' +
          'e.log(column); '#13#10'  //console.log(eOpts);'#13#10'  //console.log(ct);'#13#10 +
          '  ajaxRequest(this, '#39'_columnshow'#39', ["column=" + column.dataIndex' +
          ', "hidden=" + column.hidden]);'#13#10'}'
        
          'columnmove=function columnmove(ct, column, fromIdx, toIdx, eOpts' +
          ')'#13#10'{'#13#10'  //ajaxRequest(this, '#39'_columnmove'#39', ["column=" + fromIdx,' +
          ' "columnTo=" + toIdx]);'#13#10'}'
        
          'columnresize=function columnresize(ct, column, width, eOpts)'#13#10'{'#13 +
          #10'  //  ajaxRequest(this, '#39'_columnresize'#39', ["column=" + column.da' +
          'taIndex, "hidden=" + column.hidden]);'#13#10'}'
        
          'columnschanged=function columnschanged(ct, eOpts)'#13#10'{'#13#10' // ajaxRe' +
          'quest(this, '#39'_columnschanged'#39', ['#39'colIndx='#39' + column.dataIndex])'#13 +
          #10'}')
      ClientEvents.UniEvents.Strings = (
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
          'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
          'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
          'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
          't.body.removeChild(el);'#13#10'    };'#13#10'    '#13#10'    // '#1079#1072#1082#1088#1077#1087#1083#1077#1085#1080#1077' '#1089#1090#1086#1083#1073#1094 +
          #1086#1074#13#10'        /*'#13#10'    config.enableLocking = true;'#13#10#13#10'    Ext.defi' +
          'ne('#39'Ext.overrides.selection.CheckboxModel'#39', {'#13#10'        override:' +
          ' '#39'Ext.selection.CheckboxModel'#39','#13#10#13#10'        hasLockedHeader: func' +
          'tion() {'#13#10'            return this.callParent(arguments) || this.' +
          'view.ownerGrid.lockable;'#13#10'        },'#13#10'        onReconfigure: fun' +
          'ction(grid, store, columns) {'#13#10'            if (columns && grid.l' +
          'ockable) {'#13#10'                grid.lock(this.column, 0);'#13#10'        ' +
          '        grid.view.refreshView();'#13#10'                return;'#13#10'     ' +
          '       }'#13#10'            return this.callParent(arguments);'#13#10'      ' +
          '  }'#13#10'    }); '#13#10'    '#13#10'    function reconfigure(sender, store, col' +
          'umns, oldStore, oldColumns, eOpts)'#13#10'    {'#13#10'        columns.forEa' +
          'ch(function(col){'#13#10'            col.lockable=false'#13#10'        });'#13#10 +
          '    }'#13#10'    */     '#13#10'}'#13#10#13#10
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'  config.displayInfo=true;'#13#10'}'
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
          'r.getDockedItems()[1];'#13#10'  toolbar.items.getAt(9).hide();'#13#10'  tool' +
          'bar.items.getAt(10).hide();'#13#10'  '#13#10'  // '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1074' '#1087#1072#1085#1077#1083#1100' ' +
          #1085#1072#1074#1080#1075#1072#1094#1080#1080#13#10'  if (!toolbar.exportBtn) {'#13#10'     toolbar.exportBtn =' +
          ' toolbar.insert('#13#10'       0, '#13#10'       //{ xtype: '#39'tbseparator'#39' }'#13 +
          #10'       {xtype: '#39'button'#39', text: '#39#39', tooltip : '#39#1054#1087#1080#1089#1072#1085#1080#1077' '#1089#1090#1072#1090#1091#1089#1086#1074 +
          ' '#1079#1072#1082#1072#1079#1086#1074#39', handler: function() {'#13#10'          ajaxRequest(sender, ' +
          '"btnStatusFormShow", {})'#13#10'       }}'#13#10'       '#13#10'     '#13#10'     );'#13#10'  ' +
          '   toolbar.exportBtn.setIconCls('#39'StatusIcons'#39');// icon...'#13#10'  }  ' +
          #13#10'}')
      HeaderTitleAlign = taCenter
      PagingBarAuxControl = pnlGridSelectedCount
      DataSource = DataSource
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgRowSelect, dgCheckSelect, dgCheckSelectCheckOnly, dgAlwaysShowSelection, dgMultiSelect, dgFilterClearButton, dgTabs, dgDontShowSelected, dgRowNumbers]
      WebOptions.PageSize = 50
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      Grouping.ShowCaption = False
      Grouping.ShowValue = False
      LoadMask.WaitData = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Target = Owner
      LoadMask.Color = 13421772
      Images = UniImageList
      EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
      LayoutConfig.ComponentCls = 'grid-order'
      BorderStyle = ubsNone
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
      OnCellClick = GridCellClick
      OnColumnSort = GridColumnSort
      OnColumnMove = GridColumnMove
      OnDblClick = GridDblClick
      OnCellContextClick = GridCellContextClick
      OnDrawColumnCell = GridDrawColumnCell
      OnColumnResize = GridColumnResize
      Columns = <
        item
          FieldName = 'Status'
          Title.Alignment = taCenter
          Title.Caption = ' '
          Width = 64
          Alignment = taLeftJustify
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
          Title.Caption = ' '
          Width = 85
          Visible = False
          ReadOnly = True
          Hint = 'ClientID'
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
          Title.Caption = #1057#1090#1072#1090#1091#1089
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
          Title.Caption = #1041#1088#1077#1085#1076
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
          Title.Caption = #1055#1083#1072#1085#1086#1074#1072#1103' '#1076#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Width = 100
          ReadOnly = True
          Hint = #1055#1083#1072#1085#1086#1074#1072#1103' '#1076#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Sortable = True
        end
        item
          FieldName = 'DeliveryRestTermSupplier'
          Title.Alignment = taCenter
          Title.Caption = #1054#1089#1090#1072#1090#1086#1082' '#1089#1088#1086#1082#1072' '#1076#1086' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Width = 100
          ReadOnly = True
          Hint = #1054#1089#1090#1072#1090#1086#1082' '#1089#1088#1086#1082#1072' '#1076#1086' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Sortable = True
        end
        item
          FieldName = 'DeliveredDateToSupplier'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1089#1090#1072#1074#1083#1077#1085#1072' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Width = 100
          ReadOnly = True
          Hint = #1044#1086#1089#1090#1072#1074#1083#1077#1085#1072' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
          Sortable = True
        end
        item
          FieldName = 'DeliveryDaysReserve'
          Title.Alignment = taCenter
          Title.Caption = #1044#1085#1077#1081' '#1079#1072#1087#1072#1089#1072' '#1076#1086' '#1074#1099#1083#1077#1090#1072
          Width = 100
          ReadOnly = True
          Hint = #1044#1085#1077#1081' '#1079#1072#1087#1072#1089#1072' '#1076#1086' '#1074#1099#1083#1077#1090#1072
          Sortable = True
        end
        item
          FieldName = 'DeliveryNextDate'
          Title.Alignment = taCenter
          Title.Caption = #1041#1083#1080#1078#1072#1081#1096#1072#1103' '#1076#1072#1090#1072' '#1074#1099#1083#1077#1090#1072
          Width = 100
          ReadOnly = True
          Hint = #1041#1083#1080#1078#1072#1081#1096#1072#1103' '#1076#1072#1090#1072' '#1074#1099#1083#1077#1090#1072
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
          FieldName = 'DestinationLogo'
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
          Sortable = True
        end
        item
          FieldName = 'DaysInWork'
          Title.Caption = #1044#1085#1077#1081' '#1074' '#1088#1072#1073#1086#1090#1077
          Width = 106
          Sortable = True
        end
        item
          FieldName = 'Flag'
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Width = 64
          Visible = False
          ReadOnly = True
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
          Title.Caption = 'updDatetime'
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
        end>
    end
    object pFilter: TUniPanel
      Left = 0
      Top = 0
      Width = 1640
      Height = 121
      Hint = ''
      ShowHint = True
      Align = alTop
      TabOrder = 2
      ShowCaption = False
      Caption = 'pFilter'
      ParentAlignmentControl = False
      LayoutAttribs.Align = 'top'
      LayoutAttribs.Pack = 'start'
      LayoutConfig.Region = 'north'
      object gbFilter: TUniGroupBox
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 1632
        Height = 113
        Hint = ''
        ShowHint = True
        Caption = #1060#1080#1083#1100#1090#1088
        Align = alClient
        LayoutConfig.Width = '0'
        TabOrder = 1
        object UniLabel1: TUniLabel
          Left = 17
          Top = 16
          Width = 36
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1057#1090#1072#1090#1091#1089':'
          TabOrder = 1
        end
        object UniLabel2: TUniLabel
          Left = 259
          Top = 16
          Width = 36
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1055#1088#1072#1081#1089':'
          TabOrder = 2
        end
        object UniLabel3: TUniLabel
          Left = 379
          Top = 16
          Width = 40
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1050#1083#1080#1077#1085#1090':'
          TabOrder = 3
        end
        object fCancel: TUniBitBtn
          Left = 1135
          Top = 35
          Width = 128
          Height = 24
          ShowHint = True
          Action = actFilterClear
          TabOrder = 10
          ImageIndex = 3
        end
        object fOk: TUniBitBtn
          Left = 1285
          Top = 35
          Width = 137
          Height = 24
          ShowHint = True
          Action = actFilter
          TabOrder = 12
          IconPosition = ipButtonEdge
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          ScreenMask.Message = #1046#1076#1080#1090#1077', '#1086#1087#1077#1088#1072#1094#1080#1103' '#1074#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103
          ScreenMask.Target = Owner
          ImageIndex = 2
        end
        object fOrderNum: TUniEdit
          Left = 581
          Top = 35
          Width = 167
          Hint = ''
          ShowHint = True
          Text = ''
          TabOrder = 7
          EmptyText = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072
          CheckChangeDelay = 200
          ClearButton = True
          OnKeyDown = fStatus2KeyDown
        end
        object UniLabel4: TUniLabel
          Left = 581
          Top = 16
          Width = 76
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072':'
          TabOrder = 9
        end
        object UniLabel5: TUniLabel
          Left = 890
          Top = 16
          Width = 34
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1054#1090#1082#1072#1079':'
          TabOrder = 11
        end
        object cbCancel: TUniComboBox
          Left = 890
          Top = 35
          Width = 81
          Height = 23
          Hint = ''
          ShowHint = True
          Text = 'cbCancel'
          Items.Strings = (
            #1053#1077#1090
            #1044#1072)
          ItemIndex = 0
          TabOrder = 8
          EmptyText = #1054#1090#1082#1072#1079
          ClearButton = True
          IconItems = <>
          OnKeyDown = fStatus2KeyDown
        end
        object fStatus2: TUniCheckComboBox
          Left = 17
          Top = 35
          Width = 236
          Hint = ''
          ShowHint = True
          Text = ''
          TabOrder = 4
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
        object fPriceLogo: TUniCheckComboBox
          Left = 259
          Top = 35
          Width = 114
          Hint = ''
          ShowHint = True
          Text = ''
          TabOrder = 5
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
          EmptyText = #1055#1088#1072#1081#1089' '#1083#1080#1089#1090
          CheckChangeDelay = 100
          ClearButton = True
          Triggers = <
            item
              ImageIndex = 3
              ButtonId = 0
              HandleClicks = True
              Hint = #1054#1095#1080#1089#1090#1080#1090#1100
              HideOnReadOnly = False
            end
            item
              ImageIndex = 2
              ButtonId = 1
              HandleClicks = True
              Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100
              HideOnReadOnly = False
            end>
          Images = UniImageList
          HideTrigger = True
          HideDefaultTrigger = False
          IconItems = <>
          OnSelect = fPriceLogoSelect
          OnKeyDown = fStatus2KeyDown
        end
        object fClient: TUniCheckComboBox
          Left = 379
          Top = 35
          Width = 196
          Hint = ''
          ShowHint = True
          Text = ''
          TabOrder = 6
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
          EmptyText = #1050#1083#1080#1077#1085#1090
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
          Images = UniImageList
          HideTrigger = True
          HideDefaultTrigger = False
          IconItems = <>
          OnSelect = fClientSelect
          OnKeyDown = fStatus2KeyDown
        end
        object UniLabel6: TUniLabel
          Left = 581
          Top = 63
          Width = 78
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080':'
          TabOrder = 13
        end
        object fOrderDate: TUniDateTimePicker
          Left = 754
          Top = 35
          Width = 130
          Height = 21
          Hint = ''
          ShowHint = True
          DateTime = 45257.000000000000000000
          DateFormat = 'dd/MM/yyyy'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 14
          ClearButton = True
          EmptyText = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072
          OnKeyDown = fStatus2KeyDown
        end
        object UniLabel8: TUniLabel
          Left = 754
          Top = 16
          Width = 65
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072':'
          TabOrder = 15
        end
        object edtUpdDate: TUniDateTimePicker
          Left = 977
          Top = 35
          Width = 130
          Height = 21
          Hint = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
          ShowHint = True
          DateTime = 45257.000000000000000000
          DateFormat = 'dd/MM/yyyy'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 16
          ClearButton = True
          EmptyText = #1044#1072#1090#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
          OnKeyDown = fStatus2KeyDown
        end
        object UniLabel10: TUniLabel
          Left = 977
          Top = 16
          Width = 97
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1044#1072#1090#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103':'
          TabOrder = 17
        end
        object edtInvoice: TUniEdit
          Left = 977
          Top = 81
          Width = 130
          Hint = ''
          ShowHint = True
          Text = ''
          TabOrder = 18
          EmptyText = #1053#1086#1084#1077#1088' '#1080#1085#1074#1086#1081#1089#1072
          CheckChangeDelay = 200
          ClearButton = True
          OnKeyDown = fStatus2KeyDown
        end
        object UniLabel11: TUniLabel
          Left = 977
          Top = 63
          Width = 87
          Height = 13
          Hint = ''
          ShowHint = True
          Caption = #1053#1086#1084#1077#1088' '#1080#1085#1074#1086#1081#1089#1072':'
          TabOrder = 19
        end
        object fDetailNum: TUniEdit
          Left = 581
          Top = 81
          Width = 167
          Hint = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
          ShowHint = True
          Text = ''
          TabOrder = 20
          EmptyText = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
          CheckChangeDelay = 200
          ClearButton = True
          OnKeyDown = fStatus2KeyDown
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
        Width = 175
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
        Left = 175
        Top = 0
        Width = 175
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
          TabOrder = 2
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
          TabOrder = 3
        end
      end
      object UniPanel5: TUniPanel
        Left = 350
        Top = 0
        Width = 175
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
    object UniHiddenPanel1: TUniHiddenPanel
      Left = 1096
      Top = 192
      Width = 127
      Height = 244
      Hint = ''
      Visible = True
      ShowHint = True
    end
  end
  object Query: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evItems, evAutoFetchAll]
    FetchOptions.Items = []
    FormatOptions.AssignedValues = [fvSortOptions]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.UpdateTableName = 'tOrders'
    UpdateOptions.KeyFields = 'OrderID'
    UpdateOptions.AutoIncFields = 'OrderID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'SELECT '
      '       o.[OrderID]'
      '      ,o.Flag              Status '
      '      ,o.[ClientID]'
      '      ,o.[ClientName]'
      '      ,o.[OrderDate]'
      '      ,o.[PriceLogo]'
      '      ,o.CustomerPriceLogo -- '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1072#1081#1089#1072' '#1080#1079' '#1079#1072#1082#1072#1079#1072
      '      ,o.[OrderNum]'
      '      ,o.[StatusID]'
      '      ,o.[StatusName]'
      '      ,o.[isCancel]'
      '      ,o.isCancelToClient'
      '      ,o.MakeLogo'
      '      ,o.[Manufacturer]'
      '      ,o.[DetailNumber]'
      '      ,o.[DetailName]'
      '     -- ,o.[DetailNameF]'
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
      
        '      ,o.[DeliveryRestTermSupplier] -- '#1054#1089#1090#1072#1090#1086#1082' '#1089#1088#1086#1082#1072' '#1076#1086' '#1087#1086#1089#1090#1091#1087#1083#1077 +
        #1085#1080#1103' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
      '      ,o.[DeliveredDateToSupplier]  -- '#1044#1086#1089#1090#1072#1074#1083#1077#1085#1072' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
      '      ,o.[DeliveryDaysReserve]'
      '      ,o.[DeliveryNextDate]         -- '#1041#1083#1080#1078#1072#1081#1096#1072#1103' '#1076#1072#1090#1072' '#1074#1099#1083#1077#1090#1072' '
      '      ,o.[DeliveryNextDate2]        -- '#1041#1083#1080#1078#1072#1081#1096#1072#1103' '#1076#1072#1090#1072' '#1074#1099#1083#1077#1090#1072
      '      ,o.[DeliveryDateToCustomer]'
      '      ,o.[DeliveryTermToCustomer]'
      '      ,o.[DeliveryRestToCustomer]'
      '      ,o.[UserID]'
      '      ,o.[UserName]'
      '      ,o.[inDatetime]'
      '      ,o.[updDatetime]      '
      '      ,o.OverPricing -- '#1087#1088#1077#1074#1099#1096#1077#1085#1080#1077
      '      ,o.Warning'
      '      ,o.ReplacementMakeLogo'
      '      ,o.ReplacementDetailNumber'
      '      ,o.ReplacementManufacturer    '
      '      --,o.ReplacementPrice  '
      '      ,o.DestinationLogo -- '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
      '      ,o.Invoice'
      '      ,o.FileDate'
      '      ,o.Flag'
      
        '      ,o.OverVolume      -- '#1087#1088#1077#1074#1099#1096#1077#1085#1080#1077' '#1086#1073#1098#1077#1084#1072', '#1088#1072#1079#1085#1080#1094#1072' '#1054#1073#1098#1077#1084#1085#1099#1081' ' +
        #1074#1077#1089' - '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1074#1077#1089' '#1087#1086' '#1076#1072#1085#1085#1099#1084' '#1087#1088#1072#1081#1089'-'#1083#1080#1089#1090#1072'.'
      '      ,o.DateDeparture   -- '#1044#1072#1090#1072' '#1074#1099#1083#1077#1090#1072
      '      ,o.DaysInWork      -- '#1044#1085#1077#1081' '#1074' '#1088#1072#1073#1086#1090#1077
      '      '
      '  FROM [vOrders] o'
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
      '   !Invoice'
      '               '
      '  order by  o.[OrderID]  '
      '   ')
    Left = 575
    Top = 254
    MacroData = <
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
      end>
    object QueryUserID: TFMTBCDField
      FieldName = 'UserID'
      Origin = 'UserID'
      ReadOnly = True
      Precision = 18
      Size = 0
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
    object QueryOrderID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'OrderID'
      KeyFields = 'OrderID'
      Origin = 'OrderID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Precision = 18
      Size = 0
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
      Size = 256
    end
    object QueryOrderDate: TSQLTimeStampField
      FieldName = 'OrderDate'
      Origin = 'OrderDate'
      Required = True
    end
    object QueryPriceLogo: TWideStringField
      FieldName = 'PriceLogo'
      Origin = 'PriceLogo'
      ReadOnly = True
      Size = 32
    end
    object QueryOrderNum: TWideStringField
      FieldName = 'OrderNum'
      Origin = 'OrderNum'
      ReadOnly = True
      Size = 32
    end
    object QueryStatusName: TWideStringField
      FieldName = 'StatusName'
      Origin = 'StatusName'
      Size = 512
    end
    object QueryisCancel: TBooleanField
      FieldName = 'isCancel'
      Origin = 'isCancel'
    end
    object QueryMakeLogo: TWideStringField
      FieldName = 'MakeLogo'
      OnGetText = QueryMakeLogoGetText
      Size = 128
    end
    object QueryManufacturer: TWideStringField
      FieldName = 'Manufacturer'
      Origin = 'Manufacturer'
      OnGetText = QueryManufacturerGetText
      Size = 256
    end
    object QueryDetailNumber: TWideStringField
      FieldName = 'DetailNumber'
      Origin = 'DetailNumber'
      OnGetText = QueryDetailNumberGetText
      Size = 30
    end
    object QueryDetailName: TWideStringField
      FieldName = 'DetailName'
      Size = 512
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
    object QueryPrice: TCurrencyField
      FieldName = 'Price'
      Origin = 'Price'
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryAmount: TCurrencyField
      FieldName = 'Amount'
      Origin = 'Amount'
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryPricePurchase: TCurrencyField
      FieldName = 'PricePurchase'
      Origin = 'PricePurchase'
      DisplayFormat = '###,##0.00 $'
    end
    object QueryAmountPurchase: TCurrencyField
      FieldName = 'AmountPurchase'
      Origin = 'AmountPurchase'
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
    end
    object QueryNextDateDeparture: TSQLTimeStampField
      FieldName = 'DeliveryNextDate'
      Origin = 'DeliveryNextDate'
      OnGetText = QueryNextDateDepartureGetText
    end
    object QueryDeliveryNextDate2: TSQLTimeStampField
      FieldName = 'DeliveryNextDate2'
    end
    object QueryDateDeliveryToCustomer: TSQLTimeStampField
      FieldName = 'DeliveryDateToCustomer'
      Origin = 'DeliveryDateToCustomer'
    end
    object QueryTermDeliveryToCustomer: TIntegerField
      FieldName = 'DeliveryTermToCustomer'
      Origin = 'DeliveryTermToCustomer'
    end
    object QueryRestDeliveryToCustomer: TIntegerField
      FieldName = 'DeliveryRestToCustomer'
      Origin = 'DeliveryRestToCustomer'
    end
    object QueryUserName: TWideStringField
      FieldName = 'UserName'
      Origin = 'UserName'
      Size = 512
    end
    object QueryStatusID: TFMTBCDField
      FieldName = 'StatusID'
    end
    object QueryFlag: TIntegerField
      FieldName = 'Flag'
    end
    object QueryOverPricing: TCurrencyField
      FieldName = 'OverPricing'
      DisplayFormat = '###,##0.00 %'
    end
    object QueryWarning: TWideStringField
      FieldName = 'Warning'
      Size = 128
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
      Size = 64
    end
    object QueryDestinationLogo: TWideStringField
      FieldName = 'DestinationLogo'
    end
    object QueryInvoice: TWideStringField
      FieldName = 'Invoice'
      Size = 64
    end
    object QueryFileDate: TSQLTimeStampField
      FieldName = 'FileDate'
    end
    object QueryDateDeparture: TSQLTimeStampField
      FieldName = 'DateDeparture'
    end
    object QueryDaysInWork: TIntegerField
      FieldName = 'DaysInWork'
    end
    object QueryStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = QueryStatusGetText
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 648
    Top = 255
  end
  object actMain: TUniActionList
    Images = UniImageListAdapter
    Left = 102
    Top = 281
    object actEdit: TAction
      Category = 'Action'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1082#1072#1079
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1082#1072#1079
      ImageIndex = 6
      OnExecute = actEditExecute
    end
    object actRefreshAll: TAction
      Category = 'Action'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 5
      OnExecute = actRefreshAllExecute
    end
    object actExecuteAction: TAction
      Tag = -1
      Category = 'Action'
      OnExecute = actExecuteActionExecute
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
    object actProtocol: TAction
      Category = 'Grid'
      Caption = #1055#1088#1086#1090#1086#1082#1086#1083
      Hint = #1055#1088#1086#1090#1086#1082#1086#1083
      ImageIndex = 4
      OnExecute = actProtocolExecute
    end
    object actFilter: TAction
      Category = 'Filter'
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      ImageIndex = 2
      OnExecute = actFilterExecute
    end
    object actFilterClear: TAction
      Category = 'Filter'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1103' '#1092#1080#1083#1100#1090#1088#1072
      ImageIndex = 3
      OnExecute = actFilterClearExecute
    end
    object actSelect: TAction
      Category = 'Grid'
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      ImageIndex = 1
      OnExecute = actSelectExecute
    end
    object actUnselect: TAction
      Category = 'Grid'
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077' '#1086#1090#1084#1077#1090#1082#1080
      Hint = #1057#1085#1103#1090#1100' '#1074#1089#1077' '#1086#1090#1084#1077#1090#1082#1080
      ImageIndex = 0
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
      ImageIndex = 9
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
      Hint = #1043#1088#1091#1087#1087#1086#1074#1086#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1088#1080#1079#1085#1072#1082#1072' [B]Fragile[/B]'
      OnExecute = actGroupSetFragileSignExecute
    end
    object actCancellation: TAction
      Caption = #1055#1088#1086#1089#1090#1072#1074#1080#1090#1100' '#1087#1088#1080#1079#1085#1072#1082': '#1047#1072#1087#1088#1086#1096#1077#1085' '#1086#1090#1082#1072#1079
      OnExecute = actCancellationExecute
    end
  end
  object ppMain: TUniPopupMenu
    OnPopup = ppMainPopup
    Left = 101
    Top = 218
    object ppExecuteAction: TUniMenuItem
      Action = actExecuteActionEnabled
    end
    object N3: TUniMenuItem
      Action = actExecuteActionRollback
    end
    object N1: TUniMenuItem
      Caption = '-'
    end
    object N12: TUniMenuItem
      Action = actEdit
    end
    object N8: TUniMenuItem
      Action = actCancellation
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
      'select OrderID  '
      '  from vOrders (nolock)'
      ' WHERE OrderID  = :OLD_OrderID')
    DeleteSQL.Strings = (
      'DELETE FROM tOrders WHERE OrderID = :OLD_OrderID')
    FetchRowSQL.Strings = (
      'SELECT StatusID, '
      '       StatusName,'
      '       PricePurchaseF,'
      '       AmountPurchaseF,'
      '       ReplacementMakeLogo,'
      '       ReplacementDetailNumber,'
      '       OverPricing,'
      '       Warning,'
      '       Flag,'
      '       updDatetime,'
      '       DetailName,'
      '       WeightKGF,'
      '       VolumeKGf,'
      '       DetailName,'
      '       WeightKG,'
      '       VolumeKG,'
      '       isCancel,'
      '       --isCancelToClient,'
      '       PriceLogo,'
      '       Margin,'
      '       MarginF,'
      '       Income,'
      '       IncomePRC,'
      '       Profit,'
      '       DestinationLogo'
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
      'SELECT distinct'
      '       n.[NodeID]'
      '      ,n.[Name]'
      '  FROM [tNodes] n (nolock)'
      ' where n.Type = 0 -- '#1089#1086#1089#1090#1086#1103#1085#1080#1103)
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
      ' where PriceLogo is not null')
    Left = 574
    Top = 379
    object qPriceLogoPriceLogo: TWideStringField
      FieldName = 'PriceLogo'
      Size = 64
    end
  end
  object qClient: TFDQuery
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
      'SELECT c.[ClientID]'
      '      ,c.[Brief]'
      '      ,c.[Name]'
      '  FROM [tClients] c (nolock)'
      ' -- '#1087#1088#1072#1074#1072
      ' inner join vUserAccess ua (nolock)'
      '         on ua.UserID    = dbo.GetUserID()'
      '        and ua.LinkType  = 7'
      '        and ua.LinkID    = c.ClientID')
    Left = 500
    Top = 393
    object qClientClientID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'ClientID'
      ProviderFlags = [pfInWhere]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object qClientBrief: TWideStringField
      FieldName = 'Brief'
      Origin = 'Brief'
      Required = True
      Size = 256
    end
    object qClientName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Size = 512
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
    DataSet = qClient
    Left = 652
    Top = 432
  end
  object ppExecute: TUniPopupMenu
    ScreenMask.ShowMessage = False
    Left = 210
    Top = 218
  end
  object UniImageListAdapter: TUniImageListAdapter
    UniImageList = UniImageList
    Left = 352
    Top = 253
  end
  object UniImageList: TUniImageList
    Left = 349
    Top = 375
    Bitmap = {
      494C01010A001800040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006A6A6AF2717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF6B6B
      6BF4000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF00000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF000000000000
      0000000000000000000000000000000000000000000000000000717171FF7171
      71FF00000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF000000000000
      0000000000000000000000000000000000000000000000000000717171FF7171
      71FF00000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF000000000000
      0000000000000000000000000000000000000000000000000000717171FF7171
      71FF00000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFAA5E0ECBAA5C0CCAD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF00000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFCB700FF25D33066F03000003020000035B32066DCA700FF1D776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF00000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FF92500CAE180C011C190D021D93500BB094510BB21A0D011F160C021B8F4F
      0AACD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF000000000000
      0000000000000000000000000000000000000000000000000000535353BD1B1B
      1B3E00000000000000000000000000000000D77610FFD77610FFBD680EE24224
      044F030200035E340771CD700FF3D77610FFD77610FFCD700FF3613508730302
      00044023054DBD690EE0D77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF000000007171
      71FF717171FF717171FF717171FF0000000000000000000000000107000B1562
      01A000000000000000000000000000000000D37410FC7742088E0A06000C2C17
      0334AC5F0DCDD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFAD5E
      0DCE2D1803350A04000C7541088CD37310FB0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF000000007171
      71FF00000000717171FF717171FF0000000000000000061A012B1C8003D5229C
      02FF00000000000000000000000000000000291602320B05010D7A420A90D375
      10FCD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD47510FC7B4309920C07000E281603310000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF000000007171
      71FF00000000717171FF717171FF000000000C3B0161219602F5229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF44250551BF690EE3D77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFBF690EE4462605530000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000696969F0717171FF000000007171
      71FF717171FF717171FF717171FF000000000D39015D209502F3229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000051800291C7F01D2229C
      02FF00000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000106000A145F
      019C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000F0F6C85080842521717
      AFD51B1BCFFD1717B1DA0E0E698012128DAC000000000000000010B1FFFF6D6D
      6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D
      6DFF6D6D6DFF10B1FFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000001E643B2AE7B9C7D2FF7789A2FF234082FF040F32AF0000
      0021000000050000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001B1BD1FF1919C4F00707
      323E000002030E0E667C1B1BD1FF0E0E6A81000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF00000000000000000000000000000000000000000000
      00001C1C1C1D6E6D6C70A79E94B7BB9774EABB9774EAA79E94B76E6D6C701C1C
      1C1D000000000000000000000000000000000000000000000002000000090000
      000E0000000F0000002040261BAE879AB2FFC8E3F5FF1E65B6FF2A6AA8FF0412
      36AD0000001F0000000400000000000000006A6A6AF2717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF000000001B1BD1FF1B1BD1FF0D0D
      6A8207073C491919C4EF0D0D647B1717B2D9000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF00000000000000000000000000000000000000003838
      3839A49C93B0B88248FFB88248FFB88248FFB88248FFB88248FFB88248FF4E4E
      4E4F0000000000000000000000000000000000000000000000088B6657C0C38C
      79FFC38C78FFCBA395FFA89894FF478BC3FFDEFEFDFF50B4E3FF1E67B7FF3072
      AEFF051537AA0000001C0000000400000000717171FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000707
      3C491919C4EF070739460000000000000000000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFF8C8CE8FF8C8CE8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF000000000000000000000000000000001C1C1C1DA49C
      93B0B88248FFADA194BF656464661E1E1E1F1E1E1E1F65646466555454560000
      00004C4C4C4D000000000000000000000000000000000000000CC5917DFFFDFB
      FAFFFCF8F6FFFAF7F5FFECEAE9FF7BA3BFFF469FD2FFDEFEFDFF58BFE9FF206A
      B9FF357AB3FF07163AA70000001A00000004717171FF000000003838387F3838
      387F000000003838387F3838387F00000000000000001515ADD40D0D6B821919
      C4EF070739460D0D667E1B1BD1FF1B1BD1FF000000000000000010B1FFFF6D6D
      6DFFFFFFFFFF8C8CE8FF1717D1FF1717D1FF8C8CE8FFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF000000000000000000000000000000006E6D6C70B882
      48FFADA194BF2D2D2D2E00000000000000000000000000000000000000004C4C
      4C4DB88248FF4C4C4C4D0000000000000000000000000000000CC79481FFFEFB
      FAFFF9F0EAFFF8F0EAFFF7F0EBFFE8E4E1FF7DA4BFFF4AA5D5FFDEFEFDFF60CA
      EFFF236EBCFF3A83B9FF081A3CA300000018717171FF000000003838387F3838
      387F000000003838387F3838387F00000000000000000E0E667D1B1BD1FF0D0D
      687F00000607070734401919C2EE1B1BD1FF000000000000000010B1FFFF6D6D
      6DFFFFFFFFFF8F8FE8FF8F8FE8FF8F8FE8FF1717D1FF8C8CE8FFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF00000000000000000000000000000000A79E94B7B882
      48FF6564646600000000000000000000000000000000000000004C4C4C4DB882
      48FFB88248FFB88248FF4C4C4C4D00000000000000000000000BC99786FFFEFC
      FBFFF9F2EDFFF9F2EDFFF9F0EBFFF8F2EDFFEBE7E5FF82A7C2FF4DAAD7FFDEFE
      FDFF67D4F4FF2774BEFF3E8BBEFF091B3E9E717171FF00000000000000000000
      00000000000000000000000000000000000000000000111188A70E0E667C1515
      ADD41A1ACBF91616ABD2080842510C0C647A000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8FE8FF1717D1FF8C8CE8FFFFFF
      FFFF6D6D6DFF10B1FFFF0000000000000000B88248FFB88248FFB88248FFB882
      48FFB88248FFB88248FFB88248FF00000000030303044C4C4C4DB88248FFB882
      48FFB88248FFB88248FFB88248FF4C4C4C4D000000000000000ACB9C8BFFFEFD
      FCFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF8F2EEFFEDE9E7FF85ABC7FF50AE
      DAFFDEFEFDFF6DDDF8FF2B7AC2FF17438BFF717171FF000000003838387F3838
      387F000000001B1BD1FF1B1BD1FF000000002B2B2B6202020207000000000707
      071100000003000000003333337500000000000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8FE8FF8F8FE8FFFFFF
      FFFF6D6D6DFF10B1FFFF00000000000000004C4C4C4DB88248FFB88248FFB882
      48FFB88248FFB88248FF4C4C4C4D0000000000000000B88248FFB88248FFB882
      48FFB88248FFB88248FFB88248FFB88248FF0000000000000009CFA08DFFFEFE
      FDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF8F4EFFFEFECE9FF89AE
      CAFF53B1DCFFDEFEFDFF4EA6D4FF102B4E93717171FF000000003838387F3838
      387F000000001B1BD1FF1B1BD1FF000000003838387F2B2B2B62000000003838
      387F3838387F00000000717171FF00000000000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF0000000000000000000000004C4C4C4DB88248FFB882
      48FFB88248FF4C4C4C4D00000000000000000000000000000000000000006564
      6466B88248FFA79E94B700000000000000000000000000000009D0A393FFFEFE
      FDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4EFFFFAF6F1FFF3EF
      EDFF83A0B8FF347EBCFF1639598F0000000C717171FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000717171FF00000000000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF000000000000000000000000000000005A59595BB882
      48FF4C4C4C4D00000000000000000000000000000000000000002D2D2D2EADA1
      94BFB88248FF6E6D6C7000000000000000000000000000000008D3A897FFFEFE
      FEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5F1FFFBF5F0FFFAF6
      F3FFE2CCC4FF000000160000000600000001717171FF000000003838387F3838
      387F000000003838387F3838387F000000003838387F3838387F000000003838
      387F3838387F00000000717171FF00000000000000000000000010B1FFFF6D6D
      6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF6D6D6DFF10B1FFFF000000000000000000000000000000000F0F0F104C4C
      4C4D0101000175737277656464661E1E1E1F1E1E1E1F65646466ADA194BFB882
      48FFA49C93B01C1C1C1D00000000000000000000000000000007D3AB9AFFFFFE
      FEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F2FFFBF6
      F1FFD1A494FF0000000C0000000000000000717171FF000000003838387F3838
      387F000000003838387F3838387F000000003838387F3838387F000000003838
      387F3838387F00000000717171FF00000000000000000000000010B1FFFF6D6D
      6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D
      6DFF6D6D6DFF10B1FFFF00000000000000000000000000000000000000000101
      00016C6B6A6EB88248FFB88248FFB88248FFB88248FFB88248FFB88248FFA49C
      93B0383838390000000000000000000000000000000000000006D8AE9DFFFFFF
      FEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7F5FFFBF7F4FFFCF7
      F3FFD3A897FF0000000B0000000000000000717171FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000717171FF00000000000000000000000010B1FFFF10B1
      FFFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D
      6DFF10B1FFFF10B1FFFF00000000000000000000000000000000000000000000
      00001C1C1C1D6E6D6C70A79E94B7BB9774EABB9774EAA79E94B76E6D6C701C1C
      1C1D000000000000000000000000000000000000000000000006D8B0A0FFFFFF
      FFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8F6FFFBF7F6FFFCF7
      F5FFD4AC9BFF0000000A0000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF000000000000000000000000000000000000
      00006D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D6DFF6D6D
      6DFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000005D9B3A3FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFEFEFFFEFEFEFFFEFE
      FEFFD7AE9EFF000000090000000000000000696969F0717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF6A6A6AF2000000000000000000000000000000000000
      000000000000000000006A6A6A6D8D8D8DEA8B8B8BEB6E6E6E71000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000003A2857AC0DBB5
      A5FFDAB5A4FFDAB5A4FFDAB4A4FFD9B3A3FFD9B3A3FFD9B3A2FFD9B2A2FFD8B2
      A2FF9F8376C20000000600000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000002000000080000000C0000
      000D0000000E0000000E0000000E0000000E0000000E0000000F0000000F0000
      000F0000000F0000000E0000000A00000002000000020000000A0000000F0000
      0010000000100000001000000010000000110000001100000011000000110000
      001100000011000000100000000A000000020000000000000000000000000000
      000000000000020202030C0C0C0D181818191919191A0D0D0D0E66656568ECE5
      E1FFB1ADACB70000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000077F6054BFB18676FFB186
      75FFB18676FFB18575FFB08575FFB18575FFB08575FFB08576FFB18575FFB185
      75FFB08575FFB08575FF7D5E54C10000000900000009835D4EC1B6836DFFB782
      6CFFB5816CFFB5806BFFB5806BFFB4806BFFB47D6AFFB47D69FFB37C68FFB37C
      67FFB27C68FFB27B67FF805649C20000000A0000000000000000000000000000
      0000000000000C0C0C0D666E778C23539DF622529BF6747C87A092B5A1FF006F
      3DFF99B9A5FF6968686B00000000000000000000000000000000000000000000
      0000000000000000000000000000020202037A7987965E5799DB2C2C2C2D0000
      00002C2C2C2D5B5798DB7A798696020202030000000AB38878FFFBF7F4FFFBF7
      F4FFFAF6F4FFFAF6F4FFFAF5F3FFFAF5F2FFFAF5F2FFFAF5F1FFFAF5F2FFF9F4
      F1FFFAF4F0FFF9F4F1FFB18675FF0000000D0000000EBC8B75FFF8F2EDFFF6EF
      EBFFF6EEEAFFF6EFEAFFF6EFEAFFF6EEE9FFF6EEE9FFF5EEE9FFF6EDE8FFF5EE
      E8FFF5EDE8FFF6EFEBFFBB8773FF0000000E0000000000000000000000000000
      00000000000016161617245FABFFD6EDF7FF90C5E6FF2F64A9FF1C8457FB3FBD
      96FF128250FFD5D9D0FF5E5D5D5F000000000000000000000000000000000303
      03040C0C0C0D10101011101010117C7B8DA13D4BC0FF435ED6FF4747A1EE4F4F
      50524747A0EE3D58D4FF3545BCFF7B7A8A9C0000000BB38879FFFBF8F6FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAF5F2FFB28777FF0000000E0000000EBE8D78FFF8F3EFFFF5EE
      E9FFF6EEE9FFF5EEEBFFF4F0ECFFEBE8E5FFEEE9E8FFF5EFEAFFF5ECE7FFF4EC
      E6FFF4EBE6FFF6F0ECFFBD8A75FF0000000F0000000000000000000000000000
      00000000000018181819225CA9FFC1E6F5FF78BCE3FF42956EFF37B088FF45C6
      9EFF2DAB81FF43936DFF5C5C5C5E000000000000000000000000000000000B0B
      0B0C376FB7FF2858A8FF87A2CEFF2D2899FF8596E1FF5778E6FF4B69DEFF2E33
      A2FE4866DDFF5170E4FF7086DDFF5E579ADB0000000AB58A7AFFFCF9F7FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FBF6F3FFB48879FF0000000D0000000DC08F7BFFFAF3F1FFF7EF
      EAFFF6F0EBFFF2EEECFFCEBDB2FFA36341FFB08C79FFEBE8E5FFF5EEE9FFF5ED
      E7FFF5ECE7FFF7F1EDFFBD8B77FF0000000E0000000000000000000000000000
      000000000000161616172059A7FFCEE7F0FF95BBA7FF21996AFF63D1B2FF61D1
      B0FF4CC9A3FF209867FF94BAA5FF7E7D7D810000000000000000000000000E0E
      0E0F215BA9FFC1E6F5FF9FD1EFFF7892C6FF5252A8EF8EA1E8FF5A7BE7FF5777
      E5FF5777E6FF8397E6FF5151A4ED2929292A00000009B58C7DFFFCFAF8FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FBF7F5FFB48A7BFF0000000C0000000CC2917DFFFAF5F3FFF8F1
      EDFFF5F1EFFFD3C2B8FFB57D58FFE2BD8BFFAB714CFFC7B5ABFFF1EDEBFFF5EE
      E9FFF5EEE9FFF8F3EDFFBF8E7AFF0000000D0000000000000000000000000000
      0000010101021A1A1A1B1F58A6FFADDDF0FF1F9766FF13935EFF13925DFF6CD6
      B8FF007943FF148A5EFE30966EF43B3B3B3C0000000000000000000000000D0D
      0D0E1F58A7FFABE2F6FF5AB3E7FF86A4CDFF5857595C4247AEFE83A0F1FF84A1
      F2FF829FF0FF4044ABFE4F4F50520000000000000008B78E80FFFDFAF9FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCF8F6FFB58B7CFF0000000C0000000CC39581FFFBF8F4FFF6F3
      F1FFD9C8BFFFB9845DFFE4C18FFFE6C393FFDCB687FFA36C4EFFDDD6D2FFF6F0
      EDFFF6EFEAFFF9F3EFFFC0907CFF0000000D0000000000000000000000000404
      040515151516656C768A1F57A6FF8CD0EEFF53ABDFFF7190BCFF149560FF76DA
      BEFF007D48FEA6A5A4AE1E1E1E1F919090940000000000000000000000010D0D
      0D0E1E57A6FF8FD6F4FF96CCEEFF758EC3FF4E509FEF87A1EDFF97B2F6FFC1D0
      F8FF96B1F6FF859EECFF4E4F9FEE2C2C2C2D00000008B89081FFFDFBFAFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCF9F7FFB68D80FF0000000B0000000BC59785FFFAF7F5FFE1D1
      C7FFBE8D69FFEACCA5FFF1DEBFFFF5E4CAFFEBCCA1FFCEA275FFAB7E69FFE8E6
      E3FFF6F2EEFFF9F3F1FFC29380FF0000000C0000000000000000040404052B2B
      2B2D5A7EA1D03881C4FF4B96D2FF47A1D9FF3292D1FF5A98CEFF159864FF83DD
      C5FF0E7C51F73B3B3B3C00000001000000000000000000000001050505064747
      47491E56A6FF73CAEEFF90C9ECFF2F2FA9FFA8B7EFFFA4BCF8FFCAD3F5FF6160
      B6FEC7D1F4FFA2BBF8FFA6B5EEFF5956A3E100000007BA9283FFFEFCFBFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCFAF8FFB88F81FF0000000A0000000AC69A88FFFBF9F7FFDBC5
      B8FFC99F81FFE4CCB4FFCAA082FFB98462FFEAD5BBFFEBCEA4FFC4936AFFB897
      86FFEEEAE8FFF8F3F0FFC39683FF0000000B000000000303030431313133457A
      B7EE539FD6FF79C0E8FF93CFEFFF58BFE9FF3EADDFFF4F98D3FF189A67FF8CE0
      CBFF017F51FE696A6B72040404050000000000000001050505065D5E60633C72
      B5FB63A5D8FF7BC9EBFF94D1EDFF4E5BBEFF9C9CDAFFD6D9F3FF5E5EB5EF5050
      51535E5DB0EED1D5F1FF9597D6FF7C7C909F00000006BB9386FFFEFCFCFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFBF9FFBA9183FF0000000A0000000AC89D8BFFFCFAF8FFFAF7
      F6FFD9C3B4FFC1957AFFD4BDAFFFDED3CDFFBC8E70FFEBD7BEFFEED3ADFFBB86
      60FFC4AEA2FFF0ECE9FFC49885FF0000000A000000010A0A0A0B6283A4C95FAC
      DDFF86CDEFFFC3EAF9FFA8E2F8FF68CFF0FF44BAE6FF3F94D5FF199B6DFFC3F1
      E6FF008650FF6580A0D50E0E0E0F0000000103030304595A5B5E4485C3FF84CB
      EEFFC3EAF9FF8EDAF2FF81D0EEFF9DC7E9FF5463C5FF3334B3FF7F8189910404
      04052C2C2C2D605CAADE7A7A88930202020300000006BD9587FFFEFDFCFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFBFAFFBB9385FF0000000900000009CAA08EFFFBFAF8FFFCF9
      F6FFFAF7F6FFF8F5F3FFF9F6F4FFF8F6F4FFE8DFDAFFBC8E70FFE5CDB5FFF1DE
      BDFFBA8561FFE9E6E3FFC59A88FF0000000A020202034B4D4F534692CCFF8BD2
      F1FFBAE9F9FFE2F7FDFFAFE7F9FF6FD4F2FF47BFE8FF75B4E0FF56B692FF1B9E
      6FFF4EB294FF6296CAFF4F51545A04040405121212135E87B4E882C8EBFFBAE9
      F9FFE2F7FDFF90DEF5FF47C0E8FF75B7E4FF8AB2E0FF90BBE4FF91ABCCF11414
      14150000000100000000000000000000000000000005BE9889FFFEFEFDFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FEFCFBFFBC9587FF0000000800000008CCA391FFFCFBFAFFFCF8
      F5FFFCF8F5FFFBF7F4FFFBF7F4FFFAF6F5FFFAF7F6FFEBE5E1FFC0967AFFC598
      79FFD1C3BAFFF1EFECFFC99E8CFF00000009050505066C8293A968B6E1FF99E1
      F7FFDFF7FDFFF5FCFFFFB1EBFBFF73D7F3FF4AC5EAFF72B4DFFF538DCFFF3881
      CDFF5CAEE6FF68A8D8FF66788FAE0909090A6365676A5397CEFF99E1F7FFDFF7
      FDFFF5FCFFFF8BDFF5FF49C5EAFF48A6DEFF2970C6FF2F7ACCFF3C83C6FF6466
      686C0303030400000000000000000000000000000005C0998BFFFEFEFEFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FEFDFCFFBE9689FF0000000800000007CDA593FFFDFBFAFFFCF9
      F7FFFCF9F7FFFCF8F6FFFBF9F5FFFBF8F5FFFBF8F5FFFAF8F6FFF4F2F1FFEEEC
      EBFFF4F2F0FFFAF7F6FFCBA18FFF00000008060606074D8DBBEC91D5F2FFC5EF
      FBFFF1FCFEFFEBFAFDFFE4F9FDFFDFF8FDFFDAF7FDFFD5F6FDFFC7ECF9FFA1D1
      EEFF86CBF1FF4CADE5FF3B6BA5EC0B0B0B0C828F9FB284C2E6FFC3EDFAFFE6F7
      FDFFE2F5FCFFDFF6FCFFDEF6FCFFD7F5FBFFB7DCF2FF8FC0E7FF5AA6DCFF828D
      9EB30505050600000000000000000000000000000004C19B8DFFFFFEFEFFFFFE
      FEFFFEFEFEFFFFFEFEFFFFFEFEFFFEFEFDFFFEFDFDFFFEFEFDFFFEFEFDFFFEFD
      FDFFFEFDFDFFFEFDFDFFBF998BFF0000000600000006CEA796FFFDFBFAFFFEFB
      FAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFBFAFFFDFBF9FFFCFBFBFFFAF9
      F8FFFBFAF8FFFCFAF8FFCCA391FF0000000704040405398BC8FFF2FAFDFFB9C6
      E2FF6584C0FF3961B1FF0C40A4FF114EADFF185DB8FF216EC1FF4F9CD6FF73BB
      E6FFAAE0F4FFC5F0FBFF2564ABFE0909090A4B83BAF4D5EFFAFF9BB8DDFF608A
      C7FF0F44A7FF0D46A9FF104BADFF1452B1FF6298D1FF99C2E5FFC5ECF9FF5279
      B5EF05050506000000000000000000000000000000028F736ABFC29C8FFFC19C
      8FFFC29C8EFFC29C8EFFC19B8FFFC29B8EFFC29C8EFFC19B8EFFC19B8DFFC19B
      8DFFC19A8DFFC19A8DFF8E7268C10000000400000004997D71C1CFA998FFCFA8
      98FFCFA997FFCFA997FFCFA897FFCEA796FFCFA796FFCFA896FFCFA796FFCEA6
      96FFCEA794FFCEA694FF977B6FC1000000050101010253575A5E5794C5F093C7
      E7FFC7E6F4FFE4F4FBFFE8F7FCFFF4FCFEFFEFFBFDFFD6F2FAFFCAEBF8FFA6D6
      EFFF6EAFDCFF407BB6F156595D64030303046A6C6F736296C3F9AAD2EBFFCEEA
      F7FFDCF1FAFFE2F5FBFFE0F5FBFFD6F2FBFFC2E7F6FF9CCCEAFF5692C0F96A6D
      6F74020202030000000000000000000000000000000100000002000000030000
      0004000000040000000400000004000000040000000400000005000000050000
      0005000000050000000500000004000000010000000100000004000000050000
      0006000000060000000600000006000000060000000600000006000000060000
      0006000000060000000600000004000000010000000001010102101010115559
      5C606F8291A1658FADCF5A8EB6DE3585C4FF3381C2FF5587B2DE5D85A9D16B7C
      8EA4575A5E6414141415030303040000000102020203202020217275797E8195
      A8BE7393B2D53977BDFF3976BCFF7392B2D58092A7BF72767A7F242424250202
      020300000001000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000000FFFFF00000000
      000F0000000000003FCF0000000000003FCF0000000000003FCF000000000000
      000F000000000000000F0000000000003FCF00000000000021CF000000000000
      298F00000000000029000000000000002100000000000000FF8F000000000000
      FFCFFFFF00000000FFFFFFFF00000000C003FFFFF80FFF80C003FFFFF807FF80
      C003F00F80030080C003E00F80017FE3C003C01780004980C003C3E380004980
      C003C7C180007F80C003010080004925C003018080004925C00383E380007FFD
      C003C7C380004925C003C00380034925C003E00780037FFDC003F00F80030001
      F00FFFFF80030001FC3FFFFF8003FFFF00000000F807FFFF00000000F803FE10
      00000000F801E0001FF80000F801E0001FF80000F800E0001FF80000F000E001
      1FF80000E000C0001FF80000C00180001FF80000800100001FF8000000000000
      1FF80000000000071FF80000000000071FF80000000000070000000000000007
      0000000000000007000000008000000700000000000000000000000000000000
      000000000000}
  end
  object UniImageList32: TUniImageList
    Width = 32
    Height = 32
    Left = 351
    Top = 313
    Bitmap = {
      494C01010A000C00040020002000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000008000000060000000010020000000000000C0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A5A5ACC717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF5E5E5ED40000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000717171FF717171FF717171FF717171FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000717171FF717171FF717171FF717171FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000717171FF717171FF717171FF717171FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000717171FF717171FF717171FF717171FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000717171FF717171FF717171FF717171FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000717171FF717171FF717171FF717171FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFBD670EE14223044E3E21044ABB660EDFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD37410FC7641088D0A06000C00000000000000000904000B743F0989D273
      10FBD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFAA5D
      0CCA2A1603310000000000000000000000000000000000000000000000002615
      032EA75C0BC7D77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFCB700FF25B32066E0200
      00030000000000000000190D011E96520BB199530AB51B0F0220000000000000
      0000020100025930076AC96F0FF0D77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF91500CAD160C021B000000000000
      00000302000460340872CD700FF3D77610FFD77610FFCD700FF5633607760401
      00050000000000000000140B01198D4E0BA9D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000717171FF717171FF545454BB1A1A1A3C0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFBD670EE14223044E0000000000000000000000002C18
      0335AD5E0DCED77610FFD77610FFD77610FFD77610FFD77610FFD77610FFAF60
      0DD12F1903380000000000000000000000003E21044ABB660EDFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000545454BB1A1A1A3C00000000000000000000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD37410FC7641088D0A06000C00000000000000000A05000E7A430A91D475
      10FCD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD47410FD7E4509950D06000F00000000000000000904000B743F0989D273
      10FBD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF0000000000000000717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF00000000000000000000000000000000000000000000
      000000000000000000000107000B146201A10000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFAA5D
      0CCA2A16033100000000000000000000000045250552BF690EE4D77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFC26A0EE6472706560000000000000000000000002615
      032EA75C0BC7D77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF0000000000000000717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF00000000000000000000000000000000000000000000
      000000000000061A012C1D8303D6229C02FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFCB700FF25B32066E0200
      00030000000000000000190D011E96520BB1D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF99530AB51B0F0220000000000000
      0000020100025930076AC96F0FF0D77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF0000000000000000717171FF717171FF0000000000000000717171FF7171
      71FF717171FF717171FF00000000000000000000000000000000000000000000
      00000D3C0162219602F5229C02FF229C02FF0000000000000000000000000000
      00000000000000000000000000000000000091500CAD160C021B000000000000
      00000302000460340872CD700FF3D77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFCD700FF5633607760401
      00050000000000000000140B01198D4E0BA90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF0000000000000000717171FF717171FF0000000000000000717171FF7171
      71FF717171FF717171FF000000000000000000000000000000000107000B1462
      01A1229C02FF229C02FF229C02FF229C02FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002C18
      0335AD5E0DCED77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFAF60
      0DD12F1903380000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF0000000000000000717171FF717171FF0000000000000000717171FF7171
      71FF717171FF717171FF000000000000000000000000061A012C1D8303D6229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF000000000A05000E7A430A91D475
      10FCD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD47410FD7E4509950D06000F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF0000000000000000717171FF717171FF0000000000000000717171FF7171
      71FF717171FF717171FF00000000000000000D3C0162219602F5229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF45250552BF690EE4D77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFC26A0EE6472706560000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000717171FF717171FF717171FF7171
      71FF0000000000000000717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF00000000000000000B37015A209302F2229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000575757C4717171FF717171FF7171
      71FF0000000000000000717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF000000000000000000000000051800271D7F01D0229C
      02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C02FF229C
      02FF229C02FF229C02FF229C02FF229C02FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000050009135E
      0199229C02FF229C02FF229C02FF229C02FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000B37015A209302F2229C02FF229C02FF0000000000000000000000000000
      000000000000000000000000000000000000D77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD77610FFD776
      10FFD77610FFD77610FFD77610FFD77610FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000051800271D7F01D0229C02FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000050009135E01990000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000000000000F0F728B0000
      000000000000020210140D0D6A831515ADD41B1BCDFB1B1BCEFC1717B2DA1010
      758E0303191E0202101414149DBF05052B340000000000000000000000000000
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
      00000000000000000000000000000000000000000000000000001B1BD1FF0F0F
      728B07073B481919C1EC1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1B
      D1FF1A1AC8F51717B2DA1B1BD1FF14149DBF0000000000000000000000000000
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
      00000000000000000000000000000000000000000000000000001B1BD1FF1B1B
      D1FF1B1BCFFE1B1BD1FF121296B70606323F010105060000040506062D371212
      96B71B1BD1FF1B1BD1FF1717B2DB020210140000000000000000000000000000
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
      00000000000000000000000000000000000000000000000000001B1BD1FF1B1B
      D1FF1B1BD1FF1616A0C40000010100000000000000000000000003031C221818
      B8E11B1BD1FF1B1BD1FF1919C8F603031B210000000000000000000000000000
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
      0004000000010000000000000000000000005A5A5ACC717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF00000000000000001B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF0D0D6C84000000000000000003031C221818B8E11B1B
      D1FF1717B4DD141498B91B1BD1FF0F0F76910000000000000000000000000000
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
      000700000001000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF00000000000000001B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF1B1BD1FF0D0D6C8403031C221818B8E11B1BD1FF1717
      B4DD0303191E05052D381B1BD1FF1717AFD70000000000000000000000000000
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
      000700000001000000000000000000000000717171FF717171FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000003031C221818B8E11B1BD1FF1717B4DD0303
      191E000000000000000000000000000000000000000000000000000000000000
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
      000700000001000000000000000000000000717171FF717171FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000003031C221818B8E11B1BD1FF1717B4DD0303191E0000
      0000000000000000000000000000000000000000000000000000000000000000
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
      000700000001000000000000000000000000717171FF717171FF000000000000
      00003838387F3838387F3838387F3838387F00000000000000003838387F3838
      387F3838387F3838387F000000000000000000000000000000001717A7CD1B1B
      D1FF0707364303031C221818B8E11B1BD1FF1717B4DD0303191E0E0E657C1B1B
      D1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF0000000000000000000000000000
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
      000600000001000000000000000000000000717171FF717171FF000000000000
      00003838387F3838387F3838387F3838387F00000000000000003838387F3838
      387F3838387F3838387F000000000000000000000000000000000F0F6D861B1B
      D1FF14149FC31818B8E11B1BD1FF1717B4DD0303191E00000000000000000E0E
      657C1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF0000000000000000000000000000
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
      000700000001000000000000000000000000717171FF717171FF000000000000
      00003838387F3838387F3838387F3838387F00000000000000003838387F3838
      387F3838387F3838387F00000000000000000000000000000000030314191919
      C4F01B1BD1FF1B1BD1FF1717B4DD0303191E0000000000000000000000000000
      010113139CC11B1BD1FF1B1BD1FF1B1BD1FF0000000000000000000000000000
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
      000800000002000000000000000000000000717171FF717171FF000000000000
      00003838387F3838387F3838387F3838387F00000000000000003838387F3838
      387F3838387F3838387F00000000000000000000000000000000020210141717
      B0D81B1BD1FF1B1BD1FF14149DBF0606364201010A0E01010B0D060638441313
      97BA1B1BD1FF1B1BCDFB1B1BD1FF1B1BD1FF0000000000000000000000000000
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
      000D00000003000000010000000000000000717171FF717171FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000141498B91B1B
      D1FF1717B0D71919C4EF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1BD1FF1B1B
      D1FF1919BFEA080839470D0D5F741B1BD1FF0000000000000000000000000000
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
      001400000007000000020000000000000000717171FF717171FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000505232B1414
      98B902021014030312160D0D6A831616A9D01A1AC6F31A1AC8F41616A8CE0D0D
      667E01010F1200000000000000000D0D5F740000000000000000000000000000
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
      0A900000000F000000060000000200000000717171FF717171FF000000000000
      00003838387F3838387F3838387F3838387F00000000000000001B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF0000000000000000343434770B0B0B1A000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000F0F0F2400000000000000000000000000000000000000000000
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
      40FF180D218D0000000C0000000500000001717171FF717171FF000000000000
      00003838387F3838387F3838387F3838387F00000000000000001B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF00000000000000003838387F343434770B0B0B1A0000
      0000000000000000000015151531080808150101010503030306000000000000
      00004F4F4FB4707070FE00000000000000000000000000000000000000000000
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
      8BFF201F95FF09093D8B0000000B00000004717171FF717171FF000000000000
      00003838387F3838387F3838387F3838387F00000000000000001B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF00000000000000003838387F3838387F343434770B0B
      0B1A00000000000000003838387F3838387F3838387F3838387F000000000000
      0000717171FF717171FF00000000000000000000000000000000000000000000
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
      E3FF2A2DAAFF24249CFF0E0E458900000006717171FF717171FF000000000000
      00003838387F3838387F3838387F3838387F00000000000000001B1BD1FF1B1B
      D1FF1B1BD1FF1B1BD1FF00000000000000003838387F3838387F3838387F3434
      347700000000000000003838387F3838387F3838387F3838387F000000000000
      0000717171FF717171FF00000000000000000000000000000000000000000000
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
      E1FF98A2E7FF7A85D0FF262996FF00000007717171FF717171FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000717171FF717171FF00000000000000000000000000000000000000000000
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
      EEFFACC0F3FF4D56C3FF21235A8400000004717171FF717171FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000717171FF717171FF00000000000000000000000000000000000000000000
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
      FCFF6574D7FF252960830000000500000002717171FF717171FF000000000000
      00003838387F3838387F3838387F3838387F00000000000000003838387F3838
      387F3838387F3838387F00000000000000003838387F3838387F3838387F3838
      387F00000000000000003838387F3838387F3838387F3838387F000000000000
      0000717171FF717171FF00000000000000000000000000000000000000000000
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
      CEFF2B306681000000040000000200000001717171FF717171FF000000000000
      00003838387F3838387F3838387F3838387F00000000000000003838387F3838
      387F3838387F3838387F00000000000000003838387F3838387F3838387F3838
      387F00000000000000003838387F3838387F3838387F3838387F000000000000
      0000717171FF717171FF00000000000000000000000000000000000000000000
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
      000500000002000000010000000000000000717171FF717171FF000000000000
      00003838387F3838387F3838387F3838387F00000000000000003838387F3838
      387F3838387F3838387F00000000000000003838387F3838387F3838387F3838
      387F00000000000000003838387F3838387F3838387F3838387F000000000000
      0000717171FF717171FF00000000000000000000000000000000000000000000
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
      000300000000000000000000000000000000717171FF717171FF000000000000
      00003838387F3838387F3838387F3838387F00000000000000003838387F3838
      387F3838387F3838387F00000000000000003838387F3838387F3838387F3838
      387F00000000000000003838387F3838387F3838387F3838387F000000000000
      0000717171FF717171FF00000000000000000000000000000000000000000000
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
      000300000000000000000000000000000000717171FF717171FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000717171FF717171FF00000000000000000000000000000000000000000000
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
      000300000000000000000000000000000000717171FF717171FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000717171FF717171FF00000000000000000000000000000000000000000000
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
      000300000000000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF00000000000000000000000000000000000000000000
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
      000200000000000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF00000000000000000000000000000000000000000000
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
      000200000000000000000000000000000000717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF00000000000000000000000000000000000000000000
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
      000200000000000000000000000000000000575757C4717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
      71FF717171FF5A5A5ACC00000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000101010203030304050505060505
      0506050505060505050605050506050505060505050605050506050505060505
      0506050505060505050605050506050505060505050605050506050505060505
      0506050505060606060706060607060606070606060706060607060606070606
      0607050505060303030401010102000000010101010203030304050505060505
      0506050505060505050605050506050505060505050605050506050505060505
      0506050505060505050605050506050505060505050605050506050505060505
      0506050505060606060706060607060606070606060706060607060606070606
      0607050505060303030401010102000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000000000
      0000000000010101010203030304040404050404040520202021010101020000
      00010000000013131314161616170E0E0E0FC5BAB5E14A4A4A4B000000000000
      0000000000000000000000000000010101010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000060606070D0D0D0E131313151515
      1518151515181515151815151518151515181616161916161619161616191616
      1619161616191616161916161619161616191616161916161619161616191616
      16191616161916161619161616191717171A1717171A1717171A1717171A1616
      1619141414170F0F0F100606060701010102060606070D0D0D0E131313151515
      1518151515181515151815151518151515181616161916161619161616191616
      1619161616191616161916161619161616191616161916161619161616191616
      16191616161916161619161616191717171A1717171A1717171A1717171A1616
      1619141414170F0F0F1006060607010101020000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000000000
      00010303030408080809101010111414141515151516101010110909090A0303
      0304000000010404040424242425CCC6C3F5456653FFD2CAC7FF2C2C2C2D0606
      0606000000000101010100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000001010101020202020301010102000000010000
      0000000000000000000000000001010101020202020301010102000000010000
      0000000000000000000000000000000000000E0E0E0F8B726AC0AB7A6AFFAA7A
      6AFFAA7A6AFFAA7A6AFFAA7A6AFFAA7A6AFFAA796AFFAA7A6AFFAA7A69FFAA7A
      69FFAA7A69FFAA796AFFAA796AFFAA796AFFAA7A69FFAA7969FFA97969FFAA79
      69FFAA7869FFA97969FFA97869FFAA7869FFAA7968FFA97869FFAA7869FFAA79
      69FFA97868FF897168C10F0F0F10030303040E0E0E0F8B726AC0AB7A6AFFAA7A
      6AFFAA7A6AFFAA7A6AFFAA7A6AFFAA7A6AFFAA796AFFAA7A6AFFAA7A69FFAA7A
      69FFAA7A69FFAA796AFFAA796AFFAA796AFFAA7A69FFAA7969FFA97969FFAA79
      69FFAA7869FFA97969FFA97869FFAA7869FFAA7968FFA97869FFAA7869FFAA79
      69FFA97868FF897168C10F0F0F10030303040000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000010101
      01020808080935363638627492BA2E59A1F52E59A1F5617392BB3737383A0909
      090A1D1D1D1E25252526C5C0BDD8577060FE448D71FF556D5FFFE1D9D5FF0A09
      090A000000000202020200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000001010102040404050909090A0A0A0A0B06060607020202030000
      0001000000000000000103030304070707080A0A0A0B0A0A0A0B050505060101
      01020000000000000000000000000000000012121214AB7B6CFFF8F1EDFFF8F1
      EDFFF8F1EDFFF8F1EDFFF8F1ECFFF8F0ECFFF8F0ECFFF8F0ECFFF8F1ECFFF8F0
      ECFFF8EFECFFF8EFECFFF8F0ECFFF8EFECFFF8EFECFFF8EFECFFF8EFECFFF8EF
      ECFFF8EFEBFFF8F0EBFFF7EFEAFFF7EFEBFFF7EFEAFFF7F0EAFFF7EFEAFFF7F0
      EAFFF7EFEAFFAA7969FF141414160505050612121214AB7B6CFFF8F1EDFFF8F1
      EDFFF8F1EDFFF8F1EDFFF8F1ECFFF8F0ECFFF8F0ECFFF8F0ECFFF8F1ECFFF8F0
      ECFFF8EFECFFF8EFECFFF8F0ECFFF8EFECFFF8EFECFFF8EFECFFF8EFECFFF8EF
      ECFFF8EFEBFFF8F0EBFFF7EFEAFFF7EFEBFFF7EFEAFFF7F0EAFFF7EFEAFFF7F0
      EAFFF7EFEAFFAA7969FF14141416050505060000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000010303
      0304101010115983ACD976B9DFFFBCECF9FF68BFEBFF4192D2FF46679CDC1313
      131428282829EEE7E4FFA3A7A0FF1A573CFF74D7BDFF17553AFFA3A69FFF4040
      4041020202020101010100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0001020202030606060715151516676482AB484089E13D3D3F420909090A0303
      030401010102030303040909090A3E3E4043484089E1676482AB161616170606
      06070101010200000000000000000000000014141416AC7D6CFFF8F2EDFFF6EC
      E6FFF5ECE6FFF5ECE5FFF6EBE6FFF5EBE6FFF6EBE6FFF5EBE6FFF5EBE6FFF6EB
      E5FFF5ECE5FFF6EBE6FFF6EBE5FFF6EBE5FFF6EBE5FFF5EBE5FFF5EAE5FFF6EB
      E5FFF5EBE5FFF5EBE5FFF5EBE5FFF5EAE5FFF6EAE5FFF6EAE5FFF5EBE5FFF6EA
      E5FFF7F0EAFFAA7A6AFF151515180505050614141416AC7D6CFFF8F2EDFFF7ED
      E8FFF7EDE8FFF6EDE7FFF7EDE7FFF7ECE7FFF7ECE8FFF6ECE7FFF6ECE7FFF7EC
      E7FFF6EDE7FFF7ECE7FFF7ECE7FFF7ECE6FFF7ECE7FFF6ECE7FFF6EBE7FFF7EC
      E6FFF7ECE7FFF6ECE6FFF6ECE7FFF6EBE6FFF7EBE6FFF7EBE6FFF6ECE6FFF7EB
      E6FFF7F0EAFFAA7A6AFF15151518050505060000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000010505
      0506202020213172BAFFA0E6FBFFB9EFFBFF65BFECFF51AFE9FF194FA2FF3131
      31332929292AD7D0CDFF26513BFF67BAA1FF4BC7A1FF5EB79DFF25503AFFD5CF
      CBFF181818190201010201010101000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000010303
      03040909090A18181819625D87BF464EBBFF4D5BCDFF3D3996F23E3E40430A0A
      0A0B060606070A0A0A0B3F3F40443E3A96F24C59CCFF3C43B7FF625D87BF1515
      15160505050600000001000000000000000014141416AD806EFFF9F2EEFFF6EC
      E6FFF6ECE6FFF6ECE6FFF5EAE5FFC7A591FFA26C4DFF8F4D2AFFA26B4DFFC6A4
      91FFF5E9E4FFF6ECE6FFF6EBE6FFF6EBE6FFF6ECE6FFF6EBE6FFF5EBE5FFF6EC
      E6FFF6ECE6FFF5ECE5FFF5EBE6FFF5EBE5FFF5EBE5FFF5EBE6FFF5EBE5FFF6EB
      E5FFF8F0ECFFAB7B6BFF151515180505050614141416AD806EFFF9F2EEFFF7ED
      E8FFF7EDE8FFF7EDE8FFF6ECE7FFE4D0C6FFD5BAABFFCDAE9DFFD6BAABFFE3D0
      C6FFF6EBE7FFF7EDE8FFF7ECE7FFF7ECE7FFF7EDE8FFF7ECE7FFF6ECE7FFF7ED
      E7FFF7ECE7FFF7ECE7FFF6ECE7FFF7ECE6FFF6ECE7FFF6ECE7FFF6ECE6FFF7EC
      E6FFF8F0ECFFAB7B6BFF15151518050505060000000000000000000000000000
      0000000000000000000000000000000000000000000000000001010101020707
      070838393A3C3373BBFF9DE3FAFFABE9F9FF5BB8E9FF51AEE8FF1C54A5FF4A4B
      4C50E6E0DCFF667C6FFF3D8466FF62D2B3FF3CC096FF61D1B2FF358162FF677B
      6DFFE6DEDAFF0B0A0A0B01010101000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001040404050E0E
      0E0F1B1B1B1C625D84BC4F5AC1FF495DD6FF4053D3FF4A5BD1FF3E3996F23F3F
      404410101011404041453F3B96F24F5FD3FF3D4FD0FF4151D2FF4148BBFF6460
      86B60909090A01010102000000000000000013131315AF8170FFF9F3EFFFF6ED
      E7FFF6EDE7FFF2E7E1FFA87356FFA86E44FFCA9964FFD8AC73FFC89761FFA76B
      41FFA67052FFF2E6E0FFF6ECE6FFF6ECE7FFF6ECE6FFF6ECE6FFF6EBE7FFF6EC
      E6FFF6ECE6FFF6EBE6FFF6ECE6FFF6ECE6FFF6EBE6FFF6EBE6FFF5EBE6FFF6EB
      E6FFF8F0ECFFAC7C6CFF141414170505050613131315AF8170FFF9F3EFFFF7EE
      E9FFF7EEE9FFF6EBE6FFD8BEB0FFD8BCA8FFE6CCB5FFEBD4BBFFE5CBB3FFD8BA
      A7FFD7BCADFFF6EAE5FFF7EDE8FFF7EDE8FFF7EDE8FFF7EDE8FFF7ECE8FFF7ED
      E7FFF7EDE7FFF7ECE7FFF7EDE7FFF7EDE7FFF7ECE7FFF7ECE7FFF6ECE7FFF7EC
      E7FFF8F0ECFFAC7C6CFF14141417050505060000000000000000000000000000
      0000000000000000000000000000000000000000000000000000010101020808
      08094D4E51563474BBFF9BE0F9FF99E2F6FF52B1E5FF4EACE8FF2158A8FF595A
      5E66B3B5AFFF1B553AFF75D3BAFF3FC299FF3BC096FF3FC299FF6ED1B6FF1954
      38FFB2B4AEFF1919191A03030304000000000000000000000000000000000000
      00000000000000000000000000000000000000000001020202030C0C0C0D595C
      606A8497BAEE37339CFF7A94E1FF475CD7FF4055D3FF4155D3FF4D5DD2FF3E3A
      96F25C5B626F413C96F25365D4FF3F51D2FF3B4ED1FF3F51D3FF6173D6FF463F
      8DE70909090A01010102000000000000000012121214AF8271FFF9F3EFFFF6EE
      E8FFF6EDE8FFC39E8AFFAB724AFFDCB37BFFDBB179FFDBB078FFDBB077FFDAAE
      76FFAA7149FFC29D87FFF6ECE7FFF6EDE8FFF6ECE8FFF7ECE7FFF7ECE7FFF7ED
      E7FFF7ECE7FFF6ECE7FFF6ECE7FFF6ECE7FFF6EDE7FFF6ECE7FFF6ECE7FFF6EC
      E7FFF8F1EEFFAD806EFF141414160505050612121214AF8271FFF9F3EFFFF7EF
      E9FFF7EEE9FFE3CFC4FFD9BDABFFEDD6BEFFECD6BEFFECD5BDFFECD5BDFFECD4
      BCFFD9BDAAFFE2CEC2FFF7EDE8FFF7EEE9FFF7EDE9FFF8EDE8FFF7EDE8FFF8ED
      E8FFF7EDE8FFF7EDE8FFF7EDE8FFF7EDE8FFF7EDE8FFF7EDE8FFF7EDE8FFF7ED
      E8FFF8F1EEFFAD806EFF14141416050505060000000000000000000000000000
      0000000000000000000000000000000000000000000000000000010101020A0A
      0A0B5B5E646D3374BCFF99DDF8FF84D9F3FF47AAE2FF4BA9E6FF275FABFFDCD6
      D4FF355C48FF6AB39DFF53CAA6FF3BC096FF3BC096FF3BC096FF4FC9A4FF57AE
      94FF325945FFDBD5D2FF2A2A2A2B010101010000000000000000000000000000
      0000000000000000000000000000000000000000000105050506141414153D65
      A5F0C8E2EFFF87A7D4FF4A4EB1FF829BE7FF485DD6FF4357D4FF4458D4FF4F60
      D3FF3736A1FE5669D6FF4356D3FF3F53D2FF4156D3FF6981DEFF4445A4F74444
      464A0606060701010102000000000000000012121214B18473FFFAF4F1FFF7EE
      E9FFF7EEE9FFA3694AFFD2A976FFDEB885FFDDB783FFDDB681FFDCB581FFDCB3
      7CFFCFA26EFFA06547FFF7EDE9FFF6EEE8FFF7EEE8FFF7EEE8FFF7EDE8FFF6ED
      E8FFF7EDE8FFF7EDE8FFF6EDE8FFF6EDE8FFF7EDE8FFF6EDE7FFF7EDE7FFF6ED
      E7FFF8F1EEFFAE816FFF141414160404040512121214B18473FFFAF4F1FFF8EF
      EBFFF8EFEAFFD6BAABFFE9D3BDFFEED9C2FFEDD9C1FFEDD8C1FFEDD9C3FFEED8
      C2FFE9D2BCFFD7BCAEFFF8EEEAFFF7EEE9FFF8EEE9FFF8EEE9FFF8EEE9FFF7EE
      E9FFF7EEE9FFF7EEE9FFF7EDE9FFF7EDE9FFF7EDE8FFF7EDE8FFF7EEE8FFF7ED
      E8FFF8F1EEFFAE816FFF14141416040404050000000000000000000000000000
      0000000000000000000000000000000000000000000000000000010101020B0B
      0B0C646A73833375BDFF96DAF8FF79D4F1FF3FA4DFFF53ACE4FFE0DBD9FF7C90
      84FF3C7961FF87DEC5FF56CDAAFF44C49CFF3CC096FF3BC096FF3BC097FF66D3
      B5FF2D7458FF7A8D82FFE6DDD8FF323232330000000000000000000000000000
      000000000000000000000000000000000000000000010606060726262627295C
      A9FFBBE9F7FFA0D1EAFF81A3D3FF4D51B3FF87A1E9FF4A61D7FF455BD7FF465C
      D6FF5166DAFF4659D5FF4257D5FF445BD6FF728CE1FF4A4BA6F74444464A0808
      08090202020300000001000000000000000011111113B18675FFFAF4F1FFF8EF
      EAFFF7EFEAFF995C3AFFE1C294FFE0BD8BFFE0BC8AFFDFBB88FFDFBA87FFDEB8
      85FFDFBB8BFF975835FFF7EEE9FFF7EEE9FFF7EEE9FFB0816FFFB0826FFFB081
      6FFFB0816FFFB0816FFFAF826EFFAF816EFFF7EDE9FFF6EEE9FFF7EDE8FFF6ED
      E8FFF9F2F0FFAF8271FF131313150404040511111113B18675FFFAF4F1FFF9F0
      EBFFF8F0EBFFD2B5A5FFEFDDC9FFEEDBC5FFEEDBC5FFEFDBC6FFF4E8DCFFF7F0
      EBFFF7F0EBFFF6EEE9FFF8F0ECFFF8EFEAFFF8EFEAFFE9D9D3FFF6EFEBFFF6EF
      EBFFF6EFEBFFECDED8FFDDC6BDFFDBC2B9FFF8EEE9FFF7EEEAFFF8EDE9FFF7ED
      E9FFF9F2F0FFAF8271FF13131315040404050000000000000000000000000000
      0000000000000000000000000000000000000000000000000000020202030C0C
      0C0D6973829B3377BFFF95D8F7FF72D0EFFF369EDDFFECEBE9FFC3C3BEFF1E56
      3BFF92D7C4FF61D0AFFF5ACEACFF59CEACFF48C69FFF3CC096FF3BC096FF41C3
      9AFF6BCDB3FF195339FFC0C0BBFFF3ECE9FF0000000000000000000000000000
      00000000000000000000000000000000000001010102080808093D3E3F423A72
      B8FFAEE5F6FF62B9E4FF9BCBE9FF7A8FC2FF5355B1FA849FE8FF4A63D9FF475F
      D8FF475ED8FF475DD7FF475DD7FF718DE2FF4E50A9F74545474B080808090202
      02030000000100000000000000000000000011111113B38876FFFAF5F2FFF8EF
      EBFFF8F0EBFFA56E4EFFDEC19EFFE1C392FFE1C290FFE1C08EFFE1BF8DFFE0BF
      8BFFDBBC97FFA36A4BFFF7EFEAFFF8EFEAFFF8EFEAFFF8EEEAFFF7EEEAFFF7EE
      EAFFF7EEEAFFF7EEEAFFF7EEE9FFF7EEE9FFF8EEEAFFF7EEEAFFF7EEE9FFF7EF
      E9FFF9F3F0FFB08472FF121212140404040511111113B38876FFFAF5F2FFF9F0
      ECFFF9F0ECFFD7BDAEFFEEDDCDFFEFDEC8FFEFDEC9FFF4E9DDFFF6F0ECFFEEE9
      E5FFE8E3DFFFEFE9E6FFF6F0ECFFF8F0ECFFF8F0ECFFF6F0ECFFEEE9E5FFE6E1
      DDFFECE7E3FFF5EFEBFFF8F1ECFFF8EEEAFFF8EEEAFFF8EEEAFFF8EEEAFFF8EE
      EAFFF9F3F0FFB08472FF12121214040404050000000000000000000000000000
      0000000000000000000000000000000000000000000000000001040404050F0F
      0F1066748CB13379C2FF92D6F7FF6BCCEEFF2F99DBFFE8E3E0FF446A56FF71AF
      9AFFB3ECDEFFB3ECDEFFB3ECDDFFB2ECDEFF5CCEADFF87E0C8FF7CDDC4FF99E5
      D2FF98E6D2FF5FAA92FF426753FFE6E1DDFF0000000000000000000000000000
      000000000000000000000000000000000001010101020909090A5153555C4483
      C1FFA9E3F6FF4EB1E3FF59AEE1FF94B0D3FF72748EB15058BBFE6381E2FF4B63
      DAFF4A62DAFF4A62D9FF556CDDFF464BB4FE5F5E66720D0D0D0E040404050101
      01020000000000000000000000000000000010101012B48977FFFAF5F3FFF8F0
      ECFFF8F0ECFFCBAB97FFB48663FFEDDBB7FFE7CCA0FFE4C696FFE6CA9EFFEDD7
      B4FFB58763FFCAA895FFF8F0ECFFF8EFEBFFF8F0EBFFF8EFEBFFF8EFEBFFF8EF
      EBFFF8EFEBFFF7EFEAFFF8EFEAFFF7EFEAFFF7EFEAFFF7EFEAFFF7EFEAFFF8EF
      EAFFFAF3F0FFB18574FF121212140404040510101012B48977FFFAF5F3FFF9F1
      EDFFF9F0EDFFE6D4CBFFDDC6B7FFF4E8D7FFF2E3D0FFF6EFEAFFE9E4E0FF776D
      A8FF2B1C8DFF8881B0FFEAE5E1FFF6F0ECFFF6F0ECFFE9E4E0FF8880AEFF2A1B
      8CFF756BA5FFE6E1DDFFF6F0ECFFF8EEEBFFF8EFEBFFF8EFEAFFF8EEEBFFF8EE
      EAFFFAF3F0FFB18574FF12121214040404050000000000000000000000000000
      00000000000000000000000000000000000001010102040404050B0B0B0C1C1C
      1C1D5275A1D92D76C3FF4397D7FF3D99D8FF2782CFFFE4E0DDFF1E8058FF1E7C
      58FF1E7C58FF1E7C58FF106540FFB3EDDEFF5ED0AEFF9CE5D2FF106440FF1E7C
      57FF1E7B57FF1E7B57FF1E7B57FFE3DEDAFF0000000000000000000000000000
      000000000000000000000000000000000001020202030B0B0B0C61656B774E91
      CBFFA4E0F5FF5FB9E5FF99CBEAFF869AC9FF4545A4F9758FE3FF6A87E5FF6E8A
      E8FF6E8AE7FF6A85E6FF627BE2FF6175DCFF45419FF23C3C3D40070707080202
      0203000000010000000000000000000000000F0F0F11B58B7AFFFBF6F4FFF8F2
      EDFFF9F1EDFFF8EFEBFFB28568FFB48663FFDFC7A7FFF0DFC3FFDEC5A7FFB385
      60FFB18266FFF8EEEAFFF9F1ECFFF8F0ECFFF8F0ECFFF9F1ECFFF8F0ECFFF8F0
      ECFFF8F0ECFFF8F0ECFFF8F0EBFFF8EFEBFFF8F0ECFFF8F0EBFFF8EFEBFFF8F0
      EBFFFAF4F2FFB28776FF11111113040404050F0F0F11B58B7AFFFBF6F4FFF9F1
      EEFFF9F1EEFFF9F0EDFFDDC5B9FFDDC6B7FFEFE1D2FFF0EAE6FF7A70ADFF3031
      AFFF3446CCFF1B1CA5FF8881B1FFE9E4E0FFE9E4E0FF8780AFFF1D1EA5FF3545
      CCFF2B2DAEFF776DA8FFEDE8E4FFF9EFEBFFF8EFEBFFF9EFEBFFF9EFEBFFF8EF
      EBFFFAF4F2FFB28776FF11111113040404050000000000000000000000000000
      000000000000000000000000000001010102050505060D0D0D0E5D6065703862
      A3F23574BDFF4799DAFF3B98DAFF2E90D7FF2A88D4FF57A0DAFFE3E0DDFFDDD8
      D6FFDDD8D6FFC6C2C0FF106742FFB7EDE0FF5FD1B0FF9DE6D3FF106641FFC3BF
      BDFFDBD6D4FFDCD6D4FFE2DDDAFF353535360000000000000000000000000000
      000000000000000000000000000000000001020202030D0D0D0E69727E90579E
      D3FFA7DEF3FF9FD1ECFF87AAD8FF4646ADFF89A1EAFF849DEEFF8099EDFF829A
      EDFF9EBAF4FF7A97EBFF7490EAFF748FE9FF6F86E1FF49439FF139393A3D0505
      0506010101020000000100000000000000000F0F0F11B78D7CFFFBF7F4FFF9F2
      EEFFF9F1EEFFF9F2EEFFF8F0ECFFD0B2A0FFAF7D60FF9E623FFFAE7D60FFCFB1
      9FFFF8F0EBFFF9F1EDFFF8F2EDFFF9F2EDFFF8F1EDFFF9F1EDFFF8F1EDFFF8F1
      EDFFF8F1EDFFF8F1EDFFF9F1EDFFF9F1EDFFF9F1EDFFF8F0EDFFF8F0EDFFF8F0
      ECFFFAF5F2FFB38877FF11111113040404050F0F0F11B78D7CFFFBF7F4FFF9F1
      EFFFF9F1EFFFF9F1EFFFF9F1EDFFE9D8CFFFDCC5BAFFEAE4DFFF33289AFF576A
      D8FF394FD3FF384DD2FF1C20A6FF847BAEFF837BADFF1E20A6FF384ED3FF384E
      D3FF4A5DD4FF342999FFE8E3DFFFF8F0ECFFF8F0ECFFF9F0ECFFF9F0ECFFF8EF
      ECFFFAF5F2FFB38877FF11111113040404050000000000000000000000000000
      0000000000000000000001010102060606071A1A1A1B627996C13272BAFF52A2
      DCFF5DACE1FF52A8E0FF3EA3DEFF3398DCFF2D8FD7FF2887D2FF2B8CD4FF3590
      D5FF3385CEFFDEDAD8FF116743FFB9EEE0FF62D2B1FFA0E7D4FF106742FFDDD8
      D6FF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000101010205050506121212136B7B8FAB5FA9
      D9FFC4E8F5FF8DB0DBFF4C4EB4FF99B0EFFF91A9F2FF8CA5F1FF8DA6F1FFA9C6
      F4FF6870BEFEAAC8F4FF86A0EFFF8098EDFF7C98ECFF8093E6FF4A44A0F13838
      3A3C030303040000000100000000000000000F0F0F10B88E7DFFFCF8F5FFF9F3
      EFFFF9F3EFFFF9F2EFFFF9F3EFFFF9F2EEFFF9F2EFFFF9F2EEFFF9F3EFFFF9F3
      EFFFF9F2EEFFF9F2EFFFF9F2EEFFF9F2EEFFF9F1EEFFF9F1EEFFF9F2EEFFF9F2
      EEFFF9F2EEFFF9F2EDFFF9F2EEFFF9F1EEFFF8F1EDFFF9F1EEFFF9F1EEFFF9F2
      EEFFFBF6F3FFB48A79FF10101012030303040F0F0F10B88E7DFFFCF8F5FFFAF2
      F0FFFAF2F0FFFAF2F0FFFAF2EFFFF9F1EFFFF9F2F0FFF3ECE8FF9B94BFFF4B4D
      BAFF647CE0FF3F58D6FF3F58D7FF1D22A7FF2327A8FF3F58D7FF3F58D7FF5970
      DEFF4648B8FF958EB9FFF0E8E5FFF9F0EDFFF9F0EDFFF8F0EDFFF9F0EDFFF8F1
      EDFFFBF6F3FFB48A79FF10101012030303040000000000000000000000000000
      00000000000001010102050505061F1F1F205979A0D14494D2FF5EB1E6FF6FBA
      E8FF6BB9E8FF5AB4E5FF47AFE3FF3BA4E1FF3297DBFF298AD5FF2C8DD6FF3C9A
      DCFF3F98DCFFDFDBD9FF116844FFBBEFE2FF64D3B3FFA0E7D6FF116843FFDFDB
      D8FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000001010102050505060E0E0E0F2F2F2F315278A8E067B5
      E0FFC1E5F3FF4D4FBDFFA5C0F3FF9BB3F6FF97B0F5FF98B1F4FFB1CEF8FF6469
      C0F761616B756368BDF6AFCDF7FF8EA6F1FF88A0F0FF889FEFFF8DA4EAFF5350
      A5E8050505060000000100000000000000000E0E0E0FB99081FFFCF8F6FFFAF3
      F0FFFAF3F0FFFAF4F0FFFAF3F0FFDCC5B7FFB38161FF9E5E37FFB2805FFFDCC4
      B5FFFAF3EFFFF9F3EFFFFAF3EFFFF9F3EFFFFAF3F0FFFAF3EFFFF9F3EFFFF9F2
      EFFFFAF3EFFFF9F3EFFFF9F2EEFFF9F2EFFFF9F2EFFFF9F2EFFFF9F2EFFFF9F2
      EFFFFBF6F4FFB68C7BFF0F0F0F11030303040E0E0E0FB99081FFFCF8F6FFFAF3
      F1FFFAF3F1FFF9F3F0FFFAF3F0FFEDE0D9FFDDC5B8FFD5B9A8FFE0D0C7FF9E97
      C2FF565AC1FF738DE6FF4862DBFF4863DBFF4863DBFF4862DBFF6783E3FF5154
      C0FF9992BDFFEDE7E3FFF7EFECFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1EEFFF9F1
      EEFFFBF6F4FFB68C7BFF0F0F0F11030303040000000000000000000000000000
      000000000001030303040E0E0E0F617C9DC74B9BD7FF67B9EBFF81C6EEFF8ACA
      EFFF7BC5EEFF69C3EBFF4FBBE8FF3EAAE5FF359DDFFF2A8DD7FF2C8BD6FF419F
      DEFF4AA3E3FFE0DDDAFF126A45FFBEF0E3FF66D3B4FFA3E9D6FF116A44FFE0DD
      D9FF000000010000000000000000000000000000000000000000000000000000
      000000000001020202030707070816161617696F798D42659FF84A90CCFF7AC0
      E8FFA4D5EEFF5F6FC9FF9BB2E9FFAFCAFAFFA3BCF9FFB5D3FAFF6269C3FC5050
      545A11111112404041446568BFF6B2D1F9FF97B0F4FF9FBAF6FF92A8E3FF6F6D
      94B2040404050000000100000000000000000E0E0E0FBA9283FFFCF8F7FFFAF4
      F1FFFAF4F1FFFAF4F1FFDFC8BAFFA86D47FFCFA372FFE1BC89FFCEA270FFA66A
      43FFDCC3B5FFF9F4F0FFFAF4F1FFFAF4F1FFFAF3F0FFFAF4F0FFF9F4F0FFF9F3
      F0FFFAF3F0FFFAF3EFFFFAF4F0FFFAF4EFFFFAF3EFFFFAF3EFFFFAF3F0FFF9F3
      F0FFFBF7F5FFB88D7DFF0F0F0F11030303040E0E0E0FBA9283FFFCF8F7FFFAF4
      F1FFFAF4F1FFFAF3F1FFEFE2DBFFD9BEADFFE8D3BEFFF0DDC8FFEEDFD2FFEEE9
      E5FF9F99C3FF5B61C7FF6583E5FF5572E2FF5572E2FF5572E2FF545AC6FF9A95
      BFFFEBE6E2FFF7F0ECFFF9F3EFFFF9F2EFFFF9F2EEFFF9F2EEFFF9F2EFFFF9F2
      EFFFFBF7F5FFB88D7DFF0F0F0F11030303040000000000000000000000000000
      00000101010207070708656D7582408CCAFF6CC0EFFF81CAF2FF99D6F4FF9DD8
      F3FF8AD1F2FF74CEF0FF52C2ECFF40B0E6FF37A3E2FF2D93DAFF288BD6FF3598
      DCFF4DAAE6FFE2DFDCFF126B46FFC0F0E4FF68D5B6FFA4E9D7FF126B46FFE1DE
      DCFF000000010000000000000000000000000000000000000000000000000000
      0000010101020707070823232324627899D15A93C6FF87C6ECFF7BC5EEFF69C3
      EBFF8CD0EEFF9ACCEBFF5F6CCBFF9FB8EBFFB7D5F9FF646DCCFF899FD1FF8E9C
      B4E32A2A2A2C0E0E0E0F3E3E4042666AC1F6B3D2F7FF9AB1E8FF70709FC20F0F
      0F10020202030000000100000000000000000D0D0D0EBC9485FFFDF9F7FFFAF5
      F2FFFBF6F2FFFAF5F2FFB2805EFFD2A879FFE2BE8DFFE2BE8DFFE2BE8CFFD2A8
      77FFB07C5CFFFBF5F2FFFBF5F2FFFAF4F1FFFAF4F1FFFBF4F1FFFAF5F1FFFBF4
      F1FFFAF5F1FFFAF5F1FFFAF4F1FFFAF4F1FFFAF4F1FFFAF4F1FFFAF4F0FFFAF3
      F1FFFCF8F5FFB88F81FF0F0F0F10030303040D0D0D0EBC9485FFFDF9F7FFFBF4
      F2FFFAF4F2FFFAF4F2FFDDC6B7FFEAD5C2FFF0DECBFFF3E6D9FFF7F1EDFFEFE9
      E6FF9892C0FF484EBEFF7292EBFF6183E7FF6283E7FF6183E7FF363EB6FF8F89
      B7FFECE7E3FFF6F0ECFFF9F3EFFFFAF3F0FFF9F2F0FFF9F3F0FFF9F3EFFFF9F2
      F0FFFCF8F5FFB88F81FF0F0F0F10030303040000000000000000000000000000
      0001040404052829292A3678B8FB62B8E9FF79C8F3FF9DD8F7FFACE1F8FFACE1
      F7FF97D9F5FF77D4F2FF53C8EDFF41B4E8FF38A5E3FF2D95DCFF278AD5FF3397
      DBFF4FAEE5FFE3E1DEFF136C47FFC2F1E5FF6AD5B7FFA6E9D8FF126B47FFE3E0
      DDFF010101020000000100000000000000000000000000000000000000000101
      0102050505061E1E1E1F617EA1D96FB5E1FF99D6F4FF9DD8F3FF8AD1F2FF74CE
      F0FF55C2EBFF88CBEDFF98C9EBFF5F6DCCFF6167D1FF87ABDFFFA2D1EFFF5EA3
      DAFF5A7399DB262626270C0C0C0D3D3D3E406B6BBFE872709BB70E0E0E0F0202
      0203000000010000000000000000000000000C0C0C0DBD9687FFFDF9F8FFFBF6
      F3FFFBF5F4FFFBF6F3FFA76C48FFE6C69CFFE4C292FFE3C192FFE3C091FFE4C5
      99FFA46842FFFBF5F2FFFBF6F2FFFAF6F2FFFAF5F3FFB48775FFB48775FFB486
      74FFB48674FFB38674FFB38674FFB38673FFFAF5F2FFFAF4F2FFFBF5F2FFFAF5
      F2FFFCF8F6FFB99182FF0E0E0E0F030303040C0C0C0DBD9687FFFDF9F8FFFAF5
      F2FFFAF4F3FFFAF5F2FFD9BEAFFFF2E2D0FFF1E0CDFFF7F0EBFFF1EBE7FFA19C
      C8FF535AC5FF85A1EFFF7697EDFF9CB6F4FF9DB7F5FF7797EEFF7596EDFF3F48
      BCFF9791BFFFEEE9E5FFF5EEEAFFDFC9C1FFFAF3F1FFFAF3F1FFFAF3F1FFFAF3
      F0FFFCF8F6FFB99182FF0E0E0E0F030303040000000000000000000000000101
      0102070707086C7A87984596D0FF6BBFEDFF8DD2F6FFCEEFF8FFD3F2F8FFB6E6
      F9FF9CDEF7FF7CDAF3FF54CBEDFF3FB4E8FF37A5E3FF2D95DBFF2588D4FF2E91
      D7FF4BAAE4FFE4E2E1FF136D48FFC4F1E6FF6CD6B9FFA7E9D9FF136D48FFE4E1
      E0FF020202030000000100000000000000000000000000000000000000010303
      03040B0B0B0C6F7E90AE63A8D9FF9DD8F7FFACE1F8FFACE1F7FF97D9F5FF77D4
      F2FF53C8EDFF45B5E8FF7CC4ECFF8CC3E9FF89BDE5FF90C4E9FF63B6E7FF57B0
      EBFF448DCDFF6B788CB111111112060606070404040502020203010101020000
      0001000000000000000000000000000000000C0C0C0DBE9788FFFDFBF8FFFBF7
      F5FFFCF7F5FFFBF6F4FFB68765FFDDC0A0FFE9CDA5FFE5C597FFE9CCA3FFDDC0
      A0FFB38362FFFBF6F3FFFBF6F3FFFBF6F4FFFBF6F3FFFBF6F3FFFBF6F3FFFBF6
      F3FFFBF5F3FFFBF6F3FFFBF6F3FFFBF5F2FFFBF6F3FFFBF6F3FFFBF5F3FFFBF5
      F2FFFDF9F8FFBB9384FF0E0E0E0F030303040C0C0C0DBE9788FFFDFBF8FFFAF6
      F4FFFBF5F4FFFBF5F3FFDFC8BBFFEEE0D2FFF4E4D4FFF4EDE8FFA8A4CFFF616A
      CFFF93AFF3FF83A1F1FFA6BFF7FF656BCAFF7C87DDFFAFC7F8FF83A3F2FF83A1
      F1FF4E56C4FF9C97C4FFF2ECE8FFFAF3F1FFFAF4F1FFFAF4F1FFFAF3F1FFFAF3
      F1FFFDF9F8FFBB9384FF0E0E0E0F030303040000000000000000000000000202
      02031B1B1B1C4387BCF556ACDEFF76C5F1FFBAE6F9FFDAF4F8FFDEF6F8FFCCF0
      F9FFA3E3F8FF82DFF4FF53CFEEFF3EB4E7FF35A5E3FF2D96DBFF2284D2FF288B
      D3FF44A7E0FFE6E4E3FF136F4AFFC6F1E7FF6DD7BAFFA9EAD9FF136E48FFE5E2
      E1FF050505060000000100000000000000000000000000000000010101020606
      06075153565B4C8BC1FF8DD2F6FFCEEFF8FFD3F2F8FFB6E6F9FF9CDEF7FF7CDA
      F3FF54CBEDFF3FB4E8FF37A5E3FF2D94DAFF2587D3FF2E91D7FF4BAAE4FF5BB4
      ECFF55ACEBFF3A71B4FF545659600909090A0303030401010102000000000000
      0000000000000000000000000000000000000B0B0B0CBF998AFFFDFBFAFFFCF8
      F5FFFCF8F6FFFCF7F5FFE4D0C4FFB17B57FFDCBFA1FFF1DEC4FFDCBEA0FFAF79
      54FFE0CABCFFFBF7F5FFFBF7F4FFFCF7F5FFFBF7F4FFFBF7F4FFFBF7F5FFFBF7
      F5FFFBF6F4FFFBF6F4FFFBF6F3FFFBF6F4FFFBF6F4FFFBF6F3FFFBF7F4FFFBF6
      F3FFFDFAF8FFBC9586FF0D0D0D0E030303040B0B0B0CBF998AFFFDFBFAFFFBF7
      F4FFFBF6F5FFFBF6F4FFF2E6E1FFDDC5B6FFEEDFD3FFF2ECE7FF6566D2FFAFC6
      F6FF8EADF4FFABC4F8FF6D74D0FFA49FCCFFAFACD5FF868EE1FFB5CCF9FF8DAC
      F4FFA1B8F4FF6565D2FFEFE9E6FFFAF4F3FFFAF4F3FFFAF4F2FFFAF5F2FFFAF4
      F2FFFDFAF8FFBC9586FF0D0D0D0E030303040000000000000000000000010404
      0405575B5E633E90CBFF5DB2E4FF8ED2F6FFD2F1F8FFDFF7F9FFE2F8F9FFD8F5
      F8FFAAE8F9FF7ADFF3FF51CDEEFF3CB4E7FF34A5E2FF2B95DBFF2081D0FF2588
      D2FF42A5E0FFE9E7E5FF14704AFFC6F2E7FFC6F1E7FFC6F1E7FF137049FFE7E5
      E4FF080808090101010200000000000000000000000000000001020202030B0B
      0B0C6A86A3CE6BB5E4FFBAE6F9FFDAF4F8FFDEF6F8FFCCF0F9FFA3E3F8FF82DF
      F4FF53CFEEFF3EB4E7FF35A5E3FF2D96DBFF2284D2FF288BD3FF44A7E0FF5EB6
      EAFF5BB1ECFF4898D8FF627998D0101010110404040500000001000000000000
      0000000000000000000000000000000000000B0B0B0CC19B8CFFFDFBFBFFFCF8
      F6FFFDF8F6FFFCF8F6FFFCF8F6FFE5D3C7FFBD9272FFAC7550FFBC9171FFE5D2
      C6FFFCF8F6FFFCF8F5FFFCF8F5FFFBF8F6FFFCF7F5FFFBF8F6FFFCF7F5FFFCF7
      F6FFFCF7F5FFFCF8F5FFFBF7F5FFFCF7F5FFFBF7F4FFFCF7F5FFFBF7F5FFFCF7
      F5FFFDFAF8FFBE9688FF0D0D0D0E020202030B0B0B0CC19B8CFFFDFBFBFFFBF7
      F5FFFCF7F5FFFBF6F5FFFBF6F5FFF2E8E2FFE2CEC2FFE7D9D0FFA7A5DCFF95A0
      EAFFC0D3F9FF7680D7FFACA8D3FFF4EEECFFF3EDEAFFB4B2DBFF8B93E6FFC1D3
      F9FF949EE9FFA4A3D8FFF4EEECFFFBF5F3FFFBF5F3FFFBF5F3FFFAF5F3FFFBF5
      F3FFFDFAF8FFBE9688FF0D0D0D0E020202030000000000000000000000010505
      05066F8492A24296CFFF63B6E7FFA6DDF8FFD8F4F9FFE2F8F9FFE5FAF9FFD8F6
      F8FFB5EDF8FF7CE0F4FF50CFEEFF3CB4E7FF33A4E2FF2993DAFF2081D0FF2285
      CFFF3A9FDDFFF0EEEDFF4C997AFF218860FF218860FF218860FF4C997AFFF0ED
      ECFF0B0B0B0C0202020300000000000000000000000000000001040404054041
      42454A8BC2FF8ED2F6FFD2F1F8FFDFF7F9FFE2F8F9FFD8F5F8FFAAE8F9FF7ADF
      F3FF51CDEEFF3CB4E7FF34A5E2FF2B95DBFF2081D0FF2588D2FF42A5E0FF5DB7
      EAFF5FB4EDFF52A9E9FF3970B3FF4546474B0707070801010102000000000000
      0000000000000000000000000000000000000A0A0A0BC29C8EFFFEFCFBFFFDF9
      F7FFFDF9F7FFFDF9F7FFFCF9F7FFFCF9F7FFFDF9F6FFFCF9F6FFFCF9F7FFFCF9
      F7FFFCF9F7FFFCF9F7FFFCF8F7FFFCF8F6FFFDF8F6FFFCF9F6FFFCF8F6FFFCF8
      F6FFFCF8F6FFFCF8F6FFFCF8F6FFFCF8F6FFFCF8F6FFFCF8F6FFFCF8F6FFFCF8
      F5FFFDFBF9FFBF988AFF0C0C0C0D020202030A0A0A0BC29C8EFFFEFCFBFFFCF8
      F6FFFCF7F6FFFCF7F6FFFBF7F6FFFBF7F6FFFCF7F5FFFAF6F4FFF5F0EDFFABAA
      E0FF6F72DCFFB2AFDAFFF5EFEDFFFAF5F4FFFBF5F4FFF5F0EDFFB7B5DEFF6F72
      DCFFA9A8DCFFF2EDEAFFFAF5F3FFFBF6F4FFFBF6F4FFFBF6F4FFFBF6F4FFFBF6
      F4FFFDFBF9FFBF988AFF0C0C0C0D020202030000000000000000010101020606
      06076694B1CF4194CEFF6BBBEAFFB5E4F9FFDEF6F9FFE4F9FAFFE4F9FAFFDCF6
      FBFFD7F4FBFFCAF1FBFFCFF3FBFFD2F5FCFFCFF5FCFFC4F0FCFFB0E2F7FFACE1
      F6FF9ED8F2FFA8DAF3FFF1EFEEFFEBE9E8FFE9E7E6FFEAE8E7FFF0EEECFF9FB2
      C9EA0D0D0D0E0303030400000000000000000000000001010102060606076A71
      7984559DD1FFA6DDF8FFD8F4F9FFE2F8F9FFE5FAF9FFD8F6F8FFB5EDF8FF7CE0
      F4FF50CFEEFF3CB4E7FF33A4E2FF2993DAFF2081D0FF2285CFFF3A9FDDFF5BB7
      E9FF61B6EDFF56ABEAFF3E87C8FF6C747F940A0A0A0B02020203000000000000
      0000000000000000000000000000000000000A0A0A0BC39E90FFFEFCFBFFFDFA
      F8FFFDF9F8FFFCFAF8FFFDFAF8FFF2EAE3FFC29674FFAA6B41FFC29473FFF3E8
      E2FFFDF9F7FFFDF9F8FFFCF9F7FFFCF9F7FFFCF9F7FFFDF9F7FFFCF9F7FFFDF9
      F7FFFDF9F7FFFCF8F7FFFDF8F7FFFCF9F7FFFCF8F7FFFCF9F6FFFDF9F7FFFCF8
      F7FFFDFBF9FFC09A8BFF0B0B0B0C020202030A0A0A0BC39E90FFFEFCFBFFFCF8
      F7FFFCF8F7FFFCF8F7FFFCF8F6FFF7F1EEFFE4D0C3FFDBBFAEFFE4CFC2FFF6EE
      EBFFF8F3F2FFFAF5F4FFFAF6F5FFFBF7F6FFFBF7F5FFFBF6F5FFF8F4F2FFF7F2
      F0FFF8F3F1FFFAF5F4FFFCF6F5FFFBF7F5FFFBF6F5FFFBF7F5FFFCF6F5FFFBF6
      F5FFFDFBF9FFC09A8BFF0B0B0B0C020202030000000000000000010101020606
      06074C97C6F361B2E0FFA4E1F7FFE1F7FCFFD7E7F3FF9EB9DCFF799FCFFF5685
      C1FF4072B7FF3A6FB8FF1554ACFF175BB3FF1B67BAFF2479C2FF519CD3FF58A4
      D7FF68B1E0FF80BFE7FF94CCEEFFBDE8F7FFA2D7F3FF56A8E2FF2B83CDFF386B
      ABF40F0F0F10030303040000000000000000000000000101010207070708718D
      A5C563AFE0FFB5E4F9FFDDF6F9FFE4F9FAFFE5F9FBFFDEF7FBFFD9F6FCFFCDF2
      FBFFDAF7FDFFD8F7FCFFD4F6FCFFB9E7F8FFB4E3F6FF9DD5F1FF77C1EAFF67BB
      EBFF59B2EBFF58AEEBFF4596D8FF68819DCA0D0D0D0E02020203000000000000
      0000000000000000000000000000000000000909090AC5A091FFFEFCFBFFFDFA
      F8FFFDFAF9FFFDFAF9FFFDFAF8FFC39776FFCDA274FFE8CB9BFFCDA071FFC092
      70FFFDFAF9FFFDFAF8FFFDF9F9FFFCFAF8FFFDF9F8FFFDF9F8FFFDF9F8FFFDF9
      F8FFFDFAF8FFFDF9F8FFFDF9F7FFFDFAF7FFFDFAF8FFFDFAF8FFFCFAF7FFFCF9
      F7FFFEFCFBFFC19C8DFF0B0B0B0C020202030909090AC5A091FFFEFCFBFFFCF8
      F7FFFCF8F7FFFCF8F8FFFCF8F7FFE5D1C4FFE9D4C3FFF3E5D2FFE9D4C2FFE3CF
      C1FFFCF8F7FFFCF8F7FFFCF7F7FFFBF8F6FFFCF7F6FFFCF7F6FFFCF7F6FFFCF7
      F6FFFCF7F6FFFCF7F6FFFCF7F6FFFCF8F6FFFCF7F6FFFCF7F6FFFBF7F5FFFBF7
      F5FFFEFCFBFFC19C8DFF0B0B0B0C020202030000000000000000010101020606
      06074196CDFEC1ECF9FFBBCFE6FF4E79BEFF1751ADFF1C57B2FF215FB6FF2263
      B7FF1D65B8FF1966BAFF1D6EBFFF227AC7FF2B8CCFFF3AA1D7FF52ADDDFF5DB5
      E3FF5FB9E7FF59B4E8FF4BABE6FF3897DAFF519CD6FFA6D3ECFF7BB8E3FF2B68
      AFFE0E0E0E0F0303030400000000000000000000000001010102080808096893
      B6DE86CFEEFFD5F6FBFFEEFCFDFFB9D0E7FF89A9D3FF5C87C2FF3D6DB4FF3164
      B2FF124FA9FF1556B0FF1862B7FF3D8CC9FF519CD4FF6BB1DEFF8CC8EAFFABDC
      F2FFBBE8F8FF6FBBEAFF3793DAFF537EAAEA0E0E0E0F03030304000000000000
      0000000000000000000000000000000000000909090AC6A193FFFEFDFCFFFDFB
      FAFFFDFAF9FFFDFBF9FFFDFAFAFFB57C54FFEDD8B4FFEBD1A5FFEDD6B2FFB174
      4CFFFEFAF9FFFDFAF9FFFDFAF8FFFDFAF9FFFDFBF8FFB88C79FFB88C79FFB88B
      79FFB88B79FFB78A79FFB78B79FFB78A78FFFDFAF9FFFDFAF8FFFDF9F8FFFCFA
      F8FFFEFCFBFFC39D8FFF0A0A0A0B020202030909090AC6A193FFFEFDFCFFFCF9
      F8FFFCF8F8FFFCF9F8FFFCF8F8FFDFC7B6FFF6EBDCFFF5E8D6FFF5EADBFFDDC3
      B3FFFCF8F8FFFCF8F7FFFCF8F7FFFCF8F7FFFCF8F7FFE1CCC4FFE0CCC5FFE0CC
      C4FFE0CBC4FFE0CBC4FFE0CBC4FFE0CBC4FFFCF8F7FFFCF8F6FFFCF7F6FFFBF7
      F6FFFEFCFBFFC39D8FFF0A0A0A0B020202030000000000000000000000010505
      0506559AC4EBE8F2F9FF255CB2FF1355B2FF1D64BDFF266EC4FF2A72C4FF2A74
      C5FF2274C2FF1E72C3FF217BC7FF288ACFFF339BD6FF47B2DFFF65C1E9FF75CD
      F0FF78D3F1FF71CEF3FF62C2F1FF4BAEE8FF2E90D3FF318ACCFFCCEAF7FF4474
      ADEA0B0B0B0C0202020300000000000000000000000001010102080808095693
      C3F7D0F2FBFFB4C7E3FF3868B6FF1750ADFF1E5AB2FF1F60B4FF1A60B5FF1762
      B8FF1A69BDFF2076C7FF288ACFFF39A1D8FF52AFE1FF5DB8E5FF5FBAE8FF57B4
      E7FF5EB2E6FFA2D7F2FF8BC7EBFF457AAFFA0D0D0D0E03030304000000000000
      00000000000000000000000000000000000008080809C7A395FFFEFDFCFFFEFB
      FAFFFEFBFAFFFEFCFAFFFDFBFAFFC79E80FFD6B595FFF6EBD3FFD5B493FFC599
      79FFFDFBFAFFFEFBF9FFFEFBF9FFFEFBFAFFFEFBF9FFFDFBF9FFFDFBFAFFFDFB
      FAFFFEFAF9FFFDFBF9FFFDFAF9FFFDFBF9FFFEFAF9FFFDFAF8FFFDFAF9FFFDFB
      F9FFFEFDFCFFC49F91FF0A0A0A0B0202020308080809C7A395FFFEFDFCFFFDF9
      F8FFFDF9F8FFFDF9F8FFFCF9F8FFE6D3C7FFEDDDD0FFFAF2E9FFECDCCFFFE6D1
      C5FFFCF9F8FFFCF9F8FFFDF9F8FFFDF9F8FFFDF8F7FFFCF9F7FFFCF9F8FFFCF9
      F8FFFCF8F7FFFCF8F7FFFCF8F7FFFCF8F7FFFCF8F7FFFCF8F7FFFCF8F7FFFCF8
      F7FFFEFDFCFFC49F91FF0A0A0A0B020202030000000000000000000000010202
      02035C63666B9ECAE6FFC2D6ECFF538FCFFF216CC4FF2873C8FF2C75C8FF2B78
      C7FF2477C5FF1F76C5FF2581CBFF2C8ED1FF37A0D9FF4DBAE4FF6DCAECFF83D7
      F3FF89DEF7FF81D9F9FF6ECEF5FF54B8EDFF61B2E2FFAFDAF1FF85B5DBFF5C61
      676F070707080101010200000000000000000000000001010102060606075B98
      C6F5EEF6FAFF1F57AFFF1759B6FF236BC3FF2A72C4FF2A74C4FF2171C2FF1B6F
      C1FF1E76C7FF2587CEFF3199D6FF47B4E0FF66C4EBFF77D0F2FF7AD6F3FF71CF
      F4FF5DBEEFFF4FADE7FFC5EDF7FF477DB2FA0C0C0C0D02020203000000000000
      00000000000000000000000000000000000007070708C8A496FFFEFDFCFFFEFB
      FAFFFDFBFBFFFEFCFBFFFDFCFBFFF6EFEAFFCBA58AFFB7825AFFCBA488FFF5EE
      E9FFFEFCFAFFFEFBFAFFFDFBFBFFFDFBFAFFFEFBFAFFFEFBFAFFFEFBFAFFFDFB
      FAFFFDFBFAFFFEFBF9FFFEFBFAFFFEFBFAFFFDFBFAFFFEFBFAFFFDFBF9FFFEFA
      F9FFFEFCFCFFC5A192FF0909090A0202020307070708C8A496FFFEFDFCFFFDF9
      F9FFFCF9F9FFFDFAF9FFFCF9F9FFFAF4F2FFE8D7CCFFE0C8BAFFE8D6CBFFF9F4
      F1FFFDFAF8FFFDF9F8FFFCF9F9FFFCF9F8FFFDF9F8FFFDF9F8FFFDF9F8FFFCF9
      F8FFFCF9F8FFFCF8F7FFFCF9F8FFFCF8F8FFFCF9F8FFFCF9F8FFFCF8F7FFFDF8
      F7FFFEFCFCFFC5A192FF0909090A020202030000000000000000000000000000
      000103030304565A5D607BB2D5F4C8E1F1FFE7F0F9FFB0CCEBFF90B8E2FF6AA3
      D8FF4F94D1FF4B94D1FF2C86CCFF2C90D2FF39A1DAFF54BCE5FF89D6F0FF97E0
      F5FFA6EAFAFFACE8FAFFB3E7FAFFCAEEFAFFAAD3EBFF679EC9F5585C60660909
      090A03030304000000010000000000000000000000000000000104040405788D
      9FB2ADCFE8FFB6CBE6FF4386CDFF2773C9FF2C75C8FF2B77C6FF2273C4FF1C71
      C3FF217BC9FF288AD1FF349ED9FF4CBAE4FF6FCDEFFF86DBF6FF8CE1F9FF7CDA
      F9FF79D0F6FFAAE1F7FF92C4E2FF738A9CB50808080901010102000000000000
      00000000000000000000000000000000000007070708C9A698FFFEFDFDFFFEFC
      FBFFFEFCFBFFFEFCFBFFFEFCFAFFFEFCFBFFFEFCFAFFFEFBFBFFFEFCFBFFFEFC
      FBFFFEFCFBFFFEFCFBFFFEFCFBFFFEFCFAFFFEFBFAFFFEFCFBFFFEFBFBFFFEFB
      FAFFFEFCFAFFFDFCFBFFFEFBFAFFFDFBFAFFFEFBFAFFFEFBFAFFFEFBFAFFFEFC
      FAFFFEFDFDFFC7A394FF080808090101010207070708C9A698FFFEFDFDFFFDFA
      F9FFFDFAF9FFFDFAF9FFFDFAF9FFFDFAF9FFFDFAF8FFFDF9F9FFFDF9F9FFFDFA
      F9FFFDF9F9FFFDF9F9FFFDFAF9FFFDF9F9FFFDF9F9FFFDFAF9FFFCF9F9FFFDF9
      F8FFFDF9F8FFFCF9F9FFFDF9F8FFFCF9F8FFFCF9F8FFFDF9F8FFFCF9F8FFFCF8
      F8FFFEFDFDFFC7A394FF08080809010101020000000000000000000000000000
      00000000000103030304181818196A757B8374A0BBD379BAE0FFA1CDE8FFC5E0
      F1FFDBECF6FFDAEBF6FFEAF4FAFFFAFDFEFFF7FCFEFFDFF1F8FFC9E5F4FFC3E3
      F3FFAAD5ECFF8ABFE1FF68A9D6FF6994B3D56A747D881D1D1D1E070707080202
      0203000000010000000000000000000000000000000000000001010101021818
      1819788E9EAF91C0E2FFDFEDF7FFC7DDF1FF9BC0E5FF6FA6D9FF4B91D0FF438E
      D0FF217BC9FF288CD1FF369FDBFF6AC7E9FF89D8F2FFA5E8F8FFB7F0FCFFC2F0
      FCFFBEE6F4FF7AB6DBFF758B9BB21F1F1F200404040500000001000000000000
      00000000000000000000000000000000000005050506CAA799FFFEFDFDFFFEFD
      FDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFD
      FDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFD
      FDFFFEFDFDFFFEFDFDFFFEFDFCFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFCFFFEFD
      FDFFFEFDFDFFC7A495FF070707080101010205050506CAA799FFFEFDFDFFFEFD
      FDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFD
      FDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFD
      FDFFFEFDFDFFFEFDFDFFFEFDFCFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFCFFFEFD
      FDFFFEFDFDFFC7A495FF07070708010101020000000000000000000000000000
      000000000000000000010101010203030304050505061E1E1E1F585D5F637487
      929E7594A7B8729CB5CF6E9CBAD54EA0D5FF4D9FD3FF6D99B8D56D98B4D07291
      A4B9738592A05A5E6267232323240909090A0606060703030304010101020000
      0001000000000000000000000000000000000000000000000000000000010202
      0203050505064E5152557599B3CC6CACD9FF97C3E4FFC0DDEFFFD5E9F5FFD2E9
      F4FFE8F7FCFFEBFAFEFFE1F6FCFFC7E6F4FFC5E5F4FFAFD7EDFF88BDE0FF63A6
      D4FF7195B0CD505254580909090A040404050101010200000000000000000000
      00000000000000000000000000000000000003030304A18C85C0CBA99AFFCBA8
      9AFFCAA89AFFCAA89AFFCAA899FFCAA89AFFCAA89AFFCAA79AFFCAA899FFCAA8
      99FFCAA799FFCAA799FFCAA799FFC9A799FFCAA698FFC9A798FFC9A798FFC9A6
      98FFC9A799FFC9A699FFCAA698FFC9A698FFC9A697FFC9A698FFC9A597FFC8A6
      98FFC9A697FF9F8B83C0040404050000000103030304A18C85C0CBA99AFFCBA8
      9AFFCAA89AFFCAA89AFFCAA899FFCAA89AFFCAA89AFFCAA79AFFCAA899FFCAA8
      99FFCAA799FFCAA799FFCAA799FFC9A799FFCAA698FFC9A798FFC9A798FFC9A6
      98FFC9A799FFC9A699FFCAA698FFC9A698FFC9A697FFC9A698FFC9A597FFC8A6
      98FFC9A697FF9F8B83C004040405000000010000000000000000000000000000
      0000000000000000000000000000000000010000000101010102020202030404
      0405050505060505050606060607070707080707070807070708070707080606
      0607060606070404040503030304010101020101010200000001000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00010101010202020203050505061E1E1E1F585C5F637586929E7599B4CC7499
      B5CF64A0C8EB559FD3FF649EC8EB7398B4D07498B2CD7485919F5A5E61662121
      2122080808090404040502020203000000010000000000000000000000000000
      0000000000000000000000000000000000000101010203030304050505060505
      0506060606070606060706060607060606070606060706060607060606070606
      0607060606070606060706060607060606070606060706060607060606070606
      0607060606070606060707070708070707080707070807070708070707080606
      0607060606070404040501010102000000010101010203030304050505060505
      0506060606070606060706060607060606070606060706060607060606070606
      0607060606070606060706060607060606070606060706060607060606070606
      0607060606070606060707070708070707080707070807070708070707080606
      0607060606070404040501010102000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000010000
      0001000000010000000101010102010101020101010201010102010101020101
      0102000000010000000100000001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000100000001010101020202020304040405050505060505
      0506060606070606060707070708060606070606060705050506040404050202
      0203010101020000000100000001000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000600000000100010000000000000600000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFFFFFF0000000000000000
      FFFFFFFFFFFFFFFF0000000000000000000000FFFFFFFFFF0000000000000000
      000000FFFFFFFFFF0000000000000000000000FF000000000000000000000000
      000000FF0000000000000000000000000FFFF0FF000000000000000000000000
      0FFFF0FF0000000000000000000000000FFFF0FF000000000000000000000000
      0FFFF0FF0000000000000000000000000FFFF0FF000000000000000000000000
      0FFFF0FF000000000000000000000000000000FF000180000000000000000000
      000000FF0007E0000000000000000000000000FF000C30000000000000000000
      000000FF00300C0000000000000000000FFFF0FF00E007000000000000000000
      0FFFF3FF0180018000000000000000000C03FCFF070000E00000000000000000
      0C03F8FF0C00003000000000000000000CC3F0FF3000000C0000000000000000
      0CC3C0FFE000000700000000000000000CC38000800000010000000000000000
      0CC300000000000000000000000000000C030000000000000000000000000000
      0C038000000000000000000000000000FFFFC0FF000000000000000000000000
      FFFFF0FF000000000000000000000000FFFFF8FFFFFFFFFF0000000000000000
      FFFFFCFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFF0000000000000000
      FFFFFFFFFFFFFFFF0000000000000000F000000FFFFFFFFFFE003FFFFFFFD800
      F000000FFFFFFFFFF000003FFFFFC000F000000FFFFFFFFFC000000FFFFFC000
      F000000FFFFFFFFFC000000FFFFFC1C0F000000FFFFFFFFF800000070000C180
      F000000FFFE007FF800000070000C000F000000FFF8001FF800000073FFFFE0F
      F000000FFF0000FF800000073FFFFC1FF000000FFE0000FF8000000730C3C000
      F000000FFC00017FC000000730C3C060F000000FFC07E23FC000000730C3C0E0
      F000000FF80FF40FC000000730C3C000F000000FF81FF807C00000033FFFC000
      F000000FF83FF007C00000033FFFC006F000000FF83FE003C000000130C33FFB
      F000000F0001C001C000000030C31C33F000000F80038000C000000030C30C33
      F000000FC007FC1FC000000030C30C33F000000FE00FFC1FC00000003FFFFFF3
      F000000FE01FF81FC00000003FFFFFF3F000000FF02FF01FC000000030C30C33
      F000000FFC47E03FC000000030C30C33F000000FFE80003FC000000330C30C33
      F000000FFF00007FC000000F30C30C33F000000FFF0000FFC000000F3FFFFFF3
      F000000FFF8001FFE000000F3FFFFFF3F000000FFFE007FFE000000F00000003
      F000000FFFFFFFFFF800000F00000003FF0000FFFFFFFFFFFC00000F00000003
      FF0000FFFFFFFFFFFE00000F00000003FFF00FFFFFFFFFFFFF00000FFFFFFFFF
      FFF81FFFFFFFFFFFFF80001FFFFFFFFF0000000000000000FFB0083EFFFFFFFF
      0000000000000000FFA0000BFFFC1C1F0000000000000000FF80000BFFF8080F
      0000000000000000FF800003FFE000070000000000000000FF800001FF800003
      0000000000000000FF800001FF8000030000000000000000FFC00001FF000003
      0000000000000000FFC00000FF0000030000000000000000FFC00000FF000003
      0000000000000000FFC00000FF0000070000000000000000FF800000FE00000F
      0000000000000000FF000000FE0000070000000000000000FE000000FE000003
      0000000000000000FC00000FFE0000030000000000000000F800000FFC000003
      0000000000000000F0000007F00000030000000000000000F0000007F0000003
      0000000000000000E0000003E00000070000000000000000E0000003C000000F
      0000000000000000E0000003C000003F0000000000000000C00000038000003F
      0000000000000000C00000038000003F0000000000000000C00000038000003F
      0000000000000000C00000038000003F0000000000000000C00000038000003F
      0000000000000000C00000038000003F0000000000000000C00000038000003F
      0000000000000000E00000038000003F0000000000000000F00000078000003F
      0000000000000000F800000FC000007F0000000000000000FE00003FE00000FF
      0000000000000000FFC001FFF80001FF00000000000000000000000000000000
      000000000000}
  end
end
