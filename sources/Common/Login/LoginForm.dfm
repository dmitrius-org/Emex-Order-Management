object LoginF: TLoginF
  Left = 0
  Top = 0
  ClientHeight = 349
  ClientWidth = 670
  Caption = #1042#1093#1086#1076' '#1074' '#1089#1080#1089#1090#1077#1084#1091
  OnShow = UniLoginFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Layout = 'fit'
  DesignSize = (
    670
    349)
  TextHeight = 15
  object UniLabel1: TUniLabel
    Left = 154
    Top = 86
    Width = 77
    Height = 13
    Hint = ''
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
    Anchors = []
    TabOrder = 0
  end
  object UniLabel2: TUniLabel
    Left = 152
    Top = 138
    Width = 43
    Height = 13
    Hint = ''
    Caption = #1055#1072#1088#1086#1083#1100':'
    Anchors = []
    TabOrder = 6
  end
  object btnOk: TUniButton
    Left = 389
    Top = 236
    Width = 105
    Height = 25
    Hint = ''
    Caption = #1042#1086#1081#1090#1080
    Anchors = []
    TabOrder = 4
    OnClick = btnOkClick
  end
  object edtUser: TUniEdit
    Left = 269
    Top = 83
    Width = 225
    Hint = ''
    Text = ''
    Anchors = []
    TabOrder = 1
  end
  object edtPas: TUniEdit
    Left = 269
    Top = 134
    Width = 225
    Hint = ''
    PasswordChar = '*'
    CharEOL = '*'
    Text = ''
    Anchors = []
    TabOrder = 2
  end
  object btnCancel: TUniButton
    Left = 269
    Top = 236
    Width = 105
    Height = 25
    Hint = ''
    Caption = #1054#1090#1084#1077#1085#1072
    Cancel = True
    Anchors = []
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object UniCheckBox1: TUniCheckBox
    Left = 269
    Top = 171
    Width = 97
    Height = 17
    Hint = ''
    Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
    TabOrder = 3
  end
end
