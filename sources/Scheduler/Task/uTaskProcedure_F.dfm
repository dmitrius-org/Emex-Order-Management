object TaskProcedure_F: TTaskProcedure_F
  Left = 0
  Top = 0
  ClientHeight = 221
  ClientWidth = 675
  Caption = 'TaskProcedure_F'
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  MonitoredKeys.Keys = <>
  DesignSize = (
    675
    221)
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 183
    Width = 669
    Height = 35
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 581
      Top = 4
      Width = 82
      Height = 27
      Hint = ''
      Margins.Right = 5
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Align = alRight
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 494
      Top = 4
      Width = 81
      Height = 27
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Align = alRight
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
  object edtLinkID: TUniDBLookupComboBox
    Left = 103
    Top = 114
    Width = 546
    Height = 23
    Hint = ''
    ListField = 'Brief'
    ListSource = DataSource
    KeyField = 'PropertyID'
    ListFieldIndex = 0
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Color = clWindow
  end
  object edtIsActive: TUniCheckBox
    Left = 103
    Top = 18
    Width = 199
    Height = 22
    Hint = ''
    Checked = True
    Caption = #1044#1077#1081#1089#1090#1074#1080#1077' '#1072#1082#1090#1080#1074#1085#1086
    ParentFont = False
    Font.Height = -13
    TabOrder = 2
  end
  object edtComment: TUniEdit
    Left = 103
    Top = 64
    Width = 546
    Hint = ''
    Text = ''
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    ClearButton = True
  end
  object UniLabel1: TUniLabel
    Left = 8
    Top = 67
    Width = 57
    Height = 13
    Hint = ''
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
    TabOrder = 4
  end
  object UniLabel2: TUniLabel
    Left = 8
    Top = 114
    Width = 62
    Height = 13
    Hint = ''
    Caption = #1055#1088#1086#1094#1077#1076#1091#1088#1072':'
    TabOrder = 5
  end
  object edtNumber: TUniNumberEdit
    Left = 528
    Top = 18
    Width = 121
    Hint = ''
    Anchors = [akTop, akRight]
    TabOrder = 6
    DecimalPrecision = 0
    DecimalSeparator = ','
  end
  object UniLabel3: TUniLabel
    Left = 459
    Top = 20
    Width = 39
    Height = 13
    Hint = ''
    Caption = #1053#1086#1084#1077#1088':'
    Anchors = [akTop, akRight]
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
