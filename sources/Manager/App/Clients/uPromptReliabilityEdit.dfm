object PromptReliabilityEdit: TPromptReliabilityEdit
  Left = 0
  Top = 0
  ClientHeight = 118
  ClientWidth = 282
  Caption = #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1085#1072#1094#1077#1085#1082#1080
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object edtReliability: TUniNumberEdit
    Left = 8
    Top = 30
    Width = 264
    Hint = ''
    ParentFont = False
    Font.Height = -13
    TabOrder = 0
    DecimalSeparator = ','
  end
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 83
    Width = 276
    Height = 32
    Hint = ''
    Align = alBottom
    ParentFont = False
    Font.Height = -13
    TabOrder = 1
    BorderStyle = ubsNone
    Caption = ''
    Color = clGradientInactiveCaption
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 188
      Top = 3
      Width = 85
      Height = 26
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Align = alRight
      TabOrder = 2
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 101
      Top = 3
      Width = 81
      Height = 26
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Align = alRight
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
end
