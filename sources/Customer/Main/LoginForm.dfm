object LoginF: TLoginF
  Left = 0
  Top = 0
  Cursor = crHandPoint
  ClientHeight = 400
  ClientWidth = 400
  Caption = #1042#1093#1086#1076' '#1074' '#1089#1080#1089#1090#1077#1084#1091
  OnShow = UniLoginFormShow
  BorderStyle = bsNone
  Position = poDesktopCenter
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  ClientEvents.ExtEvents.Strings = (
    
      'window.afterlayout=function window.afterlayout(sender, layout, e' +
      'Opts)'#13#10'{'#13#10'    var me=this;'#13#10'    window.addEventListener('#39'resize'#39 +
      ', function(){me.center()});'#13#10'}'
    
      'window.resize=function window.resize(sender, width, height, oldW' +
      'idth, oldHeight, eOpts)'#13#10'{'#13#10'  // '#1085#1091#1078#1085#1086' !!!'#13#10'}')
  ClientEvents.UniEvents.Strings = (
    
      'window.beforeInit=function window.beforeInit(sender, config)'#13#10'{'#13 +
      #10'  config.shadow=false;'#13#10'}')
  Layout = 'fit'
  LayoutConfig.Cls = 'login-form login-container'
  LayoutAttribs.Align = 'stretch'
  TextHeight = 15
  object UniPanel1: TUniPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 400
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    ShowCaption = False
    Caption = 'UniPanel1'
    LayoutConfig.Region = 'center'
    ExplicitLeft = 24
    ExplicitTop = 16
    ExplicitWidth = 497
    ExplicitHeight = 313
    object btnOk: TUniButton
      Left = 82
      Top = 295
      Width = 225
      Height = 33
      Hint = ''
      Caption = #1042#1086#1081#1090#1080
      TabOrder = 1
      OnClick = btnOkClick
    end
    object edtUser: TUniEdit
      Left = 82
      Top = 110
      Width = 225
      Hint = #1051#1086#1075#1080#1085
      ShowHint = True
      ParentShowHint = False
      MaxLength = 64
      BorderStyle = ubsNone
      Text = ''
      TabOrder = 2
      EmptyText = #1051#1086#1075#1080#1085
      InputType = 'email'
    end
    object edtPassword: TUniEdit
      Left = 82
      Top = 170
      Width = 225
      Hint = #1055#1072#1088#1086#1083#1100
      ShowHint = True
      ParentShowHint = False
      PasswordChar = '*'
      MaxLength = 64
      BorderStyle = ubsNone
      Text = ''
      TabOrder = 3
      EmptyText = #1055#1072#1088#1086#1083#1100
    end
    object UniCheckBox1: TUniCheckBox
      Left = 82
      Top = 214
      Width = 97
      Height = 17
      Hint = ''
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
      TabOrder = 4
      LayoutConfig.Cls = 'remember-checkbox'
    end
    object lblReset: TUniLabel
      Left = 221
      Top = 228
      Width = 86
      Height = 17
      Cursor = crHandPoint
      Hint = ''
      Caption = #1047#1072#1073#1099#1083' '#1087#1072#1088#1086#1083#1100
      ParentFont = False
      Font.Color = clHighlight
      Font.Height = -13
      ParentColor = False
      Color = clHighlight
      TabOrder = 5
      OnClick = lblResetClick
    end
    object lblReg: TUniLabel
      Left = 82
      Top = 365
      Width = 122
      Height = 17
      Cursor = crHandPoint
      Hint = ''
      Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100#1089#1103
      ParentFont = False
      Font.Color = clHighlight
      Font.Height = -13
      ParentColor = False
      Color = clHighlight
      TabOrder = 6
      OnClick = lblRegClick
    end
    object UniLabel3: TUniLabel
      Left = 82
      Top = 45
      Width = 225
      Height = 13
      Hint = ''
      AutoSize = False
      Caption = #1042#1093#1086#1076' '#1074' '#1089#1080#1089#1090#1077#1084#1091
      TabOrder = 7
      LayoutConfig.Cls = 'login-title'
    end
  end
end
