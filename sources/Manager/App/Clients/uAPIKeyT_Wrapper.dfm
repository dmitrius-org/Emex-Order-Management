object APIKeyT_W: TAPIKeyT_W
  Left = 0
  Top = 0
  ClientHeight = 587
  ClientWidth = 1052
  Caption = 'API'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Visible = True
  AlignmentControl = uniAlignmentClient
  OnDestroy = UniFormDestroy
  TextHeight = 15
  object UniButton1: TUniButton
    Left = 944
    Top = 24
    Width = 75
    Height = 25
    Hint = ''
    Caption = 'UniButton1'
    TabOrder = 0
    OnClick = UniButton1Click
  end
  object UniButton2: TUniButton
    Left = 760
    Top = 24
    Width = 75
    Height = 25
    Hint = ''
    Caption = 'UniButton1'
    TabOrder = 1
    OnClick = UniButton2Click
  end
end
