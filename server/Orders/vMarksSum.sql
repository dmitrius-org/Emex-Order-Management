

if OBJECT_ID('vMarksSum') is not null
    drop view vMarksSum
go
/* **********************************************************
vMarksSum - сумма выделенный заказов/деталей
             
********************************************************** */

create view vMarksSum
as

select Sum(o.Amount)           as Amount, 
       sum(o.AmountPurchaseF)  as AmountPurchase,
       sum(isnull(p.WeightKGF, o.WeightKG) * o.Quantity) as WeightKG,
       sum(isnull(p.VolumeKGF, o.VolumeKG) * o.Quantity) as VolumeKG,
       sum(isnull(p.WeightKGF, o.WeightKG)*o.Quantity  - isnull(p.VolumeKGF, o.VolumeKG)*o.Quantity)  as OverVolume  -- превышение объема, разница Объемный вес - Физический вес по данным прайс-листа.
  from tMarks m with (nolock index=pk_tMarks)
 inner join tOrders o with (nolock index=ao1)
         on o.OrderID = m.ID
  left join tPrice p with (nolock index=ao1)
         on p.PriceID = o.PriceID 
where m.Spid   = @@spid
  and m.Type   = 3

go
exec setOV 'vMarksSum', 'V', '20240604', '2'
go
grant select on vMarksSum to public
go



select * from vMarksSum


--select * from tOrders