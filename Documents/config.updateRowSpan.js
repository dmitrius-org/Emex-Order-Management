function afterCreate(sender)
{
  sender.getView().on('refresh', sender.updateRowSpan, sender);
}  
  
  
//  function beforeInit(sender, config)
  config.updateRowSpan = function() {
        var columns = sender.getColumns(),
        view = sender.getView(),
        store = sender.getStore(),
        rowCount = store.getCount();
        //console.log(columns);  
        for (var col = 0; col < columns.length; ++col) {     
            var colIndx = col; // second column for example
            var column = columns[colIndx];
            var dataIndex = column.dataIndex,
            spanCell = null,
            spanCount = null,
            spanValue = null;
            
            for (var row = 0; row < rowCount; ++row) {
                var cell = view.getCellByPosition({ row: row, column: colIndx }).dom,
                record = store.getAt(row),
                value = record.get(dataIndex);

                if (col < 6) {
                    if (spanValue != value) {
                        if (spanCell !== null) {
                            spanCell.rowSpan = spanCount;
                        }

                        Ext.fly(cell).query('.x-grid-cell-inner')[0].style.display='';
                        spanCell = cell;
                        spanCount = 1;
                        spanValue = value;
                    } else {
                        spanCount++;
                    //  Ext.fly(cell).setStyle('display', 'none');     
                        Ext.fly(cell).query('.x-grid-cell-inner')[0].style.display='none';
                    }
                }
                else {
                
                    if (row == 0) {
                        Ext.fly(cell).query('.x-grid-cell-inner')[0].style.display=''
                    }
                    else { 
                
                        Ext.fly(cell).setStyle('border-style', 'solid');
                        Ext.fly(cell).setStyle('border-width', '1px 0 0');
                        Ext.fly(cell).setStyle('border-color', '#cfcfcf');  
                    }
                }  //if (col < 5) {
                
            }
            
            if (spanCell !== null) {
                spanCell.rowSpan = spanCount;
            }
        };

    };