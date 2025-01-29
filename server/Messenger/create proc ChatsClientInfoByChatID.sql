drop proc if exists ChatsClientInfoByChatID
go
drop proc if exists ChatsInfoByChatID
/*
  ChatsInfoByChatID -
*/
go
create proc ChatsInfoByChatID 
               @ChatID   numeric(18,0)            
as

    select c.ClientID
          ,cl.Brief ClientBrief
          ,cl.Name  ClientName
          ,c.OrderID 
          ,c.Name   Subject
      from tChats c (nolock)
     inner join tClients cl (nolock)
             on cl.ClientID = c.ClientID
     where c.ChatID = @ChatID

  exit_:
  return 0

go
grant exec on ChatsInfoByChatID to public
go
exec setOV 'ChatsInfoByChatID', 'P', '20250128', '2'
go
 

 exec ChatsInfoByChatID @ChatID = 776