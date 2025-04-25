object UserProfile: TUserProfile
  Left = 0
  Top = 0
  ClientHeight = 400
  ClientWidth = 400
  Caption = #1055#1088#1086#1092#1080#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
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
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 0
    LayoutConfig.Cls = 'login-box'
    ExplicitLeft = 26
    ExplicitTop = 189
    ExplicitWidth = 349
    ExplicitHeight = 164
    DesignSize = (
      400
      400)
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 64
      Top = 312
      Width = 120
      Height = 33
      Hint = ''
      Margins.Right = 5
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight, akBottom]
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 222
      Top = 312
      Width = 120
      Height = 33
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight, akBottom]
      TabOrder = 2
      OnClick = btnOkClick
    end
    object lblBrief: TUniLabel
      Left = 26
      Top = 61
      Width = 4
      Height = 20
      Hint = ''
      Caption = ''
      ParentFont = False
      Font.Height = -15
      TabOrder = 3
    end
    object Email: TUniEdit
      Left = 64
      Top = 198
      Width = 278
      Hint = #1055#1086#1095#1090#1072
      ShowHint = True
      ParentShowHint = False
      BorderStyle = ubsNone
      Text = ''
      ParentFont = False
      Font.Color = clBlack
      Font.Height = -13
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
      EmptyText = #1055#1086#1095#1090#1072
      FieldLabel = #1055#1086#1095#1090#1072
      FieldLabelWidth = 50
      FieldLabelAlign = laTop
      InputType = 'email'
    end
    object edtName: TUniEdit
      Left = 64
      Top = 105
      Width = 278
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      BorderStyle = ubsNone
      Text = ''
      ParentFont = False
      Font.Height = -13
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
      FieldLabel = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      FieldLabelWidth = 50
      FieldLabelAlign = laTop
    end
    object edtBrief: TUniEdit
      Left = 64
      Top = 17
      Width = 278
      Hint = #1051#1086#1075#1080#1085
      ShowHint = True
      ParentShowHint = False
      BorderStyle = ubsNone
      Text = ''
      ParentFont = False
      Font.Height = -13
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 6
      FieldLabel = #1051#1086#1075#1080#1085
      FieldLabelWidth = 50
      FieldLabelAlign = laTop
    end
  end
end
