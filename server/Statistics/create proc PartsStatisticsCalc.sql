drop proc if exists PartsStatisticsCalc
/*
  PartsStatisticsCalc - 
*/
go
create proc PartsStatisticsCalc
              @Orders      ID READONLY 
as

  declare @Parts as table
  (
   Make     	nvarchar(256)
  ,DetailNumber nvarchar(64)
  )

  insert @Parts
        (Make,
         DetailNumber)
  Select distinct 
         o.MakeLogo,
         o.DetailNumber
    from @Orders p 
   inner join tOrders o (nolock)   
           on o.OrderID = p.ID 


    insert tPartsStatistics
        (Make,
            DetailNum,
            OrderCount
            )
    Select p.Make,
            p.DetailNumber,
            o.OrderCount
    from @Parts p  
    cross apply (select top 1 count(*) over ()        OrdeUniqueCount 
                        ,sum(min(o.Quantity))  over () OrderCount 
                    from tOrders o (nolock)   
                    where o.MakeLogo     = p.Make
                    and o.DetailNumber = p.DetailNumber
                    group by o.CustomerSubId, o.Reference, o.MakeLogo, o.DetailNumber 
                ) as o
    where not exists (select 1
                        from tPartsStatistics pp (nolock)
                        where pp.Make      = p.Make
                        and pp.DetailNum = p.DetailNumber)


    Update ps
       set ps.OrderCount       = o.OrderCount
          ,ps.OrderUniqueCount  = o.OrderUniqueCount
      from @Parts p  
     inner join tPartsStatistics ps (updlock)
             on ps.Make      = p.Make
            and ps.DetailNum = p.DetailNumber

    cross apply (select top 1 count(*) over ()        OrderUniqueCount 
                        ,sum(min(o.Quantity))  over () OrderCount 
                    from tOrders o (nolock)   
                    where o.MakeLogo     = ps.Make
                    and o.DetailNumber = ps.DetailNum
                    group by  o.CustomerSubId, o.Reference, o.MakeLogo, o.DetailNumber 
                ) as o

    Update ps
       set ps.WorkOrderCount       = o.OrderCount
          ,ps.WorkOrderUniqueCount  = o.OrderUniqueCount
      from @Parts p  
     inner join tPartsStatistics ps (updlock)
             on ps.Make      = p.Make
            and ps.DetailNum = p.DetailNumber

    cross apply (select top 1 count(*) over ()        OrderUniqueCount 
                        ,sum(min(o.Quantity))  over () OrderCount 
                    from tOrders o (nolock)   
                    where o.MakeLogo     = ps.Make
                    and o.DetailNumber = ps.DetailNum
                    and isnull(o.iscancel, 0) = 0
                    group by  o.CustomerSubId, o.Reference, o.MakeLogo, o.DetailNumber 
                ) as o

go
grant exec on PartsStatisticsCalc to public
go
exec setOV 'PartsStatisticsCalc', 'P', '20240814', '3'
go
 