object UserF: TUserF
  Left = 0
  Top = 0
  ClientHeight = 351
  ClientWidth = 602
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
  OnShow = UniFormShow
  BorderStyle = bsDialog
  Position = poDesktopCenter
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 314
    Width = 596
    Height = 34
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    DesignSize = (
      596
      34)
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 476
      Top = 4
      Width = 85
      Height = 26
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight, akBottom]
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 392
      Top = 4
      Width = 81
      Height = 26
      Hint = ''
      Margins.Right = 5
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight, akBottom]
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
  object fsCommon: TUniFieldSet
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 596
    Height = 219
    Hint = ''
    Title = #1054#1073#1097#1080#1077' '#1089#1074#1077#1076#1077#1085#1080#1103
    Align = alTop
    TabOrder = 1
    Font.Color = clBlack
    Font.Height = -12
    ParentFont = False
    object UniFieldContainer1: TUniFieldContainer
      Left = 2
      Top = 15
      Width = 592
      Height = 198
      Hint = ''
      ParentColor = False
      Align = alTop
      TabOrder = 1
      DesignSize = (
        592
        198)
      object edtBrief: TUniEdit
        Left = 144
        Top = 16
        Width = 416
        Hint = ''
        Text = ''
        ParentFont = False
        Font.Height = -12
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        ClearButton = True
      end
      object edtName: TUniEdit
        Left = 144
        Top = 44
        Width = 416
        Hint = ''
        Text = ''
        ParentFont = False
        Font.Height = -12
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        ClearButton = True
      end
      object cbIsActive: TUniCheckBox
        Left = 144
        Top = 104
        Width = 138
        Height = 17
        Hint = ''
        Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
        ParentFont = False
        Font.Height = -12
        TabOrder = 3
        ReadOnly = True
      end
      object cbIsBlock: TUniCheckBox
        Left = 144
        Top = 132
        Width = 138
        Height = 17
        Hint = ''
        Caption = #1047#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085
        ParentFont = False
        Font.Height = -12
        TabOrder = 4
      end
      object edtDataBlock: TUniDateTimePicker
        Left = 415
        Top = 129
        Width = 145
        Hint = ''
        DateTime = 45099.000000000000000000
        DateFormat = 'dd.MM.yyyy'
        TimeFormat = 'HH:mm:ss'
        ReadOnly = True
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 5
        ParentFont = False
        Font.Height = -12
        ClearButton = True
      end
      object lblBrief: TUniLabel
        Left = 25
        Top = 44
        Width = 84
        Height = 13
        Hint = ''
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        ParentFont = False
        Font.Height = -12
        TabOrder = 6
      end
      object lblName: TUniLabel
        Left = 25
        Top = 16
        Width = 36
        Height = 13
        Hint = ''
        Caption = #1051#1086#1075#1080#1085':'
        ParentFont = False
        Font.Height = -12
        TabOrder = 7
      end
      object lbDateBlock: TUniLabel
        Left = 294
        Top = 132
        Width = 97
        Height = 13
        Hint = ''
        Caption = #1044#1072#1090#1072' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080':'
        ParentFont = False
        Font.Height = -12
        TabOrder = 8
      end
      object edtPass: TUniEdit
        Left = 144
        Top = 72
        Width = 209
        Hint = ''
        ShowHint = True
        ParentShowHint = False
        MaxLength = 128
        Text = ''
        ParentFont = False
        Font.Height = -12
        TabOrder = 9
        ClearButton = True
      end
      object lblPass: TUniLabel
        Left = 25
        Top = 72
        Width = 43
        Height = 13
        Hint = ''
        Caption = #1055#1072#1088#1086#1083#1100':'
        ParentFont = False
        Font.Height = -12
        TabOrder = 10
      end
      object Email: TUniEdit
        Left = 144
        Top = 157
        Width = 416
        Hint = ''
        Text = ''
        ParentFont = False
        Font.Color = clBlack
        Font.Height = -12
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 11
        ClearButton = True
        InputType = 'email'
      end
      object UniLabel5: TUniLabel
        Left = 25
        Top = 157
        Width = 36
        Height = 13
        Hint = ''
        Caption = #1055#1086#1095#1090#1072':'
        ParentFont = False
        Font.Color = clBlack
        Font.Height = -12
        TabOrder = 12
      end
    end
  end
  object fsAudit: TUniFieldSet
    AlignWithMargins = True
    Left = 3
    Top = 228
    Width = 596
    Height = 80
    Hint = ''
    Title = #1040#1091#1076#1080#1090
    Collapsible = True
    Align = alBottom
    LayoutConfig.Region = 'south'
    TabOrder = 2
    object UniFieldContainer2: TUniFieldContainer
      Left = 2
      Top = 15
      Width = 592
      Height = 63
      Hint = ''
      ParentColor = False
      Align = alClient
      TabOrder = 1
      DesignSize = (
        592
        63)
      object edtID: TUniEdit
        Left = 141
        Top = 7
        Width = 138
        Hint = ''
        Text = ''
        TabOrder = 1
        ReadOnly = True
      end
      object edtInDate: TUniDateTimePicker
        Left = 141
        Top = 34
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
        Top = 34
        Width = 145
        Hint = ''
        DateTime = 45098.000000000000000000
        DateFormat = 'dd.MM.yyyy'
        TimeFormat = 'HH:mm:ss'
        ReadOnly = True
        Anchors = [akLeft, akTop, akRight]
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
