object EmployeeOrdersProcessedT: TEmployeeOrdersProcessedT
  Left = 0
  Top = 0
  Width = 1199
  Height = 480
  OnCreate = UniFrameCreate
  OnDestroy = UniFrameDestroy
  Layout = 'fit'
  TabOrder = 0
  object UniPanel3: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1193
    Height = 64
    Hint = ''
    Align = alTop
    TabOrder = 0
    ShowCaption = False
    Caption = 'UniPanel1'
    LayoutAttribs.Align = 'top'
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'north'
    object btnGridStatisticOpen: TUniButton
      Left = 526
      Top = 27
      Width = 100
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      TabOrder = 1
      OnClick = btnGridStatisticOpenClick
    end
    object UniLabel5: TUniLabel
      Left = 6
      Top = 4
      Width = 49
      Height = 17
      Hint = ''
      Caption = #1055#1077#1088#1080#1086#1076':'
      ParentFont = False
      Font.Height = -13
      TabOrder = 2
    end
    object fCancel: TUniBitBtn
      Left = 632
      Top = 27
      Width = 100
      Height = 25
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 3
      ImageIndex = 3
      OnClick = fCancelClick
    end
    object UniLabel3: TUniLabel
      Left = 215
      Top = 4
      Width = 65
      Height = 17
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082':'
      ParentFont = False
      Font.Height = -13
      TabOrder = 4
    end
    object edtOrderDate: TUniDateRangePicker
      Left = 6
      Top = 27
      Width = 203
      Hint = ''
      Text = ''
      TabOrder = 5
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
      OnKeyDown = edtOrderDateKeyDown
      DateFormat = 'DD/MM/YYYY'
      DatePickerOptions.Opens = ooRight
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
    object fEmployees: TUniADCheckComboBox
      Left = 215
      Top = 27
      Width = 305
      Hint = ''
      ShowSearch = True
      Text = ''
      TabOrder = 6
      ClientEvents.ExtEvents.Strings = (
        ''
        
          'afterrender=function afterrender(sender, eOpts) {'#13#10'   initComboB' +
          'oxSearch(sender, "id", "val");'#13#10'}')
      ClearButton = True
      IconItems = <>
      OnKeyDown = edtOrderDateKeyDown
    end
  end
  object Grid: TUniDBGrid
    Left = 0
    Top = 70
    Width = 1199
    Height = 410
    Hint = ''
    Margins.Bottom = 0
    ShowHint = True
    ParentShowHint = False
    BodyRTL = False
    ClientEvents.UniEvents.Strings = (
      
        'afterCreate=function afterCreate(sender)'#13#10'{'#13#10' '#13#10'  //'#1059#1073#1080#1088#1072#1077#1084' '#1082#1085#1086#1087 +
        #1082#1091' '#1054#1073#1085#1086#1074#1080#1090#1100' '#1074' '#1055#1072#1085#1077#1083#1080' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074', '#1085#1086#1084#1077#1088' 9-10, '#1089#1082#1088#1099#1074#1072#1077#1084' '#1077#1075#1086#13#10'  v' +
        'ar toolbar=sender.getDockedItems()[1];'#13#10'  toolbar.items.getAt(9)' +
        '.hide();'#13#10'  toolbar.items.getAt(10).hide();'#13#10'    '#13#10'     '#13#10'  send' +
        'er.addPlugin('#39'gridexporter'#39');'#13#10'    '#13#10'  var exporterCfg = new Obj' +
        'ect({'#13#10'            type: "xlsx",'#13#10'            mimeType: "applica' +
        'tion/vnd.openxmlformats-officedocument.spreadsheetml.sheet",'#13#10'  ' +
        '          title: '#39#1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1079#1072#1082#1072#1079#1086#1074#39','#13#10'            fi' +
        'leName: "'#1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1079#1072#1082#1072#1079#1086#1074'.xlsx"'#13#10'        }); '#13#10#13#10'  /' +
        '/ '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1074' '#1087#1072#1085#1077#1083#1100' '#1085#1072#1074#1080#1075#1072#1094#1080#1080#13#10'  if (!toolbar.exportBtn)' +
        ' {'#13#10'     toolbar.exportBtn = toolbar.insert('#13#10'       0, '#13#10'      ' +
        ' //{ xtype: '#39'tbseparator'#39' }'#13#10'       {xtype: '#39'button'#39', text: '#39#39', ' +
        'tooltip : '#39#1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'#39', handler: function() {'#13#10'          ' +
        'sender.saveDocumentAs(exporterCfg);'#13#10'       }}'#13#10'     );'#13#10'     to' +
        'olbar.exportBtn.setIconCls('#39'ToExcel'#39');// icon...     '#13#10'  }   '#13#10' ' +
        ' '#13#10'}'
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
        'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
        'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
        'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
        'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
        'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
        't.body.removeChild(el);'#13#10'    };     '#13#10'}'#13#10#13#10
      
        'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
        'g)'#13#10'{'#13#10'  config.displayInfo=true;'#13#10'}')
    HeaderTitleAlign = taCenter
    DataSource = Source
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgCheckSelectCheckOnly, dgAlwaysShowSelection, dgTabs, dgCancelOnExit, dgDontShowSelected, dgRowNumbers]
    WebOptions.PageSize = 10000
    WebOptions.AppendPosition = tpCurrentRow
    WebOptions.FetchAll = True
    Grouping.ShowCaption = False
    Grouping.ShowValue = False
    LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
    LoadMask.Color = 13421772
    EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
    LayoutConfig.ComponentCls = 'grid-employee-orders-processed'
    LayoutConfig.Height = '100'
    LayoutConfig.Width = '100'
    BorderStyle = ubsNone
    TrackOver = False
    Align = alClient
    Anchors = []
    TabOrder = 1
    ParentColor = False
    Color = clBtnFace
    DragDrop.PromptDrop = False
    RowWidget.DestroyOnCollapse = False
    Exporter.Enabled = True
    Exporter.UseColumnRenderer = True
    OnColumnSort = GridColumnSort
    Columns = <
      item
        FieldName = 'EmployeeName'
        Title.Alignment = taCenter
        Title.Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082
        Width = 398
      end
      item
        FieldName = 'Processed'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1085#1099#1093' '#1089#1090#1088#1086#1082
        Width = 100
      end
      item
        FieldName = 'Incorrect'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1085#1077#1087#1088#1072#1074#1080#1083#1100#1085#1086' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1085#1099#1093' '#1089#1090#1088#1086#1082
        Width = 100
      end
      item
        FieldName = 'Confirmed'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1085#1099#1093' '#1089#1090#1088#1086#1082
        Width = 100
      end
      item
        FieldName = 'AmountSum'
        Title.Alignment = taCenter
        Title.Caption = #1057#1091#1084#1084#1072' '#1074#1086#1079#1085#1072#1075#1088#1072#1078#1076#1077#1085#1080#1103' '#1089' '#1084#1086#1084#1077#1085#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1089#1073#1088#1086#1089#1072
        Width = 120
      end
      item
        FieldName = 'AmountSumAll'
        Title.Alignment = taCenter
        Title.Caption = #1057#1091#1084#1084#1072' '#1074#1086#1079#1085#1072#1075#1088#1072#1078#1076#1077#1085#1080#1103' '#1079#1072' '#1074#1089#1102' '#1080#1089#1090#1086#1088#1080#1102
        Width = 120
      end
      item
        FieldName = 'ProcessedSum'
        Title.Alignment = taCenter
        Title.Caption = #1057#1091#1084#1084#1072' '#1074#1077#1088#1085#1086' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1085#1099#1093' '#1089#1090#1088#1086#1082
        Width = 120
      end
      item
        FieldName = 'IncorrectSum'
        Title.Alignment = taCenter
        Title.Caption = #1057#1091#1084#1084#1072' '#1085#1077#1074#1077#1088#1085#1086' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1085#1099#1093' '#1089#1090#1088#1086#1082
        Width = 120
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
      ''
      'DECLARE @Employees as ID;'
      ' '
      'if :Employees <> '#39#39'    '
      '  INSERT INTO @Employees (ID)'
      '  SELECT CAST(value AS NUMERIC(18, 0))'
      '    FROM STRING_SPLIT(:Employees, '#39','#39');'
      '                         '
      'exec EmployeeOrdersProcessedSelect            '
      '       @Employees = @Employees  '
      '      ,@DateBegin = :DateBegin  '
      '      ,@DateEnd   = :DateEnd  '
      ' '
      ''
      ''
      ''
      '')
    Left = 580
    Top = 273
    ParamData = <
      item
        Name = 'EMPLOYEES'
        ParamType = ptInput
      end
      item
        Name = 'DATEBEGIN'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATEEND'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object QueryEmployeeID: TFMTBCDField
      FieldName = 'EmployeeID'
    end
    object QueryEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 256
    end
    object QueryProcessed: TIntegerField
      FieldName = 'Processed'
    end
    object QueryIncorrect: TIntegerField
      FieldName = 'Incorrect'
    end
    object QueryConfirmed: TIntegerField
      FieldName = 'Confirmed'
    end
    object QueryAmountSum: TFloatField
      FieldName = 'AmountSum'
    end
    object QueryAmountSumAll: TFloatField
      FieldName = 'AmountSumAll'
    end
    object QueryProcessedSum: TFloatField
      FieldName = 'ProcessedSum'
    end
    object QueryIncorrectSum: TFloatField
      FieldName = 'IncorrectSum'
    end
  end
end
