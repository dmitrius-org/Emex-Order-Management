inherited UserRegisterF: TUserRegisterF
  ClientHeight = 500
  ClientWidth = 500
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1074' '#1089#1080#1089#1090#1077#1084#1077
  OnShow = UniFormShow
  BorderStyle = bsNone
  Visible = True
  AlignmentControl = uniAlignmentClient
  ClientEvents.ExtEvents.Strings = (
    
      'window.afterlayout=function window.afterlayout(sender, layout, e' +
      'Opts)'#13#10'{'#13#10'    var me=this;'#13#10'    window.addEventListener('#39'resize'#39 +
      ', function(){me.center()});'#13#10'}'
    
      'window.resize=function window.resize(sender, width, height, oldW' +
      'idth, oldHeight, eOpts)'#13#10'{'#13#10'  //'#13#10'}')
  ClientEvents.UniEvents.Strings = (
    
      'window.beforeInit=function window.beforeInit(sender, config)'#13#10'{'#13 +
      #10'    config.shadow=false;'#13#10'}')
  LayoutConfig.Cls = 'login-form login-container'
  LayoutConfig.Region = 'center'
  ExplicitWidth = 500
  ExplicitHeight = 500
  TextHeight = 15
  object UniContainerPanel1: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 500
    Height = 500
    Hint = ''
    ParentColor = False
    Align = alClient
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 0
    LayoutConfig.Cls = 'login-box'
    DesignSize = (
      500
      500)
    object UniLabel6: TUniLabel
      Left = 50
      Top = 471
      Width = 191
      Height = 13
      Hint = ''
      Caption = '* - '#1087#1086#1083#1077' '#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1086' '#1082' '#1079#1072#1087#1086#1083#1085#1077#1085#1080#1102
      Anchors = [akLeft, akBottom]
      ParentFont = False
      Font.Color = clCrimson
      TabOrder = 1
    end
    object edtPhone: TUniEdit
      Left = 50
      Top = 208
      Width = 401
      Hint = #1058#1077#1083#1077#1092#1086#1085
      ShowHint = True
      ParentShowHint = False
      MaxLength = 64
      CharEOL = '*'
      BorderStyle = ubsNone
      Text = ''
      ParentFont = False
      TabOrder = 2
      EmptyText = #1058#1077#1083#1077#1092#1086#1085
      FieldLabelWidth = 5
      FieldLabelFont.Color = clCrimson
      InputType = 'tel'
    end
    object edtPassword: TUniEdit
      Left = 50
      Top = 254
      Width = 401
      Hint = #1055#1072#1088#1086#1083#1100
      ShowHint = True
      ParentShowHint = False
      PasswordChar = '*'
      MaxLength = 64
      CharEOL = '*'
      BorderStyle = ubsNone
      Text = ''
      ParentFont = False
      TabOrder = 3
      EmptyText = #1055#1072#1088#1086#1083#1100
      FieldLabelWidth = 5
      FieldLabelFont.Color = clCrimson
      InputType = 'tel'
    end
    object edtEmail: TUniEdit
      Left = 50
      Top = 162
      Width = 401
      Hint = #1055#1086#1095#1090#1072
      ShowHint = True
      ParentShowHint = False
      MaxLength = 64
      BorderStyle = ubsNone
      Text = ''
      ParentFont = False
      TabOrder = 4
      EmptyText = #1055#1086#1095#1090#1072
      FieldLabelWidth = 5
      FieldLabelFont.Color = clCrimson
      InputType = 'email'
    end
    object edtContactPerson: TUniEdit
      Left = 50
      Top = 300
      Width = 401
      Hint = #1050#1086#1085#1090#1072#1082#1090#1085#1086#1077' '#1083#1080#1094#1086
      ShowHint = True
      ParentShowHint = False
      MaxLength = 256
      CharEOL = '*'
      BorderStyle = ubsNone
      Text = ''
      TabOrder = 5
      EmptyText = #1050#1086#1085#1090#1072#1082#1090#1085#1086#1077' '#1083#1080#1094#1086
      FieldLabelWidth = 5
      InputType = 'text'
    end
    object edtBrief: TUniEdit
      Left = 50
      Top = 117
      Width = 401
      Hint = #1048#1084#1103'/'#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103':'
      ShowHint = True
      ParentShowHint = False
      MaxLength = 128
      BorderStyle = ubsNone
      Text = ''
      ParentFont = False
      TabOrder = 6
      EmptyText = #1048#1084#1103'/'#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      FieldLabelWidth = 5
      FieldLabelAlign = laRight
      FieldLabelFont.Color = clCrimson
      InputType = 'text'
    end
    object btnOk: TUniButton
      Left = 281
      Top = 392
      Width = 170
      Height = 33
      Hint = ''
      Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100#1089#1103
      Anchors = []
      TabOrder = 7
      ScreenMask.Enabled = True
      ScreenMask.Message = #1054#1087#1077#1088#1072#1094#1080#1103' '#1074#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103' ...'
      ScreenMask.Target = Owner
      OnClick = btnOkClick
    end
    object btnCancel: TUniButton
      Left = 50
      Top = 392
      Width = 170
      Height = 33
      Hint = ''
      Caption = #1053#1072#1079#1072#1076
      Cancel = True
      Anchors = []
      TabOrder = 8
      OnClick = btnCancelClick
    end
    object UniLabel2: TUniLabel
      Left = 56
      Top = 53
      Width = 395
      Height = 13
      Hint = ''
      AutoSize = False
      Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
      TabOrder = 9
      LayoutConfig.Cls = 'login-title'
    end
    object UniLabel1: TUniLabel
      Left = 457
      Top = 117
      Width = 5
      Height = 13
      Hint = ''
      Caption = '*'
      Anchors = [akLeft, akBottom]
      ParentFont = False
      Font.Color = clCrimson
      TabOrder = 10
    end
    object UniLabel3: TUniLabel
      Left = 457
      Top = 162
      Width = 5
      Height = 13
      Hint = ''
      Caption = '*'
      Anchors = [akLeft, akBottom]
      ParentFont = False
      Font.Color = clCrimson
      TabOrder = 11
    end
    object UniLabel4: TUniLabel
      Left = 457
      Top = 208
      Width = 5
      Height = 13
      Hint = ''
      Caption = '*'
      Anchors = [akLeft, akBottom]
      ParentFont = False
      Font.Color = clCrimson
      TabOrder = 12
    end
    object UniLabel5: TUniLabel
      Left = 457
      Top = 254
      Width = 5
      Height = 13
      Hint = ''
      Caption = '*'
      Anchors = [akLeft, akBottom]
      ParentFont = False
      Font.Color = clCrimson
      TabOrder = 13
    end
  end
end
