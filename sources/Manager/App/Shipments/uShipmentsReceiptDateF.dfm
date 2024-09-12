object ShipmentsReceiptDateF: TShipmentsReceiptDateF
  Left = 0
  Top = 0
  ClientHeight = 141
  ClientWidth = 284
  Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1076#1072#1090#1091' '#1076#1086#1089#1090#1072#1074#1082#1080
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 94
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
    Width = 119
    Height = 13
    Hint = ''
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1072#1090#1091' '#1076#1086#1089#1090#1072#1074#1082#1080
    TabOrder = 1
  end
  object edtDate: TUniDateTimePicker
    Left = 20
    Top = 37
    Width = 140
    Height = 28
    Hint = ''
    DateTime = 45546.000000000000000000
    DateFormat = 'dd.MM.yyyy'
    TimeFormat = 'HH:mm:ss'
    TabOrder = 2
    ParentFont = False
    Font.Height = -13
    ClearButton = True
  end
end
