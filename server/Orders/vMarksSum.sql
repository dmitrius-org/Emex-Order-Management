

if OBJECT_ID('vMarksSum') is not null
    drop view vMarksSum
go
/* **********************************************************						
vMarksSum - сумма выделенный заказов/деталей
             
********************************************************** */

create view vMarksSum
as

select Sum(Amount)              as Amount, 
       sum(AmountPurchase)      as AmountPurchase,
       sum(WeightKG)            as WeightKG,
       sum(VolumeKG)            as VolumeKG,
       sum(VolumeKG - WeightKG) as OverVolume  -- превышение объема, разница Объемный вес - Физический вес по данным прайс-листа.
  from tMarks m (nolock)
 inner join tOrders o --(nolock)
         on o.OrderID = m.ID
where m.Spid   = @@spid
  and m.Type   = 3

go
grant select on vMarksSum to public
go


select * from vMarksSum


--select * from tOrders