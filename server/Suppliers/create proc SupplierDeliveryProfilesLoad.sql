if OBJECT_ID('SupplierDeliveryProfilesLoad') is not null
    drop proc SupplierDeliveryProfilesLoad
/*
  SupplierDeliveryProfilesLoad - копирование профилей доставки поставщика во временную таюлицу и обратно
  @SuppliersID - поставщик
  @Direction   - 0 - с постоянной во временную
                 1 - с временной в постоянную
*/
go
create proc SupplierDeliveryProfilesLoad
              @SuppliersID    numeric(18, 0)  
             ,@Direction      int = null
as
  set nocount on
  declare @r int

  select @R         = 0
        ,@Direction = isnull(@Direction, 0)

  if @Direction = 0
  begin

	  delete pSupplierDeliveryProfiles from pSupplierDeliveryProfiles (rowlock) where spid = @@spid
	  insert pSupplierDeliveryProfiles  
			 (
             Spid
            ,ProfilesDeliveryID 
            ,SuppliersID        
            ,Name               
            ,WeightKG           
            ,VolumeKG           
            ,PDelivery1         
            ,PDelivery2         
            ,PDelivery3         
            ,DenVyleta          
            ,VolumeKG_Rate1     
            ,VolumeKG_Rate2     
            ,VolumeKG_Rate3     
            ,VolumeKG_Rate4     
            ,DestinationLogo    
            ,Restrictions       
            ,IsActive  
			,Delivery
			)
     select @@SPID
           ,ProfilesDeliveryID
           ,SuppliersID
           ,Name
           ,WeightKG
           ,VolumeKG
           ,PDelivery1
           ,PDelivery2
           ,PDelivery3
           ,DenVyleta
           ,VolumeKG_Rate1
           ,VolumeKG_Rate2
           ,VolumeKG_Rate3
           ,VolumeKG_Rate4
           ,DestinationLogo
           ,Restrictions
           ,IsActive
		   ,Delivery
       from tSupplierDeliveryProfiles (nolock)
      where SuppliersID = @SuppliersID
  end
  else
  begin

    delete tSupplierDeliveryProfiles
	  from tSupplierDeliveryProfiles t  (rowlock)
	 where t.SuppliersID = @SuppliersID
	   and not exists ( select 1
	                      from pSupplierDeliveryProfiles p (nolock)
						 where p.Spid               = @@spid
						   and p.ProfilesDeliveryID = t.ProfilesDeliveryID
					   )

	  insert tSupplierDeliveryProfiles  
			 (
             SuppliersID        
            ,Name               
            ,WeightKG           
            ,VolumeKG           
            ,PDelivery1         
            ,PDelivery2         
            ,PDelivery3         
            ,DenVyleta          
            ,VolumeKG_Rate1     
            ,VolumeKG_Rate2     
            ,VolumeKG_Rate3     
            ,VolumeKG_Rate4     
            ,DestinationLogo    
            ,Restrictions       
            ,IsActive    
			,Delivery
			)
     select @SuppliersID
           ,Name
           ,WeightKG
           ,VolumeKG
           ,PDelivery1
           ,PDelivery2
           ,PDelivery3
           ,DenVyleta
           ,VolumeKG_Rate1
           ,VolumeKG_Rate2
           ,VolumeKG_Rate3
           ,VolumeKG_Rate4
           ,DestinationLogo
           ,Restrictions
           ,IsActive
		   ,Delivery
       from pSupplierDeliveryProfiles (nolock)
      where Spid = @@Spid --SuppliersID = @SuppliersID
	    and isnull(ProfilesDeliveryID, 0) = 0

     Update t
        set t.Name             = p.Name           
           ,t.WeightKG         = p.WeightKG       
           ,t.VolumeKG         = p.VolumeKG       
           ,t.PDelivery1       = p.PDelivery1     
           ,t.PDelivery2       = p.PDelivery2     
           ,t.PDelivery3       = p.PDelivery3     
           ,t.DenVyleta        = p.DenVyleta      
           ,t.VolumeKG_Rate1   = p.VolumeKG_Rate1 
           ,t.VolumeKG_Rate2   = p.VolumeKG_Rate2 
           ,t.VolumeKG_Rate3   = p.VolumeKG_Rate3 
           ,t.VolumeKG_Rate4   = p.VolumeKG_Rate4 
           ,t.DestinationLogo  = p.DestinationLogo
           ,t.Restrictions     = p.Restrictions   
           ,t.IsActive         = p.IsActive  
		   ,t.Delivery         = p.Delivery
       from pSupplierDeliveryProfiles p (nolock)
      inner join tSupplierDeliveryProfiles t (updlock)
              on t.SuppliersID        = @SuppliersID
             and t.ProfilesDeliveryID = p.ProfilesDeliveryID
      where p.Spid = @@Spid 
  end

exit_:
return @r
go
grant exec on SupplierDeliveryProfilesLoad to public
go
exec setOV 'SupplierDeliveryProfilesLoad', 'P', '20240403', '1'
go