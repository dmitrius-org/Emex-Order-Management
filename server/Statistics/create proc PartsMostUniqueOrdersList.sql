drop proc if exists PartsMostUniqueOrdersList
/*
  PartsMostUniqueOrdersList - Детали с наибольшим количеством уникальных заказов
*/
go
create proc PartsMostUniqueOrdersList
               @RowSize   int = null  
              ,@isCancel  bit = null  
              ,@DateBegin datetime = null
              ,@DateEnd   datetime = null
as

  select @RowSize = isnull(@RowSize, 100)
        ,@DateBegin=nullif(@DateBegin, '18991230')
        ,@DateEnd  =nullif(@DateEnd, '18991230')


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
          OrderCount
          )
  Select @@SPID,
         p.Make,
         p.DetailNumber,
         o.OrderCount
    from @Parts p  
   cross apply (select top 1 
                       count(*) over () OrderCount 
                  from tOrders o (nolock)   
                 where o.MakeLogo   = p.Make
                   and o.DetailNumber = p.DetailNumber
                   and o.OrderDate between isnull(@DateBegin, '19000101') and isnull(@DateEnd, '20701231')
                   and o.isCancel = isnull(@isCancel, o.isCancel)
                 group by o.CustomerSubId, o.Reference, o.MakeLogo, o.DetailNumber 
                ) as o


  set rowcount @RowSize 


  Select p.Make, 
         m.Name            Manufacturer, 
         p.DetailNum       DetailNumber,
         pd.Name_RUS       DetailName,
         p.OrderCount
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
grant exec on PartsMostUniqueOrdersList to public
go
exec setOV 'PartsMostUniqueOrdersList', 'P', '20240808', '2'
go
