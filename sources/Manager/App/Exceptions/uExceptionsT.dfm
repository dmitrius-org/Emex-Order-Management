inherited ExceptionsT: TExceptionsT
  Width = 1532
  ExplicitWidth = 1532
  inherited UniPanel: TUniPanel
    Width = 1532
    ExplicitWidth = 1163
    inherited UniPanel3: TUniPanel
      AlignWithMargins = False
      Left = 0
      Top = 0
      Width = 1532
      Height = 72
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 1532
      ExplicitHeight = 72
      object fCancel: TUniBitBtn
        Left = 661
        Top = 22
        Width = 100
        Height = 25
        Hint = ''
        ShowHint = True
        ParentShowHint = False
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        TabOrder = 1
        ImageIndex = 3
        OnClick = fCancelClick
      end
      object btnGridStatisticOpen: TUniButton
        Left = 555
        Top = 22
        Width = 100
        Height = 25
        Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
        ShowHint = True
        Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
        TabOrder = 2
        OnClick = actRefreshAllExecute
      end
      object fType: TUniADCheckComboBox
        Left = 10
        Top = 22
        Width = 336
        Hint = ''
        ShowHint = True
        ShowSearch = True
        Text = ''
        TabOrder = 3
        ClientEvents.ExtEvents.Strings = (
          ''
          
            'afterrender=function afterrender(sender, eOpts) {'#13#10'   initComboB' +
            'oxSearch(sender, "id", "val");'#13#10'}')
        ClearButton = True
        IconItems = <>
      end
      object UniLabel3: TUniLabel
        Left = 10
        Top = 3
        Width = 84
        Height = 13
        Hint = ''
        ShowHint = True
        ParentShowHint = False
        Caption = #1058#1080#1087' '#1080#1079#1084#1077#1085#1077#1085#1080#1103':'
        TabOrder = 4
      end
      object fDetailNum: TUniEdit
        Left = 352
        Top = 22
        Width = 197
        Hint = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
        ShowHint = True
        Text = ''
        TabOrder = 5
        EmptyText = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
        CheckChangeDelay = 200
        ClearButton = True
      end
      object lblDEtailNumber: TUniLabel
        Left = 352
        Top = 3
        Width = 78
        Height = 13
        Hint = ''
        ShowHint = True
        Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080':'
        TabOrder = 6
      end
    end
  end
  inherited UniPanel2: TUniPanel
    Width = 1532
    ExplicitWidth = 1163
    ExplicitHeight = 327
    inherited Grid: TUniDBGrid
      Width = 1532
      WebOptions.PageSize = 500
      Columns = <
        item
          FieldName = 'Brand'
          Title.Alignment = taCenter
          Title.Caption = #1041#1088#1077#1085#1076
          Width = 191
        end
        item
          FieldName = 'DetailNum'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1076' '#1076#1077#1090#1072#1083#1080
          Width = 196
        end
        item
          FieldName = 'DetailName'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 300
        end
        item
          FieldName = 'DetailNameF'
          Title.Alignment = taCenter
          Title.Caption = #1048#1079#1084#1077#1085#1077#1085#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 300
        end
        item
          FieldName = 'WeightKGF'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089
          Width = 95
        end
        item
          FieldName = 'VolumeKGf'
          Title.Alignment = taCenter
          Title.Caption = #1054#1073#1098#1077#1084
          Width = 92
        end
        item
          FieldName = 'Restrictions'
          Title.Alignment = taCenter
          Title.Caption = 'Restrictions'
          Width = 118
        end
        item
          FieldName = 'Fragile'
          Title.Alignment = taCenter
          Title.Caption = 'Fragile'
          Width = 100
        end
        item
          FieldName = 'NLA'
          Title.Alignment = taCenter
          Title.Caption = 'NLA'
          Width = 81
        end>
    end
  end
  inherited Query: TFDQuery
    UpdateOptions.UpdateTableName = 'dbo.tPrice'
    UpdateOptions.KeyFields = 'PriceID'
    UpdateOptions.AutoIncFields = 'PriceID'
    SQL.Strings = (
      ''
      'DECLARE @Type as ID'
      ' '
      'if :Types <> '#39#39'    '
      '  INSERT INTO @Type (ID)'
      '  SELECT CAST(value AS NUMERIC(18, 0))'
      '    FROM STRING_SPLIT(:Types, '#39','#39');'
      '    '
      '                        '
      ' exec dbo.ExceptionsSelect            '
      '            @Type = @Type '
      '           ,@DetailNum = :DetailNum  '
      '')
    Left = 694
    Top = 198
    ParamData = <
      item
        Name = 'TYPES'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DETAILNUM'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object QueryBrand: TStringField
      FieldName = 'Brand'
      Size = 60
    end
    object QueryDetailNum: TStringField
      FieldName = 'DetailNum'
      Size = 60
    end
    object QueryDetailName: TStringField
      FieldName = 'DetailName'
      Size = 256
    end
    object QueryDetailNameF: TStringField
      FieldName = 'DetailNameF'
      Size = 256
    end
    object QueryWeightKGF: TFloatField
      FieldName = 'WeightKGF'
      DisplayFormat = '###,##0.000 '#1082#1075
    end
    object QueryVolumeKGf: TFloatField
      FieldName = 'VolumeKGf'
      DisplayFormat = '###,##0.000 '#1082#1075
    end
    object QueryRestrictions: TStringField
      FieldName = 'Restrictions'
      Size = 60
    end
    object QueryFragile: TBooleanField
      FieldName = 'Fragile'
    end
    object QueryNLA: TBooleanField
      FieldName = 'NLA'
    end
    object QueryPriceID: TFMTBCDField
      FieldName = 'PriceID'
    end
  end
  inherited DataSource: TDataSource
    Left = 691
    Top = 250
  end
  inherited ActionList: TUniActionList
    Tag = -1
    inherited actAdd: TAction
      Tag = -1
      Visible = False
    end
    inherited actEdit: TAction
      Tag = -1
      Visible = False
    end
    inherited actDelete: TAction
      Tag = -1
      Visible = False
    end
    inherited actRefreshAll: TAction
      Tag = -1
    end
  end
  inherited UpdateSQL: TFDUpdateSQL
    Left = 810
    Top = 213
  end
end
