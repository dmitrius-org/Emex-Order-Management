object BalanceT: TBalanceT
  Left = 0
  Top = 0
  ClientHeight = 527
  ClientWidth = 1125
  Caption = #1041#1072#1083#1072#1085#1089
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  TextHeight = 15
  object Grid: TUniDBGrid
    Left = 0
    Top = 99
    Width = 1125
    Height = 428
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    BodyRTL = False
    ClientEvents.ExtEvents.Strings = (
      
        'store.load=function store.load(sender, records, successful, oper' +
        'ation, eOpts)'#13#10'{'#13#10#13#10'  '#13#10'}')
    ClientEvents.UniEvents.Strings = (
      
        'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  //'#1059#1073#1080#1088#1072#1077#1084' '#1082#1085#1086#1087#1082#1091' ' +
        #1054#1073#1085#1086#1074#1080#1090#1100' '#1074' '#1055#1072#1085#1077#1083#1080' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074', '#1085#1086#1084#1077#1088' 9-10, '#1089#1082#1088#1099#1074#1072#1077#1084' '#1077#1075#1086#13#10'  var ' +
        'toolbar=sender.getDockedItems()[1];'#13#10'  toolbar.items.getAt(9).hi' +
        'de();'#13#10'  toolbar.items.getAt(10).hide();'#13#10'  '#13#10'  sender.addPlugin' +
        '('#39'gridexporter'#39');'#13#10'    '#13#10'  var exporterCfg = new Object({'#13#10'     ' +
        '       type: "xlsx",'#13#10'            mimeType: "application/vnd.ope' +
        'nxmlformats-officedocument.spreadsheetml.sheet",'#13#10'            ti' +
        'tle: '#39#1054#1073#1086#1088#1086#1090#1099' '#1087#1086' '#1089#1095#1077#1090#1091#39','#13#10'            fileName: "'#1054#1073#1086#1088#1086#1090#1099' '#1087#1086' '#1089#1095#1077#1090 +
        #1091'.xlsx"'#13#10'        }); '#13#10#13#10'  // '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1074' '#1087#1072#1085#1077#1083#1100' '#1085#1072#1074#1080#1075#1072#1094#1080 +
        #1080#13#10'  if (!toolbar.exportBtn) {'#13#10'     toolbar.exportBtn = toolbar' +
        '.insert('#13#10'       0, '#13#10'       //{ xtype: '#39'tbseparator'#39' }'#13#10'       ' +
        '{xtype: '#39'button'#39', text: '#39#39', tooltip : '#39#1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'#39', handl' +
        'er: function() {'#13#10'          sender.saveDocumentAs(exporterCfg);'#13 +
        #10'       }}'#13#10'     );'#13#10'     toolbar.exportBtn.setIconCls('#39'ToExcel'#39 +
        ');// icon...     '#13#10'  }  '#13#10'}'
      
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
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgRowNumbers]
    ReadOnly = True
    WebOptions.PageSize = 500
    WebOptions.CustomizableCells = False
    WebOptions.AppendPosition = tpCurrentRow
    WebOptions.FetchAll = True
    LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
    LoadMask.Color = clActiveCaption
    EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
    LayoutConfig.ComponentCls = 'grid-balance'
    LayoutConfig.Height = '100'
    LayoutConfig.Width = '100'
    BorderStyle = ubsNone
    Align = alClient
    Anchors = []
    TabOrder = 1
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
    Width = 1125
    Height = 99
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    Align = alTop
    ParentFont = False
    Font.Height = -13
    TabOrder = 0
    ShowCaption = False
    Caption = 'UniPanel1'
    DesignSize = (
      1125
      99)
    object UniButton1: TUniButton
      Left = 280
      Top = 63
      Width = 127
      Height = 28
      Hint = ''
      ShowHint = True
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 2
      OnClick = UniButton1Click
    end
    object UniPanel2: TUniPanel
      Left = 849
      Top = 1
      Width = 275
      Height = 97
      Hint = ''
      ShowHint = True
      Align = alRight
      TabOrder = 1
      BorderStyle = ubsNone
      ShowCaption = False
      Caption = 'UniPanel2'
      DesignSize = (
        275
        97)
      object edtBalance: TUniFormattedNumberEdit
        Left = 135
        Top = 7
        Width = 129
        Hint = ''
        ShowHint = True
        BorderStyle = ubsNone
        Alignment = taCenter
        ParentFont = False
        Font.Height = -13
        Anchors = [akTop, akRight]
        TabOrder = 2
        Color = clBtnFace
        DecimalSeparator = ','
        ThousandSeparator = #160
      end
      object UniLabel1: TUniLabel
        Left = 51
        Top = 10
        Width = 48
        Height = 17
        Hint = #1057#1088#1077#1076#1089#1090#1074#1072' '#1080#1084#1077#1102#1097#1080#1077#1089#1103' '#1085#1072' '#1073#1072#1083#1072#1085#1089#1077
        ShowHint = True
        Caption = #1041#1072#1083#1072#1085#1089':'
        Anchors = [akTop, akRight]
        ParentFont = False
        Font.Height = -13
        Font.Style = [fsBold]
        TabOrder = 1
      end
      object btnBalanceAdd: TUniButton
        Left = 135
        Top = 59
        Width = 129
        Height = 28
        ShowHint = True
        Action = actInsert
        Anchors = [akLeft, akRight, akBottom]
        TabOrder = 3
      end
    end
    object UniLabel6: TUniLabel
      Left = 13
      Top = 8
      Width = 44
      Height = 17
      Hint = ''
      ShowHint = True
      Caption = #1050#1083#1080#1077#1085#1090':'
      Anchors = [akLeft, akRight, akBottom]
      ParentFont = False
      Font.Height = -13
      TabOrder = 3
    end
    object edtDate: TUniDateRangePicker
      Left = 13
      Top = 63
      Width = 236
      Height = 26
      Hint = ''
      ShowHint = True
      Text = 'edtDate'
      TabOrder = 4
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
      DatePickerOptions.Opens = ooRight
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
    object cbClient: TUniExComboBox
      Left = 13
      Top = 31
      Width = 394
      Height = 26
      Hint = ''
      ShowHint = True
      Text = 'cbClient'
      TabOrder = 5
      AnyMatch = True
      ClearButton = True
      IconItems = <>
      Value = '-1'
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
    UpdateObject = UpdateSQL
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
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      OnExecute = actEditExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = actDeleteExecute
    end
    object actInsert: TAction
      Caption = #1055#1086#1087#1086#1083#1085#1080#1090#1100' '#1073#1072#1083#1072#1085#1089
      OnExecute = actInsertExecute
    end
  end
  object ppMain: TUniPopupMenu
    Left = 101
    Top = 218
    object N1: TUniMenuItem
      Action = actInsert
    end
    object N2: TUniMenuItem
      Action = actEdit
    end
    object N3: TUniMenuItem
      Action = actDelete
    end
    object N4: TUniMenuItem
      Caption = '-'
    end
    object N6: TUniMenuItem
      Action = actRefreshAll
    end
  end
  object UpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    InsertSQL.Strings = (
      'select 1')
    ModifySQL.Strings = (
      'select 1')
    DeleteSQL.Strings = (
      'select 1')
    FetchRowSQL.Strings = (
      ' select *'
      
        '   from tDocuments with (nolock index=PK_tDocuments_DocumentID) ' +
        ' '
      '  WHERE DocumentID = :DocumentID')
    Left = 711
    Top = 242
  end
end
