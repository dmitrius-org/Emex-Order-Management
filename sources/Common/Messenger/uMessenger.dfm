object Messenger: TMessenger
  Left = 0
  Top = 0
  Width = 1166
  Height = 696
  OnCreate = UniFrameCreate
  Layout = 'fit'
  LayoutConfig.ComponentCls = 'messenger-layout-content'
  TabOrder = 0
  object MessengerContainer: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 1166
    Height = 696
    Hint = ''
    ParentColor = False
    Align = alClient
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    TabOrder = 0
    Layout = 'border'
    LayoutConfig.ComponentCls = 'messenger-scope messenger-container'
    object pnlContentDefaultChatContainer: TUniPanel
      Left = 300
      Top = 0
      Width = 866
      Height = 696
      Hint = ''
      Align = alClient
      TabOrder = 1
      BorderStyle = ubsNone
      ShowCaption = False
      Caption = 'UniPanel1'
      AlignmentControl = uniAlignmentClient
      ParentAlignmentControl = False
      Layout = 'fit'
      LayoutConfig.ComponentCls = 'content-default-chat-container'
      LayoutConfig.Region = 'center'
    end
    object leftPanel: TUniPanel
      Left = 0
      Top = 0
      Width = 300
      Height = 696
      Hint = ''
      Align = alLeft
      TabOrder = 2
      BorderStyle = ubsNone
      ShowCaption = False
      Caption = 'leftPanel'
      AlignmentControl = uniAlignmentClient
      ParentAlignmentControl = False
      Layout = 'fit'
      LayoutAttribs.Pack = 'start'
      LayoutConfig.ComponentCls = 'messenger-list-container'
      LayoutConfig.Region = 'west'
      object ItemsPanel: TUniPanel
        Left = 0
        Top = 0
        Width = 300
        Height = 696
        Hint = ''
        Align = alClient
        TabOrder = 1
        Caption = 'ItemsPanel'
        ScrollDirection = sdVertical
        AlignmentControl = uniAlignmentClient
        ParentAlignmentControl = False
        Layout = 'fit'
        LayoutAttribs.Pack = 'start'
        LayoutAttribs.Columns = 1
        LayoutConfig.ComponentCls = 'messenger-elements-container'
        object ChatsEditor: TUniListBox
          Left = 1
          Top = 1
          Width = 298
          Height = 694
          Hint = ''
          Align = alClient
          TabOrder = 1
          LayoutConfig.ComponentCls = 'chats'
          OnClick = ChatsEditorClick
        end
      end
    end
  end
  object qChats: TFDQuery
    Connection = UniMainModule.FDConnection
    SQL.Strings = (
      'exec ChatsLoad @ClientID=:ClientID '
      '    ')
    Left = 172
    Top = 526
    ParamData = <
      item
        Name = 'CLIENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qChatsChatID: TFMTBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'ChatID'
      Origin = 'ChatID'
      ProviderFlags = [pfInWhere]
      ReadOnly = True
      OnGetText = qChatsChatIDGetText
      Precision = 18
      Size = 0
    end
    object qChatsClientID: TFMTBCDField
      FieldName = 'ClientID'
      Origin = 'ClientID'
      Precision = 18
      Size = 0
    end
    object qChatsOrderID: TFMTBCDField
      FieldName = 'OrderID'
      Origin = 'OrderID'
      Precision = 18
      Size = 0
    end
    object qChatsFlag: TIntegerField
      FieldName = 'Flag'
      Origin = 'Flag'
    end
    object qChatsInDateTime: TSQLTimeStampField
      FieldName = 'InDateTime'
      Origin = 'InDateTime'
    end
    object qChatsClientBrief: TWideStringField
      FieldName = 'ClientBrief'
      Origin = 'ClientBrief'
      Required = True
      Size = 256
    end
  end
  object dsChats: TDataSource
    DataSet = qChats
    Left = 105
    Top = 525
  end
end
