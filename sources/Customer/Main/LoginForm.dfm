object LoginF: TLoginF
  Left = 0
  Top = 0
  Cursor = crHandPoint
  ClientHeight = 352
  ClientWidth = 547
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
    
      'window.afterrender=function window.afterrender(sender, eOpts)'#13#10'{' +
      #13#10'  var me=sender.getEl();'#13#10'    if (me) {'#13#10'        me.setStyle("' +
      'padding", 0);'#13#10'        me.setStyle("border-width", 0);'#13#10'        ' +
      'me.setStyle("margin", 0);'#13#10'        me.setStyle("-webkit-border-r' +
      'adius", 0);'#13#10'        me.setStyle("-moz-'#65279'border-radius", 0);'#13#10'   ' +
      '     me.setStyle("border-radius", 0);'#13#10'    }'#13#10'}'
    
      'window.resize=function window.resize(sender, width, height, oldW' +
      'idth, oldHeight, eOpts)'#13#10'{'#13#10'  // '#1085#1091#1078#1085#1086' !!!'#13#10'}')
  ClientEvents.UniEvents.Strings = (
    
      'window.beforeInit=function window.beforeInit(sender, config)'#13#10'{'#13 +
      #10'  config.shadow=false;'#13#10'}')
  Layout = 'fit'
  LayoutAttribs.Align = 'stretch'
  TextHeight = 15
  object UniPanel1: TUniPanel
    Left = 24
    Top = 16
    Width = 497
    Height = 313
    Hint = ''
    TabOrder = 0
    BorderStyle = ubsNone
    ShowCaption = False
    Caption = 'UniPanel1'
    LayoutConfig.Region = 'center'
    object UniLabel1: TUniLabel
      Left = 146
      Top = 53
      Width = 31
      Height = 13
      Hint = ''
      Caption = 'Email:'
      ParentFont = False
      Font.Height = -12
      Font.Style = [fsBold]
      TabOrder = 1
    end
    object UniLabel2: TUniLabel
      Left = 146
      Top = 116
      Width = 44
      Height = 13
      Hint = ''
      Caption = #1055#1072#1088#1086#1083#1100':'
      ParentFont = False
      Font.Height = -12
      Font.Style = [fsBold]
      TabOrder = 2
    end
    object btnOk: TUniButton
      Left = 200
      Top = 248
      Width = 115
      Height = 25
      Hint = ''
      Caption = #1042#1086#1081#1090#1080
      TabOrder = 3
      OnClick = btnOkClick
    end
    object edtUser: TUniEdit
      Left = 146
      Top = 74
      Width = 225
      Hint = ''
      MaxLength = 64
      Text = ''
      TabOrder = 4
      InputType = 'email'
    end
    object edtPassword: TUniEdit
      Left = 146
      Top = 137
      Width = 225
      Hint = ''
      PasswordChar = '*'
      MaxLength = 64
      Text = ''
      TabOrder = 5
    end
    object UniCheckBox1: TUniCheckBox
      Left = 146
      Top = 197
      Width = 97
      Height = 17
      Hint = ''
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
      TabOrder = 6
    end
    object lblReset: TUniLabel
      Left = 285
      Top = 165
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
      TabOrder = 7
      OnClick = lblResetClick
    end
    object lblReg: TUniLabel
      Left = 18
      Top = 293
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
      TabOrder = 8
      OnClick = lblRegClick
    end
  end
end
