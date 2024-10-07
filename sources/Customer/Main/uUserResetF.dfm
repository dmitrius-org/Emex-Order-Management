object UserResetF: TUserResetF
  Left = 0
  Top = 0
  ClientHeight = 365
  ClientWidth = 800
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1074' '#1089#1080#1089#1090#1077#1084#1077
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  ClientEvents.ExtEvents.Strings = (
    
      'window.afterlayout=function window.afterlayout(sender, layout, e' +
      'Opts)'#13#10'{'#13#10'    var me=this;'#13#10'    window.addEventListener('#39'resize'#39 +
      ', function(){me.center()});'#13#10'}'
    
      'window.afterrender=function window.afterrender(sender, eOpts)'#13#10'{' +
      #13#10'    var me=sender.getEl();'#13#10'    if (me) {'#13#10'        me.setStyle' +
      '("padding", 0);'#13#10'        me.setStyle("margin", 0);'#13#10'        me.s' +
      'etStyle("border-width", 0);'#13#10'        me.setStyle("-webkit-border' +
      '-radius", 0);'#13#10'        me.setStyle("-moz-'#65279'border-radius", 0);'#13#10' ' +
      '       me.setStyle("border-radius", 0);'#13#10'    }'#13#10'}'
    
      'window.resize=function window.resize(sender, width, height, oldW' +
      'idth, oldHeight, eOpts)'#13#10'{'#13#10'  //'#13#10'}')
  ClientEvents.UniEvents.Strings = (
    
      'window.beforeInit=function window.beforeInit(sender, config)'#13#10'{'#13 +
      #10'    config.shadow=false;'#13#10'}')
  LayoutConfig.Region = 'center'
  DesignSize = (
    800
    365)
  TextHeight = 15
  object edtEmail: TUniEdit
    Left = 241
    Top = 146
    Width = 325
    Hint = ''
    Text = ''
    TabOrder = 0
  end
  object btnCancel: TUniButton
    Left = 241
    Top = 199
    Width = 143
    Height = 25
    Hint = ''
    Caption = #1053#1072#1079#1072#1076
    Cancel = True
    Anchors = []
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnOk: TUniButton
    Left = 426
    Top = 199
    Width = 140
    Height = 25
    Hint = ''
    Caption = #1057#1073#1088#1086#1089' '#1087#1072#1088#1086#1083#1103
    Anchors = []
    TabOrder = 2
    ScreenMask.Enabled = True
    ScreenMask.Message = #1054#1087#1077#1088#1072#1094#1080#1103' '#1074#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103' ...'
    ScreenMask.Target = Owner
    OnClick = btnOkClick
  end
  object UniContainerPanel1: TUniContainerPanel
    Left = 224
    Top = 91
    Width = 356
    Height = 49
    Hint = ''
    ParentColor = False
    TabOrder = 3
    object UniLabel2: TUniLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 491
      Height = 13
      Hint = ''
      Alignment = taCenter
      Caption = 
        #1042#1074#1077#1076#1080#1090#1077' '#1089#1074#1086#1081' '#1072#1076#1088#1077#1089' '#1101#1083#1077#1082#1090#1088#1086#1085#1085#1086#1081' '#1087#1086#1095#1090#1099' '#1085#1080#1078#1077', '#1080' '#1084#1099' '#1074#1099#1096#1083#1077#1084' '#1074#1072#1084' '#1089#1089#1099#1083#1082 +
        #1091' '#1076#1083#1103' '#1089#1073#1088#1086#1089#1072' '#1087#1072#1088#1086#1083#1103'.'
      Align = alTop
      ParentFont = False
      Font.Color = clGrayText
      TabOrder = 1
    end
  end
end
