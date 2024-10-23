drop proc if exists ChatsLoad
/*
  ChatsLoad -
*/
go
create proc ChatsLoad
               @ClientID                numeric(18,0)

              
as

    select c.ChatID
          ,c.ClientID
          ,cl.Brief ClientBrief
          ,c.OrderID
          ,c.Flag
          ,c.InDateTime 
      from tChats c (nolock)
     inner join tClients cl (nolock)
             on cl.ClientID = c.ClientID
    -- where ClientID = :ClientID

    order by c.InDateTime desc

  exit_:
  return 0

go
grant exec on ChatsLoad to public
go
exec setOV 'ChatsLoad', 'P', '20240813', '1'
go
 

 exec ChatsLoad @ClientID = 57