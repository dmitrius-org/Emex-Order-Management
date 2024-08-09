drop proc if exists PartsMostOrdersList
/*
  PartsMostOrdersList - Детали с наибольшим количеством заказанных позиций
*/
go
create proc PartsMostOrdersList
               @RowSize int = null                          
as

  select @RowSize = isnull(@RowSize, 100)
 
 set rowcount @RowSize 

  Select p.Make, 
         m.Name            Manufacturer, 
         p.DetailNum       DetailNumber,
         pd.Name_RUS       DetailName,
         p.OrderCount 
    from tPartsStatistics p (nolock)

    left join [tPartDescription] pd (nolock)  
           on pd.Make   = p.Make
          and pd.Number = p.DetailNum

    left join tMakes m (nolock)
           on m.Code = p.Make
   order by p.OrderCount desc

  set rowcount 0 

  --declare @Result as table
  --(Make     	nvarchar(256)
  --,Manufacturer nvarchar(256)
  --,DetailNumber nvarchar(64)
  --,DetailName   nvarchar(256)
  --,OrderCount   int
  --)
  


  --set rowcount @RowSize 
  --insert @Result
  --      (Make,
  --       DetailNumber,
  --       OrderCount
  --       )
  --Select o.MakeLogo,
  --       o.DetailNumber,
  --       count(o.Quantity) as OrderCount
  --  from tOrders o    
  -- group by o.MakeLogo, o.DetailNumber

  -- order by OrderCount desc
  --set rowcount 0

  --Select p.Make, 
  --       m.Name Manufacturer, 
  --       p.DetailNumber,
  --       isnull(p.DetailName, pd.Name_RUS) DetailName,
  --       OrderCount 
  --  from @Result p 
  --  left join [tPartDescription] pd (nolock)  
  --         on pd.Make   = p.Make
  --        and pd.Number = p.DetailNumber

  --  left join tMakes m (nolock)
  --         on m.Code = p.Make
  -- order by p.OrderCount desc


go
grant exec on PartsMostOrdersList to public
go
exec setOV 'PartsMostOrdersList', 'P', '20240808', '2'
go