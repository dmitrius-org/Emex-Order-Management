if OBJECT_ID('ExportFragile') is not null
    drop proc ExportFragile
/*
  ExportAdmission - 

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

Create proc ExportFragile  
              @Invoice nvarchar(128)
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

      from tOrders o with (nolock)
     inner join vPrice p 
             on p.PriceID = o.PriceID	
            and p.Fragile = 1
      left join tMakes m (nolock)
             on m.Code = o.ReplacementMakeLogo
          
     where o.Invoice = @Invoice

     order by o.OrderID

exit_:

return @r
GO
grant exec on ExportFragile to public
go
exec setOV 'ExportFragile', 'P', '20250531', '3'
go

exec ExportFragile @Invoice = '243838'