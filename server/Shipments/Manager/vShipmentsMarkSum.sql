

if OBJECT_ID('vShipmentsMarkSum') is not null
    drop view vShipmentsMarkSum
go
/* **********************************************************
vShipmentsMarkSum - сумма выделенный заказов/деталей
             
********************************************************** */

create view vShipmentsMarkSum
as

select round( Sum(s.ShipmentsAmount), 2)    as ShipmentsAmount, --Сумма отгрузки ($)
       round( Sum(s.ShipmentsAmountR), 2)   as ShipmentsAmountR --Сумма отгрузки (руб)
  from tMarks m with (nolock index=pk_tMarks)
 inner join tShipments s with (nolock index=ao1)
         on s.ShipmentsID = m.ID
where m.Spid   = @@spid
  and m.Type   = 10 -- tObjectType.ObjectTypeID

go
exec setOV 'vShipmentsMarkSum', 'V', '20250312', '0'
go
grant select on vShipmentsMarkSum to public
go
