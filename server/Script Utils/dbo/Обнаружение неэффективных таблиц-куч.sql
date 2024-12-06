SELECT TOP 25
 t.object_id
 ,s.name + '.' + t.name AS [table]
 ,SUM(ips.record_count) AS [rows]
 ,SUM(ips.forwarded_record_count)
 AS [forwarding pointers]
 ,SUM(ips.avg_page_space_used_in_percent * ips.page_count) /
 NULLIF(SUM(ips.page_count),0)
 AS [internal fragmentation %]
FROM
 sys.tables t WITH (NOLOCK)
 JOIN sys.schemas s WITH (NOLOCK) ON
 t.schema_id = s.schema_id
 CROSS APPLY
 sys.dm_db_index_physical_stats
 (DB_ID(),t.object_id,0,NULL,'DETAILED') ips

WHERE
 t.is_memory_optimized = 0 AND
 t.is_ms_shipped = 0 AND
 EXISTS
 (
 SELECT *
 FROM sys.indexes i WITH (NOLOCK)
 WHERE t.object_id = i.object_id AND i.index_id = 0
 )
GROUP BY
 t.object_id, s.name, t.name
ORDER BY
 [forwarding pointers] DESC
OPTION (RECOMPILE, MAXDOP 1);


/*
ALTER TABLE dbo.tPartDescription REBUILD WITH (ONLINE = ON);

ALTER INDEX ALL ON dbo.tCustomerGridOptions REBUILD;


dbo.tProtocol
dbo.pOrdersFin
dbo.pShipments
dbo.tShipments
dbo.tOrderRefusals
dbo.tObjectVersion
 */