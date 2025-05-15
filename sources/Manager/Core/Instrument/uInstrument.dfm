object InstrumentT: TInstrumentT
  Left = 0
  Top = 0
  Width = 862
  Height = 527
  OnCreate = UniFrameCreate
  Layout = 'fit'
  LayoutConfig.Width = '0'
  TabOrder = 0
  object UniPanelTop: TUniPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 40
    Hint = ''
    Align = alTop
    TabOrder = 0
    ShowCaption = False
    Caption = 'UniPanelTop'
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'fit'
    LayoutConfig.Height = '40'
    LayoutConfig.Width = '0'
    LayoutConfig.Region = 'north'
  end
  object UniPanel2: TUniPanel
    Left = 0
    Top = 40
    Width = 862
    Height = 487
    Hint = ''
    Align = alClient
    TabOrder = 1
    Caption = 'UniPanelCenter'
    AlignmentControl = uniAlignmentClient
    ParentAlignmentControl = False
    Layout = 'border'
    LayoutConfig.Width = '100'
    LayoutConfig.Region = 'center'
    object UniPanelleft: TUniPanel
      Left = 1
      Top = 1
      Width = 487
      Height = 485
      Hint = ''
      Align = alLeft
      TabOrder = 1
      ShowCaption = False
      Caption = 'UniPanel1'
      Layout = 'fit'
      LayoutConfig.Split = True
      LayoutConfig.Region = 'west'
      object twInstrument: TUniTreeView
        Left = 1
        Top = 1
        Width = 485
        Height = 483
        Hint = ''
        Items.FontData = {0100000000}
        Images = InstrumentImage
        Align = alClient
        TabOrder = 1
        ScreenMask.ShowMessage = False
        ScreenMask.Color = clNone
        Color = clWindow
        BorderStyle = ubsNone
        LayoutConfig.Cls = 'twInstrument'
        LayoutConfig.IgnorePosition = False
        OnClick = twInstrumentClick
        OnDblClick = twInstrumentDblClick
        OnCellContextClick = twInstrumentCellContextClick
      end
    end
    object UniPanelCenter: TUniPanel
      Left = 488
      Top = 1
      Width = 373
      Height = 485
      Hint = ''
      Align = alClient
      TabOrder = 2
      ScreenMask.Enabled = True
      ScreenMask.ShowMessage = False
      ScreenMask.Color = clNone
      ShowCaption = False
      Caption = 'UniPanel1'
      Layout = 'fit'
      LayoutConfig.Width = '100'
      LayoutConfig.Region = 'center'
    end
  end
  object UniActionList: TUniActionList
    Left = 606
    Top = 138
    object ActInstrumentAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1072' '#1087#1086#1076#1091#1088#1086#1074#1077#1085#1100
      ImageIndex = 0
      OnExecute = ActInstrumentAddExecute
    end
    object ActInstrumentEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      ImageIndex = 1
      OnExecute = ActInstrumentEditExecute
    end
    object ActInstrumentDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnExecute = ActInstrumentDeleteExecute
    end
    object ActInstrumentShow: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      OnExecute = ActInstrumentShowExecute
    end
  end
  object PMInstrument: TUniPopupMenu
    Images = UniMainModule.BaseImage
    OnPopup = PMInstrumentPopup
    Left = 609
    Top = 203
    object N1: TUniMenuItem
      Action = ActInstrumentAdd
    end
    object N2: TUniMenuItem
      Action = ActInstrumentEdit
    end
    object N3: TUniMenuItem
      Action = ActInstrumentDelete
    end
  end
  object InstrumentImage: TUniNativeImageList
    Width = 32
    Height = 32
    Left = 257
    Top = 169
    Images = {
      07000000000000FF060A000000666F6C6465723B66613B000000FF0608000000
      636F67733B66613B000000FF0607000000636F673B66613B008000FF060D0000
      006D61702D7369676E733B66613B000000FF060B00000074682D6C6973743B66
      613B000000FF06080000006C6973743B66613B000000FF060F0000006172726F
      772D72696768743B66613B}
  end
end
