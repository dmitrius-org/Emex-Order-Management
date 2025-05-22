if OBJECT_ID('ExportImplementationByClient') is not null
    drop proc ExportImplementationByClient
/*
  ExportImplementationByClient - 

1 Клиент	
2 Производитель	
3 Номер детали	
4 Производитель (замены)	
5 Номер детали (замены)	
6 Наименование	
7 Количество	
8 Цена закупки руб	
9 Сумма закупки руб	
10 reference	
11 SubID	
12 Штрихкод	
13 Коробка

*/
go

Create proc ExportImplementationByClient  
              @Invoice  nvarchar(128)
             ,@ClientID numeric(18, 0)
as
    set nocount on;
    declare @r int = 0

  -- test !!!
  if @ClientID in (57)
    select @ClientID= 39

    select o.OrderID
          ,c.Brief ClientBrief --1
          ,o.Manufacturer      --2 
          ,o.DetailNumber      --3
          ,cast(m.Name as nvarchar)  RManufacturer
          ,o.ReplacementDetailNumber RDetailNumber
          ,case 
             when isnull(o.ReplacementMakeLogo, '') <> '' then o.ReplacementDetailNumber  + ' ' + ltrim(rtrim(Replace( case 
                                                            when coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) in ('Автодеталь', 'Автозапчасть', 'Деталь', 'Запчасть')
                                                            then p.DetailName
                                                            else coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) 
                                                          end  
                                                         ,o.[DetailNumber]  
                                                         ,'')))
             else ltrim(rtrim(Replace( case 
                                         when coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) in ('Автодеталь', 'Автозапчасть', 'Деталь', 'Запчасть')
                                         then p.DetailName
                                         else coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) 
                                       end  
                                      ,o.[DetailNumber]  
                                      ,'')))
           end  DetailName --6
          ,o.Quantity
          ,o.Price  PricePurchase  
          ,o.Amount AmountPurchase
          ,o.reference
          ,o.CustomerSubId
          ,o.OrderDetailSubId
          ,SUBSTRING(pr.Comment, CHARINDEX('box:', pr.Comment) + 4, LEN(pr.Comment) - CHARINDEX('box:', pr.Comment) +5) as Box
      from tOrders o with (nolock)
     inner join tClients c (nolock)
             on c.ClientID = o.ClientID     
      left join vPrice p 
             on p.PriceID = o.PriceID 
      left join tMakes m (nolock)
             on m.Code = o.ReplacementMakeLogo

    outer apply (select top 1 *
                   from tProtocol p (nolock)
                  where p.ObjectID = o.OrderID
                    and p.NewStateID = 8 -- отправлено
                  order by p.ProtocolID desc
                 ) as pr

          
     where o.ClientID = @ClientID
       and o.Invoice  = @Invoice

     order by c.Brief, o.OrderID, Box

exit_:

return @r
GO
grant exec on ExportImplementationByClient to public
go
exec setOV 'ExportImplementationByClient', 'P', '20250531', '3'
go

exec ExportImplementationByClient @Invoice = '241329', @ClientID = 57
