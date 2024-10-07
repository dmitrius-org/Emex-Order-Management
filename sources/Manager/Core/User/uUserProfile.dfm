object UserProfile: TUserProfile
  Left = 0
  Top = 0
  ClientHeight = 258
  ClientWidth = 431
  Caption = #1055#1088#1086#1092#1080#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  DesignSize = (
    431
    258)
  TextHeight = 15
  object edtBrief: TUniEdit
    Left = 144
    Top = 48
    Width = 245
    Hint = ''
    Text = ''
    ParentFont = False
    Font.Height = -13
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    ClearButton = True
  end
  object edtName: TUniEdit
    Left = 144
    Top = 76
    Width = 245
    Hint = ''
    Text = ''
    ParentFont = False
    Font.Height = -13
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    ClearButton = True
  end
  object Email: TUniEdit
    Left = 144
    Top = 122
    Width = 245
    Hint = ''
    Text = ''
    ParentFont = False
    Font.Color = clBlack
    Font.Height = -13
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    ClearButton = True
    InputType = 'email'
  end
  object lblName: TUniLabel
    Left = 25
    Top = 48
    Width = 46
    Height = 20
    Hint = ''
    Caption = #1051#1086#1075#1080#1085':'
    ParentFont = False
    Font.Height = -15
    TabOrder = 3
  end
  object lblBrief: TUniLabel
    Left = 25
    Top = 76
    Width = 110
    Height = 20
    Hint = ''
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
    ParentFont = False
    Font.Height = -15
    TabOrder = 4
  end
  object UniLabel5: TUniLabel
    Left = 25
    Top = 122
    Width = 45
    Height = 20
    Hint = ''
    Caption = #1055#1086#1095#1090#1072':'
    ParentFont = False
    Font.Color = clBlack
    Font.Height = -15
    TabOrder = 5
  end
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 217
    Width = 425
    Height = 38
    Hint = ''
    Align = alBottom
    TabOrder = 6
    Caption = ''
    DesignSize = (
      425
      38)
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 335
      Top = 5
      Width = 85
      Height = 28
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight, akBottom]
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 250
      Top = 5
      Width = 81
      Height = 28
      Hint = ''
      Margins.Right = 5
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight, akBottom]
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
end
