object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 534
  ClientWidth = 910
  Caption = 'MainForm'
  OnShow = UniFormShow
  OldCreateOrder = False
  OnKeyDown = UniFormKeyDown
  MonitoredKeys.Keys = <>
  Font.Color = clSilver
  Layout = 'fit'
  OnCreate = UniFormCreate
  OnDestroy = UniFormDestroy
  DesignSize = (
    910
    534)
  TextHeight = 15
  object UniContainerPanel: TUniContainerPanel
    AlignWithMargins = True
    Left = 100
    Top = 3
    Width = 710
    Height = 528
    Hint = ''
    Margins.Left = 100
    Margins.Right = 100
    ParentColor = False
    Align = alClient
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 0
    Layout = 'fit'
    LayoutAttribs.Padding = '25'
    LayoutConfig.BodyPadding = '25'
    ExplicitWidth = 706
    ExplicitHeight = 527
    object UniPanelParent: TUniPanel
      Left = 0
      Top = 0
      Width = 710
      Height = 528
      Hint = ''
      Align = alClient
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      AlignmentControl = uniAlignmentClient
      ParentAlignmentControl = False
      Layout = 'border'
      LayoutConfig.Region = 'center'
      ExplicitWidth = 706
      ExplicitHeight = 527
      object UniPanelCentral: TUniPanel
        Left = 0
        Top = 55
        Width = 710
        Height = 473
        Hint = ''
        Align = alClient
        TabOrder = 1
        BorderStyle = ubsNone
        TitleAlign = taCenter
        Caption = 'UniPanelCentral'
        AlignmentControl = uniAlignmentClient
        ParentAlignmentControl = False
        Layout = 'fit'
        LayoutConfig.IgnorePosition = False
        LayoutConfig.Region = 'center'
        ExplicitWidth = 706
        ExplicitHeight = 472
        object pcMain: TUniPageControl
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 704
          Height = 467
          Hint = ''
          ActivePage = tbS
          Align = alClient
          LayoutConfig.IgnorePosition = False
          LayoutConfig.DockWhenAligned = False
          TabOrder = 1
          ExplicitWidth = 700
          ExplicitHeight = 466
          object tbS: TUniTabSheet
            Hint = ''
            Caption = #1055#1086#1080#1089#1082
            ExplicitWidth = 692
            ExplicitHeight = 438
          end
          object tsB: TUniTabSheet
            Hint = ''
            Caption = #1050#1086#1088#1079#1080#1085#1072
            OnBeforeActivate = tsBBeforeActivate
            ExplicitWidth = 692
            ExplicitHeight = 438
          end
          object tsO: TUniTabSheet
            Hint = ''
            Caption = #1047#1072#1082#1072#1079#1099
            ExplicitWidth = 692
            ExplicitHeight = 438
          end
        end
      end
      object UniPanelTop: TUniPanel
        Left = 0
        Top = 0
        Width = 710
        Height = 55
        Hint = ''
        Align = alTop
        TabOrder = 2
        BorderStyle = ubsNone
        Caption = ''
        LayoutConfig.Region = 'north'
        ExplicitWidth = 706
        object UniPanel: TUniPanel
          Left = 395
          Top = 0
          Width = 315
          Height = 55
          Hint = ''
          Align = alRight
          TabOrder = 1
          BorderStyle = ubsNone
          Caption = ''
          ExplicitLeft = 391
          object btnProfile: TUniMenuButton
            AlignWithMargins = True
            Left = 114
            Top = 5
            Width = 201
            Height = 45
            Hint = ''
            Margins.Top = 5
            Margins.Right = 0
            Margins.Bottom = 5
            DropdownMenu = pmProfile
            Caption = 'btnProfile'
            Align = alRight
            TabOrder = 1
            ScreenMask.Color = clNone
            LayoutConfig.Cls = 'btn-profile'
            LayoutConfig.DockWhenAligned = False
            Images = ImageList
          end
        end
      end
    end
  end
  object lblVersion: TUniLabel
    AlignWithMargins = True
    Left = 24
    Top = 513
    Width = 38
    Height = 13
    Hint = ''
    Alignment = taCenter
    Caption = 'Version'
    Anchors = [akLeft, akBottom]
    ParentFont = False
    Font.Color = clSilver
    TabOrder = 1
    ExplicitTop = 512
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
    Images = {
      05000000FFFFFF1F060400000075736572FFFFFF1F0604000000696E666FFFFF
      FF1F0606000000736561726368FFFFFF1F060400000063617274FFFFFF1F0604
      00000063617365}
  end
  object pmProfile: TUniPopupMenu
    Left = 599
    Top = 93
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
