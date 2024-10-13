drop proc if exists ChatsMessageLoadByChatID
/*
  ChatsLoad -
*/
go
create proc ChatsMessageLoadByChatID 
               @ChatID   numeric(18,0)

              
as

    select cm.ChatID
          ,cm.ClientID
          ,cm.UserID
          ,cm.Message
          ,cm.InDateTime
          
          ,u.Brief
          ,u.Name
      from tChatsMessage cm (nolock)
     inner join tUser u (nolock)
             on u.UserID = cm.UserID
     where cm.ChatID = @ChatID

    order by cm.InDateTime
   --select * from tUser
  exit_:
  return 0

go
grant exec on ChatsMessageLoadByChatID to public
go
exec setOV 'ChatsLoad', 'P', '20240813', '1'
go
 

 exec ChatsMessageLoadByChatID @ChatID = 10