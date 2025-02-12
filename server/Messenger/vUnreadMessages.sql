if OBJECT_ID('vUnreadMessages') is not null
    drop view vUnreadMessages
go
/* **********************************************************						
vUnreadMessages - непрочитанные сообщения
********************************************************** */

create view vUnreadMessages
as
  select cm.MessageID, 
         c.ClientID,
         cm.Flag
    from tChats c with (nolock index=ao2)
   inner join tChatsMessage cm with (nolock index=ao2)
           on cm.ChatID = c.ChatID
   where cm.Flag&2=0 -- непрочитано
go
grant select on vUnreadMessages to public
go
exec setOV 'vUnreadMessages', 'V', '20250127', '1'
go
