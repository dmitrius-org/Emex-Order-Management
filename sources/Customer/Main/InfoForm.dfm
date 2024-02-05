object Info: TInfo
  Left = 0
  Top = 0
  ClientHeight = 414
  ClientWidth = 815
  Caption = #1054' '#1089#1080#1089#1090#1077#1084#1077
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object Grid: TUniDBGrid
    Left = 0
    Top = 0
    Width = 815
    Height = 414
    Hint = ''
    DataSource = DataSource
    WebOptions.Paged = False
    WebOptions.CustomizableCells = False
    LoadMask.Message = 'Loading data...'
    Align = alClient
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    Columns = <
      item
        FieldName = 'p'
        Title.Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088
        Width = 361
        Menu.MenuEnabled = False
      end
      item
        FieldName = 'i'
        Title.Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
        Width = 417
        Menu.MenuEnabled = False
      end>
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 657
    Top = 137
  end
  object Query: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    SQL.Strings = (
      'exec GetAppInfo')
    Left = 658
    Top = 72
  end
end
