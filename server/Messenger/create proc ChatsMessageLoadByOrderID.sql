drop proc if exists ChatsMessageLoadByOrderID
/*
  ChatsMessageLoadByOrderID -
*/
go
create proc ChatsMessageLoadByOrderID 
               @OrderID   numeric(18,0)

              
as

    select cm.ChatID
          ,cm.MessageID
          ,c.ClientID
          ,cm.UserID
          ,cm.Message
          ,cm.InDateTime
          
          ,u.Brief
          ,u.Name
          ,cm.Flag
      from tChats c (nolock)
     inner join tChatsMessage cm (nolock)
             on cm.ChatID = c.ChatID
      left join tUser u (nolock)
             on u.UserID = cm.UserID
     where c.OrderID = @OrderID

    order by cm.InDateTime
   --select * from tUser
  exit_:
  return 0

go
grant exec on ChatsMessageLoadByOrderID to public
go
exec setOV 'ChatsMessageLoadByOrderID', 'P', '20240813', '1'
go
 

 exec ChatsMessageLoadByOrderID @OrderID = 167120