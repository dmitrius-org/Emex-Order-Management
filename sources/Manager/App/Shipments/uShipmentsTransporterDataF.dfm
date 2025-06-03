object ShipmentsTransporterDataF: TShipmentsTransporterDataF
  Left = 0
  Top = 0
  ClientHeight = 184
  ClientWidth = 284
  Caption = #1059#1082#1072#1079#1072#1090#1100' '#1074#1077#1089' '#1087#1086' '#1076#1072#1085#1085#1099#1084' '#1087#1077#1088#1077#1074#1086#1079#1095#1080#1082#1072
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 137
    Width = 278
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    DesignSize = (
      278
      44)
    object btnOk: TUniBitBtn
      Left = 143
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
      Left = 56
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
    Left = 17
    Top = 18
    Width = 177
    Height = 13
    Hint = ''
    Caption = #1042#1077#1089' '#1092#1080#1079' '#1087#1086' '#1076#1072#1085#1085#1099#1084' '#1087#1077#1088#1077#1074#1086#1079#1095#1080#1082#1072
    TabOrder = 1
  end
  object edtTransporterWeightKG: TUniFormattedNumberEdit
    Left = 19
    Top = 37
    Width = 121
    Height = 25
    Hint = ''
    ParentFont = False
    Font.Height = -13
    TabOrder = 2
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object edtTransporterVolumeKG: TUniFormattedNumberEdit
    Left = 19
    Top = 97
    Width = 121
    Height = 25
    Hint = ''
    ParentFont = False
    Font.Height = -13
    TabOrder = 3
    DecimalSeparator = ','
    ThousandSeparator = #160
  end
  object UniLabel2: TUniLabel
    Left = 19
    Top = 78
    Width = 213
    Height = 13
    Hint = ''
    Caption = #1042#1077#1089' '#1086#1073#1098#1077#1084#1085#1099#1081' '#1087#1086' '#1076#1072#1085#1085#1099#1084' '#1087#1077#1088#1077#1074#1086#1079#1095#1080#1082#1072
    TabOrder = 4
  end
end
