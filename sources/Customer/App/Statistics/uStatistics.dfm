object StatisticsT: TStatisticsT
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 1324
  Height = 549
  Margins.Bottom = 0
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
  object PageCommon: TUniPageControl
    Left = 0
    Top = 0
    Width = 1324
    Height = 549
    Hint = ''
    ActivePage = TabOrders
    Align = alClient
    TabOrder = 0
    object TabOrders: TUniTabSheet
      Hint = ''
      Caption = #1052#1086#1085#1080#1090#1086#1088' '#1079#1072#1082#1072#1079#1086#1074
      Layout = 'fit'
      OnBeforeFirstActivate = TabOrdersBeforeFirstActivate
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 256
      ExplicitHeight = 128
    end
  end
end
