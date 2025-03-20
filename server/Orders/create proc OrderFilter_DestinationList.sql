if OBJECT_ID('OrderFilter_DestinationList') is not null
    drop proc OrderFilter_DestinationList
/*
  OrderFilter_DestinationList - формирование значений для фильтра статус
*/
go
create proc OrderFilter_DestinationList
              @OrderID numeric(18, 0)
as
  declare @r          int = 0

  SELECT distinct
         cp.ProfilesCustomerID   as ID
        ,cp.ClientProfileName    as Name
    FROM tOrders o (nolock)
   inner join vClientProfilesParam cp
           on cp.ClientID                = o.ClientID
          and cp.ClientProfileIsActive   =1
          and cp.SupplierProfileIsActive =1
   where o.OrderID = @OrderID
     and o.Flag&16 >0

 exit_:
 return @r
go
grant exec on OrderFilter_DestinationList to public
go
exec setOV 'OrderFilter_DestinationList', 'P', '20250320', '0'
go
exec OrderFilter_DestinationList @OrderID = 193241



