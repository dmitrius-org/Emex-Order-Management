inherited test: Ttest
  inherited UniPanel2: TUniPanel
    Top = 67
    Height = 414
    inherited Grid: TUniDBGrid
      Top = 52
      Height = 362
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
          'r.getDockedItems()[1];'#13#10'  toolbar.items.getAt(10).hide(); '#13#10'  to' +
          'olbar.items.getAt(9).hide(); '#13#10#13#10'  sender.addPlugin('#39'gridexporte' +
          'r'#39');'#13#10'    '#13#10'  var exporterCfg = new Object({'#13#10'            type: ' +
          '"xlsx",'#13#10'            mimeType: "application/vnd.openxmlformats-o' +
          'fficedocument.spreadsheetml.sheet",'#13#10'            title: '#39'fgfgfgf' +
          'gfg'#39','#13#10'            fileName: "'#1048#1089#1090#1086#1088#1080#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1076#1077#1090#1072#1083#1080'.xlsx"'#13#10'  ' +
          '      }); '#13#10#13#10'  // '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1074' '#1087#1072#1085#1077#1083#1100' '#1085#1072#1074#1080#1075#1072#1094#1080#1080#13#10'  if (!t' +
          'oolbar.exportBtn) {'#13#10'     toolbar.exportBtn = toolbar.insert('#13#10' ' +
          '      0, '#13#10'       //{ xtype: '#39'tbseparator'#39' }'#13#10'       {xtype: '#39'bu' +
          'tton'#39', text: '#39#39', tooltip : '#39#1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'#39', handler: functio' +
          'n() {'#13#10'          sender.saveDocumentAs(exporterCfg);'#13#10'       }}'#13 +
          #10'     );'#13#10'     toolbar.exportBtn.setIconCls('#39'ToExcel'#39');// icon..' +
          '.     '#13#10'  }  '#13#10'}'
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
          'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
          'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
          'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
          't.body.removeChild(el);'#13#10'    };'#13#10'}'
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'  config.displayInfo = true'#13#10'}')
    end
    object gbFilter: TUniGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 903
      Height = 46
      Hint = ''
      ShowHint = True
      ParentShowHint = False
      Caption = #1060#1080#1083#1100#1090#1088
      Align = alTop
      LayoutConfig.Width = '0'
      TabOrder = 2
      ExplicitLeft = 6
      ExplicitTop = 11
    end
  end
  object ToolBars: TUniPanel [1]
    Left = 0
    Top = 0
    Width = 909
    Height = 67
    Hint = ''
    ShowHint = True
    Align = alTop
    TabOrder = 1
    BorderStyle = ubsNone
    Caption = ''
    Color = clBtnShadow
    Images = ImageList32
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'fit'
    LayoutAttribs.Align = 'top'
    LayoutAttribs.Pack = 'start'
    LayoutConfig.Width = '100'
    LayoutConfig.Region = 'north'
    ExplicitLeft = -348
    ExplicitWidth = 1257
    object ToolBar: TUniToolBar
      Left = 0
      Top = 0
      Width = 909
      Height = 67
      Hint = ''
      ShowHint = True
      ButtonHeight = 53
      ButtonWidth = 112
      Images = ImageList32
      ShowCaptions = True
      ButtonAutoWidth = True
      LayoutConfig.IgnorePosition = False
      LayoutConfig.DockWhenAligned = False
      Align = alClient
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      OverflowHandler = ohMenu
      ExplicitWidth = 1257
      object UniToolButton1: TUniToolButton
        AlignWithMargins = True
        Left = 3
        Top = 3
        ShowHint = True
        Action = actdelete
        TabOrder = 1
      end
      object UniToolButton2: TUniToolButton
        AlignWithMargins = True
        Left = 118
        Top = 3
        Hint = ''
        Margins.Left = 0
        ShowHint = True
        ImageIndex = 3
        Caption = ''
        TabOrder = 2
      end
      object UniToolButton4: TUniToolButton
        AlignWithMargins = True
        Left = 233
        Top = 3
        Hint = ''
        Margins.Left = 0
        ShowHint = True
        ImageIndex = 0
        Caption = ''
        TabOrder = 3
      end
    end
  end
  inherited ActionList: TUniActionList
    object actdelete: TAction
      Caption = 'actTest'
      OnExecute = actdeleteExecute
    end
  end
  inherited PopupMenu: TUniPopupMenu
    object actTest1: TUniMenuItem
      Action = actdelete
    end
  end
end
