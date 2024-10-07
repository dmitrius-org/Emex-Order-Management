object LoginF: TLoginF
  Left = 0
  Top = 0
  ClientHeight = 349
  ClientWidth = 670
  Caption = #1042#1093#1086#1076' '#1074' '#1089#1080#1089#1090#1077#1084#1091
  OnShow = UniLoginFormShow
  BorderStyle = bsNone
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
      'adius", 0);'#13#10'        me.setStyle("-moz-'#65279'border-radius", 0);     ' +
      '        '#13#10'    }   '#13#10'}'
    
      'window.resize=function window.resize(sender, width, height, oldW' +
      'idth, oldHeight, eOpts)'#13#10'{'#13#10'//'#13#10'}')
  ClientEvents.UniEvents.Strings = (
    
      'window.beforeInit=function window.beforeInit(sender, config)'#13#10'{'#13 +
      #10'  config.shadow=false;'#13#10'}')
  Layout = 'fit'
  DesignSize = (
    670
    349)
  TextHeight = 15
  object UniLabel1: TUniLabel
    Left = 154
    Top = 86
    Width = 77
    Height = 13
    Hint = ''
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
    Anchors = []
    TabOrder = 0
  end
  object UniLabel2: TUniLabel
    Left = 152
    Top = 138
    Width = 43
    Height = 13
    Hint = ''
    Caption = #1055#1072#1088#1086#1083#1100':'
    Anchors = []
    TabOrder = 6
  end
  object btnOk: TUniButton
    Left = 389
    Top = 236
    Width = 105
    Height = 25
    Hint = ''
    Caption = #1042#1086#1081#1090#1080
    Anchors = []
    TabOrder = 4
    OnClick = btnOkClick
  end
  object edtUser: TUniEdit
    Left = 269
    Top = 83
    Width = 225
    Hint = ''
    Text = ''
    Anchors = []
    TabOrder = 1
  end
  object edtPas: TUniEdit
    Left = 269
    Top = 134
    Width = 225
    Hint = ''
    PasswordChar = '*'
    CharEOL = '*'
    Text = ''
    Anchors = []
    TabOrder = 2
  end
  object btnCancel: TUniButton
    Left = 269
    Top = 236
    Width = 105
    Height = 25
    Hint = ''
    Caption = #1054#1090#1084#1077#1085#1072
    Cancel = True
    Anchors = []
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object UniCheckBox1: TUniCheckBox
    Left = 269
    Top = 171
    Width = 97
    Height = 17
    Hint = ''
    Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
    TabOrder = 3
  end
  object lblReset: TUniLabel
    Left = 408
    Top = 171
    Width = 86
    Height = 17
    Cursor = crHandPoint
    Hint = ''
    Visible = False
    Caption = #1047#1072#1073#1099#1083' '#1087#1072#1088#1086#1083#1100
    ParentFont = False
    Font.Color = clHighlight
    Font.Height = -13
    ParentColor = False
    Color = clHighlight
    TabOrder = 7
  end
end
