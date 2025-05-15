object GroupSetFragileSignF: TGroupSetFragileSignF
  Left = 0
  Top = 0
  ClientHeight = 161
  ClientWidth = 384
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
    Width = 384
    Height = 161
    Hint = ''
    ShowHint = True
    ParentColor = False
    Align = alClient
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 0
    DesignSize = (
      384
      161)
    object lblDetailNameF: TUniLabel
      Left = 21
      Top = 21
      Width = 49
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1055#1088#1080#1079#1085#1072#1082':'
      TabOrder = 1
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 196
      Top = 126
      Width = 81
      Height = 27
      Hint = ''
      ShowHint = True
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akRight, akBottom]
      TabStop = False
      TabOrder = 3
      OnClick = btnCancelClick
    end
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 283
      Top = 126
      Width = 82
      Height = 27
      Hint = ''
      Margins.Right = 30
      ShowHint = True
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 4
      OnClick = btnOkClick
    end
    object cbRestrictions: TUniComboBox
      Left = 21
      Top = 40
      Width = 350
      Hint = ''
      ShowHint = True
      Text = ''
      Items.Strings = (
        'Fragile')
      TabOrder = 2
      TabStop = False
      IconItems = <>
    end
  end
end
