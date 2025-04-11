set nocount on;

if OBJECT_ID('tempdb..#UnloadRefusals') is not null
  drop table #UnloadRefusals
CREATE TABLE #UnloadRefusals
(
 OperDate             datetime -- дата выгрузки ответа
,FileName             varchar(256) 
,OrderDate            DateTime 
,ClientName           varchar(512)
,OrderNum             varchar(128)
,DetailName           varchar(256)
,MakeLogo             varchar(32)
,Brand                varchar(128)
,UploadFileName       varchar(32)
,DetailNumber         varchar(128) 
,CustomerPriceLogo    varchar(32)
,Reference            varchar(128)
,DetailID             varchar(128)
,Quantity             int 
,QuantityOrg          int
,Price                int
,Amount               int
,ClientID             numeric(18, 0)
,NotificationAddress  varchar(512)
,NotificationScript   varchar(512)
,OnlyThisBrand        varchar(30)
,CustomerClientNum    varchar(128)   
,CustomerClientSign   varchar(128)  
,CustomerOrder        varchar(128)  
);

;with OrdersWithDiff as (
    select distinct o.OrderNum
    from tOrders o with (nolock)
    outer apply (
                  select top 1 ur.Quantity
                    from tUnloadRefusals ur with (nolock)
                   where ur.ClientID     = o.ClientID
                     and ur.DetailNumber = o.DetailNumber 
                     and ur.Reference    = o.Reference
                     and ur.DetailID     = o.DetailID
                     and ur.OrderNum     = o.OrderNum
                   order by ur.OperDate desc
                 ) ur
    where o.ClientID = 149
 --     and o.OrderNum ='BRA0000000002'
    group by o.ClientID, o.DetailNumber, o.Reference, o.DetailID, o.OrderNum
            ,ur.Quantity
           
   having sum( iif(o.isCancel=1, 0, 1) *  o.Quantity ) <> isnull(ur.Quantity, -1)
)

insert #UnloadRefusals
      (OperDate 
      ,FileName        	         
      ,OrderNum 
      ,OrderDate       
      ,MakeLogo        
      ,DetailNumber    
      ,DetailName
      ,CustomerPriceLogo
      ,Reference  
      ,DetailID     
      ,Quantity   
      ,QuantityOrg
      ,Price  
      ,Amount  
      ,ClientID
      ,ClientName    
      ,NotificationAddress     
      ,NotificationScript
      ,UploadFileName
      ,Brand
      ,OnlyThisBrand
      ,CustomerClientNum      
      ,CustomerClientSign    
      ,CustomerOrder           
      )
Select dateadd(dd, 0, p.OperDate) 
      ,p.FileName        	         
      ,p.OrderNum  
      ,p.OrderDate      
      ,p.MakeLogo        
      ,p.DetailNumber 
      ,p.DetailName 
      ,p.CustomerPriceLogo  
      ,p.Reference 
      ,p.DetailID      
      ,p.Quantity   
      ,p.QuantityOrg
      ,p.Price   
      ,p.Amount 
      ,p.ClientID
      ,p.ClientName    
      ,p.NotificationAddress  
      ,p.NotificationScript
      ,p.UploadFileName
      ,p.Brand
      ,p.OnlyThisBrand
      ,p.CustomerClientNum
      ,p.CustomerClientSign   
      ,p.CustomerOrder        
  from (Select cast(GetDate() as Date)	 as OperDate -- Дата ответа
              ,c.ClientID
              ,c.Brief                   as ClientName
              ,'Order' + o.OrderNum + '(' + REPLACE(convert(varchar(10), max(o.OrderDate), 4), '/', '') + ')' as FileName
         	    ,o.OrderNum 
              
         	    ,o.MakeLogo
         	    ,o.DetailNumber
         	    ,o.Reference
              ,o.DetailID
              
              ,max(o.OrderDate)         OrderDate
              ,max(o.CustomerPriceLogo) CustomerPriceLogo
              ,max(isnull(o.DetailName, ''))   DetailName 
              ,max(o.Manufacturer)             Brand              
           	  ,sum( iif(o.isCancel=1, 0, 1) *  o.Quantity ) as Quantity
              ,sum(o.Quantity)                              as QuantityOrg
           	  ,max(isnull(o.Price, 0))                      as Price
           	  ,sum(isnull(o.Amount, 0))                     as Amount
              ,max(c.NotificationAddress)                   as NotificationAddress     
              ,max(c.NotificationScript)                    as NotificationScript   
              ,min(cpm.UploadFileName)                      as UploadFileName
              ,case              
                 when SUM(DISTINCT 
                          CASE WHEN o.Flag & 2097152  <> 0 THEN 1 ELSE 0 END * 2097152
                          )&2097152 > 0 
                 then 'Без замен'
                 else ''
               end                                          as OnlyThisBrand
              ,max(isnull(o.CustomerClientNum , '')) as CustomerClientNum     
              ,max(isnull(o.CustomerClientSign, '')) as CustomerClientSign    
              ,max(isnull(o.CustomerOrder     , '')) as CustomerOrder      
          from OrdersWithDiff od
         inner join tOrders o with (nolock)
                 on o.ClientID = 149
                and o.OrderNum = od.OrderNum
                and o.MakeLogo is not null
         inner join tClients c with (nolock)
                 on c.ClientID = o.ClientID
         left join vClientProfilesParam cpm (nolock)   
                on cpm.ClientID        = c.ClientID
               and cpm.ClientPriceLogo = o.CustomerPriceLogo
         where c.ClientID = 149           
           --and not exists (select 1
           --                  from tMovement m (nolock)
           --                 where m.OrderID       = o.OrderID
           --                   and m.Quantity     <> o.Quantity
           --                 union all
           --                select 2
           --                  from tMovement m (nolock)
           --                 where m.OrderNumber      = o.EmexOrderID
           --                   and m.DetailNum        = o.DetailNumber
           --                   and m.CustomerSubId    = o.CustomerSubId
           --                   and m.Reference        = o.Reference 
           --                   and (isnull(m.OrderID, 0) = 0 
           --                     or m.Quantity <> o.Quantity)
           --               ) 
         group by c.ClientID, c.Brief, o.OrderNum, o.MakeLogo, o.DetailNumber, o.Reference, o.DetailID 
         ) as p


where 1=1
  
select distinct 
       
       FileName, NotificationAddress, NotificationScript 
  from #UnloadRefusals (nolock)
 --where OrderNum ='BRA0000000002'
 order by FileName