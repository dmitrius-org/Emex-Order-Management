if OBJECT_ID('OrderF_GetEditData') is not null
    drop proc OrderF_GetEditData
/*
  OrderF_GetEditData -
*/
go
create proc OrderF_GetEditData
              @Make               nvarchar(32)
             ,@DetailNum          nvarchar(32)
             ,@PriceLogo          nvarchar(32)
             ,@ProfilesDeliveryID numeric(18,0) 
as
  select top 1 
         p.*,
         case
           when p.Available = -1 then 'под заказ'
           else cast(p.Available as nvarchar)
         end as AvailableStr -- наличие детали на складе
        ,f.MarginF
        ,f.IncomePrc
        ,f.Profit
        ,cpp.DeliveryTermFromSupplier -- Срок доставки с профиля доставки поставщика
    from pFindByNumber p with (nolock index= ao3)
   inner join pOrdersFin f with (nolock index= ao1)
           on f.Spid  = @@spid 
          and f.ID    = p.ID
   inner join vSupplierDeliveryParam cpp
           on cpp.ProfilesDeliveryID      = @ProfilesDeliveryID
          and cpp.SupplierProfileIsActive = 1
   where p.Spid      = @@spid
     and p.Make      = @Make
     and p.DetailNum = @DetailNum
     and p.PriceLogo = @PriceLogo
   order by p.PercentSupped desc
go
  grant exec on OrderF_GetEditData to public
go
exec setOV 'OrderF_GetEditData', 'P', '20250320', '8'
go
 
 