object ConfluencePagesF: TConfluencePagesF
  Left = 0
  Top = 0
  ClientHeight = 260
  ClientWidth = 623
  Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1080
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 213
    Width = 617
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    DesignSize = (
      617
      44)
    object btnOk: TUniBitBtn
      Left = 495
      Top = 10
      Width = 82
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = btnOkClick
      ExplicitLeft = 491
    end
    object btnCancel: TUniBitBtn
      Left = 402
      Top = 10
      Width = 87
      Height = 25
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = btnCancelClick
      ExplicitLeft = 398
    end
    object AuditPanel: TUniPanel
      Left = 1
      Top = 1
      Width = 416
      Height = 42
      Hint = ''
      Align = alLeft
      TabOrder = 3
      BorderStyle = ubsNone
      ShowCaption = False
      Caption = 'AuditPanel'
      object lblUserName: TUniLabel
        Left = 16
        Top = 5
        Width = 52
        Height = 12
        Hint = ''
        Caption = 'lblUserName'
        ParentFont = False
        Font.Color = clGray
        Font.Height = -9
        TabOrder = 1
      end
      object lblInDateTime: TUniLabel
        Left = 16
        Top = 24
        Width = 39
        Height = 12
        Hint = ''
        Caption = 'UniLabel3'
        ParentFont = False
        Font.Color = clGray
        Font.Height = -9
        TabOrder = 2
      end
    end
  end
  object fsCommon: TUniFieldSet
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 617
    Height = 204
    Hint = ''
    Title = #1054#1073#1097#1080#1077' '#1089#1074#1077#1076#1077#1085#1080#1103
    Align = alClient
    TabOrder = 1
    object UniFieldContainer1: TUniFieldContainer
      Left = 2
      Top = 15
      Width = 613
      Height = 122
      Hint = ''
      ParentColor = False
      Align = alTop
      TabOrder = 1
      DesignSize = (
        613
        122)
      object edtName: TUniEdit
        Left = 120
        Top = 12
        Width = 471
        Hint = ''
        Text = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        ClearButton = True
        ExplicitWidth = 467
      end
      object UniLabel1: TUniLabel
        Left = 15
        Top = 14
        Width = 84
        Height = 13
        Hint = ''
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        TabOrder = 2
      end
      object UniLabel2: TUniLabel
        Left = 15
        Top = 43
        Width = 57
        Height = 13
        Hint = ''
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
        TabOrder = 3
      end
      object edtComment: TUniMemo
        Left = 120
        Top = 40
        Width = 471
        Height = 67
        Hint = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 4
      end
    end
  end
end
