object APIKeyForm_F: TAPIKeyForm_F
  Left = 0
  Top = 0
  ClientHeight = 274
  ClientWidth = 616
  Caption = 'API '#1050#1083#1102#1095
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 227
    Width = 610
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    DesignSize = (
      610
      44)
    object btnOk: TUniBitBtn
      Left = 490
      Top = 4
      Width = 114
      Height = 35
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      Left = 403
      Top = 4
      Width = 81
      Height = 35
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
  object pcCommon: TUniPageControl
    Left = 0
    Top = 0
    Width = 616
    Height = 224
    Hint = ''
    ActivePage = tabCommon
    Align = alClient
    TabOrder = 1
    object tabCommon: TUniTabSheet
      Hint = ''
      Caption = #1043#1083#1072#1074#1085#1072#1103
      object UniFieldContainer1: TUniFieldContainer
        Left = 0
        Top = 0
        Width = 608
        Height = 143
        Hint = ''
        ParentColor = False
        Align = alTop
        TabOrder = 0
        DesignSize = (
          608
          143)
        object edtBrief: TUniEdit
          Left = 160
          Top = 16
          Width = 428
          Hint = ''
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          ReadOnly = True
          ClearButton = True
        end
        object lblName: TUniLabel
          Left = 25
          Top = 16
          Width = 50
          Height = 13
          Hint = ''
          Caption = 'API '#1082#1083#1102#1095':'
          TabOrder = 2
        end
        object edtComment: TUniEdit
          Left = 160
          Top = 44
          Width = 428
          Hint = ''
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          ClearButton = True
        end
        object UniLabel4: TUniLabel
          Left = 25
          Top = 44
          Width = 57
          Height = 13
          Hint = ''
          Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
          TabOrder = 4
        end
      end
      object fsAudit: TUniFieldSet
        AlignWithMargins = True
        Left = 3
        Top = 113
        Width = 602
        Height = 80
        Hint = ''
        Title = #1040#1091#1076#1080#1090
        Collapsible = True
        Align = alBottom
        LayoutConfig.Region = 'south'
        TabOrder = 1
        object UniFieldContainer2: TUniFieldContainer
          Left = 2
          Top = 15
          Width = 598
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
            TabOrder = 2
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
            TabOrder = 3
            DateMode = dtmDateTime
          end
          object UniLabel1: TUniLabel
            Left = 25
            Top = 10
            Width = 89
            Height = 13
            Hint = ''
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088':'
            TabOrder = 4
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
end
