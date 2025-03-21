if OBJECT_ID('CustomerReOrderF_DestinationList') is not null
    drop proc CustomerReOrderF_DestinationList
/*
  OrderF_DestinationList -
*/
go
create proc CustomerReOrderF_DestinationList
              @OrderID numeric(18, 0)
as
  declare @r          int = 0

  SELECT distinct
         cp.ProfilesCustomerID   as ID
        ,cp.DestinationName      as Name
    FROM tOrders o (nolock)
   inner join vClientProfilesParam cp
           on cp.ClientID                = o.ClientID
          --and cp.ClientProfileIsActive   =1
          --and cp.SupplierProfileIsActive =1
   where o.OrderID = @OrderID
     and isnull(o.Flag, 0)&16 >0
   union all
  SELECT distinct
         cp.ProfilesDeliveryID   as ID
        ,cp.ProfileName          as Name
    FROM tOrders o (nolock)
   inner join vSupplierDeliveryParam cp
           on cp.SuppliersID             = o.SuppliersID
          --and cp.SupplierProfileIsActive = 1
   where o.OrderID = @OrderID
     and isnull(o.Flag, 0)&16 =0

 exit_:
 return @r
go
grant exec on CustomerReOrderF_DestinationList to public
go
exec setOV 'CustomerReOrderF_DestinationList', 'P', '20250320', '0'
go
exec CustomerReOrderF_DestinationList @OrderID = 193850



