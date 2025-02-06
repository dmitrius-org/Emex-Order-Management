if OBJECT_ID('vOrdersProtocolInWork') is not null
    drop view vOrdersProtocolInWork
go
/* **********************************************************						
vOrdersProtocolInWork - 
********************************************************** */

create view vOrdersProtocolInWork
as
select p.ObjectID as OrderID
      ,n.NodeID   as StateID
      ,n.Brief    as StateBrief
      ,p.OperDate
  from tNodes n with (nolock)
 cross apply (select p.ObjectID, max(isnull(p.OperDate, p.InDateTime)) as OperDate
                from tProtocol p
               where p.NewStateID = n.NodeID
               group by p.ObjectID
              -- order by p.OperDate desc
               ) as p
 where n.NodeID = 4 -- InWork
  
go
grant select on vOrdersProtocolInWork to public
go
exec setOV 'vOrdersProtocolInWork', 'V', '20250204', '0'
go
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'vOrdersProtocolInWork', @desc = 'Протокол перевода в статус в работе'

