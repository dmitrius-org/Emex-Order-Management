object BalanceT: TBalanceT
  Left = 0
  Top = 0
  ClientHeight = 527
  ClientWidth = 1098
  Caption = #1041#1072#1083#1072#1085#1089
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  TextHeight = 15
  object Grid: TUniDBGrid
    Left = 0
    Top = 128
    Width = 1098
    Height = 399
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
      
        'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  //'#1055#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077 +
        #1085#1090#1086#1074', '#1079#1072#1082#1088#1077#1087#1083#1077#1085#1085#1072#1103' '#1074#1085#1080#1079#1091'.'#13#10'  var toolbar=sender.getDockedItems()' +
        '[1]; '#13#10'  toolbar.items.getAt(10).hide(); //'#1059#1073#1080#1088#1072#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1054#1073#1085#1086#1074#1080 +
        #1090#1100' '#1074' '#1055#1072#1085#1077#1083#1080' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074', '#1085#1086#1084#1077#1088' 10, '#1089#1082#1088#1099#1074#1072#1077#1084' '#1077#1075#1086#13#10'  '#13#10'  '#13#10#13#10'}')
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
    Exporter.Enabled = True
    OnKeyDown = GridKeyDown
    OnCellContextClick = GridCellContextClick
    Columns = <
      item
        FieldName = 'DocumentID'
        Title.Alignment = taCenter
        Title.Caption = #1048#1044' '#1044#1086#1082#1091#1084#1077#1085#1090#1072
        Width = 144
        Visible = False
      end
      item
        FieldName = 'Document'
        Title.Alignment = taCenter
        Title.Caption = #1044#1086#1082#1091#1084#1077#1085#1090
        Width = 308
        ReadOnly = True
      end
      item
        FieldName = 'Number'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088
        Width = 157
      end
      item
        FieldName = 'Date'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072
        Width = 116
      end
      item
        FieldName = 'Amount'
        Title.Alignment = taCenter
        Title.Caption = #1057#1091#1084#1084#1072
        Width = 110
      end
      item
        FieldName = 'Balance'
        Title.Alignment = taCenter
        Title.Caption = #1057#1072#1083#1100#1076#1086
        Width = 106
      end
      item
        FieldName = 'Comment'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
        Width = 259
      end>
  end
  object UniPanel1: TUniPanel
    Left = 0
    Top = 0
    Width = 1098
    Height = 128
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    Align = alTop
    TabOrder = 1
    ShowCaption = False
    Caption = 'UniPanel1'
    ExplicitWidth = 1094
    object UniButton1: TUniButton
      Left = 265
      Top = 89
      Width = 75
      Height = 25
      Hint = ''
      ShowHint = True
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      TabOrder = 1
      OnClick = UniButton1Click
    end
    object edtDateEnd: TUniDateTimePicker
      Left = 139
      Top = 90
      Width = 120
      Hint = ''
      ShowHint = True
      DateTime = 45253.000000000000000000
      DateFormat = 'dd/MM/yyyy'
      TimeFormat = 'HH:mm:ss'
      TabOrder = 2
    end
    object edtDateBegin: TUniDateTimePicker
      Left = 13
      Top = 90
      Width = 120
      Hint = ''
      ShowHint = True
      DateTime = 45253.000000000000000000
      DateFormat = 'dd/MM/yyyy'
      TimeFormat = 'HH:mm:ss'
      TabOrder = 3
    end
    object UniPanel2: TUniPanel
      Left = 822
      Top = 1
      Width = 275
      Height = 126
      Hint = ''
      ShowHint = True
      Align = alRight
      TabOrder = 4
      BorderStyle = ubsNone
      ShowCaption = False
      Caption = 'UniPanel2'
      ExplicitLeft = 818
      DesignSize = (
        275
        126)
      object edtBalance: TUniFormattedNumberEdit
        Left = 135
        Top = 19
        Width = 129
        Hint = ''
        ShowHint = True
        BorderStyle = ubsNone
        Alignment = taCenter
        ParentFont = False
        Font.Height = -12
        Anchors = [akTop, akRight]
        TabOrder = 1
        Color = clBtnFace
        DecimalSeparator = ','
        ThousandSeparator = #160
      end
      object UniLabel1: TUniLabel
        Left = 51
        Top = 19
        Width = 48
        Height = 17
        Hint = #1057#1088#1077#1076#1089#1090#1074#1072' '#1080#1084#1077#1102#1097#1080#1077#1089#1103' '#1085#1072' '#1073#1072#1083#1072#1085#1089#1077
        ShowHint = True
        Caption = #1041#1072#1083#1072#1085#1089':'
        Anchors = [akTop, akRight]
        ParentFont = False
        Font.Height = -13
        Font.Style = [fsBold]
        TabOrder = 2
      end
      object btnBalanceAdd: TUniButton
        Left = 135
        Top = 88
        Width = 129
        Height = 25
        Hint = ''
        ShowHint = True
        Caption = #1055#1086#1087#1086#1083#1085#1080#1090#1100' '#1073#1072#1083#1072#1085#1089
        Anchors = [akTop, akRight]
        TabOrder = 3
        OnClick = btnBalanceAddClick
      end
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
      ' declare @Rest money'
      ' '
      ' exec BalanceSelect'
      '        @ClientID = :ClientID'
      '       ,@BDate    = :BDate '
      '       ,@EDate    = :EDate '
      '   ')
    Left = 796
    Top = 242
    ParamData = <
      item
        Name = 'CLIENTID'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'BDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object QueryDocumentID: TFMTBCDField
      FieldName = 'DocumentID'
      Origin = 'DocumentID'
      Precision = 18
      Size = 0
    end
    object QueryDocument: TStringField
      FieldName = 'Document'
      Origin = 'Document'
      ReadOnly = True
      Required = True
      Size = 18
    end
    object QueryNumber: TWideStringField
      FieldName = 'Number'
      Origin = 'Number'
      Size = 255
    end
    object QueryDate: TSQLTimeStampField
      FieldName = 'Date'
      Origin = 'Date'
    end
    object QueryAmount: TCurrencyField
      FieldName = 'Amount'
      Origin = 'Amount'
      DisplayFormat = '###,##0.00'
    end
    object QueryBalance: TCurrencyField
      FieldName = 'Balance'
      Origin = 'Balance'
      DisplayFormat = '###,##0.00'
    end
    object QueryComment: TWideStringField
      FieldName = 'Comment'
      Origin = 'Comment'
      Size = 512
    end
    object QueryRest: TCurrencyField
      FieldName = 'Rest'
      Origin = 'Rest'
      ReadOnly = True
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
