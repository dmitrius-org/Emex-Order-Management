inherited InstructionT: TInstructionT
  Height = 478
  ExplicitHeight = 478
  inherited UniPanel1: TUniPanel
    Height = 478
    inherited MenuPanel: TUniContainerPanel
      Height = 476
      inherited TreeMenu: TUniTreeView
        Height = 476
        Items.NodeData = {
          07040000000A5400580054007200650065004E006F00640065002B0000000000
          000000000000FFFFFFFFFFFFFFFF000000000000000000000000000106770065
          0072006500770072000000250000000000000000000000FFFFFFFFFFFFFFFF00
          000000000000000000000000010377006500720000002B000000000000000000
          0000FFFFFFFFFFFFFFFF00000000000000000000000000010677006500720065
          00770072000000250000000000000000000000FFFFFFFFFFFFFFFF0000000000
          00000000000000000103770065007200}
        Items.FontData = {
          0104000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFF
          FF00000000}
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
      end
    end
    inherited ContentPanel: TUniContainerPanel
      Height = 476
      inherited UniPanel2: TUniPanel
        Height = 473
        inherited ArticleContent: TUniContainerPanel
          Height = 418
          inherited edt1: TUniHTMLFrame
            Height = 412
          end
        end
      end
    end
  end
end
