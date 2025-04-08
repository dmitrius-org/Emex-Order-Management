if OBJECT_ID('ClientInsert') is not null
    drop proc ClientInsert
/*
  ClientInsert - добавление клиента
*/
go
create proc ClientInsert
              @ClientID               numeric(18,0) output --  
             ,@Brief                  nvarchar(256)  --
             ,@Name	                  nvarchar(1024)  -- 
			 ,@SuppliersID            numeric(18,0)=null--поставщик
			 ,@IsActive               bit
			 ,@Taxes                  money        -- налоги
             ,@ResponseType           int          -- Тип ответа
             ,@NotificationMethod     int          -- Способ оповещения
             ,@NotificationAddress    nvarchar(256)-- Адрес оповещения
             ,@ClientTypeID	          int          = null -- Тип клиента
             ,@StatusRequiringPayment varchar(256) = null
             ,@Email	              nvarchar(256)= null
             ,@Phone                  varchar(32)= null
             ,@ContactPerson          varchar(256) = null
             ,@NotificationScript     varchar(256) = null -- Скрипт оповещения
            -- ,@Margin               money       =null -- Наценка в процентах
            -- ,@Reliability          money       =null -- Вероятность поставки 
            -- ,@Discount             money       =null -- Скидка Discount - Скидка поставщика на закупку товара
           --  ,@Commission           money       =null -- Комиссия эквайера 

as
  declare @r int = 0

  DECLARE @ID TABLE (ID numeric(18,0));

  if exists (select 1 
               from tClients u (nolock)
              where u.Brief = @Brief)
  begin
    set @r = 100 -- 'Клиент с заданным наименование существует'
    goto exit_
  end

  BEGIN TRY 
      delete tRetMessage from tRetMessage with (rowlock index=ao1) where spid=@@spid
      Begin tran

		insert into tClients with (rowlock)
		      (
		       Brief
		      ,Name
		      ,SuppliersID
		      ,IsActive 
		      ,UserID
			  ,Taxes 
              ,ResponseType
              ,NotificationMethod
              ,NotificationAddress
              ,ClientTypeID	
              ,StatusRequiringPayment
              ,Phone       
              ,ContactPerson
              ,NotificationScript
		       )
		OUTPUT INSERTED.ClientID INTO @ID
		select @Brief     
		      ,@Name	
		      ,@SuppliersID
		      ,@IsActive
		      ,dbo.GetUserID()	
			  ,@Taxes -- налоги %
              ,@ResponseType
              ,@NotificationMethod
              ,@NotificationAddress
              ,@ClientTypeID
              ,@StatusRequiringPayment
              ,@Phone
              ,@ContactPerson
              ,@NotificationScript

		Select @ClientID = ID from @ID	    
 
	    exec @r=OrderFileFormat_load 
		          @ClientID  = @ClientID,
			      @Direction = 1

        if @r = 0
          exec @r=EmployeeReliationload
                    @ClientID  = @ClientID 
                   ,@Direction = 1  

        if @r = 0
          exec @r=ProfilesCustomerLoad
                    @ClientID  = @ClientID 
                   ,@Direction = 1  
		
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
      insert tRetMessage with (rowlock) (RetCode, Message) select @r,  ERROR_MESSAGE()  

      goto exit_     
  END CATCH  



exit_:
return @r
go
grant exec on ClientInsert to public
go
exec setOV 'ClientInsert', 'P', '20250408', '4'
go

