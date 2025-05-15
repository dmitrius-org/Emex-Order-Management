object RefusalsT: TRefusalsT
  Left = 0
  Top = 0
  Width = 933
  Height = 455
  OnCreate = UniFrameCreate
  OnReady = UniFrameReady
  Layout = 'fit'
  LayoutConfig.Width = '100%'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  ShowHint = True
  ParentShowHint = False
  TabOrder = 0
  ParentColor = False
  ParentBackground = False
  object TopPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 933
    Height = 74
    Hint = ''
    Margins.Bottom = 0
    ShowHint = True
    Align = alTop
    TabOrder = 0
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
      Width = 933
      Height = 74
      Hint = ''
      Margins.Bottom = 0
      ShowHint = True
      ButtonHeight = 60
      ButtonWidth = 145
      Images = UniMainModule.BaseImage
      ShowCaptions = True
      ButtonAutoWidth = True
      LayoutConfig.Padding = '0px 0px 0px 5px'
      LayoutConfig.IgnorePosition = False
      LayoutConfig.Width = '100'
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
        Action = actUploadingRefusalsEmex
        ImageIndex = 19
        TabOrder = 1
      end
      object UniToolButton2: TUniToolButton
        AlignWithMargins = True
        Left = 154
        Top = 3
        ShowHint = True
        Action = actUpload
        ImageIndex = 17
        TabOrder = 2
      end
      object UniToolButton4: TUniToolButton
        AlignWithMargins = True
        Left = 305
        Top = 3
        ShowHint = True
        Action = actRefreshAll
        ImageIndex = 3
        TabOrder = 3
      end
    end
  end
  object GridPanel: TUniContainerPanel
    Left = 0
    Top = 148
    Width = 933
    Height = 307
    Hint = ''
    ShowHint = True
    ParentColor = False
    Align = alClient
    TabOrder = 2
    Layout = 'fit'
    LayoutConfig.Flex = 1
    LayoutConfig.Region = 'center'
    object Grid: TUniDBGrid
      Left = 0
      Top = 0
      Width = 933
      Height = 307
      Hint = ''
      ShowHint = True
      BodyRTL = False
      ClientEvents.ExtEvents.Strings = (
        
          'beforerender=function beforerender(sender, eOpts)'#13#10'{'#13#10'    var me' +
          '=sender.checkboxModel;'#13#10'    if (me) {'#13#10'        // '#1089#1082#1088#1099#1074#1072#1077#1084' Check' +
          'box '#1089' '#1079#1072#1075#1086#1083#1086#1074#1082#1072' '#1090#1072#1073#1083#1080#1094#1099#13#10'        me.showHeaderCheckbox=true;'#13#10'  ' +
          '  }'#13#10'}')
      ClientEvents.UniEvents.Strings = (
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'  config.displayInfo = true'#13#10'}'
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
          'data[sender.uniCol+1];'#13#10'        el.value = document.activeElemen' +
          't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
          '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
          'ent.body.removeChild(el);'#13#10'    };'#13#10'}'
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10'  var toolbar=sende' +
          'r.getDockedItems()[1]; //Remove the ToolBar fixed in the bottom'#13 +
          #10'  toolbar.items.getAt(10).hide(); //Remove the Refresh button i' +
          'n the ToolBar, number 10, hide him'#13#10#13#10'}')
      RowEditor = True
      DataSource = DataSource
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgCheckSelect, dgCheckSelectCheckOnly, dgAlwaysShowSelection, dgMultiSelect, dgTabs, dgAutoRefreshRow, dgDontShowSelected, dgRowNumbers]
      WebOptions.PageSize = 500
      WebOptions.CustomizableCells = False
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Color = clActiveCaption
      EmptyText = 
        '<p style="text-align:center;"><strong>'#1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...</strong></p' +
        '><p style="text-align:center;">'
      EnableColumnHide = False
      LayoutConfig.ComponentCls = 'grid-clients'
      LayoutConfig.Height = '0'
      LayoutConfig.DockWhenAligned = False
      BorderStyle = ubsNone
      Align = alClient
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      OnKeyDown = GridKeyDown
      OnCellContextClick = GridCellContextClick
      Columns = <
        item
          FieldName = 'FileName'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 785
          ReadOnly = True
        end
        item
          FieldName = 'InDateTime'
          Title.Caption = #1044#1072#1090#1072' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '
          Width = 169
        end>
    end
  end
  object gbFilter: TUniGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 77
    Width = 927
    Height = 68
    Hint = ''
    ShowHint = True
    Caption = #1060#1080#1083#1100#1090#1088
    Align = alTop
    LayoutConfig.Width = '0'
    TabOrder = 1
    object fCancel: TUniBitBtn
      Left = 487
      Top = 37
      Width = 128
      Height = 24
      ShowHint = True
      Action = actFilterClear
      TabOrder = 4
      ImageIndex = 16
    end
    object fOk: TUniBitBtn
      Left = 621
      Top = 37
      Width = 137
      Height = 24
      ShowHint = True
      Action = actFilter
      TabOrder = 5
      IconPosition = ipButtonEdge
      ScreenMask.Enabled = True
      ScreenMask.WaitData = True
      ScreenMask.Message = #1046#1076#1080#1090#1077', '#1086#1087#1077#1088#1072#1094#1080#1103' '#1074#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103
      ScreenMask.Target = Owner
      ImageIndex = 15
    end
    object fFileName: TUniEdit
      Left = 8
      Top = 38
      Width = 250
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 6
      CheckChangeDelay = 200
      ClearButton = True
    end
    object UniLabel4: TUniLabel
      Left = 8
      Top = 19
      Width = 121
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1092#1072#1081#1083#1072':'
      TabOrder = 1
    end
    object fDate: TUniDateTimePicker
      Left = 264
      Top = 38
      Width = 130
      Hint = ''
      ShowHint = True
      DateTime = 45454.000000000000000000
      DateFormat = 'dd/MM/yyyy'
      TimeFormat = 'HH:mm:ss'
      TabOrder = 7
      ClearButton = True
    end
    object UniLabel8: TUniLabel
      Left = 264
      Top = 19
      Width = 28
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1044#1072#1090#1072':'
      TabOrder = 2
    end
    object UniLabel5: TUniLabel
      Left = 400
      Top = 19
      Width = 50
      Height = 13
      Hint = ''
      ShowHint = True
      Caption = #1042' '#1072#1088#1093#1080#1074#1077':'
      TabOrder = 3
    end
    object fArchive: TUniComboBox
      Left = 400
      Top = 38
      Width = 81
      Hint = ''
      ShowHint = True
      Text = 'fArchive'
      Items.Strings = (
        #1053#1077#1090
        #1044#1072)
      ItemIndex = 0
      TabOrder = 8
      ClearButton = True
      IconItems = <>
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 594
    Top = 241
  end
  object ActionList: TUniActionList
    Left = 218
    Top = 188
    object actUpload: TAction
      Caption = #1057#1082#1072#1095#1072#1090#1100
      Hint = #1057#1082#1072#1095#1072#1090#1100' '#1092#1072#1081#1083
      ImageIndex = 17
      OnExecute = actUploadExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnExecute = actDeleteExecute
    end
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      ImageIndex = 3
      OnExecute = actRefreshAllExecute
    end
    object actUploadingRefusalsEmex: TAction
      Caption = #1054#1073#1088#1072#1073#1086#1090#1072#1090#1100' '#1086#1090#1082#1072#1079#1099' Emex'
      ImageIndex = 19
      OnExecute = actUploadingRefusalsEmexExecute
    end
    object actToArchive: TAction
      Caption = #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1074' '#1072#1088#1093#1080#1074
      Hint = #1060#1072#1081#1083' '#1073#1091#1076#1077#1090' '#1087#1077#1088#1077#1085#1077#1089#1077#1085' '#1074' '#1072#1088#1093#1080#1074#1085#1099#1081' '#1082#1072#1090#1072#1083#1086#1075
      ImageIndex = 18
      OnExecute = actToArchiveExecute
    end
    object actFilterClear: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      ImageIndex = 16
      OnExecute = actFilterClearExecute
    end
    object actFilter: TAction
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
      ImageIndex = 15
      OnExecute = actFilterExecute
    end
  end
  object PopupMenu: TUniPopupMenu
    Images = UniMainModule.BaseImage
    OnPopup = PopupMenuPopup
    Left = 218
    Top = 270
    object N3: TUniMenuItem
      Action = actUpload
    end
    object N2: TUniMenuItem
      Caption = '-'
    end
    object N1: TUniMenuItem
      Action = actToArchive
    end
    object N4: TUniMenuItem
      Action = actDelete
    end
    object N5: TUniMenuItem
      Caption = '-'
    end
    object N6: TUniMenuItem
      Action = actRefreshAll
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
    UpdateOptions.UpdateTableName = 'tOrderRefusals'
    UpdateOptions.KeyFields = 'OrderRefusalsID'
    UpdateOptions.AutoIncFields = 'OrderRefusalsID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'select *'
      '  from vOrderRefusals'
      ' where 1=1  '
      ' '
      '       !fFileName'
      '       '
      '       !fInDateTime'
      '       '
      '       !fArchive'
      '  '
      ' order by InDateTime desc')
    Left = 663
    Top = 241
    MacroData = <
      item
        Value = Null
        Name = 'FFILENAME'
      end
      item
        Value = Null
        Name = 'FINDATETIME'
      end
      item
        Value = Null
        Name = 'FARCHIVE'
      end>
    object QueryOrderRefusalsID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'OrderRefusalsID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QueryFileName: TWideStringField
      FieldName = 'FileName'
      ReadOnly = True
      Required = True
      Size = 128
    end
    object QueryFlag: TIntegerField
      FieldName = 'Flag'
    end
    object QueryInDateTime: TSQLTimeStampField
      FieldName = 'InDateTime'
    end
  end
  object UpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    InsertSQL.Strings = (
      ''
      '')
    ModifySQL.Strings = (
      ''
      '')
    DeleteSQL.Strings = (
      ''
      'declare @R        numeric(18, 0)'
      '       ,@IsCancel bit'
      ''
      'exec OrderRefusalsDelete '
      '       @OrderRefusalsID = :OLD_OrderRefusalsID'
      '      ,@IsCancel        = :IsCancel '
      ''
      'if @R > 0'
      'begin'
      ' declare @M nvarchar(1024)'
      ' set @M = dbo.GetRetMsg(@R)'
      ''
      ' RAISERROR (@M, 16, 1); '
      'end'
      '')
    FetchRowSQL.Strings = (
      'SELECT *'
      '  FROM dbo.vClients'
      ' WHERE ClientID = :ClientID')
    Left = 664
    Top = 333
  end
  object UniFileUpload: TUniFileUpload
    Filter = '.xls,.xlsm'
    Title = #1042#1099#1073#1077#1088#1080#1090#1077' '#1092#1072#1081#1083#1099' '#1086#1090#1082#1072#1079#1072' '#1076#1083#1103' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
    Messages.Uploading = 'Uploading...'
    Messages.PleaseWait = 'Please Wait'
    Messages.Cancel = #1054#1090#1084#1077#1085#1080#1090#1100
    Messages.Processing = 'Processing...'
    Messages.UploadError = 'Upload Error'
    Messages.Upload = #1047#1072#1075#1088#1091#1079#1080#1090#1100
    Messages.NoFileError = 'Please select a file'
    Messages.BrowseText = #1042#1099#1073#1088#1072#1090#1100'...'
    Messages.UploadTimeout = 'Timeout occurred...'
    Messages.MaxSizeError = 'File is bigger than maximum allowed size'
    Messages.MaxFilesError = 'You can upload maximum %d files.'
    Width = 400
    MultipleFiles = True
    OnMultiCompleted = UniFileUploadMultiCompleted
    Left = 577
    Top = 165
  end
end
