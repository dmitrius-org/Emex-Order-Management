drop proc if exists CustomerOrdersPage
/*
  CustomerOrdersPage - 


*/
go
create proc CustomerOrdersPage
               @ClientID         numeric(18,0)  
              ,@Status           id readonly
              ,@DetailNum        nvarchar(60)
              ,@Comment2         varchar(60)  
              ,@OrderDateStart   datetime = null    
              ,@OrderDateEnd     datetime = null    
              ,@isCancel         int         
              ,@IsNotification   bit 
              ,@PageSize         int
as
  SET NOCOUNT ON; 
  declare @r             int = 0

  select @OrderDateStart= isnull(nullif(@OrderDateStart,'18991230'), '20000101')  
        ,@OrderDateEnd  = isnull(nullif(@OrderDateEnd  ,'18991230'), '20701231') 
        ,@DetailNum     = nullif(@DetailNum, '')
        ,@Comment2      = nullif(@Comment2, '')
        ,@isCancel      = nullif(@isCancel, -1)
  
  delete from #OrderPage
  insert #OrderPage 
        (OrderID, Page)
  select o.OrderID
        ,(ROW_NUMBER() OVER (ORDER BY o.ClientID, o.OrderID desc) - 1) / @PageSize + 1 AS PageNumber
    from tOrders o with (nolock index=ao2)
    left JOIN @Status c
           ON o.StatusID = c.ID

    left join vCustomerOrderNotificationFilter cl
           on cl.OrderID  = o.OrderID
          and cl.ClientID = o.ClientID
   where o.ClientID = @ClientID
     and (NOT EXISTS (SELECT 1 FROM @Status) OR c.ID IS NOT NULL)

     and (@DetailNum is null
      or  ((left(o.DetailNumber, 1) = '1' and o.OrderDetailSubId = Trim(@DetailNum))
           or (
                 o.DetailNumber like '%' + Trim(@DetailNum) + '%' 
              or o.ReplacementDetailNumber like '%' + Trim(@DetailNum) + '%'
              )
          )        
         )

     and o.OrderDate between @OrderDateStart and @OrderDateEnd

     and (@isCancel is null or o.isCancel = @isCancel)

     and (@Comment2 is null or o.Comment2 like '%' + @Comment2 + '%')

     and ( @IsNotification = 0 or
          (@IsNotification = 1 and cl.OrderID is not null)
         )
 -- order by o.OrderID desc

  exit_:
  return @r

go
grant exec on CustomerOrdersPage to public
go
exec setOV 'CustomerOrdersPage', 'P', '20250224', '0'
go
 