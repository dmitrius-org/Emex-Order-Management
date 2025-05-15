object BalanceAddF: TBalanceAddF
  Left = 0
  Top = 0
  ClientHeight = 333
  ClientWidth = 603
  Caption = #1055#1086#1087#1086#1083#1085#1077#1085#1080#1077' '#1073#1072#1083#1072#1085#1089#1072' '#1087#1086' '#1082#1083#1080#1077#1085#1090#1091':'
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 286
    Width = 597
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 1
    Caption = ''
    DesignSize = (
      597
      44)
    object btnOk: TUniBitBtn
      Left = 478
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
      Left = 392
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
    Left = 0
    Top = 0
    Width = 603
    Height = 283
    Hint = ''
    ActivePage = tabCommon
    TabBarVisible = False
    Align = alClient
    TabOrder = 0
    object tabCommon: TUniTabSheet
      Hint = ''
      Caption = #1043#1083#1072#1074#1085#1072#1103
      object UniFieldContainer1: TUniFieldContainer
        Left = 0
        Top = 0
        Width = 595
        Height = 249
        Hint = ''
        ParentColor = False
        Align = alTop
        TabOrder = 0
        object lblName: TUniLabel
          Left = 26
          Top = 50
          Width = 37
          Height = 13
          Hint = ''
          Caption = #1057#1091#1084#1084#1072':'
          TabOrder = 1
        end
        object UniLabel4: TUniLabel
          Left = 26
          Top = 157
          Width = 77
          Height = 13
          Hint = ''
          Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
          TabOrder = 5
        end
        object edtAmount: TUniNumberEdit
          Left = 128
          Top = 50
          Width = 169
          Hint = ''
          TabOrder = 2
          EmptyText = #1057#1091#1084#1084#1072' '
          DecimalSeparator = ','
          OnKeyPress = edtAmountKeyPress
        end
        object edtComment: TUniMemo
          Left = 128
          Top = 157
          Width = 437
          Height = 73
          Hint = ''
          TabOrder = 6
        end
        object lblDate: TUniLabel
          Left = 26
          Top = 82
          Width = 28
          Height = 13
          Hint = ''
          Caption = #1044#1072#1090#1072':'
          TabOrder = 3
        end
        object edtDate: TUniDateTimePicker
          Left = 129
          Top = 78
          Width = 168
          Hint = ''
          DateTime = 45311.000000000000000000
          DateFormat = 'dd.MM.yyyy'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 4
          ClearButton = True
          EmptyText = #1044#1072#1090#1072' '#1087#1086#1087#1086#1083#1085#1077#1085#1080#1103
        end
        object cbPayType: TUniExComboBox
          Left = 128
          Top = 106
          Width = 169
          Height = 23
          Hint = ''
          Text = ''
          TabOrder = 7
          EmptyText = #1058#1080#1087' '#1087#1083#1072#1090#1077#1078#1072
          AnyMatch = True
          ClearButton = True
          IconItems = <>
          Value = '-1'
        end
        object UniLabel5: TUniLabel
          Left = 26
          Top = 109
          Width = 70
          Height = 13
          Hint = ''
          Caption = #1058#1080#1087' '#1087#1083#1072#1090#1077#1078#1072':'
          TabOrder = 8
        end
        object cbClient: TUniExComboBox
          Left = 128
          Top = 20
          Width = 437
          Height = 23
          Hint = ''
          Text = ''
          ParentFont = False
          Font.Height = -12
          TabOrder = 9
          EmptyText = #1050#1083#1080#1077#1085#1090
          AnyMatch = True
          ClearButton = True
          IconItems = <>
          Value = '-1'
        end
        object UniLabel6: TUniLabel
          Left = 26
          Top = 23
          Width = 40
          Height = 13
          Hint = ''
          Caption = #1050#1083#1080#1077#1085#1090':'
          TabOrder = 10
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
        Top = 172
        Width = 589
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
          Width = 585
          Height = 63
          Hint = ''
          ParentColor = False
          Align = alClient
          TabOrder = 1
          object edtID: TUniEdit
            Left = 141
            Top = 8
            Width = 138
            Hint = ''
            Text = ''
            TabOrder = 1
            ReadOnly = True
          end
          object edtInDate: TUniDateTimePicker
            Left = 141
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
            Left = 415
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
            Left = 25
            Top = 10
            Width = 89
            Height = 13
            Hint = ''
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088':'
            TabOrder = 2
          end
          object UniLabel2: TUniLabel
            Left = 25
            Top = 37
            Width = 80
            Height = 13
            Hint = ''
            Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103':'
            TabOrder = 5
          end
          object UniLabel3: TUniLabel
            Left = 302
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
    Left = 266
    Top = 180
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
    Top = 179
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
    Left = 169
    Top = 178
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
