object OrderF: TOrderF
  Left = 0
  Top = 0
  ClientHeight = 171
  ClientWidth = 551
  Caption = #1056#1072#1079#1084#1077#1097#1077#1085#1080#1077' '#1079#1072#1082#1072#1079#1072
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnReady = UniFormReady
  DesignSize = (
    551
    171)
  TextHeight = 15
  object UniPanel1: TUniPanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 551
    Height = 121
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 50
    Align = alClient
    TabOrder = 0
    Caption = ''
    object UniLabel1: TUniLabel
      Left = 71
      Top = 22
      Width = 89
      Height = 21
      Hint = ''
      Caption = #1050#1086#1083'-'#1074#1086' ('#1096#1090'.):'
      ParentFont = False
      Font.Height = -16
      TabOrder = 1
    end
    object lblRowCountL: TUniLabel
      Left = 71
      Top = 66
      Width = 55
      Height = 21
      Hint = ''
      Caption = #1057#1090#1088#1086#1082#1080':'
      ParentFont = False
      Font.Height = -16
      TabOrder = 5
    end
    object UniLabel3: TUniLabel
      Left = 322
      Top = 22
      Width = 51
      Height = 21
      Hint = ''
      Caption = #1057#1091#1084#1084#1072':'
      ParentFont = False
      Font.Height = -16
      TabOrder = 3
    end
    object UniLabel4: TUniLabel
      Left = 322
      Top = 66
      Width = 27
      Height = 21
      Hint = ''
      Caption = #1042#1077#1089':'
      ParentFont = False
      Font.Height = -16
      TabOrder = 7
    end
    object lblCount: TUniLabel
      Left = 169
      Top = 22
      Width = 59
      Height = 21
      Hint = ''
      Caption = 'lblCount'
      ParentFont = False
      Font.Height = -16
      TabOrder = 2
    end
    object lblRowCount: TUniLabel
      Left = 169
      Top = 66
      Width = 90
      Height = 21
      Hint = ''
      Caption = 'lblRowCount'
      ParentFont = False
      Font.Height = -16
      TabOrder = 6
    end
    object lblSum: TUniLabel
      Left = 398
      Top = 22
      Width = 49
      Height = 21
      Hint = ''
      Caption = 'lblSum'
      ParentFont = False
      Font.Height = -16
      TabOrder = 4
    end
    object lblW: TUniLabel
      Left = 398
      Top = 66
      Width = 32
      Height = 21
      Hint = ''
      Caption = 'lblW'
      ParentFont = False
      Font.Height = -16
      TabOrder = 8
    end
  end
  object btnCancel: TUniBitBtn
    AlignWithMargins = True
    Left = 354
    Top = 127
    Width = 81
    Height = 35
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    Caption = #1054#1090#1084#1077#1085#1072
    Anchors = [akRight, akBottom]
    TabStop = False
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnOk: TUniBitBtn
    AlignWithMargins = True
    Left = 441
    Top = 127
    Width = 103
    Height = 35
    Hint = ''
    Margins.Right = 30
    ShowHint = True
    ParentShowHint = False
    Caption = #1057#1086#1079#1076#1072#1090#1100
    Anchors = [akRight, akBottom]
    TabOrder = 2
    OnClick = btnOkClick
  end
end
