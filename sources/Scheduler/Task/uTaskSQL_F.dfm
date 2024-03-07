object TaskSQL_F: TTaskSQL_F
  Left = 0
  Top = 0
  ClientHeight = 555
  ClientWidth = 925
  Caption = 'TaskSQL_F'
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  MonitoredKeys.Keys = <>
  DesignSize = (
    925
    555)
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 517
    Width = 919
    Height = 35
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    ExplicitTop = 182
    ExplicitWidth = 644
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 831
      Top = 4
      Width = 82
      Height = 27
      Hint = ''
      Margins.Right = 5
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Align = alRight
      TabOrder = 1
      OnClick = btnOkClick
      ExplicitLeft = 556
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 744
      Top = 4
      Width = 81
      Height = 27
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Align = alRight
      TabOrder = 2
      OnClick = btnCancelClick
      ExplicitLeft = 469
    end
  end
  object edtIsActive: TUniCheckBox
    Left = 103
    Top = 8
    Width = 154
    Height = 22
    Hint = ''
    Caption = #1044#1077#1081#1089#1090#1074#1080#1077' '#1072#1082#1090#1080#1074#1085#1086
    ParentFont = False
    Font.Height = -13
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object edtComment: TUniEdit
    Left = 103
    Top = 70
    Width = 814
    Hint = ''
    Text = ''
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    ClearButton = True
  end
  object UniLabel1: TUniLabel
    Left = 8
    Top = 75
    Width = 57
    Height = 13
    Hint = ''
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
    TabOrder = 3
  end
  object edtNumber: TUniNumberEdit
    Left = 103
    Top = 42
    Width = 121
    Hint = ''
    TabOrder = 4
    DecimalPrecision = 0
    DecimalSeparator = ','
  end
  object UniLabel3: TUniLabel
    Left = 8
    Top = 45
    Width = 39
    Height = 13
    Hint = ''
    Caption = #1053#1086#1084#1077#1088':'
    TabOrder = 5
  end
  object edtSQL: TUniSyntaxEdit
    Left = 8
    Top = 112
    Width = 909
    Height = 399
    Hint = ''
    Language = 'SQL'
    Font.Name = 'Courier New'
    Anchors = [akLeft, akTop, akRight, akBottom]
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
