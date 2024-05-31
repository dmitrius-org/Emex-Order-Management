inherited InstructionDevT: TInstructionDevT
  inherited UniPanel1: TUniPanel
    inherited MenuPanel: TUniContainerPanel
      inherited TreeMenu: TUniTreeView
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
      end
    end
  end
end
