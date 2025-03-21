if OBJECT_ID('OrderFilter_DestinationList') is not null
    drop proc OrderFilter_DestinationList
go
if OBJECT_ID('OrderF_DestinationList') is not null
    drop proc OrderF_DestinationList
/*
  OrderF_DestinationList -
*/
go
create proc OrderF_DestinationList
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
grant exec on OrderF_DestinationList to public
go
exec setOV 'OrderF_DestinationList', 'P', '20250320', '0'
go
exec OrderF_DestinationList @OrderID = 193099



