object GroupDetailNameEditF: TGroupDetailNameEditF
  Left = 0
  Top = 0
  ClientHeight = 172
  ClientWidth = 671
  Caption = #1043#1088#1091#1087#1087#1086#1074#1086#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103' '#1076#1077#1090#1072#1083#1080
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  ShowHint = True
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object tabCommon: TUniFieldContainer
    Left = 0
    Top = 0
    Width = 671
    Height = 310
    Hint = ''
    ShowHint = True
    ParentColor = False
    Align = alTop
    TabOrder = 0
    DesignSize = (
      671
      310)
    object edtDetailName: TUniEdit
      Left = 21
      Top = 40
      Width = 610
      Hint = ''
      ShowHint = True
      Text = ''
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      ClearButton = True
    end
    object lblDetailNameF: TUniLabel
      Left = 21
      Top = 21
      Width = 84
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      TabOrder = 1
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 462
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
      Left = 549
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
  end
end
