object UserRegisterF: TUserRegisterF
  Left = 0
  Top = 0
  ClientHeight = 427
  ClientWidth = 943
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1074' '#1089#1080#1089#1090#1077#1084#1077
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  DesignSize = (
    943
    427)
  TextHeight = 15
  object edtEmail: TUniEdit
    Left = 337
    Top = 138
    Width = 325
    Hint = ''
    Text = ''
    TabOrder = 0
  end
  object edtPassword: TUniEdit
    Left = 337
    Top = 177
    Width = 325
    Hint = ''
    PasswordChar = '*'
    CharEOL = '*'
    Text = ''
    TabOrder = 1
  end
  object btnCancel: TUniButton
    Left = 338
    Top = 235
    Width = 143
    Height = 25
    Hint = ''
    Caption = #1053#1072#1079#1072#1076
    Cancel = True
    Anchors = []
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnOk: TUniButton
    Left = 522
    Top = 235
    Width = 140
    Height = 25
    Hint = ''
    Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100#1089#1103
    Anchors = []
    TabOrder = 3
    ScreenMask.Enabled = True
    ScreenMask.Message = #1054#1087#1077#1088#1072#1094#1080#1103' '#1074#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103' ...'
    ScreenMask.Target = Owner
    OnClick = btnOkClick
  end
  object UniLabel1: TUniLabel
    Left = 257
    Top = 138
    Width = 36
    Height = 13
    Hint = ''
    Caption = #1055#1086#1095#1090#1072':'
    TabOrder = 4
  end
  object UniLabel2: TUniLabel
    Left = 257
    Top = 177
    Width = 43
    Height = 13
    Hint = ''
    Caption = #1055#1072#1088#1086#1083#1100':'
    TabOrder = 5
  end
end
