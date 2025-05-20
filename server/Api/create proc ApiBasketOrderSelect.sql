if OBJECT_ID('ApiBasketOrderSelect') is not null
    drop proc ApiBasketOrderSelect
go
/* **********************************************************						
ApiBasketOrderSelect - получение списка заказов
********************************************************** */

create proc ApiBasketOrderSelect
               @ClientID numeric(18, 0)
              ,@OrderNum SID readonly
as

SELECT o.OrderID
      ,@ClientID                                      ClientID
      ,num.Name                                       OrderNum
      ,iif(o.OrderNum is null, 0, 1)                  Status
      ,Count(*) over(partition by o.ClientID, o.OrderNum)         PositionsQuantity
      ,Sum(Amount) over(partition by o.ClientID, o.OrderNum)      TotalSum
      ,o.OrderDate             OrderDate
      ,o.PriceLogo + '-' + cast(o.ProfilesCustomerID as varchar) as supplierCode -- Идентификатор поставщика (ID склада)
      ,o.Manufacturer          Brand
      ,o.DetailNumber          DetailNumber
      ,o.DetailName            DetailName
      ,o.Quantity              Quantity
      ,o.Price                 Price
      ,o.Amount                Amount
      ,o.itemKey               itemKey
      ,o.Comment2              Comment2 -- комментарий к позиции
      ,o.Comment3              Comment3 -- комментарий к заказу
      ,n.NodeID                StatusId
      ,n.SearchBrief           StatusCode
      ,o.Reference
      ,oс.DeliveryDateToCustomer  -- Дата поставки клиенту после изменения
      ,oс.DeliveryTermToCustomer  -- Срок поставки клиенту после изменения
      ,p.OperDate              StatusDate
  FROM @OrderNum num
  left join tOrders o with (nolock index=ao2)
         on o.ClientID = @ClientID
        and o.OrderNum = num.Name

  left join tNodes n with (nolock index=ao1)
         on n.NodeID = o.StatusID  
  --left join tMakes b with (nolock index=ao2) -- брент замены
  --       on cast(b.Code as nvarchar)= o.ReplacementMakeLogo
 left join vOrdersDeliveryCustomer oс -- актуальные сроки доставки клиента
         on oс.OrderID = o.OrderID
 outer apply (select top 1 *
                from tProtocol p with (nolock index=ao2)
               where p.ObjectID = o.OrderID
                 and p.NewStateID = o.StatusID
               order by p.InDateTime desc 
              ) p


go
grant exec on ApiBasketOrderSelect to public
go
exec setOV 'ApiBasketOrderSelect', 'P', '20250423', '1'
go

DECLARE @OrderNums as sID
                    
INSERT INTO @OrderNums (Name)
SELECT value
    FROM STRING_SPLIT('15,номер6', ',');

exec ApiBasketOrderSelect 
       @ClientID = 57
      ,@OrderNum =@OrderNums
