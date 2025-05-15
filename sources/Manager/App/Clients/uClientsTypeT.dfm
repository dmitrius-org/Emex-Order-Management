object ClientsTypeT: TClientsTypeT
  Left = 0
  Top = 0
  Width = 1114
  Height = 574
  OnCreate = UniFrameCreate
  Layout = 'fit'
  LayoutConfig.Width = '100'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  ShowHint = True
  ParentShowHint = False
  TabOrder = 0
  object hdFilter: TUniHiddenPanel
    Left = 29
    Top = 330
    Width = 160
    Height = 161
    Hint = ''
    Visible = True
    ShowHint = True
    object fUserID: TUniEdit
      Left = 17
      Top = 14
      Width = 121
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 1
      EmptyText = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088'...'
    end
    object fName: TUniEdit
      Left = 18
      Top = 68
      Width = 121
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 3
      EmptyText = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'...'
    end
    object fBrief: TUniEdit
      Left = 19
      Top = 40
      Width = 121
      Hint = ''
      ShowHint = True
      Text = ''
      TabOrder = 2
      EmptyText = #1051#1086#1075#1080#1085'...'
    end
    object fisAdmin: TUniCheckBox
      Left = 20
      Top = 95
      Width = 97
      Height = 17
      Hint = ''
      ShowHint = True
      Caption = ''
      TabOrder = 4
    end
    object fisBlock: TUniCheckBox
      Left = 20
      Top = 118
      Width = 97
      Height = 17
      Hint = ''
      ShowHint = True
      Caption = ''
      TabOrder = 5
    end
  end
  object UniPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 1114
    Height = 67
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
      Width = 1114
      Height = 67
      Hint = ''
      Margins.Bottom = 0
      ShowHint = True
      ButtonHeight = 60
      ButtonWidth = 90
      Images = UniMainModule.BaseImage
      ShowCaptions = True
      LayoutConfig.Padding = '0px 0px 0px 5px'
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
        Action = actAdd
        ImageIndex = 0
        TabOrder = 1
      end
      object UniToolButton2: TUniToolButton
        AlignWithMargins = True
        Left = 99
        Top = 3
        ShowHint = True
        Action = actEdit
        ImageIndex = 1
        TabOrder = 2
      end
      object UniToolButton4: TUniToolButton
        AlignWithMargins = True
        Left = 195
        Top = 3
        ShowHint = True
        Action = actDelete
        ImageIndex = 2
        TabOrder = 3
        ExplicitLeft = 291
      end
    end
  end
  object UniPanel2: TUniPanel
    Left = 0
    Top = 67
    Width = 1114
    Height = 507
    Hint = ''
    ShowHint = True
    Align = alClient
    TabOrder = 1
    BorderStyle = ubsNone
    Caption = 'UniPanel2'
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'fit'
    LayoutConfig.Flex = 1
    LayoutConfig.Width = '100'
    LayoutConfig.Region = 'center'
    object Grid: TUniDBGrid
      Left = 0
      Top = 0
      Width = 1114
      Height = 507
      Hint = ''
      ShowHint = True
      BodyRTL = False
      ClientEvents.UniEvents.Strings = (
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'    config.displayInfo = true'#13#10'}'
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
          'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
          'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
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
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete]
      WebOptions.PageSize = 50
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
      LoadMask.Color = clActiveCaption
      EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
      LayoutConfig.Cls = 'GridLotacao'
      LayoutConfig.ComponentCls = 'grid-client-Type'
      LayoutConfig.Height = '100'
      LayoutConfig.Width = '100'
      BorderStyle = ubsNone
      Align = alClient
      Anchors = []
      TabOrder = 0
      ParentColor = False
      Color = clBtnFace
      OnKeyDown = GridKeyDown
      OnClearFilters = GridClearFilters
      OnCellContextClick = GridCellContextClick
      OnColumnFilter = GridColumnFilter
      Columns = <
        item
          FieldName = 'ClientTypeID'
          Title.Alignment = taCenter
          Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
          Width = 127
          ReadOnly = True
        end
        item
          FieldName = 'Name'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 201
        end
        item
          FieldName = 'Comment'
          Title.Alignment = taCenter
          Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          Width = 248
        end
        item
          FieldName = 'Prepayment'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1077#1076#1086#1087#1083#1072#1090#1072
          Width = 96
        end
        item
          FieldName = 'PrepaymentAmount'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1077#1076#1086#1087#1083#1072#1090#1072
          Width = 107
        end
        item
          FieldName = 'Margin'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1094#1077#1085#1082#1072
          Width = 95
        end
        item
          FieldName = 'Reliability'
          Title.Alignment = taCenter
          Title.Caption = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1087#1086#1089#1090#1072#1074#1082#1080
          Width = 104
          Hint = #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1087#1086#1089#1090#1072#1074#1082#1080' '
        end
        item
          FieldName = 'IsActive'
          Title.Alignment = taCenter
          Title.Caption = #1040#1082#1090#1080#1074#1077#1085
          Width = 75
        end>
    end
  end
  object Query: TFDQuery
    AfterPost = QueryAfterPost
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.KeyFields = 'ClientTypeID'
    UpdateOptions.AutoIncFields = 'ClientTypeID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      ''
      '  select ClientTypeID     '
      '        ,Name'#9'          '
      '        ,Comment          '
      '        ,Prepayment       '
      '        ,PrepaymentAmount '
      '        ,Margin           '
      '        ,IsActive  '
      '        ,Reliability'
      '              '
      '    from tClientType (nolock)')
    Left = 610
    Top = 179
    object QueryClientTypeID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientTypeID'
      Origin = 'ClientTypeID'
      ProviderFlags = [pfInWhere]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QueryName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Size = 256
    end
    object QueryComment: TWideStringField
      FieldName = 'Comment'
      Origin = 'Comment'
      Size = 512
    end
    object QueryPrepayment: TBooleanField
      FieldName = 'Prepayment'
      Origin = 'Prepayment'
    end
    object QueryPrepaymentAmount: TCurrencyField
      FieldName = 'PrepaymentAmount'
      Origin = 'PrepaymentAmount'
      DisplayFormat = '###,##0 %'
      MaxValue = 100.000000000000000000
    end
    object QueryMargin: TCurrencyField
      FieldName = 'Margin'
      Origin = 'Margin'
      DisplayFormat = '###,##0 %'
      MaxValue = 100.000000000000000000
    end
    object QueryIsActive: TBooleanField
      FieldName = 'IsActive'
      Origin = 'IsActive'
    end
    object QueryReliability: TCurrencyField
      FieldName = 'Reliability'
      DisplayFormat = '###,##0 %'
      MaxValue = 100.000000000000000000
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 683
    Top = 181
  end
  object ActionList: TUniActionList
    Left = 219
    Top = 194
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
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
    object actView: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Visible = False
    end
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 3
      OnExecute = actRefreshAllExecute
    end
  end
  object PopupMenu: TUniPopupMenu
    Images = UniMainModule.BaseImage
    Left = 218
    Top = 271
    object N1: TUniMenuItem
      Action = actAdd
    end
    object N2: TUniMenuItem
      Action = actEdit
    end
    object N3: TUniMenuItem
      Action = actView
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
  object UpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    InsertSQL.Strings = (
      'declare @R                 numeric(18, 0)'
      '       ,@ClientTypeID      numeric(18, 0)'
      ''
      'exec @R = ClientTypeInsert'
      '             @ClientTypeID     = @ClientTypeID out    '
      '            ,@Name'#9'       = :NEW_Name    '
      '            ,@Comment          = :NEW_Comment'
      '            ,@Prepayment       = :NEW_Prepayment '
      '            ,@PrepaymentAmount = :NEW_PrepaymentAmount'
      '            ,@Margin           = :NEW_Margin '
      
        '            ,@Reliability      = :NEW_Reliability -- '#1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100 +
        ' '#1087#1086#1089#1090#1072#1074#1082#1080' '
      '           -- ,@Discount         = :NEW_Discount    -- '#1057#1082#1080#1076#1082#1072' '
      
        '           -- ,@Commission       = :NEW_Commission  -- '#1050#1086#1084#1080#1089#1089#1080#1103' ' +
        #1101#1082#1074#1072#1081#1077#1088#1072' '
      '            ,@IsActive         = :NEW_IsActive '
      '           '
      'if @R > 0'
      'begin'
      '  declare @M nvarchar(1024) = dbo.GetRetMsg(@R)'
      ''
      '  RAISERROR (@M, 16, 1); '
      'end'
      ''
      'SELECT @ClientTypeID as ClientTypeID '
      ''
      '')
    ModifySQL.Strings = (
      'declare @R                 numeric(18, 0)'
      '   '
      'exec @R = ClientTypeUpdate'
      '             @ClientTypeID     = :NEW_ClientTypeID '
      '            ,@Name'#9'       = :NEW_Name    '
      '            ,@Comment          = :NEW_Comment'
      '            ,@Prepayment       = :NEW_Prepayment '
      '            ,@PrepaymentAmount = :NEW_PrepaymentAmount'
      '            ,@Margin           = :NEW_Margin '
      
        '            ,@Reliability      = :NEW_Reliability -- '#1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100 +
        ' '#1087#1086#1089#1090#1072#1074#1082#1080' '
      '          --  ,@Discount         = :NEW_Discount    -- '#1057#1082#1080#1076#1082#1072' '
      
        '           -- ,@Commission       = :NEW_Commission  -- '#1050#1086#1084#1080#1089#1089#1080#1103' ' +
        #1101#1082#1074#1072#1081#1077#1088#1072'   '
      '            ,@IsActive         = :NEW_IsActive '
      '           '
      'if @R > 0'
      'begin'
      '  declare @M nvarchar(1024) = dbo.GetRetMsg(@R)'
      ''
      '  RAISERROR (@M, 16, 1); '
      'end'
      ''
      '')
    DeleteSQL.Strings = (
      'declare @R numeric(18, 0)'
      ''
      'exec @R= ClientTypeDelete @ClientTypeID = :ClientTypeID'
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
      '  FROM tClientType  (nolock)'
      ' WHERE ClientTypeID= :ClientTypeID')
    Left = 611
    Top = 271
  end
end
