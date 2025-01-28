object ChatsT: TChatsT
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
    Height = 112
    Hint = ''
    Align = alTop
    TabOrder = 0
    ShowCaption = False
    Caption = 'UniPanel1'
    LayoutAttribs.Align = 'top'
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'north'
    object btnGridStatisticOpen: TUniButton
      Left = 584
      Top = 70
      Width = 100
      Height = 32
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      TabOrder = 1
      OnClick = btnGridStatisticOpenClick
    end
    object fCancel: TUniBitBtn
      Left = 690
      Top = 70
      Width = 100
      Height = 32
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 2
      ImageIndex = 3
      OnClick = fCancelClick
    end
    object UniLabel1: TUniLabel
      Left = 40
      Top = 49
      Width = 40
      Height = 17
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1057#1090#1072#1090#1091#1089':'
      ParentFont = False
      Font.Height = -13
      TabOrder = 3
    end
    object fStatus: TUniADCheckComboBox
      Left = 40
      Top = 70
      Width = 232
      Height = 32
      Hint = ''
      ShowSearch = True
      ShowSelectButton = True
      Text = ''
      ParentFont = False
      Font.Height = -13
      TabOrder = 4
      ClientEvents.ExtEvents.Strings = (
        ''
        ''
        
          'afterrender=function afterrender(sender, eOpts) {  '#13#10'initComboBo' +
          'xSelectButtons(sender, "id");'#13#10'initComboBoxSearch(sender, "id", ' +
          '"val");  '#13#10'}')
      EmptyText = #1057#1090#1072#1090#1091#1089#1099
      ClearButton = True
      IconItems = <>
      OnKeyDown = edtOrderDateKeyDown
    end
    object edtSearch: TUniComboBox
      Left = 40
      Top = 9
      Width = 751
      Height = 32
      Hint = ''
      Margins.Top = 5
      Margins.Bottom = 5
      MaxLength = 40
      Text = ''
      ParentFont = False
      Font.Height = -13
      TabOrder = 5
      EmptyText = #1055#1086#1080#1089#1082' '#1086#1073#1088#1072#1097#1077#1085#1080#1081' '#1087#1086' '#1085#1086#1084#1077#1088#1091' '#1080' '#1090#1077#1084#1077
      MinQueryLength = 0
      RemoteFilter = False
      RemoteQueryCache = False
      ClearButton = True
      HideTrigger = True
      IconItems = <>
    end
  end
  object Grid: TUniDBGrid
    Left = 0
    Top = 118
    Width = 1199
    Height = 362
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
        '          title: '#39#1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1087#1086' '#1073#1088#1077#1085#1076#1072#1084#39','#13#10'            fileName:' +
        ' "'#1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1087#1086' '#1073#1088#1077#1085#1076#1072#1084'.xlsx"'#13#10'        }); '#13#10#13#10'  // '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1085 +
        #1086#1087#1082#1091' '#1074' '#1087#1072#1085#1077#1083#1100' '#1085#1072#1074#1080#1075#1072#1094#1080#1080#13#10'  if (!toolbar.exportBtn) {'#13#10'     toolb' +
        'ar.exportBtn = toolbar.insert('#13#10'       0, '#13#10'       //{ xtype: '#39't' +
        'bseparator'#39' }'#13#10'       {xtype: '#39'button'#39', text: '#39#39', tooltip : '#39#1042#1099#1075 +
        #1088#1091#1079#1080#1090#1100' '#1074' Excel'#39', handler: function() {'#13#10'          sender.saveDoc' +
        'umentAs(exporterCfg);'#13#10'       }}'#13#10'     );'#13#10'     toolbar.exportBt' +
        'n.setIconCls('#39'ToExcel'#39');// icon...     '#13#10'  }   '#13#10'  '#13#10'}'
      
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
    TitleFont.Height = -13
    DataSource = dsQuery
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgCheckSelectCheckOnly, dgAlwaysShowSelection, dgTabs, dgCancelOnExit, dgDontShowSelected, dgRowNumbers]
    WebOptions.PageSize = 1000
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
    OnKeyDown = GridKeyDown
    OnAjaxEvent = GridAjaxEvent
    OnBodyDblClick = actMessagesExecute
    OnColumnSort = GridColumnSort
    OnColumnMove = GridColumnMove
    OnColumnResize = GridColumnResize
    Columns = <
      item
        FieldName = 'ChatID'
        Title.Alignment = taCenter
        Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
        Title.Font.Height = -13
        Width = 100
        Visible = False
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'Flag'
        Title.Alignment = taCenter
        Title.Caption = ' '
        Width = 64
      end
      item
        FieldName = 'Subject'
        Title.Alignment = taCenter
        Title.Caption = #1058#1077#1084#1072
        Title.Font.Height = -13
        Width = 399
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'ClientName'
        Title.Alignment = taCenter
        Title.Caption = #1050#1083#1080#1077#1085#1090
        Title.Font.Height = -13
        Width = 250
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'InDateTime'
        Title.Alignment = taCenter
        Title.Caption = #1057#1086#1079#1076#1072#1085#1086
        Title.Font.Height = -13
        Width = 158
        ReadOnly = True
        Sortable = True
      end
      item
        FieldName = 'StatusName'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1072#1090#1091#1089
        Title.Font.Height = -13
        Width = 200
        ReadOnly = True
        Sortable = True
      end>
  end
  object dsQuery: TDataSource
    DataSet = qQuery
    Left = 668
    Top = 272
  end
  object qQuery: TFDQuery
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
    UpdateOptions.KeyFields = 'ChatID'
    UpdateOptions.AutoIncFields = 'ChatID'
    SQL.Strings = (
      '   '
      'DECLARE @Status as ID;'
      ' '
      'if :Status <> '#39#39'    '
      '  INSERT INTO @Status (ID)'
      '  SELECT CAST(value AS NUMERIC(18, 0))'
      '    FROM STRING_SPLIT(:Status, '#39','#39');    '
      '       '
      'exec CustomerChatsList '
      '       @ClientID= :ClientID'
      '      ,@Status  = @Status'
      '      ,@Number  = :Number'
      '')
    Left = 580
    Top = 273
    ParamData = <
      item
        Name = 'STATUS'
        ParamType = ptInput
      end
      item
        Name = 'CLIENTID'
        DataType = ftFMTBcd
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'NUMBER'
        ParamType = ptInput
      end>
    object qQueryChatID: TFMTBCDField
      FieldName = 'ChatID'
    end
    object qQueryFlag: TIntegerField
      FieldName = 'Flag'
      OnGetText = qQueryFlagGetText
    end
    object qQuerySubject: TStringField
      FieldName = 'Subject'
      Size = 255
    end
    object qQueryNumber: TStringField
      FieldName = 'Number'
      Size = 100
    end
    object qQueryInDateTime: TSQLTimeStampField
      FieldName = 'InDateTime'
    end
    object qQueryStatusName: TStringField
      FieldName = 'StatusName'
      Size = 256
    end
    object qQueryClientName: TWideStringField
      FieldName = 'ClientName'
      Size = 256
    end
    object qQueryUnReadMessages: TIntegerField
      FieldName = 'UnReadMessages'
    end
  end
end
