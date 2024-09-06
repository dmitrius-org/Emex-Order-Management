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
  from tOrders o with (nolock)
  left join tPrice p with (nolock index=ao1)
         on p.PriceID = o.PriceID 
 where o.Invoice = @Invoice
 -- and o.OrderID= 133499
 union all
select o.OrderID
      ,m.Name
      ,o.ReplacementDetailNumber
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
  from tOrders o with (nolock)
  left join tPrice p with (nolock index=ao1)
         on p.PriceID = o.PriceID 
 inner join tMakes m (nolock)
         on m.Code = o.ReplacementMakeLogo
 where o.Invoice = @Invoice 
    --and o.OrderID= 133499
   and isnull(o.ReplacementMakeLogo, '') <> ''

order by OrderID

exit_:

return @r
GO
grant exec on ExportNomenklature to public
go
exec setOV 'ExportNomenklature', 'P', '20240819', '2'
go

exec ExportNomenklature @Invoice = '240126'