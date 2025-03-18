if OBJECT_ID('OrdersFragile') is not null
    drop proc OrdersFragile
/*
  OrdersFragile - 

  Производитель (фактически поставленной детали)	
  Номер детали (фактически поставленной детали)	
  Производитель + Номер детали (фактически поставленной детали)	
  Номер детали + Наименование детали (фактически поставленной детали)	
  Производитель замены + Номер детали замены (первично заказанной детали)	
  SubID
  Количество	
  Цена закупки Факт	
  Сумма закупки Факт

*/
go

Create proc OrdersFragile  
              @Suppliers     as ID READONLY
as
    set nocount on;
    declare @r int = 0

    select o.OrderID
          ,case 
             when isnull(o.ReplacementMakeLogo, '') <> '' 
             then cast(m.Name as nvarchar)
             else o.Manufacturer
           end Manufacturer
          ,case 
             when isnull(o.ReplacementMakeLogo, '') <> '' 
             then o.ReplacementDetailNumber
             else o.DetailNumber
           end  DetailNumber
          ,case 
             when isnull(o.ReplacementMakeLogo, '') <> '' 
             then cast(m.Name as nvarchar) + ' ' + o.ReplacementDetailNumber
             else o.Manufacturer + ' ' +  o.DetailNumber 
           end  ManufacturerDetailNumber
          ,case 
             when isnull(o.ReplacementMakeLogo, '') <> '' then o.ReplacementDetailNumber  + ' ' + ltrim(rtrim(Replace( case 
                                                                                                                         when coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) in ('Автодеталь', 'Автозапчасть', 'Деталь', 'Запчасть')
                                                                                                                         then p.DetailName
                                                                                                                         else coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) 
                                                                                                                       end  
                                                                                                                      ,o.[DetailNumber]  
                                                                                                                      ,'')))
             else o.DetailNumber  + ' ' + ltrim(rtrim(Replace( case 
                                                                 when coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) in ('Автодеталь', 'Автозапчасть', 'Деталь', 'Запчасть')
                                                                 then p.DetailName
                                                                 else coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) 
                                                               end  
                                                              ,o.[DetailNumber]  
                                                              ,'')))
           end  DetailNumberDetailName
          ,case 
             when isnull(o.ReplacementMakeLogo, '') <> '' then o.Manufacturer + ' ' + o.DetailNumber
             else null
           end RManufacturerDetailNumber
          ,o.CustomerSubId
          ,o.reference
          ,o.Quantity
          ,o.PricePurchaseF 
          ,o.AmountPurchaseF
          ,s.Brief SupplierBrief
      from tOrders o with (nolock)
      LEFT JOIN @Suppliers c
             ON o.SuppliersID = c.ID
     inner join tPrice p with (nolock index=ao1)
             on p.PriceID = o.PriceID
            and p.Fragile = 1
      left join tMakes m (nolock)
             on m.Code = o.ReplacementMakeLogo
     inner join tSuppliers s (nolock)
             on s.SuppliersID= o.SuppliersID  
     where o.StatusID in (6  --ReceivedOnStock	Получено на склад в ОАЭ
                         ,7  --ReadyToSend	Готово к отправке из ОАЭ
                         )
       AND (NOT EXISTS (SELECT 1 FROM @Suppliers) OR c.ID IS NOT NULL)
     order by o.OrderID


exit_:

return @r
GO
grant exec on OrdersFragile to public
go
exec setOV 'OrdersFragile', 'P', '20250313', '0'
go

exec OrdersFragile 