inherited SuppliersPriceT: TSuppliersPriceT
  inherited UniPanel2: TUniPanel
    Top = 51
    Height = 430
    ExplicitTop = 51
    ExplicitHeight = 430
    inherited Grid: TUniDBGrid
      Height = 430
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColumnMove, dgColLines, dgRowLines, dgConfirmDelete, dgFilterClearButton]
      LayoutConfig.ComponentCls = 'grid-prices'
      Columns = <
        item
          FieldName = 'Name'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1072#1081#1089#1072
          Width = 184
        end
        item
          FieldName = 'DeliveryTerm'
          Title.Alignment = taCenter
          Title.Caption = #1057#1088#1086#1082' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1087#1086' '#1087#1088#1072#1081#1089#1091
          Width = 143
        end
        item
          FieldName = 'DeliveryType'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087' '#1089#1088#1086#1082#1072' '#1076#1086#1089#1090#1072#1074#1082#1080
          Width = 184
          Editor = cbDeliveryType
        end
        item
          FieldName = 'InWorkingDays'
          Title.Alignment = taCenter
          Title.Caption = #1057#1088#1086#1082' '#1091#1082#1072#1079#1072#1085' '#1074' '#1088#1072#1073#1086#1095#1080#1093' '#1076#1085#1103#1093
          Width = 156
        end
        item
          FieldName = 'ShowInSearch'
          Title.Alignment = taCenter
          Title.Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074' '#1087#1086#1080#1089#1082#1077
          Width = 136
        end
        item
          FieldName = 'Comment'
          Title.Alignment = taCenter
          Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          Width = 300
        end>
    end
    object UniHiddenPanel1: TUniHiddenPanel
      Left = 749
      Top = 126
      Width = 160
      Height = 256
      Hint = ''
      Visible = True
      ShowHint = True
      object cbDeliveryType: TUniComboBox
        Left = 26
        Top = 29
        Width = 114
        Height = 23
        Hint = ''
        ShowHint = True
        Style = csOwnerDrawFixed
        Text = ''
        Items.Strings = (
          'Days'
          'Months  ')
        TabOrder = 1
        IconItems = <>
      end
    end
  end
  object UniPanel: TUniPanel [1]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 903
    Height = 48
    Hint = ''
    Margins.Bottom = 0
    ShowHint = True
    Align = alTop
    TabOrder = 1
    BorderStyle = ubsNone
    Caption = '1234'
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
      Width = 903
      Height = 48
      Hint = ''
      ShowHint = True
      BodyRTL = False
      ButtonHeight = 40
      ButtonWidth = 113
      Images = UniMainModule.BaseImage16
      ShowCaptions = True
      ButtonAutoWidth = True
      LayoutConfig.Padding = '0px 0px 0px 5px'
      LayoutConfig.IgnorePosition = False
      LayoutConfig.Region = 'center'
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
        IconAlign = iaLeft
        TabOrder = 0
      end
      object UniToolButton2: TUniToolButton
        AlignWithMargins = True
        Left = 122
        Top = 3
        ShowHint = True
        Action = actEdit
        ImageIndex = 1
        IconAlign = iaLeft
        TabOrder = 2
      end
      object UniToolButton4: TUniToolButton
        AlignWithMargins = True
        Left = 241
        Top = 3
        ShowHint = True
        Action = actDelete
        ImageIndex = 2
        IconAlign = iaLeft
        TabOrder = 3
      end
      object UniToolButton3: TUniToolButton
        AlignWithMargins = True
        Left = 360
        Top = 3
        ShowHint = True
        Action = actRefreshAll
        ImageIndex = 3
        IconAlign = iaLeft
        TabOrder = 4
      end
    end
  end
  inherited Query: TFDQuery
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'ID'
    SQL.Strings = (
      'select *'
      '  from vSupplierPrices')
    object QueryDeliveryType: TStringField
      FieldName = 'DeliveryType'
      Required = True
      Size = 30
    end
    object QueryName: TStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 30
    end
    object QueryComment: TStringField
      FieldName = 'Comment'
      Origin = 'Comment'
      Size = 256
    end
    object QueryDeliveryTerm: TIntegerField
      FieldName = 'DeliveryTerm'
      Required = True
    end
    object QueryInWorkingDays: TBooleanField
      FieldName = 'InWorkingDays'
    end
    object QueryShowInSearch: TBooleanField
      FieldName = 'ShowInSearch'
    end
    object QueryID: TFMTBCDField
      FieldName = 'ID'
    end
  end
  inherited ActionList: TUniActionList
    Tag = -1
    inherited actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091' '
    end
    object actInsert: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 0
      OnExecute = actInsertExecute
    end
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 1
      OnExecute = actEditExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnExecute = actDeleteExecute
    end
  end
  inherited PopupMenu: TUniPopupMenu
    object N1: TUniMenuItem
      Action = actInsert
    end
    object N2: TUniMenuItem
      Action = actEdit
    end
    object N3: TUniMenuItem
      Action = actDelete
    end
    object N5: TUniMenuItem
      Caption = '-'
    end
    object N4: TUniMenuItem
      Action = actRefreshAll
    end
  end
  inherited UpdateSQL: TFDUpdateSQL
    InsertSQL.Strings = (
      'declare @R       numeric(18, 0)'
      '       ,@Name    nvarchar(30)'
      ''
      'select @Name = :NEW_Name'
      ''
      'if isnull(@Name , '#39#39') = '#39#39
      'begin'
      ' RAISERROR ('#39#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1072#1081#1089#1072#39', 16, 1); '
      'end'
      ''
      'if exists (select 1'
      '             from pSupplierPrices (nolock)'
      '            where spid        = @@spid'
      '              and SuppliersID = :SuppliersID'
      '              and Name        = @Name)'
      'begin'
      
        '   select @R = 600 -- '#39#1055#1088#1072#1081#1089#1083#1080#1089#1090' '#1089' '#1079#1072#1076#1072#1085#1085#1099#1084' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077#1084' '#1089#1091#1097#1077#1089#1090 +
        #1074#1091#1102#1090'!'#39
      'end'
      ''
      'if @R > 0'
      'begin'
      ' declare @M nvarchar(1024)'
      ' set @M = dbo.GetRetMsg(@R)'
      ''
      ' RAISERROR (@M, 16, 1); '
      'end'
      ''
      'INSERT INTO pSupplierPrices '
      '           ([Name]'
      '           ,[Comment]'
      '           ,[DeliveryTerm]'
      '           ,[DeliveryType]'
      '           ,[Flag]'
      '           ,[InWorkingDays]'
      '           ,[ShowInSearch]  '
      '           ,[SuppliersID] '
      '           ,[Spid] '
      '           )'
      '     VALUES'
      '           (@Name '
      '           ,:NEW_Comment'
      '           ,:NEW_DeliveryTerm'
      '           ,:NEW_DeliveryType'
      '           ,:NEW_Flag'
      '           ,:New_InWorkingDays'
      '           ,:NEW_ShowInSearch'
      '           ,:NEW_SuppliersID'
      '           ,@@Spid'
      '           )'
      ''
      'SELECT @Name AS Name')
    ModifySQL.Strings = (
      'declare @R       numeric(18, 0)'
      '       ,@Name    nvarchar(30)'
      ''
      'select @Name = :NEW_Name'
      ''
      'if isnull(@Name , '#39#39') = '#39#39
      'begin'
      ' RAISERROR ('#39#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1072#1081#1089#1072#39', 16, 1); '
      'end'
      ''
      'if exists (select 1'
      '             from pSupplierPrices(nolock)'
      '            where Spid = @@Spid'
      '              and SuppliersID = :OLD_SuppliersID'
      '              and Name        = @Name'
      '              and Name       <> :OLD_Name)'
      'begin'
      
        '   select @r = 600 -- '#39#1055#1088#1072#1081#1089#1083#1080#1089#1090' '#1089' '#1079#1072#1076#1072#1085#1085#1099#1084' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077#1084' '#1089#1091#1097#1077#1089#1090 +
        #1074#1091#1102#1090'!'#39
      'end'
      ''
      'if @R > 0'
      'begin'
      ' declare @M nvarchar(1024)'
      ' set @M = dbo.GetRetMsg(@R)'
      ''
      ' RAISERROR (@M, 16, 1); '
      'end'
      ''
      'UPDATE pSupplierPrices'
      '   SET Name          = @Name'
      '      ,Comment       = :NEW_Comment'
      '      ,DeliveryTerm  = :NEW_DeliveryTerm'
      '      ,DeliveryType  = :NEW_DeliveryType'
      '      ,Flag          = :NEW_Flag'
      '      ,InWorkingDays = :NEW_InWorkingDays'
      '      ,ShowInSearch  = :NEW_ShowInSearch'
      ' WHERE ID = :OLD_ID;'
      ' '
      'SELECT @Name as Name        '
      '')
    DeleteSQL.Strings = (
      'DELETE FROM pSupplierPrices'
      ' WHERE ID = :OLD_ID ')
    FetchRowSQL.Strings = (
      'SELECT * '
      '  FROM vSupplierPrices '
      ' WHERE ID= :ID'
      '')
  end
end
