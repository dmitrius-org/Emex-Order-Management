object NodesF: TNodesF
  Left = 0
  Top = 0
  ClientHeight = 291
  ClientWidth = 610
  Caption = #1057#1090#1072#1090#1091#1089#1099
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 244
    Width = 604
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    ExplicitTop = 245
    ExplicitWidth = 619
    DesignSize = (
      604
      44)
    object btnOk: TUniBitBtn
      Left = 487
      Top = 10
      Width = 82
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = btnOkClick
      ExplicitLeft = 503
    end
    object btnCancel: TUniBitBtn
      Left = 400
      Top = 10
      Width = 81
      Height = 25
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = btnCancelClick
      ExplicitLeft = 416
    end
  end
  object fsCommon: TUniFieldSet
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 604
    Height = 199
    Hint = ''
    Title = #1054#1073#1097#1080#1077' '#1089#1074#1077#1076#1077#1085#1080#1103
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 619
    object UniFieldContainer1: TUniFieldContainer
      Left = 2
      Top = 15
      Width = 604
      Height = 167
      Hint = ''
      ParentColor = False
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 615
      DesignSize = (
        600
        167)
      object edtBrief: TUniEdit
        Left = 150
        Top = 70
        Width = 417
        Hint = ''
        Text = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        ClearButton = True
        ExplicitWidth = 433
      end
      object edtName: TUniEdit
        Left = 150
        Top = 98
        Width = 417
        Hint = ''
        Text = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        ClearButton = True
        ExplicitWidth = 433
      end
      object edtComment: TUniEdit
        Left = 150
        Top = 126
        Width = 417
        Hint = ''
        Text = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 3
        ClearButton = True
        ExplicitWidth = 433
      end
      object lblBruef: TUniLabel
        Left = 31
        Top = 70
        Width = 71
        Height = 13
        Hint = ''
        Caption = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077':'
        TabOrder = 4
      end
      object UniLabel1: TUniLabel
        Left = 31
        Top = 98
        Width = 84
        Height = 13
        Hint = ''
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        TabOrder = 5
      end
      object UniLabel2: TUniLabel
        Left = 31
        Top = 126
        Width = 57
        Height = 13
        Hint = ''
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
        TabOrder = 6
      end
      object edtType: TUniRadioGroup
        Left = 150
        Top = 3
        Width = 314
        Height = 61
        Hint = ''
        Items.Strings = (
          #1057#1086#1089#1090#1086#1103#1085#1080#1077
          #1044#1077#1081#1089#1090#1074#1080#1077)
        Caption = #1058#1080#1087
        TabOrder = 7
        Columns = 2
      end
    end
  end
end
