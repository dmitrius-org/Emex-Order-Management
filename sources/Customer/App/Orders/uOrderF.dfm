object OrderF: TOrderF
  Left = 0
  Top = 0
  ClientHeight = 187
  ClientWidth = 585
  Caption = #1056#1072#1079#1084#1077#1097#1077#1085#1080#1077' '#1079#1072#1082#1072#1079#1072
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnReady = UniFormReady
  DesignSize = (
    585
    187)
  TextHeight = 15
  object UniPanel1: TUniPanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 585
    Height = 137
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 50
    Align = alClient
    TabOrder = 0
    Caption = ''
    ExplicitLeft = 397
    ExplicitTop = 127
    ExplicitWidth = 256
    ExplicitHeight = 128
    object UniLabel1: TUniLabel
      Left = 94
      Top = 27
      Width = 77
      Height = 17
      Hint = ''
      Caption = #1050#1086#1083'-'#1074#1086' ('#1096#1090'.):'
      ParentFont = False
      Font.Height = -13
      TabOrder = 1
    end
    object lblRowCountL: TUniLabel
      Left = 94
      Top = 71
      Width = 45
      Height = 17
      Hint = ''
      Caption = #1057#1090#1088#1086#1082#1080':'
      ParentFont = False
      Font.Height = -13
      TabOrder = 2
    end
    object UniLabel3: TUniLabel
      Left = 345
      Top = 27
      Width = 42
      Height = 17
      Hint = ''
      Caption = #1057#1091#1084#1084#1072':'
      ParentFont = False
      Font.Height = -13
      TabOrder = 3
    end
    object UniLabel4: TUniLabel
      Left = 345
      Top = 71
      Width = 23
      Height = 17
      Hint = ''
      Caption = #1042#1077#1089':'
      ParentFont = False
      Font.Height = -13
      TabOrder = 4
    end
    object lblCount: TUniLabel
      Left = 177
      Top = 27
      Width = 48
      Height = 17
      Hint = ''
      Caption = 'lblCount'
      ParentFont = False
      Font.Height = -13
      TabOrder = 5
    end
    object lblRowCount: TUniLabel
      Left = 177
      Top = 71
      Width = 48
      Height = 17
      Hint = ''
      Caption = 'lblCount'
      ParentFont = False
      Font.Height = -13
      TabOrder = 6
    end
    object lblSum: TUniLabel
      Left = 406
      Top = 27
      Width = 48
      Height = 17
      Hint = ''
      Caption = 'lblCount'
      ParentFont = False
      Font.Height = -13
      TabOrder = 7
    end
    object lblW: TUniLabel
      Left = 406
      Top = 71
      Width = 48
      Height = 17
      Hint = ''
      Caption = 'lblCount'
      ParentFont = False
      Font.Height = -13
      TabOrder = 8
    end
  end
  object btnCancel: TUniBitBtn
    AlignWithMargins = True
    Left = 406
    Top = 152
    Width = 81
    Height = 27
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    Caption = #1054#1090#1084#1077#1085#1072
    Anchors = [akRight, akBottom]
    TabStop = False
    TabOrder = 1
    OnClick = btnCancelClick
    ExplicitLeft = 527
    ExplicitTop = 242
  end
  object btnOk: TUniBitBtn
    AlignWithMargins = True
    Left = 493
    Top = 152
    Width = 82
    Height = 27
    Hint = ''
    Margins.Right = 30
    ShowHint = True
    ParentShowHint = False
    Caption = #1057#1086#1079#1076#1072#1090#1100
    Anchors = [akRight, akBottom]
    TabOrder = 2
    OnClick = btnOkClick
    ExplicitLeft = 614
    ExplicitTop = 242
  end
end
