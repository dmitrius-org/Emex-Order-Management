object UserRegisterF: TUserRegisterF
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
    Left = 273
    Top = 90
    Width = 325
    Hint = ''
    MaxLength = 64
    Text = ''
    ParentFont = False
    TabOrder = 0
    FieldLabelWidth = 5
    FieldLabelFont.Color = clCrimson
  end
  object edtPassword: TUniEdit
    Left = 273
    Top = 164
    Width = 325
    Hint = ''
    PasswordChar = '*'
    MaxLength = 64
    CharEOL = '*'
    Text = ''
    ParentFont = False
    TabOrder = 1
    FieldLabelWidth = 5
    FieldLabelFont.Color = clCrimson
  end
  object btnCancel: TUniButton
    Left = 288
    Top = 287
    Width = 143
    Height = 25
    Hint = ''
    Caption = #1053#1072#1079#1072#1076
    Cancel = True
    Anchors = []
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnOk: TUniButton
    Left = 444
    Top = 287
    Width = 140
    Height = 25
    Hint = ''
    Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100#1089#1103
    Anchors = []
    TabOrder = 3
    ScreenMask.Enabled = True
    ScreenMask.Message = #1054#1087#1077#1088#1072#1094#1080#1103' '#1074#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103' ...'
    ScreenMask.Target = Owner
    OnClick = btnOkClick
  end
  object UniLabel1: TUniLabel
    Left = 145
    Top = 94
    Width = 36
    Height = 13
    Hint = ''
    Caption = #1055#1086#1095#1090#1072':'
    TabOrder = 4
  end
  object UniLabel2: TUniLabel
    Left = 145
    Top = 167
    Width = 43
    Height = 13
    Hint = ''
    Caption = #1055#1072#1088#1086#1083#1100':'
    TabOrder = 5
  end
  object edtBrief: TUniEdit
    Left = 273
    Top = 53
    Width = 325
    Hint = ''
    MaxLength = 128
    Text = ''
    ParentFont = False
    TabOrder = 6
    FieldLabelWidth = 5
    FieldLabelFont.Color = clCrimson
  end
  object UniLabel3: TUniLabel
    Left = 145
    Top = 53
    Width = 107
    Height = 13
    Hint = ''
    Caption = #1048#1084#1103' / '#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103':'
    TabOrder = 7
  end
  object edtPhone: TUniEdit
    Left = 273
    Top = 126
    Width = 325
    Hint = ''
    MaxLength = 64
    CharEOL = '*'
    Text = ''
    ParentFont = False
    TabOrder = 8
    FieldLabelWidth = 5
    FieldLabelFont.Color = clCrimson
  end
  object UniLabel4: TUniLabel
    Left = 145
    Top = 129
    Width = 49
    Height = 13
    Hint = ''
    Caption = #1058#1077#1083#1077#1092#1086#1085':'
    TabOrder = 9
  end
  object edtContactPerson: TUniEdit
    Left = 273
    Top = 203
    Width = 325
    Hint = ''
    MaxLength = 256
    CharEOL = '*'
    Text = ''
    TabOrder = 10
    FieldLabelWidth = 5
  end
  object UniLabel5: TUniLabel
    Left = 145
    Top = 206
    Width = 95
    Height = 13
    Hint = ''
    Caption = #1050#1086#1085#1090#1072#1082#1090#1085#1086#1077' '#1083#1080#1094#1086':'
    TabOrder = 11
  end
  object UniLabel6: TUniLabel
    Left = 8
    Top = 344
    Width = 191
    Height = 13
    Hint = ''
    Caption = '* - '#1087#1086#1083#1077' '#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1086' '#1082' '#1079#1072#1087#1086#1083#1085#1077#1085#1080#1102
    Anchors = [akLeft, akBottom]
    ParentFont = False
    Font.Color = clCrimson
    TabOrder = 12
  end
  object UniLabel7: TUniLabel
    Left = 604
    Top = 53
    Width = 5
    Height = 13
    Hint = ''
    Caption = '*'
    Anchors = [akLeft, akBottom]
    ParentFont = False
    Font.Color = clCrimson
    TabOrder = 13
  end
  object UniLabel8: TUniLabel
    Left = 604
    Top = 126
    Width = 5
    Height = 13
    Hint = ''
    Caption = '*'
    Anchors = [akLeft, akBottom]
    ParentFont = False
    Font.Color = clCrimson
    TabOrder = 14
  end
  object UniLabel9: TUniLabel
    Left = 604
    Top = 90
    Width = 5
    Height = 13
    Hint = ''
    Caption = '*'
    Anchors = [akLeft, akBottom]
    ParentFont = False
    Font.Color = clCrimson
    TabOrder = 15
  end
  object UniLabel10: TUniLabel
    Left = 604
    Top = 164
    Width = 5
    Height = 13
    Hint = ''
    Caption = '*'
    Anchors = [akLeft, akBottom]
    ParentFont = False
    Font.Color = clCrimson
    TabOrder = 16
  end
end
