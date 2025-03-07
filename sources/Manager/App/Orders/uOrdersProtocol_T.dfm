object OrdersProtocol_T: TOrdersProtocol_T
  Left = 0
  Top = 0
  ClientHeight = 491
  ClientWidth = 1324
  Caption = #1055#1088#1086#1090#1086#1082#1086#1083
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  TextHeight = 15
  object Grid: TUniDBGrid
    Left = 0
    Top = 69
    Width = 1324
    Height = 422
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    BodyRTL = False
    ClientEvents.ExtEvents.Strings = (
      'added=function added(sender, container, pos, eOpts)'#13#10'{'#13#10#13#10'}'
      
        'store.load=function store.load(sender, records, successful, oper' +
        'ation, eOpts)'#13#10'{'#13#10#13#10'    '#13#10#13#10'   '#13#10'}')
    ClientEvents.UniEvents.Strings = (
      
        'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
        'r.getDockedItems()[1]; //Remove the ToolBar fixed in the bottom'#13 +
        #10'  toolbar.items.getAt(10).hide(); //Remove the Refresh button i' +
        'n the ToolBar, number 10, hide him'#13#10'  toolbar.items.getAt(9).hid' +
        'e(); //Remove the Refresh button in the ToolBar, number 10, hide' +
        ' him'#13#10#13#10'  sender.addPlugin('#39'gridexporter'#39');'#13#10'    '#13#10'  var exporte' +
        'rCfg = new Object({'#13#10'            type: "xlsx",'#13#10'            mime' +
        'Type: "application/vnd.openxmlformats-officedocument.spreadsheet' +
        'ml.sheet",'#13#10'            title: '#39#1055#1088#1086#1090#1086#1082#1086#1083#39','#13#10'            fileName' +
        ': "'#1055#1088#1086#1090#1086#1082#1086#1083'.xlsx"'#13#10'        }); '#13#10#13#10'  // '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1074' '#1087#1072#1085#1077#1083 +
        #1100' '#1085#1072#1074#1080#1075#1072#1094#1080#1080#13#10'  if (!toolbar.exportBtn) {'#13#10'     toolbar.exportBtn' +
        ' = toolbar.insert('#13#10'       0, '#13#10'       //{ xtype: '#39'tbseparator'#39' ' +
        '}'#13#10'       {xtype: '#39'button'#39', text: '#39#39', tooltip : '#39#1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Exc' +
        'el'#39', handler: function() {'#13#10'          sender.saveDocumentAs(expo' +
        'rterCfg);'#13#10'       }}'#13#10'     );'#13#10'     toolbar.exportBtn.setIconCls' +
        '('#39'ToExcel'#39');// icon...     '#13#10'  }  '#13#10'}'
      
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
    LayoutConfig.Height = '100'
    LayoutConfig.Width = '100'
    BorderStyle = ubsNone
    Align = alClient
    Anchors = []
    TabOrder = 1
    ParentColor = False
    Color = clBtnFace
    PreventWrap = True
    OnKeyDown = GridKeyDown
    OnCellContextClick = GridCellContextClick
    OnDrawColumnCell = GridDrawColumnCell
    Columns = <
      item
        FieldName = 'ProtocolID'
        Title.Alignment = taCenter
        Title.Caption = #1048#1044' '#1086#1073#1098#1077#1082#1090#1072
        Width = 96
      end
      item
        FieldName = 'ObjectID'
        Title.Alignment = taCenter
        Title.Caption = #1048#1044' '#1047#1072#1082#1072#1079#1072
        Width = 113
        Visible = False
      end
      item
        FieldName = 'ActionName'
        Title.Alignment = taCenter
        Title.Caption = #1044#1077#1081#1089#1090#1074#1080#1077
        Width = 237
      end
      item
        FieldName = 'CurState'
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1082#1091#1097#1077#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
        Width = 186
      end
      item
        ShowToolTip = True
        FieldName = 'UserName'
        Title.Alignment = taCenter
        Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        Width = 182
      end
      item
        FieldName = 'OperDate'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
        Width = 143
      end
      item
        ShowToolTip = True
        FieldName = 'Comment'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
        Width = 276
      end
      item
        FieldName = 'InDateTime'
        Title.Caption = #1060#1080#1079#1080#1095#1077#1089#1082#1072#1103' '#1076#1072#1090#1072
        Width = 143
      end>
  end
  object UniPanel1: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1318
    Height = 63
    Hint = ''
    Align = alTop
    TabOrder = 0
    ShowCaption = False
    Caption = 'UniPanel1'
    LayoutAttribs.Align = 'top'
    LayoutConfig.Width = '0'
    object btnFilter: TUniButton
      Left = 347
      Top = 25
      Width = 75
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      TabOrder = 3
      OnClick = btnFilterClick
    end
    object fProtocol: TUniCheckComboBox
      Left = 9
      Top = 25
      Width = 332
      Height = 23
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Text = ''
      Items.Strings = (
        #1057#1086#1089#1090#1086#1103#1085#1080#1077
        #1054#1090#1082#1072#1079#1099
        #1048#1079#1084#1077#1085#1077#1085#1080#1077
        #1054#1090#1084#1077#1085#1072)
      TabOrder = 2
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
      EmptyText = #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1080#1087' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
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
      OnSelect = fProtocolSelect
    end
    object UniLabel3: TUniLabel
      Left = 9
      Top = 6
      Width = 83
      Height = 13
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1058#1080#1087' '#1087#1088#1086#1090#1086#1082#1086#1083#1072':'
      TabOrder = 1
    end
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
    UpdateOptions.KeyFields = 'ProtocolID'
    UpdateOptions.AutoIncFields = 'ProtocolID'
    SQL.Strings = (
      'select * '
      '  from vProtocolSelect'
      ' where ObjectID = :ID'
      ' '
      '       !ProtocolType '
      '      '
      ' order by InDateTime desc')
    Left = 540
    Top = 114
    ParamData = <
      item
        Name = 'ID'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
    MacroData = <
      item
        Value = Null
        Name = 'PROTOCOLTYPE'
      end>
    object ProtocolQueryProtocolID: TFMTBCDField
      FieldName = 'ProtocolID'
      KeyFields = 'ProtocolID'
      Required = True
      Precision = 18
      Size = 0
    end
    object ProtocolQueryObjectID: TFMTBCDField
      FieldName = 'ObjectID'
      Precision = 18
      Size = 0
    end
    object ProtocolQueryCurState: TWideStringField
      FieldName = 'CurState'
      Required = True
      Size = 256
    end
    object ProtocolQueryActionName: TWideStringField
      FieldName = 'ActionName'
      Required = True
      Size = 256
    end
    object ProtocolQueryProtocDate: TSQLTimeStampField
      FieldName = 'OperDate'
    end
    object ProtocolQueryComment: TWideStringField
      FieldName = 'Comment'
      Size = 1024
    end
    object ProtocolQueryName: TWideStringField
      FieldName = 'UserName'
      Size = 512
    end
    object ProtocolQueryInDateTime: TSQLTimeStampField
      FieldName = 'InDateTime'
    end
    object ProtocolQueryProtocolType: TIntegerField
      FieldName = 'ProtocolType'
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
