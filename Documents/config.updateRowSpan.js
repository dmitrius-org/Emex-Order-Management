function afterCreate(sender)
{
  sender.getView().on('refresh', sender.updateRowSpan, sender);
}  
  
  
function beforeInit(sender, config)
{
     

    config.updateRowSpan = function() {

    var columns = sender.getColumns(),
        view = sender.getView(),
        store = sender.getStore(),
        rowCount = store.getCount();

    for (var col = 0; col < columns.length; ++col) {     
        var colIndx = col; 
        var column = columns[colIndx];
        var dataIndex = column.dataIndex;
        var spanCell = null,
            spanCount = 0,
            spanValue = null;

        for (var row = 0; row < rowCount; ++row) {
            var cell = view.getCellByPosition({ row: row, column: colIndx }).dom,
                record = store.getAt(row),
                value = record.get(dataIndex);

            // Добавляем проверку на существование ячейки
          //  if (!cell || !Ext.fly(cell).query('.x-grid-cell-inner')[0]) {
          //      continue;
          //  }

            if (col < 6) {
                if (spanValue !== value) {
                    // Применяем rowSpan для предыдущей группы
                    if (spanCell !== null) {
                        spanCell.rowSpan = spanCount;
                    }

                    // Новая группа
                    Ext.fly(cell).query('.x-grid-cell-inner')[0].style.display = '';
                    spanCell = cell;
                    spanCount = 1;
                    spanValue = value;
                } else {
                    // Увеличиваем счетчик для текущей группы    
                    spanCount++;
                    console.log(spanCount);
                    
                    Ext.fly(cell).query('.x-grid-cell-inner')[0].style.display = 'none';
                    
                }
            } else {
                // Логика для колонок больше 6
                if (row === 0) {
                    Ext.fly(cell).query('.x-grid-cell-inner')[0].style.display = '';
                } else {
                    Ext.fly(cell).addCls('bordered-cell'); // Вместо прямой работы с inline-стилями
                }
            }
        }

        // Применяем rowSpan для последней группы строк (особенно для последней строки)
        if (spanCell !== null) {
            spanCell.rowSpan = spanCount;
        }
    }
    };


}