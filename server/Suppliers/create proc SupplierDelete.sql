if OBJECT_ID('SupplierDelete') is not null
    drop proc SupplierDelete
/*
  SupplierDelete - удаление поставщика
*/
go
create proc SupplierDelete
              @SuppliersID numeric(18,0)  
as
  declare @r int = 0

  if exists (select 1 
               from tClients с (nolock)
              where с.SuppliersID  = @SuppliersID
             )
  begin
    set @r = 201 -- 'Удаление запрещено, поставщик используется в справочнике "Клиенты"!'
    goto exit_
  end 

  if exists (select 1 
               from tOrders o (nolock)
              where o.SuppliersID  = @SuppliersID
             )
  begin
    set @r = 203 -- 'Удаление запрещено, поставщик используется в справочнике "Заказов"!'
    goto exit_
  end 

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran

        Delete tSupplierDeliveryProfiles
          from tSupplierDeliveryProfiles with (rowlock index=ao1)
         where SuppliersID  = @SuppliersID
 
        Delete tSuppliers
          from tSuppliers with (rowlock index=ao1)
         where SuppliersID  = @SuppliersID

      commit tran
  END TRY  
  BEGIN CATCH  
      if @@TRANCOUNT > 0
        rollback tran
    
      set @r = -1
      insert tRetMessage(RetCode, Message) select @r,  ERROR_MESSAGE()  

      goto exit_     
  END CATCH  
 
 exit_:
 return @r
go
grant exec on SupplierDelete to public
go
exec setOV 'SupplierDelete', 'P', '20250320', '1'
go
 