object SuppliersF: TSuppliersF
  Left = 0
  Top = 0
  ClientHeight = 461
  ClientWidth = 1284
  Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
  OnShow = UniFormShow
  OldCreateOrder = False
  OnClose = UniFormClose
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  TextHeight = 15
  object UniPanel: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 414
    Width = 1278
    Height = 44
    Hint = ''
    Align = alBottom
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    ExplicitLeft = 387
    ExplicitTop = 408
    DesignSize = (
      1278
      44)
    object btnOk: TUniBitBtn
      Left = 1158
      Top = 4
      Width = 114
      Height = 35
      Hint = ''
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TUniBitBtn
      Left = 1071
      Top = 4
      Width = 81
      Height = 35
      Hint = ''
      Caption = #1054#1090#1084#1077#1085#1072
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
  object pcCommon: TUniPageControl
    Left = 0
    Top = 0
    Width = 1284
    Height = 411
    Hint = ''
    ActivePage = tabCommon
    Align = alClient
    TabOrder = 1
    object tabCommon: TUniTabSheet
      Hint = ''
      Caption = #1043#1083#1072#1074#1085#1072#1103
      object UniFieldContainer1: TUniFieldContainer
        Left = 0
        Top = 0
        Width = 1276
        Height = 143
        Hint = ''
        ParentColor = False
        Align = alTop
        TabOrder = 0
        DesignSize = (
          1276
          143)
        object edtBrief: TUniEdit
          Left = 160
          Top = 16
          Width = 1096
          Hint = ''
          Text = ''
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          ClearButton = True
        end
        object lblName: TUniLabel
          Left = 25
          Top = 16
          Width = 84
          Height = 13
          Hint = ''
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
          TabOrder = 2
        end
      end
      object fsAudit: TUniFieldSet
        AlignWithMargins = True
        Left = 3
        Top = 300
        Width = 1270
        Height = 80
        Hint = ''
        Title = #1040#1091#1076#1080#1090
        Collapsible = True
        Align = alBottom
        LayoutConfig.Region = 'south'
        TabOrder = 1
        object UniFieldContainer2: TUniFieldContainer
          Left = 2
          Top = 15
          Width = 1266
          Height = 63
          Hint = ''
          ParentColor = False
          Align = alClient
          TabOrder = 1
          object edtID: TUniEdit
            Left = 141
            Top = 8
            Width = 138
            Hint = ''
            Text = ''
            TabOrder = 1
            ReadOnly = True
          end
          object edtInDate: TUniDateTimePicker
            Left = 141
            Top = 33
            Width = 138
            Hint = ''
            DateTime = 45098.000000000000000000
            DateFormat = 'dd.MM.yyyy'
            TimeFormat = 'HH:mm:ss'
            ReadOnly = True
            TabOrder = 2
            DateMode = dtmDateTime
          end
          object edtUpdDate: TUniDateTimePicker
            Left = 415
            Top = 33
            Width = 145
            Hint = ''
            DateTime = 45098.000000000000000000
            DateFormat = 'dd.MM.yyyy'
            TimeFormat = 'HH:mm:ss'
            ReadOnly = True
            TabOrder = 3
            DateMode = dtmDateTime
          end
          object UniLabel1: TUniLabel
            Left = 25
            Top = 10
            Width = 89
            Height = 13
            Hint = ''
            Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088':'
            TabOrder = 4
          end
          object UniLabel2: TUniLabel
            Left = 25
            Top = 37
            Width = 80
            Height = 13
            Hint = ''
            Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103':'
            TabOrder = 5
          end
          object UniLabel3: TUniLabel
            Left = 302
            Top = 38
            Width = 90
            Height = 13
            Hint = ''
            Caption = #1044#1072#1090#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1103':'
            TabOrder = 6
          end
        end
      end
    end
    object tabSuppliers: TUniTabSheet
      Hint = ''
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      DesignSize = (
        1276
        383)
      object edtEmexUsername: TUniEdit
        Left = 238
        Top = 26
        Width = 506
        Hint = ''
        Text = ''
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        ClearButton = True
      end
      object UniLabel4: TUniLabel
        Left = 33
        Top = 29
        Width = 165
        Height = 13
        Hint = ''
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '#1076#1083#1103' '#1080#1085#1090#1077#1075#1088#1072#1094#1080#1080':'
        TabOrder = 1
      end
      object UniLabel5: TUniLabel
        Left = 33
        Top = 65
        Width = 131
        Height = 13
        Hint = ''
        Caption = #1055#1072#1088#1086#1083#1100' '#1076#1083#1103' '#1080#1085#1090#1077#1075#1088#1072#1094#1080#1080':'
        TabOrder = 2
      end
      object edtDiscount: TUniNumberEdit
        Left = 238
        Top = 118
        Width = 121
        Hint = ''
        TabOrder = 3
        MaxValue = 100.000000000000000000
        DecimalSeparator = ','
      end
      object UniLabel6: TUniLabel
        Left = 33
        Top = 120
        Width = 108
        Height = 13
        Hint = ''
        Caption = #1057#1082#1080#1076#1082#1072' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072':'
        TabOrder = 4
      end
      object edtCommission: TUniNumberEdit
        Left = 238
        Top = 148
        Width = 121
        Hint = ''
        TabOrder = 5
        MaxValue = 100.000000000000000000
        DecimalSeparator = ','
      end
      object edtExtraKurs: TUniNumberEdit
        Left = 238
        Top = 178
        Width = 121
        Hint = ''
        TabOrder = 6
        MaxValue = 100.000000000000000000
        DecimalSeparator = ','
      end
      object UniLabel7: TUniLabel
        Left = 33
        Top = 149
        Width = 106
        Height = 13
        Hint = ''
        Caption = #1050#1086#1084#1080#1089#1089#1080#1103' '#1101#1082#1074#1072#1081#1077#1088#1072':'
        TabOrder = 7
      end
      object UniLabel8: TUniLabel
        Left = 33
        Top = 177
        Width = 91
        Height = 13
        Hint = ''
        Caption = #1053#1072#1094#1077#1085#1082#1072' '#1085#1072' '#1082#1091#1088#1089':'
        TabOrder = 8
      end
      object edtEmexPassword: TUniEdit
        Left = 238
        Top = 57
        Width = 240
        Hint = ''
        Text = ''
        TabOrder = 9
      end
    end
    object tabDelivery: TUniTabSheet
      Hint = ''
      AlignmentControl = uniAlignmentClient
      ParentAlignmentControl = False
      Caption = #1055#1088#1086#1092#1080#1083#1080' '#1076#1086#1089#1090#1072#1074#1082#1080
      LayoutConfig.Width = '100'
      object ToolBar: TUniToolBar
        AlignWithMargins = True
        Left = 3
        Top = 0
        Width = 1270
        Height = 48
        Hint = ''
        Margins.Top = 0
        Margins.Bottom = 0
        ShowHint = True
        ParentShowHint = False
        ButtonHeight = 40
        ButtonWidth = 90
        Images = UniMainModule.BaseImage16
        ShowCaptions = True
        LayoutConfig.IgnorePosition = False
        LayoutConfig.DockWhenAligned = False
        TabOrder = 0
        ParentColor = False
        Color = clBtnFace
        OverflowHandler = ohMenu
        object UniToolButton1: TUniToolButton
          Left = 0
          Top = 0
          ShowHint = True
          Action = actAdd
          ImageIndex = 0
          IconAlign = iaLeft
          TabOrder = 1
        end
        object UniToolButton2: TUniToolButton
          Left = 90
          Top = 0
          ShowHint = True
          Action = actEdit
          ImageIndex = 1
          IconAlign = iaLeft
          TabOrder = 2
        end
        object UniToolButton4: TUniToolButton
          Left = 180
          Top = 0
          ShowHint = True
          Action = actDelete
          ImageIndex = 2
          IconAlign = iaLeft
          TabOrder = 3
        end
      end
      object UniPanel1: TUniPanel
        Left = 0
        Top = 48
        Width = 1276
        Height = 335
        Hint = ''
        Align = alClient
        TabOrder = 1
        BorderStyle = ubsNone
        Caption = 'UniPanel1'
        Color = clYellow
        Layout = 'fit'
        LayoutConfig.Width = '100'
        object Grid: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1276
          Height = 335
          Hint = ''
          ShowHint = True
          ParentShowHint = False
          BodyRTL = False
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    sender.co' +
              'pyToClipboard = str => {'#13#10'        const el = document.createElem' +
              'ent('#39'textarea'#39');'#13#10'        //el.value = sender.getSelection()[0].' +
              'data[sender.uniCol+1];'#13#10'        el.value = document.activeElemen' +
              't.innerText;'#13#10'        document.body.appendChild(el);'#13#10'        el' +
              '.select();'#13#10'        document.execCommand('#39'copy'#39');'#13#10'        docum' +
              'ent.body.removeChild(el);'#13#10'    };'#13#10'}')
          RowEditor = True
          DataSource = dsDelivery
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgFilterClearButton]
          WebOptions.PageSize = 50
          WebOptions.AppendPosition = tpCurrentRow
          WebOptions.FetchAll = True
          LoadMask.Message = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
          LoadMask.Color = clActiveCaption
          EmptyText = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093' ...'
          LayoutConfig.ComponentCls = 'grid-suppliers'
          LayoutConfig.IgnorePosition = False
          LayoutConfig.Height = '100'
          LayoutConfig.Width = '100'
          BorderStyle = ubsNone
          Align = alClient
          TabOrder = 1
          ParentColor = False
          Color = clBtnFace
          OnKeyDown = GridKeyDown
          OnCellContextClick = GridCellContextClick
          Columns = <
            item
              FieldName = 'IsActive'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1072#1090#1091#1089
              Width = 67
              Sortable = True
              CheckBoxField.AutoPost = True
            end
            item
              FieldName = 'Image'
              Title.Alignment = taCenter
              Title.Caption = #1050#1072#1088#1090#1080#1085#1082#1072
              Width = 82
              Alignment = taCenter
              Editor = cbImage
              Sortable = True
            end
            item
              FieldName = 'DestinationLogo'
              Title.Alignment = taCenter
              Title.Caption = #1057#1087#1086#1089#1086#1073' '#1086#1090#1075#1088#1091#1079#1082#1080
              Width = 136
              Hint = #1057#1087#1086#1089#1086#1073' '#1086#1090#1075#1088#1091#1079#1082#1080' (DestinationLogo)'
              Sortable = True
            end
            item
              FieldName = 'Name'
              Title.Alignment = taCenter
              Title.Caption = 'Name'
              Width = 157
              Sortable = True
            end
            item
              FieldName = 'Brief'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1088#1086#1090#1082#1086#1077' '#1086#1073#1086#1079#1085#1072#1095#1077#1085#1080#1077
              Width = 109
              Sortable = True
            end
            item
              FieldName = 'WeightKG'
              Title.Alignment = taCenter
              Title.Caption = 'WeightKG'
              Width = 101
              Hint = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1077#1088#1077#1074#1086#1079#1082#1080' '#1082#1075'. '#1092#1080#1079#1080#1095#1077#1089#1082#1086#1075#1086' '#1074#1077#1089#1072' '
              Sortable = True
            end
            item
              FieldName = 'VolumeKG'
              Title.Alignment = taCenter
              Title.Caption = 'VolumeKG'
              Width = 91
              Hint = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1077#1088#1077#1074#1086#1079#1082#1080' '#1082#1075'. '#1086#1073#1098#1077#1084#1085#1086#1075#1086' '#1074#1077#1089#1072' '
              Sortable = True
            end
            item
              FieldName = 'DenVyleta'
              Title.Alignment = taCenter
              Title.Caption = #1044#1077#1085#1100' '#1074#1099#1083#1077#1090#1072
              Width = 247
              Hint = #1044#1077#1085#1100' '#1074#1099#1083#1077#1090#1072' (DenVyleta)'
              Editor = cbDenVileta
              Sortable = True
            end
            item
              FieldName = 'Delivery'
              Title.Alignment = taCenter
              Title.Caption = #1057#1088#1086#1082' '#1076#1086#1089#1090#1072#1074#1082#1080
              Width = 124
              Hint = #1057#1088#1086#1082' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1086#1090' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072', '#1076#1086#1073#1072#1074#1083#1103#1077#1084' '#1082' '#1089#1088#1086#1082#1091' emex'
              Editor = edtDelivery
              Sortable = True
            end
            item
              FieldName = 'VolumeKG_Rate1'
              Title.Alignment = taCenter
              Title.Caption = 'VolumeKG_Rate1'
              Width = 149
              Sortable = True
            end
            item
              FieldName = 'VolumeKG_Rate2'
              Title.Alignment = taCenter
              Title.Caption = 'VolumeKG_Rate2'
              Width = 146
              Sortable = True
            end
            item
              FieldName = 'VolumeKG_Rate3'
              Title.Alignment = taCenter
              Title.Caption = 'VolumeKG_Rate3'
              Width = 148
              Sortable = True
            end
            item
              FieldName = 'VolumeKG_Rate4'
              Title.Alignment = taCenter
              Title.Caption = 'VolumeKG_Rate4'
              Width = 153
              Sortable = True
            end
            item
              FieldName = 'Restrictions'
              Title.Alignment = taCenter
              Title.Caption = 'Restrictions'
              Width = 157
              Sortable = True
              CheckBoxField.AutoPost = True
            end
            item
              FieldName = 'ImageHelp'
              Title.Alignment = taCenter
              Title.Caption = #1058#1077#1082#1089#1090' '#1087#1086#1076#1089#1082#1072#1079#1082#1080' '#1082' '#1089#1087#1086#1089#1086#1073#1091' '#1076#1086#1089#1090#1072#1074#1082#1080
              Width = 300
              Sortable = True
            end
            item
              FieldName = 'isMyDelivery'
              Title.Alignment = taCenter
              Title.Caption = 'isMyDelivery'
              Width = 107
              Hint = #1057#1095#1080#1090#1072#1090#1100' '#1089' '#1091#1095#1077#1090#1086#1084' '#1076#1086#1089#1090#1072#1074#1082#1080
              Sortable = True
              CheckBoxField.AutoPost = True
            end
            item
              FieldName = 'isIgnore'
              Title.Alignment = taCenter
              Title.Caption = 'isIgnore'
              Width = 91
              Hint = #1048#1075#1085#1086#1088#1080#1088#1086#1074#1072#1090#1100' '#1076#1077#1090#1072#1083#1080' '#1073#1077#1079' '#1074#1077#1089#1072
              Sortable = True
              CheckBoxField.AutoPost = True
            end
            item
              FieldName = 'Fragile'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1094#1077#1085#1082#1072' '#1079#1072' '#1089#1090#1088#1072#1093#1086#1074#1082#1091' (Fragile)'
              Width = 168
              Sortable = True
            end>
        end
        object UniHiddenPanel3: TUniHiddenPanel
          Left = 117
          Top = 72
          Width = 167
          Height = 155
          Hint = ''
          Visible = True
          object cbDenVileta: TUniCheckComboBox
            Left = 19
            Top = 117
            Width = 137
            Height = 23
            Hint = ''
            Text = ''
            Items.Strings = (
              #1055#1086#1085#1077#1076#1077#1083#1100#1085#1080#1082
              #1042#1090#1086#1088#1085#1080#1082
              #1057#1088#1077#1076#1072
              #1063#1077#1090#1074#1077#1088#1075
              #1055#1103#1090#1085#1080#1094#1072
              #1057#1091#1073#1073#1086#1090#1072
              #1042#1086#1089#1082#1088#1077#1089#1077#1085#1100#1077)
            TabOrder = 1
            IconItems = <>
          end
          object cbImage: TUniComboBox
            Left = 19
            Top = 88
            Width = 118
            Height = 23
            Hint = ''
            Style = csDropDownList
            Text = ''
            Items.Strings = (
              '<i class="fa fa-plane"></i>'
              '<i class="fa fa-car"></i>'
              '<i class="fa fa-ship"></i>')
            TabOrder = 2
            IconItems = <>
          end
          object edtDelivery: TUniSpinEdit
            Left = 24
            Top = 56
            Width = 121
            Hint = ''
            TabOrder = 3
          end
        end
      end
    end
  end
  object DataSource: TDataSource
    Left = 683
    Top = 181
  end
  object UpdateSQL: TFDUpdateSQL
    Connection = UniMainModule.FDConnection
    ConnectionName = 'Connection'
    InsertSQL.Strings = (
      'declare @R                 numeric(18, 0)'
      '       ,@DestinationLogo   nvarchar(10)'
      ''
      'select @DestinationLogo = :NEW_DestinationLogo'
      ''
      'if isnull(@DestinationLogo, '#39#39') = '#39#39
      'begin'
      
        ' RAISERROR ('#39#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1087#1086#1083#1077' '#1089#1087#1086#1089#1086#1073' '#1086#1090#1075#1088#1091#1079#1082#1080#39', 16, 1);' +
        ' '
      'end'
      ''
      'INSERT INTO pSupplierDeliveryProfiles'
      '        (SuppliersID, '
      '         Name, '
      '         Brief,'
      '         WeightKG, '
      '         VolumeKG, '
      '         DenVyleta, '
      '         VolumeKG_Rate1, '
      '         VolumeKG_Rate2, '
      '         VolumeKG_Rate3, '
      '         VolumeKG_Rate4, '
      '         DestinationLogo, '
      '         Restrictions, '
      '         IsActive,'
      '         Delivery,'
      '        [Image],'
      '        ImageHelp,'
      '        isMyDelivery,'
      '        isIgnore,'
      '        Fragile,'
      '         Spid)'
      'VALUES (:NEW_SuppliersID, '
      '        :NEW_Name, '
      '        :NEW_Brief,'
      '        :NEW_WeightKG, '
      '        :NEW_VolumeKG, '
      '        :NEW_DenVyleta, '
      '        :NEW_VolumeKG_Rate1, '
      '        :NEW_VolumeKG_Rate2, '
      '        :NEW_VolumeKG_Rate3, '
      '        :NEW_VolumeKG_Rate4, '
      '        :NEW_DestinationLogo, '
      '        :NEW_Restrictions, '
      '        :NEW_IsActive,'
      '        :NEW_Delivery,'
      '        :NEW_Image,'
      '        :NEW_ImageHelp,'
      '        :NEW_isMyDelivery,'
      '        :NEW_isIgnore,'
      '        :NEW_Fragile,'
      '        @@Spid);'
      ''
      'SELECT SCOPE_IDENTITY() AS ID')
    ModifySQL.Strings = (
      'declare @R                 numeric(18, 0)'
      '       ,@DestinationLogo   nvarchar(10)'
      ''
      'select @DestinationLogo = :NEW_DestinationLogo'
      ''
      'if isnull(@DestinationLogo, '#39#39') = '#39#39
      'begin'
      
        ' RAISERROR ('#39#1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087#1086#1083#1085#1080#1090#1100' '#1087#1086#1083#1077' '#1089#1087#1086#1089#1086#1073' '#1086#1090#1075#1088#1091#1079#1082#1080#39', 16, 1);' +
        ' '
      'end'
      '/*'
      'if exists (select 1'
      '             from pSupplierDeliveryProfiles (nolock)'
      '            where Spid            = @@spid'
      '              and DestinationLogo = @DestinationLogo'
      '              and ID             <> :ID)'
      'begin'
      '   RAISERROR ('#39'C'#1087#1086#1089#1086#1073' '#1086#1090#1075#1088#1091#1079#1082#1080' '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090'!'#39', 16, 1); '
      'end'
      '*/'
      ''
      'UPDATE pSupplierDeliveryProfiles'
      '   SET '
      '      SuppliersID = :NEW_SuppliersID, '
      '      Brief       = :NEW_Brief,'
      '      Name        = :NEW_Name, '
      '      WeightKG    = :NEW_WeightKG, '
      '      VolumeKG    = :NEW_VolumeKG, '
      '      DenVyleta   = :NEW_DenVyleta, '
      '      VolumeKG_Rate1  = :NEW_VolumeKG_Rate1, '
      '      VolumeKG_Rate2  = :NEW_VolumeKG_Rate2, '
      '      VolumeKG_Rate3  = :NEW_VolumeKG_Rate3, '
      '      VolumeKG_Rate4  = :NEW_VolumeKG_Rate4, '
      '      DestinationLogo = :NEW_DestinationLogo, '
      '      Restrictions    = :NEW_Restrictions, '
      '      IsActive        = :NEW_IsActive,'
      '      Delivery        = :NEW_Delivery,'
      '      [Image]         = :NEW_Image,'
      '      [ImageHelp]     = :New_ImageHelp,'
      '      isMyDelivery    = :New_isMyDelivery,'
      '      isIgnore=:New_isIgnore,'
      '      Fragile =:NEW_Fragile'
      'WHERE ID= :ID;'
      '')
    DeleteSQL.Strings = (
      'declare @R      numeric(18, 0)'
      '       ,@RetMsg nvarchar(256)'
      ''
      'exec @R =SupplierDeliveryProfilesDetele'
      '              @ID  = :ID'
      ''
      'if isnull(@R, 0) > 0'
      'begin'
      '   select @RetMsg = dbo.GetRetMsg(@R)'
      ''
      '   RAISERROR (@RetMsg , 16, 1); '
      'end'
      ''
      'delete pSupplierDeliveryProfiles  '
      '  from pSupplierDeliveryProfiles (rowlock) '
      ' where ID = :ID')
    FetchRowSQL.Strings = (
      'select *'
      '  from pSupplierDeliveryProfiles (nolock)'
      ' where ID   = :ID   ')
    Left = 768
    Top = 254
  end
  object ActionList: TUniActionList
    Left = 414
    Top = 179
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
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      Hint = #1055#1086#1083#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 3
      OnExecute = actRefreshAllExecute
    end
  end
  object qDelivery: TFDQuery
    AutoCalcFields = False
    AfterInsert = qDeliveryAfterInsert
    AfterEdit = qDeliveryAfterEdit
    AfterPost = qDeliveryAfterPost
    AfterDelete = qDeliveryAfterDelete
    Connection = UniMainModule.FDConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'ID'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'select ID'
      '      ,ProfilesDeliveryID'
      '      ,SuppliersID'
      '      ,Brief'
      '      ,Name'
      '      ,Brief'
      '      ,WeightKG'
      '      ,VolumeKG'
      '      ,PDelivery1'
      '      ,PDelivery2'
      '      ,PDelivery3'
      '      ,DenVyleta'
      '      ,VolumeKG_Rate1'
      '      ,VolumeKG_Rate2'
      '      ,VolumeKG_Rate3'
      '      ,VolumeKG_Rate4'
      '      ,DestinationLogo'
      '      ,Restrictions'
      '      ,IsActive'
      '      ,Delivery'
      '      ,[Image]'
      '      ,ImageHelp'
      '      ,isMyDelivery-- '#1057#1095#1080#1090#1072#1090#1100' '#1089' '#1091#1095#1077#1090#1086#1084' '#1076#1086#1089#1090#1072#1074#1082#1080
      '      ,isIgnore    -- '#1048#1075#1085#1086#1088#1080#1088#1086#1074#1072#1090#1100' '#1076#1077#1090#1072#1083#1080' '#1073#1077#1079' '#1074#1077#1089#1072
      '      ,Fragile'
      '  from pSupplierDeliveryProfiles (nolock)'
      ' where Spid = @@Spid ')
    Left = 767
    Top = 182
    object qDeliveryProfilesDeliveryID: TFDAutoIncField
      AutoGenerateValue = arNone
      FieldName = 'ProfilesDeliveryID'
      Origin = 'ProfilesDeliveryID'
    end
    object qDeliverySuppliersID: TFMTBCDField
      FieldName = 'SuppliersID'
      Origin = 'SuppliersID'
      Required = True
      Precision = 18
      Size = 0
    end
    object qDeliveryName: TStringField
      FieldName = 'Name'
      Origin = 'Name'
      Size = 60
    end
    object qDeliveryWeightKG: TFloatField
      FieldName = 'WeightKG'
      Origin = 'WeightKG'
    end
    object qDeliveryVolumeKG: TFloatField
      FieldName = 'VolumeKG'
      Origin = 'VolumeKG'
    end
    object qDeliveryPDelivery1: TIntegerField
      FieldName = 'PDelivery1'
      Origin = 'PDelivery1'
    end
    object qDeliveryPDelivery2: TIntegerField
      FieldName = 'PDelivery2'
      Origin = 'PDelivery2'
    end
    object qDeliveryPDelivery3: TIntegerField
      FieldName = 'PDelivery3'
      Origin = 'PDelivery3'
    end
    object qDeliveryVolumeKG_Rate1: TBCDField
      FieldName = 'VolumeKG_Rate1'
      Origin = 'VolumeKG_Rate1'
      Precision = 10
      Size = 2
    end
    object qDeliveryVolumeKG_Rate2: TBCDField
      FieldName = 'VolumeKG_Rate2'
      Origin = 'VolumeKG_Rate2'
      Precision = 10
      Size = 2
    end
    object qDeliveryVolumeKG_Rate3: TBCDField
      FieldName = 'VolumeKG_Rate3'
      Origin = 'VolumeKG_Rate3'
      Precision = 10
      Size = 2
    end
    object qDeliveryVolumeKG_Rate4: TBCDField
      FieldName = 'VolumeKG_Rate4'
      Origin = 'VolumeKG_Rate4'
      Precision = 10
      Size = 2
    end
    object qDeliveryDestinationLogo: TWideStringField
      FieldName = 'DestinationLogo'
      Origin = 'DestinationLogo'
      Size = 10
    end
    object qDeliveryRestrictions: TBooleanField
      FieldName = 'Restrictions'
      Origin = 'Restrictions'
    end
    object qDeliveryIsActive: TBooleanField
      FieldName = 'IsActive'
      Origin = 'IsActive'
    end
    object qDeliveryID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qDeliveryDenVyleta: TWideStringField
      FieldName = 'DenVyleta'
      Size = 256
    end
    object qDeliveryDelivery: TIntegerField
      FieldName = 'Delivery'
    end
    object qDeliveryImage: TWideStringField
      FieldName = 'Image'
      Required = True
      Size = 256
    end
    object qDeliveryImageHelp: TWideStringField
      FieldName = 'ImageHelp'
      Size = 248
    end
    object qDeliveryisMyDelivery: TBooleanField
      FieldName = 'isMyDelivery'
    end
    object qDeliveryisIgnore: TBooleanField
      FieldName = 'isIgnore'
    end
    object qDeliveryFragile: TFloatField
      FieldName = 'Fragile'
    end
    object qDeliveryBrief: TWideStringField
      FieldName = 'Brief'
      Size = 10
    end
  end
  object dsDelivery: TDataSource
    DataSet = qDelivery
    Left = 836
    Top = 183
  end
  object PopupMenu: TUniPopupMenu
    Images = UniMainModule.BaseImage16
    Left = 586
    Top = 129
    object N1: TUniMenuItem
      Action = actAdd
    end
    object N3: TUniMenuItem
      Action = actEdit
    end
    object N2: TUniMenuItem
      Action = actDelete
    end
    object N5: TUniMenuItem
      Caption = '-'
    end
    object N4: TUniMenuItem
      Action = actRefreshAll
    end
  end
end
