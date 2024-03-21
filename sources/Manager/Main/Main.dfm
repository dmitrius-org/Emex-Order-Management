object MainForm: TMainForm
  Left = 0
  Top = 0
  Margins.Left = 0
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 0
  ClientHeight = 409
  ClientWidth = 826
  Caption = 'Emex Manager'
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  OnKeyDown = UniFormKeyDown
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  OnDestroy = UniFormDestroy
  TextHeight = 15
  object UniContainerPanel: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 826
    Height = 409
    Hint = ''
    ParentColor = False
    Align = alClient
    TabOrder = 0
    Layout = 'fit'
    LayoutAttribs.Align = 'stretch'
    LayoutConfig.IgnorePosition = False
    LayoutConfig.DockWhenAligned = False
    ExplicitWidth = 1040
    ExplicitHeight = 583
    object UniPanel: TUniPanel
      Left = 0
      Top = 0
      Width = 826
      Height = 409
      Hint = ''
      Align = alClient
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = 'UniPanel'
      Layout = 'border'
      LayoutConfig.DockWhenAligned = False
      ExplicitWidth = 1040
      ExplicitHeight = 583
      object MainMenuPanel: TUniPanel
        Left = 0
        Top = 0
        Width = 300
        Height = 409
        Hint = ''
        Align = alLeft
        TabOrder = 0
        Caption = 'MainMenuPanel'
        Layout = 'fit'
        LayoutAttribs.Pack = 'start'
        LayoutConfig.Region = 'west'
        ExplicitHeight = 583
        object LogoPanel: TUniSimplePanel
          Left = 1
          Top = 1
          Width = 298
          Height = 38
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          ParentColor = False
          Align = alTop
          TabOrder = 1
          LayoutConfig.Cls = 'logo-caption'
          LayoutConfig.BodyCls = 'logo-caption'
          object LogoImage: TUniImage
            Left = 0
            Top = 0
            Width = 50
            Height = 38
            Cursor = crHandPoint
            Hint = ''
            Align = alLeft
            Transparent = True
            LayoutConfig.Cls = 'logo-image '
            LayoutConfig.BodyCls = 'logo-image '
          end
          object LogoLabel: TUniLabel
            AlignWithMargins = True
            Left = 53
            Top = 9
            Width = 4
            Height = 17
            Hint = ''
            Margins.Top = 9
            Alignment = taCenter
            Caption = ''
            Align = alClient
            ParentFont = False
            Font.Height = -13
            Font.Style = [fsBold]
            ParentColor = False
            Color = clBtnFace
            TabOrder = 2
            LayoutConfig.ComponentCls = 'logo-caption'
          end
        end
        object MainMenu: TUniTreeMenu
          AlignWithMargins = True
          Left = 1
          Top = 39
          Width = 298
          Height = 369
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          ParentRTL = False
          ShowHint = True
          ParentShowHint = False
          BodyRTL = False
          Align = alClient
          Items.NodeData = {
            0301000000260000000F0000000F0000000F000000FFFFFFFF0F000000000000
            0000000000010420002E002E002E00}
          Items.FontData = {
            01010000001D000000000000000600000000080000FFF5FFFFFF000000000000
            53696D53756E}
          Images = MainMenuImage
          MicroWidth = 50
          OnClick = MainMenuClick
          ExplicitHeight = 543
        end
      end
      object MainMenuPanelDetail: TUniPanel
        Left = 300
        Top = 0
        Width = 526
        Height = 409
        Hint = ''
        Align = alClient
        TabOrder = 2
        BorderStyle = ubsNone
        TitlePosition = tpBottom
        Caption = 'MainMenuPanelDetail'
        Color = clMenuHighlight
        Layout = 'fit'
        LayoutConfig.Region = 'center'
        ExplicitWidth = 740
        ExplicitHeight = 583
        object pcMain: TUniPageControl
          Left = 0
          Top = 0
          Width = 526
          Height = 409
          Hint = ''
          Images = MainMenuImage
          Align = alClient
          LayoutConfig.Cls = 'main-menu-detail'
          LayoutConfig.IgnorePosition = False
          LayoutConfig.DockWhenAligned = False
          TabOrder = 1
        end
      end
    end
  end
  object pmProfile: TUniPopupMenu
    Left = 599
    Top = 93
    object N4: TUniMenuItem
      Action = actinfo
    end
    object N5: TUniMenuItem
      Caption = '-'
    end
    object N2: TUniMenuItem
      Action = actEditPas
    end
    object N3: TUniMenuItem
      Caption = '-'
    end
    object N1: TUniMenuItem
      Action = actExit
    end
  end
  object ActionList: TUniActionList
    Left = 673
    Top = 94
    object actExit: TAction
      Caption = #1042#1099#1081#1090#1080
      Hint = #1042#1099#1081#1090#1080
      OnExecute = actExitExecute
    end
    object actEditPas: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1074#1093#1086#1076#1072
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1074#1093#1086#1076#1072
      OnExecute = actEditPasExecute
    end
    object actinfo: TAction
      Caption = #1054' '#1089#1080#1089#1090#1077#1084#1077
      OnExecute = actinfoExecute
    end
  end
  object MainMenuImage: TUniNativeImageList
    Width = 24
    Height = 24
    Left = 512
    Top = 166
    Images = {
      14000000FFFFFF1F061300000073686F7070696E672D6261736B65743B66613B
      FFFFFF1F060900000075736572733B66613BFFFFFF1F0608000000757365723B
      66613BFFFFFF1F0612000000616464726573732D626F6F6B2D6F3B66613BFFFF
      FF1F06080000006C6F636B3B66613BFFFFFF1F0608000000626F6F6B3B66613B
      FFFFFF1F060E0000006C696E652D63686172743B66613BFFFFFF1F0609000000
      7461736B733B66613BFFFFFF1F060F00000068616E647368616B652D6F3B6661
      3BFFFFFF1F060D0000006D61702D7369676E733B66613BFFFFFF1F0609000000
      747275636B3B66613BFFFFFF1F060800000073657474696E6773FFFFFF1F0607
      0000006661783B66613BFFFFFF1F0610000000616464726573732D626F6F6B3B
      66613BFFFFFF1F0608000000686F6D653B66613BA6CAF0FF0608000000626172
      733B66613BFFFFFF1F060A000000756E6C6F636B3B66613BFFFFFF1F06120000
      0077696E646F772D636C6F73652D6F3B66613BFFFFFF1F0608000000696E666F
      3B66613BFFFFFF1F060D0000007265706C792D616C6C3B66613B}
  end
  object UniNativeImageList1: TUniNativeImageList
    Left = 704
    Top = 166
    Images = {
      0E000000FFFFFF1F061300000073686F7070696E672D6261736B65743B66613B
      FFFFFF1F060900000075736572733B66613BFFFFFF1F0608000000757365723B
      66613BFFFFFF1F0612000000616464726573732D626F6F6B2D6F3B66613BFFFF
      FF1F06080000006C6F636B3B66613BFFFFFF1F0608000000626F6F6B3B66613B
      FFFFFF1F060E0000006C696E652D63686172743B66613BFFFFFF1F0609000000
      7461736B733B66613BFFFFFF1F060F00000068616E647368616B652D6F3B6661
      3BFFFFFF1F060D0000006D61702D7369676E733B66613BFFFFFF1F0609000000
      747275636B3B66613BFFFFFF1F060800000073657474696E6773FFFFFF1F0607
      0000006661783B66613BFFFFFF1F0610000000616464726573732D626F6F6B3B
      66613B}
  end
end
