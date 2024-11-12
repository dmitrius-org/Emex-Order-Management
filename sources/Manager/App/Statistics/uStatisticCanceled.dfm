object StatisticCanceled: TStatisticCanceled
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
    Height = 70
    Hint = ''
    Align = alTop
    TabOrder = 0
    ShowCaption = False
    Caption = 'UniPanel1'
    LayoutAttribs.Align = 'top'
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'north'
    object btnGridStatisticOpen: TUniButton
      Left = 556
      Top = 25
      Width = 100
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      TabOrder = 1
      OnClick = btnGridStatisticOpenClick
    end
    object UniLabel5: TUniLabel
      Left = 3
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
      Left = 662
      Top = 25
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
    object fClient: TUniCheckComboBox
      Left = 215
      Top = 27
      Width = 209
      Hint = ''
      ShowHint = True
      ParentShowHint = False
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
      HideTrigger = True
      HideDefaultTrigger = False
      IconItems = <>
      OnSelect = fClientSelect
      OnKeyDown = edtOrderDateKeyDown
    end
    object UniLabel3: TUniLabel
      Left = 215
      Top = 8
      Width = 40
      Height = 13
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1050#1083#1080#1077#1085#1090':'
      TabOrder = 5
    end
    object edtOrderDate: TUniDateRangePicker
      Left = 6
      Top = 27
      Width = 203
      Hint = ''
      Text = ''
      TabOrder = 6
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
    end
  end
  object Grid: TUniDBGrid
    Left = 0
    Top = 76
    Width = 1199
    Height = 404
    Hint = ''
    Margins.Bottom = 0
    ShowHint = True
    ParentShowHint = False
    BodyRTL = False
    ClientEvents.UniEvents.Strings = (
      
        'afterCreate=function afterCreate(sender)'#13#10'{'#13#10' '#13#10'  //'#1059#1073#1080#1088#1072#1077#1084' '#1082#1085#1086#1087 +
        #1082#1091' '#1054#1073#1085#1086#1074#1080#1090#1100' '#1074' '#1055#1072#1085#1077#1083#1080' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074', '#1085#1086#1084#1077#1088' 9-10, '#1089#1082#1088#1099#1074#1072#1077#1084' '#1077#1075#1086#13#10'  v' +
        'ar toolbar=sender.getDockedItems()[1];'#13#10'  toolbar.items.getAt(9)' +
        '.hide();'#13#10'  toolbar.items.getAt(10).hide();'#13#10'     '#13#10'  sender.add' +
        'Plugin('#39'gridexporter'#39');'#13#10'    '#13#10'  var exporterCfg = new Object({'#13 +
        #10'            type: "xlsx",'#13#10'            mimeType: "application/v' +
        'nd.openxmlformats-officedocument.spreadsheetml.sheet",'#13#10'        ' +
        '    title: '#39#1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1087#1086' '#1086#1090#1082#1072#1079#1072#1084#39','#13#10'            fileName: "'#1057#1090#1072#1090 +
        #1080#1089#1090#1080#1082#1072' '#1087#1086' '#1086#1090#1082#1072#1079#1072#1084'.xlsx"'#13#10'        }); '#13#10#13#10'  // '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1074 +
        ' '#1087#1072#1085#1077#1083#1100' '#1085#1072#1074#1080#1075#1072#1094#1080#1080#13#10'  if (!toolbar.exportBtn) {'#13#10'     toolbar.exp' +
        'ortBtn = toolbar.insert('#13#10'       0, '#13#10'       //{ xtype: '#39'tbsepar' +
        'ator'#39' }'#13#10'       {xtype: '#39'button'#39', text: '#39#39', tooltip : '#39#1042#1099#1075#1088#1091#1079#1080#1090#1100 +
        ' '#1074' Excel'#39', handler: function() {'#13#10'          sender.saveDocumentA' +
        's(exporterCfg);'#13#10'       }}'#13#10'     );'#13#10'     toolbar.exportBtn.setI' +
        'conCls('#39'ToExcel'#39');// icon...     '#13#10'  }  '#13#10'  '#13#10'}'
      
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
    DataSource = dsCanceled
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgCheckSelectCheckOnly, dgAlwaysShowSelection, dgTabs, dgCancelOnExit, dgDontShowSelected, dgRowNumbers]
    WebOptions.PageSize = 10000
    WebOptions.AppendPosition = tpCurrentRow
    WebOptions.FetchAll = True
    Grouping.ShowCaption = False
    Grouping.ShowValue = False
    LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
    LoadMask.Color = 13421772
    EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
    LayoutConfig.ComponentCls = 'grid-statistics'
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
        FieldName = 'Manufacturer'
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
        Width = 183
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'DetailNumber'
        Title.Alignment = taCenter
        Title.Caption = #1044#1077#1090#1072#1083#1100
        Width = 201
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'DetailName'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 455
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'DetailAmount'
        Title.Alignment = taCenter
        Title.Caption = #1057#1091#1084#1084#1072
        Width = 158
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'DetailQuantity'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1079#1080#1094#1080#1081
        Width = 168
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'Quantity'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1079#1072#1082#1072#1079#1086#1074
        Width = 152
        ReadOnly = True
        Sortable = True
      end>
  end
  object dsCanceled: TDataSource
    DataSet = qCanceled
    Left = 668
    Top = 272
  end
  object qCanceled: TFDQuery
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
      'DECLARE @Clients as ID;'
      ' '
      'if :Clients <> '#39#39'    '
      '  INSERT INTO @Clients (ID)'
      '  SELECT CAST(value AS NUMERIC(18, 0))'
      '    FROM STRING_SPLIT(:Clients, '#39','#39');'
      '                         '
      ' exec dbo.StatisticCancelledCalc            '
      '    @Clients   = @Clients  '
      '   ,@DateBegin = :DateBegin  '
      '   ,@DateEnd   = :DateEnd  '
      ' '
      ''
      ''
      ''
      '')
    Left = 580
    Top = 273
    ParamData = <
      item
        Name = 'CLIENTS'
        DataType = ftString
        ParamType = ptInput
        Value = Null
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
  end
end
