object OrdersMessageF: TOrdersMessageF
  Left = 0
  Top = 0
  ClientHeight = 362
  ClientWidth = 488
  Caption = #1053#1072#1087#1080#1089#1072#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077' '#1082#1083#1080#1077#1085#1090#1091
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
    ExplicitTop = 310
    ExplicitWidth = 491
    DesignSize = (
      488
      39)
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 309
      Top = 6
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
      Left = 395
      Top = 6
      Width = 82
      Height = 27
      Hint = ''
      Margins.Right = 30
      ShowHint = True
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 1
      OnClick = btnOkClick
      ExplicitLeft = 398
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
    ClearButton = True
    ExplicitWidth = 491
    ExplicitHeight = 310
  end
end
