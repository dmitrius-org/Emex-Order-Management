object OrdersProtocol_T: TOrdersProtocol_T
  Left = 0
  Top = 0
  ClientHeight = 580
  ClientWidth = 1381
  Caption = #1055#1088#1086#1090#1086#1082#1086#1083
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  TextHeight = 15
  object Grid: TUniDBGrid
    Left = 0
    Top = 69
    Width = 1381
    Height = 511
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    BodyRTL = False
    ClientEvents.ExtEvents.Strings = (
      
        'store.load=function store.load(sender, records, successful, oper' +
        'ation, eOpts)'#13#10'{'#13#10'    sender.grid.columnManager.columns.forEach(' +
        'function(col){'#13#10'      if (col.text == '#39#1057#1090#1072#1090#1091#1089#1099#39') {'#13#10'        col.' +
        'innerCls = '#39'statusFlag'#39';'#13#10'      }'#13#10'    });'#13#10'    '#13#10'$('#39'.statusFlag' +
        #39').children().andSelf().contents().each('#13#10#9'function () {'#13#10'//'#9'con' +
        'sole.log('#39'records'#39');'#13#10#9'if (this.nodeType == 3) {'#13#10'//   console.l' +
        'og('#39'records2'#39');'#13#10#9#9'$(this).replaceWith(function () {'#13#10'      cons' +
        'ole.log('#39'records3'#39');'#13#10#9#9#9#9'var t='#39#39';'#13#10#9#9#9#9'var flags=parseInt($(th' +
        'is).text());'#9#13#10#9#9#9#9'if ((flags&1)==1)'#9'{'#13#10#9#9#9#9#9#9't = t + '#39'<span cla' +
        'ss="flagSystem">u</span>'#39';'#13#10#9#9#9#9'};'#9#9#13#10#9#9#9#9'if ((flags&2)==2)'#9'{'#13#10#9 +
        #9#9#9#9#9't = t + '#39'<span class="flagBegin">u</span>'#39';'#13#10#9#9#9#9'};'#9#13#10#9#9#9#9'i' +
        'f ((flags&4)==4)'#9'{'#13#10#9#9#9#9#9#9't = t + '#39'<span class="flagDefault">u</' +
        'span>'#39';'#13#10#9#9#9#9'};'#9#13#10'            console.log(t);'#13#10#9#9#9#9'return t;'#9#13#10#9 +
        #9#9'}'#13#10#9#9')'#13#10#9'};'#13#10'}'#13#10');'#13#10'   '#13#10'}'
      'added=function added(sender, container, pos, eOpts)'#13#10'{'#13#10#13#10'}')
    ClientEvents.UniEvents.Strings = (
      
        'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
        'g)'#13#10'{'#13#10'  config.displayInfo = true'#13#10' // config.displayMsg  = '#39'Vi' +
        'sualizando {0} - {1} de <b>{2}</b>'#39','#13#10' // config.emptyMsg    = "' +
        'N'#227'o h'#225' registros",'#13#10'}'
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
        'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
        'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
        'data[sender.uniCol+1];'#13#10'        el.value = document.activeElemen' +
        't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
        '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
        'ent.body.removeChild(el);'#13#10'    };'#13#10'}'
      
        'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
        'r.getDockedItems()[1]; //Remove the ToolBar fixed in the bottom'#13 +
        #10'  toolbar.items.getAt(10).hide(); //Remove the Refresh button i' +
        'n the ToolBar, number 10, hide him'#13#10#13#10'}')
    RowEditor = True
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgRowNumbers]
    ReadOnly = True
    WebOptions.PageSize = 500
    WebOptions.CustomizableCells = False
    WebOptions.AppendPosition = tpCurrentRow
    WebOptions.FetchAll = True
    LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
    LoadMask.Color = clActiveCaption
    EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
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
    OnCellContextClick = GridCellContextClick
    OnDrawColumnCell = GridDrawColumnCell
    Columns = <
      item
        FieldName = 'ProtocolID'
        Title.Alignment = taCenter
        Title.Caption = #1048#1044' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
        Width = 113
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
        Width = 189
      end
      item
        FieldName = 'CurState'
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1082#1091#1097#1077#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
        Width = 186
      end
      item
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
        FieldName = 'Comment'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
        Width = 372
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
    Width = 1375
    Height = 63
    Hint = ''
    Align = alTop
    TabOrder = 1
    ShowCaption = False
    Caption = 'UniPanel1'
    LayoutAttribs.Align = 'top'
    LayoutConfig.Width = '0'
    object UniButton1: TUniButton
      Left = 211
      Top = 25
      Width = 75
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      TabOrder = 1
      OnClick = UniButton1Click
    end
    object fProtocol: TUniCheckComboBox
      Left = 9
      Top = 25
      Width = 196
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Text = ''
      Items.Strings = (
        #1057#1086#1089#1090#1086#1103#1085#1080#1077
        #1054#1090#1082#1072#1079#1099)
      ItemIndex = 0
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
      Top = 3
      Width = 84
      Height = 13
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1058#1080#1087' '#1087#1088#1086#1090#1086#1082#1086#1083#1072':'
      TabOrder = 3
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 541
    Top = 178
  end
  object Query: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evAutoFetchAll]
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
    UpdateOptions.UpdateTableName = 'tNodes'
    SQL.Strings = (
      'select * '
      '  from vProtocolSelect'
      ' where ObjectID = :ID'
      '   !ProtocolType    '
      ' order by InDateTime desc')
    Left = 540
    Top = 114
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end>
    MacroData = <
      item
        Value = Null
        Name = 'PROTOCOLTYPE'
      end>
    object QueryProtocolID: TFMTBCDField
      FieldName = 'ProtocolID'
      Required = True
      Precision = 18
      Size = 0
    end
    object QueryObjectID: TFMTBCDField
      FieldName = 'ObjectID'
      Precision = 18
      Size = 0
    end
    object QueryCurState: TWideStringField
      FieldName = 'CurState'
      Required = True
      Size = 256
    end
    object QueryActionName: TWideStringField
      FieldName = 'ActionName'
      Required = True
      Size = 256
    end
    object QueryProtocDate: TSQLTimeStampField
      FieldName = 'OperDate'
    end
    object QueryComment: TWideStringField
      FieldName = 'Comment'
      Size = 1024
    end
    object QueryName: TWideStringField
      FieldName = 'UserName'
      Size = 512
    end
    object QueryInDateTime: TSQLTimeStampField
      FieldName = 'InDateTime'
    end
    object QueryProtocolType: TIntegerField
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
