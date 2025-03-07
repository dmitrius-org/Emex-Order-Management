object StatisticCanceled: TStatisticCanceled
  Left = 0
  Top = 0
  Width = 928
  Height = 359
  OnCreate = UniFrameCreate
  Layout = 'fit'
  TabOrder = 0
  object UniPanel3: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 922
    Height = 71
    Hint = ''
    Align = alTop
    TabOrder = 0
    ShowCaption = False
    Caption = 'UniPanel1'
    LayoutAttribs.Align = 'top'
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'north'
    ExplicitWidth = 1193
    object btnGridStatisticOpen: TUniButton
      Left = 704
      Top = 27
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
      Left = 810
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
      Top = 8
      Width = 40
      Height = 13
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1050#1083#1080#1077#1085#1090':'
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
    object UniLabel2: TUniLabel
      Left = 430
      Top = 8
      Width = 114
      Height = 13
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082' '#1080#1079' '#1079#1072#1082#1072#1079#1072':'
      TabOrder = 6
    end
    object fPriceLogo: TUniADCheckComboBox
      Left = 430
      Top = 27
      Width = 131
      Hint = ''
      ShowSearch = True
      Text = ''
      TabOrder = 7
      ClientEvents.ExtEvents.Strings = (
        
          'afterrender=function afterrender(sender, eOpts) {'#13#10'   initComboB' +
          'oxSearch(sender, "id", "val");'#13#10'}')
      ClearButton = True
      IconItems = <>
    end
    object fClient: TUniADCheckComboBox
      Left = 215
      Top = 27
      Width = 209
      Hint = ''
      ShowSearch = True
      Text = ''
      TabOrder = 8
      ClientEvents.ExtEvents.Strings = (
        ''
        
          'afterrender=function afterrender(sender, eOpts) {'#13#10'   initComboB' +
          'oxSearch(sender, "id", "val");'#13#10'}')
      ClearButton = True
      IconItems = <>
      OnKeyDown = edtOrderDateKeyDown
    end
    object UniLabel1: TUniLabel
      Left = 567
      Top = 8
      Width = 95
      Height = 13
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082' ('#1060#1072#1082#1090'):'
      TabOrder = 9
    end
    object fPriceLogoF: TUniADCheckComboBox
      Left = 567
      Top = 27
      Width = 131
      Hint = ''
      ShowSearch = True
      Text = ''
      TabOrder = 10
      ClientEvents.ExtEvents.Strings = (
        
          'afterrender=function afterrender(sender, eOpts) {'#13#10'   initComboB' +
          'oxSearch(sender, "id", "val");'#13#10'}')
      ClearButton = True
      IconItems = <>
    end
    object fPriceLogoCancel: TUniCheckBox
      Left = 566
      Top = 52
      Width = 97
      Height = 17
      Hint = ''
      Caption = #1048#1089#1082#1083#1102#1095#1080#1090#1100
      TabOrder = 11
    end
  end
  object ChartAverage: TuniGChartsFrame
    Left = 0
    Top = 77
    Width = 928
    Height = 282
    Hint = ''
    Align = alClient
    TabOrder = 1
    ExplicitLeft = -115
    ExplicitTop = -28
    ExplicitWidth = 1314
    ExplicitHeight = 447
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
      'DECLARE @Clients as ID'
      '       ,@Prices  as SID'
      '       ,@PricesF as SID'
      ' '
      'if :Clients <> '#39#39'    '
      '  INSERT INTO @Clients (ID)'
      '  SELECT CAST(value AS NUMERIC(18, 0))'
      '    FROM STRING_SPLIT(:Clients, '#39','#39');'
      '    '
      'if :Prices <> '#39#39'    '
      '  INSERT INTO @Prices (Name)'
      '  SELECT value'
      '    FROM STRING_SPLIT(:Prices, '#39','#39'); '
      '    '
      'if :PricesF <> '#39#39'    '
      '  INSERT INTO @PricesF (Name)'
      '  SELECT value'
      '    FROM STRING_SPLIT(:PricesF, '#39','#39');     '
      '                         '
      ' exec dbo.StatisticCancelledCalc            '
      '    @Clients   = @Clients  '
      '   ,@Prices    = @Prices  '
      '   ,@PricesF   = @PricesF  '
      '   ,@DateBegin = :DateBegin  '
      '   ,@DateEnd   = :DateEnd  '
      '   ,@PricesFCan= :PricesFCan'
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
        Name = 'PRICES'
        ParamType = ptInput
      end
      item
        Name = 'PRICESF'
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
      end
      item
        Name = 'PRICESFCAN'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end>
    object qCanceledOrderDate: TSQLTimeStampField
      FieldName = 'OrderDate'
    end
    object qCanceledQuantityCancel: TIntegerField
      FieldName = 'QuantityCancel'
      DisplayFormat = '###,##0'
    end
    object qCanceledAmountCancel: TCurrencyField
      FieldName = 'AmountCancel'
      DisplayFormat = '###,##0.00 '#8381
    end
    object qCanceledQuantityCancelEmex: TIntegerField
      FieldName = 'QuantityCancelEmex'
    end
    object qCanceledAmountCancelEmex: TCurrencyField
      FieldName = 'AmountCancelEmex'
    end
    object qCanceledQuantityCancelManager: TIntegerField
      FieldName = 'QuantityCancelManager'
    end
    object qCanceledAmountCancelManger: TCurrencyField
      FieldName = 'AmountCancelManger'
    end
    object qCanceledPrcCancel: TFloatField
      FieldName = 'PrcCancel'
    end
  end
end
