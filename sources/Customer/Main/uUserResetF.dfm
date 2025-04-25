object UserResetF: TUserResetF
  Left = 0
  Top = 0
  ClientHeight = 400
  ClientWidth = 400
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1074' '#1089#1080#1089#1090#1077#1084#1077
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
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
  Layout = 'fit'
  LayoutConfig.Cls = 'login-form login-container'
  LayoutConfig.Region = 'center'
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
    ExplicitLeft = 64
    ExplicitTop = 80
    DesignSize = (
      400
      400)
    object btnCancel: TUniButton
      Left = 55
      Top = 295
      Width = 143
      Height = 33
      Hint = ''
      Caption = #1053#1072#1079#1072#1076
      Cancel = True
      Anchors = []
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnOk: TUniButton
      Left = 217
      Top = 295
      Width = 140
      Height = 33
      Hint = ''
      Caption = #1057#1073#1088#1086#1089' '#1087#1072#1088#1086#1083#1103
      Anchors = []
      TabOrder = 2
      ScreenMask.Enabled = True
      ScreenMask.Message = #1054#1087#1077#1088#1072#1094#1080#1103' '#1074#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103' ...'
      ScreenMask.Target = Owner
      OnClick = btnOkClick
    end
    object edtEmail: TUniEdit
      Left = 55
      Top = 186
      Width = 302
      Hint = #1055#1086#1095#1090#1072
      ShowHint = True
      ParentShowHint = False
      BorderStyle = ubsNone
      Text = ''
      TabOrder = 3
      EmptyText = #1055#1086#1095#1090#1072
      InputType = 'email'
    end
    object UniContainerPanel1: TUniContainerPanel
      Left = 55
      Top = 131
      Width = 302
      Height = 49
      Hint = ''
      ParentColor = False
      TabOrder = 4
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
        ExplicitTop = -5
      end
    end
    object UniLabel1: TUniLabel
      Left = 58
      Top = 45
      Width = 299
      Height = 13
      Hint = ''
      AutoSize = False
      Caption = #1042#1093#1086#1076' '#1074' '#1089#1080#1089#1090#1077#1084#1091
      TabOrder = 5
      LayoutConfig.Cls = 'login-title'
    end
  end
end
