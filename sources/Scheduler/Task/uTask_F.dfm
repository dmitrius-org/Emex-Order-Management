object Task_F: TTask_F
  Left = 0
  Top = 0
  ClientHeight = 486
  ClientWidth = 897
  Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1077' '#1079#1072#1076#1072#1085#1080#1103
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  OnClose = UniFormClose
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 448
    Width = 891
    Height = 35
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 803
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
      Left = 716
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
  object MainPage: TUniPageControl
    Left = 0
    Top = 0
    Width = 897
    Height = 445
    Hint = ''
    ActivePage = TaskPage
    Align = alClient
    TabOrder = 1
    object MainSheet: TUniTabSheet
      Hint = ''
      Caption = #1043#1083#1072#1074#1085#1072#1103
      object tabCommon: TUniFieldContainer
        Left = 0
        Top = 0
        Width = 889
        Height = 417
        Hint = ''
        ParentColor = False
        Align = alClient
        TabOrder = 0
        DesignSize = (
          889
          417)
        object edtBrief: TUniEdit
          Left = 150
          Top = 42
          Width = 672
          Hint = ''
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          ClearButton = True
        end
        object edtName: TUniEdit
          Left = 150
          Top = 70
          Width = 672
          Hint = ''
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          ClearButton = True
        end
        object lblBruef: TUniLabel
          Left = 17
          Top = 42
          Width = 71
          Height = 13
          Hint = ''
          Caption = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077':'
          TabOrder = 3
        end
        object UniLabel1: TUniLabel
          Left = 17
          Top = 70
          Width = 57
          Height = 13
          Hint = ''
          Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
          TabOrder = 4
        end
        object edtDateBegin: TUniDateTimePicker
          Left = 150
          Top = 99
          Width = 182
          Hint = ''
          DateTime = 45170.605918425930000000
          DateFormat = 'dd/MM/yyyy'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 5
          DateMode = dtmDateTime
        end
        object UniLabel2: TUniLabel
          Left = 17
          Top = 99
          Width = 33
          Height = 13
          Hint = ''
          Caption = #1057#1090#1072#1088#1090':'
          TabOrder = 6
        end
        object ebtIsActive: TUniCheckBox
          Left = 150
          Top = 14
          Width = 129
          Height = 22
          Hint = ''
          Caption = #1047#1072#1076#1072#1085#1080#1077' '#1072#1082#1090#1080#1074#1085#1086
          ParentFont = False
          Font.Height = -13
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 7
        end
        object pnlInteval: TUniPanel
          Left = 17
          Top = 127
          Width = 358
          Height = 29
          Hint = ''
          TabOrder = 8
          BorderStyle = ubsNone
          Caption = 'pnlInteval'
          object lblStartTime: TUniLabel
            Left = 0
            Top = 0
            Width = 127
            Height = 28
            Hint = ''
            AutoSize = False
            Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1074#1088#1077#1084#1077#1085#1080' '#1074' '#1090#1077#1095#1077#1085#1080#1080' '#1076#1085#1103':'
            TabOrder = 1
          end
          object edtTimeBegin: TUniDateTimePicker
            Left = 133
            Top = 0
            Width = 87
            Hint = ''
            DateTime = 0.939875347219640400
            DateFormat = 'dd/MM/yyyy'
            TimeFormat = 'HH:mm:ss'
            Kind = tUniTime
            TabOrder = 2
          end
          object edtTimeEnd: TUniDateTimePicker
            Left = 226
            Top = 0
            Width = 89
            Hint = ''
            DateTime = 0.939875347219640400
            DateFormat = 'dd/MM/yyyy'
            TimeFormat = 'HH:mm:ss'
            Kind = tUniTime
            TabOrder = 3
          end
        end
        object pnlPeriodType: TUniContainerPanel
          Left = 0
          Top = 289
          Width = 889
          Height = 128
          Hint = ''
          ParentColor = False
          Align = alBottom
          TabOrder = 9
          DesignSize = (
            889
            128)
          object edtPeriodType: TUniRadioGroup
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 883
            Height = 122
            Hint = ''
            Items.Strings = (
              #1058#1086#1083#1100#1082#1086' '#1086#1076#1080#1085' '#1088#1072#1079
              #1042#1099#1073#1088#1072#1090#1100
              #1045#1078#1077#1076#1085#1077#1074#1085#1086
              #1045#1078#1077#1085#1077#1076#1077#1083#1100#1085#1086
              #1045#1078#1077#1084#1077#1089#1103#1095#1085#1086
              #1045#1078#1077#1075#1086#1076#1085#1086)
            Align = alBottom
            Caption = #1055#1077#1088#1080#1086#1076' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103':'
            TabOrder = 1
            ParentColor = False
            Color = clWindow
            Columns = 2
            OnClick = edtPeriodTypeClick
          end
          object PeriodType1: TUniPanel
            Left = 110
            Top = 54
            Width = 315
            Height = 33
            Hint = ''
            Anchors = [akLeft, akBottom]
            TabOrder = 2
            BorderStyle = ubsNone
            ShowCaption = False
            Caption = ''
            object edtTimePeriod: TUniDateTimePicker
              Left = 168
              Top = 3
              Width = 91
              Hint = ''
              DateTime = 0.010416666666666670
              DateFormat = 'dd/MM/yyyy'
              TimeFormat = 'HH:mm:ss'
              Kind = tUniTime
              TabOrder = 1
              DateMode = dtmDateTime
            end
            object UniLabel3: TUniLabel
              Left = 25
              Top = 7
              Width = 44
              Height = 13
              Hint = ''
              Caption = #1050#1072#1078#1076#1099#1077':'
              TabOrder = 2
            end
            object edtDayPeriod: TUniSpinEdit
              Left = 77
              Top = 3
              Width = 50
              Hint = ''
              TabOrder = 3
            end
            object UniLabel4: TUniLabel
              Left = 133
              Top = 7
              Width = 29
              Height = 13
              Hint = ''
              Caption = #1076#1085#1077#1081':'
              TabOrder = 4
            end
            object UniLabel5: TUniLabel
              Left = 264
              Top = 8
              Width = 30
              Height = 13
              Hint = ''
              Caption = #1063':'#1052':'#1057
              TabOrder = 5
            end
          end
        end
      end
    end
    object TaskPage: TUniTabSheet
      Hint = ''
      AlignmentControl = uniAlignmentClient
      ParentAlignmentControl = False
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      object UniPanel3: TUniPanel
        Left = 0
        Top = 54
        Width = 889
        Height = 363
        Hint = ''
        Align = alClient
        TabOrder = 0
        Caption = 'UniPanel1'
        Color = clYellow
        AlignmentControl = uniAlignmentClient
        ParentAlignmentControl = False
        Layout = 'fit'
        LayoutConfig.Width = '100'
        object ActionGrid: TUniDBGrid
          Left = 1
          Top = 1
          Width = 887
          Height = 361
          Hint = ''
          ShowHint = True
          ParentShowHint = False
          BodyRTL = False
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
              'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
              'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
              'data[sender.uniCol+1];'#13#10'        el.value = document.activeElemen' +
              't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
              '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
              'ent.body.removeChild(el);'#13#10'    };'#13#10'}'
            
              'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
              'r.getDockedItems()[1]; //Remove the ToolBar fixed in the bottom'#13 +
              #10'  toolbar.items.getAt(10).hide(); //Remove the Refresh button i' +
              'n the ToolBar, number 10, hide him'#13#10'}')
          RowEditor = True
          DataSource = DataSourceAction
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgFilterClearButton]
          WebOptions.PageSize = 50
          WebOptions.AppendPosition = tpCurrentRow
          WebOptions.FetchAll = True
          LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
          LoadMask.Color = clActiveCaption
          EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
          LayoutConfig.ComponentCls = 'grid-clients-file-format'
          LayoutConfig.IgnorePosition = False
          LayoutConfig.Height = '100'
          LayoutConfig.Width = '100'
          BorderStyle = ubsNone
          Align = alClient
          TabOrder = 1
          ParentColor = False
          Color = clBtnFace
          OnCellContextClick = ActionGridCellContextClick
          Columns = <
            item
              FieldName = 'ID'
              Title.Alignment = taCenter
              Title.Caption = #1048#1044
              Width = 112
              Visible = False
              ReadOnly = True
            end
            item
              FieldName = 'Number'
              Title.Alignment = taCenter
              Title.Caption = #1053#1086#1084#1077#1088
              Width = 79
              ReadOnly = True
            end
            item
              FieldName = 'IsActive'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1072#1090#1091#1089
              Width = 82
              Alignment = taCenter
              CheckBoxField.AutoPost = True
            end
            item
              FieldName = 'TaskTypeName'
              Title.Alignment = taCenter
              Title.Caption = #1058#1080#1087' '#1076#1077#1081#1089#1090#1074#1080#1103
              Width = 142
              ReadOnly = True
            end
            item
              FieldName = 'Comment'
              Title.Alignment = taCenter
              Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
              Width = 526
              ReadOnly = True
            end>
        end
      end
      object ActionTool: TUniToolBar
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 883
        Height = 48
        Hint = ''
        ShowHint = True
        ParentShowHint = False
        ButtonHeight = 40
        ButtonWidth = 110
        Images = UniMainModule.BaseImage16
        ShowCaptions = True
        LayoutConfig.IgnorePosition = False
        LayoutConfig.DockWhenAligned = False
        TabOrder = 1
        ParentColor = False
        Color = clBtnFace
        OverflowHandler = ohMenu
        object UniToolButton7: TUniToolButton
          Left = 0
          Top = 0
          Width = 97
          Hint = ''
          ShowHint = True
          ImageIndex = 1
          Style = tbsDropDown
          DropdownMenu = pmTaskActionAdd
          Caption = #1057#1086#1079#1076#1072#1090#1100
          IconAlign = iaLeft
          TabOrder = 1
        end
        object UniToolButton8: TUniToolButton
          Left = 97
          Top = 0
          ShowHint = True
          Action = actEdit
          ImageIndex = 1
          IconAlign = iaLeft
          TabOrder = 2
        end
        object UniToolButton9: TUniToolButton
          Left = 207
          Top = 0
          ShowHint = True
          Action = actDelete
          ImageIndex = 2
          IconAlign = iaLeft
          TabOrder = 3
        end
      end
    end
    object AuditSheet: TUniTabSheet
      Hint = ''
      Caption = #1040#1091#1076#1080#1090
      object UniContainerPanel1: TUniContainerPanel
        Left = 0
        Top = 350
        Width = 889
        Height = 67
        Hint = ''
        ParentColor = False
        Align = alBottom
        TabOrder = 0
        DesignSize = (
          889
          67)
        object UniLabel6: TUniLabel
          Left = 15
          Top = 36
          Width = 89
          Height = 13
          Hint = ''
          Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088':'
          Anchors = [akLeft, akBottom]
          TabOrder = 1
        end
        object edtID: TUniEdit
          Left = 150
          Top = 32
          Width = 163
          Hint = ''
          Text = ''
          Anchors = [akLeft, akBottom]
          TabOrder = 2
          ReadOnly = True
        end
        object UniLabel7: TUniLabel
          Left = 391
          Top = 36
          Width = 95
          Height = 13
          Hint = ''
          Caption = #1044#1072#1090#1072' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103':'
          Anchors = [akLeft, akBottom]
          TabOrder = 3
        end
        object edtInDateTime: TUniDateTimePicker
          Left = 534
          Top = 32
          Width = 163
          Hint = ''
          DateTime = 45170.605918425930000000
          DateFormat = 'dd/MM/yyyy'
          TimeFormat = 'HH:mm:ss'
          ReadOnly = True
          Anchors = [akLeft, akBottom]
          TabOrder = 4
          DateMode = dtmDateTime
        end
      end
    end
  end
  object FDQueryAction: TFDQuery
    AutoCalcFields = False
    IndexFieldNames = 'ID'
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'ID'
    UpdateObject = FDUpdateSQL
    SQL.Strings = (
      'select ID '
      '      ,Comment'
      '      ,IsActive'
      '      ,TaskType'
      '      ,TaskTypeName'
      '      ,Number'
      '  from vTaskActions'
      ' order by Number')
    Left = 634
    Top = 154
    object FDQueryActionID: TFMTBCDField
      FieldName = 'ID'
      KeyFields = 'ID'
      Origin = 'ID'
      Precision = 18
      Size = 0
    end
    object FDQueryActionIsActive: TBooleanField
      FieldName = 'IsActive'
      Origin = 'IsActive'
    end
    object FDQueryActionTaskTypeName: TStringField
      FieldName = 'TaskTypeName'
      Origin = 'TaskTypeName'
      ReadOnly = True
      Required = True
      Size = 16
    end
    object FDQueryActionTaskType: TIntegerField
      FieldName = 'TaskType'
    end
    object FDQueryActionNumber: TIntegerField
      FieldName = 'Number'
    end
    object FDQueryActionBrief: TWideStringField
      FieldName = 'Comment'
      Origin = 'Brief'
      Size = 60
    end
  end
  object DataSourceAction: TDataSource
    DataSet = FDQueryAction
    Left = 737
    Top = 154
  end
  object ActionList: TUniActionList
    Left = 407
    Top = 218
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 1
      OnExecute = actEditExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnExecute = actDeleteExecute
    end
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 3
      OnExecute = actRefreshAllExecute
    end
    object actAddActionProc: TAction
      Caption = #1055#1088#1086#1094#1077#1076#1091#1088#1072
      Hint = #1047#1072#1087#1091#1089#1082' '#1074#1085#1091#1090#1088#1077#1085#1085#1080#1093' '#1087#1088#1086#1094#1077#1076#1091#1088
      OnExecute = actAddActionProcExecute
    end
    object actAddActionBat: TAction
      Caption = 'BAT'
      Hint = #1047#1072#1087#1091#1089#1082' '#1092#1072#1081#1083#1086#1074' BAT'
      OnExecute = actAddActionBatExecute
    end
    object actAddActionSQL: TAction
      Caption = 'SQL'
      Hint = #1047#1072#1087#1091#1089#1082' SQl '#1089#1082#1088#1080#1087#1090#1086#1074
      OnExecute = actAddActionSQLExecute
    end
  end
  object pmTaskAction: TUniPopupMenu
    Images = UniMainModule.BaseImage16
    Left = 489
    Top = 257
    object N1: TUniMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077
      ImageIndex = 0
      OnClick = actAddActionBatExecute
      object N7: TUniMenuItem
        Action = actAddActionProc
      end
      object BAT2: TUniMenuItem
        Action = actAddActionBat
      end
      object SQL2: TUniMenuItem
        Action = actAddActionSQL
      end
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
  object pmTaskActionAdd: TUniPopupMenu
    Images = UniMainModule.BaseImage16
    Left = 489
    Top = 153
    object N6: TUniMenuItem
      Action = actAddActionProc
    end
    object Bat1: TUniMenuItem
      Action = actAddActionBat
    end
    object SQL1: TUniMenuItem
      Action = actAddActionSQL
    end
  end
  object FDUpdateSQL: TFDUpdateSQL
    ModifySQL.Strings = (
      'Update pTaskActions'
      '   set IsActive = :NEW_IsActive'
      ' where ID = :OLD_ID')
    FetchRowSQL.Strings = (
      'select IsActive from vTaskActions where ID = :OLD_ID')
    Left = 724
    Top = 214
  end
end
