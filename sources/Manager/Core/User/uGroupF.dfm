object GroupF: TGroupF
  Left = 0
  Top = 0
  ClientHeight = 350
  ClientWidth = 602
  Caption = #1043#1088#1091#1087#1087#1072
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 313
    Width = 596
    Height = 34
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    ExplicitTop = 312
    ExplicitWidth = 592
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 507
      Top = 4
      Width = 85
      Height = 26
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Align = alRight
      TabOrder = 1
      OnClick = btnOkClick
      ExplicitLeft = 503
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 420
      Top = 4
      Width = 81
      Height = 26
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Align = alRight
      TabOrder = 2
      OnClick = btnCancelClick
      ExplicitLeft = 416
    end
  end
  object fsCommon: TUniFieldSet
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 596
    Height = 172
    Hint = ''
    Title = #1054#1073#1097#1080#1077' '#1089#1074#1077#1076#1077#1085#1080#1103
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 592
    object UniFieldContainer1: TUniFieldContainer
      Left = 2
      Top = 15
      Width = 592
      Height = 143
      Hint = ''
      ParentColor = False
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 588
      DesignSize = (
        592
        143)
      object edtBrief: TUniEdit
        Left = 144
        Top = 16
        Width = 416
        Hint = ''
        Text = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        ClearButton = True
        ExplicitWidth = 412
      end
      object edtName: TUniEdit
        Left = 144
        Top = 44
        Width = 416
        Hint = ''
        Text = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        ClearButton = True
        ExplicitWidth = 412
      end
      object lblBrief: TUniLabel
        Left = 25
        Top = 44
        Width = 84
        Height = 13
        Hint = ''
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        TabOrder = 3
      end
      object lblName: TUniLabel
        Left = 25
        Top = 16
        Width = 71
        Height = 13
        Hint = ''
        Caption = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077':'
        TabOrder = 4
      end
    end
  end
  object fsAudit: TUniFieldSet
    AlignWithMargins = True
    Left = 3
    Top = 227
    Width = 596
    Height = 80
    Hint = ''
    Title = #1040#1091#1076#1080#1090
    Collapsible = True
    Align = alBottom
    LayoutConfig.Region = 'south'
    TabOrder = 2
    ExplicitTop = 226
    ExplicitWidth = 592
    object UniFieldContainer2: TUniFieldContainer
      Left = 2
      Top = 15
      Width = 592
      Height = 63
      Hint = ''
      ParentColor = False
      Align = alClient
      TabOrder = 1
      ExplicitWidth = 588
      object edtID: TUniEdit
        Left = 141
        Top = 8
        Width = 138
        Hint = ''
        Text = ''
        TabOrder = 1
        ReadOnly = True
      end
      object edtInDate: TUniDateTimePicker
        Left = 141
        Top = 33
        Width = 138
        Hint = ''
        DateTime = 45098.000000000000000000
        DateFormat = 'dd.MM.yyyy'
        TimeFormat = 'HH:mm:ss'
        ReadOnly = True
        TabOrder = 2
        DateMode = dtmDateTime
      end
      object edtUpdDate: TUniDateTimePicker
        Left = 415
        Top = 33
        Width = 145
        Hint = ''
        DateTime = 45098.000000000000000000
        DateFormat = 'dd.MM.yyyy'
        TimeFormat = 'HH:mm:ss'
        ReadOnly = True
        TabOrder = 3
        DateMode = dtmDateTime
      end
      object UniLabel1: TUniLabel
        Left = 25
        Top = 10
        Width = 89
        Height = 13
        Hint = ''
        Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088':'
        TabOrder = 4
      end
      object UniLabel2: TUniLabel
        Left = 25
        Top = 37
        Width = 80
        Height = 13
        Hint = ''
        Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103':'
        TabOrder = 5
      end
      object UniLabel3: TUniLabel
        Left = 302
        Top = 38
        Width = 90
        Height = 13
        Hint = ''
        Caption = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103':'
        TabOrder = 6
      end
    end
  end
end
