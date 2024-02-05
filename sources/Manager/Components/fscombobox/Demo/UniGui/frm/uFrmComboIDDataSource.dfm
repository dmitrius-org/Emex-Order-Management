object frmComboDataSource: TfrmComboDataSource
  Left = 0
  Top = 0
  ClientHeight = 553
  ClientWidth = 805
  Caption = 'Exemplo Combo Linkado ao DatasSource'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object dbg1: TUniDBGrid
    Left = 24
    Top = 56
    Width = 753
    Height = 465
    Hint = ''
    LoadMask.Message = 'Loading data...'
    TabOrder = 0
  end
  object hdp1: TUniHiddenPanel
    Left = 600
    Top = 208
    Width = 161
    Height = 185
    Hint = ''
    Visible = True
    object cmb1: TUniFSComboBox
      Left = 8
      Top = 24
      Width = 145
      Hint = ''
      Text = 'cmb1'
      TabOrder = 1
      AnyMatch = True
    end
  end
  object btnLoad: TUniBitBtn
    Left = 24
    Top = 17
    Width = 121
    Height = 25
    Hint = ''
    Caption = 'Load Grid'
    TabOrder = 2
  end
  object cbb1: TUniDBComboBox
    Left = 328
    Top = 17
    Width = 177
    Hint = ''
    TabOrder = 3
  end
  object CDS1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 280
  end
end
