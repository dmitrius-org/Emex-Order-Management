if OBJECT_ID('EmexOrderStatusParser') is not null
    drop proc EmexOrderStatusParser
/*
  EmexOrderStatusParser - Синронизация статусов с emex
*/
go
create proc EmexOrderStatusParser
as

set nocount on;

declare @r     int 

delete pMovementOur from pMovementOur (rowlock) where spid = @@spid

-- пронумеруем по
Update pMovement -- 
   set pMovement.N = p.N
      ,pMovement.RowCounts = p.C
  from (Select ID,
               ROW_NUMBER() over(partition by OrderNumber, DetailNum, CustomerSubId, Reference order by StatusID, ID) N,
               Count(*) over(partition by OrderNumber, DetailNum, CustomerSubId, Reference) C
          from pMovement (nolock)
         where Spid = @@Spid
        ) p
  where p.ID = pMovement.ID

;with GroupedMovement as (
   select 
          m.OrderNumber,
          m.DetailNum,
          m.CustomerSubId,
          m.Reference
     from pMovement m with (nolock)
    where m.Spid = @@spid
    group by 
            m.OrderNumber,
            m.DetailNum,
            m.CustomerSubId,
            m.Reference
)

insert into pMovementOur 
      (Spid,
       OrderID,
       OrderNumber,            
       OrderDetailSubId,       
       DocumentDate,           
       PriceOrdered,           
       PriceSale,              
       MakeLogo,               
       DetailNum,              
       Quantity,               
       Condition,              
       Reference,              
       DetailNameRus,          
       DetailNameEng,          
       CustomerSubId,          
       DestinationLogo,        
       PriceLogo,              
       ReplacementMakeLogo,    
       ReplacementDetailNumber,
       StatusId,               
       StateText,
       RowCounts,
       TotalQuantity
       )
select 
       @@Spid,
       o.OrderID,
       gm.OrderNumber,            
       o.OrderDetailSubId,       
       p.OperDate, -- DocumentDate           
       0,           -- PriceOrdered           
       0,           -- PriceSale              
       o.MakeLogo,               
       o.DetailNumber,              
       o.Quantity,               
       n.EID,        -- Condition
       o.Reference,               
       '',           -- DetailNameRus          
       '',           -- DetailNameEng          
       o.CustomerSubId,          
       o.DestinationLogo,        
       o.PriceLogo,              
       o.ReplacementMakeLogo,    
       o.ReplacementDetailNumber,
       n.EID,        -- StatusId               
       n.Brief,      -- StateText
       Count(*) over(partition by o.EmexOrderID, o.DetailNumber, o.CustomerSubId, o.Reference), 
       Sum(o.Quantity) over(partition by o.EmexOrderID, o.DetailNumber, o.CustomerSubId, o.Reference) 
from GroupedMovement gm

inner join tOrders o with (nolock)
        on o.EmexOrderID    = gm.OrderNumber
       and o.DetailNumber   = gm.DetailNum
       and o.CustomerSubId  = gm.CustomerSubId
       and o.Reference      = gm.Reference

cross apply (
    select top 1 *
      from tProtocol p with (nolock index=ao2)
     where p.ObjectID   = o.OrderID
       and p.NewStateID = o.StatusID
     order by p.InDateTime desc
) p

inner join tNodes n with (nolock)
        on n.NodeID = p.NewStateID

-- 1. По идентификатору OrderDetailSubId
Update p
   set p.OrderID = o.OrderID
      ,p.Tag     = 1 
  from pMovement p with (updlock) 
 cross apply (select top 1 *
                from pMovementOur m with (nolock) 
               where m.Spid             = @@SPID
                 and m.OrderNumber      = p.OrderNumber
                 and m.OrderDetailSubId = p.OrderDetailSubId
                 and p.OrderDetailSubId<> ''
             --  order by o.StatusID -- есть состояние "Возвращено" у котрого такой-же OrderDetailSubId
              ) o 
where p.Spid = @@SPID
  and p.OrderDetailSubId<> ''
  and p.OrderID is null
  --and SUBSTRING(p.OrderDetailSubId, 1,1) = '!'

-- 2. Ситуация когда количество и статус совпадают
Update p
   set p.OrderID = o.OrderID
      ,p.Tag     = 2 
  from pMovement p with (updlock) 
 cross apply (select top 1 *
                from pMovementOur m with (nolock) 
               where m.Spid          = @@SPID
                 and m.OrderNumber   = p.OrderNumber
                 AND m.DetailNum     = p.DetailNum
                 AND m.CustomerSubId = p.CustomerSubId
                 AND m.Reference     = p.Reference

                 and m.Condition     = p.Condition
                 and m.Quantity      = p.Quantity
               
               order by  
                        case 
                          when m.DocumentDate=p.DocumentDate then 0 else 1 -- на случай, если несколько позиций одним и тое же состоянием и количеством
                        end

              ) o 
where p.Spid = @@SPID
  and p.OrderID is null

-- данные заказы не трогаем, т.к. они в статусах которые не синхранизируюся
Update p
   set p.Flag = isnull(p.Flag, 0)|1
  from pMovement p with (updlock) 
 inner join pMovementOur m with (nolock) 
         on m.OrderID  = p.OrderID
        AND (m.StatusId is NULL
          or m.Condition = p.Condition) 
where p.Spid = @@SPID

declare @N int 
--объявляем курсор
DECLARE my_cur CURSOR FOR 
 SELECT distinct N
   FROM pMovement (nolock)
  where spid = @@spid
    and isnull(Flag, 0)&1 = 0
  order by N

--открываем курсор
OPEN my_cur
--считываем данные первой строки в наши переменные
FETCH NEXT FROM my_cur INTO @N
--если данные в курсоре есть, то заходим в цикл
--и крутимся там до тех пор, пока не закончатся строки в курсоре
WHILE @@FETCH_STATUS = 0
BEGIN

    Update p
       set p.OrderID = o.OrderID
          ,p.Tag     = 3 
      from pMovement p with (updlock) 
     cross apply (select top 1 *
                    from pMovementOur m with (nolock) 
                   where m.Spid          = @@SPID
                     and m.OrderNumber   = p.OrderNumber
                     AND m.DetailNum     = p.DetailNum
                     AND m.CustomerSubId = p.CustomerSubId
                     AND m.Reference     = p.Reference
                   order by --m.Condition
                           --,m.DocumentDate desc
                          --  case when m.Condition    < p.Condition    then 0 else 1 end
                            case when m.Condition    = p.Condition    then 0 else 1 end
                           ,m.Condition
                            --case when p.Quantity         = o.Quantity         then 0 else 1 
                           ,case when m.DocumentDate = p.DocumentDate then 0 else 1 end
                           ,m.DocumentDate desc
                           --,case when m.DocumentDate < p.DocumentDate then 0 else 1 end 
                            --case when p.Quantity         = o.Quantity         then 0 else 1 
                        
                            
                               --  case when p.PriceLogo        = o.PriceLogo         then 0 else 1 end
                       --         ,case 
                       --            when n.NodeID = o.StatusID then 0 
                       --            when n.EID = 6 /*НЕТ В НАЛИЧИИ*/ then
                       --                   case 
                       --                     when nn.EID = 1 /* InWork        	В работе*/            then 2
                       --                     when nn.EID = 2 /* Purchased	    Закуплено*/           then 20
                       --                     when nn.EID = 3 /* ReceivedOnStock	Получено на склад*/   then 30
                       --                     when nn.EID = 4 /* ReadyToSend	    Готово к выдаче*/     then 40
                       --                     when nn.EID = 5 /* Sent             Отправлено*/          then 50
                       --                     when nn.EID = 6 /* NOT AVAILABLE	НЕТ В НАЛИЧИИ*/       then 1
                       --                     --when nn.EID = 0 /**/ 	                                  then 
                       --                     when nn.EID = 7 /* AGREE	Изменение цены*/              then 70
                       --                     else 99 -- закуплено в последнюю очередь                  
                       --                   end
                       --            else 1 
                       --          end
                       --         ,case when p.Quantity         = o.Quantity         then 0 else 1 end -- ??
                       --         ,case when p.MakeLogo         = o.MakeLogo         then 0 else 1 end -- ??
                       --         ,case when nn.EID            <= p.StatusId         then 0 else 1 end
                               -- ,nn.EID desc
                    ) o  
                    -- and m.Condition     = p.Condition
                    -- and m.Quantity      = p.Quantity
        
    where p.Spid = @@SPID
      and p.OrderID is null
      and p.N = @N

    -- 3. Отказались от детали
    Update p
       set p.Tag     = 4
          ,p.Flag    = isnull(p.Flag, 0)|2
      from pMovement p with (updlock) 
     inner join pMovementOur m with (nolock) 
             on m.Spid      = @@SPID
            and m.OrderID   = p.OrderID
            and m.RowCounts > p.RowCounts
    where p.Spid      = @@SPID
      and p.Condition = 6 -- NOT AVAILABLE
      and p.RowCounts = 1

    exec CloneOrders @N = @N -- разбиение заказа

     --считываем следующую строку курсора
     FETCH NEXT FROM my_cur INTO @N
END

--закрываем курсор
CLOSE my_cur
DEALLOCATE my_cur

-- ситуация когда деталь разделисась, а после на все пришел отказ одной строкой 
declare @Archiving ID
insert @Archiving (ID)
select distinct
       m2.OrderID
  from pMovement p with (updlock) 
 inner join pMovementOur m2 with (nolock) 
         on m2.Spid          = @@SPID
        and m2.OrderNumber   = p.OrderNumber
        AND m2.DetailNum     = p.DetailNum
        AND m2.CustomerSubId = p.CustomerSubId
        AND m2.Reference     = p.Reference

        and m2.OrderID      <> p.OrderID

where p.Spid   = @@SPID
  and p.Flag&2 = 2

exec OrderArchiving
      @OrderID = @Archiving

select 'Для удаления', *
  from @Archiving A
 inner join tOrders o (rowlock)
         on o.OrderID = a.ID

delete o
  from @Archiving A
 inner join tOrders o (rowlock)
         on o.OrderID = a.ID

  -- помечаем строки в которых изменилось количество и нет строк для разбиения, т.е. наоборот нужно строки собрать
  --Update p
  --   set p.Flag    = isnull(p.Flag, 0)|8 
  --  FROM pMovement p (updlock)
  -- where p.spid = @@spid
  --   --and p.Flag&4>0
  --   and not exists (select 1
  --                     from pMovement pp (nolock)
  --                    where pp.spid = @@spid
  --                      and pp.CustomerSubId = pp.CustomerSubId
  --                      and pp.OrderID is null
  --                   )

 exit_:
 return @r
go
grant exec on EmexOrderStatusParser to public
go
exec setOV 'EmexOrderStatusParser', 'P', '20250619', '0'
go
 
