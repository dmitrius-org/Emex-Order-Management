object frmComboValues: TfrmComboValues
  Left = 0
  Top = 0
  ClientHeight = 333
  ClientWidth = 358
  Caption = 'Exmplo Combo Values'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object btnLoadCombo: TUniBitBtn
    Left = 40
    Top = 40
    Width = 273
    Height = 41
    Hint = ''
    Caption = 'Load Combo'
    ParentFont = False
    Font.Height = -16
    TabOrder = 0
    OnClick = btnLoadComboClick
  end
  object cmb1: TUniFSComboBox
    Left = 40
    Top = 112
    Width = 273
    Height = 27
    Hint = ''
    Text = ''
    ParentFont = False
    Font.Height = -16
    TabOrder = 1
    OnCloseUp = cmb1CloseUp
  end
  object btnGetValue: TUniBitBtn
    Left = 40
    Top = 160
    Width = 273
    Height = 41
    Hint = ''
    Caption = 'Get Value'
    ParentFont = False
    Font.Height = -16
    TabOrder = 2
    OnClick = btnGetValueClick
  end
  object btnSetValue: TUniBitBtn
    Left = 40
    Top = 224
    Width = 273
    Height = 41
    Hint = ''
    Caption = 'SetValue - RS'
    ParentFont = False
    Font.Height = -16
    TabOrder = 3
    OnClick = btnSetValueClick
  end
end
