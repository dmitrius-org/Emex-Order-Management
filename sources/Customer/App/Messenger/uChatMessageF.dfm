object ChatMessageF: TChatMessageF
  AlignWithMargins = True
  Left = 0
  Top = 0
  ClientHeight = 362
  ClientWidth = 488
  Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1086#1077' '#1086#1073#1088#1072#1097#1077#1085#1080#1077
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  ShowHint = True
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  TextHeight = 15
  object tabCommon: TUniFieldContainer
    AlignWithMargins = True
    Left = 3
    Top = 320
    Width = 482
    Height = 39
    Hint = ''
    ShowHint = True
    ParentColor = False
    Align = alBottom
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 1
    LayoutConfig.Padding = '0px 0px 0px 0px'
    DesignSize = (
      482
      39)
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 301
      Top = 6
      Width = 81
      Height = 27
      Hint = ''
      ShowHint = True
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akRight, akBottom]
      TabStop = False
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 387
      Top = 6
      Width = 93
      Height = 27
      Hint = ''
      Margins.Right = 30
      ShowHint = True
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 2
      OnClick = btnOkClick
    end
  end
  object edtMessage: TUniMemo
    AlignWithMargins = True
    Left = 3
    Top = 41
    Width = 482
    Height = 273
    Hint = ''
    ShowHint = True
    Align = alClient
    TabOrder = 0
    LayoutConfig.Padding = '3'
    FieldLabel = #1042#1086#1087#1088#1086#1089
    FieldLabelAlign = laTop
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 488
    ExplicitHeight = 323
  end
  object edtSubject: TUniEdit
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 482
    Height = 32
    Hint = ''
    ShowHint = True
    MaxLength = 256
    Text = ''
    Align = alTop
    TabOrder = 2
    ClearButton = True
    FieldLabel = #1058#1077#1084#1072
    FieldLabelAlign = laTop
    InputType = 'text'
    LayoutConfig.Padding = '3'
    LayoutConfig.Height = '32'
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 488
  end
end
