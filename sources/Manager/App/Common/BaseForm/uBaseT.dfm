object BaseT: TBaseT
  Left = 0
  Top = 0
  Width = 909
  Height = 481
  OnCreate = UniFrameCreate
  Layout = 'fit'
  LayoutConfig.Width = '0'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  ShowHint = True
  ParentShowHint = False
  TabOrder = 0
  ClientEvents.UniEvents.Strings = (
    
      'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
      'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
      'ent('#39'textarea'#39');'#13#10'        el.value = sender.getSelection()[0].da' +
      'ta[sender.uniCol+1];'#13#10'       // el.value = document.activeElemen' +
      't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
      '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
      'ent.body.removeChild(el);'#13#10'    };'#13#10'}')
  object UniPanel2: TUniPanel
    Left = 0
    Top = 0
    Width = 909
    Height = 481
    Hint = ''
    ShowHint = True
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = 'UniPanel2'
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'fit'
    LayoutConfig.Flex = 1
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'center'
    object Grid: TUniDBGrid
      Left = 0
      Top = 0
      Width = 909
      Height = 481
      Hint = ''
      ShowHint = True
      BodyRTL = False
      ClientEvents.ExtEvents.Strings = (
        
          'columnhide=function columnhide(ct, column, eOpts)'#13#10'{'#13#10'  if (colu' +
          'mn.dataIndex >= 0) {'#13#10'    ajaxRequest(this, '#39'_columnhide'#39', ["col' +
          'umn=" + column.dataIndex, "hidden=" + column.hidden]);'#13#10'  }'#13#10'}'
        
          'columnshow=function columnshow(ct, column, eOpts)'#13#10'{'#13#10'  ajaxRequ' +
          'est(this, '#39'_columnshow'#39', ["column=" + column.dataIndex, "hidden=' +
          '" + column.hidden]);'#13#10'}')
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
          'r.getDockedItems()[1];'#13#10'  toolbar.items.getAt(10).hide(); '#13#10'  to' +
          'olbar.items.getAt(9).hide(); '#13#10#13#10'  sender.addPlugin('#39'gridexporte' +
          'r'#39');'#13#10'    '#13#10'  var exporterCfg = new Object({'#13#10'            type: ' +
          '"xlsx",'#13#10'            mimeType: "application/vnd.openxmlformats-o' +
          'fficedocument.spreadsheetml.sheet",'#13#10'            title: '#39#1048#1089#1090#1086#1088#1080#1103 +
          ' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1076#1077#1090#1072#1083#1080#39','#13#10'            fileName: "'#1048#1089#1090#1086#1088#1080#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1076#1077 +
          #1090#1072#1083#1080'.xlsx"'#13#10'        }); '#13#10#13#10'  // '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1082#1085#1086#1087#1082#1091' '#1074' '#1087#1072#1085#1077#1083#1100' '#1085#1072#1074#1080#1075 +
          #1072#1094#1080#1080#13#10'  if (!toolbar.exportBtn) {'#13#10'     toolbar.exportBtn = tool' +
          'bar.insert('#13#10'       0, '#13#10'       //{ xtype: '#39'tbseparator'#39' }'#13#10'    ' +
          '   {xtype: '#39'button'#39', text: '#39#39', tooltip : '#39#1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'#39', ha' +
          'ndler: function() {'#13#10'          sender.saveDocumentAs(exporterCfg' +
          ');'#13#10'       }}'#13#10'     );'#13#10'     toolbar.exportBtn.setIconCls('#39'ToExc' +
          'el'#39');// icon...     '#13#10'  }  '#13#10'}'
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
          'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
          'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
          'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
          't.body.removeChild(el);'#13#10'    };'#13#10'}'
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'  config.displayInfo = true'#13#10'}')
      RowEditor = True
      DataSource = DataSource
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgConfirmDelete, dgFilterClearButton]
      WebOptions.PageSize = 500
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Color = clActiveCaption
      EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
      LayoutConfig.Height = '100'
      LayoutConfig.Width = '100'
      BorderStyle = ubsNone
      Align = alClient
      Anchors = []
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      OnKeyDown = GridKeyDown
      OnAjaxEvent = GridAjaxEvent
      OnColumnSort = GridColumnSort
      OnColumnMove = GridColumnMove
      OnClearFilters = GridClearFilters
      OnCellContextClick = GridCellContextClick
      OnColumnResize = GridColumnResize
      OnColumnFilter = GridColumnFilter
    end
  end
  object Query: TFDQuery
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'select 1')
    Left = 686
    Top = 118
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 683
    Top = 178
  end
  object ActionList: TUniActionList
    Left = 221
    Top = 196
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      ImageIndex = 3
      OnExecute = actRefreshAllExecute
    end
  end
  object PopupMenu: TUniPopupMenu
    Images = UniMainModule.BaseImage
    Left = 218
    Top = 270
  end
  object UpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    Left = 754
    Top = 117
  end
end
