DECLARE @Orders ID;

-- Вставляем @Orders в таблицу переменной
INSERT INTO @Orders (ID)
select min(o.OrderID)

  from tOrders o (nolock)   
 group by  o.MakeLogo, o.DetailNumber 

-- Вызов хранимой процедуры
EXEC PartsStatisticsCalc @Orders = @Orders;
 -- declare @Parts as table
 -- (
 --  Make     	nvarchar(256)
 -- ,DetailNumber nvarchar(64)
 -- )

 -- insert @Parts
 --       (Make,
 --        DetailNumber)
 -- Select distinct 
 --        o.MakeLogo,
 --        o.DetailNumber
 --   from @Orders p 
 --  inner join tOrders o (nolock)   
 --          on o.OrderID = p.ID 

 --Select p.Make,
 --        p.DetailNumber,
 --        o.OrderCount,
 --        o.OrdeUniqueCount
 --   from @Parts p  
 --   cross apply (select top 1 count(*) over ()  OrdeUniqueCount 
 --                      ,sum(min(o.Quantity))  over () OrderCount 
 --                  from tOrders o (nolock)   
 --                 where o.MakeLogo     = p.Make
 --                   and o.DetailNumber = p.DetailNumber
 --                 group by  o.CustomerSubId, o.MakeLogo, o.DetailNumber 
 --               ) as o
   --where not exists (select 1
   --                   from tPartsStatistics pp (nolock)
   --                  where pp.Make      = p.Make
   --                    and pp.DetailNum = p.DetailNumber)

