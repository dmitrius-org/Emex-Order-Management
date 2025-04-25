object PartProtocol_T: TPartProtocol_T
  Left = 0
  Top = 0
  ClientHeight = 646
  ClientWidth = 1324
  Caption = #1048#1089#1090#1086#1088#1080#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1076#1077#1090#1072#1083#1080
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  OnCreate = UniFormCreate
  TextHeight = 15
  object Grid: TUniDBGrid
    Left = 0
    Top = 0
    Width = 1324
    Height = 646
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    BodyRTL = False
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
        'r.getDockedItems()[1]; //Remove the ToolBar fixed in the bottom'#13 +
        #10'  toolbar.items.getAt(10).hide(); //Remove the Refresh button i' +
        'n the ToolBar, number 10, hide him'#13#10'  toolbar.items.getAt(9).hid' +
        'e(); //Remove the Refresh button in the ToolBar, number 10, hide' +
        ' him'#13#10#13#10'  sender.addPlugin('#39'gridexporter'#39');'#13#10'    '#13#10'  var exporte' +
        'rCfg = new Object({'#13#10'            type: "xlsx",'#13#10'            mime' +
        'Type: "application/vnd.openxmlformats-officedocument.spreadsheet' +
        'ml.sheet",'#13#10'            title: '#39#1048#1089#1090#1086#1088#1080#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1076#1077#1090#1072#1083#1080#39','#13#10'    ' +
        '        fileName: "'#1048#1089#1090#1086#1088#1080#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1076#1077#1090#1072#1083#1080'.xlsx"'#13#10'        }); '#13 +
        #10#13#10'  // '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1074' '#1087#1072#1085#1077#1083#1100' '#1085#1072#1074#1080#1075#1072#1094#1080#1080#13#10'  if (!toolbar.expo' +
        'rtBtn) {'#13#10'     toolbar.exportBtn = toolbar.insert('#13#10'       0, '#13#10 +
        '       //{ xtype: '#39'tbseparator'#39' }'#13#10'       {xtype: '#39'button'#39', text' +
        ': '#39#39', tooltip : '#39#1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'#39', handler: function() {'#13#10'    ' +
        '      sender.saveDocumentAs(exporterCfg);'#13#10'       }}'#13#10'     );'#13#10' ' +
        '    toolbar.exportBtn.setIconCls('#39'ToExcel'#39');// icon...     '#13#10'  }' +
        '  '#13#10'}'
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
        'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
        'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
        'data[sender.uniCol+1];'#13#10'        el.value = document.activeElemen' +
        't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
        '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
        'ent.body.removeChild(el);'#13#10'    };'#13#10'}'
      
        'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
        'g)'#13#10'{'#13#10'  config.displayInfo = true'#13#10' // config.displayMsg  = '#39'Vi' +
        'sualizando {0} - {1} de <b>{2}</b>'#39','#13#10' // config.emptyMsg    = "' +
        'N'#227'o h'#225' registros",'#13#10'}')
    RowEditor = True
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgAutoRefreshRow, dgRowNumbers]
    ReadOnly = True
    WebOptions.PageSize = 500
    WebOptions.CustomizableCells = False
    WebOptions.AppendPosition = tpCurrentRow
    WebOptions.FetchAll = True
    WebOptions.RetainCursorOnSort = True
    LoadMask.WaitData = True
    LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
    LoadMask.Color = clActiveCaption
    EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
    LayoutConfig.Cls = 'grid-part-protocol'
    LayoutConfig.Height = '100'
    LayoutConfig.Width = '100'
    BorderStyle = ubsNone
    Align = alClient
    Anchors = []
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    PreventWrap = True
    OnKeyDown = GridKeyDown
    OnAjaxEvent = GridAjaxEvent
    OnColumnSort = GridColumnSort
    OnColumnMove = GridColumnMove
    OnCellContextClick = GridCellContextClick
    OnColumnResize = GridColumnResize
    Columns = <
      item
        FieldName = 'MakeLogo'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1076' '#1073#1088#1077#1085#1076#1072
        Width = 99
        Visible = False
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'Brand'
        Title.Alignment = taCenter
        Title.Caption = #1041#1088#1077#1085#1076
        Width = 235
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'DetailNum'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
        Width = 244
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'DetailName'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 300
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'WeightKG'
        Title.Alignment = taCenter
        Title.Caption = #1042#1077#1089
        Width = 142
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'VolumeKG'
        Title.Alignment = taCenter
        Title.Caption = #1054#1073#1098#1077#1084
        Width = 142
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'Restrictions'
        Title.Alignment = taCenter
        Title.Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103
        Width = 184
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'Fragile'
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1080#1079#1085#1072#1082': '#1061#1088#1091#1087#1082#1080#1081
        Width = 98
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'NLA'
        Title.Caption = 'NLA'
        Width = 34
        Hint = 'No longer available '#1080#1083#1080' '#1041#1086#1083#1077#1077' '#1085#1077#1076#1086#1089#1090#1091#1087#1085#1086
      end
      item
        FieldName = 'UserName'
        Title.Alignment = taCenter
        Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        Width = 200
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'updDateTime'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
        Width = 159
        ReadOnly = True
        Sortable = True
      end>
  end
  object DataSource: TDataSource
    DataSet = ProtocolQuery
    Left = 541
    Top = 178
  end
  object ProtocolQuery: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evAutoClose, evAutoFetchAll]
    FormatOptions.AssignedValues = [fvDefaultParamDataType]
    FormatOptions.DefaultParamDataType = ftString
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
      'exec PartProtocolSelect'
      '       @OrderID = :OrderID')
    Left = 540
    Top = 114
    ParamData = <
      item
        Name = 'ORDERID'
        ParamType = ptInput
      end>
    object ProtocolQueryMakeLogo: TStringField
      FieldName = 'MakeLogo'
      Size = 30
    end
    object ProtocolQueryBrand: TStringField
      FieldName = 'Brand'
      Size = 60
    end
    object ProtocolQueryDetailNum: TStringField
      FieldName = 'DetailNum'
      Size = 40
    end
    object ProtocolQueryDetailName: TStringField
      FieldName = 'DetailName'
      Size = 256
    end
    object ProtocolQueryWeightKG: TFloatField
      FieldName = 'WeightKG'
      DisplayFormat = '###,##0.000 '#1082#1075
    end
    object ProtocolQueryVolumeKG: TFloatField
      FieldName = 'VolumeKG'
      DisplayFormat = '###,##0.000 '#1082#1075
    end
    object ProtocolQueryRestrictions: TStringField
      FieldName = 'Restrictions'
      Size = 30
    end
    object ProtocolQueryFragile: TBooleanField
      FieldName = 'Fragile'
    end
    object ProtocolQueryUserName: TStringField
      FieldName = 'UserName'
      Size = 256
    end
    object ProtocolQueryupdDateTime: TSQLTimeStampField
      FieldName = 'updDateTime'
    end
    object ProtocolQueryNLA: TBooleanField
      FieldName = 'NLA'
    end
  end
  object actMain: TUniActionList
    Left = 98
    Top = 274
    object actRefreshAll: TAction
      Category = 'Order'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 0
      OnExecute = actRefreshAllExecute
    end
  end
  object ppMain: TUniPopupMenu
    Left = 101
    Top = 218
    object N6: TUniMenuItem
      Action = actRefreshAll
    end
  end
end
