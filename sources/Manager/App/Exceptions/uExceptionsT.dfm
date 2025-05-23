inherited ExceptionsT: TExceptionsT
  Width = 1532
  ExplicitWidth = 1532
  object gbFilter: TUniGroupBox [0]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1526
    Height = 60
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    Caption = #1060#1080#1083#1100#1090#1088
    Align = alTop
    LayoutConfig.Width = '0'
    TabOrder = 1
    object fCancel: TUniBitBtn
      Left = 629
      Top = 29
      Width = 106
      Height = 24
      Hint = ''
      ShowHint = True
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 1
      ImageIndex = 3
      OnClick = fCancelClick
    end
    object fOk: TUniBitBtn
      Left = 516
      Top = 29
      Width = 107
      Height = 24
      Hint = ''
      ShowHint = True
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      TabOrder = 2
      IconPosition = ipButtonEdge
      ImageIndex = 2
      OnClick = fOkClick
    end
    object fType: TUniExCheckComboBox
      Left = 15
      Top = 29
      Width = 329
      Hint = ''
      ShowHint = True
      ShowSelectButton = True
      ShowSearch = True
      Text = ''
      TabOrder = 4
      ClientEvents.ExtEvents.Strings = (
        ''
        
          'afterrender=function afterrender(sender, eOpts) {'#13#10'   initComboB' +
          'oxSearch(sender, "id", "val");'#13#10'}')
      ClearButton = True
      IconItems = <>
    end
    object fDetailNum: TUniEdit
      Left = 350
      Top = 29
      Width = 160
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 5
      ClearButton = True
    end
    object UniLabel1: TUniLabel
      Left = 350
      Top = 12
      Width = 39
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1053#1086#1084#1077#1088':'
      TabOrder = 6
    end
    object UniLabel3: TUniLabel
      Left = 15
      Top = 12
      Width = 22
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1058#1080#1087':'
      TabOrder = 3
    end
  end
  inherited UniPanel2: TUniPanel
    Top = 66
    Width = 1532
    Height = 415
    ExplicitTop = 66
    ExplicitWidth = 1532
    ExplicitHeight = 415
    inherited Grid: TUniDBGrid
      Width = 1532
      Height = 415
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
          'r.getDockedItems()[1];'#13#10'  toolbar.items.getAt(10).hide(); '#13#10'  to' +
          'olbar.items.getAt(9).hide(); '#13#10#13#10'  sender.addPlugin('#39'gridexporte' +
          'r'#39');'#13#10'    '#13#10'  var exporterCfg = new Object({'#13#10'            type: ' +
          '"xlsx",'#13#10'            mimeType: "application/vnd.openxmlformats-o' +
          'fficedocument.spreadsheetml.sheet",'#13#10'            title: '#39#1048#1089#1082#1083#1102#1095#1077 +
          #1085#1080#1103#39','#13#10'            fileName: "'#1048#1089#1082#1083#1102#1095#1077#1085#1080#1103'.xlsx"'#13#10'        }); '#13#10#13#10 +
          '  // '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1074' '#1087#1072#1085#1077#1083#1100' '#1085#1072#1074#1080#1075#1072#1094#1080#1080#13#10'  if (!toolbar.exportB' +
          'tn) {'#13#10'     toolbar.exportBtn = toolbar.insert('#13#10'       0, '#13#10'   ' +
          '    //{ xtype: '#39'tbseparator'#39' }'#13#10'       {xtype: '#39'button'#39', text: '#39 +
          #39', tooltip : '#39#1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'#39', handler: function() {'#13#10'       ' +
          '   sender.saveDocumentAs(exporterCfg);'#13#10'       }}'#13#10'     );'#13#10'    ' +
          ' toolbar.exportBtn.setIconCls('#39'ToExcel'#39');// icon...     '#13#10'  }  '#13 +
          #10'}'
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
          'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
          'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
          'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
          't.body.removeChild(el);'#13#10'    };'#13#10'}'
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'  config.displayInfo = true'#13#10'}')
      Columns = <
        item
          FieldName = 'Brand'
          Title.Alignment = taCenter
          Title.Caption = #1041#1088#1077#1085#1076
          Width = 191
        end
        item
          FieldName = 'DetailNum'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1076' '#1076#1077#1090#1072#1083#1080
          Width = 196
        end
        item
          FieldName = 'DetailName'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 300
        end
        item
          FieldName = 'DetailNameF'
          Title.Alignment = taCenter
          Title.Caption = #1048#1079#1084#1077#1085#1077#1085#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 300
        end
        item
          FieldName = 'WeightKGF'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1089
          Width = 95
        end
        item
          FieldName = 'VolumeKGf'
          Title.Alignment = taCenter
          Title.Caption = #1054#1073#1098#1077#1084
          Width = 92
        end
        item
          FieldName = 'Restrictions'
          Title.Alignment = taCenter
          Title.Caption = 'Restrictions'
          Width = 118
        end
        item
          FieldName = 'Fragile'
          Title.Alignment = taCenter
          Title.Caption = 'Fragile'
          Width = 100
        end
        item
          FieldName = 'NLA'
          Title.Alignment = taCenter
          Title.Caption = 'NLA'
          Width = 81
        end>
    end
  end
  inherited Query: TFDQuery
    UpdateOptions.UpdateTableName = 'dbo.tPrice'
    UpdateOptions.KeyFields = 'PriceID'
    UpdateOptions.AutoIncFields = 'PriceID'
    SQL.Strings = (
      ''
      'DECLARE @Type as ID'
      ' '
      'if :Types <> '#39#39'    '
      '  INSERT INTO @Type (ID)'
      '  SELECT CAST(value AS NUMERIC(18, 0))'
      '    FROM STRING_SPLIT(:Types, '#39','#39');'
      '    '
      '                        '
      ' exec dbo.ExceptionsSelect            '
      '            @Type = @Type '
      '           ,@DetailNum = :DetailNum  '
      '')
    Left = 694
    Top = 198
    ParamData = <
      item
        Name = 'TYPES'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DETAILNUM'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object QueryBrand: TStringField
      FieldName = 'Brand'
      Size = 60
    end
    object QueryDetailNum: TStringField
      FieldName = 'DetailNum'
      Size = 60
    end
    object QueryDetailName: TStringField
      FieldName = 'DetailName'
      Size = 256
    end
    object QueryDetailNameF: TStringField
      FieldName = 'DetailNameF'
      Size = 256
    end
    object QueryWeightKGF: TFloatField
      FieldName = 'WeightKGF'
      DisplayFormat = '###,##0.000 '#1082#1075
    end
    object QueryVolumeKGf: TFloatField
      FieldName = 'VolumeKGf'
      DisplayFormat = '###,##0.000 '#1082#1075
    end
    object QueryRestrictions: TStringField
      FieldName = 'Restrictions'
      Size = 60
    end
    object QueryFragile: TBooleanField
      FieldName = 'Fragile'
    end
    object QueryNLA: TBooleanField
      FieldName = 'NLA'
    end
    object QueryPriceID: TFMTBCDField
      FieldName = 'PriceID'
    end
  end
  inherited DataSource: TDataSource
    Left = 691
    Top = 250
  end
  inherited ActionList: TUniActionList
    Tag = -1
    inherited actRefreshAll: TAction
      Tag = -1
    end
  end
  inherited PopupMenu: TUniPopupMenu
    object N1: TUniMenuItem
      Action = actRefreshAll
    end
  end
  inherited UpdateSQL: TFDUpdateSQL
    Left = 810
    Top = 213
  end
end
