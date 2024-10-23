drop proc if exists ChatsClientInfoByOrderID
/*
  ChatsClientInfoByOrderID -
*/
go
create proc ChatsClientInfoByOrderID 
               @OrderID   numeric(18,0)            
as

  if exists ( select 1
                from tChats c (nolock)
               where c.OrderID = @OrderID)
    select c.ClientID
          ,cl.Brief ClientBrief
          ,cl.Name  ClientName
      from tChats c (nolock)
     inner join tClients cl (nolock)
             on cl.ClientID = c.ClientID
     where c.OrderID = @OrderID
  else
    select o.ClientID
          ,cl.Brief ClientBrief
          ,cl.Name  ClientName
      from tOrders o (nolock)
     inner join tClients cl (nolock)
             on cl.ClientID =o.ClientID
     where o.OrderID = @OrderID

  exit_:
  return 0

go
grant exec on ChatsClientInfoByOrderID to public
go
exec setOV 'ChatsClientInfoByOrderID', 'P', '20240813', '1'
go
 

 exec ChatsClientInfoByOrderID @OrderID = 167095