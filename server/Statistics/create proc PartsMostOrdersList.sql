drop proc if exists PartsMostOrdersList
/*
  PartsMostOrdersList - Детали с наибольшим количеством заказанных позиций
*/
go
create proc PartsMostOrdersList
               @RowSize   int = null  
              ,@isCancel  bit = null  
              ,@DateBegin datetime = null
              ,@DateEnd   datetime = null
as

  select @RowSize = isnull(@RowSize, 100)
        ,@DateBegin=nullif(@DateBegin, '')
        ,@DateEnd  =nullif(@DateEnd, '')


  delete pPartsStatistics from pPartsStatistics (rowlock) where Spid = @@SPID

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
    from tOrders o (nolock)
   where o.OrderDate between isnull(@DateBegin, '19000101') and isnull(@DateEnd, '20701231')


  insert pPartsStatistics
        (Spid,
         Make,
         DetailNum,
         OrderCount)
  Select @@SPID,
         p.Make,
         p.DetailNumber,
         o.OrderCount
    from @Parts p  
   cross apply (select sum(o.Quantity) OrderCount 
                  from tOrders o (nolock)   
                 where o.MakeLogo   = p.Make
                   and o.DetailNumber = p.DetailNumber
                   and o.OrderDate between isnull(@DateBegin, '19000101') and isnull(@DateEnd, '20701231')
                   and o.isCancel = isnull(@isCancel, o.isCancel)
                ) as o


  set rowcount @RowSize 


  Select p.Make            Make, 
         m.Name            Manufacturer, 
         p.DetailNum       DetailNumber,
         pd.Name_RUS       DetailName,
         p.OrderCount      OrderCount
    from pPartsStatistics p (nolock)

    left join [tPartDescription] pd (nolock)  
           on pd.Make   = p.Make
          and pd.Number = p.DetailNum

    left join tMakes m (nolock)
           on m.Code = p.Make

    where p.spid = @@SPID
   order by p.OrderCount desc

   set rowcount 0 
go
grant exec on PartsMostOrdersList to public
go
exec setOV 'PartsMostOrdersList', 'P', '20240808', '3'
go