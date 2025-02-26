if OBJECT_ID('SupplierDeliveryProfilesDetele') is not null
    drop proc SupplierDeliveryProfilesDetele
/*
  SupplierDeliveryProfilesDetele - 
  @ID - 

*/
go
create proc SupplierDeliveryProfilesDetele
              @ID    numeric(18, 0)  
as
  set nocount on
  declare @r int

  select @R         = 0

  if exists (select 1 
               from pSupplierDeliveryProfiles p (nolock)
              inner join tProfilesCustomer pc (nolock)
                      on pc.ProfilesDeliveryID = p.ProfilesDeliveryID
              where p.ID = @ID)
  begin
    Select @r= 202 -- Удаление запрещено, профиль доставки используется в справочнике "Клиенты"!
    goto exit_
  end

  delete pSupplierDeliveryProfiles  
    from pSupplierDeliveryProfiles (rowlock)
   where ID = @ID


exit_:
return @r
go
grant exec on SupplierDeliveryProfilesDetele to public
go
exec setOV 'SupplierDeliveryProfilesDetele', 'P', '20250226', '0'
go