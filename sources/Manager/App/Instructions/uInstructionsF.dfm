object InstructionsF: TInstructionsF
  Left = 0
  Top = 0
  ClientHeight = 244
  ClientWidth = 610
  Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1080
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 197
    Width = 604
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    ExplicitTop = 196
    ExplicitWidth = 600
    DesignSize = (
      604
      44)
    object btnOk: TUniBitBtn
      Left = 479
      Top = 10
      Width = 82
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = btnOkClick
      ExplicitLeft = 475
    end
    object btnCancel: TUniBitBtn
      Left = 392
      Top = 10
      Width = 81
      Height = 25
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = btnCancelClick
      ExplicitLeft = 388
    end
  end
  object fsCommon: TUniFieldSet
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 604
    Height = 182
    Hint = ''
    Title = #1054#1073#1097#1080#1077' '#1089#1074#1077#1076#1077#1085#1080#1103
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 600
    object UniFieldContainer1: TUniFieldContainer
      Left = 2
      Top = 15
      Width = 600
      Height = 146
      Hint = ''
      ParentColor = False
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 596
      DesignSize = (
        600
        146)
      object edtName: TUniEdit
        Left = 150
        Top = 26
        Width = 413
        Hint = ''
        Text = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        ClearButton = True
        ExplicitWidth = 409
      end
      object UniLabel1: TUniLabel
        Left = 31
        Top = 29
        Width = 84
        Height = 13
        Hint = ''
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        TabOrder = 2
      end
      object UniLabel2: TUniLabel
        Left = 31
        Top = 70
        Width = 57
        Height = 13
        Hint = ''
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
        TabOrder = 3
      end
      object edtComment: TUniMemo
        Left = 150
        Top = 54
        Width = 413
        Height = 67
        Hint = ''
        TabOrder = 4
      end
    end
  end
end
