if OBJECT_ID('vShipmentsMarkSum') is not null
    drop view vShipmentsMarkSum
go
/* **********************************************************
vShipmentsMarkSum - сумма выделенный отгрузок
             
********************************************************** */
create view vShipmentsMarkSum
as

select round( Sum(coalesce(s.ShipmentsAmount , p.ShipmentsAmount, 0 )) , 2)  as ShipmentsAmount, --Сумма отгрузки ($)
       round( Sum(coalesce(s.ShipmentsAmountR, p.ShipmentsAmountR, 0 )), 2)  as ShipmentsAmountR --Сумма отгрузки (руб)
  from tMarks m with (nolock index=pk_tMarks)
  left join tShipments s with (nolock index=ao1)
         on s.ShipmentsID = m.ID
  left join pShipments p (nolock)
         on p.Spid        = @@SPID
        and p.ShipmentsID = m.ID
where m.Spid   = @@spid
  and m.Type   = 10 -- tObjectType.ObjectTypeID

go
exec setOV 'vShipmentsMarkSum', 'V', '20250531', '2'
go
grant select on vShipmentsMarkSum to public
go
