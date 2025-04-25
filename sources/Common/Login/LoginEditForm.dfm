object LoginEditF: TLoginEditF
  Left = 0
  Top = 0
  ClientHeight = 400
  ClientWidth = 400
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1072#1088#1086#1083#1103
  BorderStyle = bsDialog
  Position = poDesktopCenter
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  LayoutConfig.Cls = 'login-form login-container'
  TextHeight = 15
  object loginbox: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 400
    Hint = ''
    ParentColor = False
    Align = alClient
    TabOrder = 0
    LayoutConfig.Cls = 'login-box'
    ExplicitTop = -160
    ExplicitWidth = 384
    ExplicitHeight = 361
    DesignSize = (
      400
      400)
    object edtPas: TUniEdit
      Left = 96
      Top = 19
      Width = 225
      Hint = #1058#1077#1082#1091#1097#1080#1081' '#1087#1072#1088#1086#1083#1100
      ShowHint = True
      ParentShowHint = False
      PasswordChar = '*'
      CharEOL = '*'
      BorderStyle = ubsNone
      Text = ''
      Anchors = []
      TabOrder = 1
      EmptyText = #1042#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1091#1097#1080#1081' '#1087#1072#1088#1086#1083#1100
      FieldLabel = #1058#1077#1082#1091#1097#1080#1081' '#1087#1072#1088#1086#1083#1100
      FieldLabelWidth = 50
      FieldLabelAlign = laTop
      ExplicitLeft = 88
      ExplicitTop = 16
    end
    object edtNewPas2: TUniEdit
      Left = 96
      Top = 177
      Width = 225
      Hint = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
      ShowHint = True
      ParentShowHint = False
      PasswordChar = '*'
      CharEOL = '*'
      BorderStyle = ubsNone
      Text = ''
      Anchors = []
      TabOrder = 2
      EmptyText = #1055#1086#1074#1090#1086#1088#1090#1077' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
      FieldLabel = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
      FieldLabelWidth = 50
      FieldLabelAlign = laTop
      ExplicitLeft = 88
      ExplicitTop = 159
    end
    object edtNewPas: TUniEdit
      Left = 96
      Top = 100
      Width = 225
      Hint = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
      ShowHint = True
      ParentShowHint = False
      PasswordChar = '*'
      CharEOL = '*'
      BorderStyle = ubsNone
      Text = ''
      Anchors = []
      TabOrder = 3
      EmptyText = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
      FieldLabel = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
      FieldLabelWidth = 50
      FieldLabelAlign = laTop
      ExplicitLeft = 88
      ExplicitTop = 89
    end
    object btnCancel: TUniButton
      Left = 94
      Top = 296
      Width = 107
      Height = 33
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Cancel = True
      Anchors = []
      TabOrder = 4
      OnClick = btnCancelClick
      ExplicitLeft = 88
      ExplicitTop = 266
    end
    object btnOk: TUniButton
      Left = 214
      Top = 296
      Width = 110
      Height = 33
      Hint = ''
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Anchors = []
      TabOrder = 5
      OnClick = btnOkClick
      ExplicitLeft = 203
      ExplicitTop = 266
    end
  end
end
