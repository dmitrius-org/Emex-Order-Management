object StatisticsT: TStatisticsT
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 1055
  Height = 549
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
  object UniPageControl1: TUniPageControl
    Left = 0
    Top = 0
    Width = 1055
    Height = 549
    Hint = ''
    ActivePage = UniTabOrders
    Align = alClient
    TabOrder = 0
    object UniTabOrders: TUniTabSheet
      Hint = ''
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1087#1086' '#1079#1072#1082#1072#1079#1072#1084
      Layout = 'fit'
      object UniPanel1: TUniPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1041
        Height = 66
        Hint = ''
        Align = alTop
        TabOrder = 0
        ShowCaption = False
        Caption = 'UniPanel1'
        LayoutAttribs.Align = 'top'
        LayoutConfig.Width = '0'
        LayoutConfig.Region = 'north'
        object UniLabel1: TUniLabel
          Left = 29
          Top = 15
          Width = 69
          Height = 13
          Hint = ''
          Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
          TabOrder = 1
        end
        object edtDateBegin: TUniDateTimePicker
          Left = 29
          Top = 34
          Width = 120
          Hint = ''
          DateTime = 45253.000000000000000000
          DateFormat = 'dd/MM/yyyy'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 2
        end
        object UniLabel2: TUniLabel
          Left = 155
          Top = 15
          Width = 64
          Height = 13
          Hint = ''
          Caption = #1044#1072#1090#1072' '#1082#1086#1085#1094#1072':'
          TabOrder = 3
        end
        object edtDateEnd: TUniDateTimePicker
          Left = 155
          Top = 34
          Width = 120
          Hint = ''
          DateTime = 45253.000000000000000000
          DateFormat = 'dd/MM/yyyy'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 4
        end
        object UniButton1: TUniButton
          Left = 483
          Top = 33
          Width = 75
          Height = 25
          Hint = ''
          Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
          TabOrder = 5
          OnClick = UniButton1Click
        end
        object fClient: TUniCheckComboBox
          Left = 281
          Top = 34
          Width = 196
          Hint = ''
          ShowHint = True
          ParentShowHint = False
          Text = ''
          TabOrder = 6
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
        end
        object UniLabel3: TUniLabel
          Left = 281
          Top = 15
          Width = 40
          Height = 13
          Hint = ''
          ShowHint = True
          ParentShowHint = False
          Caption = #1050#1083#1080#1077#1085#1090':'
          TabOrder = 7
        end
      end
      object UniPanel2: TUniPanel
        Left = 0
        Top = 72
        Width = 1047
        Height = 449
        Hint = ''
        Align = alClient
        TabOrder = 1
        Caption = 'UniPanel2'
        Layout = 'fit'
        LayoutConfig.Region = 'center'
        object ChartAverage: TuniGChartsFrame
          Left = 1
          Top = 1
          Width = 1045
          Height = 447
          Hint = ''
          Align = alClient
          TabOrder = 1
        end
      end
    end
    object UniTabSheet1: TUniTabSheet
      Hint = ''
      Caption = #1052#1086#1085#1080#1090#1086#1088' '#1079#1072#1082#1072#1079#1086#1074
      Layout = 'fit'
      object UniPanel3: TUniPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1041
        Height = 66
        Hint = ''
        Align = alTop
        TabOrder = 0
        ShowCaption = False
        Caption = 'UniPanel1'
        LayoutAttribs.Align = 'top'
        LayoutConfig.Width = '0'
        LayoutConfig.Region = 'north'
        DesignSize = (
          1041
          66)
        object btnGridStatisticOpen: TUniButton
          Left = 581
          Top = 28
          Width = 105
          Height = 25
          Hint = ''
          Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
          TabOrder = 3
          OnClick = btnGridStatisticOpenClick
        end
        object UniLabel6: TUniLabel
          Left = 15
          Top = 10
          Width = 64
          Height = 13
          Hint = ''
          ShowHint = True
          ParentShowHint = False
          Caption = #1058#1080#1087' '#1076#1072#1085#1085#1099#1093':'
          TabOrder = 5
        end
        object UniLabel4: TUniLabel
          Left = 454
          Top = 10
          Width = 84
          Height = 13
          Hint = ''
          ShowHint = True
          ParentShowHint = False
          Caption = #1056#1072#1079#1084#1077#1088' '#1074#1099#1076#1072#1095#1080':'
          TabOrder = 6
        end
        object edtDataType: TUniFSComboBox
          Left = 15
          Top = 28
          Width = 433
          Hint = ''
          Text = ''
          Items.Strings = (
            #1044#1077#1090#1072#1083#1080' '#1089' '#1085#1072#1080#1073#1086#1083#1100#1096#1080#1084' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086#1084' '#1091#1085#1080#1082#1072#1083#1100#1085#1099#1093' '#1079#1072#1082#1072#1079#1086#1074#10#10
            #1044#1077#1090#1072#1083#1080' '#1089' '#1085#1072#1080#1073#1086#1083#1100#1096#1080#1084' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086#1084' '#1079#1072#1082#1072#1079#1072#1085#1085#1099#1093' '#1087#1086#1079#1080#1094#1080#1081)
          Anchors = [akLeft]
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
          Left = 454
          Top = 28
          Width = 121
          Hint = ''
          TabOrder = 2
          Value = 100.000000000000000000
          EmptyText = #1056#1072#1079#1084#1077#1088' '#1074#1099#1076#1072#1095#1080
          DecimalPrecision = 0
          DecimalSeparator = ','
        end
        object btnExcelExportButton: TUniButton
          Left = 692
          Top = 28
          Width = 147
          Height = 25
          Hint = ''
          Enabled = False
          Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
          TabOrder = 4
          OnClick = btnExcelExportButtonClick
        end
      end
      object GridStatistics: TUniDBGrid
        Left = 0
        Top = 72
        Width = 1047
        Height = 449
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
        TabOrder = 1
        ParentColor = False
        Color = clBtnFace
        DragDrop.PromptDrop = False
        RowWidget.DestroyOnCollapse = False
        Exporter.Enabled = True
        Exporter.UseColumnRenderer = True
        Exporter.Exporter = UniGridExcelExporter1
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
    end
  end
  object qAverageCountOrders: TFDQuery
    Connection = UniMainModule.FDConnection
    SQL.Strings = (
      ';with t as'
      '('
      '  Select o.OrderDate  , '
      '         o.Amount,'
      '         o.isCancel'
      '    from tOrders o (nolock)'
      '   where 1=1'
      '     and o.OrderDate between :DateBegin  and :DateEnd'
      '    '
      '     !Client'
      ')'
      '  --  '
      '  Select o.OrderDate   as OrderDate, '
      '         -- '#1086#1073#1097#1080#1077' '#1076#1072#1085#1085#1099#1077
      '         count(*)      as TotalCount,'
      '         sum(o.Amount) as TotalSum,  '
      '         -- '#1074#1079#1103#1090#1086#1074' '#1088#1072#1073#1086#1090#1091'         '
      '         sum(case '
      '                 when o.isCancel = 0 then 1'
      '                 else 0'
      '             end)      as WorkCount,'
      '         sum(case '
      '                 when o.isCancel = 0 then o.Amount '
      '                 else 0'
      '             end)      as WorkSum,'
      '         -- '#1086#1090#1082#1072#1079#1072#1085#1086
      '         sum(case '
      '                 when o.isCancel = 1 then 1'
      '                 else 0'
      '             end)      as CancelCount,'
      '         sum(case '
      '                 when o.isCancel = 1 then o.Amount '
      '                 else 0'
      '             end)      as CancelSum'
      '  '
      '    from t o (nolock)'
      '   where 1=1'
      '    '
      '   group by o.OrderDate   '
      '   order by o.OrderDate'
      '    '
      '       '
      '    '
      '       ')
    Left = 186
    Top = 422
    ParamData = <
      item
        Name = 'DATEBEGIN'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATEEND'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end>
    MacroData = <
      item
        Value = Null
        Name = 'CLIENT'
      end>
  end
  object dsAverageCountOrders: TDataSource
    DataSet = qAverageCountOrders
    Left = 46
    Top = 424
  end
  object qClient: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
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
      'SELECT c.[ClientID]'
      '      ,c.[Brief]'
      '      ,c.[Name]'
      '  FROM [tClients] c (nolock)'
      ' -- '#1087#1088#1072#1074#1072
      ' inner join vUserAccess ua (nolock)'
      '         on ua.UserID    = dbo.GetUserID()'
      '        and ua.LinkType  = 7'
      '        and ua.LinkID    = c.ClientID')
    Left = 572
    Top = 433
    object qClientClientID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'ClientID'
      ProviderFlags = [pfInWhere]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object qClientBrief: TWideStringField
      FieldName = 'Brief'
      Origin = 'Brief'
      Required = True
      Size = 256
    end
    object qClientName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Size = 512
    end
  end
  object dsClient: TDataSource
    DataSet = qClient
    Left = 652
    Top = 432
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
      '            exec  PartsMostUniqueOrdersList')
    Left = 618
    Top = 172
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
  object UniGridExcelExporter1: TUniGridExcelExporter
    FileExtention = 'xlsx'
    MimeType = 
      'application/vnd.openxmlformats-officedocument.spreadsheetml.shee' +
      't'
    CharSet = 'UTF-8'
    Left = 857
    Top = 167
  end
end
