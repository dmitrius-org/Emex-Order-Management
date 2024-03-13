if OBJECT_ID('ClientUpdate') is not null
    drop proc ClientUpdate
/*
  ClientUpdate - изменение данных клиента
*/
go
create proc ClientUpdate
              @ClientID             numeric(18,0)  --  
             ,@Brief                nvarchar(512)  --
             ,@Name	                nvarchar(512)  -- 
			 ,@SuppliersID          numeric(18,0)=null--поставщик
			 ,@IsActive             bit
			 ,@Taxes                money
             ,@ResponseType         int          -- Тип ответа
             ,@NotificationMethod   int          -- Способ оповещения
             ,@NotificationAddress  nvarchar(256)-- Адрес оповещения
             ,@ClientTypeID	        int         =null
            -- ,@Margin               money       =null -- Наценка в процентах
            -- ,@Reliability          money       =null -- Вероятность поставки 
            -- ,@Discount             money       =null -- Скидка Discount - Скидка поставщика на закупку товара
            -- ,@Commission           money       =null -- Комиссия эквайера 

as
  declare @r int = 0

  if exists (select 1 
               from tClients (nolock)
              where Brief     = @Brief
                and ClientID <> @ClientID)
  begin
    set @r = 100 -- 'Клиент с заданным наименование существует'
    goto exit_
  end

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran

	    Update tClients
		   set Brief               = @Brief
		   	  ,Name                = @Name
		      ,SuppliersID         = @SuppliersID
		      ,IsActive            = @IsActive 
			  ,updDatetime         = GetDate()
			  ,Taxes               = @Taxes
              ,ResponseType        = @ResponseType
              ,NotificationMethod  = @NotificationMethod
              ,NotificationAddress = @NotificationAddress
              ,ClientTypeID        = @ClientTypeID
             -- ,Margin              = nullif(@Margin      , -1) 
             -- ,Reliability         = nullif(@Reliability , -1) 
             -- ,Discount            = nullif(@Discount    , -1) 
             -- ,Commission          = nullif(@Commission  , -1) 
		  from tClients (rowlock)
	     where ClientID     = @ClientID 

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
      insert tRetMessage(RetCode, Message) select @r,  ERROR_MESSAGE()  

      goto exit_     
  END CATCH  

      
  exit_:
return @r
go
grant exec on ClientUpdate to public
go
exec setOV 'ClientUpdate', 'P', '20240101', '0'
go
