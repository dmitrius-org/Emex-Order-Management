if OBJECT_ID('SupplierInsert') is not null
    drop proc SupplierInsert
/*
  SupplierInsert - добавление 
*/
go
create proc SupplierInsert
              @SuppliersID          numeric(18,0) output --  
             ,@Brief                nvarchar(512)  --
             ,@Name	                nvarchar(1024)  -- 
			 ,@emexUsername         nvarchar(32)=null--Пользователь для интеграции
             ,@emexPassword         nvarchar(32)=null--Пароль для интеграции
             ,@Discount             money  
             ,@Commission           money  
             ,@ExtraKurs            money 
             ,@GroupName	        varchar(64 ) 
             ,@ApiAddress           varchar(256) = null 

as
  declare @r int = 0

  DECLARE @ID TABLE (ID numeric(18,0));

  if exists (select 1 
               from tSuppliers u (nolock)
              where u.Brief = @Brief)
  begin
    set @r = 200 -- 'Поставщик с заданным наименованием!'
    goto exit_
  end

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran

		insert into tSuppliers with (rowlock)
		      (
		       Brief
		      ,Name
		      ,emexUsername
		      ,emexPassword
              ,Discount  
              ,Commission
              ,ExtraKurs 
              ,GroupName
              ,ApiAddress
		       )
		OUTPUT INSERTED.SuppliersID INTO @ID
		select @Brief     
		      ,@Name	
		      ,@emexUsername
		      ,@emexPassword
              ,@Discount  
              ,@Commission
              ,@ExtraKurs 
              ,@GroupName
              ,@ApiAddress

		Select @SuppliersID = ID from @ID	
        
        exec @r = SupplierDeliveryProfilesLoad
                    @SuppliersID    = @SuppliersID
                   ,@Direction      = 1
		
		if @r <> 0
		begin 
		  RAISERROR (15600, 16, 1, @r);
		end

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
grant exec on SupplierInsert to public
go
exec setOV 'SupplierInsert', 'P', '20250613', '2'
go
