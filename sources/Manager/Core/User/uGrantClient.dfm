object GrantClientT: TGrantClientT
  Left = 0
  Top = 0
  Width = 887
  Height = 403
  Layout = 'fit'
  LayoutConfig.Width = '0'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  TabOrder = 0
  ParentColor = False
  ParentBackground = False
  object GridUsers: TUniDBGrid
    Left = 0
    Top = 44
    Width = 887
    Height = 359
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    BodyRTL = False
    RowEditor = True
    DataSource = DataSource
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgFilterClearButton, dgTabs]
    ReadOnly = True
    WebOptions.Paged = False
    WebOptions.PageSize = 50
    WebOptions.CustomizableCells = False
    WebOptions.AppendPosition = tpCurrentRow
    WebOptions.FetchAll = True
    LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
    LoadMask.Color = clActiveCaption
    LayoutConfig.Height = '100'
    LayoutConfig.Width = '100'
    Align = alClient
    Anchors = []
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    Columns = <
      item
        FieldName = 'ClientBrief'
        Title.Alignment = taCenter
        Title.Caption = #1050#1083#1080#1077#1085#1090
        Title.Font.Height = -13
        Width = 586
      end>
  end
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 887
    Height = 44
    Hint = ''
    ButtonHeight = 37
    ButtonWidth = 110
    Images = UniMainModule.BaseImage16
    ShowCaptions = True
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'north'
    Layout = 'absolute'
    TabOrder = 1
    ParentColor = False
    Color = clBtnFace
    object UniToolButton1: TUniToolButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Margins.Right = 0
      BodyRTL = False
      Action = acInsert
      ImageIndex = 0
      IconAlign = iaLeft
      TabOrder = 1
    end
    object UniToolButton2: TUniToolButton
      AlignWithMargins = True
      Left = 116
      Top = 3
      Margins.Right = 0
      Action = actEdit
      ImageIndex = 1
      IconAlign = iaLeft
      TabOrder = 2
    end
    object UniToolButton3: TUniToolButton
      AlignWithMargins = True
      Left = 229
      Top = 3
      Margins.Right = 0
      Action = acDelete
      ImageIndex = 2
      IconAlign = iaLeft
      TabOrder = 3
    end
    object UniToolButton4: TUniToolButton
      AlignWithMargins = True
      Left = 342
      Top = 3
      Hint = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      Action = actRefreshAll
      ImageIndex = 3
      IconAlign = iaLeft
      TabOrder = 4
    end
  end
  object Query: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    SQL.Strings = (
      'Select *'
      '  from vGrantObject'
      '')
    Left = 683
    Top = 102
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 686
    Top = 173
  end
  object PopupMenu: TUniPopupMenu
    Images = UniMainModule.BaseImage
    Left = 225
    Top = 275
    object N1: TUniMenuItem
      Action = acInsert
    end
    object N2: TUniMenuItem
      Action = actEdit
    end
    object N4: TUniMenuItem
      Action = acDelete
    end
    object N5: TUniMenuItem
      Caption = '-'
    end
    object N6: TUniMenuItem
      Action = actRefreshAll
    end
  end
  object ActionList: TUniActionList
    Left = 222
    Top = 196
    object acInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 0
      OnExecute = acInsertExecute
    end
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 1
      OnExecute = actEditExecute
    end
    object acDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnExecute = acDeleteExecute
    end
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      ImageIndex = 3
      OnExecute = actRefreshAllExecute
    end
  end
end
