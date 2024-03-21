object LoginEditF: TLoginEditF
  Left = 0
  Top = 0
  ClientHeight = 201
  ClientWidth = 433
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1072#1088#1086#1083#1103
  BorderStyle = bsDialog
  Position = poDesktopCenter
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  DesignSize = (
    433
    201)
  TextHeight = 15
  object UniLabel2: TUniLabel
    Left = 37
    Top = 31
    Width = 90
    Height = 13
    Hint = ''
    Caption = #1058#1077#1082#1091#1097#1080#1081' '#1087#1072#1088#1086#1083#1100':'
    Anchors = []
    TabOrder = 0
    ExplicitLeft = 46
  end
  object edtPas: TUniEdit
    Left = 166
    Top = 31
    Width = 225
    Hint = ''
    PasswordChar = '*'
    CharEOL = '*'
    Text = ''
    Anchors = []
    TabOrder = 1
    EmptyText = #1042#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1091#1097#1080#1081' '#1087#1072#1088#1086#1083#1100
    ClearButton = True
  end
  object UniPanel: TUniPanel
    Left = 0
    Top = 161
    Width = 433
    Height = 40
    Hint = ''
    Align = alBottom
    TabOrder = 2
    Caption = ''
    ExplicitTop = 160
    ExplicitWidth = 483
    DesignSize = (
      433
      40)
    object btnOk: TUniButton
      Left = 278
      Top = 6
      Width = 113
      Height = 28
      Hint = ''
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Anchors = []
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TUniButton
      Left = 161
      Top = 6
      Width = 107
      Height = 28
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Cancel = True
      Anchors = []
      TabOrder = 2
      OnClick = btnCancelClick
      ExplicitLeft = 186
    end
  end
  object UniLabel1: TUniLabel
    Left = 42
    Top = 79
    Width = 81
    Height = 13
    Hint = ''
    Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
    Anchors = []
    TabOrder = 3
    ExplicitLeft = 51
  end
  object edtNewPas2: TUniEdit
    Left = 166
    Top = 105
    Width = 225
    Hint = ''
    PasswordChar = '*'
    CharEOL = '*'
    Text = ''
    Anchors = []
    TabOrder = 4
    EmptyText = #1055#1086#1074#1090#1086#1088#1090#1077' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
    ClearButton = True
  end
  object UniLabel3: TUniLabel
    Left = 42
    Top = 106
    Width = 81
    Height = 13
    Hint = ''
    Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
    Anchors = []
    TabOrder = 5
    ExplicitLeft = 51
    ExplicitTop = 105
  end
  object edtNewPas: TUniEdit
    Left = 166
    Top = 72
    Width = 225
    Hint = ''
    PasswordChar = '*'
    CharEOL = '*'
    Text = ''
    Anchors = []
    TabOrder = 6
    EmptyText = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
    ClearButton = True
  end
end
