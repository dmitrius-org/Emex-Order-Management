object OrderF: TOrderF
  Left = 0
  Top = 0
  ClientHeight = 806
  ClientWidth = 1007
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1079#1072#1082#1072#1079#1072
  OnShow = UniFormShow
  Position = poDesktopCenter
  OldCreateOrder = False
  ShowHint = True
  MonitoredKeys.Keys = <>
  ClientEvents.UniEvents.Strings = (
    
      'window.beforeInit=function window.beforeInit(sender, config)'#13#10'{'#13 +
      #10'      config.style={'#39'overflow'#39': '#39'visible'#39'};'#13#10'      sender.actio' +
      'n = '#39'badgetext'#39';'#13#10'      sender.plugins = ['#13#10'                    ' +
      '        {'#13#10'                                ptype:'#39'badgetext'#39','#13#10' ' +
      '                               defaultText: '#39#39','#13#10'               ' +
      '                 textSize: 16,'#13#10'                                ' +
      'disableOpacity:1,'#13#10'                                disableBg: '#39'#' +
      '157fcc'#39','#13#10'                                enableBg: '#39'#157fcc'#39','#13#10 +
      '                                align:'#39'right'#39','#13#10'                ' +
      '                top:-25'#13#10'                            }'#13#10'        ' +
      '              ];'#13#10'}')
  LayoutConfig.Cls = 'x-header-orderf'
  Images = UniNativeImageList1
  ToolButtons = <
    item
      Action = actProtocol
      ButtonId = 1
      ImageIndex = 0
      Hint = #1055#1088#1086#1090#1086#1082#1086#1083
    end
    item
      Action = actRefreshFormData
      ButtonId = 0
      ImageIndex = 1
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
    end>
  OnReady = UniFormReady
  OnDestroy = UniFormDestroy
  TextHeight = 15
  object tabCommon: TUniFieldContainer
    Left = 0
    Top = 0
    Width = 1007
    Height = 335
    Hint = ''
    ShowHint = True
    ParentColor = False
    Align = alTop
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 0
    DesignSize = (
      1007
      335)
    object cbNoAir: TUniCheckBox
      Left = 116
      Top = 182
      Width = 50
      Height = 17
      Hint = ''
      ShowHint = True
      Caption = 'NoAir'
      TabOrder = 19
    end
    object cbFragile: TUniCheckBox
      Left = 171
      Top = 182
      Width = 61
      Height = 17
      Hint = #1046#1088#1091#1087#1082#1080#1081
      ShowHint = True
      Caption = 'Fragile'
      TabOrder = 20
    end
    object lblWeightKGF: TUniLabel
      Left = 17
      Top = 102
      Width = 90
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1042#1077#1089' '#1092#1080#1079#1080#1095#1077#1089#1082#1080#1081':'
      TabOrder = 10
    end
    object lblVolumeKGF: TUniLabel
      Left = 17
      Top = 144
      Width = 81
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1042#1077#1089' '#1086#1073#1098#1077#1084#1085#1099#1081':'
      TabOrder = 17
    end
    object lblDetailNameF: TUniLabel
      Left = 17
      Top = 66
      Width = 84
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      TabOrder = 4
    end
    object UniGroupBox1: TUniGroupBox
      Left = 280
      Top = 87
      Width = 104
      Height = 124
      Hint = 
        '|('#1044#1083#1080#1085#1072' (1-'#1103' '#1075#1088#1072#1092#1072') '#1061' '#1064#1080#1088#1080#1085#1072' (2-'#1103' '#1075#1088#1072#1092#1072') '#1061' '#1042#1099#1089#1086#1090#1072' (3-'#1103' '#1075#1088#1072#1092#1072')) /' +
        ' 5000'#13#10#1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1086#1082#1088#1091#1075#1083#1103#1077#1084' '#1076#1086' '#1076#1077#1089#1103#1090#1099#1093' '
      ShowHint = True
      Caption = #1056#1072#1079#1084#1077#1088
      Layout = 'vbox'
      LayoutAttribs.Align = 'center'
      LayoutAttribs.Pack = 'start'
      LayoutAttribs.Padding = '1'
      LayoutConfig.Padding = '0'
      LayoutConfig.Margin = '0'
      TabOrder = 7
      object edtL: TUniNumberEdit
        Left = 3
        Top = 15
        Width = 86
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        ParentFont = False
        Font.Height = -13
        TabOrder = 1
        FieldLabel = 'L'
        FieldLabelWidth = 15
        LayoutConfig.Padding = '0'
        LayoutConfig.Margin = '0'
        DecimalSeparator = ','
        OnKeyDown = edtLKeyDown
      end
      object edtW: TUniNumberEdit
        Left = 3
        Top = 38
        Width = 86
        Hint = ''
        ShowHint = True
        ParentFont = False
        Font.Height = -13
        TabOrder = 2
        FieldLabel = 'W'
        FieldLabelWidth = 15
        LayoutConfig.Padding = '0'
        LayoutConfig.Margin = '1'
        DecimalSeparator = ','
        OnKeyDown = edtLKeyDown
      end
      object edtH: TUniNumberEdit
        Left = 3
        Top = 61
        Width = 86
        Hint = ''
        ShowHint = True
        ParentFont = False
        Font.Height = -13
        TabOrder = 3
        FieldLabel = 'H'
        FieldLabelWidth = 15
        LayoutConfig.Padding = '0'
        LayoutConfig.Margin = '1'
        DecimalSeparator = ','
        OnKeyDown = edtLKeyDown
      end
      object edtVKG: TUniNumberEdit
        Left = 3
        Top = 84
        Width = 86
        Hint = ''
        ShowHint = True
        ParentFont = False
        Font.Height = -13
        TabOrder = 4
        ReadOnly = True
        FieldLabel = 'VKG'
        FieldLabelWidth = 30
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        LayoutConfig.Padding = '0'
        LayoutConfig.Margin = '1'
        DecimalPrecision = 1
        DecimalSeparator = ','
        OnKeyDown = edtVKGKeyDown
      end
    end
    object UniGroupBox2: TUniGroupBox
      Left = 16
      Top = 3
      Width = 228
      Height = 56
      Hint = ''
      ShowHint = True
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100':'
      TabOrder = 1
      object btnNumber: TUniButton
        AlignWithMargins = True
        Left = 9
        Top = 20
        Width = 96
        Height = 25
        Hint = ''
        ShowHint = True
        Caption = #1053#1086#1084#1077#1088
        TabStop = False
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
            'pyToClipboard = str => {'#13#10'        console.log('#39#1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1089#1090 +
            ': '#39' + str);'#13#10'        const el = document.createElement('#39'textarea' +
            #39');'#13#10'        el.value = str;'#13#10'        document.body.appendChild(' +
            'el);'#13#10'        el.select();'#13#10'        document.execCommand('#39'copy'#39')' +
            ';'#13#10'        document.body.removeChild(el);'#13#10'    };'#13#10'}')
        OnClick = btnNumberClick
      end
      object btnNumber2: TUniButton
        AlignWithMargins = True
        Left = 111
        Top = 20
        Width = 105
        Height = 25
        Hint = ''
        ShowHint = True
        Caption = #1041#1088#1077#1085#1076' + '#1053#1086#1084#1077#1088
        TabStop = False
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'copyToClipboard = str => {'#13#10'        console.log('#39#1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082 +
            #1089#1090': '#39' + str);'#13#10'        const el = document.createElement('#39'textar' +
            'ea'#39');'#13#10'        el.value = str;'#13#10'        document.body.appendChil' +
            'd(el);'#13#10'        el.select();'#13#10'        document.execCommand('#39'copy' +
            #39');'#13#10'        document.body.removeChild(el);'#13#10'    };'#13#10'}')
        OnClick = btnNumber2Click
      end
    end
    object UniGroupBox3: TUniGroupBox
      Left = 250
      Top = 3
      Width = 741
      Height = 56
      Hint = ''
      ShowHint = True
      Caption = #1055#1086#1080#1089#1082':'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      object btnGoogleImages: TUniButton
        AlignWithMargins = True
        Left = 13
        Top = 20
        Width = 107
        Height = 25
        Hint = ''
        ShowHint = True
        Caption = 'Google '#1082#1072#1088#1090#1080#1085#1082#1080
        TabStop = False
        TabOrder = 1
        OnClick = btnGoogleImagesClick
      end
      object btnYandexImages: TUniButton
        AlignWithMargins = True
        Left = 126
        Top = 20
        Width = 107
        Height = 25
        Hint = ''
        ShowHint = True
        Caption = 'Yandex '#1082#1072#1088#1090#1080#1085#1082#1080
        TabStop = False
        TabOrder = 2
        OnClick = btnYandexImagesClick
      end
      object btnExist: TUniButton
        AlignWithMargins = True
        Left = 239
        Top = 20
        Width = 107
        Height = 25
        Hint = ''
        ShowHint = True
        Caption = 'Exist'
        TabStop = False
        TabOrder = 3
        OnClick = btnExistClick
      end
      object btnZZAP: TUniButton
        AlignWithMargins = True
        Left = 352
        Top = 20
        Width = 107
        Height = 25
        Hint = ''
        ShowHint = True
        Caption = 'ZZAP'
        TabStop = False
        TabOrder = 4
        OnClick = btnZZAPClick
      end
      object btnEmEx: TUniButton
        AlignWithMargins = True
        Left = 465
        Top = 20
        Width = 107
        Height = 25
        Hint = ''
        ShowHint = True
        Caption = 'EmEx DWC'
        TabStop = False
        TabOrder = 5
        OnClick = btnEmExClick
      end
    end
    object UniLabel1: TUniLabel
      Left = 17
      Top = 182
      Width = 77
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103':'
      TabOrder = 18
    end
    object UniBitBtn1: TUniBitBtn
      Left = 874
      Top = 187
      Width = 22
      Height = 24
      Hint = #1042#1082#1083#1102#1095#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1077' '#1083#1086#1075#1086
      ShowHint = True
      Caption = ''
      Anchors = [akTop, akRight]
      TabOrder = 13
      IconAlign = iaCenter
      IconPosition = ipButtonEdge
      Images = UniMainModule.BaseImage16
      ImageIndex = 1
      OnClick = UniBitBtn1Click
    end
    object btnDestinationLogo: TUniBitBtn
      Left = 874
      Top = 159
      Width = 22
      Height = 24
      Hint = #1042#1082#1083#1102#1095#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1077' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1103
      ShowHint = True
      Caption = ''
      Anchors = [akTop, akRight]
      TabOrder = 9
      IconAlign = iaCenter
      IconPosition = ipButtonEdge
      Images = UniMainModule.BaseImage16
      ImageIndex = 1
      OnClick = btnDestinationLogoClick
    end
    object UniGroupBox5: TUniGroupBox
      AlignWithMargins = True
      Left = 125
      Top = 87
      Width = 72
      Height = 42
      Hint = ''
      ShowHint = True
      Caption = #1055#1088#1072#1081#1089
      Layout = 'vbox'
      TabOrder = 5
      object edtWeightKG: TUniNumberEdit
        Left = 2
        Top = 15
        Width = 68
        Hint = ''
        Enabled = False
        ShowHint = True
        BorderStyle = ubsNone
        TabOrder = 1
        ReadOnlyMode = urmNotEditable
        DecimalPrecision = 3
        DecimalSeparator = ','
      end
    end
    object UniGroupBox6: TUniGroupBox
      Left = 201
      Top = 87
      Width = 70
      Height = 42
      Hint = ''
      ShowHint = True
      Caption = #1060#1072#1082#1090
      Layout = 'vbox'
      TabOrder = 6
      object edtWeightKGF: TUniNumberEdit
        Left = 3
        Top = 14
        Width = 66
        Hint = ''
        ShowHint = True
        BorderStyle = ubsNone
        TabOrder = 1
        BlankValue = 0
        DecimalPrecision = 3
        DecimalSeparator = ','
        OnChange = edtWeightKGFChange
        OnKeyDown = edtWeightKGFKeyDown
      end
    end
    object UniGroupBox7: TUniGroupBox
      Left = 125
      Top = 129
      Width = 72
      Height = 42
      Hint = ''
      ShowHint = True
      Caption = #1055#1088#1072#1081#1089
      Layout = 'vbox'
      TabOrder = 14
      object edtVolumeKG: TUniNumberEdit
        Left = 2
        Top = 15
        Width = 68
        Hint = ''
        Enabled = False
        ShowHint = True
        BorderStyle = ubsNone
        TabOrder = 1
        ReadOnlyMode = urmNotEditable
        DecimalPrecision = 3
        DecimalSeparator = ','
      end
    end
    object UniGroupBox8: TUniGroupBox
      Left = 201
      Top = 129
      Width = 70
      Height = 42
      Hint = ''
      ShowHint = True
      Caption = #1060#1072#1082#1090
      Layout = 'vbox'
      TabOrder = 15
      object edtVolumeKGF: TUniNumberEdit
        Left = 2
        Top = 15
        Width = 66
        Hint = ''
        ShowHint = True
        BorderStyle = ubsNone
        TabOrder = 1
        BlankValue = 0
        DecimalPrecision = 3
        DecimalSeparator = ','
        OnChange = edtVolumeKGFChange
      end
    end
    object UniLabel11: TUniLabel
      Left = 390
      Top = 163
      Width = 52
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1044#1086#1089#1090#1072#1074#1082#1072':'
      TabOrder = 11
    end
    object UniLabel12: TUniLabel
      Left = 390
      Top = 191
      Width = 62
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
      TabOrder = 16
    end
    object UniGroupBox9: TUniGroupBox
      Left = 16
      Top = 211
      Width = 975
      Height = 60
      Hint = ''
      ShowHint = True
      Caption = #1055#1086#1082#1072#1079#1072#1090#1077#1083#1080' '#1076#1086' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Anchors = [akLeft, akTop, akRight]
      Layout = 'column'
      LayoutAttribs.Align = 'top'
      LayoutAttribs.Pack = 'center'
      LayoutAttribs.Padding = '1'
      LayoutAttribs.Columns = 9
      LayoutConfig.ComponentCls = 'order-indicators'
      TabOrder = 21
      object edtPrice: TUniEdit
        Left = 3
        Top = 17
        Width = 132
        Hint = ''
        Margins.Top = 0
        Margins.Right = 0
        ShowHint = True
        Text = ''
        TabOrder = 1
        ReadOnly = True
        FieldLabel = #1047#1072#1082#1091#1087#1082#1072
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtMargin: TUniEdit
        Left = 128
        Top = 18
        Width = 65
        Hint = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 2
        ReadOnly = True
        FieldLabel = #1053#1072#1094#1077#1085#1082#1072
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtMarginF: TUniEdit
        Left = 196
        Top = 21
        Width = 80
        Hint = #1053#1072#1094#1077#1085#1082#1072' '#1092#1072#1082#1090
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 3
        ReadOnly = True
        FieldLabel = #1053#1072#1094#1077#1085#1082#1072'  '#1092#1072#1082#1090
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtIncome: TUniEdit
        Left = 279
        Top = 22
        Width = 65
        Hint = ''
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 4
        ReadOnly = True
        FieldLabel = #1044#1086#1093#1086#1076
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtProfit: TUniEdit
        Left = 347
        Top = 23
        Width = 90
        Hint = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 5
        ReadOnly = True
        FieldLabel = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtReliabilityGroup: TUniFieldContainer
        Left = 455
        Top = 19
        Width = 121
        Height = 35
        Hint = ''
        ShowHint = True
        ParentColor = False
        FieldLabel = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100
        FieldLabelWidth = 100
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        TabOrder = 6
        Layout = 'vbox'
        LayoutAttribs.Align = 'end'
        LayoutAttribs.Pack = 'end'
        LayoutConfig.Padding = '1'
        LayoutConfig.Margin = '3'
        object edtReliability: TUniHTMLFrame
          Left = 0
          Top = 15
          Width = 121
          Height = 22
          Hint = ''
          Margins.Left = 0
          Margins.Top = 5
          Margins.Right = 0
          Margins.Bottom = 0
          ShowHint = True
          HTML.Strings = (
            '<fieldset class="rating">'
            
              '    <input type="radio" id="star100" name="rating" value="100"/>' +
              '<label class="full" for="star5"     title="100 %"></label>'
            
              '    <input type="radio" id="star90"  name="rating" value="90" />' +
              '<label class="half" for="star4half" title="90 %"></label>'
            
              '    <input type="radio" id="star80"  name="rating" value="80" />' +
              '<label class="full" for="star4"     title="80 %"></label>'
            
              '    <input type="radio" id="star70"  name="rating" value="70" />' +
              '<label class="half" for="star3half" title="70 %"></label>'
            
              '    <input type="radio" id="star60"  name="rating" value="60" />' +
              '<label class="full" for="star3"     title="60 %"></label>'
            
              '    <input type="radio" id="star50"  name="rating" value="50" />' +
              '<label class="half" for="star2half" title="50 %"></label>'
            
              '    <input type="radio" id="star40"  name="rating" value="40" />' +
              '<label class="full" for="star2"     title="40 %"></label>'
            
              '    <input type="radio" id="star30"  name="rating" value="30" />' +
              '<label class="half" for="star1half" title="30 %"></label>'
            
              '    <input type="radio" id="star20"  name="rating" value="20" />' +
              '<label class="full" for="star1"     title="20 %"></label>'
            
              '    <input type="radio" id="star10"  name="rating" value="10" />' +
              '<label class="half" for="starhalf"  title="10 %"></label>'
            
              '    <input type="radio" id="star"    name="rating" value="1" /><' +
              'label  class="half" for=""      title="0 %"></label>     '
            '</fieldset>'
            '<label id="prc" class="ratingprc"></label>')
          ScreenMask.WaitData = True
          LayoutConfig.IgnorePosition = False
          LayoutConfig.DockWhenAligned = False
        end
      end
      object edtDelivery: TUniEdit
        Left = 579
        Top = 35
        Width = 174
        Hint = '12'#13#10'12'
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 7
        ReadOnly = True
        FieldLabel = #1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtCount: TUniEdit
        Left = 756
        Top = 35
        Width = 124
        Hint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074' '#1079#1072#1082#1072#1079#1077'/'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074' '#1087#1088#1072#1081#1089#1077
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 8
        ReadOnly = True
        FieldLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
    end
    object UniGroupBox4: TUniGroupBox
      Left = 16
      Top = 271
      Width = 975
      Height = 60
      Hint = ''
      ShowHint = True
      Caption = #1055#1086#1082#1072#1079#1072#1090#1077#1083#1080' '#1087#1086#1089#1083#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Anchors = [akLeft, akTop, akRight]
      Layout = 'column'
      LayoutAttribs.Align = 'top'
      LayoutAttribs.Pack = 'center'
      LayoutAttribs.Padding = '1'
      LayoutAttribs.Columns = 9
      LayoutConfig.ComponentCls = 'order-indicators'
      TabOrder = 22
      object edtPrice2: TUniEdit
        Left = 3
        Top = 18
        Width = 132
        Hint = ''
        Margins.Top = 0
        Margins.Right = 0
        ShowHint = True
        Text = ''
        TabOrder = 1
        ReadOnly = True
        FieldLabel = #1047#1072#1082#1091#1087#1082#1072
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtMargin2: TUniEdit
        Left = 128
        Top = 18
        Width = 65
        Hint = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 2
        ReadOnly = True
        FieldLabel = #1053#1072#1094#1077#1085#1082#1072
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtMarginF2: TUniEdit
        Left = 196
        Top = 19
        Width = 80
        Hint = #1053#1072#1094#1077#1085#1082#1072' '#1092#1072#1082#1090
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 3
        ReadOnly = True
        FieldLabel = #1053#1072#1094#1077#1085#1082#1072'  '#1092#1072#1082#1090
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtIncome2: TUniEdit
        Left = 279
        Top = 20
        Width = 65
        Hint = ''
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 4
        ReadOnly = True
        FieldLabel = #1044#1086#1093#1086#1076
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtProfit2: TUniEdit
        Left = 347
        Top = 19
        Width = 90
        Hint = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 5
        ReadOnly = True
        FieldLabel = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtReliabilityGroup2: TUniFieldContainer
        Left = 448
        Top = 14
        Width = 121
        Height = 39
        Hint = ''
        ShowHint = True
        ParentColor = False
        FieldLabel = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100
        FieldLabelWidth = 100
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        TabOrder = 6
        Layout = 'vbox'
        LayoutAttribs.Align = 'center'
        LayoutAttribs.Pack = 'center'
        LayoutConfig.Padding = '1'
        LayoutConfig.Margin = '3'
        object NotExists: TUniLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 64
          Height = 13
          Hint = ''
          Visible = False
          ShowHint = True
          Alignment = taCenter
          Caption = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093
          Align = alClient
          ParentFont = False
          Font.Color = clRed
          Font.Style = [fsBold]
          TabOrder = 1
          LayoutConfig.IgnorePosition = False
          LayoutConfig.Margin = '8px 0px 0px 0px'
          LayoutConfig.DockWhenAligned = False
        end
        object edtReliability2: TUniHTMLFrame
          Left = 0
          Top = 17
          Width = 121
          Height = 22
          Hint = ''
          ShowHint = True
          HTML.Strings = (
            '<fieldset class="rating2">'
            
              '    <input type="radio" id="star1002" name="rating2" value="100"' +
              '/><label class="full" for="star5" title="100 %"></label>'
            
              '    <input type="radio" id="star902"  name="rating2" value="90" ' +
              '/><label class="half" for="star4half" title="90 %"></label>'
            
              '    <input type="radio" id="star802"  name="rating2" value="80" ' +
              '/><label class="full" for="star4" title="80 %"></label>'
            
              '    <input type="radio" id="star702"  name="rating2" value="70" ' +
              '/><label class="half" for="star3half" title="70 %"></label>'
            
              '    <input type="radio" id="star602"  name="rating2" value="60" ' +
              '/><label class="full" for="star3" title="60 %"></label>'
            
              '    <input type="radio" id="star502"  name="rating2" value="50" ' +
              '/><label class="half" for="star2half" title="50 %"></label>'
            
              '    <input type="radio" id="star402"  name="rating2" value="40" ' +
              '/><label class="full" for="star2" title="40 %"></label>'
            
              '    <input type="radio" id="star302"  name="rating2" value="30" ' +
              '/><label class="half" for="star1half" title="30 %"></label>'
            
              '    <input type="radio" id="star202"  name="rating2" value="20" ' +
              '/><label class="full" for="star1" title="20 %"></label>'
            
              '    <input type="radio" id="star102"  name="rating2" value="10" ' +
              '/><label class="half" for="starhalf" title="10 %"></label>'
            
              '    <input type="radio" id="star2"    name="rating2" value="1"  ' +
              '/><label class="half" for="" title="0 %"></label>    '
            '</fieldset>'
            '<label id="prc2" class="ratingprc" ></label>')
          ScreenMask.WaitData = True
          LayoutConfig.IgnorePosition = False
          LayoutConfig.Margin = '8px 0px 0px 0px'
          LayoutConfig.DockWhenAligned = False
        end
      end
      object edtDelivery2: TUniEdit
        Left = 575
        Top = 22
        Width = 174
        Hint = ''
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 7
        ReadOnly = True
        FieldLabel = #1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtCount2: TUniEdit
        Left = 756
        Top = 21
        Width = 124
        Hint = 
          #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074' '#1079#1072#1082#1072#1079#1077'/'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074' '#1087#1088#1072#1081#1089#1077' ('#1052#1080#1085#1080#1084#1072#1083#1100#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' ' +
          #1074' '#1079#1072#1082#1072#1079#1077')'
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 8
        ReadOnly = True
        FieldLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
    end
    object cbDestinationLogo: TUniExComboBox
      Left = 479
      Top = 159
      Width = 389
      Height = 23
      Hint = ''
      Enabled = False
      ShowHint = True
      Text = ''
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 8
      AnyMatch = True
      IconItems = <>
      OnChange = cbDestinationLogoChange
      Value = '-1'
    end
    object edtDetailNameF: TUniComboBox
      Left = 125
      Top = 63
      Width = 866
      Hint = ''
      ShowHint = True
      Text = ''
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
      MinQueryLength = 3
      RemoteQuery = True
      IconItems = <>
      OnRemoteQuery = edtDetailNameFRemoteQuery
    end
    object cbPrice: TUniExComboBox
      Left = 479
      Top = 187
      Width = 389
      Hint = ''
      Enabled = False
      ShowHint = True
      Style = csOwnerDrawFixed
      Text = ''
      Anchors = [akLeft, akTop, akRight]
      ParentFont = False
      Font.Charset = ANSI_CHARSET
      TabOrder = 12
      ClientEvents.ExtEvents.Strings = (
        
          'expand=function expand(field, eOpts)'#13#10'{'#13#10'  //console.log("expand' +
          '");'#13#10'  var store = field.getStore(); // '#1055#1086#1083#1091#1095#1072#1077#1084' store '#1089' '#1076#1072#1085#1085#1099#1084#1080 +
          #13#10'  var items = field.picker.el.query('#39'.x-boundlist-item'#39'); // '#1055 +
          #1086#1083#1091#1095#1072#1077#1084' '#1101#1083#1077#1084#1077#1085#1090#1099' '#1089#1087#1080#1089#1082#1072#13#10'  '#13#10'  items.forEach(function(item, inde' +
          'x) {'#13#10'      var record = store.getAt(index); // '#1041#1077#1088#1077#1084' '#1079#1072#1087#1080#1089#1100' '#1080#1079' ' +
          'store'#13#10'      //console.log(record);'#13#10'      if (record && record.' +
          'data.tag == 1) {  '#13#10'          //console.log(record);'#13#10'          ' +
          'item.classList.add('#39'price-logo-block'#39'); // '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1083#1072#1089#1089#1099#13#10'   ' +
          '   }'#13#10'  });           '#13#10'}')
      AnyMatch = True
      IconItems = <>
      OnChange = cbPriceChange
      Value = '-1'
    end
    object lblKurs: TUniLabel
      Left = 390
      Top = 94
      Width = 83
      Height = 13
      Hint = ''
      ShowHint = True
      AutoSize = False
      Caption = #1050#1091#1088#1089' '#1085#1072' '#1076#1072#1090#1091' '#1079#1072#1082#1072#1079#1072
      ParentFont = False
      Font.Height = -9
      TabOrder = 23
    end
    object edtKurs: TUniNumberEdit
      Left = 479
      Top = 93
      Width = 94
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ShowHint = True
      ParentFont = False
      Font.Height = -13
      TabOrder = 24
      FieldLabelWidth = 50
      LayoutConfig.Padding = '0'
      LayoutConfig.Margin = '0'
      DecimalSeparator = ','
      OnKeyDown = edtLKeyDown
    end
    object lblCurKurs: TUniLabel
      Left = 594
      Top = 92
      Width = 83
      Height = 24
      Hint = ''
      ShowHint = True
      AutoSize = False
      Caption = #1050#1091#1088#1089' '#1085#1072' '#1090#1077#1082#1091#1097#1091#1102' '#1076#1072#1090#1091
      ParentFont = False
      Font.Height = -9
      TabOrder = 25
    end
    object edtCurKurs: TUniNumberEdit
      Left = 680
      Top = 94
      Width = 94
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ShowHint = True
      ParentFont = False
      Font.Height = -13
      TabOrder = 26
      FieldLabelWidth = 50
      LayoutConfig.Padding = '0'
      LayoutConfig.Margin = '0'
      DecimalSeparator = ','
      OnKeyDown = edtLKeyDown
    end
    object edtCurExtraKurs: TUniNumberEdit
      Left = 680
      Top = 119
      Width = 94
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ShowHint = True
      ParentFont = False
      Font.Height = -13
      TabOrder = 27
      FieldLabelWidth = 50
      LayoutConfig.Padding = '0'
      LayoutConfig.Margin = '0'
      DecimalSeparator = ','
      OnKeyDown = edtLKeyDown
    end
    object lblCurExtraKurs: TUniLabel
      Left = 594
      Top = 119
      Width = 86
      Height = 27
      Hint = ''
      ShowHint = True
      AutoSize = False
      Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1085#1072' '#1090#1077#1082#1091#1097#1091#1102' '#1076#1072#1090#1091
      ParentFont = False
      Font.Height = -9
      TabOrder = 28
    end
    object lblExtraKurs: TUniLabel
      Left = 390
      Top = 119
      Width = 86
      Height = 27
      Hint = ''
      ShowHint = True
      AutoSize = False
      Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1085#1072' '#1076#1072#1090#1091' '#1079#1072#1082#1072#1079#1072
      ParentFont = False
      Font.Height = -9
      TabOrder = 29
    end
    object edtExtraKurs: TUniNumberEdit
      Left = 479
      Top = 119
      Width = 94
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ShowHint = True
      ParentFont = False
      Font.Height = -13
      TabOrder = 30
      FieldLabelWidth = 15
      LayoutConfig.Padding = '0'
      LayoutConfig.Margin = '0'
      DecimalSeparator = ','
      OnKeyDown = edtLKeyDown
    end
    object btnMessage: TUniButton
      Left = 777
      Top = 94
      Width = 91
      Height = 25
      Hint = ''
      ShowHint = True
      Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1103
      TabOrder = 31
      OnClick = btnMessageClick
    end
    object lblChangeW: TUniHTMLFrame
      Left = 90
      Top = 119
      Width = 32
      Height = 28
      Hint = ''
      ShowHint = True
      HTML.Strings = (
        
          '<span class="grid-order-balance-scale" data-qtip="'#1050#1083#1080#1077#1085#1090' '#1080#1079#1084#1077#1085#1080#1083 +
          ' '#1074#1077#1089' '#1076#1077#1090#1072#1083#1080'"><i class="fa fa-balance-scale"></i></span>')
    end
    object btnSplit: TUniBitBtn
      Left = 902
      Top = 159
      Width = 87
      Height = 52
      Hint = ''
      ShowHint = True
      Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1100'<br>'#1079#1072#1082#1072#1079
      Anchors = [akTop, akRight]
      TabOrder = 34
      IconAlign = iaCenter
      IconPosition = ipButtonEdge
      OnClick = btnSplitClick
    end
    object cbNLA: TUniCheckBox
      Left = 232
      Top = 182
      Width = 42
      Height = 17
      Hint = 'No longer available ('#1041#1086#1083#1077#1077' '#1085#1077#1076#1086#1089#1090#1091#1087#1085#1086')'
      ShowHint = True
      Caption = 'NLA'
      TabOrder = 32
    end
  end
  object UniContainerPanel1: TUniContainerPanel
    Left = 0
    Top = 372
    Width = 1007
    Height = 37
    Hint = ''
    ShowHint = True
    ParentColor = False
    Align = alTop
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 1
    LayoutConfig.Padding = '2'
    DesignSize = (
      1007
      37)
    object edtNextPart: TUniCheckBox
      AlignWithMargins = True
      Left = 16
      Top = 10
      Width = 359
      Height = 16
      Hint = ''
      ShowHint = True
      Caption = #1055#1077#1088#1077#1093#1086#1076#1080#1090#1100' '#1082' '#1089#1083#1077#1076#1091#1102#1097#1077#1081' '#1089#1090#1088#1086#1082#1077' '#1087#1086#1089#1083#1077' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103
      Anchors = [akLeft, akBottom]
      TabOrder = 5
    end
    object btnOkToProc: TUniBitBtn
      AlignWithMargins = True
      Left = 829
      Top = 6
      Width = 162
      Height = 27
      Hint = ''
      Margins.Right = 30
      ShowHint = True
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1087#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 1
      OnClick = btnOkToProcClick
    end
    object btnOkToCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 679
      Top = 6
      Width = 144
      Height = 27
      Hint = ''
      Margins.Right = 30
      ShowHint = True
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1086#1090#1082#1072#1079#1072#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 2
      OnClick = btnOkToCancelClick
    end
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 592
      Top = 6
      Width = 82
      Height = 27
      Hint = ''
      Margins.Right = 30
      ShowHint = True
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 3
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 505
      Top = 6
      Width = 81
      Height = 27
      Hint = ''
      ShowHint = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Anchors = [akRight, akBottom]
      TabStop = False
      TabOrder = 4
      OnClick = btnCancelClick
    end
  end
  object UniHTMLFrame1: TUniHTMLFrame
    Left = 0
    Top = 409
    Width = 1007
    Height = 397
    Hint = ''
    ShowHint = True
    AutoScroll = True
    Align = alClient
    ScrollHeight = 397
    ScrollWidth = 1007
  end
  object pnlSplitMessage: TUniContainerPanel
    Left = 0
    Top = 335
    Width = 1007
    Height = 37
    Hint = ''
    ShowHint = True
    ParentColor = False
    Align = alTop
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 3
    LayoutConfig.Padding = '2'
    object lblSplit: TUniLabel
      Left = 25
      Top = 9
      Width = 39
      Height = 17
      Hint = ''
      ShowHint = True
      Caption = 'lblSplit'
      ParentFont = False
      Font.Color = clCrimson
      Font.Height = -13
      TabOrder = 1
    end
  end
  object UniTimer: TUniTimer
    Interval = 500
    Enabled = False
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimerTimer
    Left = 491
    Top = 459
  end
  object UniActionList1: TUniActionList
    Left = 569
    Top = 527
    object actRefreshFormData: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      OnExecute = actRefreshFormDataExecute
    end
    object actProtocol: TAction
      Caption = #1055#1088#1086#1090#1086#1082#1086#1083
      ImageIndex = 4
      ImageName = 'protocol'
      OnExecute = actProtocolExecute
    end
  end
  object UniNativeImageList1: TUniNativeImageList
    Left = 549
    Top = 398
    Images = {
      02000000008080FF061400000063616C656E6461722D636865636B2D6F3B6661
      3B008080FF060B000000726566726573683B66613B}
  end
end
