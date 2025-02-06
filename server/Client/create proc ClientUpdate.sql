if OBJECT_ID('ClientUpdate') is not null
    drop proc ClientUpdate
/*
  ClientUpdate - изменение данных клиента
*/
go
create proc ClientUpdate
              @ClientID               numeric(18,0)  --  
             ,@Brief                  nvarchar(256)  --
             ,@Name	                  nvarchar(512)  -- 
			 ,@SuppliersID            numeric(18,0)=null--поставщик
			 ,@IsActive               bit
			 ,@Taxes                  money
             ,@ResponseType           int          -- Тип ответа
             ,@NotificationMethod     int          -- Способ оповещения
             ,@NotificationAddress    nvarchar(256)-- Адрес оповещения
             ,@ClientTypeID	          int            = null
             ,@StatusRequiringPayment varchar(256) = null
             ,@Email	              nvarchar(256)= null
             ,@Phone                  varchar(32)  = null
             ,@ContactPerson          varchar(256) = null

as
  declare @r int = 0
  --declare   

  if exists (select 1 
               from tClients (nolock)
              where Brief     = @Brief
                and ClientID <> @ClientID)
  begin
    set @r = 100 -- 'Клиент с заданным наименованием существует'
    goto exit_
  end

  if @Email is not null
     and
     exists (select 1 
               from tClients (nolock)
              where Email     = @Email
                and ClientID <> @ClientID)
  begin
    set @r = 102 --В системе уже зарегистрирован клиент с заданной почтой!
    goto exit_
  end

  BEGIN TRY 
      delete tRetMessage from tRetMessage with (rowlock index=ao1) where spid=@@spid
      Begin tran 

      --Статусы требующие предоплаты
      SELECT @StatusRequiringPayment = STRING_AGG(n.SearchID, ';') WITHIN GROUP (ORDER BY n.SearchID ASC) 
        FROM ( 
              SELECT DISTINCT n.SearchID 
                FROM STRING_SPLIT(@StatusRequiringPayment, ';') AS p
               INNER JOIN tNodes n WITH (NOLOCK)
                  ON n.Type = 0 
                 AND n.SearchBrief = RTRIM(LTRIM(p.value))  -- Убираем возможные пробелы
                 AND n.SearchID <> 8
             ) AS n;

	    Update tClients
		   set Brief                  = @Brief
		   	  ,Name                   = @Name
		      ,SuppliersID            = @SuppliersID
		      ,IsActive               = @IsActive 
			  ,updDatetime            = GetDate()
			  ,Taxes                  = @Taxes
              ,ResponseType           = @ResponseType
              ,NotificationMethod     = @NotificationMethod
              ,NotificationAddress    = @NotificationAddress
              ,ClientTypeID           = @ClientTypeID
              ,StatusRequiringPayment = @StatusRequiringPayment
              ,Phone                  = @Phone         
              ,ContactPerson          = @ContactPerson
              ,Email                  = @Email
		  from tClients with (rowlock index=PK_tClients_ClientID)
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

        exec RestCalc 
               @ClientID = @ClientID
		
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
grant exec on ClientUpdate to public
go
exec setOV 'ClientUpdate', 'P', '20240205', '4'
go
