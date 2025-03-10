object SpplitForm: TSpplitForm
  Left = 0
  Top = 0
  ClientHeight = 161
  ClientWidth = 384
  Caption = #1059#1082#1072#1078#1080#1090#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1083#1103' '#1090#1077#1082#1091#1097#1077#1081' '#1095#1072#1089#1090#1080' '#1079#1072#1082#1072#1079#1072
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  ShowHint = True
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object tabCommon: TUniFieldContainer
    Left = 0
    Top = 0
    Width = 384
    Height = 161
    Hint = ''
    ShowHint = True
    ParentColor = False
    Align = alClient
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 0
    ExplicitWidth = 291
    ExplicitHeight = 257
    DesignSize = (
      384
      161)
    object lblDetailNameF: TUniLabel
      Left = 21
      Top = 21
      Width = 251
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1059#1082#1072#1078#1080#1090#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1083#1103' '#1090#1077#1082#1091#1097#1077#1081' '#1095#1072#1089#1090#1080' '#1079#1072#1082#1072#1079#1072':'
      TabOrder = 1
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 200
      Top = 121
      Width = 81
      Height = 27
      Hint = ''
      ShowHint = True
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akRight, akBottom]
      TabStop = False
      TabOrder = 2
      OnClick = btnCancelClick
      ExplicitTop = 93
    end
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 287
      Top = 121
      Width = 82
      Height = 27
      Hint = ''
      Margins.Right = 30
      ShowHint = True
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 3
      OnClick = btnOkClick
      ExplicitTop = 93
    end
    object edtQuantity: TUniSpinEdit
      Left = 21
      Top = 40
      Width = 164
      Height = 27
      Hint = ''
      ShowHint = True
      TabOrder = 4
      ParentFont = False
      Font.Height = -13
      SelectOnFocus = True
    end
  end
end
