if OBJECT_ID('vUnreadManagerMessages') is not null
    drop view vUnreadManagerMessages
go
/* **********************************************************						
vUnreadManagerMessages - непрочитанные сообщения от менеджера
********************************************************** */

create view vUnreadManagerMessages
as

  select c.ChatID, 
         c.ClientID,
         c.OrderID,
         cm.Message,
         cm.InDateTime
    from tChats c with (nolock index=ao3)
   inner join tChatsMessage cm with (nolock index=ao2)
           on cm.ChatID = c.ChatID
          and cm.Flag&1 = 1
          and cm.Flag&2 = 0  
go
grant select on vUnreadManagerMessages to public
go
exec setOV 'vUnreadManagerMessages', 'V', '20250211', '3'
go
