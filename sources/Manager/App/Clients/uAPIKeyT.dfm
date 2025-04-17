inherited APIKeyT: TAPIKeyT
  Width = 1257
  Height = 503
  ExplicitWidth = 1257
  ExplicitHeight = 503
  inherited UniPanel2: TUniPanel
    Top = 67
    Width = 1257
    Height = 436
    ExplicitTop = 67
    ExplicitWidth = 1257
    ExplicitHeight = 436
    inherited Grid: TUniDBGrid
      Top = 52
      Width = 1257
      Height = 384
      Columns = <
        item
          FieldName = 'ApiKeysID'
          Title.Alignment = taCenter
          Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
          Width = 122
          Visible = False
        end
        item
          FieldName = 'Flag'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Width = 64
        end
        item
          FieldName = 'ApiKey'
          Title.Alignment = taCenter
          Title.Caption = 'Api '#1082#1083#1102#1095
          Width = 360
        end
        item
          FieldName = 'Name'
          Title.Alignment = taCenter
          Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          Width = 300
        end
        item
          FieldName = 'inDatetime'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
          Width = 128
        end
        item
          FieldName = 'EndDatetime'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
          Width = 208
        end>
    end
    object gbFilter: TUniGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 1251
      Height = 46
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1060#1080#1083#1100#1090#1088
      Align = alTop
      LayoutConfig.Width = '0'
      TabOrder = 2
    end
  end
  object ToolBars: TUniPanel [1]
    Left = 0
    Top = 0
    Width = 1257
    Height = 67
    Hint = ''
    ShowHint = True
    Align = alTop
    TabOrder = 1
    BorderStyle = ubsNone
    Caption = ''
    Color = clBtnShadow
    Images = ImageList32
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'fit'
    LayoutAttribs.Align = 'top'
    LayoutAttribs.Pack = 'start'
    LayoutConfig.Width = '100'
    LayoutConfig.Region = 'north'
    object ToolBar: TUniToolBar
      Left = 0
      Top = 0
      Width = 1257
      Height = 67
      Hint = ''
      ShowHint = True
      ButtonHeight = 53
      ButtonWidth = 112
      Images = ImageList32
      ShowCaptions = True
      ButtonAutoWidth = True
      LayoutConfig.IgnorePosition = False
      LayoutConfig.DockWhenAligned = False
      Align = alClient
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      OverflowHandler = ohMenu
      object UniToolButton1: TUniToolButton
        AlignWithMargins = True
        Left = 3
        Top = 3
        ShowHint = True
        Action = actInsert
        ImageIndex = 1
        TabOrder = 1
      end
      object UniToolButton2: TUniToolButton
        AlignWithMargins = True
        Left = 118
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actUpdate
        ImageIndex = 3
        TabOrder = 2
      end
      object UniToolButton4: TUniToolButton
        AlignWithMargins = True
        Left = 233
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actDelete
        ImageIndex = 0
        TabOrder = 3
      end
    end
  end
  inherited Query: TFDQuery
    UpdateOptions.KeyFields = 'ApiKeysID'
    UpdateOptions.AutoIncFields = 'ApiKeysID'
    SQL.Strings = (
      'select * '
      '  from vApiKeys'
      ' where ClientID = :ClientID ')
    Top = 182
    ParamData = <
      item
        Name = 'CLIENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QueryApiKeysID: TIntegerField
      FieldName = 'ApiKeysID'
    end
    object QueryClientID: TFMTBCDField
      FieldName = 'ClientID'
      Size = 0
    end
    object QueryApiKey: TStringField
      FieldName = 'ApiKey'
      Size = 255
    end
    object QueryName: TStringField
      FieldName = 'Name'
      Size = 255
    end
    object QueryFlag: TIntegerField
      FieldName = 'Flag'
    end
    object QueryinDatetime: TSQLTimeStampField
      FieldName = 'inDatetime'
    end
    object QueryEndDatetime: TSQLTimeStampField
      FieldName = 'EndDatetime'
    end
  end
  inherited DataSource: TDataSource
    Left = 691
    Top = 242
  end
  inherited ActionList: TUniActionList
    inherited actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
    end
    object actInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 1
      OnExecute = actInsertExecute
    end
    object actUpdate: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 3
      OnExecute = actUpdateExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 0
      OnExecute = actDeleteExecute
    end
  end
  inherited PopupMenu: TUniPopupMenu
    Tag = -1
    object N2: TUniMenuItem [0]
      Action = actInsert
    end
    object N3: TUniMenuItem [1]
      Action = actUpdate
    end
    object N4: TUniMenuItem [2]
      Action = actDelete
    end
    object N1: TUniMenuItem [3]
      Caption = '-'
    end
    inherited ppRefresh: TUniMenuItem
      Tag = -1
    end
  end
  inherited UpdateSQL: TFDUpdateSQL
    Left = 762
    Top = 181
  end
end
