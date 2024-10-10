 config.updateRowSpan = function() {
    console.log('updateRowSpan');
    var columns = sender.getColumns(),
        view = sender.getView(),
        store = sender.getStore(),
        rowCount = store.getCount();

    console.log(rowCount);
    console.log(columns.length);

    for (var col = 0; col < 6; ++col) {     
        var colIndx = col; 
        var column = columns[colIndx];
        var dataIndex = column.dataIndex;

        for (var row = 1; row < 100; ++row) {
            var cell = view.getCellByPosition({ row: row, column: colIndx }).dom;

            // Добавляем проверку на существование ячейки
            if (!cell || !Ext.fly(cell).query('.x-grid-cell-inner')[0]) {
                console.log(rowCount);
                continue;
            }

            Ext.fly(cell).query('.x-grid-cell-inner')[0].style.display = 'none';

        }

    }
};