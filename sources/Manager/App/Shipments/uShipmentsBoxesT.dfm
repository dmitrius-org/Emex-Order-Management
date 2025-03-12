object ShipmentsBoxesT: TShipmentsBoxesT
  Left = 0
  Top = 0
  Width = 1307
  Height = 412
  OnCreate = UniFrameCreate
  Layout = 'fit'
  TabOrder = 0
  object UniPanel3: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1301
    Height = 64
    Hint = ''
    Visible = False
    Align = alTop
    TabOrder = 0
    ShowCaption = False
    Caption = 'UniPanel1'
    LayoutAttribs.Align = 'top'
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'north'
  end
  object Grid: TUniDBGrid
    Left = 0
    Top = 70
    Width = 1307
    Height = 342
    Hint = ''
    ClientEvents.ExtEvents.Strings = (
      
        'columnhide=function columnhide(ct, column, eOpts)'#13#10'{'#13#10'  if (colu' +
        'mn.dataIndex >= 0) { //column.dataIndex >= 0 '#1080#1089#1087#1088#1072#1074#1083#1077#1085#1080#1077' Argumen' +
        't out of range'#13#10'    ajaxRequest(this, '#39'_columnhide'#39', ["column=" ' +
        '+ column.dataIndex, "hidden=" + column.hidden]);'#13#10'  }'#13#10'}'
      
        'columnshow=function columnshow(ct, column, eOpts)'#13#10'{'#13#10'  ajaxRequ' +
        'est(this, '#39'_columnshow'#39', ["column=" + column.dataIndex, "hidden=' +
        '" + column.hidden]);'#13#10'}')
    ClientEvents.UniEvents.Strings = (
      
        'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
        'r.getDockedItems()[1]; '#13#10'  toolbar.items.getAt(10).hide(); '#13#10'  t' +
        'oolbar.items.getAt(9).hide(); '#13#10'  '#13#10'  sender.addPlugin('#39'gridexpo' +
        'rter'#39');'#13#10'    '#13#10'  var exporterCfg = new Object({'#13#10'            typ' +
        'e: "xlsx",'#13#10'            mimeType: "application/vnd.openxmlformat' +
        's-officedocument.spreadsheetml.sheet",'#13#10'            title: '#39#1050#1086#1088#1086 +
        #1073#1082#1080#39','#13#10'            fileName: "'#1050#1086#1088#1086#1073#1082#1080'.xlsx"'#13#10'        }); '#13#10#13#10'  /' +
        '/ '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1074' '#1087#1072#1085#1077#1083#1100' '#1085#1072#1074#1080#1075#1072#1094#1080#1080#13#10'  if (!toolbar.exportBtn)' +
        ' {'#13#10'     toolbar.exportBtn = toolbar.insert('#13#10'       0, '#13#10'      ' +
        ' //{ xtype: '#39'tbseparator'#39' }'#13#10'       {xtype: '#39'button'#39', text: '#39#39', ' +
        'tooltip : '#39#1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'#39', handler: function() {'#13#10'          ' +
        'sender.saveDocumentAs(exporterCfg);'#13#10'       }}'#13#10'     );'#13#10'     to' +
        'olbar.exportBtn.setIconCls('#39'ToExcel'#39');// icon...     '#13#10'  }   '#13#10'}'
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
        'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
        'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
        'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
        'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
        'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
        't.body.removeChild(el);'#13#10'    };     '#13#10'}'#13#10
      
        'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
        'g)'#13#10'{'#13#10'  config.displayInfo=true;'#13#10'}')
    DataSource = Source
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgConfirmDelete, dgAutoRefreshRow]
    WebOptions.PageSize = 10000
    WebOptions.FetchAll = True
    Grouping.FieldName = 'BoxNumber'
    Grouping.FieldCaption = #1050#1086#1088#1086#1073#1082#1072
    Grouping.Enabled = True
    Grouping.Collapsible = True
    LoadMask.Message = 'Loading data...'
    LayoutConfig.Cls = 'grid-box'
    TrackOver = False
    Align = alClient
    TabOrder = 1
    Summary.Align = taTop
    Summary.Enabled = True
    Summary.GrandTotal = True
    Summary.GrandTotalAlign = taTop
    OnKeyDown = GridKeyDown
    OnAjaxEvent = GridAjaxEvent
    OnColumnSort = GridColumnSort
    OnColumnMove = GridColumnMove
    OnDblClick = GridDblClick
    OnCellContextClick = GridCellContextClick
    OnDrawColumnCell = GridDrawColumnCell
    OnColumnResize = GridColumnResize
    OnColumnSummary = GridColumnSummary
    OnColumnSummaryResult = GridColumnSummaryResult
    OnColumnSummaryTotal = GridColumnSummaryTotal
    OnAfterLoad = GridAfterLoad
    Columns = <
      item
        FieldName = 'BoxNumber'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1088#1086#1073#1082#1072
        Width = 95
        Sortable = True
      end
      item
        FieldName = 'ClientName'
        Title.Alignment = taCenter
        Title.Caption = #1050#1083#1080#1077#1085#1090
        Width = 122
      end
      item
        FieldName = 'Manufacturer'
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
        Width = 155
      end
      item
        FieldName = 'DetailNumber'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
        Width = 196
      end
      item
        FieldName = 'DetailName'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1077#1090#1072#1083#1080
        Width = 200
      end
      item
        FieldName = 'ManufacturerReplacement'
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' '#1079#1072#1084#1077#1085#1099
        Width = 200
      end
      item
        FieldName = 'DetailNumberReplacement'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' '#1079#1072#1084#1077#1085#1099
        Width = 196
      end
      item
        FieldName = 'Quantity'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Width = 69
      end
      item
        FieldName = 'PricePurchase'
        Title.Alignment = taCenter
        Title.Caption = #1062#1077#1085#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1088#1091#1073
        Width = 101
      end
      item
        FieldName = 'AmountPurchase'
        Title.Alignment = taCenter
        Title.Caption = #1057#1091#1084#1084#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1088#1091#1073
        Width = 111
      end
      item
        FieldName = 'WeightKG'
        Title.Alignment = taCenter
        Title.Caption = #1042#1077#1089' '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1060#1072#1082#1090
        Width = 122
      end
      item
        FieldName = 'WeightKGS'
        Title.Alignment = taCenter
        Title.Caption = #1042#1077#1089' '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1060#1072#1082#1090' '#1057#1091#1084#1084#1072
        Width = 163
        ShowSummary = True
      end
      item
        FieldName = 'SupplierPhysicalWeight'
        Title.Alignment = taCenter
        Title.Caption = #1042#1077#1089' '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1055#1086#1089#1090#1072#1074#1097#1080#1082' '#1057#1091#1084#1084#1072
        Width = 200
        ShowSummary = True
      end
      item
        FieldName = 'TransporterPhysicalWeight'
        Title.Alignment = taCenter
        Title.Caption = #1042#1077#1089' '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1055#1077#1088#1077#1074#1086#1079#1095#1080#1082' '#1057#1091#1084#1084#1072
        Width = 203
        ShowSummary = True
      end
      item
        FieldName = 'WeightL'
        Title.Alignment = taCenter
        Title.Caption = #1042#1077#1089' '#1060#1080#1079#1080#1095#1077#1089#1082#1080#1081' '#1055#1088#1077#1074#1099#1096#1077#1085#1080#1077
        Width = 170
        ShowSummary = True
      end
      item
        FieldName = 'VolumeKG'
        Title.Alignment = taCenter
        Title.Caption = #1042#1077#1089' '#1054#1073#1098#1077#1084#1085#1099#1081' '#1060#1072#1082#1090
        Width = 116
      end
      item
        FieldName = 'VolumeKGS'
        Title.Alignment = taCenter
        Title.Caption = #1042#1077#1089' '#1054#1073#1098#1077#1084#1085#1099#1081' '#1060#1072#1082#1090' '#1057#1091#1084#1084#1072
        Width = 157
        ShowSummary = True
      end
      item
        FieldName = 'SupplierVolumetricWeight'
        Title.Alignment = taCenter
        Title.Caption = #1042#1077#1089' '#1054#1073#1098#1077#1084#1085#1099#1081' '#1055#1086#1089#1090#1072#1074#1097#1080#1082' '#1057#1091#1084#1084#1072
        Width = 194
        ShowSummary = True
      end
      item
        FieldName = 'TransporterVolumetricWeight'
        Title.Alignment = taCenter
        Title.Caption = #1042#1077#1089' '#1054#1073#1098#1077#1084#1085#1099#1081' '#1055#1077#1088#1077#1074#1086#1079#1095#1080#1082' '#1057#1091#1084#1084#1072
        Width = 197
        ShowSummary = True
      end
      item
        FieldName = 'VolumeL'
        Title.Alignment = taCenter
        Title.Caption = #1042#1077#1089' '#1054#1073#1098#1077#1084#1085#1099#1081' '#1055#1088#1077#1074#1099#1096#1077#1085#1080#1077
        Width = 164
        ShowSummary = True
      end
      item
        FieldName = 'OrderDetailSubId'
        Title.Alignment = taCenter
        Title.Caption = #1064#1090#1088#1080#1093'-'#1082#1086#1076
        Width = 196
      end
      item
        FieldName = 'CustomerSubId'
        Title.Alignment = taCenter
        Title.Caption = 'SubID'
        Width = 196
      end
      item
        FieldName = 'Reference'
        Title.Alignment = taCenter
        Title.Caption = 'Reference'
        Width = 196
      end>
  end
  object Source: TDataSource
    DataSet = Query
    Left = 668
    Top = 272
  end
  object Query: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    FormatOptions.AssignedValues = [fvDefaultParamDataType]
    FormatOptions.DefaultParamDataType = ftInteger
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
      'exec ShipmentsTransporterSelect'
      '       @TransporterNumber = :TransporterNumber     '
      '      ,@Invoice           = :Invoice  '
      ''
      ' '
      ''
      ''
      ''
      '')
    Left = 580
    Top = 273
    ParamData = <
      item
        Name = 'TRANSPORTERNUMBER'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'INVOICE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object QueryShipmentsBoxesID: TFMTBCDField
      FieldName = 'ShipmentsBoxesID'
      Origin = 'ShipmentsBoxesID'
      Precision = 18
      Size = 0
    end
    object QueryBoxNumber: TFMTBCDField
      FieldName = 'BoxNumber'
      Origin = 'BoxNumber'
      Precision = 18
      Size = 0
    end
    object QueryClientName: TStringField
      FieldName = 'ClientName'
      Origin = 'ClientName'
      Size = 256
    end
    object QueryManufacturer: TStringField
      FieldName = 'Manufacturer'
      Origin = 'Manufacturer'
      Size = 64
    end
    object QueryDetailNumber: TStringField
      FieldName = 'DetailNumber'
      Origin = 'DetailNumber'
      Size = 32
    end
    object QueryDetailName: TStringField
      FieldName = 'DetailName'
      Origin = 'DetailName'
      Size = 256
    end
    object QueryManufacturerReplacement: TStringField
      FieldName = 'ManufacturerReplacement'
      Origin = 'ManufacturerReplacement'
      Size = 64
    end
    object QueryDetailNumberReplacement: TStringField
      FieldName = 'DetailNumberReplacement'
      Origin = 'DetailNumberReplacement'
      Size = 32
    end
    object QueryQuantity: TIntegerField
      FieldName = 'Quantity'
      Origin = 'Quantity'
    end
    object QueryPricePurchase: TCurrencyField
      FieldName = 'PricePurchase'
      Origin = 'PricePurchase'
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryAmountPurchase: TCurrencyField
      FieldName = 'AmountPurchase'
      Origin = 'AmountPurchase'
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryWeightKG: TCurrencyField
      FieldName = 'WeightKG'
      Origin = 'WeightKG'
      DisplayFormat = '###,##0.000 '#1082#1075
    end
    object QueryWeightKGS: TCurrencyField
      FieldName = 'WeightKGS'
      Origin = 'WeightKGS'
      DisplayFormat = '###,##0.000 '#1082#1075
    end
    object QuerySupplierPhysicalWeight: TFloatField
      FieldName = 'SupplierPhysicalWeight'
      Origin = 'SupplierPhysicalWeight'
      OnGetText = QueryTransporterPhysicalWeightGetText
      DisplayFormat = '###,##0.000'
    end
    object QueryTransporterPhysicalWeight: TFloatField
      FieldName = 'TransporterPhysicalWeight'
      Origin = 'TransporterPhysicalWeight'
      OnGetText = QueryTransporterPhysicalWeightGetText
      DisplayFormat = '###,##0.000'
    end
    object QueryVolumeKG: TCurrencyField
      FieldName = 'VolumeKG'
      Origin = 'VolumeKG'
      DisplayFormat = '###,##0.000 '#1082#1075
    end
    object QueryVolumeKGS: TCurrencyField
      FieldName = 'VolumeKGS'
      Origin = 'VolumeKGS'
      DisplayFormat = '###,##0.000 '#1082#1075
    end
    object QuerySupplierVolumetricWeight: TFloatField
      FieldName = 'SupplierVolumetricWeight'
      Origin = 'SupplierVolumetricWeight'
      OnGetText = QueryTransporterPhysicalWeightGetText
      DisplayFormat = '###,##0.000'
    end
    object QueryTransporterVolumetricWeight: TFloatField
      FieldName = 'TransporterVolumetricWeight'
      Origin = 'TransporterVolumetricWeight'
      OnGetText = QueryTransporterPhysicalWeightGetText
      DisplayFormat = '###,##0.000'
    end
    object QueryOrderDetailSubId: TStringField
      FieldName = 'OrderDetailSubId'
      Origin = 'OrderDetailSubId'
      Size = 32
    end
    object QueryCustomerSubId: TStringField
      FieldName = 'CustomerSubId'
      Origin = 'CustomerSubId'
      Size = 32
    end
    object QueryReference: TStringField
      FieldName = 'Reference'
      Origin = 'Reference'
      Size = 32
    end
    object QueryWeightL: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'WeightL'
      Calculated = True
    end
    object QueryVolumeL: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'VolumeL'
      Calculated = True
    end
    object QueryOrderID: TFMTBCDField
      FieldName = 'OrderID'
    end
  end
  object actMain: TUniActionList
    Left = 102
    Top = 281
    object actOrderEdit: TAction
      Category = 'Action'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1082#1072#1079
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1079#1072#1082#1072#1079
      ImageIndex = 6
      OnExecute = actOrderEditExecute
    end
  end
  object ppMain: TUniPopupMenu
    Left = 101
    Top = 218
    object N12: TUniMenuItem
      Action = actOrderEdit
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
