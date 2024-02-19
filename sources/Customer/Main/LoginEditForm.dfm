object LoginEditF: TLoginEditF
  Left = 0
  Top = 0
  ClientHeight = 200
  ClientWidth = 455
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1072#1088#1086#1083#1103
  BorderStyle = bsDialog
  Position = poDesktopCenter
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  DesignSize = (
    455
    200)
  TextHeight = 15
  object UniLabel2: TUniLabel
    Left = 41
    Top = 31
    Width = 90
    Height = 13
    Hint = ''
    Caption = #1058#1077#1082#1091#1097#1080#1081' '#1087#1072#1088#1086#1083#1100':'
    Anchors = []
    TabOrder = 0
    ExplicitLeft = 40
  end
  object edtPas: TUniEdit
    Left = 165
    Top = 31
    Width = 225
    Hint = ''
    CharEOL = '*'
    Text = ''
    Anchors = []
    TabOrder = 1
    EmptyText = #1042#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1091#1097#1080#1081' '#1087#1072#1088#1086#1083#1100
    ClearButton = True
    ExplicitLeft = 163
  end
  object UniPanel: TUniPanel
    Left = 0
    Top = 160
    Width = 455
    Height = 40
    Hint = ''
    Align = alBottom
    TabOrder = 2
    Caption = ''
    ExplicitTop = 159
    ExplicitWidth = 451
    DesignSize = (
      455
      40)
    object btnOk: TUniButton
      Left = 281
      Top = 6
      Width = 110
      Height = 28
      Hint = ''
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Anchors = []
      TabOrder = 1
      OnClick = btnOkClick
      ExplicitLeft = 278
    end
    object btnCancel: TUniButton
      Left = 167
      Top = 6
      Width = 107
      Height = 28
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Cancel = True
      Anchors = []
      TabOrder = 2
      OnClick = btnCancelClick
      ExplicitLeft = 165
    end
  end
  object UniLabel1: TUniLabel
    Left = 45
    Top = 80
    Width = 81
    Height = 13
    Hint = ''
    Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
    Anchors = []
    TabOrder = 3
    ExplicitLeft = 44
  end
  object edtNewPas2: TUniEdit
    Left = 165
    Top = 103
    Width = 225
    Hint = ''
    CharEOL = '*'
    Text = ''
    Anchors = []
    TabOrder = 4
    EmptyText = #1055#1086#1074#1090#1086#1088#1090#1077' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
    ClearButton = True
    ExplicitLeft = 163
    ExplicitTop = 102
  end
  object UniLabel3: TUniLabel
    Left = 45
    Top = 104
    Width = 81
    Height = 13
    Hint = ''
    Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
    Anchors = []
    TabOrder = 5
    ExplicitLeft = 44
    ExplicitTop = 103
  end
  object edtNewPas: TUniEdit
    Left = 165
    Top = 73
    Width = 225
    Hint = ''
    CharEOL = '*'
    Text = ''
    Anchors = []
    TabOrder = 6
    EmptyText = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
    ClearButton = True
    ExplicitLeft = 163
  end
end
