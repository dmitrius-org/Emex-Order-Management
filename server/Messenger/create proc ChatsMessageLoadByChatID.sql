drop proc if exists ChatsMessageLoadByChatID
/*
  ChatsLoad -
*/
go
create proc ChatsMessageLoadByChatID 
               @ChatID   numeric(18,0)

              
as

    select cm.ChatID
          ,cm.MessageID
          ,0 ClientID
          ,cm.UserID
          ,cm.Message
          ,cm.InDateTime
          ,u.Brief
          ,u.Name
          ,cm.Flag
      from tChatsMessage cm (nolock)
     left join tUser u (nolock)
             on u.UserID = cm.UserID
            and cm.Flag&1 = 1

     where cm.ChatID = @ChatID

    order by cm.InDateTime
   --select * from tUser
  exit_:
  return 0

go
grant exec on ChatsMessageLoadByChatID to public
go
exec setOV 'ChatsMessageLoadByChatID', 'P', '20250128', '2'
go
 

 exec ChatsMessageLoadByChatID @ChatID = 772


 select * from tChatsMessage