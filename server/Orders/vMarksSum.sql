

if OBJECT_ID('vMarksSum') is not null
    drop view vMarksSum
go
/* **********************************************************
vMarksSum - сумма выделенный заказов/деталей
             
********************************************************** */

create view vMarksSum
as

select round( Sum(o.Amount), 2)           as Amount, 
       round( sum(coalesce(o.AmountPurchaseF, o.AmountPurchase, 0)),  2)  as AmountPurchase,
       round( sum(coalesce(p.WeightKGF, o.WeightKG, 0) * o.Quantity), 2) as WeightKG,
       round( sum(coalesce(p.VolumeKGF, o.VolumeKG, 0) * o.Quantity), 2) as VolumeKG,
       round( sum(coalesce(p.WeightKGF, o.WeightKG, 0) * o.Quantity - coalesce(p.VolumeKGF, o.VolumeKG, 0) * o.Quantity), 2)  as OverVolume  -- превышение объема, разница Объемный вес - Физический вес по данным прайс-листа.
  from tMarks m with (nolock index=pk_tMarks)
 inner join tOrders o with (nolock index=ao1)
         on o.OrderID = m.ID
  left join vPrice p 
         on p.PriceID = o.PriceID	
where m.Spid   = @@spid
  and m.Type   = 3

go
grant select on vMarksSum to public
go
exec setOV 'vMarksSum', 'V', '20250531', '4'
go
