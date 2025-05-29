if OBJECT_ID('tempdb..#Orders') is not null
  drop table #Orders
CREATE TABLE #Orders
(
 MakeLogo             varchar(64) 
,DetailNum            varchar(64)  
,Reference            varchar(64) 
,CustomerSubId        varchar(64) 
,Quantity             int 
);

insert #Orders with (rowlock)
       (MakeLogo 
       ,DetailNum
       ,Reference
       ,CustomerSubId 
       ,Quantity )
select  o.MakeLogo 
       ,o.DetailNumber
       ,o.Reference
       ,o.CustomerSubId 
       ,sum(iif(o.isCancel=1 and o.statusID = 12, 0, 1) *  iif(o.Quantity > 0, o.Quantity, 0))
  from tOrders o (nolock)
 group by o.MakeLogo 
         ,o.DetailNumber
         ,o.Reference
         ,o.CustomerSubId 

      --   select * from tNodes

if OBJECT_ID('tempdb..#Movement') is not null
  drop table #Movement
CREATE TABLE #Movement
(
 MakeLogo             varchar(64) 
,DetailNum            varchar(64)  
,Reference            varchar(64) 
,CustomerSubId        varchar(64) 
,Quantity             int 
);

insert #Movement with (rowlock)
       (MakeLogo 
       ,DetailNum
       ,Reference
       ,CustomerSubId 
       ,Quantity )
select  m.MakeLogo 
       ,m.DetailNum
       ,m.Reference
       ,m.CustomerSubId 
       ,sum(m.Quantity)
  from tMovement m (nolock)
 where m.Quantity is not null
 group by m.MakeLogo 
         ,m.DetailNum
         ,m.Reference
         ,m.CustomerSubId 



select *
  from #Movement m
inner join #Orders o
        on o.MakeLogo      = m.MakeLogo
       and o.DetailNum     = m.DetailNum
       and o.CustomerSubId = m.CustomerSubId
       and o.Reference     = m.Reference
       and o.Quantity      <> m.Quantity