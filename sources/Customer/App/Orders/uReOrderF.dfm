object ReOrder: TReOrder
  Left = 0
  Top = 0
  ClientHeight = 157
  ClientWidth = 620
  Caption = 'ReOrder'
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Images = UniNativeImageList1
  ToolButtons = <
    item
      Action = actRefreshFormData
      ButtonId = 0
      ImageIndex = 1
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
    end>
  OnReady = UniFormReady
  OnDestroy = UniFormDestroy
  DesignSize = (
    620
    157)
  TextHeight = 15
  object UniLabel11: TUniLabel
    Left = 8
    Top = 24
    Width = 52
    Height = 13
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    Caption = #1044#1086#1089#1090#1072#1074#1082#1072':'
    TabOrder = 0
  end
  object cbDestinationLogo: TUniFSComboBox
    Left = 112
    Top = 20
    Width = 500
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    Text = ''
    Anchors = [akLeft, akTop, akRight]
    ParentFont = False
    TabOrder = 1
    AnyMatch = True
    IconItems = <>
    OnChange = cbDestinationLogoChange
    Value = '-1'
  end
  object UniLabel12: TUniLabel
    Left = 8
    Top = 60
    Width = 62
    Height = 13
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
    TabOrder = 2
  end
  object cbPrice: TUniFSComboBox
    Left = 112
    Top = 57
    Width = 500
    Hint = ''
    Enabled = False
    ShowHint = True
    ParentShowHint = False
    Text = ''
    Anchors = [akLeft, akTop, akRight]
    ParentFont = False
    Font.Charset = ANSI_CHARSET
    TabOrder = 3
    AnyMatch = True
    IconItems = <>
    OnChange = cbDestinationLogoChange
    Value = '-1'
  end
  object UniContainerPanel1: TUniContainerPanel
    Left = 0
    Top = 120
    Width = 620
    Height = 37
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    ParentColor = False
    Align = alBottom
    TabOrder = 4
    LayoutConfig.Padding = '2'
    DesignSize = (
      620
      37)
    object edtNextPart: TUniCheckBox
      AlignWithMargins = True
      Left = 16
      Top = 10
      Width = 359
      Height = 16
      Hint = ''
      Enabled = False
      ShowHint = True
      Caption = #1055#1077#1088#1077#1093#1086#1076#1080#1090#1100' '#1082' '#1089#1083#1077#1076#1091#1102#1097#1077#1081' '#1089#1090#1088#1086#1082#1077' '#1087#1086#1089#1083#1077' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103
      Anchors = [akLeft, akBottom]
      TabOrder = 3
    end
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 521
      Top = 5
      Width = 91
      Height = 27
      Hint = ''
      Margins.Right = 30
      Enabled = False
      ShowHint = True
      Caption = #1055#1077#1088#1077#1079#1072#1082#1072#1079#1072#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 1
      ScreenMask.Enabled = True
      ScreenMask.WaitData = True
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 434
      Top = 5
      Width = 81
      Height = 27
      Hint = ''
      ShowHint = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Anchors = [akRight, akBottom]
      TabStop = False
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
  object UniTimer: TUniTimer
    Enabled = False
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimerTimer
    Left = 574
    Top = 92
  end
  object UniActionList1: TUniActionList
    Left = 310
    Top = 89
    object actRefreshFormData: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      OnExecute = actRefreshFormDataExecute
    end
    object actProtocol: TAction
      Caption = #1055#1088#1086#1090#1086#1082#1086#1083
      ImageIndex = 4
      ImageName = 'protocol'
    end
  end
  object UniNativeImageList1: TUniNativeImageList
    Left = 389
    Top = 89
    Images = {
      02000000FFFFFF1F061400000063616C656E6461722D636865636B2D6F3B6661
      3BFFFFFF1F060B000000726566726573683B66613B}
  end
end
