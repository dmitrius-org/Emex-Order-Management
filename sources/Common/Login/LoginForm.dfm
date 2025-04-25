object LoginF: TLoginF
  AlignWithMargins = True
  Left = 0
  Top = 0
  ClientHeight = 400
  ClientWidth = 400
  Caption = #1042#1093#1086#1076' '#1074' '#1089#1080#1089#1090#1077#1084#1091
  OnShow = UniLoginFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  ClientEvents.ExtEvents.Strings = (
    
      'window.afterlayout=function window.afterlayout(sender, layout, e' +
      'Opts)'#13#10'{'#13#10'    var me=this;'#13#10'    window.addEventListener('#39'resize'#39 +
      ', function(){me.center()});'#13#10'}'
    
      'window.afterrender=function window.afterrender(sender, eOpts)'#13#10'{' +
      #13#10'  //var me=sender.getEl();'#13#10'    //if (me) {'#13#10'       // me.setS' +
      'tyle("padding", 0);'#13#10'        //me.setStyle("border-width", 0);'#13#10 +
      '        //me.setStyle("margin", 0);'#13#10'        //me.setStyle("-web' +
      'kit-border-radius", 5);'#13#10'        //me.setStyle("-moz-'#65279'border-rad' +
      'ius", 5);      '#13#10'    //}   '#13#10'}'
    
      'window.resize=function window.resize(sender, width, height, oldW' +
      'idth, oldHeight, eOpts)'#13#10'{'#13#10'//'#13#10'}')
  ClientEvents.UniEvents.Strings = (
    
      'window.beforeInit=function window.beforeInit(sender, config)'#13#10'{'#13 +
      #10'  config.shadow=false;'#13#10'}')
  LayoutConfig.Cls = 'login-form login-container'
  TextHeight = 15
  object loginbox: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 400
    Hint = #1055#1072#1088#1086#1083#1100
    ParentColor = False
    Align = alClient
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 0
    LayoutConfig.Cls = 'login-box'
    ExplicitWidth = 533
    ExplicitHeight = 391
    DesignSize = (
      400
      400)
    object btnOk: TUniButton
      Left = 95
      Top = 303
      Width = 225
      Height = 33
      Hint = ''
      Caption = #1042#1086#1081#1090#1080
      TabOrder = 1
      OnClick = btnOkClick
    end
    object edtUser: TUniEdit
      AlignWithMargins = True
      Left = 95
      Top = 110
      Width = 225
      Hint = #1051#1086#1075#1080#1085
      ShowHint = True
      ParentShowHint = False
      BorderStyle = ubsNone
      Text = ''
      ParentFont = False
      Font.Height = -12
      TabOrder = 2
      EmptyText = #1051#1086#1075#1080#1085
      FieldLabelAlign = laTop
      InputType = 'email'
    end
    object edtPas: TUniEdit
      AlignWithMargins = True
      Left = 95
      Top = 170
      Width = 225
      Hint = #1055#1072#1088#1086#1083#1100
      ShowHint = True
      ParentShowHint = False
      PasswordChar = '*'
      CharEOL = '*'
      BorderStyle = ubsNone
      Text = ''
      ParentFont = False
      Font.Height = -12
      TabOrder = 3
      EmptyText = #1055#1072#1088#1086#1083#1100
      FieldLabelAlign = laTop
    end
    object UniCheckBox1: TUniCheckBox
      AlignWithMargins = True
      Left = 95
      Top = 214
      Width = 97
      Height = 17
      Hint = ''
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
      TabOrder = 4
      LayoutConfig.Cls = 'remember-checkbox'
    end
    object lblReset: TUniLabel
      Left = 234
      Top = 214
      Width = 246
      Height = 17
      Cursor = crHandPoint
      Hint = ''
      Visible = False
      AutoSize = False
      Caption = #1047#1072#1073#1099#1083' '#1087#1072#1088#1086#1083#1100
      Anchors = [akLeft, akTop, akRight]
      ParentFont = False
      Font.Color = clHighlight
      Font.Height = -13
      ParentColor = False
      Color = clHighlight
      TabOrder = 5
    end
    object UniLabel2: TUniLabel
      Left = 95
      Top = 45
      Width = 225
      Height = 13
      Hint = ''
      AutoSize = False
      Caption = #1042#1093#1086#1076' '#1074' '#1089#1080#1089#1090#1077#1084#1091
      TabOrder = 6
      LayoutConfig.Cls = 'login-title'
    end
  end
end
