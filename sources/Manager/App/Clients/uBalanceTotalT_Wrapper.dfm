object BalanceTotalT_W: TBalanceTotalT_W
  Left = 0
  Top = 0
  ClientHeight = 746
  ClientWidth = 1513
  Caption = 'BalanceTotalT_W'
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  TextHeight = 15
  object UniPanel1: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1507
    Height = 47
    Hint = ''
    Align = alTop
    TabOrder = 0
    ShowCaption = False
    Caption = ''
    DesignSize = (
      1507
      47)
    object cbClient: TUniExComboBox
      Left = 63
      Top = 11
      Width = 367
      Height = 26
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Text = ''
      Anchors = [akLeft, akRight, akBottom]
      ParentFont = False
      Font.Height = -12
      TabOrder = 1
      AnyMatch = True
      ClearButton = True
      IconItems = <>
      OnSelect = cbClientSelect
      Value = '-1'
    end
    object UniLabel6: TUniLabel
      Left = 13
      Top = 14
      Width = 44
      Height = 17
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1050#1083#1080#1077#1085#1090':'
      Anchors = [akLeft, akRight, akBottom]
      ParentFont = False
      Font.Height = -13
      TabOrder = 2
    end
  end
end
