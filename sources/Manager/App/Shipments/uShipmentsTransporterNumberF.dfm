object ShipmentsTransporterNumberF: TShipmentsTransporterNumberF
  Left = 0
  Top = 0
  ClientHeight = 141
  ClientWidth = 284
  Caption = #1053#1086#1084#1077#1088' '#1075#1088#1091#1079#1072
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnReady = UniFormReady
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
  object edtNum: TUniEdit
    Left = 89
    Top = 42
    Width = 106
    Height = 28
    Hint = ''
    BorderStyle = ubsSolid
    Text = ''
    ParentFont = False
    Font.Height = -13
    TabOrder = 1
    InputMask.Mask = '\d'
    FieldLabelWidth = 200
    FieldLabelAlign = laTop
    InputType = 'number'
  end
  object edtNumS: TUniLabel
    Left = 29
    Top = 48
    Width = 57
    Height = 17
    Hint = ''
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'edtNumS'
    ParentFont = False
    Font.Height = -13
    Font.Style = [fsBold]
    TabOrder = 2
  end
  object UniLabel1: TUniLabel
    Left = 17
    Top = 18
    Width = 112
    Height = 13
    Hint = ''
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1084#1077#1088' '#1075#1088#1091#1079#1072
    TabOrder = 3
  end
  object edtNumE: TUniLabel
    Left = 197
    Top = 48
    Width = 57
    Height = 17
    Hint = ''
    Caption = 'edtNumE'
    ParentFont = False
    Font.Height = -13
    Font.Style = [fsBold]
    TabOrder = 4
  end
end
