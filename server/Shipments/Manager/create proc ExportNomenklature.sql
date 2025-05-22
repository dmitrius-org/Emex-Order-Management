if OBJECT_ID('ExportNomenklature') is not null
    drop proc ExportNomenklature
/*
  ExportNomenklature - 


*/
go

Create proc ExportNomenklature  
              @Invoice nvarchar(128)
as
  set nocount on;
  declare @r int = 0

select o.OrderID
      ,o.Manufacturer
      ,o.DetailNumber
      ,ltrim(rtrim(Replace( case 
                              when coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) in ('Автодеталь', 'Автозапчасть', 'Деталь', 'Запчасть')
                              then p.DetailName
                              else coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) 
                            end  
                           ,o.[DetailNumber]  
                           ,'')))    as DetailName
      ,o.DetailNumber + ' ' + ltrim(rtrim(Replace( case 
                                                     when coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) in ('Автодеталь', 'Автозапчасть', 'Деталь', 'Запчасть')
                                                     then p.DetailName
                                                     else coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) 
                                                   end  
                                                  ,o.[DetailNumber]  
                                                  ,'')))    as DetailNumberDetailName
      ,o.Manufacturer + ' ' + o.DetailNumber ManufacturerDetailNumber
      ,coalesce(p.WeightKGF, o.WeightKG, 0) WeightKGF
      ,case 
         when isnull(o.ReplacementMakeLogo, '') = '' then o.OrderDetailSubId 
         else ''
       end as BarCode
      ,c.Brief + ' ' + o.Invoice ClientBrief
  from tOrders o with (nolock index=ao3)
 inner join tClients c with (nolock index=ao1)
         on c.ClientID = o.ClientID
  left join vPrice p 
         on p.PriceID = o.PriceID	
  --left join tPrice p with (nolock index=PK_tPrice_ID)
  --       on p.PriceID = o.PriceID	
  --left join tParts pt with (nolock index=PK_tParts_ID)
  --       on pt.PartID = p.PartID
 where o.Invoice = @Invoice
 -- and o.OrderID= 133499
 union all
select o.OrderID
      ,m.Name
      ,o.ReplacementDetailNumber
      ,ltrim(rtrim(Replace( case 
                              when coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) in ('Автодеталь', 'Автозапчасть', 'Деталь', 'Запчасть')
                              then p.DetailName
                              else coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) 
                            end  
                           ,o.[DetailNumber]  
                           ,'')))
      ,o.ReplacementDetailNumber + ' ' + ltrim(rtrim(Replace( case 
                                                                when coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) in ('Автодеталь', 'Автозапчасть', 'Деталь', 'Запчасть')
                                                                then p.DetailName
                                                                else coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) 
                                                              end  
                                                             ,o.[DetailNumber]  
                                                             ,'')))
      ,m.Name + ' ' + o.ReplacementDetailNumber
      ,coalesce(p.WeightKGF, o.WeightKG, 0) WeightKGF
      ,o.OrderDetailSubId    as BarCode
      ,c.Brief + ' ' + o.Invoice ClientBrief
  from tOrders o with (nolock index=ao3)
 inner join tClients c with (nolock index=ao1)
         on c.ClientID = o.ClientID
  left join vPrice p 
         on p.PriceID = o.PriceID	
  --left join tPrice p with (nolock index=PK_tPrice_ID)
  --       on p.PriceID = o.PriceID	
  --left join tParts pt with (nolock index=PK_tParts_ID)
  --       on pt.PartID = p.PartID
 inner join tMakes m (nolock)
         on m.Code = o.ReplacementMakeLogo
 where o.Invoice = @Invoice 
    --and o.OrderID= 133499
   and isnull(o.ReplacementMakeLogo, '') <> ''

order by ClientBrief, OrderID

exit_:

return @r
GO
grant exec on ExportNomenklature to public
go
exec setOV 'ExportNomenklature', 'P', '20250531', '5'
go

exec ExportNomenklature @Invoice = '240126'