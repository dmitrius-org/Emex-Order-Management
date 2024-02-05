object OrdersMessageF: TOrdersMessageF
  Left = 0
  Top = 0
  ClientHeight = 362
  ClientWidth = 488
  Caption = #1050#1088#1084#1084#1077#1085#1090#1072#1088#1080#1081' '#1087#1086' '#1087#1086#1079#1080#1094#1080#1080
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  ShowHint = True
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object tabCommon: TUniFieldContainer
    Left = 0
    Top = 323
    Width = 488
    Height = 39
    Hint = ''
    ShowHint = True
    ParentColor = False
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 203
    ExplicitWidth = 774
    DesignSize = (
      488
      39)
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 309
      Top = 6
      Width = 81
      Height = 27
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1092#1086#1088#1084#1091' '#1041#1045#1047' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      ShowHint = True
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akRight, akBottom]
      TabStop = False
      TabOrder = 2
      OnClick = btnCancelClick
    end
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 395
      Top = 6
      Width = 82
      Height = 27
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1092#1086#1088#1084#1091' '#1080' '#1091#1076#1072#1083#1080#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
      Margins.Right = 30
      ShowHint = True
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 1
      OnClick = btnOkClick
    end
  end
  object edtMessage: TUniMemo
    Left = 0
    Top = 0
    Width = 488
    Height = 323
    Hint = ''
    ShowHint = True
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 774
    ExplicitHeight = 203
  end
end
