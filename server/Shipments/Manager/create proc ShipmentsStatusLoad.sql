if OBJECT_ID('ShipmentsStatusLoad') is not null
  drop proc ShipmentsStatusLoad
go
/* **********************************************************

********************************************************** */
create proc ShipmentsStatusLoad
as

declare @ID as ID

insert tShipmentsStatus (
       Date
      ,Number
      ,Name
      ,ID
      ) 
OUTPUT INSERTED.ShipmentStatusID INTO @ID(ID)    
select p.Date
      ,p.Number
      ,p.Name
      ,p.ID
  from #shipments p (nolock)
 where not exists (select 1
                     from tShipmentsStatus t with (nolock index=ao2)
                    where t.Number= p.Number
                      and t.ID    = p.ID
                  )

 delete pShipmentsProtocol from pShipmentsProtocol (rowlock) where spid = @@Spid
 insert pShipmentsProtocol 
       (Spid, ShipmentsID, StateID, Message, ord)
 select @@Spid, s.ShipmentsID, s.StatusID, 'Синхранизация статусов с транспортной компанией', 0
   from tShipments s (updlock)
  where isnull(s.StatusID, 0) <> 24 --	Received	Готовим к выдаче в РФ

 exec ShipmentsStatusSync

go
grant execute on ShipmentsStatusLoad to public
go
exec setOV 'ShipmentsStatusLoad', 'P', '20240916', '2'
go