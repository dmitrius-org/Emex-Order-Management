object GroupSetFragileSignF: TGroupSetFragileSignF
  Left = 0
  Top = 0
  ClientHeight = 169
  ClientWidth = 460
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
    Width = 460
    Height = 310
    Hint = ''
    ShowHint = True
    ParentColor = False
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 667
    DesignSize = (
      460
      310)
    object lblDetailNameF: TUniLabel
      Left = 21
      Top = 21
      Width = 49
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1055#1088#1080#1079#1085#1072#1082':'
      TabOrder = 3
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 272
      Top = 126
      Width = 81
      Height = 27
      Hint = ''
      ShowHint = True
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akRight, akBottom]
      TabStop = False
      TabOrder = 2
      OnClick = btnCancelClick
    end
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 359
      Top = 126
      Width = 82
      Height = 27
      Hint = ''
      Margins.Right = 30
      ShowHint = True
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 1
      OnClick = btnOkClick
    end
    object cbRestrictions: TUniComboBox
      Left = 21
      Top = 40
      Width = 420
      Hint = ''
      ShowHint = True
      Text = ''
      Items.Strings = (
        'Fragile')
      TabOrder = 4
      TabStop = False
      IconItems = <>
    end
  end
end
