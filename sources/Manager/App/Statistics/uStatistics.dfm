object StatisticsT: TStatisticsT
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 1024
  Height = 541
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
  object UniPanel1: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1018
    Height = 66
    Hint = ''
    Align = alTop
    TabOrder = 0
    ShowCaption = False
    Caption = 'UniPanel1'
    LayoutAttribs.Align = 'top'
    LayoutConfig.Width = '0'
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
    Width = 1024
    Height = 469
    Hint = ''
    Align = alClient
    TabOrder = 1
    Caption = 'UniPanel2'
    object ChartAverage: TuniGChartsFrame
      Left = 1
      Top = 1
      Width = 1022
      Height = 467
      Hint = ''
      Align = alClient
      TabOrder = 1
    end
  end
  object qAverageCountOrders: TFDQuery
    Connection = UniMainModule.FDConnection
    SQL.Strings = (
      '  Select o.OrderDate   as d, '
      '         count(*)      as orderCount ,'
      '         sum(o.Amount) as orderSum    '
      '    from tOrders o (nolock)'
      '   --cross apply ( select top 1 cast(p.InDateTime as date) d'
      '   --                from tProtocol p with (nolock index=ao2)'
      '   --              inner join tNodes n (nolock)'
      '   --                      on n.NodeId = p.NewStateID'
      '   --                     and n.Brief in ('#39'InWork'#39')'
      '   --               where p.objectID  = o.OrderID'
      '                    '
      '   --               order by p.OperDate desc'
      '   --             ) p'
      '   where 1=1'
      '     and o.OrderDate between :DateBegin  and :DateEnd'
      '     and o.isCancel = 0'
      '      !Client'
      '   group by o.OrderDate   '
      '   order by o.OrderDate'
      '    '
      '       ')
    Left = 814
    Top = 30
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
    Left = 713
    Top = 32
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
end
