object EmployeeParametersF: TEmployeeParametersF
  Left = 0
  Top = 0
  ClientHeight = 272
  ClientWidth = 571
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 225
    Width = 565
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 1
    Caption = ''
    DesignSize = (
      565
      44)
    object btnOk: TUniBitBtn
      Left = 446
      Top = 10
      Width = 85
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      Left = 360
      Top = 10
      Width = 81
      Height = 25
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object pcCommon: TUniPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 565
    Height = 216
    Hint = ''
    ActivePage = tabCommon
    Align = alClient
    TabOrder = 0
    object tabCommon: TUniTabSheet
      Hint = ''
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1079#1072#1082#1072#1079#1086#1074
      object UniFieldContainer1: TUniFieldContainer
        Left = 0
        Top = 0
        Width = 557
        Height = 249
        Hint = ''
        ParentColor = False
        Align = alTop
        AlignmentControl = uniAlignmentClient
        ParentAlignmentControl = False
        TabOrder = 0
        object lblName: TUniLabel
          Left = 26
          Top = 18
          Width = 182
          Height = 13
          Hint = ''
          Caption = #1053#1072#1075#1088#1072#1076#1072' '#1079#1072' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1085#1091#1102' '#1076#1077#1090#1072#1083#1100':'
          TabOrder = 1
        end
        object edtProcessedVal: TUniNumberEdit
          Left = 359
          Top = 18
          Width = 169
          Hint = ''
          TabOrder = 2
          EmptyText = #1057#1091#1084#1084#1072' '
          DecimalSeparator = ','
        end
        object edtIncorrectVal: TUniNumberEdit
          Left = 359
          Top = 46
          Width = 169
          Hint = ''
          TabOrder = 3
          EmptyText = #1057#1091#1084#1084#1072' '
          DecimalSeparator = ','
        end
        object UniLabel4: TUniLabel
          Left = 26
          Top = 46
          Width = 251
          Height = 13
          Hint = ''
          Caption = #1064#1090#1088#1072#1092' '#1079#1072' '#1085#1077#1087#1088#1072#1074#1080#1083#1100#1085#1086' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1085#1091#1102' '#1076#1077#1090#1072#1083#1100':'
          TabOrder = 4
        end
        object UniLabel5: TUniLabel
          Left = 26
          Top = 74
          Width = 195
          Height = 13
          Hint = ''
          Caption = #1053#1072#1075#1088#1072#1076#1072' '#1079#1072' '#1087#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1085#1091#1102' '#1076#1077#1090#1072#1083#1100':'
          TabOrder = 5
        end
        object edtConfirmedVal: TUniNumberEdit
          Left = 359
          Top = 74
          Width = 169
          Hint = ''
          TabOrder = 6
          EmptyText = #1057#1091#1084#1084#1072' '
          DecimalSeparator = ','
        end
      end
    end
    object tabAudit: TUniTabSheet
      Hint = ''
      TabVisible = False
      AlignmentControl = uniAlignmentClient
      ParentAlignmentControl = False
      Caption = #1040#1091#1076#1080#1090
      LayoutConfig.Width = '100'
      object fsAudit: TUniFieldSet
        AlignWithMargins = True
        Left = 3
        Top = 105
        Width = 551
        Height = 80
        Hint = ''
        Title = #1040#1091#1076#1080#1090
        Collapsible = True
        Align = alBottom
        LayoutConfig.Region = 'south'
        TabOrder = 0
        object UniFieldContainer2: TUniFieldContainer
          Left = 2
          Top = 15
          Width = 547
          Height = 63
          Hint = ''
          ParentColor = False
          Align = alClient
          TabOrder = 1
          object edtID: TUniEdit
            Left = 127
            Top = 8
            Width = 138
            Hint = ''
            Text = ''
            TabOrder = 1
            ReadOnly = True
          end
          object edtInDate: TUniDateTimePicker
            Left = 127
            Top = 33
            Width = 138
            Hint = ''
            DateTime = 45098.000000000000000000
            DateFormat = 'dd.MM.yyyy'
            TimeFormat = 'HH:mm:ss'
            ReadOnly = True
            TabOrder = 3
            DateMode = dtmDateTime
          end
          object edtUpdDate: TUniDateTimePicker
            Left = 401
            Top = 33
            Width = 145
            Hint = ''
            DateTime = 45098.000000000000000000
            DateFormat = 'dd.MM.yyyy'
            TimeFormat = 'HH:mm:ss'
            ReadOnly = True
            TabOrder = 4
            DateMode = dtmDateTime
          end
          object UniLabel1: TUniLabel
            Left = 11
            Top = 10
            Width = 89
            Height = 13
            Hint = ''
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088':'
            TabOrder = 2
          end
          object UniLabel2: TUniLabel
            Left = 11
            Top = 37
            Width = 80
            Height = 13
            Hint = ''
            Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103':'
            TabOrder = 5
          end
          object UniLabel3: TUniLabel
            Left = 288
            Top = 38
            Width = 90
            Height = 13
            Hint = ''
            Caption = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103':'
            TabOrder = 6
          end
        end
      end
    end
  end
  object Query: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.UpdateTableName = 'pClientReliation'
    UpdateOptions.KeyFields = 'ID '
    UpdateOptions.AutoIncFields = 'ID '
    SQL.Strings = (
      'select * '
      '  from vClientEmployeeReliation ')
    Left = 354
    Top = 156
    object QueryID: TFMTBCDField
      FieldName = 'ID'
    end
    object QueryClientID: TFMTBCDField
      FieldName = 'ClientID'
    end
    object QueryEmployeeID: TFMTBCDField
      FieldName = 'EmployeeID'
    end
    object QueryClientBrief: TWideStringField
      FieldName = 'ClientBrief'
      Size = 255
    end
  end
  object ActionList: TUniActionList
    Left = 414
    Top = 155
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 1
    end
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 2
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 0
    end
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
    end
  end
  object PopupMenu: TUniPopupMenu
    Left = 137
    Top = 154
    object N1: TUniMenuItem
      Action = actAdd
    end
    object N2: TUniMenuItem
      Action = actEdit
    end
    object N3: TUniMenuItem
      Action = actDelete
    end
    object N4: TUniMenuItem
      Caption = '-'
    end
    object N5: TUniMenuItem
      Action = actRefreshAll
    end
  end
end
