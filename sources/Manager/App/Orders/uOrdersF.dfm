object OrderF: TOrderF
  Left = 0
  Top = 0
  ClientHeight = 404
  ClientWidth = 867
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1079#1072#1082#1072#1079#1072
  OnShow = UniFormShow
  OldCreateOrder = False
  ShowHint = True
  MonitoredKeys.Keys = <>
  LayoutConfig.Cls = 'x-header-orderf'
  OnReady = UniFormReady
  OnDestroy = UniFormDestroy
  TextHeight = 15
  object tabCommon: TUniFieldContainer
    Left = 0
    Top = 0
    Width = 867
    Height = 404
    Hint = ''
    ShowHint = True
    ParentColor = False
    Align = alClient
    TabOrder = 0
    DesignSize = (
      867
      404)
    object edtNextPart: TUniCheckBox
      AlignWithMargins = True
      Left = 16
      Top = 372
      Width = 361
      Height = 17
      Hint = ''
      ShowHint = True
      Caption = #1055#1077#1088#1077#1093#1086#1076#1080#1090#1100' '#1082' '#1089#1083#1077#1076#1091#1102#1097#1077#1081' '#1089#1090#1088#1086#1082#1077' '#1087#1086#1089#1083#1077' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103
      Anchors = [akLeft, akBottom]
      TabOrder = 29
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
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 355
      Top = 369
      Width = 81
      Height = 27
      Hint = ''
      ShowHint = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Anchors = [akRight, akBottom]
      TabStop = False
      TabOrder = 25
      OnClick = btnCancelClick
    end
    object btnOk: TUniBitBtn
      AlignWithMargins = True
      Left = 442
      Top = 369
      Width = 82
      Height = 27
      Hint = ''
      Margins.Right = 30
      ShowHint = True
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 26
      OnClick = btnOkClick
    end
    object UniGroupBox1: TUniGroupBox
      Left = 267
      Top = 87
      Width = 110
      Height = 124
      Hint = 
        '|('#1044#1083#1080#1085#1072' (1-'#1103' '#1075#1088#1072#1092#1072') '#1061' '#1064#1080#1088#1080#1085#1072' (2-'#1103' '#1075#1088#1072#1092#1072') '#1061' '#1042#1099#1089#1086#1090#1072' (3-'#1103' '#1075#1088#1072#1092#1072')) /' +
        ' 5000'#13#10#1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1086#1082#1088#1091#1075#1083#1103#1077#1084' '#1076#1086' '#1076#1077#1089#1103#1090#1099#1093' '
      ShowHint = True
      AlignmentControl = uniAlignmentClient
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
        OnChange = edtLChange
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
        OnChange = edtLChange
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
        OnChange = edtLChange
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
      Width = 601
      Height = 56
      Hint = ''
      ShowHint = True
      Caption = #1055#1086#1080#1089#1082':'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      object btnGoogleImages: TUniButton
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
      TabOrder = 20
    end
    object UniBitBtn1: TUniBitBtn
      Left = 829
      Top = 128
      Width = 22
      Height = 24
      Hint = #1042#1082#1083#1102#1095#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1077' '#1083#1086#1075#1086
      ShowHint = True
      Caption = ''
      Anchors = [akTop, akRight]
      TabOrder = 13
      IconAlign = iaCenter
      IconPosition = ipButtonEdge
      Images = ImageList16
      ImageIndex = 2
      OnClick = UniBitBtn1Click
    end
    object btnDestinationLogo: TUniBitBtn
      Left = 829
      Top = 100
      Width = 22
      Height = 24
      Hint = #1042#1082#1083#1102#1095#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1077' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1103
      ShowHint = True
      Caption = ''
      Anchors = [akTop, akRight]
      TabOrder = 9
      IconAlign = iaCenter
      IconPosition = ipButtonEdge
      Images = ImageList16
      ImageIndex = 2
      OnClick = btnDestinationLogoClick
    end
    object cbFragile: TUniCheckBox
      Left = 195
      Top = 182
      Width = 66
      Height = 17
      Hint = ''
      ShowHint = True
      Caption = 'Fragile'
      TabOrder = 22
    end
    object cbNoAir: TUniCheckBox
      Left = 117
      Top = 182
      Width = 60
      Height = 17
      Hint = ''
      ShowHint = True
      Caption = 'NoAir'
      TabOrder = 21
    end
    object UniGroupBox5: TUniGroupBox
      AlignWithMargins = True
      Left = 117
      Top = 87
      Width = 72
      Height = 42
      Hint = ''
      ShowHint = True
      AlignmentControl = uniAlignmentClient
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
      Left = 193
      Top = 87
      Width = 70
      Height = 42
      Hint = ''
      ShowHint = True
      AlignmentControl = uniAlignmentClient
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
        OnKeyDown = edtWeightKGFKeyDown
      end
    end
    object UniGroupBox7: TUniGroupBox
      Left = 117
      Top = 129
      Width = 72
      Height = 42
      Hint = ''
      ShowHint = True
      AlignmentControl = uniAlignmentClient
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
      Left = 193
      Top = 129
      Width = 70
      Height = 42
      Hint = ''
      ShowHint = True
      AlignmentControl = uniAlignmentClient
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
        OnKeyDown = edtWeightKGFKeyDown
      end
    end
    object UniLabel11: TUniLabel
      Left = 383
      Top = 104
      Width = 52
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1044#1086#1089#1090#1072#1074#1082#1072':'
      TabOrder = 11
    end
    object UniLabel12: TUniLabel
      Left = 383
      Top = 132
      Width = 62
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
      TabOrder = 16
    end
    object UniLabel13: TUniLabel
      Left = 382
      Top = 160
      Width = 66
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077':'
      TabOrder = 19
    end
    object edtMessage: TUniEdit
      Left = 472
      Top = 156
      Width = 379
      Hint = ''
      ShowHint = True
      Text = ''
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 18
      ClearButton = True
    end
    object UniGroupBox9: TUniGroupBox
      Left = 17
      Top = 211
      Width = 834
      Height = 60
      Hint = ''
      ShowHint = True
      AlignmentControl = uniAlignmentClient
      Caption = #1055#1086#1082#1072#1079#1072#1090#1077#1083#1080' '#1076#1086' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Anchors = [akLeft, akTop, akRight]
      Layout = 'hbox'
      LayoutAttribs.Align = 'top'
      LayoutAttribs.Pack = 'start'
      LayoutAttribs.Padding = '1'
      LayoutAttribs.Columns = 9
      LayoutConfig.ComponentCls = 'order-indicators'
      TabOrder = 23
      object edtPrice: TUniEdit
        Left = 3
        Top = 17
        Width = 122
        Hint = ''
        Margins.Top = 0
        Margins.Right = 0
        ShowHint = True
        Text = ''
        TabOrder = 2
        ReadOnly = True
        FieldLabel = #1047#1072#1082#1091#1087#1082#1072
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtMargin: TUniEdit
        Left = 91
        Top = 18
        Width = 65
        Hint = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 3
        ReadOnly = True
        FieldLabel = #1053#1072#1094#1077#1085#1082#1072
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtMarginF: TUniEdit
        Left = 164
        Top = 26
        Width = 80
        Hint = #1053#1072#1094#1077#1085#1082#1072' '#1092#1072#1082#1090
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 5
        ReadOnly = True
        FieldLabel = #1053#1072#1094#1077#1085#1082#1072'  '#1092#1072#1082#1090
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtIncome: TUniEdit
        Left = 237
        Top = 26
        Width = 65
        Hint = ''
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 6
        ReadOnly = True
        FieldLabel = #1044#1086#1093#1086#1076
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtProfit: TUniEdit
        Left = 310
        Top = 22
        Width = 90
        Hint = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 4
        ReadOnly = True
        FieldLabel = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtReliabilityGroup: TUniFieldContainer
        Left = 403
        Top = 16
        Width = 121
        Height = 35
        Hint = ''
        ShowHint = True
        ParentColor = False
        FieldLabel = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100
        FieldLabelWidth = 100
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        TabOrder = 1
        Layout = 'vbox'
        LayoutAttribs.Align = 'end'
        LayoutAttribs.Pack = 'end'
        LayoutConfig.Padding = '1'
        LayoutConfig.IgnorePosition = False
        LayoutConfig.Margin = '3'
        LayoutConfig.DockWhenAligned = False
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
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          LayoutConfig.IgnorePosition = False
          LayoutConfig.DockWhenAligned = False
        end
      end
      object edtDelivery: TUniEdit
        Left = 527
        Top = 26
        Width = 79
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
      object edtDeliveryClient: TUniEdit
        Left = 609
        Top = 26
        Width = 79
        Hint = ''
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 8
        ReadOnly = True
        FieldLabel = #1057#1088#1086#1082' '#1082#1083#1080#1077#1085#1090#1072
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtCount: TUniEdit
        Left = 699
        Top = 27
        Width = 85
        Hint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074' '#1079#1072#1082#1072#1079#1077'/'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074' '#1087#1088#1072#1081#1089#1077
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 9
        ReadOnly = True
        FieldLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
    end
    object UniGroupBox4: TUniGroupBox
      Left = 17
      Top = 271
      Width = 834
      Height = 60
      Hint = ''
      ShowHint = True
      AlignmentControl = uniAlignmentClient
      Caption = #1055#1086#1082#1072#1079#1072#1090#1077#1083#1080' '#1087#1086#1089#1083#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Anchors = [akLeft, akTop, akRight]
      Layout = 'hbox'
      LayoutAttribs.Align = 'top'
      LayoutAttribs.Pack = 'start'
      LayoutAttribs.Padding = '1'
      LayoutAttribs.Columns = 9
      LayoutConfig.ComponentCls = 'order-indicators'
      TabOrder = 24
      object edtPrice2: TUniEdit
        Left = 3
        Top = 18
        Width = 122
        Hint = ''
        Margins.Top = 0
        Margins.Right = 0
        ShowHint = True
        Text = ''
        TabOrder = 2
        ReadOnly = True
        FieldLabel = #1047#1072#1082#1091#1087#1082#1072
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtMargin2: TUniEdit
        Left = 91
        Top = 18
        Width = 65
        Hint = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 3
        ReadOnly = True
        FieldLabel = #1053#1072#1094#1077#1085#1082#1072
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtMarginF2: TUniEdit
        Left = 164
        Top = 26
        Width = 80
        Hint = #1053#1072#1094#1077#1085#1082#1072' '#1092#1072#1082#1090
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 4
        ReadOnly = True
        FieldLabel = #1053#1072#1094#1077#1085#1082#1072'  '#1092#1072#1082#1090
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtIncome2: TUniEdit
        Left = 237
        Top = 26
        Width = 65
        Hint = ''
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 5
        ReadOnly = True
        FieldLabel = #1044#1086#1093#1086#1076
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtProfit2: TUniEdit
        Left = 310
        Top = 31
        Width = 90
        Hint = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 9
        ReadOnly = True
        FieldLabel = #1056#1077#1085#1090#1072#1073#1077#1083#1100#1085#1086#1089#1090#1100
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtReliabilityGroup2: TUniFieldContainer
        Left = 403
        Top = 11
        Width = 121
        Height = 35
        Hint = ''
        ShowHint = True
        ParentColor = False
        FieldLabel = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100
        FieldLabelWidth = 100
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        TabOrder = 1
        Layout = 'vbox'
        LayoutAttribs.Align = 'end'
        LayoutAttribs.Pack = 'end'
        LayoutConfig.ComponentCls = 'order-rating-body'
        LayoutConfig.Padding = '1'
        LayoutConfig.IgnorePosition = False
        LayoutConfig.Margin = '3'
        LayoutConfig.DockWhenAligned = False
        object NotExists: TUniLabel
          Left = 27
          Top = 3
          Width = 64
          Height = 13
          Hint = ''
          Visible = False
          ShowHint = True
          Caption = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093
          Align = alCustom
          ParentFont = False
          Font.Color = clRed
          Font.Style = [fsBold]
          TabOrder = 1
        end
        object edtReliability2: TUniHTMLFrame
          Left = 0
          Top = 13
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
          Align = alBottom
          ScreenMask.Enabled = True
          ScreenMask.WaitData = True
          LayoutConfig.IgnorePosition = False
          LayoutConfig.DockWhenAligned = False
        end
      end
      object edtDelivery2: TUniEdit
        Left = 527
        Top = 26
        Width = 79
        Hint = ''
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 6
        ReadOnly = True
        FieldLabel = #1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtDeliveryClient2: TUniEdit
        Left = 609
        Top = 26
        Width = 79
        Height = 31
        Hint = ''
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ShowHint = True
        Alignment = taCenter
        Text = ''
        TabOrder = 7
        ReadOnly = True
        FieldLabel = #1057#1088#1086#1082' '#1082#1083#1080#1077#1085#1090#1072
        FieldLabelAlign = laTop
        FieldLabelFont.OverrideDefaults = [ovFontHeight]
        ReadOnlyMode = urmNotEditable
        LayoutConfig.Padding = '1'
      end
      object edtCount2: TUniEdit
        Left = 699
        Top = 27
        Width = 85
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
    object cbDestinationLogo: TUniFSComboBox
      Left = 472
      Top = 100
      Width = 351
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
    object btnOkToCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 530
      Top = 369
      Width = 144
      Height = 27
      Hint = ''
      Margins.Right = 30
      ShowHint = True
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1086#1090#1082#1072#1079#1072#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 27
      OnClick = btnOkToCancelClick
    end
    object btnOkToProc: TUniBitBtn
      AlignWithMargins = True
      Left = 680
      Top = 369
      Width = 171
      Height = 27
      Hint = ''
      Margins.Right = 30
      ShowHint = True
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1087#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100
      Anchors = [akRight, akBottom]
      TabOrder = 28
      OnClick = btnOkToProcClick
    end
    object edtDetailNameF: TUniComboBox
      Left = 116
      Top = 63
      Width = 735
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 3
      MinQueryLength = 3
      RemoteQuery = True
      IconItems = <>
      OnRemoteQuery = edtDetailNameFRemoteQuery
    end
    object cbPrice: TUniFSComboBox
      Left = 472
      Top = 128
      Width = 351
      Hint = ''
      Enabled = False
      ShowHint = True
      Text = ''
      Anchors = [akLeft, akTop, akRight]
      ParentFont = False
      Font.Charset = ANSI_CHARSET
      TabOrder = 12
      AnyMatch = True
      IconItems = <>
      OnChange = cbDestinationLogoChange
      Value = '-1'
    end
  end
  object ImageList16: TUniImageList
    Left = 722
    Top = 188
    Bitmap = {
      494C010104003C00040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000022703010E5B0000
      0003000000010100094D0000043A000000000000000000000000010100220500
      003D0500003B0400003C0500003D0500003D0500003E0400003F0500003D0501
      00410301002E000000040000000000000000000000010000000B0000000E0000
      000E0000000E0000000F0000000F000000100000001000000010000000100000
      000E0000000A0000000000000000000000000000000000000003000000080000
      000E0000000E0000000F0000000F0000000F0000000F00000010000000100000
      0010000000100000000C00000005000000000000000000000006000000120000
      001D0000001E0000001E0000001E0000001F00000020464EBCFB394FD3FF0909
      3FB303011C8E384ED3FF4A5DD4FF0000000500000000000000035E493BB2AC9A
      8BDE9C8A79D99F8B7CDBA28C7BDD9F8C79DC9F8A78DCA08A77DD9B8674DAA691
      7FDF6F5B48C201010022000000000000000100000006E3D3CDFFFBF8F6FFFBF7
      F4FFFAF7F4FFFAF6F2FFFAF5F1FFF8F3EFFFF8F2EEFFF8F2EDFFF8F2ECFFF7F0
      EBFFA8786AFF0000000300000000000000000000000000000011AE8173FEFBF8
      F5FFFBF7F5FFFBF6F3FFFBF6F3FFFAF5F1FFFAF4F1FFF9F3EFFFF8F2EEFFF8F2
      ECFFF8F1ECFFC3A195FF0000001C00000000000000000000000E76564CD5C8A9
      9DFFC8A89DFFC7A79BFFC7A69BFFC6A599FFC7A89CFF8380C2FF5F71D6FF3344
      C3FF2F3BB9FF5366D7FF2C2C77D3000000020000000000000006A78970E5FFFF
      FFFFFFFFFBFFFFFFFFFFFFFFFDFFFFFFFBFFFFFFFAFFFFFFFBFFFFFBF4FFFFFF
      FFFFCAA99AEC01000021000000000000000100000006E4D4CEFFF6EEE8FFF6ED
      E7FFF6EDE7FFF5ECE6FFF3EAE4FFE8E0DAFFEBE2DCFFF1E8E1FFF3E9E2FFF7EF
      E9FFA97B6BFF0000000300000000000000000000000000000012B08476FEF6EE
      E9FFF6EEE9FFF6EDE7FFF5EDE7FFF5ECE6FFF5ECE5FFF5ECE5FFF5EBE4FFF5EA
      E4FFF4EAE3FFC5A397FF0000001F000000000000000000000012B08475FEF7EF
      E8FFF6EFE9FFF6EDE7FFF6EDE7FFF5EDE6FFF5ECE6FFF4F1EEFF9A97C5FF6788
      E8FF6283E7FF111144B000000013000000000000000000000005977D66DAF6F6
      F4FBCEB6A1F8CEB39CFACFB59EFBCEB29CFACEB39BFACEB498FBD2B79FF9B3C2
      A6F9598C57F2091D0B83000000040000000500000005E5D7D1FFF8F0EBFFF7EF
      EAFFF7EFEAFFF5EDE8FFF0E8E3FF936F62FF534548FF67739AFFDAD2CCFFF6EF
      E9FFAC7E6EFF0000000300000000000000000000000000000010B48A7DFEF8F0
      EBFFFAF4F0FFF8F4EFFFF8F3EFFFF8F3EEFFF8F2EEFFF8F2EEFFF8F2EDFFF8F1
      EDFFF5ECE6FFC7A79BFF0000001C000000000000000000000010B2887BFEF7F0
      EAFFF8F1ECFFF7F1EBFFF7F0EBFFF7EFEAFFF7EFE9FFA9A9D7FF6876D4FF89A0
      EAFF93A7EDFF6177D8FF171843A50000000100000000000000049D836ADDFDFC
      FCFEE5CEB0FBE8CDACFDEAD0AFFEE9CEADFDE7CDACFDE1C5ACFEF1CABCFD90B1
      8BFA68D59FFF248148E4000000000000000000000005E6D7D2FFF7F1ECFFCEB0
      A1FFCDAFA1FFCCAEA0FFCCB1A3FF8B7D80FFBAD2EBFF3059A4FF4766A2FFF0E9
      E5FFAC7E6FFF000000030000000000000000000000000000000FB58C7FFEF8F1
      ECFFD4B5A9FFD4B4A8FFD4B4A7FFD3B4A7FFD3B4A6FFD2B4A5FFD2B3A5FFD2B3
      A4FFF6EDE7FFC8A89DFF0000001B00000000000000000000000EB58C7FFEF8F1
      EDFFFAF5F2FFFAF5F1FFFAF5F0FFF9F4EFFFF8F3EFFF9CA3E7FFC0D3F9FFDFDD
      EBFFF6F3F2FFAFBEF3FF949EE8FF0000000200000000000000039E846DDDFDFD
      FDFE9D97CDFB918CCBFD928CCAFE8B86C4FD978EC8FDADBDAFFE6EA86EFC4C9E
      5FFC75DFB2FC309256ED062E0E9E06210C8500000004E7D9D4FFF8F3EEFFF7F1
      EDFFF7F1ECFFF7F0EBFFF5EEEAFFC9C9CEFF4569B0FF2998EBFF55B3ECFF4E74
      B0FFA2796AFF000000040000000000000000000000000000000DB99283FEF9F3
      EFFFF3E9E4FFF2E8E4FFF2E8E3FFF2E7E2FFF1E7E2FFF1E6E1FFF1E6E1FFF1E6
      E0FFF7EEE9FFCAACA1FF0101001800000000000000000000000DB88F81FEF8F2
      EEFFD4B6A9FFD3B5A9FFD3B5A9FFD2B5A8FFD3B5A9FFD2CDE3FF9E9FE4FFF5EE
      E9FFF7F1ECFF51507BC50B0B185C000000000000000000000002A18771DDFFFF
      FEFFBFBDE3FCB9B7E5FEBAB8E4FFB2B2DDFEBEB8E2FE94BEA1FFABE9C9FE80E2
      B6FE70DAABFC62D8A3FF73E8B1FF3BAB60FF00000004E7DAD5FFF9F4F0FF696B
      D6FF676AD5FF6769D5FF6869D4FFCCC6DCFFA6B0C5FF80C5F1FF31A2EDFF1E6B
      BEFF3F5E94FF000000090000000100000000000000000000000CBB9587FEF9F3
      F0FF686AD3FF6668D3FF6667D3FF6666D1FF6667D1FF6566D1FF6466D1FF6464
      D0FFF6EFEAFFCCAEA2FF0000001700000000000000000000000BBC9587FEF9F4
      F1FFFBF7F4FFFBF6F3FFFBF6F3FFFBF5F2FFFAF5F2FFF9F5F1FFF9F4F1FFF8F2
      EDFFF8F0EBFF17111064000000050000000000000000000000019F8672DCFDFD
      FDFE9B99DAFB908DD9FD908ED7FE8786CFFD958DD5FD96B9A4FE6FB880FD7ABC
      8CFCA3E8CAFC46B577F947955FED236835D700000003EADDD8FFFBF6F3FFFAF5
      F2FFFAF5F1FFF8F3F0FFF8F2EFFFF7F1EEFFF5EFECFFA4BBD0FF47A0DEFF46BA
      F5FF74CDF2FF1A3658B50000001000000001000000000000000ABF9A8BFEFAF6
      F2FFF5EDE9FFF4ECE8FFF3EBE7FFF3EAE6FFF3EAE6FFF2E9E5FFF2E9E4FFF2E8
      E4FFF8F1EDFFCEB2A7FF0000001500000000000000000000000BBD9789FEFAF5
      F1FFD6BAAEFFD5B9ADFFD6B9ADFFD5B8ADFFD5B8ADFFD5B8ABFFD5B7ACFFEADB
      D4FFF8F0EBFF1711106400000005000000000000000000000000A18974DCFDFD
      FDFEDCD0CCFBDCCFCCFDDED1CDFEDBCDCAFDDCCECAFDE3D6C8FED5CEB9FD8BB5
      8CFAC9FDE9FE408F5DE20000000B0000000B00000003EBDDD9FFFBF7F4FFD8BF
      B1FFD7BEB0FF6C6FDBFF6C6FDAFF6C6ED8FF6D70D9FFDAD6E2FFA8C0D5FFA4DF
      FAFF52C9FAFF8D6659FF482418B400000004000000000000000AC19C8DFEFAF6
      F3FFD8BFB3FFECDDD7FF6D6FD8FF6B6ED7FF6B6DD7FF6A6DD7FF6A6CD6FF6A6B
      D5FFF7F1EEFFCFB3A9FF01010114000000000000000000000008C19E8FFEFBF8
      F5FFFCF9F8FFFBF8F6FFFBF8F6FFFBF8F5FFFBF8F5FFFBF8F4FFFBF7F4FFFAF4
      F0FFF7F1ECFF1712106100000004000000000000000000000000A48B76DCFFFF
      FFFFDBBEA3FCDABB9BFEDDBF9FFFDABB9BFED9BA9BFED6B698FEE6C1AAFDA5C4
      A0FB6CBA81FC285935BD000000000000000000000002ECE0DAFFFCF8F6FFFBF7
      F5FFFAF6F4FFFAF6F4FFF9F5F3FFFAF6F2FFFAF5F2FFFAF5F1FFF8F3F0FFAEC8
      DBFFB88E7AFFB0A5C1FF828DE8FF101065B10000000000000007C4A092FEFBF8
      F5FFF6EFECFFF5EFEBFFF5EEEBFFF4EDEAFFF4EDE9FFF5EDE9FFF5EDE9FFF5ED
      E8FFF7F2EDFFD0B4A9FF00000011000000000000000000000007C4A091FEFBF8
      F5FFD9BFB3FFD8BEB3FFD8BEB3FFD9BDB2FFD8BDB2FFD8BCB1FFD8BCB1FFEADC
      D5FFF5EDE9FF1712106000000004000000000000000000000000A38C77DBFDFD
      FDFEE6D8CAFBE8D8C9FDEADACBFEE8D8C8FDE6D6C5FCE5D3C4FEDACBBCFBEBE9
      E5FBA59F8DE601010027000000000000000200000002EDE0DBFFFCF9F7FF7479
      E1FF7378E1FF7177DFFF7177DFFFCDCBECFFD8BFB1FFD4BBACFFD3B9AAFFECE4
      E0FFAD8171FFAEBAEFFF687EEBFF363D9FE30000000000000007C6A294FEFCF9
      F6FF767CE2FF757AE1FF7479E1FF7478E0FF7378E0FFE5D4CBFFD9C1B5FFD7BD
      B2FFF3EBE6FFCFB4A8FF01010110000000000000000000000006C6A395FEFCFA
      F8FFFDFBFAFFFDFBF9FFFCFBF8FFFCFAF8FFFBF8F7FFF1E7E2FFE7D9D2FFE0CD
      C5FFDCC8BFFF1713115E00000003000000000000000000000000A48E79DBFDFD
      FDFED9C1A8FBD9BCA2FDDCBFA4FED7B89CFDE1CAB5FDDDBFA5FEC39B79F9D7AD
      8AFF977355DF0201011D000000000000000100000002EEE2DDFFFDFAF9FFFBF9
      F8FFFBF9F7FFFAF8F7FFFBF8F6FFFAF5F3FFF0E7E1FFAB7E6EFFAB7D6DFFC4A4
      98FFC29D8DFF1A1E46584F5AD2FE000000030000000000000005C9A697FEFCFA
      F8FFFBF9F8FFFCF9F7FFFBF8F7FFFBF8F6FFFAF7F6FFF3EBE6FFB89284FFAB7D
      6DFFAB7C6CFFC7A698FF0000000B000000000000000000000005C8A597FEFDFA
      F9FFDCC3B8FFDCC3B8FFDCC3B8FFDBC2B7FFDBC2B6FFC9AB9FFFC8AA9FFFC7A7
      9CFFC6A69BFF100C0A4E00000003000000000000000100000000A28C78D8FAFA
      F9FDE5D7C9FAE7D7C7FCE9D9C9FDE7D7C6FCE5D2C2FBE5D5C6F9FDF4EBFF937D
      6CD00807053800000000000000010000000000000001EEE2DDFFFDFBFAFF7981
      E6FF7980E6FF777DE4FF777DE4FFCDCBEBFFEDE0DCFFFFFDFDFFFEFCFAFFBEAB
      A3E43627225C0000000100000001000000000000000000000004C9A79AFEFCFA
      F9FF7A81E6FF7981E6FF7980E5FF7880E5FF7880E4FFF1E6E2FFB38877FFFEFC
      FBFFFDFAF8FF5C4A458500000006000000000000000000000004C9A89AFEFEFC
      FAFFFEFBFAFFFDFBFAFFFDFBF9FFFCFAF9FFFAF7F5FFCCAEA2FFFFFEFEFFE2CF
      C9FF2D231E860000000200000000000000000000000000000000A6917DDBFAFC
      FCFCF1F0EEF9F4F4F1FBF6F6F2FCF5F5F2FBEAE4DFF8F6E1D0FF9D8A7BD50302
      01250000000000000000000000000000000000000001EEE3DFFFFDFCFCFFFDFC
      FBFFFDFCFAFFFDFBFAFFFDFBF9FFF6F0EEFFECE2DDFFFCF9F7FFD9C1B7FF0000
      0004000000010000000000000000000000000000000000000003CBAA9DFEFDFC
      FBFFFDFCFBFFFDFCFAFFFEFBFAFFFDFBF9FFFAF8F7FFEFE6E2FFC19C8CFFE4D3
      CBFF5A463E850000000200000000000000000000000000000003CAA99CFEFDFD
      FCFFFDFCFBFFFDFCFAFFFEFBFAFFFBF8F7FFF8F4F2FFD0B5A9FFFFFEFEFF3329
      2784000000050000000000000000000000000000000100000000A28A75D8FFF6
      E9FFFEEFE3FFFFF2E4FFFFF2E4FFFDF0E3FFFFEEDEFFA98E77DE030301270000
      00000000000300000000000000000000000000000001EFE3DFFFFEFDFDFFFEFD
      FDFFFEFEFDFFFEFDFCFFFBF8F8FFF4EEEAFFEDE2DEFFC7B5AFE33E302B590000
      0001000000000000000000000000000000000000000000000002CCAB9DFEFEFE
      FDFFFEFDFDFFFEFDFCFFFEFDFCFFFCFAF9FFF9F6F4FFEFE5E2FFD0B3A7FF6454
      4E83000000050000000000000000000000000000000000000001705D57BDCEAE
      9FFFCEADA0FFCEACA0FFCDAC9FFFCCAB9EFFCCAA9DFFCBAA9CFF302824820000
      00010000000000000000000000000000000000000000000000000000000F0101
      0118010000190201011A0201011A0201011A0200001B00000009000000000000
      0001000000000000000000000000000000000000000000000002000000020000
      0003000000030000000300000003000000040000000400000002000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C003000780010000800200038001
      0000800200038001000080000003800100008003000380010000800000038001
      000080000001800100008000000080010000C000000080010000C00300008001
      0000C002000080010000C0020000800100004005000180010000C00F00078003
      00004017000F80070000C02F803FFFFF00000000000000000000000000000000
      000000000000}
  end
  object UniTimer: TUniTimer
    Enabled = False
    RunOnce = True
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimerTimer
    Left = 771
    Top = 195
  end
  object UniActionList1: TUniActionList
    Left = 607
    Top = 193
    object Action1: TAction
      Caption = 'Action1'
    end
  end
end
