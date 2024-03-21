if OBJECT_ID('ClientRegistrationRequest') is not null
    drop proc ClientRegistrationRequest
go
if OBJECT_ID('CustomerRegistrationRequest') is not null
    drop proc CustomerRegistrationRequest
/*
  CustomerRegistrationRequest - запрос на регистрацию клиента
                            - 
*/
go
create proc CustomerRegistrationRequest
              @ClientID  numeric(18,0) output -- 
			 ,@Hash      nvarchar(512) output
			 ,@Email     nvarchar(64)
             ,@Password  nvarchar(64)
as
  declare @r              int = 0
         ,@IsConfirmed    bit 
         ,@ClientTypeID   numeric(18,0)

  select @ClientTypeID  = 1 -- тип клиента 

  DECLARE @ID TABLE (ID numeric(18,0));
  delete tRetMessage from tRetMessage (rowlock) where spid=@@spid

  if exists (select 1 
               from tClients u (nolock)
              where u.Email = @Email)
  begin

    Select @ClientID    = ClientID 
	      ,@IsConfirmed = IsConfirmed
	  from tClients (nolock)
     where Email = @Email	

    if isnull(@IsConfirmed, 0) = 1
	begin
	  select @r= 102-- 'В системе уже зарегистрирован клиент с заданной почтой!'
	  goto exit_
	end

   set @Hash = master.dbo.fn_varbintohexstr(HashBytes('SHA2_512', @Email + @Password))

   Update tClients
      set Hash=@Hash 
	     ,Password = master.dbo.fn_varbintohexstr(HashBytes('SHA2_512', @Password))
	     ,HashDate = getdate()
    where ClientID = @ClientID	  
  end
  else 
  begin
      set @Hash = master.dbo.fn_varbintohexstr(HashBytes('SHA2_512', @Email + @Password))

      -- Поставщик по умолчанию 
      declare @SuppliersID numeric(18,0)
      select @SuppliersID = cast(isnull(nullif(Val, ''), '0') as numeric(18,0)) 
        from tSettings (nolock)
       where Brief = 'DefaultSuppliers'

	  insert into tClients
			(
			 Brief
			,Email
			,Password
			,UserID
			,ClientTypeID
			,Hash
			,HashDate
            ,SuppliersID
			)
	  OUTPUT INSERTED.ClientID INTO @ID
	  select @Email  
			,@Email
			,master.dbo.fn_varbintohexstr(HashBytes('SHA2_512', @Password))	
			,dbo.GetUserID()
			,@ClientTypeID
			,@Hash
			,getdate()
            ,@SuppliersID

	 Select @ClientID = ID from @ID

     if @ClientID > 0 
     begin
         insert tProfilesCustomer
               (
                Brief
               ,ProfilesDeliveryID
               ,Margin
               ,Reliability
               ,Discount
               ,Commission
               ,isActive
               ,ExtraKurs
               ,ClientID
               )
         select sdp.Name
               ,sdp.ProfilesDeliveryID
               ,ct.Margin
               ,ct.Reliability
               ,ct.Discount
               ,ct.Commission
               ,1
               ,2
               ,@ClientID
           from tSupplierDeliveryProfiles sdp (nolock)
           left join tClientType ct (nolock)
                  on ct.ClientTypeID=@ClientTypeID
          where sdp.SuppliersID=@SuppliersID
     end
  end
exit_:
return @r
go
grant exec on CustomerRegistrationRequest to public
go
exec setOV 'CustomerRegistrationRequest', 'P', '20240320', '0'
go