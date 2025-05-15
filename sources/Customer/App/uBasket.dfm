object BasketF: TBasketF
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 1541
  Height = 618
  OnCreate = UniFrameCreate
  OnDestroy = UniFrameDestroy
  Layout = 'fit'
  LayoutConfig.IgnorePosition = False
  LayoutConfig.Width = '0'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  TabOrder = 0
  ParentColor = False
  ParentBackground = False
  object MainPanel: TUniPanel
    Left = 0
    Top = 80
    Width = 1541
    Height = 538
    Hint = ''
    Align = alClient
    TabOrder = 1
    BorderStyle = ubsNone
    ShowCaption = False
    Caption = 'MainPanel'
    LayoutConfig.Width = '0'
    object Grid: TUniDBGrid
      Left = 0
      Top = 0
      Width = 1541
      Height = 538
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ClientEvents.ExtEvents.Strings = (
        
          'reconfigure=function reconfigure(sender, store, columns, oldStor' +
          'e, oldColumns, eOpts)'#13#10'{'#13#10'    // '#1089#1082#1088#1099#1090#1080#1077' '#1082#1085#1086#1087#1082#1080' '#1054#1073#1085#1086#1074#1080#1090#1100' '#1094#1077#1085#1091#13#10' ' +
          '   var widgetColIndx=10;'#13#10'    columns[widgetColIndx].onWidgetAtt' +
          'ach = function(column, widget, record) {'#13#10'        widget.setHidd' +
          'en(record.get(widgetColIndx) == 0);'#13#10'    };'#13#10'}')
      ClientEvents.UniEvents.Strings = (
        
          'afterCreate=function afterCreate(sender)'#13#10'{'#13#10' // var toolbar=sen' +
          'der.getDockedItems()[1]; '#13#10' // toolbar.items.getAt(10).hide(); '#13 +
          #10'}'
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
          'copyToClipboard = str => {'#13#10'        const el = document.createEl' +
          'ement('#39'textarea'#39');'#13#10'        el.value = document.activeElement.in' +
          'nerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.sel' +
          'ect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        document.' +
          'body.removeChild(el);'#13#10'    };'#13#10'}'
        
          'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
          'g)'#13#10'{'#13#10'   config.displayInfo=true;'#13#10'}')
      ClicksToEdit = 1
      DataSource = DataSource
      Options = [dgEditing, dgTitles, dgIndicator, dgRowLines, dgRowSelect, dgCheckSelect, dgCheckSelectCheckOnly, dgAlwaysShowSelection, dgConfirmDelete, dgMultiSelect, dgTabs, dgAutoRefreshRow, dgDontShowSelected]
      WebOptions.Paged = False
      WebOptions.CustomizableCells = False
      WebOptions.AppendPosition = tpCurrentRow
      WebOptions.FetchAll = True
      LoadMask.Message = 'Loading data...'
      LoadMask.Target = Owner
      EmptyText = 
        '<div style="text-align: center;"><i class="fas fa-shopping-baske' +
        't"></i> '#1050#1086#1088#1079#1080#1085#1072' '#1087#1091#1089#1090#1072'</div>'#13#10
      EnableColumnHide = False
      LayoutConfig.ComponentCls = 'grid-basket'
      LayoutConfig.Width = '0'
      BorderStyle = ubsNone
      Align = alClient
      TabOrder = 0
      ParentColor = False
      Color = clBtnFace
      OnKeyDown = GridKeyDown
      OnAjaxEvent = GridAjaxEvent
      OnSelectionChange = GridSelectionChange
      OnAfterLoad = GridAfterLoad
      Columns = <
        item
          FieldName = 'MakeName'
          Title.Alignment = taCenter
          Title.Caption = #1041#1088#1077#1085#1076
          Width = 135
          Alignment = taCenter
          ReadOnly = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'DetailNum'
          Title.Alignment = taCenter
          Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
          Width = 149
          Alignment = taCenter
          ReadOnly = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'PartNameRus'
          Title.Alignment = taCenter
          Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          Width = 200
          ReadOnly = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'PriceLogo'
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1072#1081#1089#1083#1080#1089#1090
          Width = 113
          Alignment = taCenter
          ReadOnly = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'OurDelivery'
          Title.Alignment = taCenter
          Title.Caption = #1044#1085#1080
          Width = 74
          ReadOnly = True
          Hint = #1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'Packing'
          Title.Alignment = taCenter
          Title.Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1072#1103' '#1087#1072#1088#1090#1080#1103
          Width = 159
          ReadOnly = True
        end
        item
          FieldName = 'Quantity'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Width = 126
          Editor = UniSpinEdit1
          CheckBoxField.AutoPost = True
          CheckBoxField.Enabled = False
          CheckBoxField.BooleanFieldOnly = False
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'PriceRub'
          Title.Alignment = taCenter
          Title.Caption = #1062#1077#1085#1072
          Width = 129
          ReadOnly = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'Amount'
          Title.Alignment = taCenter
          Title.Caption = #1057#1091#1084#1084#1072
          Width = 142
          ReadOnly = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end
        item
          FieldName = 'Comment2'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
          Width = 350
        end
        item
          WidgetColumn.Enabled = True
          WidgetColumn.Widget = btnPriceRefresh
          WidgetColumn.Height = 25
          ShowToolTip = True
          FieldName = 'IsUpdating'
          Title.Caption = ' '
          Width = 137
          Alignment = taLeftJustify
        end
        item
          WidgetColumn.Enabled = True
          WidgetColumn.Widget = btnDeleteBasket
          WidgetColumn.Height = 25
          Title.Caption = ' '
          MinWidth = 50
          Width = 59
          Alignment = taCenter
          Expanded = True
          Menu.MenuEnabled = False
          Menu.ColumnHideable = False
        end>
    end
    object UniHiddenPanel1: TUniHiddenPanel
      Left = 69
      Top = 286
      Width = 160
      Height = 171
      Hint = ''
      Visible = True
      object btnDeleteBasket: TUniButtonWidget
        AlignWithMargins = True
        Left = 17
        Top = 24
        Width = 120
        Height = 34
        Hint = #1059#1076#1072#1083#1080#1090#1100
        ShowHint = True
        ParentShowHint = False
        Images = ImageList
        ImageIndex = 1
        ShowValue = False
        OnClick = btnDeleteBasketClick
        Caption = ''
      end
      object UniSpinEdit1: TUniSpinEdit
        Left = 17
        Top = 120
        Width = 121
        Hint = ''
        MaxValue = 1000
        MinValue = 1
        TabOrder = 3
      end
      object btnPriceRefresh: TUniButtonWidget
        AlignWithMargins = True
        Left = 17
        Top = 64
        Width = 120
        Height = 34
        Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1094#1077#1085#1091
        ShowHint = True
        ParentShowHint = False
        Images = ImageList
        ImageIndex = 2
        ShowCaption = True
        ShowValue = False
        OnClick = btnPriceRefreshClick
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1094#1077#1085#1091
      end
    end
  end
  object TopPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 1541
    Height = 80
    Hint = ''
    Align = alTop
    TabOrder = 0
    BorderStyle = ubsNone
    ShowCaption = False
    Caption = 'TopPanel'
    Layout = 'fit'
    LayoutConfig.Width = '0'
    object UniContainerPanel1: TUniContainerPanel
      Left = 0
      Top = 0
      Width = 1541
      Height = 80
      Hint = ''
      ParentColor = False
      Align = alClient
      TabOrder = 1
      LayoutAttribs.Columns = 2
      object UniPanel1: TUniPanel
        Left = 0
        Top = 0
        Width = 1123
        Height = 80
        Hint = ''
        Align = alClient
        TabOrder = 0
        BorderStyle = ubsNone
        ShowCaption = False
        Caption = 'UniPanel1'
        LayoutConfig.Region = 'center'
        object UniLabel4: TUniLabel
          Left = 436
          Top = 7
          Width = 169
          Height = 17
          Hint = ''
          Visible = False
          Caption = #1042#1086#1079#1084#1086#1078#1085#1086' '#1088#1072#1079#1084#1077#1089#1090#1080#1090#1100' '#1079#1072#1082#1072#1079
          ParentFont = False
          Font.Height = -13
          TabOrder = 3
        end
        object UniLabel5: TUniLabel
          Left = 545
          Top = 3
          Width = 188
          Height = 17
          Hint = ''
          Visible = False
          Caption = #1044#1086#1087#1083#1072#1090#1080#1090#1100' '#1076#1086' '#1079#1072#1082#1072#1079#1072' '#1074' '#1082#1086#1088#1079#1080#1085#1077
          ParentFont = False
          Font.Height = -13
          TabOrder = 2
        end
        object UniContainerPanel2: TUniContainerPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 393
          Height = 74
          Hint = ''
          ParentColor = False
          Align = alLeft
          TabOrder = 1
          object UniFieldContainer1: TUniFieldContainer
            AlignWithMargins = True
            Left = 3
            Top = 37
            Width = 387
            Height = 34
            Hint = ''
            ParentColor = False
            Align = alClient
            TabOrder = 2
            Layout = 'hbox'
            LayoutAttribs.Align = 'top'
            LayoutAttribs.Pack = 'center'
            LayoutAttribs.Columns = 3
            object edtOrderAmount: TUniLabel
              Left = 22
              Top = 21
              Width = 108
              Height = 17
              Hint = ''
              Alignment = taCenter
              AutoSize = False
              Caption = '0.00'
              ParentFont = False
              Font.Height = -13
              TabOrder = 3
              LayoutConfig.Flex = 1
            end
            object edtWeight: TUniLabel
              Left = 167
              Top = 6
              Width = 59
              Height = 17
              Hint = ''
              Alignment = taCenter
              AutoSize = False
              Caption = '0.00'
              ParentFont = False
              Font.Height = -13
              TabOrder = 1
              LayoutConfig.Flex = 1
            end
            object edtCount: TUniLabel
              Left = 278
              Top = 20
              Width = 100
              Height = 17
              Hint = ''
              Alignment = taCenter
              AutoSize = False
              Caption = #1055#1086#1079#1080#1094#1080#1081
              ParentFont = False
              Font.Height = -13
              TabOrder = 2
              LayoutConfig.Flex = 1
            end
          end
          object UniFieldContainer2: TUniFieldContainer
            AlignWithMargins = True
            Left = 3
            Top = 10
            Width = 387
            Height = 21
            Hint = ''
            Margins.Top = 10
            ParentColor = False
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 1
            Layout = 'hbox'
            LayoutAttribs.Align = 'top'
            LayoutAttribs.Pack = 'center'
            LayoutAttribs.Columns = 3
            LayoutConfig.Flex = 1
            DesignSize = (
              387
              21)
            object UniLabel9: TUniLabel
              Left = 31
              Top = 3
              Width = 77
              Height = 13
              Hint = ''
              Alignment = taCenter
              Caption = #1057#1091#1084#1084#1072' '#1074' '#1079#1072#1082#1072#1079
              Anchors = [akLeft, akTop, akBottom]
              ParentFont = False
              Font.Height = -12
              Font.Style = [fsBold]
              TabOrder = 2
              LayoutConfig.Flex = 1
            end
            object UniLabel10: TUniLabel
              Left = 182
              Top = 3
              Width = 18
              Height = 13
              Hint = ''
              Alignment = taCenter
              Caption = #1042#1077#1089
              ParentFont = False
              Font.Height = -12
              Font.Style = [fsBold]
              TabOrder = 3
              LayoutConfig.Flex = 1
            end
            object UniLabel11: TUniLabel
              Left = 311
              Top = 3
              Width = 48
              Height = 13
              Hint = ''
              Alignment = taCenter
              Caption = #1055#1086#1079#1080#1094#1080#1081
              Anchors = [akLeft, akTop, akBottom]
              ParentFont = False
              Font.Height = -12
              Font.Style = [fsBold]
              TabOrder = 1
              LayoutConfig.Flex = 1
            end
          end
        end
      end
      object UniPanel2: TUniPanel
        Left = 1123
        Top = 0
        Width = 418
        Height = 80
        Hint = ''
        Align = alRight
        TabOrder = 2
        BorderStyle = ubsNone
        ShowCaption = False
        Caption = 'UniPanel2'
        LayoutConfig.Region = 'east'
        DesignSize = (
          418
          80)
        object addOrder: TUniButton
          AlignWithMargins = True
          Left = 244
          Top = 8
          Width = 160
          Height = 62
          Hint = ''
          Caption = #1056#1072#1079#1084#1077#1089#1090#1080#1090#1100' '#1079#1072#1082#1072#1079
          Anchors = [akTop, akRight, akBottom]
          TabOrder = 2
          LayoutConfig.ColumnWidth = 150.000000000000000000
          OnClick = addOrderClick
        end
        object btnRefresh: TUniButton
          AlignWithMargins = True
          Left = 78
          Top = 8
          Width = 160
          Height = 62
          Action = actRefreshAll
          Anchors = [akTop, akRight, akBottom]
          TabOrder = 1
          ImageIndex = 5
          LayoutConfig.ColumnWidth = 150.000000000000000000
        end
      end
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 648
    Top = 253
  end
  object Query: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evItems, evAutoFetchAll]
    FetchOptions.Items = []
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.EnableInsert = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'BasketID'
    UpdateOptions.AutoIncFields = 'BasketID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'Select *'
      '       ,Sum(IsUpdating) over() as IsUpdatingExists  '
      '  from vBasket'
      ' where ClientID = :ClientID'
      'order by BasketID  ')
    Left = 576
    Top = 255
    ParamData = <
      item
        Name = 'CLIENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QueryBasketID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'BasketID'
      Origin = 'BasketID'
      ProviderFlags = [pfInWhere]
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QueryClientID: TFMTBCDField
      FieldName = 'ClientID'
      Origin = 'ClientID'
      ReadOnly = True
      Precision = 18
      Size = 0
    end
    object QueryMake: TWideStringField
      FieldName = 'Make'
      Origin = 'Make'
      ReadOnly = True
      Size = 10
    end
    object QueryMakeName: TWideStringField
      FieldName = 'MakeName'
      Origin = 'MakeName'
      ReadOnly = True
      Size = 64
    end
    object QueryDetailNum: TWideStringField
      FieldName = 'DetailNum'
      Origin = 'DetailNum'
      ReadOnly = True
      Size = 64
    end
    object QueryPartNameRus: TWideStringField
      FieldName = 'PartNameRus'
      Origin = 'PartNameRus'
      ReadOnly = True
      Size = 256
    end
    object QueryPriceLogo: TWideStringField
      FieldName = 'PriceLogo'
      Origin = 'PriceLogo'
      ReadOnly = True
      Size = 64
    end
    object QueryQuantity: TIntegerField
      FieldName = 'Quantity'
      Origin = 'Quantity'
      Required = True
    end
    object QueryPriceRub: TCurrencyField
      FieldName = 'PriceRub'
      ReadOnly = True
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryAmount: TCurrencyField
      FieldName = 'Amount'
      Origin = 'Amount'
      ReadOnly = True
      DisplayFormat = '###,##0.00 '#8381
    end
    object QueryOurDelivery: TIntegerField
      FieldName = 'OurDelivery'
    end
    object QueryIsUpdating: TIntegerField
      FieldName = 'IsUpdating'
    end
    object QueryIsUpdatingExists: TIntegerField
      FieldName = 'IsUpdatingExists'
    end
    object QueryPacking: TIntegerField
      FieldName = 'Packing'
      ReadOnly = True
    end
    object QueryComment2: TStringField
      FieldName = 'Comment2'
      Size = 128
    end
  end
  object qStatus: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT distinct'
      '       n.[NodeID]'
      '      ,n.[Name]'
      '  FROM [tNodes] n (nolock)'
      ' where n.Type = 0 -- '#1089#1086#1089#1090#1086#1103#1085#1080#1103)
    Left = 575
    Top = 316
  end
  object UpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    ModifySQL.Strings = (
      'declare @Quantity int'
      '       ,@Comment2 varchar(128)'
      ''
      'select @Quantity = :NEW_Quantity   '
      '      ,@Comment2 = :NEW_Comment2   '
      ''
      'update tBasket'
      
        '   set Quantity = (( @Quantity + Packing - 1 ) / Packing) * Pack' +
        'ing '
      
        '      ,Amount   = (( @Quantity + Packing - 1 ) / Packing) * Pack' +
        'ing * PriceRub'
      '      ,Comment2 = @Comment2'
      '  FROM tBasket (updlock)'
      ' WHERE BasketID = :BasketID')
    DeleteSQL.Strings = (
      'declare @Comment   nvarchar(1024)'
      '       ,@AuditID   numeric(18, 0)'
      ''
      
        'select @Comment = '#39#1059#1076#1072#1083#1077#1085#1080#1077' '#1076#1077#1090#1072#1083#1080': ClientID= '#39' + convert(varcha' +
        'r, ClientID) + '#39', Make='#39' + Make + '#39', MakeName='#39' + MakeName + '#39', ' +
        'DetailNum='#39' + DetailNum'
      '  from tBasket (nolock)'
      ' where BasketID=:OLD_BasketID'
      ''
      '-- '#1072#1091#1076#1080#1090
      'exec AuditInsert'
      '         @AuditID        = @AuditID out'
      '        ,@ObjectID       = :OLD_BasketID'
      '        ,@ObjectTypeID   = 6'#9'-- '#1050#1086#1088#1079#1080#1085#1072
      '        ,@ActionID       = 3'#9'-- acDelete'
      '        ,@Comment        = @Comment'
      ''
      ''
      
        'Delete tBasket from tBasket (rowlock) where BasketID=:OLD_Basket' +
        'ID')
    FetchRowSQL.Strings = (
      'SELECT Quantity'
      '      ,Amount'
      '      ,Comment2'
      '  FROM vBasket'
      ' WHERE BasketID = :BasketID')
    Left = 497
    Top = 254
  end
  object actMain: TUniActionList
    Left = 98
    Top = 206
    object actRefreshAll: TAction
      Category = 'Action'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 5
      OnExecute = actRefreshAllExecute
    end
  end
  object ImageList: TUniNativeImageList
    Left = 816
    Top = 256
    Images = {
      03000000FFFFFF1F057E04000000000100010010102000000000006804000016
      0000002800000010000000200000000100200000000000000400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000545454DD70
      7070FF707070FF707070FF707070FF707070FF707070FF707070FF707070FF00
      000000000000000000000000000000000000000000000000000000707070FF00
      000000707070FF00000000707070FF00000000707070FF00000000707070FF00
      000000000000000000000000000000000000000000000000000000707070FF00
      000000707070FF00000000707070FF00000000707070FF00000000707070FF00
      000000000000000000000000000000000000000000000000000000707070FF00
      000000707070FF00000000707070FF00000000707070FF00000000707070FF00
      000000000000000000000000000000000000000000000000000000707070FF00
      000000707070FF00000000707070FF00000000707070FF00000000707070FF00
      000000000000000000000000000000000000000000000000000000707070FF00
      000000707070FF00000000707070FF00000000707070FF00000000707070FF00
      000000000000000000000000000000000000000000000000000000707070FF00
      000000707070FF00000000707070FF00000000707070FF00000000707070FF00
      000000000000000000000000000000000000000000000000000000707070FF00
      000000707070FF00000000707070FF00000000707070FF00000000707070FF00
      000000000000000000000000000000000000000000000000000000707070FF70
      7070FF707070FF707070FF707070FF707070FF707070FF707070FF707070FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000707070FF707070FF70
      7070FF707070FF707070FF707070FF707070FF707070FF707070FF707070FF70
      7070FF0000000000000000000000000000000000000000707070FF707070FF70
      7070FF707070FF707070FF707070FF707070FF707070FF707070FF707070FF57
      5757E20000000000000000000000000000000000000000000000000000000000
      000000707070FFFEFEFEFFFFFFFFFFEFEFEFFF707070FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000525252DC707070FF707070FF707070FF707070FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFFFF1F057E040000000001000100101020000000
      0000680400001600000028000000100000002000000001002000000000000004
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000020000
      000A0000001000000009000000020000000000000000000000020000000A0000
      00120000000C00000003000000000000000000000000000000020000000F0E06
      41921C0E7EEF0602337A0000000E00000002000000020000000F0703337C1C0E
      7DF00F083F940000001200000002000000000000000000000008110A46923132
      AFFF3547CCFF1C1DA5FF0602347A0000000F0000000F0602347C1E1FA5FF3646
      CCFF2C2EAEFF120B45950000000B00000000000000000000000C271B8DF1586B
      D8FF3A50D3FF394ED2FF1D21A6FF0501337D0401347E1F21A6FF394FD3FF394F
      D3FF4B5ED4FF281C8CF100000010000000000000000000000006120E3C734C4E
      BAFF657DE0FF4059D6FF4059D7FF1E23A7FF2428A8FF4059D7FF4059D7FF5A71
      DEFF4749B8FF120F3B79000000090000000000000000000000010000000A1611
      3F73575BC1FF748DE6FF4963DBFF4964DBFF4964DBFF4963DBFF6883E3FF5255
      C0FF16113F780000000C00000002000000000000000000000000000000010000
      000A181543755C62C7FF6683E5FF5673E2FF5673E2FF5673E2FF555BC6FF1815
      437A0000000D0000000200000000000000000000000000000000000000010000
      00090F0D3D73494FBEFF7392EBFF6283E7FF6383E7FF6283E7FF373FB6FF0A07
      38780000000C0000000200000000000000000000000000000001000000071312
      416E545BC5FF85A1EFFF7797EDFF9CB6F4FF9DB7F5FF7897EEFF7696EDFF4049
      BCFF0D0C3C730000000A000000010000000000000000000000041717446B626B
      CFFF93AFF3FF83A1F1FFA6BFF7FF666CCAFF7D87DDFFAFC7F8FF83A3F2FF83A1
      F1FF4F57C4FF120F4071000000060000000000000000000000065557C3EFAFC6
      F6FF8EADF4FFABC4F8FF6E75D0FF1716456F23234F70868EE1FFB5CCF9FF8DAC
      F4FFA1B8F4FF5556C3EF0000000900000000000000000000000330316B8695A0
      EAFFC0D3F9FF7780D7FF1C1C496B00000006000000072426526C8B93E6FFC1D3
      F9FF949EE9FF2F31678700000005000000000000000000000001000000043032
      6B825C60CAEC1E1F4D68000000050000000100000001000000052627536B5C60
      CAEC303167830000000700000001000000000000000000000000000000000000
      0002000000040000000200000001000000000000000000000001000000030000
      0005000000040000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFF0000C1830000800100008001
      0000800100008001000080010000C0030000C003000080010000800100008001
      00008001000080010000E1830000FFFF0000FFFFFF1F057E0400000000010001
      0010102000000000006804000016000000280000001000000020000000010020
      0000000000000400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000014AFFD
      FE14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FF
      FF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14AFFDFE00000000000000000A6690
      9214B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FF
      FF14B1FFFF14B1FFFF14B1FFFF14B1FFFF0D6A97990000000000000000000C12
      1212A2EAEB14B1FFFF14B1FFFF14B1FFFF14B1FFFF667882FF687780FF14B1FF
      FF14B1FFFF14B1FFFF14B1FFFF13A4EDEE010E15150000000000000000000000
      000002030314B1FFFF14B1FFFF14B1FFFF14B1FFFF647A86FF657985FF14B1FF
      FF14B1FFFF14B1FFFF14B1FFFF00020404000000000000000000000000000000
      000000000014AFFDFE14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FFFF14B1FF
      FF14B1FFFF14B1FFFF14B1FFFF00000000000000000000000000000000000000
      000000000002121B1B12A8F2F314B1FFFF14B1FFFF717171FF717171FF14B1FF
      FF14B1FFFF12A8F2F302121B1B00000000000000000000000000000000000000
      0000000000000000000954797914B1FFFF14B1FFFF717171FF717171FF14B1FF
      FF14B1FFFF095377770000000000000000000000000000000000000000000000
      0000000000000000000000000014B1FFFF14B1FFFF717171FF717171FF14B1FF
      FF14B1FFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000E7EB5B614B1FFFF717171FF717171FF14B1FF
      FF0F7BB0B1000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000A5F888A14B1FFFF14B1FFFF0A5B81
      8300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000A0E0E14B1FFFF14B1FFFF00070B
      0B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000001081BCBD0E7CB2B3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001010100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FFFF0000FFFF00
      00800100008001000080010000C0030000E0070000E0070000F00F0000F81F00
      00F81F0000FC3F0000FC3F0000FE7F0000FEFF0000FFFF0000}
  end
end
