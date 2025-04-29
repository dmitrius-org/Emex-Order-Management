object Message: TMessage
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 778
  Height = 652
  Margins.Left = 0
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 0
  OnCreate = UniFrameCreate
  OnDestroy = UniFrameDestroy
  OnReady = UniFrameReady
  Layout = 'fit'
  LayoutConfig.ComponentCls = 'content-default-chat-container '
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  TabOrder = 0
  object ContentChatContainer: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 778
    Height = 652
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    ParentColor = False
    Align = alClient
    TabOrder = 0
    ScrollDirection = sdNone
    Layout = 'fit'
    LayoutConfig.ComponentCls = 
      'content-chat-background-container content-chat-container messeng' +
      'er-scope'
    OnAjaxEvent = ContentChatContainerAjaxEvent
    object ChatContent: TUniContainerPanel
      Left = 0
      Top = 0
      Width = 778
      Height = 652
      Hint = ''
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ParentColor = False
      Align = alClient
      TabOrder = 0
      ScrollDirection = sdNone
      LayoutConfig.Cls = 'content-chat-content'
      object ChatMessages: TUniContainerPanel
        AlignWithMargins = True
        Left = 3
        Top = 63
        Width = 772
        Height = 536
        Hint = ''
        ParentColor = False
        Align = alClient
        TabOrder = 2
        ScrollDirection = sdNone
        Layout = 'fit'
        LayoutConfig.ComponentCls = 'content-chat-dialog-content'
        object MessageEditor: TUniListBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 766
          Height = 530
          Hint = ''
          Align = alClient
          TabOrder = 1
          MultiSelect = True
          LayoutConfig.ComponentCls = 'message-list-container'
          LayoutConfig.DockWhenAligned = False
        end
      end
      object ChatMessagesSend: TUniContainerPanel
        AlignWithMargins = True
        Left = 0
        Top = 602
        Width = 778
        Height = 50
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ParentColor = False
        Align = alBottom
        TabOrder = 3
        Layout = 'fit'
        LayoutConfig.ComponentCls = 'chat-textarea-container'
        object pnlSendPanelContainer: TUniContainerPanel
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 778
          Height = 50
          Hint = ''
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          ParentColor = False
          Align = alClient
          TabOrder = 1
          Layout = 'column'
          LayoutAttribs.Columns = 2
          LayoutConfig.ComponentCls = 'send-panel-scope send-panel-container'
          object pnlSendMessage: TUniContainerPanel
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 728
            Height = 50
            Hint = ''
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            ParentColor = False
            Align = alClient
            TabOrder = 1
            Layout = 'fit'
            LayoutConfig.ComponentCls = 'textarea-container'
            object pnlTextAreaContent: TUniContainerPanel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 722
              Height = 44
              Hint = ''
              ParentColor = False
              Align = alClient
              TabOrder = 1
              Layout = 'fit'
              LayoutConfig.ComponentCls = 'textarea-content'
              object pnlTextAreaLeft: TUniContainerPanel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 716
                Height = 38
                Hint = ''
                ParentColor = False
                Align = alClient
                TabOrder = 1
                Layout = 'column'
                LayoutAttribs.Columns = 2
                LayoutConfig.ComponentCls = 'textarea-left'
                object pnlUploadContainer: TUniContainerPanel
                  AlignWithMargins = True
                  Left = 3
                  Top = 3
                  Width = 32
                  Height = 32
                  Hint = ''
                  Visible = False
                  ShowHint = True
                  ParentShowHint = False
                  ParentColor = False
                  Align = alLeft
                  TabOrder = 1
                  ScrollDirection = sdNone
                  LayoutConfig.ComponentCls = 'textarea-upload-container'
                  object btnFileUpload: TUniSpeedButton
                    AlignWithMargins = True
                    Left = 3
                    Top = 3
                    Width = 26
                    Height = 26
                    Hint = ''
                    ShowHint = True
                    Caption = ''
                    Align = alClient
                    ParentColor = False
                    IconAlign = iaCenter
                    LayoutConfig.ComponentCls = 'textarea-icon'
                    TabOrder = 1
                  end
                end
                object MessageText: TUniMemo
                  AlignWithMargins = True
                  Left = 41
                  Top = 3
                  Width = 672
                  Height = 32
                  Hint = ''
                  BorderStyle = ubsNone
                  Lines.Strings = (
                    'MessageText')
                  Align = alClient
                  TabOrder = 2
                  ClearButton = True
                  EmptyText = #1042#1077#1076#1080#1090#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
                  LayoutConfig.ComponentCls = 'textarea-element'
                  OnChange = MessageTextChange
                end
              end
            end
          end
          object pnlSendButton: TUniContainerPanel
            AlignWithMargins = True
            Left = 734
            Top = 6
            Width = 38
            Height = 38
            Hint = ''
            Margins.Left = 6
            Margins.Top = 6
            Margins.Right = 6
            Margins.Bottom = 6
            ParentColor = False
            Align = alRight
            TabOrder = 2
            Layout = 'fit'
            LayoutConfig.ComponentCls = 'send-panel-container-right'
            object btnSend: TUniSpeedButton
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 32
              Height = 32
              Hint = ''
              ShowHint = True
              ParentShowHint = False
              Caption = ''
              Align = alClient
              ParentColor = False
              IconAlign = iaCenter
              LayoutConfig.ComponentCls = 'send-panel-button-container'
              TabOrder = 1
              OnClick = btnSendClick
            end
          end
        end
      end
      object ChatHeader: TUniContainerPanel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 778
        Height = 60
        Hint = ''
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ParentColor = False
        Align = alTop
        TabOrder = 1
        LayoutConfig.ComponentCls = 'chat-header-container chat-header-scope '
        object pnlChatHeaderLeft: TUniPanel
          Left = 0
          Top = 0
          Width = 609
          Height = 60
          Hint = ''
          Align = alLeft
          TabOrder = 1
          BorderStyle = ubsNone
          ShowCaption = False
          Caption = 'pnlChatHeader'
          LayoutConfig.ComponentCls = 'chat-header-left'
          object pnlChatHheaderInfo: TUniContainerPanel
            Left = 0
            Top = 0
            Width = 609
            Height = 60
            Hint = ''
            ParentColor = False
            Align = alClient
            TabOrder = 1
            LayoutConfig.ComponentCls = 'chat-header-info'
            object pnlChatHeaderTitle: TUniContainerPanel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 603
              Height = 54
              Hint = ''
              ParentColor = False
              Align = alClient
              TabOrder = 1
              LayoutConfig.ComponentCls = 'chat-header-title'
              object pnlChatHeaderTitleContainer: TUniContainerPanel
                Left = 0
                Top = 0
                Width = 603
                Height = 51
                Hint = ''
                ParentColor = False
                Align = alTop
                TabOrder = 1
                Layout = 'hbox'
                LayoutConfig.ComponentCls = 'chat-header-info chat-title-scope '
                object lblChatTitleText: TUniLabel
                  Left = 27
                  Top = 6
                  Width = 77
                  Height = 13
                  Hint = ''
                  Caption = 'lblChatTitleText'
                  TabOrder = 1
                  LayoutConfig.ComponentCls = 'chat-title-text'
                end
                object lblChatHeaderUserStatus: TUniLabel
                  Left = 172
                  Top = 6
                  Width = 76
                  Height = 13
                  Hint = ''
                  Caption = #1057#1090#1072#1090#1091#1089' '#1086#1085#1083#1072#1081#1085
                  TabOrder = 2
                  LayoutConfig.ComponentCls = 'chat-header-user-status'
                end
              end
            end
          end
        end
        object pnlChatHeaderRight: TUniContainerPanel
          AlignWithMargins = True
          Left = 636
          Top = 3
          Width = 136
          Height = 54
          Hint = ''
          Margins.Left = 6
          Margins.Right = 6
          ParentColor = False
          Align = alRight
          TabOrder = 2
          object btnRefresch: TUniSpeedButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 35
            Height = 48
            Hint = ''
            Visible = False
            ShowHint = True
            ParentShowHint = False
            Caption = ''
            Align = alLeft
            ParentColor = False
            IconAlign = iaCenter
            TabOrder = 1
          end
          object UniSpeedButton1: TUniSpeedButton
            AlignWithMargins = True
            Left = 98
            Top = 3
            Width = 35
            Height = 48
            Hint = ''
            Visible = False
            ShowHint = True
            ParentShowHint = False
            Caption = ''
            Align = alRight
            ParentColor = False
            IconAlign = iaCenter
            TabOrder = 2
          end
        end
      end
    end
  end
  object UserStatusTimer: TUniTimer
    Interval = 2000
    RunOnce = True
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UserStatusTimerTimer
    Left = 659
    Top = 181
  end
end
