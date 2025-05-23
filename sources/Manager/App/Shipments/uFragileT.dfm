inherited FragileT: TFragileT
  Width = 1400
  Height = 498
  ExplicitWidth = 1400
  ExplicitHeight = 498
  inherited UniPanel2: TUniPanel
    Width = 1400
    Height = 498
    ExplicitWidth = 1400
    ExplicitHeight = 498
    inherited Grid: TUniDBGrid
      Top = 68
      Width = 1400
      Height = 430
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
          'r.getDockedItems()[1];'#13#10'  toolbar.items.getAt(10).hide(); '#13#10'  to' +
          'olbar.items.getAt(9).hide(); '#13#10#13#10'  sender.addPlugin('#39'gridexporte' +
          'r'#39');'#13#10'    '#13#10'  var exporterCfg = new Object({'#13#10'            type: ' +
          '"xlsx",'#13#10'            mimeType: "application/vnd.openxmlformats-o' +
          'fficedocument.spreadsheetml.sheet",'#13#10'            title: '#39#1061#1088#1091#1087#1082#1086#1077 +
          #39','#13#10'            fileName: "'#1061#1088#1091#1087#1082#1086#1077'.xlsx"'#13#10'        }); '#13#10#13#10'  // '#1044 +
          #1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1074' '#1087#1072#1085#1077#1083#1100' '#1085#1072#1074#1080#1075#1072#1094#1080#1080#13#10'  if (!toolbar.exportBtn) {'#13 +
          #10'     toolbar.exportBtn = toolbar.insert('#13#10'       0, '#13#10'       //' +
          '{ xtype: '#39'tbseparator'#39' }'#13#10'       {xtype: '#39'button'#39', text: '#39#39', too' +
          'ltip : '#39#1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'#39', handler: function() {'#13#10'          sen' +
          'der.saveDocumentAs(exporterCfg);'#13#10'       }}'#13#10'     );'#13#10'     toolb' +
          'ar.exportBtn.setIconCls('#39'ToExcel'#39');// icon...     '#13#10'  }  '#13#10'}'
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
          'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
          'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
          'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
          't.body.removeChild(el);'#13#10'    };'#13#10'}'
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'  config.displayInfo = true'#13#10'}')
      LayoutConfig.ComponentCls = 'grid-order'
      Columns = <
        item
          FieldName = 'SupplierBrief'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
          Width = 120
        end
        item
          FieldName = 'Manufacturer'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072#1083#1080')'
          Width = 150
          ReadOnly = True
        end
        item
          FieldName = 'DetailNumber'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072#1083#1080')'
          Width = 150
          ReadOnly = True
        end
        item
          FieldName = 'ManufacturerDetailNumber'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072#1083#1080')'
          Width = 200
          ReadOnly = True
        end
        item
          FieldName = 'DetailNumberDetailName'
          Title.Alignment = taCenter
          Title.Caption = 
            #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' + '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1077#1090#1072#1083#1080' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072 +
            #1083#1080')'
          Width = 200
          ReadOnly = True
        end
        item
          FieldName = 'RManufacturerDetailNumber'
          Title.Alignment = taCenter
          Title.Caption = 
            #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' '#1079#1072#1084#1077#1085#1099' + '#1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' '#1079#1072#1084#1077#1085#1099' ('#1087#1077#1088#1074#1080#1095#1085#1086' '#1079#1072#1082#1072#1079#1072#1085#1085#1086#1081' ' +
            #1076#1077#1090#1072#1083#1080')'
          Width = 150
          ReadOnly = True
        end
        item
          FieldName = 'CustomerSubId'
          Title.Alignment = taCenter
          Title.Caption = 'SubID'
          Width = 150
        end
        item
          FieldName = 'Quantity'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Width = 69
        end
        item
          FieldName = 'PricePurchaseF'
          Title.Alignment = taCenter
          Title.Caption = #1062#1077#1085#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1060#1072#1082#1090
          Width = 107
        end
        item
          FieldName = 'AmountPurchaseF'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1060#1072#1082#1090
          Width = 117
        end
        item
          FieldName = 'reference'
          Title.Alignment = taCenter
          Title.Caption = 'Reference'
          Width = 100
        end>
    end
    object gbFilter: TUniGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 1394
      Height = 62
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1060#1080#1083#1100#1090#1088
      Align = alTop
      LayoutConfig.Width = '0'
      TabOrder = 2
      object fCancel: TUniBitBtn
        Left = 343
        Top = 31
        Width = 106
        Height = 24
        Hint = ''
        ShowHint = True
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        TabOrder = 1
        ImageIndex = 3
        OnClick = fCancelClick
      end
      object fOk: TUniBitBtn
        Left = 230
        Top = 31
        Width = 107
        Height = 24
        Hint = ''
        ShowHint = True
        Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
        TabOrder = 2
        IconPosition = ipButtonEdge
        ImageIndex = 2
        OnClick = fOkClick
      end
      object UniLabel3: TUniLabel
        Left = 15
        Top = 14
        Width = 62
        Height = 13
        Hint = ''
        ShowHint = True
        Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
        TabOrder = 3
      end
      object fSupplier: TUniExCheckComboBox
        Left = 15
        Top = 31
        Width = 209
        Hint = ''
        ShowHint = True
        ShowSelectButton = True
        ShowSearch = True
        Text = ''
        TabOrder = 4
        ClientEvents.ExtEvents.Strings = (
          ''
          
            'afterrender=function afterrender(sender, eOpts) {'#13#10'   initComboB' +
            'oxSearch(sender, "id", "val");'#13#10'}')
        EmptyText = #1055#1086#1089#1090#1072#1074#1097#1080#1082#1080
        ClearButton = True
        IconItems = <>
      end
    end
  end
  inherited Query: TFDQuery
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.CheckUpdatable = False
    UpdateObject = nil
    SQL.Strings = (
      'DECLARE @Suppliers as ID'
      ' '
      'if :Suppliers <> '#39#39'    '
      '  INSERT INTO @Suppliers (ID)'
      '  SELECT CAST(value AS NUMERIC(18, 0))'
      '    FROM STRING_SPLIT(:Suppliers, '#39','#39');'
      ''
      'exec OrdersFragile  '
      '       @Suppliers = @Suppliers')
    Left = 678
    Top = 270
    ParamData = <
      item
        Name = 'SUPPLIERS'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object QueryDetailNumber: TWideStringField
      FieldName = 'DetailNumber'
      Origin = 'DetailNumber'
      ReadOnly = True
      Size = 32
    end
    object QueryManufacturerDetailNumber: TWideStringField
      FieldName = 'ManufacturerDetailNumber'
      Origin = 'ManufacturerDetailNumber'
      ReadOnly = True
      Size = 93
    end
    object QueryDetailNumberDetailName: TWideStringField
      FieldName = 'DetailNumberDetailName'
      Origin = 'DetailNumberDetailName'
      ReadOnly = True
      Size = 545
    end
    object QueryRManufacturerDetailNumber: TWideStringField
      FieldName = 'RManufacturerDetailNumber'
      Origin = 'Unnamed6'
      ReadOnly = True
      Size = 161
    end
    object QueryCustomerSubId: TWideStringField
      FieldName = 'CustomerSubId'
      Origin = 'CustomerSubId'
      Size = 32
    end
    object QueryQuantity: TIntegerField
      FieldName = 'Quantity'
      Origin = 'Quantity'
    end
    object QueryPricePurchaseF: TCurrencyField
      FieldName = 'PricePurchaseF'
      Origin = 'PricePurchaseF'
      DisplayFormat = '###,##0.00'
    end
    object QueryAmountPurchaseF: TCurrencyField
      FieldName = 'AmountPurchaseF'
      Origin = 'AmountPurchaseF'
      DisplayFormat = '###,##0.00'
    end
    object QueryManufacturer: TWideStringField
      FieldName = 'Manufacturer'
      Origin = 'Manufacturer'
      ReadOnly = True
      Size = 128
    end
    object Queryreference: TWideStringField
      FieldName = 'reference'
      Size = 64
    end
    object QuerySupplierBrief: TWideStringField
      FieldName = 'SupplierBrief'
      Size = 30
    end
  end
  inherited ActionList: TUniActionList
    Tag = -1
  end
  inherited UpdateSQL: TFDUpdateSQL
    Left = 762
    Top = 269
  end
end
