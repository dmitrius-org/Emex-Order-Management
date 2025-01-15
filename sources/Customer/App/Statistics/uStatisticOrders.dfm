object StatisticOrders: TStatisticOrders
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 1111
  Height = 374
  Margins.Bottom = 0
  OnCreate = UniFrameCreate
  Layout = 'fit'
  LayoutConfig.IgnorePosition = False
  LayoutConfig.Width = '0'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  TabOrder = 0
  ParentColor = False
  ParentBackground = False
  object GridStatistics: TUniDBGrid
    Left = 0
    Top = 107
    Width = 1111
    Height = 267
    Hint = ''
    Margins.Bottom = 0
    ShowHint = True
    ParentShowHint = False
    BodyRTL = False
    ClientEvents.UniEvents.Strings = (
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
        'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
        'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
        'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
        'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
        'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
        't.body.removeChild(el);'#13#10'    };     '#13#10'}'#13#10#13#10
      
        'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
        'g)'#13#10'{'#13#10'  config.displayInfo=true;'#13#10'}'
      
        'afterCreate=function afterCreate(sender)'#13#10'{'#13#10' '#13#10'  //'#1059#1073#1080#1088#1072#1077#1084' '#1082#1085#1086#1087 +
        #1082#1091' '#1054#1073#1085#1086#1074#1080#1090#1100' '#1074' '#1055#1072#1085#1077#1083#1080' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074', '#1085#1086#1084#1077#1088' 9-10, '#1089#1082#1088#1099#1074#1072#1077#1084' '#1077#1075#1086#13#10'  v' +
        'ar toolbar=sender.getDockedItems()[1];'#13#10'  toolbar.items.getAt(9)' +
        '.hide();'#13#10'  toolbar.items.getAt(10).hide();'#13#10'    '#13#10'    '#13#10'  '#13#10'}')
    HeaderTitleAlign = taCenter
    DataSource = dsGridStatistics
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
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    DragDrop.PromptDrop = False
    RowWidget.DestroyOnCollapse = False
    Exporter.Enabled = True
    Exporter.UseColumnRenderer = True
    OnKeyDown = GridStatisticsKeyDown
    Columns = <
      item
        FieldName = 'Manufacturer'
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
        Width = 183
      end
      item
        FieldName = 'DetailNumber'
        Title.Alignment = taCenter
        Title.Caption = #1044#1077#1090#1072#1083#1100
        Width = 201
      end
      item
        FieldName = 'DetailName'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 455
        ReadOnly = True
      end
      item
        FieldName = 'OrderCount'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Width = 168
      end>
  end
  object UniPanel3: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1105
    Height = 101
    Hint = ''
    Align = alTop
    TabOrder = 1
    ShowCaption = False
    Caption = 'UniPanel1'
    LayoutAttribs.Align = 'top'
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'north'
    object btnGridStatisticOpen: TUniButton
      Left = 682
      Top = 23
      Width = 95
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      TabOrder = 3
      OnClick = btnGridStatisticOpenClick
    end
    object UniLabel6: TUniLabel
      Left = 239
      Top = 3
      Width = 71
      Height = 17
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1058#1080#1087' '#1076#1072#1085#1085#1099#1093':'
      ParentFont = False
      Font.Height = -13
      TabOrder = 4
    end
    object UniLabel4: TUniLabel
      Left = 3
      Top = 51
      Width = 95
      Height = 17
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1056#1072#1079#1084#1077#1088' '#1074#1099#1076#1072#1095#1080':'
      ParentFont = False
      Font.Height = -13
      TabOrder = 5
    end
    object edtDataType: TUniFSComboBox
      Left = 239
      Top = 23
      Width = 437
      Hint = ''
      Text = ''
      Items.Strings = (
        #1044#1077#1090#1072#1083#1080' '#1089' '#1085#1072#1080#1073#1086#1083#1100#1096#1080#1084' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086#1084' '#1091#1085#1080#1082#1072#1083#1100#1085#1099#1093' '#1079#1072#1082#1072#1079#1086#1074#10#10
        #1044#1077#1090#1072#1083#1080' '#1089' '#1085#1072#1080#1073#1086#1083#1100#1096#1080#1084' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086#1084' '#1079#1072#1082#1072#1079#1072#1085#1085#1099#1093' '#1087#1086#1079#1080#1094#1080#1081)
      TabOrder = 1
      EmptyText = #1058#1080#1087' '#1076#1072#1085#1085#1099#1093
      AnyMatch = True
      IconItems = <>
      Value = '-1'
      ValueList.Strings = (
        '1'
        '2')
    end
    object edtDataSize: TUniNumberEdit
      Left = 3
      Top = 69
      Width = 120
      Height = 24
      Hint = ''
      TabOrder = 2
      Value = 100.000000000000000000
      EmptyText = #1056#1072#1079#1084#1077#1088' '#1074#1099#1076#1072#1095#1080
      DecimalPrecision = 0
      DecimalSeparator = ','
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
      TabOrder = 6
    end
    object cbCancel: TUniComboBox
      Left = 129
      Top = 69
      Width = 104
      Height = 23
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Text = 'cbCancel'
      Items.Strings = (
        #1053#1077#1090
        #1044#1072)
      ItemIndex = 0
      TabOrder = 7
      EmptyText = #1054#1090#1082#1072#1079
      ClearButton = True
      IconItems = <>
    end
    object UniLabel8: TUniLabel
      Left = 129
      Top = 51
      Width = 37
      Height = 17
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1054#1090#1082#1072#1079':'
      ParentFont = False
      Font.Height = -13
      TabOrder = 8
    end
    object fCancel: TUniBitBtn
      Left = 783
      Top = 23
      Width = 122
      Height = 25
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      TabOrder = 9
      ImageIndex = 3
      OnClick = fCancelClick
    end
    object edtPeriod: TUniDateRangePicker
      Left = 3
      Top = 23
      Width = 230
      Hint = ''
      Text = ''
      TabOrder = 10
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
  end
  object dsGridStatistics: TDataSource
    DataSet = qGridStatistics
    Left = 712
    Top = 170
  end
  object qGridStatistics: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evItems, evAutoFetchAll]
    FetchOptions.Items = []
    FormatOptions.AssignedValues = [fvSortOptions]
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
    SQL.Strings = (
      '       '
      ' exec PartsMostUniqueOrdersList'
      '        @RowSize   = :RowSize   '
      '       ,@OnlyWork  = :OnlyWork'
      '       ,@DateBegin = :DateBegin'
      '       ,@DateEnd   = :DateEnd'
      '       ')
    Left = 618
    Top = 172
    ParamData = <
      item
        Name = 'ROWSIZE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ONLYWORK'
        DataType = ftBoolean
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
    object qGridStatisticsManufacturer: TStringField
      FieldName = 'Manufacturer'
      Origin = 'Manufacturer'
      Size = 60
    end
    object qGridStatisticsDetailNumber: TWideStringField
      FieldName = 'DetailNumber'
      Origin = 'DetailNumber'
      Size = 64
    end
    object qGridStatisticsDetailName: TWideStringField
      FieldName = 'DetailName'
      Origin = 'DetailName'
      ReadOnly = True
      Size = 256
    end
    object qGridStatisticsOrderCount: TIntegerField
      FieldName = 'OrderCount'
      Origin = 'OrderCount'
    end
  end
end
