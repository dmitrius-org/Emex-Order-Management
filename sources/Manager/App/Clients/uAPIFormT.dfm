inherited APIFormT: TAPIFormT
  Width = 1139
  ExplicitWidth = 1139
  inherited UniPanel2: TUniPanel
    Top = 67
    Width = 1139
    Height = 414
    ExplicitTop = 67
    ExplicitWidth = 1139
    ExplicitHeight = 414
    inherited Grid: TUniDBGrid
      Top = 52
      Width = 1139
      Height = 362
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
          'r.getDockedItems()[1];'#13#10'  toolbar.items.getAt(10).hide(); '#13#10'  to' +
          'olbar.items.getAt(9).hide(); '#13#10#13#10'  sender.addPlugin('#39'gridexporte' +
          'r'#39');'#13#10'    '#13#10'  var exporterCfg = new Object({'#13#10'            type: ' +
          '"xlsx",'#13#10'            mimeType: "application/vnd.openxmlformats-o' +
          'fficedocument.spreadsheetml.sheet",'#13#10'            title: '#39'fgfgfgf' +
          'gfg'#39','#13#10'            fileName: "API.xlsx"'#13#10'        }); '#13#10#13#10'  // '#1044#1086 +
          #1073#1072#1074#1083#1103#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1074' '#1087#1072#1085#1077#1083#1100' '#1085#1072#1074#1080#1075#1072#1094#1080#1080#13#10'  if (!toolbar.exportBtn) {'#13#10 +
          '     toolbar.exportBtn = toolbar.insert('#13#10'       0, '#13#10'       //{' +
          ' xtype: '#39'tbseparator'#39' }'#13#10'       {xtype: '#39'button'#39', text: '#39#39', tool' +
          'tip : '#39#1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'#39', handler: function() {'#13#10'          send' +
          'er.saveDocumentAs(exporterCfg);'#13#10'       }}'#13#10'     );'#13#10'     toolba' +
          'r.exportBtn.setIconCls('#39'ToExcel'#39');// icon...     '#13#10'  }  '#13#10'}'
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
          'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
          'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
          'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
          't.body.removeChild(el);'#13#10'    };'#13#10'}'
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'  config.displayInfo = true'#13#10'}')
      RowEditor = False
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgConfirmDelete, dgFilterClearButton]
      Images = MainMenuImage
      LayoutConfig.Cls = 'grid-apikey'
      OnColumnActionClick = GridColumnActionClick
      Columns = <
        item
          FieldName = 'ApiKeysID'
          Title.Alignment = taCenter
          Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
          Width = 105
          Visible = False
          ReadOnly = True
        end
        item
          FieldName = 'Flag'
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Width = 80
          ReadOnly = True
        end
        item
          FieldName = 'Name'
          Title.Alignment = taCenter
          Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          Width = 271
        end
        item
          FieldName = 'ApiKey'
          Title.Alignment = taCenter
          Title.Caption = 'Api '#1082#1083#1102#1095
          Width = 225
          ReadOnly = True
        end
        item
          FieldName = 'inDatetime'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
          Width = 208
          ReadOnly = True
        end
        item
          FieldName = 'EndDatetime'
          Title.Alignment = taCenter
          Title.Caption = #1044#1072#1090#1072' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1080
          Width = 208
          ReadOnly = True
        end
        item
          ActionColumn.Enabled = True
          ActionColumn.Buttons = <
            item
              Action = actDelete
              ButtonId = 0
              UI = 'confirm'
              Hint = #1059#1076#1072#1083#1080#1090#1100
              ImageIndex = 2
            end>
          Title.Alignment = taCenter
          Title.Caption = ' '
          Width = 64
          Alignment = taCenter
          ImageOptions.Visible = True
        end>
    end
    object gbFilter: TUniGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 1133
      Height = 46
      Hint = ''
      Visible = False
      ShowHint = True
      ParentShowHint = False
      Caption = #1060#1080#1083#1100#1090#1088
      Align = alTop
      LayoutConfig.Width = '0'
      TabOrder = 2
    end
  end
  object ToolBars: TUniPanel [1]
    Left = 0
    Top = 0
    Width = 1139
    Height = 67
    Hint = ''
    ShowHint = True
    Align = alTop
    TabOrder = 1
    BorderStyle = ubsNone
    Caption = ''
    Color = clBtnShadow
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'fit'
    LayoutAttribs.Align = 'top'
    LayoutAttribs.Pack = 'start'
    LayoutConfig.Width = '100'
    LayoutConfig.Region = 'north'
    object ToolBar: TUniToolBar
      Left = 0
      Top = 0
      Width = 1139
      Height = 67
      Hint = ''
      ShowHint = True
      ButtonHeight = 53
      ButtonWidth = 123
      Images = MainMenuImage
      ShowCaptions = True
      ButtonAutoWidth = True
      LayoutConfig.Padding = '0px 0px 0px 5px'
      LayoutConfig.IgnorePosition = False
      LayoutConfig.DockWhenAligned = False
      Align = alClient
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      OverflowHandler = ohMenu
      object UniToolButton1: TUniToolButton
        AlignWithMargins = True
        Left = 3
        Top = 3
        ShowHint = True
        Action = actInsert
        ImageIndex = 0
        TabOrder = 1
      end
      object UniToolButton2: TUniToolButton
        AlignWithMargins = True
        Left = 129
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actUpdate
        ImageIndex = 1
        TabOrder = 2
      end
      object UniToolButton4: TUniToolButton
        AlignWithMargins = True
        Left = 255
        Top = 3
        Margins.Left = 0
        ShowHint = True
        Action = actDelete
        ImageIndex = 2
        TabOrder = 3
      end
      object UniToolButton3: TUniToolButton
        AlignWithMargins = True
        Left = 384
        Top = 3
        ShowHint = True
        Action = actRefreshAll
        ImageIndex = 3
        TabOrder = 4
      end
    end
  end
  inherited Query: TFDQuery
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.KeyFields = 'ApiKeysID'
    UpdateOptions.AutoIncFields = 'ApiKeysID'
    SQL.Strings = (
      'select * '
      '  from vApiKeys'
      ' where ClientID = :ClientID ')
    ParamData = <
      item
        Name = 'CLIENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QueryApiKeysID: TIntegerField
      FieldName = 'ApiKeysID'
      ReadOnly = True
    end
    object QueryClientID: TFMTBCDField
      FieldName = 'ClientID'
      ReadOnly = True
      Size = 0
    end
    object QueryApiKey: TStringField
      FieldName = 'ApiKey'
      ReadOnly = True
      OnGetText = QueryApiKeyGetText
      Size = 255
    end
    object QueryName: TStringField
      FieldName = 'Name'
      Size = 255
    end
    object QueryFlag: TIntegerField
      FieldName = 'Flag'
      ReadOnly = True
    end
    object QueryinDatetime: TSQLTimeStampField
      FieldName = 'inDatetime'
      ReadOnly = True
    end
    object QueryEndDatetime: TSQLTimeStampField
      FieldName = 'EndDatetime'
      ReadOnly = True
    end
  end
  inherited ActionList: TUniActionList
    Tag = 1043
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnExecute = actDeleteExecute
    end
    object actInsert: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1099#1081' '#1082#1083#1102#1095
      ImageIndex = 0
      OnExecute = actInsertExecute
    end
    object actUpdate: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 1
      OnExecute = actUpdateExecute
    end
  end
  inherited PopupMenu: TUniPopupMenu
    object ppInsert: TUniMenuItem
      Action = actInsert
    end
    object ppUpdate: TUniMenuItem
      Action = actUpdate
    end
    object ppDelete: TUniMenuItem
      Action = actDelete
    end
    object N3: TUniMenuItem
      Caption = '-'
    end
    object N1: TUniMenuItem
      Action = actRefreshAll
    end
  end
  inherited UpdateSQL: TFDUpdateSQL
    ModifySQL.Strings = (
      ' exec ApiKeyUpdate'
      '        @ApiKeysID = :ApiKeysID'
      '       ,@Name      = :NEW_Name')
    FetchRowSQL.Strings = (
      'select * '
      '  from vApiKeys'
      ' where ApiKeysID= :ApiKeysID')
  end
  object MainMenuImage: TUniNativeImageList
    Width = 24
    Height = 24
    Left = 512
    Top = 166
    Images = {01000000FF0000FF060900000074726173683B66613B}
  end
end
