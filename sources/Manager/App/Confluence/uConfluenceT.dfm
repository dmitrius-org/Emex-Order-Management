object ConfluenceT: TConfluenceT
  Left = 0
  Top = 0
  Width = 894
  Height = 404
  OnReady = UniFrameReady
  Layout = 'fit'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  TabOrder = 0
  object UniPanel1: TUniPanel
    Left = 0
    Top = 0
    Width = 894
    Height = 404
    Hint = ''
    Align = alClient
    TabOrder = 0
    ShowCaption = False
    Caption = 'UniPanel1'
    Layout = 'border'
    ExplicitWidth = 992
    ExplicitHeight = 525
    object MenuPanel: TUniContainerPanel
      Left = 1
      Top = 1
      Width = 300
      Height = 402
      Hint = ''
      ParentColor = False
      Align = alLeft
      AlignmentControl = uniAlignmentClient
      ParentAlignmentControl = False
      TabOrder = 1
      Layout = 'fit'
      LayoutConfig.Split = True
      LayoutConfig.Region = 'west'
      ExplicitHeight = 523
      object TreeMenu: TUniTreeView
        Left = 0
        Top = 0
        Width = 300
        Height = 402
        Hint = ''
        ShowHint = True
        ParentShowHint = False
        Items.NodeData = {
          03020000002A0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
          00000000000106770065007200650077007200240000000000000000000000FF
          FFFFFFFFFFFFFF0000000000000000000000000103770065007200}
        Items.FontData = {0102000000FFFFFFFF00000000FFFFFFFF00000000}
        Align = alClient
        TabOrder = 1
        Color = clWindow
        BorderStyle = ubsNone
        Title = #1044#1077#1088#1077#1074#1086' '#1089#1090#1088#1072#1085#1080#1094
        ShowIcons = False
        ToolButtons = <
          item
            Action = actAdd
            ButtonId = 0
            IconCls = 'add'
            ImageIndex = 3
            Hint = #1044#1086#1073#1072#1074#1080#1090#1100
          end
          item
            Action = actRefreshAll
            ButtonId = 3
            IconCls = 'refresh'
            ImageIndex = 0
            Hint = #1054#1073#1085#1086#1074#1080#1090#1100
          end>
        OnClick = TreeMenuClick
        OnCellContextClick = TreeMenuCellContextClick
        ExplicitHeight = 523
      end
    end
    object ContentPanel: TUniContainerPanel
      Left = 301
      Top = 1
      Width = 592
      Height = 402
      Hint = ''
      ParentColor = False
      Align = alClient
      AlignmentControl = uniAlignmentClient
      ParentAlignmentControl = False
      TabOrder = 2
      Layout = 'fit'
      LayoutConfig.Region = 'center'
      ExplicitWidth = 690
      ExplicitHeight = 523
      object UniPanel2: TUniPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 586
        Height = 399
        Hint = ''
        Margins.Bottom = 0
        ShowHint = True
        ParentShowHint = False
        Align = alClient
        TabOrder = 1
        BorderStyle = ubsNone
        Caption = 'UniPanel2'
        AlignmentControl = uniAlignmentClient
        ParentAlignmentControl = False
        Layout = 'fit'
        LayoutAttribs.Align = 'stretch'
        LayoutAttribs.Pack = 'start'
        LayoutConfig.Flex = 1
        LayoutConfig.Width = '100'
        ExplicitWidth = 684
        ExplicitHeight = 520
        object ArticleToolBar: TUniPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 580
          Height = 49
          Hint = ''
          ShowHint = True
          Align = alTop
          TabOrder = 1
          BorderStyle = ubsNone
          ShowCaption = False
          Caption = ''
          AlignmentControl = uniAlignmentClient
          ParentAlignmentControl = False
          LayoutConfig.Region = 'north'
          ExplicitWidth = 678
          object lblArticle: TUniLabel
            Left = 16
            Top = 8
            Width = 66
            Height = 23
            Hint = ''
            ShowHint = True
            Caption = 'lblArticle'
            ParentFont = False
            Font.Color = clHighlight
            Font.Height = -17
            TabOrder = 1
            LayoutConfig.ComponentCls = 'lblArticle'
          end
          object UniPanel: TUniPanel
            AlignWithMargins = True
            Left = 184
            Top = 3
            Width = 393
            Height = 43
            Hint = ''
            ShowHint = True
            Align = alRight
            TabOrder = 2
            BorderStyle = ubsNone
            Caption = ''
            AlignmentControl = uniAlignmentClient
            ParentAlignmentControl = False
            ExplicitLeft = 282
            DesignSize = (
              393
              43)
            object btnArticleEdit: TUniButton
              AlignWithMargins = True
              Left = 112
              Top = 4
              Width = 108
              Height = 42
              Margins.Top = 5
              Margins.Bottom = 5
              ShowHint = True
              Action = actSave
              Anchors = [akTop, akRight]
              TabOrder = 1
              Images = UniNativeImageList1
              ImageIndex = 1
              LayoutConfig.IgnorePosition = False
            end
            object UniButton1: TUniButton
              AlignWithMargins = True
              Left = 226
              Top = 4
              Width = 164
              Height = 42
              Margins.Top = 5
              Margins.Bottom = 5
              ShowHint = True
              Action = actArticleEdit
              Anchors = [akTop, akRight]
              TabOrder = 2
              Images = UniNativeImageList1
              ImageIndex = 0
              LayoutConfig.IgnorePosition = False
            end
          end
        end
        object ArticleContent: TUniContainerPanel
          Left = 0
          Top = 55
          Width = 586
          Height = 344
          Hint = ''
          Margins.Left = 5
          ShowHint = True
          ParentColor = False
          Align = alClient
          TabOrder = 2
          Layout = 'fit'
          LayoutConfig.Region = 'center'
          ExplicitWidth = 684
          ExplicitHeight = 465
          object edt1: TUniHTMLFrame
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 580
            Height = 338
            Hint = ''
            ShowHint = True
            Align = alClient
            OnAjaxEvent = edt1AjaxEvent
            ExplicitWidth = 678
            ExplicitHeight = 459
          end
        end
      end
    end
  end
  object ActionList: TUniActionList
    Left = 365
    Top = 100
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 3
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 0
      OnExecute = actEditExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 4
      OnExecute = actDeleteExecute
    end
    object actRefreshAll: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 2
      OnExecute = actRefreshAllExecute
    end
    object actAddChild: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1072' '#1087#1086#1076#1091#1088#1086#1074#1077#1085#1100
      ImageIndex = 5
      OnExecute = actAddChildExecute
    end
    object actArticleEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1090#1072#1090#1100#1102
      ImageIndex = 0
      OnExecute = actArticleEditExecute
    end
    object actSave: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 1
      OnExecute = actSaveExecute
    end
  end
  object PopupMenu: TUniPopupMenu
    Images = UniNativeImageList1
    OnPopup = PopupMenuPopup
    Left = 362
    Top = 174
    object N1: TUniMenuItem
      Action = actAdd
    end
    object N3: TUniMenuItem
      Action = actAddChild
    end
    object N2: TUniMenuItem
      Action = actEdit
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
  object UniNativeImageList1: TUniNativeImageList
    Left = 658
    Top = 114
    Images = {
      06000000FFFFFF1F061300000070656E63696C2D7371756172652D6F3B66613B
      FFFFFF1F060C000000666C6F7070792D6F3B66613BFFFFFF1F060B0000007265
      66726573683B66613BFFFFFF1F0608000000706C75733B66613BFFFFFF1F0609
      00000074696D65733B66613BFFFFFF1F060F000000706C75732D737175617265
      3B66613B}
  end
end
