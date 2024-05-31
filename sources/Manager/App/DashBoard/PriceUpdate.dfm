object PriceUpdateT: TPriceUpdateT
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 521
  Height = 241
  OnReady = UniFrameReady
  Layout = 'fit'
  TabOrder = 0
  object Grid: TUniDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 515
    Height = 235
    Hint = ''
    DataSource = DataSource
    Options = [dgTitles, dgRowLines, dgConfirmDelete, dgAutoRefreshRow]
    WebOptions.Paged = False
    WebOptions.CustomizableCells = False
    LoadMask.Message = 'Loading data...'
    EnableColumnHide = False
    BorderStyle = ubsNone
    Align = alClient
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    OnDrawColumnCell = GridDrawColumnCell
    Columns = <
      item
        FieldName = 'PriceName'
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1072#1081#1089'-'#1083#1080#1089#1090
        Title.Font.Height = -13
        Width = 126
      end
      item
        FieldName = 'UpdateDate'
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
        Title.Font.Height = -13
        Width = 169
      end>
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 285
    Top = 63
  end
  object Query: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evItems, evAutoFetchAll]
    FetchOptions.Items = []
    FormatOptions.AssignedValues = [fvSortOptions]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'select *'
      '  from vDBUpdateDate'
      ' order by UpdateDate')
    Left = 333
    Top = 41
    object QueryPriceName: TStringField
      FieldName = 'PriceName'
      Size = 10
    end
    object QueryUpdateDate: TSQLTimeStampField
      FieldName = 'UpdateDate'
    end
    object QueryUpdateDays: TIntegerField
      FieldName = 'UpdateDays'
    end
  end
end
