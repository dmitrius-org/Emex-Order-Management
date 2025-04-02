object AllowCreateOrderF: TAllowCreateOrderF
  Left = 0
  Top = 0
  ClientHeight = 236
  ClientWidth = 477
  Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1088#1072#1079#1084#1077#1097#1077#1085#1080#1103' '#1079#1072#1082#1072#1079#1072'.'
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 189
    Width = 471
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    DesignSize = (
      471
      44)
    object btnOk: TUniBitBtn
      Left = 336
      Top = 5
      Width = 129
      Height = 34
      Hint = ''
      Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      Left = 249
      Top = 5
      Width = 81
      Height = 34
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
  object Grid: TUniDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 471
    Height = 180
    Hint = ''
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgConfirmDelete, dgAutoRefreshRow]
    WebOptions.Paged = False
    WebOptions.CustomizableCells = False
    LoadMask.Message = #1055#1088#1086#1074#1077#1088#1082#1072' '#1079#1072#1082#1072#1079#1072'...'
    LoadMask.Target = Owner
    ForceFit = True
    Align = alClient
    TabOrder = 1
    ParentColor = False
    Color = clBtnFace
    Columns = <
      item
        FieldName = 'Supplier'
        Title.Alignment = taCenter
        Title.Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
        Width = 123
      end
      item
        FieldName = 'Balance'
        Title.Alignment = taCenter
        Title.Caption = #1041#1072#1083#1072#1085#1089
        Width = 141
      end
      item
        FieldName = 'NewOrderAmount'
        Title.Alignment = taCenter
        Title.Caption = #1057#1091#1084#1084#1072' '#1074#1072#1096#1077#1075#1086' '#1079#1072#1082#1072#1079#1072
        Width = 170
      end>
  end
  object Table: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 288
    Top = 32
    object TableSupplier: TStringField
      FieldName = 'Supplier'
      Size = 30
    end
    object TableTotal: TFloatField
      FieldName = 'Total'
      DisplayFormat = '###,##0.00 $'
    end
    object TableBalance: TFloatField
      FieldName = 'Balance'
      DisplayFormat = '###,##0.00 $'
    end
    object TableCredit: TFloatField
      FieldName = 'Credit'
      DisplayFormat = '###,##0.00 $'
    end
    object TableNewOrderAmount: TFloatField
      FieldName = 'NewOrderAmount'
      OnGetText = TableNewOrderAmountGetText
      DisplayFormat = '###,##0.00 $'
    end
  end
  object DataSource: TDataSource
    DataSet = Table
    Left = 288
    Top = 96
  end
  object UniTimer: TUniTimer
    Interval = 500
    Enabled = False
    RunOnce = True
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimerTimer
    Left = 400
    Top = 88
  end
end
