object OrdersNewDeliveryDateF: TOrdersNewDeliveryDateF
  Left = 0
  Top = 0
  ClientHeight = 130
  ClientWidth = 236
  Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1072#1074#1082#1080
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 83
    Width = 230
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    ExplicitWidth = 278
    DesignSize = (
      230
      44)
    object btnOk: TUniBitBtn
      Left = 97
      Top = 5
      Width = 126
      Height = 34
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      Left = 6
      Top = 5
      Width = 85
      Height = 34
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
  object lblDate: TUniLabel
    Left = 9
    Top = 17
    Width = 119
    Height = 13
    Hint = ''
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1076#1072#1090#1091' '#1076#1086#1089#1090#1072#1074#1082#1080
    TabOrder = 1
  end
  object edtDate: TUniDateTimePicker
    Left = 9
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
