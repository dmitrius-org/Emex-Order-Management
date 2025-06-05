object ClientsF: TClientsF
  Left = 0
  Top = 0
  ClientHeight = 536
  ClientWidth = 1185
  Caption = #1050#1083#1080#1077#1085#1090
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 489
    Width = 1179
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 1
    Caption = ''
    DesignSize = (
      1179
      44)
    object btnOk: TUniBitBtn
      Left = 1086
      Top = 6
      Width = 87
      Height = 32
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      Left = 998
      Top = 6
      Width = 81
      Height = 32
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object pcCommon: TUniPageControl
    Left = 0
    Top = 0
    Width = 1185
    Height = 486
    Hint = ''
    ActivePage = tabPriceProfiles
    Images = UniMainModule.BaseImage16
    Align = alClient
    TabOrder = 0
    object tabHome: TUniTabSheet
      Hint = ''
      Caption = #1043#1083#1072#1074#1085#1072#1103
      object UniFieldContainer1: TUniFieldContainer
        Left = 0
        Top = 0
        Width = 1177
        Height = 348
        Hint = ''
        ParentColor = False
        Align = alTop
        TabOrder = 0
        DesignSize = (
          1177
          348)
        object edtBrief: TUniEdit
          Left = 144
          Top = 16
          Width = 1009
          Hint = ''
          MaxLength = 256
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          ClearButton = True
        end
        object cbIsActive: TUniCheckBox
          Left = 144
          Top = 78
          Width = 138
          Height = 17
          Hint = ''
          Caption = #1040#1082#1090#1080#1074#1077#1085
          TabOrder = 5
        end
        object lblName: TUniLabel
          Left = 18
          Top = 18
          Width = 84
          Height = 13
          Hint = ''
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
          TabOrder = 2
        end
        object UniLabel5: TUniLabel
          Left = 19
          Top = 51
          Width = 68
          Height = 13
          Hint = ''
          Caption = #1058#1080#1087' '#1082#1083#1080#1077#1085#1090#1072':'
          TabOrder = 4
        end
        object cbClientType: TUniExComboBox
          Left = 144
          Top = 44
          Width = 183
          Hint = ''
          Text = ''
          TabOrder = 3
          AnyMatch = True
          IconItems = <>
          Value = '-1'
        end
        object UniLabel11: TUniLabel
          Left = 18
          Top = 106
          Width = 30
          Height = 13
          Hint = ''
          Caption = 'Email:'
          TabOrder = 6
        end
        object edtEmail: TUniEdit
          Left = 144
          Top = 106
          Width = 387
          Hint = ''
          MaxLength = 64
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 7
          InputType = 'email'
        end
        object edtPhone: TUniEdit
          Left = 144
          Top = 134
          Width = 387
          Hint = ''
          PasswordChar = '*'
          MaxLength = 64
          CharEOL = '*'
          Text = ''
          ParentFont = False
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 8
          ClearButton = True
          FieldLabelWidth = 5
          FieldLabelFont.Color = clCrimson
          InputType = 'tel'
        end
        object UniLabel13: TUniLabel
          Left = 18
          Top = 134
          Width = 49
          Height = 13
          Hint = ''
          Caption = #1058#1077#1083#1077#1092#1086#1085':'
          TabOrder = 9
        end
        object edtContactPerson: TUniEdit
          Left = 144
          Top = 162
          Width = 1009
          Hint = ''
          MaxLength = 256
          CharEOL = '*'
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 10
          ClearButton = True
          FieldLabelWidth = 5
        end
        object UniLabel14: TUniLabel
          Left = 18
          Top = 162
          Width = 95
          Height = 13
          Hint = ''
          Caption = #1050#1086#1085#1090#1072#1082#1090#1085#1086#1077' '#1083#1080#1094#1086':'
          TabOrder = 11
        end
      end
      object fsAudit: TUniFieldSet
        AlignWithMargins = True
        Left = 3
        Top = 375
        Width = 1171
        Height = 80
        Hint = ''
        Title = #1040#1091#1076#1080#1090
        Collapsible = True
        Align = alBottom
        LayoutConfig.Region = 'south'
        TabOrder = 1
        object UniFieldContainer2: TUniFieldContainer
          Left = 2
          Top = 15
          Width = 1167
          Height = 63
          Hint = ''
          ParentColor = False
          Align = alClient
          TabOrder = 1
          object edtID: TUniEdit
            Left = 141
            Top = 8
            Width = 138
            Hint = ''
            Text = ''
            TabOrder = 1
            ReadOnly = True
          end
          object edtInDate: TUniDateTimePicker
            Left = 141
            Top = 33
            Width = 138
            Hint = ''
            DateTime = 45098.000000000000000000
            DateFormat = 'dd.MM.yyyy'
            TimeFormat = 'HH:mm:ss'
            ReadOnly = True
            TabOrder = 3
            DateMode = dtmDateTime
          end
          object edtUpdDate: TUniDateTimePicker
            Left = 415
            Top = 33
            Width = 145
            Hint = ''
            DateTime = 45098.000000000000000000
            DateFormat = 'dd.MM.yyyy'
            TimeFormat = 'HH:mm:ss'
            ReadOnly = True
            TabOrder = 4
            DateMode = dtmDateTime
          end
          object UniLabel1: TUniLabel
            Left = 25
            Top = 10
            Width = 89
            Height = 13
            Hint = ''
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088':'
            TabOrder = 2
          end
          object UniLabel2: TUniLabel
            Left = 25
            Top = 37
            Width = 80
            Height = 13
            Hint = ''
            Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103':'
            TabOrder = 5
          end
          object UniLabel3: TUniLabel
            Left = 302
            Top = 38
            Width = 90
            Height = 13
            Hint = ''
            Caption = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103':'
            TabOrder = 6
          end
        end
      end
    end
    object pcOrders: TUniTabSheet
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1092#1086#1088#1084#1072#1090#1086#1074' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1079#1072#1082#1072#1079#1086#1074' '#1080#1079' excel '#1092#1072#1081#1083#1072
      AlignmentControl = uniAlignmentClient
      ParentAlignmentControl = False
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1079#1072#1082#1072#1079#1086#1074
      LayoutConfig.Width = '100'
      object ToolBar: TUniToolBar
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1171
        Height = 48
        Hint = ''
        ShowHint = True
        ParentShowHint = False
        ButtonHeight = 40
        ButtonWidth = 90
        Images = UniMainModule.BaseImage16
        ShowCaptions = True
        LayoutConfig.IgnorePosition = False
        LayoutConfig.DockWhenAligned = False
        TabOrder = 0
        ParentColor = False
        Color = clBtnFace
        OverflowHandler = ohMenu
        object UniToolButton1: TUniToolButton
          Left = 0
          Top = 0
          ShowHint = True
          Action = actAdd
          ImageIndex = 0
          IconAlign = iaLeft
          TabOrder = 0
        end
        object UniToolButton2: TUniToolButton
          Left = 90
          Top = 0
          ShowHint = True
          Action = actEdit
          ImageIndex = 1
          IconAlign = iaLeft
          TabOrder = 2
        end
        object UniToolButton4: TUniToolButton
          Left = 180
          Top = 0
          ShowHint = True
          Action = actDelete
          ImageIndex = 2
          IconAlign = iaLeft
          TabOrder = 3
        end
      end
      object UniPanel1: TUniPanel
        Left = 0
        Top = 54
        Width = 1177
        Height = 404
        Hint = ''
        Align = alClient
        TabOrder = 1
        Caption = 'UniPanel1'
        Color = clYellow
        Layout = 'fit'
        LayoutConfig.Width = '100'
        object Grid: TUniDBGrid
          Left = 1
          Top = 1
          Width = 1175
          Height = 402
          Hint = ''
          ShowHint = True
          ParentShowHint = False
          BodyRTL = False
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
              'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
              'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
              'data[sender.uniCol+1];'#13#10'        el.value = document.activeElemen' +
              't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
              '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
              'ent.body.removeChild(el);'#13#10'    };'#13#10'}')
          RowEditor = True
          DataSource = DataSource
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgFilterClearButton]
          WebOptions.PageSize = 50
          WebOptions.AppendPosition = tpCurrentRow
          WebOptions.FetchAll = True
          LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
          LoadMask.Color = clActiveCaption
          EmptyText = 
            '<div style="text-align: center;"><i class="fas fa-exclamation"><' +
            '/i> '#1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ... </div>'
          LayoutConfig.ComponentCls = 'grid-clients-file-format'
          LayoutConfig.IgnorePosition = False
          LayoutConfig.Height = '100'
          LayoutConfig.Width = '100'
          BorderStyle = ubsNone
          Align = alClient
          TabOrder = 1
          ParentColor = False
          Color = clBtnFace
          OnKeyDown = GridKeyDown
          Columns = <
            item
              FieldName = 'ClientID'
              Title.Alignment = taCenter
              Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
              Width = 100
              Visible = False
              ReadOnly = True
            end
            item
              FieldName = 'IsActive'
              Title.Caption = #1040#1082#1090#1080#1074#1085#1099#1081
              Width = 90
              Alignment = taCenter
              Hint = 
                #1040#1082#1090#1080#1074#1085#1099#1081' '#1087#1088#1086#1092#1080#1083#1100' ('#1054#1090#1082#1083#1102#1095#1072#1077#1090' '#1074#1086#1079#1084#1086#1078#1085#1086#1089#1090#1100' '#1074#1093#1086#1076#1072' '#1082#1083#1080#1077#1085#1090#1072' '#1074' '#1083#1080#1095#1085#1099#1081' '#1082 +
                #1072#1073#1080#1085#1077#1090')'
              CheckBoxField.AutoPost = True
            end
            item
              FieldName = 'Folder'
              Title.Alignment = taCenter
              Title.Caption = #1055#1072#1087#1082#1072
              Width = 213
              Hint = #1055#1072#1087#1082#1072' '#1089' '#1082#1086#1090#1086#1088#1086#1075#1086' '#1079#1072#1075#1088#1091#1078#1072#1102#1090#1089#1103' '#1079#1072#1082#1072#1079#1099
            end
            item
              FieldName = 'Firstline'
              Title.Alignment = taCenter
              Title.Caption = #1055#1077#1088#1074#1072#1103' '#1089#1090#1088#1086#1082#1072
              Width = 96
              GroupHeader = #1060#1086#1088#1084#1072#1090' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1079#1072#1082#1072#1079#1086#1074
            end
            item
              FieldName = 'Manufacturer'
              Title.Alignment = taCenter
              Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
              Width = 118
              DisplayMemo = True
              GroupHeader = #1060#1086#1088#1084#1072#1090' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1079#1072#1082#1072#1079#1086#1074';'#1057#1090#1086#1083#1073#1077#1094
            end
            item
              FieldName = 'DetailNumber'
              Title.Alignment = taCenter
              Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
              Width = 97
              GroupHeader = #1060#1086#1088#1084#1072#1090' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1079#1072#1082#1072#1079#1086#1074';'#1057#1090#1086#1083#1073#1077#1094
            end
            item
              FieldName = 'Quantity'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
              Width = 95
              GroupHeader = #1060#1086#1088#1084#1072#1090' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1079#1072#1082#1072#1079#1086#1074';'#1057#1090#1086#1083#1073#1077#1094
            end
            item
              FieldName = 'DetailID'
              Title.Alignment = taCenter
              Title.Caption = 'ID'
              Width = 52
              GroupHeader = #1060#1086#1088#1084#1072#1090' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1079#1072#1082#1072#1079#1086#1074';'#1057#1090#1086#1083#1073#1077#1094
            end
            item
              FieldName = 'DetailName'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1077#1090#1072#1083#1080
              Width = 133
              GroupHeader = #1060#1086#1088#1084#1072#1090' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1079#1072#1082#1072#1079#1086#1074';'#1057#1090#1086#1083#1073#1077#1094
            end
            item
              FieldName = 'Price'
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Width = 70
              GroupHeader = #1060#1086#1088#1084#1072#1090' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1079#1072#1082#1072#1079#1086#1074';'#1057#1090#1086#1083#1073#1077#1094
            end
            item
              FieldName = 'Amount'
              Title.Alignment = taCenter
              Title.Caption = #1057#1091#1084#1084#1072
              Width = 70
              GroupHeader = #1060#1086#1088#1084#1072#1090' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1079#1072#1082#1072#1079#1086#1074';'#1057#1090#1086#1083#1073#1077#1094
            end
            item
              FieldName = 'OnlyThisBrand'
              Title.Alignment = taCenter
              Title.Caption = #1041#1077#1079' '#1079#1072#1084#1077#1085
              Width = 64
              GroupHeader = #1060#1086#1088#1084#1072#1090' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1079#1072#1082#1072#1079#1086#1074';'#1057#1090#1086#1083#1073#1077#1094
            end
            item
              FieldName = 'OrderNum'
              Title.Alignment = taCenter
              Title.Caption = #1047#1072#1082#1072#1079
              Width = 85
              GroupHeader = #1060#1086#1088#1084#1072#1090' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1079#1072#1082#1072#1079#1086#1074';'#1071#1095#1077#1081#1082#1072
            end
            item
              FieldName = 'OrderDate'
              Title.Alignment = taCenter
              Title.Caption = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072
              Width = 100
              GroupHeader = #1060#1086#1088#1084#1072#1090' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1079#1072#1082#1072#1079#1086#1074';'#1071#1095#1077#1081#1082#1072
            end
            item
              FieldName = 'PriceNum'
              Title.Alignment = taCenter
              Title.Caption = #1055#1088#1072#1081#1089
              Width = 91
              GroupHeader = #1060#1086#1088#1084#1072#1090' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1079#1072#1082#1072#1079#1086#1074';'#1071#1095#1077#1081#1082#1072
            end
            item
              FieldName = 'Commission'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1084#1080#1089#1089#1080#1103' ('#1085#1077' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1090#1089#1103')'
              Width = 86
              Editor = edtCommission
            end
            item
              FieldName = 'CustomerSubID'
              Title.Caption = 'CustomerSubID'
              Width = 142
            end
            item
              FieldName = 'Reference'
              Title.Caption = 'Reference'
              Width = 221
            end
            item
              FieldName = 'CustomerClientNum'
              Title.Alignment = taCenter
              Title.Caption = ' '#8470' '#1050#1083#1080#1077#1085#1090#1072
              Width = 118
              GroupHeader = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1072#1090#1088#1080#1073#1091#1090#1099
            end
            item
              FieldName = 'CustomerClientSign'
              Title.Alignment = taCenter
              Title.Caption = #1055#1086#1084#1077#1090#1082#1080' '#1050#1083#1080#1077#1085#1090#1072
              Width = 140
              GroupHeader = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1072#1090#1088#1080#1073#1091#1090#1099
            end
            item
              FieldName = 'CustomerOrder'
              Title.Alignment = taCenter
              Title.Caption = #1047#1072#1082#1072#1079
              Width = 86
              GroupHeader = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1072#1090#1088#1080#1073#1091#1090#1099
            end>
        end
      end
    end
    object tabPriceProfiles: TUniTabSheet
      Hint = #1055#1088#1086#1092#1080#1083#1080' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1087#1088#1072#1081#1089#1083#1080#1089#1090#1086#1074'|'#1055#1088#1086#1092#1080#1083#1080' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1087#1088#1072#1081#1089#1083#1080#1089#1090#1086#1074#13#10
      AlignmentControl = uniAlignmentClient
      ParentAlignmentControl = False
      Caption = #1055#1088#1086#1092#1080#1083#1080' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1087#1088#1072#1081#1089#1083#1080#1089#1090#1086#1074
      LayoutConfig.Width = '100'
      OnBeforeActivate = tabPriceProfilesBeforeActivate
      object UniToolBar2: TUniToolBar
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1171
        Height = 48
        Hint = ''
        ShowHint = True
        ParentShowHint = False
        ButtonHeight = 40
        ButtonWidth = 97
        Images = UniMainModule.BaseImage16
        ShowCaptions = True
        LayoutConfig.IgnorePosition = False
        LayoutConfig.DockWhenAligned = False
        TabOrder = 0
        ParentColor = False
        Color = clBtnFace
        OverflowHandler = ohMenu
        object UniToolButton7: TUniToolButton
          Left = 0
          Top = 0
          ShowHint = True
          Action = actPriceProfilesAdd
          ImageIndex = 0
          IconAlign = iaLeft
          TabOrder = 1
        end
        object UniToolButton8: TUniToolButton
          Left = 97
          Top = 0
          ShowHint = True
          Action = actPriceProfilesEdit
          ImageIndex = 1
          IconAlign = iaLeft
          TabOrder = 2
        end
        object UniToolButton9: TUniToolButton
          Left = 194
          Top = 0
          ShowHint = True
          Action = actPriceProfilesDelete
          ImageIndex = 2
          IconAlign = iaLeft
          TabOrder = 3
        end
        object UniToolButton10: TUniToolButton
          Left = 291
          Top = 0
          ShowHint = True
          Action = actPriceProfilesRefresh
          ImageIndex = 3
          TabOrder = 4
        end
      end
      object UniPanel3: TUniPanel
        Left = 0
        Top = 54
        Width = 1177
        Height = 404
        Hint = ''
        Align = alClient
        TabOrder = 1
        Caption = 'UniPanel1'
        Color = clYellow
        Layout = 'fit'
        LayoutConfig.Width = '100'
        object ProfilesCustomerGrid: TUniDBGrid
          Left = 1
          Top = 1
          Width = 1175
          Height = 402
          Hint = ''
          ShowHint = True
          ParentShowHint = False
          BodyRTL = False
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
              'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
              'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
              'data[sender.uniCol+1];'#13#10'        el.value = document.activeElemen' +
              't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
              '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
              'ent.body.removeChild(el);'#13#10'    };'#13#10'}')
          RowEditor = True
          DataSource = dsProfilesCustomer
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgFilterClearButton]
          WebOptions.PageSize = 50
          WebOptions.AppendPosition = tpCurrentRow
          WebOptions.FetchAll = True
          LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
          LoadMask.Color = clActiveCaption
          EmptyText = 
            '<div style="text-align: center;"><i class="fas fa-exclamation"><' +
            '/i> '#1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ... </div>'
          LayoutConfig.ComponentCls = 'grid-clients-file-format'
          LayoutConfig.IgnorePosition = False
          LayoutConfig.Height = '100'
          LayoutConfig.Width = '100'
          BorderStyle = ubsNone
          Align = alClient
          TabOrder = 1
          ParentColor = False
          Color = clBtnFace
          OnKeyDown = GridKeyDown
          OnAjaxEvent = ProfilesCustomerGridAjaxEvent
          OnColumnSort = ProfilesCustomerGridColumnSort
          OnSetCellValue = ProfilesCustomerGridSetCellValue
          OnCellContextClick = ProfilesCustomerGridCellContextClick
          Columns = <
            item
              FieldName = 'isActive'
              Title.Alignment = taCenter
              Title.Caption = 'isActive'
              Width = 82
              Sortable = True
              CheckBoxField.AutoPost = True
            end
            item
              FieldName = 'Brief'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1086#1092#1080#1083#1103
              Width = 166
              Sortable = True
            end
            item
              FieldName = 'SupplierName'
              Filtering.Enabled = True
              Title.Alignment = taCenter
              Title.Caption = ' '#1055#1086#1089#1090#1072#1074#1097#1080#1082
              Width = 150
              Editor = lkSupplier
              Sortable = True
            end
            item
              FieldName = 'ProfilesCustomerID'
              Title.Alignment = taCenter
              Title.Caption = 'ProfilesCustomerID'
              Width = 150
              Visible = False
              ReadOnly = True
              Sortable = True
            end
            item
              FieldName = 'ProfilesDeliveryID'
              Title.Alignment = taCenter
              Title.Caption = #1048#1044' '#1089#1087#1086#1089#1086#1073#1072' '#1076#1086#1089#1090#1072#1074#1082#1080
              Width = 133
              Visible = False
              Sortable = True
            end
            item
              FieldName = 'ProfilesDeliveryName'
              Title.Alignment = taCenter
              Title.Caption = #1057#1087#1086#1089#1086#1073' '#1076#1086#1089#1090#1072#1074#1082#1080
              Width = 172
              Editor = lkProfilesDelivery
              Sortable = True
            end
            item
              FieldName = 'Margin'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1094#1077#1085#1082#1072
              Width = 95
              Editor = edtMargin
              Sortable = True
            end
            item
              FieldName = 'Reliability'
              Title.Alignment = taCenter
              Title.Caption = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1087#1086#1089#1090#1072#1074#1082#1080
              Width = 107
              Editor = edtReliability
              Sortable = True
            end
            item
              ShowToolTip = True
              FieldName = 'UploadFolder'
              Title.Alignment = taCenter
              Title.Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1079#1072#1082#1072#1079#1086#1074
              Width = 301
              Sortable = True
            end
            item
              FieldName = 'UploadPriceName'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1072#1081#1089'-'#1083#1080#1089#1090#1072' '#1076#1083#1103' '#1079#1072#1075#1088#1091#1079#1082#1080
              Width = 185
              Sortable = True
            end
            item
              FieldName = 'UploadFileName'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1072#1081#1089'-'#1083#1080#1089#1090#1072' '#1076#1083#1103' '#1074#1099#1075#1088#1091#1079#1082#1080
              Width = 201
              Sortable = True
            end
            item
              FieldName = 'ClientPriceLogo'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1072#1081#1089'-'#1083#1080#1089#1090#1072' '#1091' '#1082#1083#1080#1077#1085#1090#1072
              Width = 196
              Sortable = True
            end
            item
              FieldName = 'UploadDelimiter'
              Title.Alignment = taCenter
              Title.Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100
              Width = 207
              Hint = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1089#1090#1086#1083#1073#1094#1086#1074' (UploadDelimiter)'
              Editor = lkUploadDelimiter
              Sortable = True
            end
            item
              FieldName = 'DeliveryTermCustomer'
              Title.Alignment = taCenter
              Title.Caption = #1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1082#1083#1080#1077#1085#1090#1072
              Width = 100
              Sortable = True
            end>
        end
        object UniHiddenPanel3: TUniHiddenPanel
          Left = 89
          Top = 139
          Width = 160
          Height = 256
          Hint = ''
          Visible = True
          object lkProfilesDelivery: TUniDBLookupComboBox
            Left = 24
            Top = 132
            Width = 121
            Height = 23
            Hint = ''
            ListField = 'ProfileName'
            ListSource = dslkProfilesDelivery
            KeyField = 'ProfilesDeliveryID'
            ListFieldIndex = 0
            DataField = 'ProfilesDeliveryID'
            DataSource = dsProfilesCustomer
            TabOrder = 1
            Color = clWindow
            Style = csOwnerDrawFixed
          end
          object lkUploadDelimiter: TUniDBLookupComboBox
            Left = 24
            Top = 161
            Width = 121
            Height = 23
            Hint = ''
            ListField = 'Name'
            ListSource = dsDelimiterList
            KeyField = 'DelimiterID'
            ListFieldIndex = 0
            DataField = 'UploadDelimiterID'
            DataSource = dsProfilesCustomer
            TabOrder = 2
            Color = clWindow
            Style = csOwnerDrawFixed
          end
          object edtCommission: TUniFormattedNumberEdit
            Left = 24
            Top = 16
            Width = 121
            Hint = ''
            TabOrder = 3
            DecimalSeparator = ','
            ThousandSeparator = #160
          end
          object edtMargin: TUniFormattedNumberEdit
            Left = 24
            Top = 47
            Width = 121
            Hint = ''
            TabOrder = 4
            DecimalSeparator = ','
            ThousandSeparator = #160
          end
          object edtReliability: TUniFormattedNumberEdit
            Left = 24
            Top = 75
            Width = 121
            Hint = ''
            TabOrder = 5
            DecimalSeparator = ','
            ThousandSeparator = #160
          end
          object lkSupplier: TUniDBLookupComboBox
            Left = 24
            Top = 190
            Width = 121
            Height = 23
            Hint = ''
            ListField = 'Brief'
            ListSource = qslkSupplierslist
            KeyField = 'SuppliersID'
            ListFieldIndex = 0
            DataField = 'SuppliersID'
            DataSource = dsProfilesCustomer
            TabOrder = 6
            Color = clWindow
            Style = csOwnerDrawFixed
            OnChange = lkSupplierChange
            OnSelect = lkSupplierSelect
          end
        end
      end
    end
    object pcRefusals: TUniTabSheet
      Hint = ''
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1086#1090#1074#1077#1090#1086#1074
      DesignSize = (
        1177
        458)
      object UniLabel7: TUniLabel
        Left = 49
        Top = 45
        Width = 60
        Height = 13
        Hint = ''
        Caption = #1058#1080#1087' '#1086#1090#1074#1077#1090#1072':'
        TabOrder = 1
      end
      object UniLabel8: TUniLabel
        Left = 49
        Top = 84
        Width = 114
        Height = 13
        Hint = ''
        Caption = #1057#1087#1086#1089#1086#1073' '#1086#1087#1086#1074#1077#1097#1077#1085#1080#1103':'
        TabOrder = 3
      end
      object UniLabel9: TUniLabel
        Left = 49
        Top = 119
        Width = 105
        Height = 13
        Hint = ''
        Caption = #1040#1076#1088#1077#1089' '#1086#1087#1086#1074#1077#1097#1077#1085#1080#1103':'
        TabOrder = 5
      end
      object cbResponseType: TUniComboBox
        Left = 196
        Top = 41
        Width = 264
        Height = 23
        Hint = ''
        Text = ''
        TabOrder = 0
        IconItems = <>
        OnChange = cbResponseTypeChange
      end
      object cbNotificationMethod: TUniComboBox
        Left = 196
        Top = 78
        Width = 264
        Height = 23
        Hint = ''
        Text = ''
        Items.Strings = (
          #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081#10#10
          #1056#1091#1095#1085#1086#1081)
        TabOrder = 2
        IconItems = <>
      end
      object edtNotificationAddress: TUniEdit
        Left = 196
        Top = 117
        Width = 957
        Hint = ''
        Text = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 4
      end
      object edtNotificationScript: TUniEdit
        Left = 196
        Top = 155
        Width = 957
        Hint = 
          #1055#1088#1080#1084#1077#1088' '#1079#1085#1072#1095#1077#1085#1080#1103':'#13#10#13#10'- C:\scripts\client_export.py'#13#10'- python C:\s' +
          'cripts\notify_customer.py'#13#10'- C:\scripts\run_export.bat'
        ShowHint = True
        ParentShowHint = False
        Text = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 6
      end
      object UniLabel12: TUniLabel
        Left = 49
        Top = 161
        Width = 81
        Height = 13
        Hint = ''
        Caption = #1055#1091#1090#1100' '#1082' '#1089#1082#1088#1080#1087#1090#1091':'
        TabOrder = 7
      end
    end
    object pcCommision: TUniTabSheet
      Hint = ''
      Caption = #1050#1086#1084#1080#1089#1089#1080#1103' '#1080' '#1085#1072#1083#1086#1075#1080
      object UniLabel6: TUniLabel
        Left = 41
        Top = 37
        Width = 123
        Height = 13
        Hint = ''
        Caption = #1050#1086#1084#1080#1089#1089#1080#1103' '#1080' '#1085#1072#1083#1086#1075#1080' (%):'
        TabOrder = 1
      end
      object edtTaxes: TUniFormattedNumberEdit
        Left = 217
        Top = 35
        Width = 121
        Hint = ''
        TabOrder = 0
        MaxValue = 100.000000000000000000
        DecimalSeparator = ','
        ThousandSeparator = #160
      end
    end
    object tabManager: TUniTabSheet
      AlignWithMargins = True
      Hint = ''
      AlignmentControl = uniAlignmentClient
      ParentAlignmentControl = False
      Caption = #1052#1077#1085#1077#1076#1078#1077#1088#1099
      LayoutConfig.Width = '100'
      object UniPanel2: TUniPanel
        Left = 0
        Top = 54
        Width = 1177
        Height = 404
        Hint = ''
        Align = alClient
        TabOrder = 1
        Caption = 'UniPanel1'
        Color = clYellow
        Layout = 'fit'
        LayoutConfig.Width = '100'
        object UniHiddenPanel1: TUniHiddenPanel
          Left = 25
          Top = 191
          Width = 274
          Height = 86
          Hint = ''
          Visible = True
          object LookupClients: TUniDBLookupComboBox
            Left = 10
            Top = 15
            Width = 261
            Height = 23
            Hint = ''
            ListField = 'Brief'
            KeyField = 'ClientID'
            ListFieldIndex = 0
            DataField = 'ClientID'
            DataSource = DataSource
            TabOrder = 1
            Color = clWindow
          end
        end
        object ManagerGrid: TUniDBGrid
          Left = 1
          Top = 1
          Width = 1175
          Height = 402
          Hint = ''
          ShowHint = True
          ParentShowHint = False
          BodyRTL = False
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
              'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
              'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
              'data[sender.uniCol+1];'#13#10'        el.value = document.activeElemen' +
              't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
              '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
              'ent.body.removeChild(el);'#13#10'    };'#13#10'}')
          RowEditor = True
          DataSource = dsManager
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgRowNumbers]
          WebOptions.PageSize = 50
          WebOptions.AppendPosition = tpCurrentRow
          WebOptions.FetchAll = True
          LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
          LoadMask.Color = clActiveCaption
          EmptyText = 
            '<div style="text-align: center;"><i class="fas fa-exclamation"><' +
            '/i> '#1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ... </div>'
          LayoutConfig.IgnorePosition = False
          LayoutConfig.Height = '0'
          LayoutConfig.Width = '100'
          BorderStyle = ubsNone
          Align = alClient
          TabOrder = 1
          ParentColor = False
          Color = clBtnFace
          OnKeyDown = GridKeyDown
          OnCellClick = ManagerGridCellClick
          OnColumnSort = ManagerGridColumnSort
          OnCellContextClick = ManagerGridCellContextClick
          Columns = <
            item
              FieldName = 'ObjectType'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1072#1090#1091#1089
              Width = 64
              Alignment = taCenter
            end
            item
              FieldName = 'EmployeeID'
              Title.Alignment = taCenter
              Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
              Width = 120
              ReadOnly = True
              Sortable = True
            end
            item
              FieldName = 'EmployeeBrief'
              Filtering.Editor = LookupManager
              Title.Alignment = taCenter
              Title.Caption = #1052#1077#1085#1077#1076#1078#1077#1088#1099
              Width = 612
              Hint = #1052#1077#1085#1077#1076#1078#1077#1088#1099
              Editor = LookupManager
              Sortable = True
            end>
        end
        object UniHiddenPanel2: TUniHiddenPanel
          Left = 33
          Top = 199
          Width = 279
          Height = 53
          Hint = ''
          Visible = True
          object LookupManager: TUniDBLookupComboBox
            Left = 10
            Top = 15
            Width = 261
            Height = 23
            Hint = ''
            ListField = 'Brief'
            ListSource = dsManagerList
            KeyField = 'EmployeeID'
            ListFieldIndex = 0
            DataField = 'EmployeeID'
            DataSource = dsManager
            TabOrder = 1
            Color = clWindow
          end
        end
      end
      object UniToolBar1: TUniToolBar
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1171
        Height = 48
        Hint = ''
        ShowHint = True
        ParentShowHint = False
        ButtonHeight = 40
        ButtonWidth = 90
        Images = UniMainModule.BaseImage16
        ShowCaptions = True
        LayoutConfig.IgnorePosition = False
        LayoutConfig.DockWhenAligned = False
        TabOrder = 0
        ParentColor = False
        Color = clBtnFace
        OverflowHandler = ohMenu
        object UniToolButton3: TUniToolButton
          Left = 0
          Top = 0
          ShowHint = True
          Action = actManagerAdd
          ImageIndex = 0
          IconAlign = iaLeft
          TabOrder = 0
        end
        object UniToolButton5: TUniToolButton
          Left = 90
          Top = 0
          ShowHint = True
          Action = actManagerEdit
          ImageIndex = 1
          IconAlign = iaLeft
          TabOrder = 2
        end
        object UniToolButton6: TUniToolButton
          Left = 180
          Top = 0
          ShowHint = True
          Action = actManagerDelete
          ImageIndex = 2
          IconAlign = iaLeft
          TabOrder = 3
        end
      end
    end
    object tabShipments: TUniTabSheet
      Hint = ''
      Caption = #1054#1090#1075#1088#1091#1079#1082#1080' - '#1073#1072#1083#1072#1085#1089
      object cbStatusRequiringPayment: TUniCheckComboBox
        Left = 242
        Top = 28
        Width = 911
        Hint = ''
        Text = ''
        TabOrder = 0
        IconItems = <>
      end
      object UniLabel10: TUniLabel
        Left = 33
        Top = 32
        Width = 176
        Height = 13
        Hint = ''
        Caption = #1057#1090#1072#1090#1091#1089#1099' '#1090#1088#1077#1073#1091#1102#1097#1080#1077' '#1087#1088#1077#1076#1086#1087#1083#1072#1090#1099':'
        TabOrder = 1
      end
    end
  end
  object Query: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.UpdateTableName = 'pOrderFileFormat'
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'ID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'select * '
      '  from vOrderFileFormat c'
      ' where c.ClientID = :ClientID')
    Left = 736
    Top = 128
    ParamData = <
      item
        Name = 'CLIENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QueryFolder: TWideStringField
      FieldName = 'Folder'
      Origin = 'Folder'
      Size = 512
    end
    object QueryFirstline: TIntegerField
      FieldName = 'Firstline'
      Origin = 'Firstline'
    end
    object QueryManufacturer: TIntegerField
      FieldName = 'Manufacturer'
      Origin = 'Manufacturer'
    end
    object QueryDetailNumber: TIntegerField
      FieldName = 'DetailNumber'
      Origin = 'DetailNumber'
    end
    object QueryQuantity: TIntegerField
      FieldName = 'Quantity'
      Origin = 'Quantity'
    end
    object QueryDetailID: TIntegerField
      FieldName = 'DetailID'
      Origin = 'DetailID'
    end
    object QuerytDetailName: TIntegerField
      FieldName = 'DetailName'
      Origin = 'PartName'
    end
    object QueryPrice: TIntegerField
      FieldName = 'Price'
      Origin = 'Price'
    end
    object QueryAmount: TIntegerField
      FieldName = 'Amount'
      Origin = 'Amount'
    end
    object QueryOrderNum: TWideStringField
      FieldName = 'OrderNum'
      Origin = 'OrderNum'
      Size = 32
    end
    object QueryOrderDate: TWideStringField
      FieldName = 'OrderDate'
      Origin = 'OrderDate'
      Size = 32
    end
    object QueryPriceNum: TWideStringField
      FieldName = 'PriceNum'
      Origin = 'PriceNum'
      Size = 32
    end
    object QueryCommission: TCurrencyField
      FieldName = 'Commission'
      Origin = 'Commission'
    end
    object QueryIsActive: TBooleanField
      FieldName = 'IsActive'
      Origin = 'IsActive'
    end
    object QueryCustomerSubID: TStringField
      FieldName = 'CustomerSubID'
      Origin = 'CustomerSubID'
      Size = 32
    end
    object QueryReference: TStringField
      FieldName = 'Reference'
      Origin = 'Reference'
      Size = 64
    end
    object QueryOrderFileFormatID: TFMTBCDField
      FieldName = 'OrderFileFormatID'
      Origin = 'OrderFileFormatID'
      ProviderFlags = [pfInWhere, pfInKey]
      Precision = 18
      Size = 0
    end
    object QueryClientID: TFMTBCDField
      FieldName = 'ClientID'
      Origin = 'ClientID'
      Precision = 18
      Size = 0
    end
    object QueryID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
    end
    object QueryOnlyThisBrand: TIntegerField
      FieldName = 'OnlyThisBrand'
    end
    object QueryCustomerClientNum: TIntegerField
      FieldName = 'CustomerClientNum'
    end
    object QueryCustomerClientSign: TIntegerField
      FieldName = 'CustomerClientSign'
    end
    object QueryCustomerOrder: TIntegerField
      FieldName = 'CustomerOrder'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 733
    Top = 182
  end
  object UpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    InsertSQL.Strings = (
      'declare @R    numeric(18, 0)'
      '       ,@ID   numeric(18, 0)'
      ''
      '  exec @R = OrderFileFormatInsert'
      '                @ID                = @ID out'
      '               ,@ClientID          = :NEW_ClientID         '
      '               ,@Folder            = :NEW_Folder           '
      '               ,@Firstline         = :NEW_Firstline        '
      '               ,@Manufacturer      = :NEW_Manufacturer     '
      '               ,@DetailNumber      = :NEW_DetailNumber       '
      '               ,@Quantity          = :NEW_Quantity         '
      '               ,@DetailID          = :NEW_DetailID         '
      '               ,@DetailName        = :NEW_DetailName       '
      '               ,@Price             = :NEW_Price            '
      '               ,@Amount            = :NEW_Amount           '
      '               ,@OrderNum          = :NEW_OrderNum         '
      '               ,@OrderDate         = :NEW_OrderDate        '
      '               ,@PriceNum          = :NEW_PriceNum         '
      '               ,@Commission        = :NEW_Commission  '
      #9'       ,@CustomerSubID     = :NEW_CustomerSubID '
      #9'       ,@Reference         = :NEW_Reference '
      '               ,@IsActive          = :NEW_IsActive'
      '               ,@OnlyThisBrand     = :NEW_OnlyThisBrand'
      '               ,@CustomerClientNum = :NEW_CustomerClientNum '
      '               ,@CustomerClientSign= :NEW_CustomerClientSign'
      '               ,@CustomerOrder     = :NEW_CustomerOrder'
      '  '
      ''
      ''
      'if @R > 0'
      'begin'
      '  declare @M nvarchar(1024) = dbo.GetRetMsg(@R)'
      ''
      '  RAISERROR (@M, 16, 1); '
      'end'
      ''
      'SELECT @ID as ID '
      ''
      '')
    ModifySQL.Strings = (
      'declare @R         numeric(18, 0)'
      ''
      'exec @R = OrderFileFormatUpdate'
      '                --@OrderFileFormatID = @OrderFileFormatID'
      '                --@ClientID          = :OLD_ClientID'
      '                @Folder            = :NEW_Folder           '
      '               ,@Firstline         = :NEW_Firstline        '
      '               ,@Manufacturer      = :NEW_Manufacturer     '
      '               ,@DetailNumber      = :NEW_DetailNumber      '
      '               ,@Quantity          = :NEW_Quantity         '
      '               ,@DetailID          = :NEW_DetailID         '
      '               ,@DetailName        = :NEW_DetailName         '
      '               ,@Price             = :NEW_Price            '
      '               ,@Amount            = :NEW_Amount           '
      '               ,@OrderNum          = :NEW_OrderNum         '
      '               ,@OrderDate         = :NEW_OrderDate        '
      '               ,@PriceNum          = :NEW_PriceNum         '
      '               ,@Commission        = :NEW_Commission  '
      #9'       ,@CustomerSubID     = :NEW_CustomerSubID '
      #9'       ,@Reference         = :NEW_Reference '
      '               ,@IsActive          = :NEW_IsActive  '
      '               ,@ID                = :ID'
      '               ,@OnlyThisBrand     = :NEW_OnlyThisBrand'
      '               ,@CustomerClientNum = :NEW_CustomerClientNum '
      '               ,@CustomerClientSign= :NEW_CustomerClientSign'
      '               ,@CustomerOrder     = :NEW_CustomerOrder'
      '       '
      'if @R > 0'
      'begin'
      ' declare @M nvarchar(1024)'
      ' set @M = dbo.GetRetMsg(@R)'
      ''
      ' RAISERROR (@M, 16, 1); '
      'end'
      ''
      '')
    DeleteSQL.Strings = (
      'declare @R numeric(18, 0)'
      ''
      '   exec @R = OrderFileFormatDeleteP'
      '                @ID          = :ID'
      ''
      'if @R > 0'
      'begin'
      ' declare @M nvarchar(1024)'
      ' set @M = dbo.GetRetMsg(@R)'
      ''
      ' RAISERROR (@M, 16, 1); '
      'end')
    FetchRowSQL.Strings = (
      'SELECT *'
      '  FROM vOrderFileFormat'
      ' WHERE ID = :ID')
    Left = 626
    Top = 130
  end
  object ActionList: TUniActionList
    Left = 414
    Top = 178
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 0
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 1
      OnExecute = actEditExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnExecute = actDeleteExecute
    end
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 3
      OnExecute = actRefreshAllExecute
    end
    object actManagerAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 0
      OnExecute = actManagerAddExecute
    end
    object actManagerEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 1
      OnExecute = actManagerEditExecute
    end
    object actManagerDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnExecute = actManagerDeleteExecute
    end
    object actManagerRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 3
      OnExecute = actManagerRefreshExecute
    end
    object actPriceProfilesAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1088#1086#1092#1080#1083#1100
      ImageIndex = 0
      OnExecute = actPriceProfilesAddExecute
    end
    object actPriceProfilesEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1092#1080#1083#1100
      ImageIndex = 1
      OnExecute = actPriceProfilesEditExecute
    end
    object actPriceProfilesDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1086#1092#1080#1083#1100
      ImageIndex = 2
      OnExecute = actPriceProfilesDeleteExecute
    end
    object actPriceProfilesRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 3
      OnExecute = actPriceProfilesRefreshExecute
    end
    object actMarginEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1084#1072#1088#1078#1091' '#1087#1086' '#1074#1089#1077#1084' '#1087#1088#1072#1081#1089#1072#1084
      OnExecute = actMarginEditExecute
    end
    object actReliabilityEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1074#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1087#1086' '#1074#1089#1077#1084' '#1087#1088#1072#1081#1089#1072#1084
      OnExecute = actReliabilityEditExecute
    end
  end
  object qlkSupplierslist: TFDQuery
    Connection = UniMainModule.FDConnection
    SQL.Strings = (
      'select SuppliersID'
      '      ,Brief '
      '  from tSuppliers (nolock)')
    Left = 310
    Top = 313
    object qlkSupplierslistSuppliersID: TFMTBCDField
      FieldName = 'SuppliersID'
    end
    object qlkSupplierslistBrief: TWideStringField
      FieldName = 'Brief'
      Size = 255
    end
  end
  object dsManagerList: TDataSource
    DataSet = qManagerList
    Left = 992
    Top = 188
  end
  object qManagerList: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'Select c.UserID as EmployeeID, '
      '       c.Name   as Brief'
      '  from tUser c (nolock)'
      ' where not exists ('
      '                   select 1'
      '                     from pClientReliation p (nolock)'
      '                    where p.Spid     = @@spid'
      '                      and p.LinkID   = c.UserID'
      '                      and p.LinkType = 5'
      '                   )')
    Left = 995
    Top = 135
    object qManagerListClientID: TFMTBCDField
      FieldName = 'EmployeeID'
      Size = 0
    end
    object qManagerListBrief: TWideStringField
      FieldName = 'Brief'
      Size = 255
    end
  end
  object qManager: TFDQuery
    AutoCalcFields = False
    AfterPost = qManagerAfterPost
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.UpdateTableName = 'pClientReliation'
    UpdateOptions.KeyFields = 'ID '
    UpdateOptions.AutoIncFields = 'ID '
    UpdateObject = uManager
    SQL.Strings = (
      'select * '
      '  from vClientEmployeeReliation ')
    Left = 903
    Top = 133
    object qManagerObjectType: TIntegerField
      FieldName = 'ObjectType'
      OnGetText = qManagerObjectTypeGetText
    end
    object FMTBCDField1: TFMTBCDField
      FieldName = 'ID'
    end
    object FMTBCDField2: TFMTBCDField
      FieldName = 'ClientID'
    end
    object QueryEmployeeID: TFMTBCDField
      FieldName = 'EmployeeID'
    end
    object QueryClientBrief: TWideStringField
      FieldName = 'EmployeeBrief'
      Size = 255
    end
  end
  object dsManager: TDataSource
    DataSet = qManager
    Left = 899
    Top = 191
  end
  object uManager: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    InsertSQL.Strings = (
      'declare @R    numeric(18, 0)'
      '       ,@ID   numeric(18, 0)'
      ''
      'if isnull(:NEW_EmployeeID, 0) = 0'
      'begin'
      ' RAISERROR ('#39#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1087#1086#1083#1077' '#1084#1077#1085#1077#1076#1078#1077#1088'!'#39', 16, 1); '
      'end'
      ''
      'exec @R = ClientReliatioInsertP'
      '            @ID                = @ID output                 '
      '           ,@ClientID          = :ClientID'
      '           ,@LinkID            = :NEW_EmployeeID   '
      '           ,@LinkType          = 7  '
      ''
      'if @R > 0'
      'begin'
      '  declare @M nvarchar(1024) = dbo.GetRetMsg(@R)'
      ''
      '  RAISERROR (@M, 16, 1); '
      'end'
      ''
      'SELECT @ID as ID '
      ''
      '')
    ModifySQL.Strings = (
      'declare @R numeric(18, 0)'
      ''
      'if isnull(:NEW_EmployeeID, 0) = 0'
      'begin'
      ' RAISERROR ('#39#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1087#1086#1083#1077' '#1084#1077#1085#1077#1076#1078#1077#1088'!'#39', 16, 1); '
      'end'
      ''
      'exec @R = ClientReliationUpdateP'
      '                @ClientID          = :ClientID  '
      '               ,@LinkID            = :NEW_EmployeeID'
      '               ,@LinkType          = 7  '
      '               ,@ID                = :ID'
      '       '
      'if @R > 0'
      'begin'
      ' declare @M nvarchar(1024)'
      ' set @M = dbo.GetRetMsg(@R)'
      ''
      ' RAISERROR (@M, 16, 1); '
      'end'
      ''
      '')
    DeleteSQL.Strings = (
      'declare @R numeric(18, 0)'
      ''
      'exec @R = ClientReliationDeleteP @ID = :ID'
      ''
      'if @R > 0'
      'begin'
      ' declare @M nvarchar(1024)'
      ' set @M = dbo.GetRetMsg(@R)'
      ''
      ' RAISERROR (@M, 16, 1); '
      'end')
    FetchRowSQL.Strings = (
      'SELECT *'
      '  FROM vClientEmployeeReliation'
      ' WHERE ID = :ID')
    Left = 822
    Top = 132
  end
  object pmManager: TUniPopupMenu
    Images = UniMainModule.BaseImage
    OnPopup = pmManagerPopup
    Left = 457
    Top = 113
    object N1: TUniMenuItem
      Action = actManagerAdd
    end
    object N2: TUniMenuItem
      Action = actManagerEdit
    end
    object N3: TUniMenuItem
      Action = actManagerDelete
    end
    object N4: TUniMenuItem
      Caption = '-'
    end
    object N5: TUniMenuItem
      Action = actManagerRefresh
    end
  end
  object qProfilesCustomer: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateObject = uProfilesCustomer
    SQL.Strings = (
      'select *'
      '  from vProfilesCustomer')
    Left = 736
    Top = 260
    object qProfilesCustomerID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object qProfilesCustomerisActive: TBooleanField
      FieldName = 'isActive'
      Origin = 'isActive'
    end
    object qProfilesCustomerSpid: TIntegerField
      FieldName = 'Spid'
      Origin = 'Spid'
    end
    object qProfilesCustomerBrief: TStringField
      FieldName = 'Brief'
      Size = 60
    end
    object qProfilesCustomerProfilesCustomerID: TIntegerField
      FieldName = 'ProfilesCustomerID'
      Origin = 'ProfilesCustomerID'
      ReadOnly = True
    end
    object qProfilesCustomerClientID: TFMTBCDField
      FieldName = 'ClientID'
      Origin = 'ClientID'
      Precision = 18
      Size = 0
    end
    object qProfilesCustomerProfilesDeliveryID: TIntegerField
      FieldName = 'ProfilesDeliveryID'
      LookupCache = True
      Origin = 'ProfilesDeliveryID'
    end
    object qProfilesCustomerProfilesDeliveryName: TWideStringField
      FieldName = 'ProfilesDeliveryName'
      KeyFields = 'ProfilesDeliveryID'
      Size = 60
    end
    object qProfilesCustomerMargin: TCurrencyField
      FieldName = 'Margin'
      Origin = 'Margin'
      DisplayFormat = '###,##0.00 %'
      MaxValue = 100.000000000000000000
    end
    object qProfilesCustomerReliability: TCurrencyField
      FieldName = 'Reliability'
      Origin = 'Reliability'
      DisplayFormat = '###,##0.00 %'
      MaxValue = 100.000000000000000000
    end
    object qProfilesCustomerUploadFolder: TStringField
      FieldName = 'UploadFolder'
      Origin = 'UploadFolder'
      Size = 255
    end
    object qProfilesCustomerUploadPriceName: TStringField
      FieldName = 'UploadPriceName'
      Origin = 'UploadPriceName'
      Size = 255
    end
    object qProfilesCustomerUploadFileName: TStringField
      FieldName = 'UploadFileName'
      Origin = 'UploadFileName'
      Size = 255
    end
    object qProfilesCustomerClientPriceLogo: TWideStringField
      FieldName = 'ClientPriceLogo'
      Origin = 'ClientPriceLogo'
      Size = 32
    end
    object qProfilesCustomerUploadDelimiterID: TIntegerField
      FieldName = 'UploadDelimiterID'
      Origin = 'UploadDelimiterID'
    end
    object qProfilesCustomerUploadDelimiter: TStringField
      FieldName = 'UploadDelimiter'
      Size = 60
    end
    object qProfilesCustomerDeliveryTermCustomer: TIntegerField
      FieldName = 'DeliveryTermCustomer'
    end
    object qProfilesCustomerSuppliersID: TFMTBCDField
      FieldName = 'SuppliersID'
      KeyFields = 'SuppliersID'
    end
    object qProfilesCustomerSupplierName: TStringField
      FieldName = 'SupplierName'
      KeyFields = 'SuppliersID'
      OnChange = qProfilesCustomerSupplierNameChange
      Size = 26
    end
  end
  object dsProfilesCustomer: TDataSource
    DataSet = qProfilesCustomer
    Left = 734
    Top = 314
  end
  object uProfilesCustomer: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    InsertSQL.Strings = (
      'declare @R                  numeric(18, 0)'
      '       ,@Brief              nvarchar(60)'
      '       ,@ProfilesDeliveryID numeric(18, 0)'
      '       ,@SuppliersID        numeric(18, 0)'
      ''
      'select @Brief              = :NEW_Brief'
      '      ,@ProfilesDeliveryID = :NEW_ProfilesDeliveryID '
      '      ,@SuppliersID        = :NEW_SuppliersID '
      ''
      'if isnull(@Brief, '#39#39') = '#39#39
      'begin'
      
        ' RAISERROR ('#39#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1087#1086#1083#1077' ['#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1086#1092#1080#1083#1103']'#39', ' +
        '16, 1); '
      'end'
      ''
      'if isnull(@SuppliersID , 0) = 0'
      'begin'
      ' RAISERROR ('#39#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1087#1086#1083#1077' ['#1055#1086#1089#1090#1072#1074#1097#1080#1082#39', 16, 1); '
      'end'
      ''
      'if isnull(@ProfilesDeliveryID, 0) = 0'
      'begin'
      
        ' RAISERROR ('#39#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1087#1086#1083#1077' ['#1057#1087#1086#1089#1086#1073' '#1076#1086#1089#1090#1072#1074#1082#1080']'#39', 16, 1' +
        '); '
      'end'
      ''
      'if exists (select 1'
      '             from [pProfilesCustomer](nolock)'
      '            where Spid            = @@spid'
      '              and Brief           = @Brief         '
      ')'
      'begin'
      '   RAISERROR ('#39#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1086#1092#1080#1083#1103' '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090'!'#39', 16, 1); '
      'end'
      ''
      'if exists (select 1'
      '             from [pProfilesCustomer](nolock)'
      '            where Spid            = @@spid'
      '              and Brief           = @Brief'
      
        '              and ProfilesDeliveryID = @ProfilesDeliveryID      ' +
        '        '
      ')'
      'begin'
      
        '   RAISERROR ('#39#1057#1086#1095#1077#1090#1072#1085#1080#1077' "'#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1086#1092#1080#1083#1103'/'#1057#1087#1086#1089#1086#1073' '#1076#1086#1089#1090#1072#1074#1082#1080'" ' +
        #1089#1091#1097#1077#1089#1090#1074#1091#1077#1090'!'#39', 16, 1); '
      'end'
      ''
      ''
      'INSERT INTO [pProfilesCustomer] with (rowlock)'
      '           ([Spid]'
      '           ,[ProfilesCustomerID]'
      '           ,[ClientID]'
      '           ,[Brief]'
      '           ,[ProfilesDeliveryID]'
      '           ,[Margin]'
      '           ,[Reliability]'
      '           ,[UploadFolder]'
      '           ,[UploadPriceName]'
      '           ,[UploadFileName]'
      '           ,[isActive]'
      '           ,[ClientPriceLogo]'
      '           ,[UploadDelimiterID]'
      '           ,DeliveryTermCustomer'
      '           ,SuppliersID'
      '           )   '
      'VALUES (@@Spid, '
      '        0, '
      '        :NEW_ClientID, '
      '        @Brief, '
      '        @ProfilesDeliveryID, '
      '        :NEW_Margin, '
      '        :NEW_Reliability,         '
      '        :NEW_UploadFolder, '
      '        :NEW_UploadPriceName,         '
      '        :NEW_UploadFileName,  '
      '        :NEW_isActive,  '
      '        :NEW_ClientPriceLogo,  '
      '        :NEW_UploadDelimiterID,'
      '        :NEW_DeliveryTermCustomer,'
      '        :NEW_SuppliersID'
      '        );'
      ''
      'SELECT SCOPE_IDENTITY() AS ID')
    ModifySQL.Strings = (
      ''
      'declare @R      numeric(18, 0)'
      '       ,@RetMsg nvarchar(256)'
      ''
      'exec @R = ClientDeliveryProfilesUpdate  '
      '      @ID                  = :ID'
      '     ,@Brief               = :NEW_Brief'
      '     ,@ProfilesDeliveryID  = :NEW_ProfilesDeliveryID'
      '     ,@Margin              = :NEW_Margin'
      '     ,@Reliability         = :NEW_Reliability'
      '     ,@UploadFolder        = :NEW_UploadFolder'
      '     ,@UploadPriceName     = :NEW_UploadPriceName'
      '     ,@UploadFileName      = :NEW_UploadFileName'
      '     ,@isActive            = :NEW_isActive'
      '     ,@ClientPriceLogo     = :NEW_ClientPriceLogo'
      '     ,@UploadDelimiterID   = :NEW_UploadDelimiterID'
      '     ,@DeliveryTermCustomer= :NEW_DeliveryTermCustomer'
      '     ,@SuppliersID         = :NEW_SuppliersID'
      ''
      'if isnull(@R, 0) > 0'
      'begin'
      '   select @RetMsg = dbo.GetRetMsg(@R)'
      ''
      '   RAISERROR (@RetMsg , 16, 1); '
      'end')
    DeleteSQL.Strings = (
      '/*'
      'declare @R numeric(18, 0)'
      ''
      'if @R > 0'
      'begin'
      ' declare @M nvarchar(1024)'
      ' set @M = dbo.GetRetMsg(@R)'
      ''
      ' RAISERROR (@M, 16, 1); '
      'end'
      '*/'
      ''
      ''
      
        'delete pProfilesCustomer from pProfilesCustomer (rowlock) where ' +
        'ID = :ID')
    FetchRowSQL.Strings = (
      'select *'
      '  from vProfilesCustomer'
      ' where ID = :ID')
    Left = 627
    Top = 258
  end
  object qlkProfilesDeliveryList: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.KeyFields = 'ProfilesDeliveryID'
    SQL.Strings = (
      'select ProfilesDeliveryID, ProfileName '
      '  from vSupplierDeliveryParam '
      ' where SuppliersID = :SuppliersID')
    Left = 473
    Top = 312
    ParamData = <
      item
        Name = 'SUPPLIERSID'
        DataType = ftFMTBcd
        ParamType = ptInput
        Value = Null
      end>
    object qlkProfilesDeliveryListProfilesDeliveryID: TFDAutoIncField
      FieldName = 'ProfilesDeliveryID'
      KeyFields = 'ProfilesDeliveryID'
      Origin = 'ProfilesDeliveryID'
    end
    object qlkProfilesDeliveryListProfileName: TWideStringField
      DisplayWidth = 60
      FieldName = 'ProfileName'
      Origin = 'ProfileName'
      Required = True
      Size = 60
    end
  end
  object qDelimiterList: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.KeyFields = 'DelimiterID'
    SQL.Strings = (
      'SELECT [DelimiterID]'
      '      ,[Brief]'
      '      ,[Name]'
      '  FROM [tDelimiter] (Nolock)')
    Left = 897
    Top = 385
    object qDelimiterListDelimiterID: TFDAutoIncField
      FieldName = 'DelimiterID'
      Origin = 'DelimiterID'
    end
    object qDelimiterListName: TStringField
      FieldName = 'Name'
      Origin = 'Name'
      Size = 60
    end
  end
  object dslkProfilesDelivery: TDataSource
    DataSet = qlkProfilesDeliveryList
    Left = 476
    Top = 375
  end
  object dsDelimiterList: TDataSource
    DataSet = qDelimiterList
    Left = 991
    Top = 387
  end
  object pmProfilesCustomer: TUniPopupMenu
    Images = UniMainModule.BaseImage
    Left = 297
    Top = 128
    object N6: TUniMenuItem
      Action = actMarginEdit
    end
    object N7: TUniMenuItem
      Action = actReliabilityEdit
    end
    object UniMenuItem4: TUniMenuItem
      Caption = '-'
    end
    object N9: TUniMenuItem
      Action = actPriceProfilesAdd
    end
    object N10: TUniMenuItem
      Action = actPriceProfilesEdit
    end
    object N11: TUniMenuItem
      Action = actPriceProfilesDelete
    end
    object N8: TUniMenuItem
      Caption = '-'
    end
    object UniMenuItem5: TUniMenuItem
      Action = actPriceProfilesRefresh
    end
  end
  object qslkSupplierslist: TDataSource
    DataSet = qlkSupplierslist
    Left = 316
    Top = 383
  end
end
