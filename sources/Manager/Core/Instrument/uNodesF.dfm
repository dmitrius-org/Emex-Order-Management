object NodesF: TNodesF
  Left = 0
  Top = 0
  ClientHeight = 291
  ClientWidth = 621
  Caption = #1057#1090#1072#1090#1091#1089#1099
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 244
    Width = 615
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    ExplicitWidth = 604
    DesignSize = (
      615
      44)
    object btnOk: TUniBitBtn
      Left = 498
      Top = 10
      Width = 82
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = btnOkClick
      ExplicitLeft = 487
    end
    object btnCancel: TUniBitBtn
      Left = 411
      Top = 10
      Width = 81
      Height = 25
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = btnCancelClick
      ExplicitLeft = 400
    end
  end
  object PageBase: TUniPageControl
    Left = 0
    Top = 0
    Width = 621
    Height = 241
    Hint = ''
    ActivePage = TabCommon
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 56
    ExplicitTop = 56
    ExplicitWidth = 289
    ExplicitHeight = 193
    object TabCommon: TUniTabSheet
      Hint = ''
      Caption = #1043#1083#1072#1074#1085#1072#1103
      ExplicitWidth = 281
      ExplicitHeight = 165
      object UniFieldContainer1: TUniFieldContainer
        Left = 0
        Top = 0
        Width = 613
        Height = 217
        Hint = ''
        ParentColor = False
        Align = alTop
        TabOrder = 0
        ExplicitTop = -52
        ExplicitWidth = 281
        DesignSize = (
          613
          217)
        object edtBrief: TUniEdit
          Left = 150
          Top = 70
          Width = 429
          Hint = ''
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          ClearButton = True
        end
        object edtName: TUniEdit
          Left = 150
          Top = 98
          Width = 429
          Hint = ''
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          ClearButton = True
        end
        object edtComment: TUniEdit
          Left = 150
          Top = 126
          Width = 429
          Hint = ''
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          ClearButton = True
        end
        object lblBruef: TUniLabel
          Left = 21
          Top = 70
          Width = 71
          Height = 13
          Hint = ''
          Caption = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077':'
          TabOrder = 4
        end
        object UniLabel1: TUniLabel
          Left = 21
          Top = 98
          Width = 84
          Height = 13
          Hint = ''
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
          TabOrder = 5
        end
        object UniLabel2: TUniLabel
          Left = 21
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
          OnChangeValue = edtTypeChangeValue
        end
        object edtN: TUniNumberEdit
          Left = 150
          Top = 154
          Width = 122
          Hint = ''
          TabOrder = 8
          BlankValue = 0
          DecimalSeparator = ','
        end
        object UniLabel3: TUniLabel
          Left = 21
          Top = 157
          Width = 109
          Height = 13
          Hint = ''
          Caption = #1055#1086#1088#1103#1076#1082#1086#1074#1099#1081' '#1085#1086#1084#1077#1088':'
          TabOrder = 9
        end
      end
    end
    object TabStateAdditionally: TUniTabSheet
      Hint = ''
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1087#1088#1080#1079#1085#1072#1082#1080' '#1089#1086#1089#1090#1086#1103#1085#1080#1103
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 621
      ExplicitHeight = 241
      object cbSyncEmex: TUniCheckBox
        Left = 18
        Top = 15
        Width = 263
        Height = 17
        Hint = ''
        Caption = #1042#1099#1087#1086#1083#1085#1103#1090#1100' '#1089#1080#1085#1093#1088#1086#1085#1080#1079#1072#1094#1080#1102' '#1089' emex'
        TabOrder = 0
      end
      object cbRecalClientDelivery: TUniCheckBox
        Left = 18
        Top = 38
        Width = 287
        Height = 17
        Hint = ''
        Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1099#1074#1072#1090#1100' '#1076#1072#1090#1099' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1082#1083#1080#1077#1085#1090#1072
        TabOrder = 1
      end
      object cbRecalSupplierDelivery: TUniCheckBox
        Left = 18
        Top = 61
        Width = 287
        Height = 17
        Hint = ''
        Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1099#1074#1072#1090#1100' '#1076#1072#1090#1099' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
        TabOrder = 2
      end
      object cbSyncSupplier: TUniCheckBox
        Left = 18
        Top = 84
        Width = 287
        Height = 17
        Hint = #1055#1088#1077#1082#1088#1072#1090#1080#1090#1100' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1089#1080#1085#1093#1088#1086#1085#1080#1079#1072#1094#1080#1080' '#1089' '#1055#1086#1089#1090#1072#1074#1082#1072#1084#1080
        Caption = #1053#1077' '#1089#1080#1085#1093#1088#1086#1085#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1089' '#1055#1086#1089#1090#1072#1074#1082#1072#1084#1080
        TabOrder = 3
      end
    end
  end
end
