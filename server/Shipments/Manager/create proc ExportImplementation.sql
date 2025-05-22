if OBJECT_ID('ExportImplementation') is not null
    drop proc ExportImplementation
/*
  ExportImplementation - 

  Производитель (фактически поставленной детали)	
  Номер детали (фактически поставленной детали)	
  Производитель + Номер детали (фактически поставленной детали)
  Номер детали + Наименование детали (фактически поставленной детали)	
  Производитель замены + Номер детали замены (первично заказанной детали)	
  SubID
  Количество	
  Цена закупки руб	
  Сумма закупки руб

*/
go

Create proc ExportImplementation  
              @Invoice nvarchar(128)
as
    set nocount on;
    declare @r int = 0

    select o.OrderID
          ,c.Brief ClientBrief
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
          ,o.Price  PricePurchase  
          ,o.Amount AmountPurchase
          ,SUBSTRING(pr.Comment, CHARINDEX('box:', pr.Comment) + 4, LEN(pr.Comment) - CHARINDEX('box:', pr.Comment) +5) as Box
      from tOrders o with (nolock)
     inner join tClients c (nolock)
             on c.ClientID = o.ClientID     
     left join vPrice p 
            on p.PriceID = o.PriceID	
  --left join tPrice p with (nolock index=PK_tPrice_ID)
  --       on p.PriceID = o.PriceID	
  --left join tParts pt with (nolock index=PK_tParts_ID)
  --       on pt.PartID = p.PartID
      left join tMakes m (nolock)
             on m.Code = o.ReplacementMakeLogo

    outer apply (select top 1 *
                   from tProtocol p (nolock)
                  where p.ObjectID = o.OrderID
                    and p.NewStateID = 8 -- отправлено
                  order by p.ProtocolID desc
                 ) as pr

          
     where o.Invoice = @Invoice

     order by c.Brief, o.OrderID, Box

exit_:

return @r
GO
grant exec on ExportImplementation to public
go
exec setOV 'ExportImplementation', 'P', '20250531', '3'
go

exec ExportImplementation @Invoice = '239771'
