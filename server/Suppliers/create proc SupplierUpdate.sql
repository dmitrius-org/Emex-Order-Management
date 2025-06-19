if OBJECT_ID('SupplierUpdate') is not null
    drop proc SupplierUpdate
/*
  SupplierUpdate - изменение данных поставщика
*/
go
create proc SupplierUpdate
              @SuppliersID          numeric(18,0) --  
             ,@Brief                nvarchar(512) --
             ,@Name                 nvarchar(1024)-- 
             ,@emexUsername         nvarchar(32)=null--Пользователь для интеграции
             ,@emexPassword         nvarchar(32)=null--Пароль для интеграции
             ,@Discount             money  
             ,@Commission           money  
             ,@ExtraKurs            money 
             ,@GroupName	        varchar(64 ) 
             ,@ApiAddress           varchar(256) = null 
as
  declare @r int = 0

  if exists (select 1 
               from tSuppliers (nolock)
              where Brief        = @Brief
                and SuppliersID <> @SuppliersID)
  begin
    set @r = 200 -- 'Поставщик с заданным наименованием!'
    goto exit_
  end

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran

        exec @r = SupplierDeliveryProfilesLoad
                    @SuppliersID    = @SuppliersID
                   ,@Direction      = 1

        if @r <> 0
        begin 
          RAISERROR (15600, 16, 1, @r);
        end

        exec @r = SupplierPricesLoad
                    @SuppliersID    = @SuppliersID
                   ,@Direction      = 1
        
        if @r <> 0
        begin 
          RAISERROR (15600, 16, 1, @r);
        end

        Update tSuppliers
           set Brief                = @Brief
              ,Name                 = @Name
              ,emexUsername         = @emexUsername
              ,emexPassword         = @emexPassword
              ,Discount             = @Discount    
              ,Commission           = @Commission  
              ,ExtraKurs            = @ExtraKurs 
              ,GroupName            = @GroupName
              ,ApiAddress           = @ApiAddress
          from tSuppliers (rowlock)
         where SuppliersID     = @SuppliersID

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
grant exec on SupplierUpdate to public
go
exec setOV 'SupplierUpdate', 'P', '20250618', '3'
go