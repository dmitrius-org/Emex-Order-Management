object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 203
  ClientWidth = 348
  Caption = 'MainForm'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object btnExemplo1: TUniBitBtn
    Left = 40
    Top = 40
    Width = 273
    Height = 41
    Hint = ''
    Caption = 'Combo Values'
    ParentFont = False
    Font.Height = -16
    TabOrder = 0
    OnClick = btnExemplo1Click
  end
  object btnExemplo2: TUniBitBtn
    Left = 40
    Top = 104
    Width = 273
    Height = 41
    Hint = ''
    Caption = 'Combo com DataSource'
    ParentFont = False
    Font.Height = -16
    TabOrder = 1
    OnClick = btnExemplo2Click
  end
end
