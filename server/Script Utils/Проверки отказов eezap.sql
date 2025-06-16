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


Select dateadd(dd, 0, p.OperDate) 
      ,p.FileName 
      ,p.MakeLogo 
      ,p.OrderNum           
      ,p.DetailNumber    
      ,p.Reference 
      ,p.DetailID      
      ,p.Quantity    
      ,ur.Quantity  QuantityCancel

      ,p.QuantityOrg
      ,m.Quantity   QuantityEmex
      ,p.PricePurchase   
      ,p.AmountPurchase  
      ,p.ClientID
      ,p.ClientName    
      ,ur.UnloaRefusalID
      --,ur.Quantity, ur.OperDate 

     , m.*
  from (Select cast(GetDate() as Date)	 as OperDate -- Дата ответа

              ,c.ClientID
              ,c.Brief                   as ClientName
              ,c.Brief +' '+ REPLACE(convert(varchar(10), dateadd(dd, 0, getdate()), 3), '/', '') as FileName
         	    ,o.OrderNum 
         	    ,o.MakeLogo
         	    ,o.DetailNumber
         	    ,o.Reference
              ,o.CustomerSubId
              ,o.DetailID
           	  ,sum( iif(o.isCancel=1, 0, 1) *  iif(o.Quantity > 0, o.Quantity, 0)) as Quantity -- всего количество в обработке
              ,sum(o.Quantity)                       as QuantityOrg -- всего количество деталей на нашей стороне
         	    ,max(isnull(o.PricePurchase, 0))       as PricePurchase
         	    ,sum(isnull(o.AmountPurchase, 0))      as AmountPurchase  
              ,max(c.NotificationAddress) as NotificationAddress           
          from tClients c with (nolock)
         inner join tOrders o with (nolock)
                 on o.ClientID = c.ClientID
                and o.MakeLogo is not null
                --and o.OrderNum = '512966'
                --and o.DetailNumber = '263172F001'
         where c.NotificationMethod = 0 -- автоматическое оповещение
           and c.ResponseType       = 1 -- файл           
         
         group by c.ClientID, c.Brief, o.OrderNum, o.MakeLogo, o.DetailNumber, o.Reference, o.DetailID, o.CustomerSubId 
         ) as p
   left join tUnloadRefusals ur (nolock)
          on ur.ClientID     = p.ClientID
         and ur.DetailNumber = p.DetailNumber 
         and ur.Reference    = p.Reference
         and ur.DetailID     = p.DetailID
         --and ur.MakeLogo = p.MakeLogo
         --and ur.OrderNum = p.OrderNum

   left join  #Movement  m (nolock)
          on m.MakeLogo         = p.MakeLogo
         and m.DetailNum        = p.DetailNumber
         and m.CustomerSubId    = p.CustomerSubId
         and m.Reference        = p.Reference 
        -- and m.Quantity        <> p.QuantityOrg

  where (ur.Quantity < p.Quantity)
  order by p.OrderNum    

  --select * from tUnloadRefusals where 
  --OrderNum = '514085'
  --and DetailNumber = '5216333902'
	