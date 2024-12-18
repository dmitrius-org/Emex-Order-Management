object ExportForm: TExportForm
  Left = 0
  Top = 0
  ClientHeight = 650
  ClientWidth = 1606
  Caption = 'ExportForm'
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  ScreenMask.Enabled = True
  Layout = 'fit'
  TextHeight = 15
  object PG: TUniPageControl
    Left = 0
    Top = 0
    Width = 1606
    Height = 650
    Hint = ''
    ActivePage = TabNomenclature
    Align = alClient
    TabOrder = 0
    object TabNomenclature: TUniTabSheet
      Hint = ''
      Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072
      Layout = 'fit'
      object GridNomenclature: TUniDBGrid
        Left = 0
        Top = 0
        Width = 1598
        Height = 622
        Hint = ''
        ShowHint = True
        ParentShowHint = False
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
            'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
            'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
            'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
            'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
            'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
            't.body.removeChild(el);'#13#10'    };'#13#10'}')
        DataSource = DSNomenklature
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgAutoRefreshRow, dgRowNumbers]
        WebOptions.Paged = False
        WebOptions.FetchAll = True
        LoadMask.WaitData = True
        LoadMask.Message = 'Loading data...'
        LayoutConfig.ComponentCls = 'grid-order'
        Align = alClient
        TabOrder = 0
        ParentColor = False
        Color = clWindow
        Exporter.Enabled = True
        Exporter.UseColumnRenderer = True
        Exporter.Exporter = ExportNomenclature
        Exporter.Title = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072
        OnKeyDown = GridImplementationKeyDown
        OnCellContextClick = GridNomenclatureCellContextClick
        Columns = <
          item
            FieldName = 'Manufacturer'
            Title.Alignment = taCenter
            Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
            Width = 135
            ReadOnly = True
          end
          item
            FieldName = 'DetailNumber'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
            Width = 219
            ReadOnly = True
          end
          item
            FieldName = 'DetailName'
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1077#1090#1072#1083#1080
            Width = 300
          end
          item
            FieldName = 'DetailNumberDetailName'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' + '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1077#1090#1072#1083#1080
            Width = 361
            ReadOnly = True
          end
          item
            FieldName = 'ManufacturerDetailNumber'
            Title.Alignment = taCenter
            Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' + '#1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
            Width = 310
            ReadOnly = True
          end
          item
            FieldName = 'WeightKGF'
            Title.Alignment = taCenter
            Title.Caption = #1042#1077#1089' 1 '#1096#1090'.'
            Width = 107
            ReadOnly = True
          end
          item
            FieldName = 'BarCode'
            Title.Alignment = taCenter
            Title.Caption = #1064#1090#1088#1080#1093'-'#1082#1086#1076
            Width = 196
          end
          item
            FieldName = 'ClientBrief'
            Title.Alignment = taCenter
            Title.Caption = #1050#1083#1080#1077#1085#1090
            Width = 201
          end>
      end
    end
    object tabAdmission: TUniTabSheet
      Hint = ''
      Caption = #1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077
      Layout = 'fit'
      object GridAdmission: TUniDBGrid
        Left = 0
        Top = 0
        Width = 1598
        Height = 622
        Hint = ''
        ShowHint = True
        ParentShowHint = False
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
            'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
            'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
            'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
            'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
            'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
            't.body.removeChild(el);'#13#10'    };'#13#10'}')
        DataSource = dsAdmission
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgAutoRefreshRow, dgRowNumbers]
        WebOptions.Paged = False
        WebOptions.FetchAll = True
        LoadMask.WaitData = True
        LoadMask.Message = 'Loading data...'
        LayoutConfig.ComponentCls = 'grid-order'
        Align = alClient
        TabOrder = 0
        ParentColor = False
        Color = clWindow
        Exporter.Enabled = True
        Exporter.UseColumnRenderer = True
        Exporter.Exporter = ExportAdmission
        Exporter.Title = #1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077
        OnKeyDown = GridImplementationKeyDown
        OnCellContextClick = GridAdmissionCellContextClick
        Columns = <
          item
            FieldName = 'Manufacturer'
            Title.Alignment = taCenter
            Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072#1083#1080')'
            Width = 143
            ReadOnly = True
          end
          item
            FieldName = 'DetailNumber'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072#1083#1080')'
            Width = 146
            ReadOnly = True
          end
          item
            FieldName = 'ManufacturerDetailNumber'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072#1083#1080')'
            Width = 189
            ReadOnly = True
          end
          item
            FieldName = 'DetailNumberDetailName'
            Title.Alignment = taCenter
            Title.Caption = 
              #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' + '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1077#1090#1072#1083#1080' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072 +
              #1083#1080')'
            Width = 213
            ReadOnly = True
          end
          item
            FieldName = 'RManufacturerDetailNumber'
            Title.Alignment = taCenter
            Title.Caption = 
              #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' '#1079#1072#1084#1077#1085#1099' + '#1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' '#1079#1072#1084#1077#1085#1099' ('#1087#1077#1088#1074#1080#1095#1085#1086' '#1079#1072#1082#1072#1079#1072#1085#1085#1086#1081' ' +
              #1076#1077#1090#1072#1083#1080')'
            Width = 192
            ReadOnly = True
          end
          item
            FieldName = 'CustomerSubId'
            Title.Alignment = taCenter
            Title.Caption = 'SubID'
            Width = 129
          end
          item
            FieldName = 'Quantity'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
            Width = 107
          end
          item
            FieldName = 'PricePurchaseF'
            Title.Alignment = taCenter
            Title.Caption = #1062#1077#1085#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1060#1072#1082#1090
            Width = 131
          end
          item
            FieldName = 'AmountPurchaseF'
            Title.Alignment = taCenter
            Title.Caption = #1057#1091#1084#1084#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1060#1072#1082#1090
            Width = 139
          end
          item
            FieldName = 'reference'
            Title.Caption = 'reference'
            Width = 130
          end>
      end
    end
    object tabImplementation: TUniTabSheet
      Hint = ''
      Caption = #1056#1077#1072#1083#1080#1079#1072#1094#1080#1103
      Layout = 'fit'
      object GridImplementation: TUniDBGrid
        Left = 0
        Top = 0
        Width = 1598
        Height = 622
        Hint = ''
        ShowHint = True
        ParentShowHint = False
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'copyToClipboard = str => {'#13#10'        const el = document.createEl' +
            'ement('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0' +
            '].data[sender.uniCol];'#13#10'        el.value = document.activeElemen' +
            't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
            '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
            'ent.body.removeChild(el);'#13#10'    };'#13#10'}')
        DataSource = dsImplementation
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgAutoRefreshRow, dgRowNumbers]
        WebOptions.Paged = False
        WebOptions.FetchAll = True
        LoadMask.WaitData = True
        LoadMask.Message = 'Loading data...'
        LayoutConfig.ComponentCls = 'grid-order'
        Align = alClient
        TabOrder = 0
        ParentColor = False
        Color = clWindow
        Exporter.Enabled = True
        Exporter.UseColumnRenderer = True
        Exporter.Exporter = ExportImplementation
        Exporter.Title = #1056#1077#1072#1083#1080#1079#1072#1094#1080#1103
        OnKeyDown = GridImplementationKeyDown
        OnCellContextClick = GridImplementationCellContextClick
        Columns = <
          item
            FieldName = 'ClientBrief'
            Title.Alignment = taCenter
            Title.Caption = #1050#1083#1080#1077#1085#1090
            Width = 153
          end
          item
            FieldName = 'Manufacturer'
            Title.Alignment = taCenter
            Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072#1083#1080')'
            Width = 143
            ReadOnly = True
          end
          item
            FieldName = 'DetailNumber'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072#1083#1080')'
            Width = 146
            ReadOnly = True
          end
          item
            FieldName = 'ManufacturerDetailNumber'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072#1083#1080')'
            Width = 189
            ReadOnly = True
          end
          item
            FieldName = 'DetailNumberDetailName'
            Title.Alignment = taCenter
            Title.Caption = 
              #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' + '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1077#1090#1072#1083#1080' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072 +
              #1083#1080')'
            Width = 213
            ReadOnly = True
          end
          item
            FieldName = 'RManufacturerDetailNumber'
            Title.Alignment = taCenter
            Title.Caption = 
              #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' '#1079#1072#1084#1077#1085#1099' + '#1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' '#1079#1072#1084#1077#1085#1099' ('#1087#1077#1088#1074#1080#1095#1085#1086' '#1079#1072#1082#1072#1079#1072#1085#1085#1086#1081' ' +
              #1076#1077#1090#1072#1083#1080')'
            Width = 192
            ReadOnly = True
          end
          item
            FieldName = 'CustomerSubId'
            Title.Alignment = taCenter
            Title.Caption = 'SubID'
            Width = 96
          end
          item
            FieldName = 'Quantity'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
            Width = 96
          end
          item
            FieldName = 'PricePurchase'
            Title.Alignment = taCenter
            Title.Caption = #1062#1077#1085#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1088#1091#1073
            Width = 99
          end
          item
            FieldName = 'AmountPurchase'
            Title.Alignment = taCenter
            Title.Caption = #1057#1091#1084#1084#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1088#1091#1073
            Width = 96
          end
          item
            FieldName = 'Box'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1088#1086#1073#1082#1072
            Width = 120
          end
          item
            FieldName = 'reference'
            Title.Caption = 'reference'
            Width = 130
          end>
      end
      object UniDBGrid1: TUniDBGrid
        Left = 0
        Top = 0
        Width = 1598
        Height = 622
        Hint = ''
        ShowHint = True
        ParentShowHint = False
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
            'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
            'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
            'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
            'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
            'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
            't.body.removeChild(el);'#13#10'    };'#13#10'}')
        DataSource = DSNomenklature
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgAutoRefreshRow, dgRowNumbers]
        WebOptions.Paged = False
        WebOptions.FetchAll = True
        LoadMask.WaitData = True
        LoadMask.Message = 'Loading data...'
        LayoutConfig.ComponentCls = 'grid-order'
        Align = alClient
        TabOrder = 1
        ParentColor = False
        Color = clWindow
        Exporter.Enabled = True
        Exporter.UseColumnRenderer = True
        Exporter.Exporter = ExportNomenclature
        Exporter.Title = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072
        OnKeyDown = GridImplementationKeyDown
        OnCellContextClick = GridNomenclatureCellContextClick
        Columns = <
          item
            FieldName = 'Manufacturer'
            Title.Alignment = taCenter
            Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100
            Width = 135
            ReadOnly = True
          end
          item
            FieldName = 'DetailNumber'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
            Width = 219
            ReadOnly = True
          end
          item
            FieldName = 'DetailNumberDetailName'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' + '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1077#1090#1072#1083#1080
            Width = 361
            ReadOnly = True
          end
          item
            FieldName = 'ManufacturerDetailNumber'
            Title.Alignment = taCenter
            Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' + '#1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
            Width = 310
            ReadOnly = True
          end
          item
            FieldName = 'WeightKGF'
            Title.Alignment = taCenter
            Title.Caption = #1042#1077#1089' 1 '#1096#1090'.'
            Width = 107
            ReadOnly = True
          end
          item
            FieldName = 'BarCode'
            Title.Alignment = taCenter
            Title.Caption = #1064#1090#1088#1080#1093'-'#1082#1086#1076
            Width = 196
          end>
      end
    end
    object tabFragile: TUniTabSheet
      Hint = ''
      Caption = #1061#1088#1091#1087#1082#1086#1077
      object GridFragile: TUniDBGrid
        Left = 0
        Top = 0
        Width = 1598
        Height = 622
        Hint = ''
        ShowHint = True
        ParentShowHint = False
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
            'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
            'ent('#39'textarea'#39');'#13#10'       // el.value = sender.getSelection()[0].' +
            'data[sender.uniCol];'#13#10'        el.value = document.activeElement.' +
            'innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el.s' +
            'elect();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        documen' +
            't.body.removeChild(el);'#13#10'    };'#13#10'}')
        DataSource = dsFragile
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgAutoRefreshRow, dgRowNumbers]
        WebOptions.Paged = False
        WebOptions.FetchAll = True
        LoadMask.WaitData = True
        LoadMask.Message = 'Loading data...'
        LayoutConfig.ComponentCls = 'grid-order'
        Align = alClient
        TabOrder = 0
        ParentColor = False
        Color = clWindow
        Exporter.Enabled = True
        Exporter.UseColumnRenderer = True
        Exporter.Exporter = ExportFragile
        Exporter.Title = #1061#1088#1091#1087#1082#1086#1077
        OnKeyDown = GridImplementationKeyDown
        OnCellContextClick = GridFragileCellContextClick
        Columns = <
          item
            FieldName = 'Manufacturer'
            Title.Alignment = taCenter
            Title.Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072#1083#1080')'
            Width = 143
            ReadOnly = True
          end
          item
            FieldName = 'DetailNumber'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072#1083#1080')'
            Width = 146
            ReadOnly = True
          end
          item
            FieldName = 'ManufacturerDetailNumber'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072#1083#1080')'
            Width = 189
            ReadOnly = True
          end
          item
            FieldName = 'DetailNumberDetailName'
            Title.Alignment = taCenter
            Title.Caption = 
              #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' + '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1077#1090#1072#1083#1080' ('#1092#1072#1082#1090#1080#1095#1077#1089#1082#1080' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1086#1081' '#1076#1077#1090#1072 +
              #1083#1080')'
            Width = 213
            ReadOnly = True
          end
          item
            FieldName = 'RManufacturerDetailNumber'
            Title.Alignment = taCenter
            Title.Caption = 
              #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' '#1079#1072#1084#1077#1085#1099' + '#1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080' '#1079#1072#1084#1077#1085#1099' ('#1087#1077#1088#1074#1080#1095#1085#1086' '#1079#1072#1082#1072#1079#1072#1085#1085#1086#1081' ' +
              #1076#1077#1090#1072#1083#1080')'
            Width = 192
            ReadOnly = True
          end
          item
            FieldName = 'CustomerSubId'
            Title.Alignment = taCenter
            Title.Caption = 'SubID'
            Width = 129
          end
          item
            FieldName = 'Quantity'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
            Width = 107
          end
          item
            FieldName = 'PricePurchaseF'
            Title.Alignment = taCenter
            Title.Caption = #1062#1077#1085#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1060#1072#1082#1090
            Width = 131
          end
          item
            FieldName = 'AmountPurchaseF'
            Title.Alignment = taCenter
            Title.Caption = #1057#1091#1084#1084#1072' '#1079#1072#1082#1091#1087#1082#1080' '#1060#1072#1082#1090
            Width = 139
          end
          item
            FieldName = 'reference'
            Title.Caption = 'reference'
            Width = 130
          end>
      end
    end
  end
  object pmNomenclature: TUniPopupMenu
    Left = 227
    Top = 372
    object N1: TUniMenuItem
      Action = actExportNomenklature
    end
    object N2: TUniMenuItem
      Action = actRefreshNomenclatureAll
    end
  end
  object ExportNomenclature: TUniGridExcelExporter
    FileExtention = 'xlsx'
    MimeType = 
      'application/vnd.openxmlformats-officedocument.spreadsheetml.shee' +
      't'
    CharSet = 'UTF-8'
    Left = 586
    Top = 366
  end
  object actMain: TUniActionList
    Tag = -1
    Left = 102
    Top = 281
    object actRefreshNomenclatureAll: TAction
      Tag = -1
      Category = 'Action'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 5
    end
    object actExportNomenklature: TAction
      Tag = -1
      Category = 'Action'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
      OnExecute = actExportNomenklatureExecute
    end
    object ectExportAdmission: TAction
      Tag = -1
      Category = 'Action'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
      OnExecute = ectExportAdmissionExecute
    end
    object actRefreshAdmission: TAction
      Tag = -1
      Category = 'Action'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnExecute = actRefreshAdmissionExecute
    end
    object actExportImplementation: TAction
      Tag = -1
      Category = 'Action'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
      OnExecute = actExportImplementationExecute
    end
    object actRefreschImplementation: TAction
      Tag = -1
      Category = 'Action'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnExecute = actRefreschImplementationExecute
    end
    object actFragileRefresh: TAction
      Tag = -1
      Category = 'Action'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnExecute = actFragileRefreshExecute
    end
    object actExportFragile: TAction
      Category = 'Action'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
      OnExecute = actExportFragileExecute
    end
  end
  object FDExportNomenclature: TFDQuery
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evAutoFetchAll]
    SQL.Strings = (
      '    exec ExportNomenklature'
      '              @Invoice = :Invoice')
    Left = 348
    Top = 495
    ParamData = <
      item
        Name = 'INVOICE'
        DataType = ftWideString
        ParamType = ptInput
        Value = Null
      end>
    object FDExportNomenclatureManufacturer: TWideStringField
      FieldName = 'Manufacturer'
      Origin = 'Manufacturer'
      ReadOnly = True
      Size = 128
    end
    object FDExportNomenclatureDetailNumber: TWideStringField
      FieldName = 'DetailNumber'
      Origin = 'DetailNumber'
      ReadOnly = True
      Size = 32
    end
    object FDExportNomenclatureDetailName: TWideStringField
      FieldName = 'DetailName'
      Size = 256
    end
    object FDExportNomenclatureDetailNumberDetailName: TWideStringField
      FieldName = 'DetailNumberDetailName'
      Origin = 'DetailNumberDetailName'
      ReadOnly = True
      Size = 545
    end
    object FDExportNomenclatureManufacturerDetailNumber: TWideStringField
      FieldName = 'ManufacturerDetailNumber'
      Origin = 'ManufacturerDetailNumber'
      ReadOnly = True
      Size = 161
    end
    object FDExportNomenclatureWeightKGF: TFloatField
      FieldName = 'WeightKGF'
      Origin = 'WeightKGF'
      ReadOnly = True
    end
    object FDExportNomenclatureBarCode: TWideStringField
      FieldName = 'BarCode'
      Size = 32
    end
    object FDExportNomenclatureClientBrief: TWideStringField
      FieldName = 'ClientBrief'
      Size = 256
    end
  end
  object DSNomenklature: TDataSource
    DataSet = FDExportNomenclature
    Left = 466
    Top = 366
  end
  object FDExportAdmission: TFDQuery
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evAutoFetchAll]
    SQL.Strings = (
      '    exec ExportAdmission'
      '              @Invoice = :Invoice')
    Left = 353
    Top = 370
    ParamData = <
      item
        Name = 'INVOICE'
        DataType = ftWideString
        ParamType = ptInput
        Value = Null
      end>
    object FDExportAdmissionDetailNumber: TWideStringField
      FieldName = 'DetailNumber'
      Origin = 'DetailNumber'
      ReadOnly = True
      Size = 32
    end
    object FDExportAdmissionManufacturerDetailNumber: TWideStringField
      FieldName = 'ManufacturerDetailNumber'
      Origin = 'ManufacturerDetailNumber'
      ReadOnly = True
      Size = 93
    end
    object FDExportAdmissionDetailNumberDetailName: TWideStringField
      FieldName = 'DetailNumberDetailName'
      Origin = 'DetailNumberDetailName'
      ReadOnly = True
      Size = 545
    end
    object FDExportAdmissionRManufacturerDetailNumber: TWideStringField
      FieldName = 'RManufacturerDetailNumber'
      Origin = 'Unnamed6'
      ReadOnly = True
      Size = 161
    end
    object FDExportAdmissionCustomerSubId: TWideStringField
      FieldName = 'CustomerSubId'
      Origin = 'CustomerSubId'
      Size = 32
    end
    object FDExportAdmissionQuantity: TIntegerField
      FieldName = 'Quantity'
      Origin = 'Quantity'
    end
    object FDExportAdmissionPricePurchaseF: TCurrencyField
      FieldName = 'PricePurchaseF'
      Origin = 'PricePurchaseF'
      DisplayFormat = '###,##0.00'
    end
    object FDExportAdmissionAmountPurchaseF: TCurrencyField
      FieldName = 'AmountPurchaseF'
      Origin = 'AmountPurchaseF'
      DisplayFormat = '###,##0.00'
    end
    object FDExportAdmissionManufacturer: TWideStringField
      FieldName = 'Manufacturer'
      Origin = 'Manufacturer'
      ReadOnly = True
      Size = 128
    end
    object FDExportAdmissionreference: TWideStringField
      FieldName = 'reference'
      Size = 64
    end
  end
  object dsAdmission: TDataSource
    DataSet = FDExportAdmission
    Left = 468
    Top = 429
  end
  object ExportAdmission: TUniGridExcelExporter
    FileExtention = 'xlsx'
    MimeType = 
      'application/vnd.openxmlformats-officedocument.spreadsheetml.shee' +
      't'
    CharSet = 'UTF-8'
    Left = 586
    Top = 429
  end
  object pmAdmission: TUniPopupMenu
    Left = 224
    Top = 429
    object UniMenuItem1: TUniMenuItem
      Action = ectExportAdmission
    end
    object UniMenuItem2: TUniMenuItem
      Action = actRefreshAdmission
    end
  end
  object pmImplementation: TUniPopupMenu
    Left = 228
    Top = 490
    object UniMenuItem3: TUniMenuItem
      Action = actExportImplementation
    end
    object UniMenuItem4: TUniMenuItem
      Action = actRefreschImplementation
    end
  end
  object qImplementation: TFDQuery
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evAutoFetchAll]
    SQL.Strings = (
      '    exec ExportImplementation'
      '              @Invoice = :Invoice')
    Left = 353
    Top = 429
    ParamData = <
      item
        Name = 'INVOICE'
        DataType = ftWideString
        ParamType = ptInput
        Value = Null
      end>
    object WideStringField1: TWideStringField
      FieldName = 'DetailNumber'
      Origin = 'DetailNumber'
      ReadOnly = True
      Size = 32
    end
    object WideStringField2: TWideStringField
      FieldName = 'ManufacturerDetailNumber'
      Origin = 'ManufacturerDetailNumber'
      ReadOnly = True
      Size = 93
    end
    object WideStringField3: TWideStringField
      FieldName = 'DetailNumberDetailName'
      Origin = 'DetailNumberDetailName'
      ReadOnly = True
      Size = 545
    end
    object WideStringField4: TWideStringField
      FieldName = 'RManufacturerDetailNumber'
      Origin = 'Unnamed6'
      ReadOnly = True
      Size = 161
    end
    object WideStringField5: TWideStringField
      FieldName = 'CustomerSubId'
      Origin = 'CustomerSubId'
      Size = 32
    end
    object IntegerField1: TIntegerField
      FieldName = 'Quantity'
      Origin = 'Quantity'
    end
    object CurrencyField1: TCurrencyField
      FieldName = 'PricePurchase'
      Origin = 'PricePurchaseF'
      DisplayFormat = '###,##0.00'
    end
    object CurrencyField2: TCurrencyField
      FieldName = 'AmountPurchase'
      Origin = 'AmountPurchaseF'
      DisplayFormat = '###,##0.00'
    end
    object WideStringField6: TWideStringField
      FieldName = 'Manufacturer'
      Origin = 'Manufacturer'
      ReadOnly = True
      Size = 128
    end
    object qImplementationClientBrief: TWideStringField
      FieldName = 'ClientBrief'
      Size = 256
    end
    object qImplementationBox: TWideStringField
      FieldName = 'Box'
      Size = 15
    end
    object qImplementationreference: TWideStringField
      FieldName = 'reference'
      Size = 64
    end
  end
  object dsImplementation: TDataSource
    DataSet = qImplementation
    Left = 467
    Top = 493
  end
  object ExportImplementation: TUniGridExcelExporter
    FileExtention = 'xlsx'
    MimeType = 
      'application/vnd.openxmlformats-officedocument.spreadsheetml.shee' +
      't'
    CharSet = 'UTF-8'
    Left = 587
    Top = 491
  end
  object dsFragile: TDataSource
    DataSet = qFragile
    Left = 710
    Top = 191
  end
  object pmFragile: TUniPopupMenu
    Left = 638
    Top = 141
    object UniMenuItem5: TUniMenuItem
      Action = actExportFragile
    end
    object UniMenuItem6: TUniMenuItem
      Action = actFragileRefresh
    end
  end
  object ExportFragile: TUniGridExcelExporter
    FileExtention = 'xlsx'
    MimeType = 
      'application/vnd.openxmlformats-officedocument.spreadsheetml.shee' +
      't'
    CharSet = 'UTF-8'
    Left = 781
    Top = 140
  end
  object qFragile: TFDQuery
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evAutoFetchAll]
    SQL.Strings = (
      '    exec ExportFragile'
      '              @Invoice = :Invoice')
    Left = 709
    Top = 138
    ParamData = <
      item
        Name = 'INVOICE'
        DataType = ftWideString
        ParamType = ptInput
        Value = Null
      end>
    object WideStringField7: TWideStringField
      FieldName = 'DetailNumber'
      Origin = 'DetailNumber'
      ReadOnly = True
      Size = 32
    end
    object WideStringField8: TWideStringField
      FieldName = 'ManufacturerDetailNumber'
      Origin = 'ManufacturerDetailNumber'
      ReadOnly = True
      Size = 93
    end
    object WideStringField9: TWideStringField
      FieldName = 'DetailNumberDetailName'
      Origin = 'DetailNumberDetailName'
      ReadOnly = True
      Size = 545
    end
    object WideStringField10: TWideStringField
      FieldName = 'RManufacturerDetailNumber'
      Origin = 'Unnamed6'
      ReadOnly = True
      Size = 161
    end
    object WideStringField11: TWideStringField
      FieldName = 'CustomerSubId'
      Origin = 'CustomerSubId'
      Size = 32
    end
    object IntegerField2: TIntegerField
      FieldName = 'Quantity'
      Origin = 'Quantity'
    end
    object CurrencyField3: TCurrencyField
      FieldName = 'PricePurchaseF'
      Origin = 'PricePurchaseF'
      DisplayFormat = '###,##0.00'
    end
    object CurrencyField4: TCurrencyField
      FieldName = 'AmountPurchaseF'
      Origin = 'AmountPurchaseF'
      DisplayFormat = '###,##0.00'
    end
    object WideStringField12: TWideStringField
      FieldName = 'Manufacturer'
      Origin = 'Manufacturer'
      ReadOnly = True
      Size = 128
    end
    object WideStringField13: TWideStringField
      FieldName = 'reference'
      Size = 64
    end
  end
end
