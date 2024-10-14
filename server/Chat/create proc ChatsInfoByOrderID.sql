drop proc if exists ChatsInfoByOrderID
/*
  ChatsInfoByOrderID -
*/
go
create proc ChatsInfoByOrderID 
               @OrderID   numeric(18,0)            
as

    select c.ChatID
      from tChats c (nolock)
     where c.OrderID = @OrderID


  exit_:
  return 0

go
grant exec on ChatsInfoByOrderID to public
go
exec setOV 'ChatsInfoByOrderID', 'P', '20240813', '1'
go
 

 exec ChatsInfoByOrderID @OrderID = 167095