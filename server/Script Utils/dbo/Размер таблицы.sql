
--select 'tPrice' as TableName,	'dbo' as SchemaName,59691430 as RowCounts,	7035200 as TotalSpaceKB,	6.7089843 as TotalSpaceGB,7033008 as UsedSpaceKB,	2192 as UnusedSpaceKB, '20.07.2023' _date
go
SELECT
  t.Name                                       AS TableName,
  s.Name                                       AS SchemaName,
  p.Rows                                       AS RowCounts,
  SUM(a.total_pages) * 8                       AS TotalSpaceKB,
  SUM(a.total_pages) * 8 / 1024 /1024.00       AS TotalSpaceGB,
  SUM(a.used_pages) * 8                        AS UsedSpaceKB,
  (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB,
  getdate() _date
FROM
  sys.tables t
  INNER JOIN sys.indexes i ON t.object_id = i.object_id
  INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
  INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
  LEFT OUTER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE 1=1
 -- t.Name = 'tPrice'--NOT LIKE 'dt%'
  AND t.is_ms_shipped = 0
  AND i.object_id > 255
GROUP BY
  t.Name, s.Name, p.Rows
ORDER BY
  t.Name;
GO
EXEC sp_spaceused N'tPrice'; 
--EXEC sp_spaceused N'tOrders'; 