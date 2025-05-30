drop proc if exists OrderRefusalsCalc_Automatic
/*
  OrderRefusalsCalc_Automatic -- расчет
  -- автоматическое оповещение
*/
go
create proc OrderRefusalsCalc_Automatic
as
set nocount on;
declare @r int

if OBJECT_ID('tempdb..#UnloadRefusals') is not null
  drop table #UnloadRefusals
CREATE TABLE #UnloadRefusals
(
 OperDate             datetime -- дата выгрузки ответа
,FileName             nvarchar(256)  
,ClientName           nvarchar(512)
,OrderNum             nvarchar(128)
,MakeLogo             nvarchar(32)
,DetailNumber         nvarchar(128)
,Reference            nvarchar(128)
,DetailID             nvarchar(128)
,Quantity             int 
,PricePurchase        money
,AmountPurchase       money
,ClientID             numeric(18, 0)
,NotificationAddress  nvarchar(512)
);


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
 
insert #UnloadRefusals with (rowlock)
      (OperDate 
      ,FileName        	         
      ,OrderNum        
      ,MakeLogo        
      ,DetailNumber    
      ,Reference  
      ,DetailID     
      ,Quantity        
      ,PricePurchase   
      ,AmountPurchase  
      ,ClientID
      ,ClientName    
      ,NotificationAddress      )

Select dateadd(dd, 0, p.OperDate) 
      ,p.FileName        	         
      ,p.OrderNum        
      ,p.MakeLogo        
      ,p.DetailNumber    
      ,p.Reference 
      ,p.DetailID      
      ,p.Quantity        
      ,p.PricePurchase   
      ,p.AmountPurchase  
      ,p.ClientID
      ,p.ClientName    
      ,p.NotificationAddress  

      --,ur.Quantity, ur.OperDate 
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
         where c.NotificationMethod = 0 -- автоматическое оповещение
           and c.ResponseType       = 1 -- файл                    
         group by c.ClientID, c.Brief, o.OrderNum, o.MakeLogo, o.DetailNumber, o.Reference, o.DetailID, o.CustomerSubId 
         ) as p
   left join tUnloadRefusals ur (nolock)
          on ur.ClientID     = p.ClientID
         and ur.DetailNumber = p.DetailNumber 
         and ur.Reference    = p.Reference
         and ur.DetailID     = p.DetailID

where isnull(p.NotificationAddress, '') <> ''

  and (ur.DetailNumber is null or ur.Quantity > p.Quantity)
  
  -- если есть несоответсвие с emex, то не выгружаем отказы
  and not exists (select 1
                    from #Movement  m (nolock)
                   where m.MakeLogo         = p.MakeLogo
                     and m.DetailNum        = p.DetailNumber
                     and m.CustomerSubId    = p.CustomerSubId
                     and m.Reference        = p.Reference 
                     and m.Quantity        <> p.QuantityOrg
 
                 )  

MERGE INTO tUnloadRefusals t
USING (
    SELECT
        OperDate,
        FileName,
        OrderNum,
        MakeLogo,
        DetailNumber,
        Reference,
        DetailID,
        Quantity,
        PricePurchase,
        AmountPurchase,
        ClientID,
        ClientName
   FROM #UnloadRefusals WITH (NOLOCK)
) s
ON (
        t.OrderNum     = s.OrderNum
    AND t.MakeLogo     = s.MakeLogo
    AND t.DetailNumber = s.DetailNumber
    AND t.Reference    = s.Reference
    AND t.DetailID     = s.DetailID
)

-- Обновление существующих записей
WHEN MATCHED THEN
    UPDATE SET
        t.OperDate = s.OperDate,
        t.FileName = s.FileName,
        t.Quantity = s.Quantity
    -- t.PricePurchase = s.PricePurchase,
    -- t.AmountPurchase = s.AmountPurchase,
    -- t.ClientID = s.ClientID,
    -- t.ClientName = s.ClientName

-- Вставка новых записей
WHEN NOT MATCHED BY TARGET THEN
 INSERT (
        OperDate,
        FileName,
        OrderNum,
        MakeLogo,
        DetailNumber,
        Reference,
        DetailID,
        Quantity,
        PricePurchase,
        AmountPurchase,
        ClientID,
        ClientName
 )
 VALUES (
        s.OperDate,
        s.FileName,
        s.OrderNum,
        s.MakeLogo,
        s.DetailNumber,
        s.Reference,
        s.DetailID,
        s.Quantity,
        s.PricePurchase,
        s.AmountPurchase,
        s.ClientID,
        s.ClientName
  );
     
 --*/
 exit_:
 return 0
go
grant exec on OrderRefusalsCalc_Automatic to public
go
exec setOV 'OrderRefusalsCalc_Automatic', 'P', '20250530', '0'
go
 