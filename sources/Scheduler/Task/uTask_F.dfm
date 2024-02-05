object Task_F: TTask_F
  Left = 0
  Top = 0
  ClientHeight = 572
  ClientWidth = 954
  Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1077' '#1079#1072#1076#1072#1085#1080#1103
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 534
    Width = 948
    Height = 35
    Hint = ''
    Align = alBottom
    TabOrder = 0
    Caption = ''
    ExplicitTop = 479
    ExplicitWidth = 943
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 839
      Top = 4
      Width = 82
      Height = 27
      Hint = ''
      Margins.Right = 30
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Align = alRight
      TabOrder = 1
      OnClick = btnOkClick
      ExplicitLeft = 830
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 752
      Top = 4
      Width = 81
      Height = 27
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Align = alRight
      TabOrder = 2
      OnClick = btnCancelClick
      ExplicitLeft = 743
    end
  end
  object MainPage: TUniPageControl
    Left = 0
    Top = 0
    Width = 954
    Height = 531
    Hint = ''
    ActivePage = MainSheet
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 630
    ExplicitTop = 210
    ExplicitWidth = 289
    ExplicitHeight = 193
    object MainSheet: TUniTabSheet
      Hint = ''
      Caption = #1043#1083#1072#1074#1085#1072#1103
      ExplicitWidth = 950
      ExplicitHeight = 504
      object tabCommon: TUniFieldContainer
        Left = 0
        Top = 0
        Width = 946
        Height = 489
        Hint = ''
        ParentColor = False
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 950
        DesignSize = (
          946
          489)
        object edtBrief: TUniEdit
          Left = 150
          Top = 42
          Width = 762
          Hint = ''
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          ClearButton = True
          ExplicitWidth = 770
        end
        object edtName: TUniEdit
          Left = 150
          Top = 70
          Width = 762
          Hint = ''
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          ClearButton = True
          ExplicitWidth = 770
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
          Width = 84
          Height = 13
          Hint = ''
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
          TabOrder = 4
        end
        object edtPeriodType: TUniRadioGroup
          Left = 17
          Top = 162
          Width = 895
          Height = 100
          Hint = ''
          Items.Strings = (
            #1058#1086#1083#1100#1082#1086' '#1086#1076#1080#1085' '#1088#1072#1079
            #1042#1099#1073#1088#1072#1090#1100
            #1045#1078#1077#1076#1085#1077#1074#1085#1086
            #1045#1078#1077#1085#1077#1076#1077#1083#1100#1085#1086
            #1045#1078#1077#1084#1077#1089#1103#1095#1085#1086
            #1045#1078#1077#1075#1086#1076#1085#1086)
          Anchors = [akLeft, akTop, akRight]
          Caption = #1055#1077#1088#1080#1086#1076' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103':'
          TabOrder = 5
          Columns = 2
          OnClick = edtPeriodTypeClick
          ExplicitWidth = 903
        end
        object edtDateBegin: TUniDateTimePicker
          Left = 150
          Top = 99
          Width = 182
          Hint = ''
          DateTime = 45170.605918425930000000
          DateFormat = 'dd/MM/yyyy'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 6
          DateMode = dtmDateTime
        end
        object UniLabel2: TUniLabel
          Left = 17
          Top = 99
          Width = 33
          Height = 13
          Hint = ''
          Caption = #1057#1090#1072#1088#1090':'
          TabOrder = 7
        end
        object edtTaskType: TUniRadioGroup
          Left = 17
          Top = 270
          Width = 895
          Height = 59
          Hint = ''
          InputRTL = False
          Items.Strings = (
            #1055#1088#1086#1094#1077#1076#1091#1088#1072
            'Bat '#1092#1072#1081#1083' (*.bat)'
            'Sql '#1089#1082#1088#1080#1087#1090)
          Anchors = [akLeft, akTop, akRight]
          Caption = #1058#1080#1087' '#1079#1072#1076#1072#1095#1080':'
          TabOrder = 8
          Columns = 3
          OnClick = edtTaskTypeClick
          ExplicitWidth = 903
        end
        object ebtIsActive: TUniCheckBox
          Left = 139
          Top = 14
          Width = 193
          Height = 22
          Hint = ''
          Caption = #1047#1072#1076#1072#1085#1080#1077' '#1072#1082#1090#1080#1074#1085#1086
          ParentFont = False
          Font.Height = -13
          Anchors = [akTop, akRight]
          TabOrder = 9
          ExplicitLeft = 138
        end
        object PeriodType1: TUniPanel
          Left = 109
          Top = 202
          Width = 284
          Height = 33
          Hint = ''
          TabOrder = 10
          BorderStyle = ubsNone
          ShowCaption = False
          Caption = ''
          object edtTimePeriod: TUniDateTimePicker
            Left = 145
            Top = 3
            Width = 94
            Hint = ''
            DateTime = 0.413358877318387400
            DateFormat = 'dd/MM/yyyy'
            TimeFormat = 'HH:mm:ss'
            Kind = tUniTime
            TabOrder = 1
            DateMode = dtmDateTime
          end
          object UniLabel3: TUniLabel
            Left = 7
            Top = 8
            Width = 44
            Height = 13
            Hint = ''
            Caption = #1050#1072#1078#1076#1099#1077':'
            TabOrder = 2
          end
          object edtDayPeriod: TUniSpinEdit
            Left = 57
            Top = 3
            Width = 50
            Hint = ''
            TabOrder = 3
          end
          object UniLabel4: TUniLabel
            Left = 111
            Top = 8
            Width = 29
            Height = 13
            Hint = ''
            Caption = #1076#1085#1077#1081':'
            TabOrder = 4
          end
          object UniLabel5: TUniLabel
            Left = 242
            Top = 8
            Width = 30
            Height = 13
            Hint = ''
            Caption = #1063':'#1052':'#1057
            TabOrder = 5
          end
        end
        object gbLink: TUniGroupBox
          Left = 17
          Top = 340
          Width = 895
          Height = 138
          Hint = ''
          Caption = #1047#1072#1076#1072#1095#1072':'
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 11
          ExplicitWidth = 899
          DesignSize = (
            895
            138)
          object edtLinkID: TUniDBLookupComboBox
            Left = 9
            Top = 23
            Width = 591
            Height = 23
            Hint = ''
            Visible = False
            ListField = 'Brief'
            ListSource = DataSource
            KeyField = 'PropertyID'
            ListFieldIndex = 0
            TabOrder = 1
            Color = clWindow
          end
          object edtLink: TUniEdit
            Left = 9
            Top = 23
            Width = 607
            Hint = ''
            Visible = False
            Text = ''
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 2
            ClearButton = True
            ExplicitWidth = 583
          end
          object cbExecuteHide: TUniCheckBox
            Left = 637
            Top = 24
            Width = 178
            Height = 17
            Hint = ''
            Caption = #1057#1082#1088#1099#1090#1086#1077' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077
            TabOrder = 3
          end
          object edtCMD: TUniMemo
            Left = 9
            Top = 16
            Width = 617
            Height = 113
            Hint = ''
            TabOrder = 4
            ClearButton = True
          end
        end
        object pnlInteval: TUniPanel
          Left = 17
          Top = 127
          Width = 358
          Height = 29
          Hint = ''
          TabOrder = 12
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
      end
    end
    object AuditSheet: TUniTabSheet
      Hint = ''
      Caption = #1040#1091#1076#1080#1090
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 941
      ExplicitHeight = 448
      DesignSize = (
        946
        503)
      object edtID: TUniEdit
        Left = 150
        Top = 472
        Width = 163
        Hint = ''
        Text = 'edtID'
        Anchors = [akLeft, akBottom]
        TabOrder = 0
        ReadOnly = True
        ExplicitTop = 415
      end
      object UniLabel6: TUniLabel
        Left = 15
        Top = 475
        Width = 89
        Height = 13
        Hint = ''
        Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088':'
        Anchors = [akLeft, akBottom]
        TabOrder = 1
        ExplicitTop = 418
      end
      object edtInDateTime: TUniDateTimePicker
        Left = 534
        Top = 472
        Width = 163
        Hint = ''
        DateTime = 45170.605918425930000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        ReadOnly = True
        Anchors = [akLeft, akBottom]
        TabOrder = 2
        DateMode = dtmDateTime
        ExplicitTop = 415
      end
      object UniLabel7: TUniLabel
        Left = 383
        Top = 474
        Width = 95
        Height = 13
        Hint = ''
        Caption = #1044#1072#1090#1072' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103':'
        Anchors = [akLeft, akBottom]
        TabOrder = 3
        ExplicitTop = 417
      end
    end
  end
  object FDQuery: TFDQuery
    Connection = UniMainModule.FDConnection
    Left = 482
    Top = 154
  end
  object DataSource: TDataSource
    DataSet = FDQuery
    Left = 481
    Top = 114
  end
end
