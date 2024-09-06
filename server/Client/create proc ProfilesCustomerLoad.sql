if OBJECT_ID('ProfilesCustomerLoad') is not null
    drop proc ProfilesCustomerLoad
/*
  ProfilesCustomerLoad - копирование профилей во временную таблицу и обратно
  @SuppliersID -  лиент
  @Direction   - 0 - с посто¤нной во временную
                 1 - с временной в посто¤нную
*/
go
create proc ProfilesCustomerLoad
              @ClientID       numeric(18, 0)  
             ,@Direction      int = null
as
  set nocount on
  declare @r int

  select @R         = 0
        ,@Direction = isnull(@Direction, 0)

  if @Direction = 0
  begin

	  delete [pProfilesCustomer] from [pProfilesCustomer] (rowlock) where spid = @@spid
      INSERT INTO [pProfilesCustomer]
           ([Spid]
           ,[ProfilesCustomerID]
           ,[ClientID]
           ,[Brief]
           ,[ProfilesDeliveryID]
           ,[Margin]
           ,[Reliability]
           ,[UploadFolder]
           ,[UploadPriceName]
           ,[UploadFileName]
           ,[isActive]
           ,[ClientPriceLogo]
           ,[UploadDelimiterID]
           ,[DeliveryTermCustomer])                       
     select @@SPID
           ,[ProfilesCustomerID]
           ,[ClientID]
           ,[Brief]
           ,[ProfilesDeliveryID]
           ,[Margin]
           ,[Reliability]
           ,[UploadFolder]
           ,[UploadPriceName]
           ,[UploadFileName]
           ,[isActive]
           ,[ClientPriceLogo]
           ,[UploadDelimiterID]
           ,[DeliveryTermCustomer]
       from tProfilesCustomer (nolock)
      where ClientID = @ClientID
  end
  else
  begin

    delete tProfilesCustomer
	  from tProfilesCustomer t  (rowlock)
	 where t.ClientID = @ClientID
	   and not exists ( select 1
	                      from pProfilesCustomer p (nolock)
						 where p.Spid               = @@spid
						   and p.ProfilesCustomerID = t.ProfilesCustomerID
					   )

	 insert tProfilesCustomer  
		 (
            [ClientID]
           ,[Brief]
           ,[ProfilesDeliveryID]
           ,[Margin]
           ,[Reliability]
           ,[UploadFolder]
           ,[UploadPriceName]
           ,[UploadFileName]
           ,[isActive]
           ,[ClientPriceLogo]
           ,[UploadDelimiterID]   
           ,[DeliveryTermCustomer]
			)
     select
            [ClientID]
           ,[Brief]
           ,[ProfilesDeliveryID]
           ,[Margin]
           ,[Reliability]
           ,[UploadFolder]
           ,[UploadPriceName]
           ,[UploadFileName]
           ,[isActive]
           ,[ClientPriceLogo]
           ,[UploadDelimiterID]  
           ,[DeliveryTermCustomer]
       from pProfilesCustomer (nolock)
      where Spid = @@Spid 
	    and isnull(ProfilesCustomerID, 0) = 0

     Update t
        set 
            t.[Brief]                = p.[Brief]
           ,t.[ProfilesDeliveryID]   = p.[ProfilesDeliveryID]
           ,t.[Margin]               = p.[Margin]
           ,t.[Reliability]          = p.[Reliability]
           ,t.[UploadFolder]         = p.[UploadFolder]
           ,t.[UploadPriceName]      = p.[UploadPriceName]
           ,t.[UploadFileName]       = p.[UploadFileName]
           ,t.[isActive]             = p.[isActive]
           ,t.[ClientPriceLogo]      = p.[ClientPriceLogo]
           ,t.[UploadDelimiterID]    = p.[UploadDelimiterID] 
           ,t.[DeliveryTermCustomer] = p.[DeliveryTermCustomer]
       from pProfilesCustomer p (nolock)
      inner join tProfilesCustomer t (updlock)
              on t.ClientID        = @ClientID
             and t.ProfilesCustomerID = p.ProfilesCustomerID
      where p.Spid = @@Spid 
  end

exit_:
return @r
go
grant exec on ProfilesCustomerLoad to public
go
exec setOV 'ProfilesCustomerLoad', 'P', '20240906', '3'
go
