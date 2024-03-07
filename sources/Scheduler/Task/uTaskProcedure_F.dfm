object TaskProcedure_F: TTaskProcedure_F
  Left = 0
  Top = 0
  ClientHeight = 193
  ClientWidth = 654
  Caption = 'TaskProcedure_F'
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  MonitoredKeys.Keys = <>
  DesignSize = (
    654
    193)
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 155
    Width = 648
    Height = 35
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    ExplicitLeft = -263
    ExplicitTop = 407
    ExplicitWidth = 891
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 560
      Top = 4
      Width = 82
      Height = 27
      Hint = ''
      Margins.Right = 5
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Align = alRight
      TabOrder = 1
      OnClick = btnOkClick
      ExplicitLeft = 803
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 473
      Top = 4
      Width = 81
      Height = 27
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 716
    end
  end
  object edtLinkID: TUniDBLookupComboBox
    Left = 103
    Top = 120
    Width = 530
    Height = 23
    Hint = ''
    Visible = False
    ListField = 'Brief'
    ListSource = DataSource
    KeyField = 'PropertyID'
    ListFieldIndex = 0
    TabOrder = 1
    Color = clWindow
  end
  object ebtIsActive: TUniCheckBox
    Left = 103
    Top = 18
    Width = 219
    Height = 22
    Hint = ''
    Caption = #1047#1072#1076#1072#1085#1080#1077' '#1072#1082#1090#1080#1074#1085#1086
    ParentFont = False
    Font.Height = -13
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object edtComment: TUniEdit
    Left = 103
    Top = 73
    Width = 530
    Hint = ''
    Text = ''
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    ClearButton = True
  end
  object UniLabel1: TUniLabel
    Left = 8
    Top = 73
    Width = 57
    Height = 13
    Hint = ''
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
    TabOrder = 4
  end
  object UniLabel2: TUniLabel
    Left = 8
    Top = 120
    Width = 62
    Height = 13
    Hint = ''
    Caption = #1055#1088#1086#1094#1077#1076#1091#1088#1072':'
    TabOrder = 5
  end
  object edtNumber: TUniNumberEdit
    Left = 512
    Top = 18
    Width = 121
    Hint = ''
    TabOrder = 6
    DecimalPrecision = 0
    DecimalSeparator = ','
  end
  object UniLabel3: TUniLabel
    Left = 443
    Top = 20
    Width = 39
    Height = 13
    Hint = ''
    Caption = #1053#1086#1084#1077#1088':'
    TabOrder = 7
  end
  object DataSource: TDataSource
    DataSet = FDQuery
    Left = 586
    Top = 18
  end
  object FDQuery: TFDQuery
    Connection = UniMainModule.FDConnection
    SQL.Strings = (
      '')
    Left = 554
    Top = 42
  end
end
