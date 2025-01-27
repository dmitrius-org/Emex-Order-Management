if OBJECT_ID('ManagerChatsList') is not null
    drop proc ManagerChatsList
go
/* **********************************************************						
ManagerChatsList - непрочитанные сообщения от клиентов
********************************************************** */

create proc ManagerChatsList
             @Clients as ID READONLY, 
             @Status  as ID READONLY,
             @Number  as varchar(255) = null
as
  select @Number = nullif(@Number, '')

  select c.ChatID, 
         c.ClientID,
         cl.Brief as ClientName,
         c.OrderID,
         case 
           when c.Flag&2=2 then c.Name 
           else 'Заказ: ' + convert(varchar, c.OrderID)
         end as Subject,
         convert(varchar, c.OrderID) as Number,
         c.StatusID,
         case 
           when c.StatusID = 1 then 'Открытые'
           when c.StatusID = 1 then 'В ожидании'
           when c.StatusID = 1 then 'Закрытые'
           else ''
         end as StatusName,
         c.Flag,

         c.InDateTime,
         isnull((select count(*) 
                   from tChatsMessage cm (nolock)
                  where cm.ChatID = c.ChatID
                    and cm.Flag&1=0
                    and cm.Flag&2>0) , 0) UnReadMessages -- количество непрочитанных сообщений
    from tChats c with (nolock index=ao3)
   inner join tClients cl with (nolock index=PK_tClients_ClientID)
           on cl.ClientID = c.ClientID 
    LEFT JOIN @Clients c2
           ON c.ClientID = c2.ID
    LEFT JOIN @Status s2
           ON c.StatusID = s2.ID

   where 1=1
     
     AND (NOT EXISTS (SELECT 1 FROM @Clients) OR c2.ID IS NOT NULL)
     AND (NOT EXISTS (SELECT 1 FROM @Status) OR s2.ID IS NOT NULL)

     AND (@Number is null
          
          or (
               convert(varchar, c.OrderID) like '%' + @Number + '%'
            or c.Name like '%' + @Number + '%'
             )
         )

   order by c.InDateTime desc
go
grant exec on ManagerChatsList to public
go
exec setOV 'ManagerChatsList', 'P', '20241023', '1'
go

exec ManagerChatsList -- where ClientID =31


