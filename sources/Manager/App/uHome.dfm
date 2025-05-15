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
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1089#1077#1088#1074#1080#1089#1086#1074
      Layout = 'fit'
      LayoutConfig.IgnorePosition = False
      LayoutConfig.DockWhenAligned = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 256
      ExplicitHeight = 128
    end
  end
end
