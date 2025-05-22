object GroupSetFragileSignF: TGroupSetFragileSignF
  Left = 0
  Top = 0
  ClientHeight = 120
  ClientWidth = 332
  Caption = #1043#1088#1091#1087#1087#1086#1074#1086#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1088#1080#1079#1085#1072#1082#1072' Fragile'
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  ShowHint = True
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object tabCommon: TUniFieldContainer
    Left = 0
    Top = 0
    Width = 332
    Height = 120
    Hint = ''
    ShowHint = True
    ParentColor = False
    Align = alClient
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 0
    ExplicitWidth = 384
    ExplicitHeight = 161
    DesignSize = (
      332
      120)
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 144
      Top = 85
      Width = 81
      Height = 27
      Hint = ''
      ShowHint = True
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akRight, akBottom]
      TabStop = False
      TabOrder = 1
      OnClick = btnCancelClick
      ExplicitLeft = 196
      ExplicitTop = 126
    end
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 231
      Top = 85
      Width = 82
      Height = 27
      Hint = ''
      Margins.Right = 30
      ShowHint = True
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 2
      OnClick = btnOkClick
      ExplicitLeft = 283
      ExplicitTop = 126
    end
    object chFragile: TUniCheckBox
      Left = 29
      Top = 16
      Width = 140
      Height = 33
      Hint = ''
      ShowHint = True
      Caption = #1061#1088#1091#1087#1082#1080#1081
      ParentFont = False
      Font.Height = -17
      TabOrder = 3
    end
  end
end
