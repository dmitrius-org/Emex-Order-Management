if OBJECT_ID('CustomerChatsList') is not null
    drop proc CustomerChatsList
go
/* **********************************************************						
CustomerChatsList - непрочитанные сообщения для клиентов
********************************************************** */

create proc CustomerChatsList
             @ClientID as numeric(18, 0), 
             @Status   as ID READONLY,
             @Number   as varchar(255) = null
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
                    and cm.Flag&1=1
                    and cm.Flag&2=0) , 0) UnReadMessages -- количество непрочитанных сообщений
    from tChats c with (nolock index=ao3)
   inner join tClients cl with (nolock index=PK_tClients_ClientID)
           on cl.ClientID = c.ClientID 
    LEFT JOIN @Status s2
           ON c.StatusID = s2.ID

   where c.ClientID = @ClientID
     
     AND (NOT EXISTS (SELECT 1 FROM @Status) OR s2.ID IS NOT NULL)

     AND (@Number is null
          
          or (
               convert(varchar, c.OrderID) like '%' + @Number + '%'
            or c.Name like '%' + @Number + '%'
             )
         )

   order by c.InDateTime desc
go
grant exec on CustomerChatsList to public
go
exec setOV 'CustomerChatsList', 'P', '20250128', '2'
go

exec CustomerChatsList @ClientID =57


