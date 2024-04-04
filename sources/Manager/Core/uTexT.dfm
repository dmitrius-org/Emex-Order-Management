object TexT: TTexT
  Left = 0
  Top = 0
  Width = 938
  Height = 480
  OnReady = UniFrameReady
  Layout = 'fit'
  LayoutConfig.Width = '0'
  TabOrder = 0
  object UniGroupBox1: TUniGroupBox
    Left = 0
    Top = 0
    Width = 938
    Height = 81
    Hint = ''
    AlignmentControl = uniAlignmentClient
    Caption = #1047#1072#1087#1088#1086#1089' '#1089#1090#1072#1090#1091#1089#1072' '#1087#1086' '#1086#1076#1085#1086#1084#1091' '#1079#1072#1103#1074#1082#1080
    Align = alTop
    LayoutConfig.IgnorePosition = False
    LayoutConfig.Width = '0'
    TabOrder = 0
    object lblordernum: TUniLabel
      Left = 16
      Top = 24
      Width = 105
      Height = 13
      Hint = ''
      Caption = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072' Emex:'
      TabOrder = 4
    end
    object UniLabel1: TUniLabel
      Left = 167
      Top = 24
      Width = 40
      Height = 13
      Hint = ''
      Caption = #1050#1083#1080#1077#1085#1090':'
      TabOrder = 5
    end
    object UniButton1: TUniButton
      Left = 270
      Top = 38
      Width = 133
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1079#1072#1087#1088#1086#1089
      TabOrder = 3
      ScreenMask.Enabled = True
      OnClick = UniButton1Click
    end
    object edtclient: TUniNumberEdit
      Left = 167
      Top = 38
      Width = 61
      Hint = ''
      TabOrder = 2
      Value = 3.000000000000000000
      DecimalSeparator = ','
    end
    object edtOrderNum: TUniNumberEdit
      Left = 16
      Top = 38
      Width = 121
      Hint = ''
      TabOrder = 1
      DecimalSeparator = ','
    end
  end
  object UniGroupBox2: TUniGroupBox
    Left = 0
    Top = 81
    Width = 938
    Height = 81
    Hint = ''
    AlignmentControl = uniAlignmentClient
    Caption = #1047#1072#1087#1088#1086#1089' '#1089#1090#1072#1090#1091#1089#1072' '#1087#1086' '#1089#1086#1089#1090#1086#1103#1085#1080#1102
    Align = alTop
    LayoutConfig.IgnorePosition = False
    LayoutConfig.Width = '0'
    TabOrder = 1
    object UniButton2: TUniButton
      Left = 270
      Top = 34
      Width = 133
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1079#1072#1087#1088#1086#1089
      TabOrder = 3
      ScreenMask.Enabled = True
      OnClick = UniButton2Click
    end
    object UniLabel2: TUniLabel
      Left = 20
      Top = 24
      Width = 65
      Height = 13
      Hint = ''
      Caption = #1057#1090#1072#1090#1091#1089' Emex:'
      TabOrder = 4
    end
    object edtclient2: TUniNumberEdit
      Left = 167
      Top = 38
      Width = 61
      Hint = ''
      TabOrder = 2
      Value = 3.000000000000000000
      DecimalSeparator = ','
    end
    object UniLabel3: TUniLabel
      Left = 167
      Top = 24
      Width = 40
      Height = 13
      Hint = ''
      Caption = #1050#1083#1080#1077#1085#1090':'
      TabOrder = 5
    end
    object cbStatus: TUniComboBox
      Left = 20
      Top = 38
      Width = 117
      Hint = ''
      Text = ''
      TabOrder = 1
      IconItems = <>
    end
  end
  object UniGroupBox3: TUniGroupBox
    Left = 0
    Top = 162
    Width = 938
    Height = 81
    Hint = ''
    AlignmentControl = uniAlignmentClient
    Caption = #1047#1072#1087#1088#1086#1089' '#1082#1086#1088#1079#1080#1085#1099
    Align = alTop
    LayoutConfig.IgnorePosition = False
    LayoutConfig.Width = '0'
    TabOrder = 2
    ExplicitTop = 89
    object UniButton3: TUniButton
      Left = 270
      Top = 34
      Width = 133
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1079#1072#1087#1088#1086#1089
      TabOrder = 2
      ScreenMask.Enabled = True
      OnClick = UniButton2Click
    end
    object edtSuppliersID: TUniNumberEdit
      Left = 167
      Top = 38
      Width = 61
      Hint = ''
      TabOrder = 1
      Value = 3.000000000000000000
      DecimalSeparator = ','
    end
    object UniLabel5: TUniLabel
      Left = 167
      Top = 24
      Width = 62
      Height = 13
      Hint = ''
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
      TabOrder = 3
    end
  end
end
