object TaskBAT_F: TTaskBAT_F
  Left = 0
  Top = 0
  ClientHeight = 202
  ClientWidth = 762
  Caption = 'TaskBAT_F'
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  MonitoredKeys.Keys = <>
  DesignSize = (
    762
    202)
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 164
    Width = 756
    Height = 35
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    ExplicitTop = 182
    ExplicitWidth = 708
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 676
      Top = 4
      Width = 82
      Height = 27
      Hint = ''
      Margins.Right = 5
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Align = alRight
      TabOrder = 1
      OnClick = btnOkClick
      ExplicitLeft = 620
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 589
      Top = 4
      Width = 81
      Height = 27
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Align = alRight
      TabOrder = 2
      OnClick = btnCancelClick
      ExplicitLeft = 533
    end
  end
  object edtpath: TUniEdit
    Left = 113
    Top = 128
    Width = 633
    Hint = ''
    Text = ''
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    ClearButton = True
    ExplicitWidth = 649
  end
  object UniLabel2: TUniLabel
    Left = 19
    Top = 137
    Width = 29
    Height = 13
    Hint = ''
    Caption = #1060#1072#1081#1083':'
    TabOrder = 2
  end
  object edtIsActive: TUniCheckBox
    Left = 113
    Top = 16
    Width = 209
    Height = 22
    Hint = ''
    Checked = True
    Caption = #1044#1077#1081#1089#1090#1074#1080#1077' '#1072#1082#1090#1080#1074#1085#1086
    ParentFont = False
    Font.Height = -13
    TabOrder = 3
  end
  object edtComment: TUniEdit
    Left = 113
    Top = 88
    Width = 633
    Hint = ''
    Text = ''
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
    ClearButton = True
    ExplicitWidth = 649
  end
  object UniLabel1: TUniLabel
    Left = 19
    Top = 93
    Width = 57
    Height = 13
    Hint = ''
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
    TabOrder = 5
  end
  object edtNumber: TUniNumberEdit
    Left = 113
    Top = 48
    Width = 127
    Hint = ''
    TabOrder = 6
    DecimalPrecision = 0
    DecimalSeparator = ','
  end
  object UniLabel3: TUniLabel
    Left = 19
    Top = 51
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
