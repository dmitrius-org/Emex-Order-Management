object GrantF: TGrantF
  Left = 0
  Top = 0
  ClientHeight = 598
  ClientWidth = 818
  Caption = #1055#1088#1072#1074#1072' '#1076#1086#1089#1090#1091#1087#1072' '#1082' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1102
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    Left = 0
    Top = 564
    Width = 818
    Height = 34
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 729
      Top = 4
      Width = 85
      Height = 26
      Hint = ''
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Align = alRight
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 642
      Top = 4
      Width = 81
      Height = 26
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Align = alRight
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
  object UniPageControl1: TUniPageControl
    Left = 0
    Top = 0
    Width = 818
    Height = 564
    Hint = ''
    ActivePage = tsInterface
    Align = alClient
    TabOrder = 1
    object tsInterface: TUniTabSheet
      Hint = ''
      Caption = #1055#1088#1072#1074#1072' '#1085#1072' '#1080#1085#1090#1077#1088#1092#1077#1081#1089
      object ToolBar: TUniToolBar
        Left = 0
        Top = 0
        Width = 810
        Height = 35
        Hint = ''
        ButtonHeight = 28
        ButtonWidth = 91
        ShowCaptions = True
        TabOrder = 0
        ParentColor = False
        Color = clBtnFace
        object UniToolButton1: TUniToolButton
          AlignWithMargins = True
          Left = 1
          Top = 3
          Margins.Left = 1
          Action = actExpand
          TabOrder = 1
        end
        object UniToolButton2: TUniToolButton
          AlignWithMargins = True
          Left = 95
          Top = 3
          Margins.Left = 0
          Action = actCollapse
          TabOrder = 2
        end
      end
      object GridGrant: TUniDBTreeGrid
        Left = 0
        Top = 35
        Width = 810
        Height = 501
        Hint = ''
        DataSource = DataSource
        ShowIcons = True
        Align = alClient
        TabOrder = 1
        ParentColor = False
        Color = clBtnFace
        LoadMask.Message = 'Loading data...'
        UseArrows = True
        IdParentField = 'ParentID'
        IdField = 'MenuID'
        Columns = <
          item
            FieldName = 'Caption'
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1084#1077#1085#1102
            Width = 500
          end
          item
            FieldName = 'Value'
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1083#1080#1095#1080#1077' '#1087#1088#1072#1074#1072
            Width = 147
            CheckBoxField.AutoPost = True
          end>
      end
    end
    object tsObjects: TUniTabSheet
      Hint = ''
      ParentAlignmentControl = False
      Caption = #1054#1073#1098#1077#1082#1090#1099' '#1089#1080#1089#1090#1077#1084#1099
      object UniPanel1: TUniPanel
        Left = 0
        Top = 0
        Width = 810
        Height = 48
        Hint = ''
        Align = alTop
        TabOrder = 0
        ShowCaption = False
        Caption = 'UniPanel1'
        object cbObjectType: TUniComboBox
          Left = 121
          Top = 14
          Width = 198
          Hint = ''
          ShowHint = True
          ParentShowHint = False
          Text = ''
          TabOrder = 1
          TabStop = False
          IconItems = <>
          OnSelect = cbObjectTypeSelect
        end
        object UniLabel1: TUniLabel
          Left = 16
          Top = 16
          Width = 69
          Height = 13
          Hint = ''
          Caption = #1058#1080#1087' '#1086#1073#1098#1077#1082#1090#1072':'
          TabOrder = 2
        end
      end
    end
  end
  object Query: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateObject = FDUpdateSQL
    SQL.Strings = (
      ''
      'exec GrantSelect '
      '       @ObjectID   = :ObjectID'
      '      ,@ObjectType = :ObjectType'
      ''
      'Select *'
      '  from vGrant'
      ' where ObjectID = :ObjectID'
      ' order by N')
    Left = 658
    Top = 72
    ParamData = <
      item
        Name = 'OBJECTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'OBJECTTYPE'
        ParamType = ptInput
      end>
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 657
    Top = 137
  end
  object FDUpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    InsertSQL.Strings = (
      '')
    ModifySQL.Strings = (
      'UPDATE pGrant'
      '   SET Value = :NEW_Value'
      ' WHERE Spid  = @@Spid'
      '   AND ObjectID = :OLD_ObjectID '
      '   AND MenuID   = :OLD_MenuID')
    DeleteSQL.Strings = (
      '')
    FetchRowSQL.Strings = (
      'SELECT --Spid, GrantID, ObjectID, MenuID, N, ParentID, Name, '
      '       Value'
      '  from pGrant (nolock)'
      ' WHERE Spid     = @@Spid'
      '   AND ObjectID = :ObjectID'
      '   AND MenuID   = :MenuID'
      '')
    Left = 660
    Top = 214
  end
  object UniActionList: TUniActionList
    Left = 386
    Top = 95
    object actExpand: TAction
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100
      OnExecute = actExpandExecute
    end
    object actCollapse: TAction
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100
      OnExecute = actCollapseExecute
    end
  end
end
