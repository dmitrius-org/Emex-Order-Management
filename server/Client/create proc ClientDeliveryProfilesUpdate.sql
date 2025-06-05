if OBJECT_ID('ClientDeliveryProfilesUpdate') is not null
    drop proc ClientDeliveryProfilesUpdate
/*
  ClientDeliveryProfilesUpdate - 
*/
go
create proc ClientDeliveryProfilesUpdate
              @Brief	            varchar(60)
             ,@Margin	            money           = null
             ,@Reliability	        money           = null
             ,@UploadFolder	        varchar(255)    = null
             ,@UploadPriceName	    varchar(255)    = null
             ,@UploadFileName	    varchar(255)    = null
             ,@isActive	            bit             = null
             ,@ProfilesDeliveryID	int             = null
             ,@ClientPriceLogo      nvarchar(32)    = null
             ,@UploadDelimiterID	int             = null
             ,@DeliveryTermCustomer	int             = null
             ,@ProfilesCustomerID   numeric(18, 0)  = null
             ,@ID	                numeric(18, 0)
             ,@SuppliersID	        numeric(18, 0)  = null
as
  set nocount on;
  declare @r int

  select @R         = 0


if isnull(@Brief, '') = ''
begin
 select @r=105 --'Необходимо заполнить поле [Наименование профиля]'
 goto exit_
end

if isnull(@SuppliersID, 0) = 0
begin
  select @r=108 --'Необходимо заполнить поле [Поставщик]!'
  goto exit_
end

if isnull(@ProfilesDeliveryID, 0) = 0
begin
  select @r=106 --'Необходимо заполнить поле [Способ доставки]
  goto exit_
end


if exists (select 1
             from [pProfilesCustomer](nolock)
            where Spid            = @@spid
              and Brief           = @Brief
              and ID             <> @ID
)
begin
   select @r=107 --Наименование профиля существует
   goto exit_
end

/*
-- 
if exists (select 1
             from [pProfilesCustomer](nolock)
            where Spid            = @@spid
              and Brief           = @Brief
              and ProfilesDeliveryID = @ProfilesDeliveryID
              and ID             <> :ID
)
begin
   RAISERROR ('Сочетание "Наименование профиля/Способ доставки" существует!', 16, 1); 
end
--*/

Update pProfilesCustomer
   set
       [Brief]               = @Brief
      ,[ProfilesDeliveryID]  = @ProfilesDeliveryID
      ,[Margin]              = @Margin
      ,[Reliability]         = @Reliability
      ,[UploadFolder]        = @UploadFolder
      ,[UploadPriceName]     = @UploadPriceName
      ,[UploadFileName]      = @UploadFileName
      ,[isActive]            = @isActive
      ,[ClientPriceLogo]     = @ClientPriceLogo
      ,[UploadDelimiterID]   = @UploadDelimiterID
      ,[DeliveryTermCustomer]= @DeliveryTermCustomer
      ,[SuppliersID]         = @SuppliersID
where ID=@ID

exit_:
return @r
go
grant exec on ClientDeliveryProfilesUpdate to public
go
exec setOV 'ClientDeliveryProfilesUpdate', 'P', '20250603', '1'
go