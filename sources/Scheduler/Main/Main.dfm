object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 533
  ClientWidth = 1028
  Caption = 'Task Manager'
  OnShow = UniFormShow
  OldCreateOrder = False
  OnKeyDown = UniFormKeyDown
  MonitoredKeys.Keys = <>
  Layout = 'fit'
  OnDestroy = UniFormDestroy
  TextHeight = 15
  object UniContainerPanel: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 1028
    Height = 533
    Hint = ''
    ParentColor = False
    Align = alClient
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 0
    Layout = 'fit'
    LayoutAttribs.Padding = '25'
    LayoutConfig.BodyPadding = '25'
    ExplicitWidth = 1024
    ExplicitHeight = 532
    object UniPanelParent: TUniPanel
      Left = 0
      Top = 0
      Width = 1028
      Height = 533
      Hint = ''
      Align = alClient
      TabOrder = 1
      Caption = ''
      AlignmentControl = uniAlignmentClient
      ParentAlignmentControl = False
      Layout = 'border'
      ExplicitWidth = 1024
      ExplicitHeight = 532
      object UniPanelLeft: TUniPanel
        Left = 1
        Top = 56
        Width = 304
        Height = 476
        Hint = ''
        Align = alLeft
        TabOrder = 1
        BorderStyle = ubsNone
        TitleVisible = True
        TitleAlign = taCenter
        Title = #1052#1077#1085#1102
        Caption = ''
        Collapsible = True
        CollapseDirection = cdLeft
        LayoutAttribs.Pack = 'center'
        LayoutAttribs.Columns = 1
        LayoutConfig.Split = True
        LayoutConfig.Region = 'west'
        ExplicitHeight = 475
        object MainMenu: TUnimTreeMenu
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 298
          Height = 470
          Hint = ''
          Align = alClient
          Items.FontData = {0100000000}
          LayoutConfig.Width = '0'
          SelectOnExpander = True
          OnClick = MainMenuClick
          ExplicitHeight = 469
        end
      end
      object UniPanelCentral: TUniPanel
        Left = 305
        Top = 56
        Width = 722
        Height = 476
        Hint = ''
        Margins.Bottom = 0
        Align = alClient
        TabOrder = 2
        BorderStyle = ubsNone
        TitleAlign = taCenter
        Caption = 'UniPanelCentral'
        AlignmentControl = uniAlignmentClient
        ParentAlignmentControl = False
        Layout = 'fit'
        LayoutConfig.IgnorePosition = False
        LayoutConfig.Region = 'center'
        ExplicitWidth = 718
        ExplicitHeight = 475
        object pcMain: TUniPageControl
          AlignWithMargins = True
          Left = 0
          Top = 2
          Width = 722
          Height = 471
          Hint = ''
          Margins.Left = 0
          Margins.Top = 2
          Margins.Right = 0
          Align = alClient
          LayoutConfig.IgnorePosition = False
          LayoutConfig.DockWhenAligned = False
          TabOrder = 1
          ScreenMask.Enabled = True
          ScreenMask.Target = Owner
          ExplicitWidth = 718
          ExplicitHeight = 470
        end
      end
      object UniPanelTop: TUniPanel
        Left = 1
        Top = 1
        Width = 1026
        Height = 55
        Hint = ''
        Align = alTop
        TabOrder = 3
        BorderStyle = ubsNone
        Caption = ''
        LayoutConfig.Region = 'north'
        ExplicitWidth = 1022
        object UniPanel: TUniPanel
          Left = 711
          Top = 0
          Width = 315
          Height = 55
          Hint = ''
          Align = alRight
          TabOrder = 1
          BorderStyle = ubsNone
          Caption = ''
          ExplicitLeft = 707
          object btnProfile: TUniMenuButton
            AlignWithMargins = True
            Left = 153
            Top = 5
            Width = 157
            Height = 45
            Hint = ''
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            DropdownMenu = pmProfile
            Caption = 'btnProfile'
            Align = alRight
            TabOrder = 1
            IconPosition = ipButtonEdge
            ScreenMask.Color = clNone
            LayoutConfig.Cls = 'btn-profile'
            LayoutConfig.DockWhenAligned = False
            Images = ImageList
            ImageIndex = 0
          end
        end
      end
    end
  end
  object Menu: TUniMenuItems
    Left = 409
    Top = 92
    object mnHome: TUniMenuItem
      Caption = #1043#1083#1072#1074#1085#1072#1103
      ImageIndex = 0
    end
    object mnUser: TUniMenuItem
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      ImageIndex = 2
    end
    object mnTasks: TUniMenuItem
      Caption = #1047#1072#1076#1072#1095#1080
      ImageIndex = 3
    end
    object mnSettings: TUniMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      ImageIndex = 1
    end
  end
  object ImageList: TUniNativeImageList
    Width = 48
    Height = 48
    Left = 512
    Top = 94
    Images = {02000000FFFFFF1F060400000075736572FFFFFF1F0604000000696E666F}
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
end
