inherited InstructionT: TInstructionT
  Height = 478
  ExplicitHeight = 478
  inherited UniPanel1: TUniPanel
    Height = 478
    ExplicitWidth = 894
    ExplicitHeight = 404
    inherited MenuPanel: TUniContainerPanel
      Height = 476
      ExplicitHeight = 402
      inherited TreeMenu: TUniTreeView
        Height = 476
        Items.NodeData = {
          03020000002A0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
          00000000000106770065007200650077007200240000000000000000000000FF
          FFFFFFFFFFFFFF0000000000000000000000000103770065007200}
        Items.FontData = {0102000000FFFFFFFF00000000FFFFFFFF00000000}
        ToolButtons = <
          item
            Action = actAdd
            ButtonId = 0
            IconCls = 'add'
            ImageIndex = 3
          end
          item
            Action = actRefreshAll
            ButtonId = 3
            IconCls = 'refresh'
            ImageIndex = 2
          end>
        ExplicitHeight = 402
      end
    end
    inherited ContentPanel: TUniContainerPanel
      Height = 476
      ExplicitWidth = 592
      ExplicitHeight = 402
      inherited UniPanel2: TUniPanel
        Height = 473
        ExplicitWidth = 586
        ExplicitHeight = 399
        inherited ArticleToolBar: TUniPanel
          ExplicitWidth = 580
          inherited UniPanel: TUniPanel
            ExplicitLeft = 184
          end
        end
        inherited ArticleContent: TUniContainerPanel
          Height = 418
          ExplicitWidth = 586
          ExplicitHeight = 344
          inherited edt1: TUniHTMLFrame
            Height = 412
            ExplicitWidth = 580
            ExplicitHeight = 338
          end
        end
      end
    end
  end
end
