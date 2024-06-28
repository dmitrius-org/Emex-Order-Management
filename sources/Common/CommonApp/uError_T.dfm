object Error_T: TError_T
  Left = 0
  Top = 0
  ClientHeight = 499
  ClientWidth = 1370
  Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  TextHeight = 15
  object Grid: TUniDBGrid
    Left = 0
    Top = 0
    Width = 1370
    Height = 499
    Hint = ''
    ShowHint = True
    ParentShowHint = False
    BodyRTL = False
    ClientEvents.ExtEvents.Strings = (
      'added=function added(sender, container, pos, eOpts)'#13#10'{'#13#10#13#10'}')
    ClientEvents.UniEvents.Strings = (
      
        'pagingBar.beforeInit=function pagingBar.beforeInit(sender, confi' +
        'g)'#13#10'{'#13#10'    config.displayInfo=true'#13#10'   // config.displayMsg  = '#39 +
        'Visualizando {0} - {1} de <b>{2}</b>'#39','#13#10'   // config.emptyMsg   ' +
        ' = "N'#227'o h'#225' registros",'#13#10'}'
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
        'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
        'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
        'data[sender.uniCol+1];'#13#10'        el.value = document.activeElemen' +
        't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
        '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
        'ent.body.removeChild(el);'#13#10'    };'#13#10'}')
    RowEditor = True
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgRowNumbers]
    ReadOnly = True
    WebOptions.PageSize = 500
    WebOptions.CustomizableCells = False
    WebOptions.AppendPosition = tpCurrentRow
    WebOptions.FetchAll = True
    LoadMask.WaitData = True
    LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
    LoadMask.Color = clActiveCaption
    EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
    LayoutConfig.Height = '100'
    LayoutConfig.Width = '100'
    Align = alClient
    Anchors = []
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    PreventWrap = True
    OnKeyDown = GridKeyDown
    Columns = <
      item
        FieldName = 'ObjectID'
        Title.Caption = #1048#1044' '#1086#1073#1098#1077#1082#1090#1072
        Width = 87
      end
      item
        FieldName = 'MakeLogo'
        Title.Caption = #1041#1088#1077#1085#1076
        Width = 72
      end
      item
        FieldName = 'Manufacturer'
        Title.Caption = #1041#1088#1077#1085#1076
        Width = 135
      end
      item
        FieldName = 'DetailNumber'
        Title.Caption = #1053#1086#1084#1077#1088' '#1076#1077#1090#1072#1083#1080
        Width = 124
      end
      item
        FieldName = 'Reference'
        Title.Caption = 'Reference'
        Width = 128
      end
      item
        FieldName = 'CustomerSubId'
        Title.Caption = 'CustomerSubId'
        Width = 121
      end
      item
        FieldName = 'Retval'
        Title.Caption = #1048#1044' '#1086#1096#1080#1073#1082#1080
        Width = 105
      end
      item
        FieldName = 'Message'
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1086#1096#1080#1073#1082#1080
        Width = 554
        ReadOnly = True
        DisplayMemo = True
      end>
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 541
    Top = 178
  end
  object Query: TFDQuery
    AutoCalcFields = False
    Connection = UniMainModule.FDConnection
    FetchOptions.AssignedValues = [evAutoFetchAll]
    FormatOptions.AssignedValues = [fvDefaultParamDataType]
    FormatOptions.DefaultParamDataType = ftString
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
    UpdateOptions.UpdateTableName = 'tNodes'
    SQL.Strings = (
      'select ObjectID, '
      '       Retval, '
      '       Message,'
      '       MakeLogo,'
      '       Manufacturer,'
      '       DetailNumber,'
      '       Reference,'
      '       CustomerSubId'
      '  from vError')
    Left = 533
    Top = 114
    object QueryObjectID: TFMTBCDField
      FieldName = 'ObjectID'
      Origin = 'ObjectID'
      Required = True
      Precision = 18
      Size = 0
    end
    object QueryRetval: TFMTBCDField
      FieldName = 'Retval'
      Origin = 'Retval'
      Precision = 18
      Size = 0
    end
    object QueryMessage: TWideStringField
      FieldName = 'Message'
      Origin = 'Message'
      ReadOnly = True
      Size = 1538
    end
    object QueryMakeLogo: TWideStringField
      FieldName = 'MakeLogo'
      Size = 10
    end
    object QueryManufacturer: TWideStringField
      FieldName = 'Manufacturer'
      Size = 256
    end
    object QueryDetailNumber: TWideStringField
      FieldName = 'DetailNumber'
      Size = 64
    end
    object QueryReference: TWideStringField
      FieldName = 'Reference'
      Size = 64
    end
    object QueryCustomerSubId: TWideStringField
      FieldName = 'CustomerSubId'
      Size = 64
    end
  end
end
