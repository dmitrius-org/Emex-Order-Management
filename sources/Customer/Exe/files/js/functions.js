// function exportToTemplate(grid1, grid2, templateFilePath) {
//     function getVisibleData(grid) {
//         const data = [];
//         const headers = [];
//         const columns = grid.headerCt.getGridColumns();

//         // Собираем заголовки
//         columns.forEach(column => {
//             if (!column.hidden && column.dataIndex && column.dataIndex !== 'id') {
//                 headers.push(column.text);
//             }
//         });
//         data.push(headers);

//         // Собираем данные
//         grid.getStore().each(record => {
//             const rowData = [];
//             columns.forEach(column => {
//                 if (!column.hidden && column.dataIndex && column.dataIndex !== 'id') {
//                     rowData.push(record.get(column.dataIndex));
//                 }
//             });
//             data.push(rowData);
//         });
//         return data;
//     }

//     const table1Data = getVisibleData(grid1);
//     const table2Data = getVisibleData(grid2);

//     // Загружаем шаблон Excel
//     const xhr = new XMLHttpRequest();
//     xhr.open('GET', templateFilePath, true);
//     xhr.responseType = 'arraybuffer';
//     xhr.onload = function() {
//         if (xhr.status === 200) {
//             const arrayBuffer = xhr.response;
//             const data = new Uint8Array(arrayBuffer);
//             const workbook = XLSX.read(data, { type: 'array' });

//             // Вставляем данные из первой таблицы
//             const worksheet1 = workbook.Sheets[workbook.SheetNames[0]];
//             const startRow1 = 3; // Пример начальной строки для первой таблицы
//             table1Data.forEach((row, i) => {
//                 row.forEach((cell, j) => {
//                     const cellAddress = XLSX.utils.encode_cell({ c: j, r: i + startRow1 });
//                     worksheet1[cellAddress] = { v: cell }; // Вставляем данные
//                 });
//             });

//             // Вставляем данные из второй таблицы
//             const startRow2 = table1Data.length + 5; // Пример начальной строки для второй таблицы
//             table2Data.forEach((row, i) => {
//                 row.forEach((cell, j) => {
//                     const cellAddress = XLSX.utils.encode_cell({ c: j, r: i + startRow2 });
//                     worksheet1[cellAddress] = { v: cell }; // Вставляем данные
//                 });
//             });

//             // Экспортируем обновленный файл Excel
//             XLSX.writeFile(workbook, 'UpdatedTemplate.xlsx');
//         }
//     };
//     xhr.send();
// }
