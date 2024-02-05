object LoginF: TLoginF
  Left = 0
  Top = 0
  ClientHeight = 388
  ClientWidth = 778
  Caption = #1042#1093#1086#1076' '#1074' '#1089#1080#1089#1090#1077#1084#1091
  OnShow = UniLoginFormShow
  BorderStyle = bsNone
  Position = poDesktopCenter
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  ClientEvents.ExtEvents.Strings = (
    
      'window.afterrender=function window.afterrender(sender, eOpts)'#13#10'{' +
      #13#10'  var me=sender.getEl();'#13#10'    if (me) {'#13#10'        me.setStyle("' +
      'padding", 0);'#13#10'        //me.setStyle("border-width", 1);'#13#10'      ' +
      '  me.setStyle("border-width", 0);'#13#10'        me.setStyle("-webkit-' +
      'border-radius", 0);'#13#10'        me.setStyle("-moz-'#65279'border-radius", ' +
      '0);'#13#10'        me.setStyle("border-radius", 0);'#13#10'    }'#13#10'}')
  Layout = 'fit'
  LayoutAttribs.Align = 'stretch'
  TextHeight = 15
  object UniPanel1: TUniPanel
    Left = 114
    Top = 35
    Width = 554
    Height = 313
    Hint = ''
    TabOrder = 0
    BorderStyle = ubsNone
    ShowCaption = False
    Caption = 'UniPanel1'
    object UniLabel1: TUniLabel
      Left = 82
      Top = 79
      Width = 77
      Height = 13
      Hint = ''
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
      TabOrder = 1
    end
    object UniLabel2: TUniLabel
      Left = 82
      Top = 118
      Width = 43
      Height = 13
      Hint = ''
      Caption = #1055#1072#1088#1086#1083#1100':'
      TabOrder = 2
    end
    object btnOk: TUniButton
      Left = 364
      Top = 220
      Width = 105
      Height = 25
      Hint = ''
      Caption = #1042#1086#1081#1090#1080
      TabOrder = 3
      OnClick = btnOkClick
    end
    object edtUser: TUniEdit
      Left = 244
      Top = 79
      Width = 225
      Hint = ''
      MaxLength = 64
      Text = ''
      TabOrder = 4
    end
    object edtPas: TUniEdit
      Left = 244
      Top = 118
      Width = 225
      Hint = ''
      PasswordChar = '*'
      MaxLength = 64
      CharEOL = '*'
      Text = ''
      TabOrder = 5
    end
    object btnCancel: TUniButton
      Left = 244
      Top = 220
      Width = 105
      Height = 25
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Cancel = True
      TabOrder = 6
      OnClick = btnCancelClick
    end
    object UniCheckBox1: TUniCheckBox
      Left = 244
      Top = 167
      Width = 97
      Height = 17
      Hint = ''
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
      TabOrder = 7
    end
    object btnRegister: TUniButton
      Left = 82
      Top = 220
      Width = 121
      Height = 25
      Hint = ''
      Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100#1089#1103
      TabOrder = 8
      LayoutConfig.Cls = 'btn-register'
      OnClick = btnRegisterClick
    end
  end
end
