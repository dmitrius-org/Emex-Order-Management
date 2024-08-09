drop proc if exists PartsMostUniqueOrdersList
/*
  PartsMostUniqueOrdersList - Детали с наибольшим количеством уникальных заказов
*/
go
create proc PartsMostUniqueOrdersList
               @RowSize int = null                          
as

  select @RowSize = isnull(@RowSize, 100)

  set rowcount @RowSize 

  Select p.Make, 
         m.Name            Manufacturer, 
         p.DetailNum       DetailNumber,
         pd.Name_RUS       DetailName,
         p.OrderUniqueCount OrderCount
    from tPartsStatistics p (nolock)

    left join [tPartDescription] pd (nolock)  
           on pd.Make   = p.Make
          and pd.Number = p.DetailNum

    left join tMakes m (nolock)
           on m.Code = p.Make
   order by p.OrderUniqueCount desc

  set rowcount 0 
  --declare @Parts as table
  --(Make     	nvarchar(256)
  --,DetailNumber nvarchar(64)
  --)


  --declare @Result as table
  --(Make     	nvarchar(256)
  --,Manufacturer nvarchar(256)
  --,DetailNumber nvarchar(64)
  --,DetailName   nvarchar(256)
  --,OrderCount   int
  --)
  
  ----
  --insert @Parts
  --      (Make,
  --       DetailNumber)
  --Select o.MakeLogo,
  --       o.DetailNumber
  --  from tOrders o (nolock)   
  -- where 1=1
  --   --and o.DetailNumber = '0K20B66124'
  -- group by o.CustomerSubId, o.MakeLogo, o.DetailNumber

  --set rowcount @RowSize 
  --insert @Result
  --      (Make,
  --       DetailNumber,
  --       OrderCount
  --       )
  --Select o.Make,
  --       o.DetailNumber,
  --       count(*) as OrderCount
  --  from @Parts o    
  -- group by o.Make, o.DetailNumber

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
grant exec on PartsMostUniqueOrdersList to public
go
exec setOV 'PartsMostUniqueOrdersList', 'P', '20240808', '1'
go
