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
      Top = 10
      Width = 85
      Height = 25
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      Left = 996
      Top = 10
      Width = 81
      Height = 25
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
    ActivePage = tabShipments
    Align = alClient
    TabOrder = 0
    object tabHome: TUniTabSheet
      Hint = ''
      Caption = #1043#1083#1072#1074#1085#1072#1103
      object UniFieldContainer1: TUniFieldContainer
        Left = 0
        Top = 0
        Width = 1177
        Height = 143
        Hint = ''
        ParentColor = False
        Align = alTop
        TabOrder = 0
        DesignSize = (
          1177
          143)
        object edtBrief: TUniEdit
          Left = 144
          Top = 16
          Width = 1009
          Hint = ''
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          ClearButton = True
        end
        object cbIsActive: TUniCheckBox
          Left = 144
          Top = 103
          Width = 138
          Height = 17
          Hint = ''
          Caption = #1040#1082#1090#1080#1074#1077#1085
          TabOrder = 5
        end
        object lblName: TUniLabel
          Left = 25
          Top = 19
          Width = 84
          Height = 13
          Hint = ''
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
          TabOrder = 2
        end
        object UniLabel5: TUniLabel
          Left = 25
          Top = 61
          Width = 68
          Height = 13
          Hint = ''
          Caption = #1058#1080#1087' '#1082#1083#1080#1077#1085#1090#1072':'
          TabOrder = 4
        end
        object cbClientType: TUniFSComboBox
          Left = 144
          Top = 56
          Width = 183
          Hint = ''
          Text = ''
          TabOrder = 3
          AnyMatch = True
          IconItems = <>
          Value = '-1'
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
        Images = ImageList16
        ShowCaptions = True
        LayoutConfig.IgnorePosition = False
        LayoutConfig.DockWhenAligned = False
        TabOrder = 0
        ParentColor = False
        Color = clBtnFace
        OverflowHandler = ohMenu
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 1177
        object UniToolButton1: TUniToolButton
          Left = 0
          Top = 0
          ShowHint = True
          Action = actAdd
          ImageIndex = 1
          IconAlign = iaLeft
          TabOrder = 0
        end
        object UniToolButton2: TUniToolButton
          Left = 90
          Top = 0
          ShowHint = True
          Action = actEdit
          ImageIndex = 2
          IconAlign = iaLeft
          TabOrder = 2
        end
        object UniToolButton4: TUniToolButton
          Left = 180
          Top = 0
          ShowHint = True
          Action = actDelete
          ImageIndex = 0
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
        ExplicitTop = 48
        ExplicitHeight = 410
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
          EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
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
              Title.Caption = #1050#1086#1084#1080#1089#1089#1080#1103
              Width = 86
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
        Images = ImageList16
        ShowCaptions = True
        LayoutConfig.IgnorePosition = False
        LayoutConfig.DockWhenAligned = False
        TabOrder = 0
        ParentColor = False
        Color = clBtnFace
        OverflowHandler = ohMenu
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 1177
        object UniToolButton7: TUniToolButton
          Left = 0
          Top = 0
          ShowHint = True
          Action = actPriceProfilesAdd
          ImageIndex = 1
          IconAlign = iaLeft
          TabOrder = 1
        end
        object UniToolButton8: TUniToolButton
          Left = 97
          Top = 0
          ShowHint = True
          Action = actPriceProfilesEdit
          ImageIndex = 2
          IconAlign = iaLeft
          TabOrder = 2
        end
        object UniToolButton9: TUniToolButton
          Left = 194
          Top = 0
          ShowHint = True
          Action = actPriceProfilesDelete
          ImageIndex = 0
          IconAlign = iaLeft
          TabOrder = 3
        end
        object UniToolButton10: TUniToolButton
          Left = 291
          Top = 0
          ShowHint = True
          Action = actPriceProfilesRefresh
          ImageIndex = 4
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
        ExplicitTop = 48
        ExplicitHeight = 410
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
          EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
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
          OnColumnSort = ProfilesCustomerGridColumnSort
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
              Editor = lkPriceProfiles
              Sortable = True
            end
            item
              FieldName = 'Margin'
              Title.Alignment = taCenter
              Title.Caption = 'Margin'
              Width = 95
              Sortable = True
            end
            item
              FieldName = 'Reliability'
              Title.Alignment = taCenter
              Title.Caption = 'Reliability'
              Width = 96
              Sortable = True
            end
            item
              ShowToolTip = True
              FieldName = 'UploadFolder'
              Title.Alignment = taCenter
              Title.Caption = 'UploadFolder'
              Width = 301
              Sortable = True
            end
            item
              FieldName = 'UploadPriceName'
              Title.Alignment = taCenter
              Title.Caption = 'UploadPriceName'
              Width = 185
              Sortable = True
            end
            item
              FieldName = 'UploadFileName'
              Title.Alignment = taCenter
              Title.Caption = 'UploadFileName'
              Width = 201
              Sortable = True
            end
            item
              FieldName = 'ClientPriceLogo'
              Title.Alignment = taCenter
              Title.Caption = 'ClientPriceLogo'
              Width = 196
              Sortable = True
            end
            item
              FieldName = 'UploadDelimiter'
              Title.Alignment = taCenter
              Title.Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100
              Width = 290
              Hint = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1089#1090#1086#1083#1073#1094#1086#1074' (UploadDelimiter)'
              Editor = lkUploadDelimiter
              Sortable = True
            end
            item
              FieldName = 'DeliveryTermCustomer'
              Title.Alignment = taCenter
              Title.Caption = #1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1082#1083#1080#1077#1085#1090#1072
              Width = 100
            end>
        end
        object UniHiddenPanel3: TUniHiddenPanel
          Left = 89
          Top = 139
          Width = 160
          Height = 256
          Hint = ''
          Visible = True
          object lkPriceProfiles: TUniDBLookupComboBox
            Left = 3
            Top = 68
            Width = 145
            Height = 23
            Hint = ''
            ListField = 'DestinationName'
            ListSource = dsProfilesDeliveryList
            KeyField = 'ProfilesDeliveryID'
            ListFieldIndex = 0
            DataField = 'ProfilesDeliveryID'
            DataSource = dsProfilesCustomer
            TabOrder = 1
            Color = clWindow
          end
          object lkUploadDelimiter: TUniDBLookupComboBox
            Left = 3
            Top = 161
            Width = 145
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
        Items.Strings = (
          #1069#1084#1077#1082#1089'.'#1088#1091#10#10
          #1060#1072#1081#1083)
        TabOrder = 0
        IconItems = <>
      end
      object cbNotificationMethod: TUniComboBox
        Left = 196
        Top = 77
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
        Width = 829
        Hint = ''
        Text = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 4
      end
    end
    object pcSuppliers: TUniTabSheet
      Hint = ''
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
      object UniLabel4: TUniLabel
        Left = 33
        Top = 37
        Width = 62
        Height = 13
        Hint = ''
        Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
        TabOrder = 1
      end
      object cbSuppliers: TUniDBLookupComboBox
        Left = 170
        Top = 35
        Width = 290
        Height = 23
        Hint = ''
        ListField = 'Brief'
        ListSource = dsSuppliers
        KeyField = 'SuppliersID'
        ListFieldIndex = 0
        ClearButton = True
        TabOrder = 0
        Color = clWindow
        OnChange = cbSuppliersChange
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
      object edtTaxes: TUniNumberEdit
        Left = 217
        Top = 35
        Width = 121
        Hint = ''
        TabOrder = 0
        MaxValue = 100.000000000000000000
        DecimalSeparator = ','
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
        ExplicitTop = 48
        ExplicitHeight = 410
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
          Hint = #1057#1074#1103#1079#1072#1085#1085#1099#1077' '#1082#1083#1080#1077#1085#1090#1099
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
          EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
          LayoutConfig.IgnorePosition = False
          LayoutConfig.Height = '0'
          LayoutConfig.Width = '100'
          BorderStyle = ubsNone
          Align = alClient
          TabOrder = 1
          ParentColor = False
          Color = clBtnFace
          OnKeyDown = GridKeyDown
          OnColumnSort = ManagerGridColumnSort
          OnCellContextClick = ManagerGridCellContextClick
          Columns = <
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
        Images = ImageList16
        ShowCaptions = True
        LayoutConfig.IgnorePosition = False
        LayoutConfig.DockWhenAligned = False
        TabOrder = 0
        ParentColor = False
        Color = clBtnFace
        OverflowHandler = ohMenu
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 1177
        object UniToolButton3: TUniToolButton
          Left = 0
          Top = 0
          ShowHint = True
          Action = actManagerAdd
          ImageIndex = 1
          IconAlign = iaLeft
          TabOrder = 0
        end
        object UniToolButton5: TUniToolButton
          Left = 90
          Top = 0
          ShowHint = True
          Action = actManagerEdit
          ImageIndex = 2
          IconAlign = iaLeft
          TabOrder = 2
        end
        object UniToolButton6: TUniToolButton
          Left = 180
          Top = 0
          ShowHint = True
          Action = actManagerDelete
          ImageIndex = 0
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
    Left = 712
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
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 645
    Top = 190
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
      '               ,@IsActive          = :NEW_IsActive   '
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
      '       '
      ''
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
    Left = 642
    Top = 130
  end
  object ImageList16: TUniImageList
    Left = 505
    Top = 179
    Bitmap = {
      494C010105003C00040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000010000000500000009000000030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00020000000E1A0F08768B5633EF0000000C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000070704
      0244704E34D0D1A876FFBC8A5DFF000000180000000D0000000B000000060000
      0002000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000010100001E402C1EA2C8A1
      74FDDEBC8BFFDDBA87FFCCA375FFB1835AF9AC7E55F8865E3FE1452C1BAF0C07
      0455000000090000000200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000005815E46D9E9D5B7FFE6CC
      A1FFE5C89BFFE3C597FFE1C192FFDFBD8CFFDEBB8AFFDEBB89FFDDBA88FFCBA0
      71FF5F3F29C50201002600000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000020100001E47382BA0DEC8
      AEFDF0E0C1FFECD6AEFFE2CAA7FFD9BC9DFFD6B697FFDCC0A1FFE7D0AFFFE3C5
      98FFDDBA8AFF876042DF0100001F000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000030B211988061510760A07
      0546836D59CDEDDDC6FFD4B392FF0100001E000000180705033C37281C91C8AC
      91F6E7CDA5FFDEBD8FFF3A281B99000000040000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000006459179EA3FBA93FF1F5A
      45D0000000181F18126DAA896AED00000007000000010000000200000004100C
      0853DEC4A4FFE4C89AFFA68361EB000000070000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000055AB296FA40C69CFF39A3
      80FF0000001C0000000300000004000000010000000306140E71000000100000
      0018D7B99AFFEBD6B1FFC7A67FFA000000070000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000003376C5AC75DD3B1FF43C2
      9CFF13402FBA0000001A0000000300000002000000074EA98BFF1F664DE00208
      055614100C5AA48F7AE07D6854C8000000040000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000050F0B5379D0B8FF4FD0
      ABFF45C6A1FF359676F8154131B50A241A930B261C954DB695FF3EC59BFF3BB1
      8CFF133E2EB70305043D05040331000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000020F231C787BCE
      B7FE6DDBBDFF4ACFA9FF53D2AFFF5BD5B4FF5DD5B5FF5AD4B3FF49CCA6FF40C8
      9FFF42C79FFF379C7CF70A1E1682000000020000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000010309
      07413B6F5FC68ED4C1FF9DE3D2FF9FE9D7FF9BE7D5FF97E5D2FF73E0C6FF72DF
      C5FF78DDC2FF62B69CF610251E7F000000020000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000001010302250815115F0D221B780D221B797CC9B3FF90EAD6FF95DE
      CCFF305649B20002022400000001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000027DC8B3FF5F9787DD050E
      0B4D000000010000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B1D186C000000090000
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
      000000000000000000000000FFFFFF00F07F000000000000C01F000000000000
      0007000000000000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000008000000000000000C000000000000000E001000000000000
      FC03000000000000FF0F0000000000000000C003000780010000800200038001
      0000800200038001000080000003800100008003000380010000800000038001
      000080000001800100008000000080010000C000000080010000C00300008001
      0000C002000080010000C0020000800100004005000180010000C00F00078003
      00004017000F80070000C02F803FFFFF00000000000000000000000000000000
      000000000000}
  end
  object ActionList: TUniActionList
    Left = 414
    Top = 178
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 1
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 2
      OnExecute = actEditExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 0
      OnExecute = actDeleteExecute
    end
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 4
      OnExecute = actRefreshAllExecute
    end
    object actManagerAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 1
      OnExecute = actManagerAddExecute
    end
    object actManagerEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 2
      OnExecute = actManagerEditExecute
    end
    object actManagerDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 0
      OnExecute = actManagerDeleteExecute
    end
    object actManagerRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 4
      OnExecute = actManagerRefreshExecute
    end
    object actPriceProfilesAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1088#1086#1092#1080#1083#1100
      ImageIndex = 1
      OnExecute = actPriceProfilesAddExecute
    end
    object actPriceProfilesEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1092#1080#1083#1100
      ImageIndex = 2
      OnExecute = actPriceProfilesEditExecute
    end
    object actPriceProfilesDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1086#1092#1080#1083#1100
      ImageIndex = 0
      OnExecute = actPriceProfilesDeleteExecute
    end
    object actPriceProfilesRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 4
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
  object qSuppliers: TFDQuery
    Connection = UniMainModule.FDConnection
    SQL.Strings = (
      'select SuppliersID'
      '      ,Brief '
      '  from tSuppliers (nolock)')
    Left = 438
    Top = 273
    object qSuppliersSuppliersID: TFMTBCDField
      FieldName = 'SuppliersID'
    end
    object qSuppliersBrief: TWideStringField
      FieldName = 'Brief'
      Size = 255
    end
  end
  object dsSuppliers: TDataSource
    DataSet = qSuppliers
    Left = 435
    Top = 333
  end
  object dsManagerList: TDataSource
    DataSet = qManagerList
    Left = 984
    Top = 196
  end
  object qManagerList: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'Select c.UserID as EmployeeID, c.Name as Brief'
      '  from tUser c (nolock)'
      ' where not exists (select 1'
      '                     from pClientReliation p (nolock)'
      '                    where p.Spid     = @@spid'
      '                      and p.LinkID   = c.UserID'
      '                      and p.LinkType = 5)')
    Left = 987
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
    Left = 895
    Top = 133
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
      '           ,@LinkType          = 5  '
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
      '               ,@LinkType          = 5  '
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
    Images = ImageList16
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
      'select p.*'
      '      ,sp.Name   ProfilesDeliveryName'
      '      ,d.Name    UploadDelimiter'
      '  from pProfilesCustomer p (nolock)'
      '  left join tSupplierDeliveryProfiles sp (nolock)'
      '         on sp.ProfilesDeliveryID = p.ProfilesDeliveryID'
      '  left join tDelimiter d (nolock)'
      '         on d.DelimiterID = p.UploadDelimiterID'
      ' where p.Spid = @@Spid')
    Left = 744
    Top = 276
    object qProfilesCustomerSpid: TIntegerField
      FieldName = 'Spid'
      Origin = 'Spid'
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
    object qProfilesCustomerisActive: TBooleanField
      FieldName = 'isActive'
      Origin = 'isActive'
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
    object qProfilesCustomerID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object qProfilesCustomerProfilesDeliveryName: TWideStringField
      FieldName = 'ProfilesDeliveryName'
      Size = 60
    end
    object qProfilesCustomerBrief: TStringField
      FieldName = 'Brief'
      Size = 60
    end
    object qProfilesCustomerDeliveryTermCustomer: TIntegerField
      FieldName = 'DeliveryTermCustomer'
    end
  end
  object dsProfilesCustomer: TDataSource
    DataSet = qProfilesCustomer
    Left = 742
    Top = 330
  end
  object uProfilesCustomer: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    InsertSQL.Strings = (
      'declare @R                 numeric(18, 0)'
      '       ,@Brief             nvarchar(60)'
      ''
      'select @Brief      = :NEW_Brief'
      ''
      'if isnull(@Brief, '#39#39') = '#39#39
      'begin'
      
        ' RAISERROR ('#39#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1087#1086#1083#1077' ['#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1086#1092#1080#1083#1103']'#39', ' +
        '16, 1); '
      'end'
      ''
      '/*'
      'if exists (select 1'
      '             from [pProfilesCustomer](nolock)'
      '            where Spid            = @@spid'
      '              '
      ')'
      'begin'
      '   RAISERROR ('#39'!'#39', 16, 1); '
      'end'
      '*/'
      ''
      'INSERT INTO [pProfilesCustomer]'
      '           ([Spid]'
      '           ,[ProfilesCustomerID]'
      '           ,[ClientID]'
      '          -- ,[Brief]'
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
      '           )   '
      'VALUES (@@Spid, '
      '        0, '
      '        :NEW_ClientID, '
      '       -- :NEW_Brief, '
      '        :NEW_ProfilesDeliveryID, '
      '        :NEW_Margin, '
      '        :NEW_Reliability,         '
      '        :NEW_UploadFolder, '
      '        :NEW_UploadPriceName,         '
      '        :NEW_UploadFileName,  '
      '        :NEW_isActive,  '
      '        :NEW_ClientPriceLogo,  '
      '        :NEW_UploadDelimiterID,'
      '        :NEW_DeliveryTermCustomer);'
      ''
      'SELECT SCOPE_IDENTITY() AS ID')
    ModifySQL.Strings = (
      'declare @R                 numeric(18, 0)'
      '       ,@Brief             nvarchar(60)'
      ''
      'select @Brief      = :NEW_Brief'
      ''
      'if isnull(@Brief, '#39#39') = '#39#39
      'begin'
      
        ' RAISERROR ('#39#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1087#1086#1083#1077' ['#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1086#1092#1080#1083#1103']'#39', ' +
        '16, 1); '
      'end'
      ''
      ''
      'if exists (select 1'
      '             from [pProfilesCustomer](nolock)'
      '            where Spid            = @@spid'
      '              and Brief           = @Brief'
      '              and ID             <> :ID'
      '              '
      ')'
      'begin'
      '   RAISERROR ('#39#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1086#1092#1080#1083#1103' '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090'!'#39', 16, 1); '
      'end'
      ''
      'Update pProfilesCustomer'
      '   set'
      '       --[Brief]               = :NEW_Brief'
      '      [ProfilesDeliveryID]  = :NEW_ProfilesDeliveryID'
      '      ,[Margin]              = :NEW_Margin'
      '      ,[Reliability]         = :NEW_Reliability'
      '      ,[UploadFolder]        = :NEW_UploadFolder'
      '      ,[UploadPriceName]     = :NEW_UploadPriceName'
      '      ,[UploadFileName]      = :NEW_UploadFileName'
      '      ,[isActive]            = :NEW_isActive'
      '      ,[ClientPriceLogo]     = :NEW_ClientPriceLogo'
      '      ,[UploadDelimiterID]   = :NEW_UploadDelimiterID'
      '      ,[DeliveryTermCustomer] = :NEW_DeliveryTermCustomer'
      'where ID=:ID')
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
      'select p.*'
      '      ,sp.Name   DestinationName'
      '      ,d.Name    UploadDelimiter'
      
        '      ,sp.isMyDelivery                           -- '#1057#1095#1080#1090#1072#1090#1100' '#1089' '#1091#1095 +
        #1077#1090#1086#1084' '#1076#1086#1089#1090#1072#1074#1082#1080
      '      ,sp.isIgnore '
      '  from pProfilesCustomer p (nolock)'
      ' left join tSupplierDeliveryProfiles sp (nolock)'
      '         on sp.ProfilesDeliveryID = p.ProfilesDeliveryID'
      ' left join tDelimiter d (nolock)'
      '         on d.DelimiterID = p.UploadDelimiterID'
      ' where p.ID = :ID')
    Left = 627
    Top = 274
  end
  object qProfilesDeliveryList: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.KeyFields = 'ProfilesDeliveryID'
    SQL.Strings = (
      'select ProfilesDeliveryID, Name as DestinationName '
      '  from tSupplierDeliveryProfiles (nolock)'
      ' where SuppliersID = :SuppliersID')
    Left = 873
    Top = 272
    ParamData = <
      item
        Name = 'SUPPLIERSID'
        DataType = ftFMTBcd
        ParamType = ptInput
        Value = Null
      end>
    object qProfilesDeliveryListProfilesDeliveryID: TFDAutoIncField
      FieldName = 'ProfilesDeliveryID'
      KeyFields = 'ProfilesDeliveryID'
      Origin = 'ProfilesDeliveryID'
    end
    object qProfilesDeliveryListDestinationName: TWideStringField
      DisplayWidth = 60
      FieldName = 'DestinationName'
      Origin = 'DestinationLogo'
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
    Left = 985
    Top = 273
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
  object dsProfilesDeliveryList: TDataSource
    DataSet = qProfilesDeliveryList
    Left = 868
    Top = 327
  end
  object dsDelimiterList: TDataSource
    DataSet = qDelimiterList
    Left = 975
    Top = 347
  end
  object pmProfilesCustomer: TUniPopupMenu
    Images = ImageList16
    OnPopup = pmProfilesCustomerPopup
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
end
