object ShipmentsEditF: TShipmentsEditF
  Left = 0
  Top = 0
  ClientHeight = 299
  ClientWidth = 693
  Caption = #1044#1072#1085#1085#1099#1077' '#1087#1086' '#1086#1090#1075#1088#1091#1079#1082#1077
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnReady = UniFormReady
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 252
    Width = 687
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    DesignSize = (
      687
      44)
    object btnOk: TUniBitBtn
      Left = 576
      Top = 9
      Width = 85
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      Left = 488
      Top = 9
      Width = 81
      Height = 25
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
  object UniLabel1: TUniLabel
    Left = 146
    Top = 21
    Width = 100
    Height = 13
    Hint = ''
    Alignment = taCenter
    AutoSize = False
    Caption = #1044#1072#1085#1085#1099#1077' '#1075#1088#1091#1079#1072
    ParentFont = False
    Font.Height = -12
    TabOrder = 1
  end
  object UniLabel2: TUniLabel
    Left = 29
    Top = 61
    Width = 78
    Height = 13
    Hint = ''
    Caption = #1044#1072#1090#1072' '#1086#1090#1075#1088#1091#1079#1082#1080':'
    TabOrder = 2
  end
  object UniLabel3: TUniLabel
    Left = 28
    Top = 89
    Width = 79
    Height = 13
    Hint = ''
    Caption = #1044#1072#1090#1072' '#1076#1086#1089#1090#1072#1074#1082#1080':'
    TabOrder = 3
  end
  object UniLabel4: TUniLabel
    Left = 28
    Top = 117
    Width = 89
    Height = 13
    Hint = ''
    Caption = #1053#1086#1084#1077#1088' '#1086#1090#1075#1088#1091#1079#1082#1080':'
    TabOrder = 4
  end
  object UniLabel5: TUniLabel
    Left = 28
    Top = 145
    Width = 62
    Height = 13
    Hint = ''
    Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
    TabOrder = 5
  end
  object UniLabel6: TUniLabel
    Left = 28
    Top = 173
    Width = 70
    Height = 13
    Hint = ''
    Caption = #1053#1086#1084#1077#1088' '#1075#1088#1091#1079#1072':'
    TabOrder = 6
  end
  object UniLabel7: TUniLabel
    Left = 28
    Top = 201
    Width = 94
    Height = 13
    Hint = ''
    Caption = #1057#1087#1086#1089#1086#1073' '#1076#1086#1089#1090#1072#1074#1082#1080':'
    TabOrder = 7
  end
  object ShipmentsDate: TUniDateTimePicker
    Left = 146
    Top = 59
    Width = 100
    Hint = ''
    Enabled = False
    DateTime = 45562.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'HH:mm:ss'
    ReadOnly = True
    TabOrder = 8
    Color = clBtnFace
  end
  object ReceiptDate: TUniDateTimePicker
    Left = 146
    Top = 87
    Width = 100
    Hint = ''
    DateTime = 45562.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'HH:mm:ss'
    TabOrder = 9
  end
  object Invoice: TUniEdit
    Left = 146
    Top = 115
    Width = 100
    Hint = ''
    Enabled = False
    Text = ''
    TabOrder = 10
    Color = clBtnFace
    ReadOnly = True
    ReadOnlyMode = urmNotEditable
  end
  object Suppliers: TUniEdit
    Left = 146
    Top = 143
    Width = 100
    Hint = ''
    Enabled = False
    Text = ''
    TabOrder = 11
    Color = clBtnFace
    ReadOnly = True
    ReadOnlyMode = urmNotEditable
  end
  object TransporterNumber: TUniEdit
    Left = 146
    Top = 171
    Width = 100
    Hint = ''
    Text = ''
    TabOrder = 12
  end
  object DestinationName: TUniEdit
    Left = 146
    Top = 199
    Width = 100
    Hint = ''
    Enabled = False
    Text = ''
    TabOrder = 13
    Color = clBtnFace
    ReadOnly = True
    ReadOnlyMode = urmNotEditable
  end
  object UniLabel8: TUniLabel
    Left = 268
    Top = 61
    Width = 67
    Height = 13
    Hint = ''
    Caption = #1062#1077#1085#1072' '#1079#1072' 1 '#1082#1075':'
    TabOrder = 14
  end
  object UniLabel9: TUniLabel
    Left = 267
    Top = 89
    Width = 36
    Height = 13
    Hint = ''
    Caption = #1055#1088#1072#1081#1089':'
    TabOrder = 15
  end
  object UniLabel10: TUniLabel
    Left = 267
    Top = 117
    Width = 27
    Height = 13
    Hint = ''
    Caption = #1060#1072#1082#1090':'
    TabOrder = 16
  end
  object UniLabel11: TUniLabel
    Left = 267
    Top = 145
    Width = 62
    Height = 13
    Hint = ''
    Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
    TabOrder = 17
  end
  object UniLabel12: TUniLabel
    Left = 267
    Top = 173
    Width = 68
    Height = 13
    Hint = ''
    Caption = #1055#1077#1088#1077#1074#1086#1079#1095#1080#1082':'
    TabOrder = 18
  end
  object UniLabel13: TUniLabel
    Left = 267
    Top = 201
    Width = 192
    Height = 13
    Hint = ''
    Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1087#1086' '#1087#1086#1083#1091#1095#1077#1085#1080#1102':'
    TabOrder = 19
  end
  object WeightKGAmount: TUniFormattedNumberEdit
    Left = 352
    Top = 59
    Width = 100
    Hint = ''
    Enabled = False
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = '$'
    FormattedInput.CurrencySignSpace = crsAvailable
    TabOrder = 20
    Color = clBtnFace
    ReadOnly = True
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object WeightKG: TUniFormattedNumberEdit
    Left = 352
    Top = 87
    Width = 100
    Hint = ''
    Enabled = False
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = #1082#1075
    TabOrder = 21
    Color = clBtnFace
    ReadOnly = True
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object WeightKGF: TUniFormattedNumberEdit
    Left = 352
    Top = 115
    Width = 100
    Hint = ''
    Enabled = False
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = #1082#1075
    TabOrder = 22
    Color = clBtnFace
    ReadOnly = True
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object SupplierWeightKG: TUniFormattedNumberEdit
    Left = 352
    Top = 143
    Width = 100
    Hint = ''
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = #1082#1075
    TabOrder = 23
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object TransporterWeightKG: TUniFormattedNumberEdit
    Left = 352
    Top = 171
    Width = 100
    Hint = ''
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = #1082#1075
    TabOrder = 24
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object UniFormattedNumberEdit6: TUniFormattedNumberEdit
    Left = 564
    Top = 59
    Width = 100
    Hint = ''
    Enabled = False
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = '$'
    TabOrder = 25
    Color = clBtnFace
    ReadOnly = True
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object Amount: TUniFormattedNumberEdit
    Left = 564
    Top = 87
    Width = 100
    Hint = ''
    Enabled = False
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = '$'
    TabOrder = 26
    Color = clBtnFace
    ReadOnly = True
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object AmountF: TUniFormattedNumberEdit
    Left = 564
    Top = 115
    Width = 100
    Hint = ''
    Enabled = False
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = '$'
    TabOrder = 27
    Color = clBtnFace
    ReadOnly = True
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object SupplierAmount: TUniFormattedNumberEdit
    Left = 564
    Top = 143
    Width = 100
    Hint = ''
    Enabled = False
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = '$'
    TabOrder = 28
    Color = clBtnFace
    ReadOnly = True
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object TransporterAmount: TUniFormattedNumberEdit
    Left = 564
    Top = 171
    Width = 100
    Hint = ''
    Enabled = False
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = '$'
    TabOrder = 29
    Color = clBtnFace
    ReadOnly = True
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object DeliverySumF: TUniFormattedNumberEdit
    Left = 564
    Top = 199
    Width = 100
    Hint = ''
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = '$'
    TabOrder = 30
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object UniLabel14: TUniLabel
    Left = 352
    Top = 21
    Width = 100
    Height = 13
    Hint = ''
    Alignment = taCenter
    AutoSize = False
    Caption = #1042#1077#1089' '#1092#1080#1079#1080#1095#1077#1089#1082#1080#1081
    ParentFont = False
    Font.Height = -12
    TabOrder = 31
  end
  object UniLabel15: TUniLabel
    Left = 458
    Top = 21
    Width = 100
    Height = 13
    Hint = ''
    Alignment = taCenter
    AutoSize = False
    Caption = #1042#1077#1089' '#1086#1073#1098#1077#1084#1085#1099#1081
    ParentFont = False
    Font.Height = -12
    TabOrder = 32
  end
  object UniLabel16: TUniLabel
    Left = 564
    Top = 21
    Width = 100
    Height = 13
    Hint = ''
    Alignment = taCenter
    AutoSize = False
    Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1076#1086#1089#1090#1072#1074#1082#1080
    ParentFont = False
    Font.Height = -12
    TabOrder = 33
  end
  object VolumeKGAmount: TUniFormattedNumberEdit
    Left = 458
    Top = 59
    Width = 100
    Hint = ''
    Enabled = False
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = '$'
    TabOrder = 34
    Color = clBtnFace
    ReadOnly = True
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object VolumeKG: TUniFormattedNumberEdit
    Left = 458
    Top = 87
    Width = 100
    Hint = ''
    Enabled = False
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = #1082#1075
    TabOrder = 35
    Color = clBtnFace
    ReadOnly = True
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object VolumeKGF: TUniFormattedNumberEdit
    Left = 458
    Top = 115
    Width = 100
    Hint = ''
    Enabled = False
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = #1082#1075
    TabOrder = 36
    Color = clBtnFace
    ReadOnly = True
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object SupplierVolumeKG: TUniFormattedNumberEdit
    Left = 458
    Top = 143
    Width = 100
    Hint = ''
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = #1082#1075
    TabOrder = 37
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object TransporterVolumeKG: TUniFormattedNumberEdit
    Left = 458
    Top = 171
    Width = 100
    Hint = ''
    FormattedInput.ShowCurrencySign = True
    FormattedInput.CurrencySignPos = cpsRight
    FormattedInput.DefaultCurrencySign = False
    FormattedInput.CurrencySign = #1082#1075
    TabOrder = 38
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
end
