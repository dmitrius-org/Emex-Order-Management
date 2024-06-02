object HomeF: THomeF
  Left = 0
  Top = 0
  Width = 932
  Height = 609
  OnCreate = UniFrameCreate
  Layout = 'fit'
  LayoutConfig.IgnorePosition = False
  LayoutConfig.Width = '0'
  ParentAlignmentControl = False
  AlignmentControl = uniAlignmentClient
  Align = alClient
  Anchors = [akLeft, akTop, akRight, akBottom]
  TabOrder = 0
  ParentColor = False
  ParentBackground = False
  object pcMain: TUniPageControl
    Left = 0
    Top = 0
    Width = 932
    Height = 609
    Hint = ''
    ActivePage = Dashboard
    Align = alClient
    LayoutConfig.IgnorePosition = False
    LayoutConfig.DockWhenAligned = False
    TabOrder = 0
    object Dashboard: TUniTabSheet
      AlignWithMargins = True
      Hint = ''
      Caption = 'Dashboard'
      Layout = 'fit'
      LayoutConfig.IgnorePosition = False
      LayoutConfig.DockWhenAligned = False
    end
  end
end
