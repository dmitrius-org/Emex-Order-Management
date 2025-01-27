if OBJECT_ID('ChatsFilter_Client') is not null
    drop proc ChatsFilter_Client
/*
  ChatsFilter_Client - формирование значений для фильтра клиенты
                      -- список формируется с учетом прав пользователя
*/
go
create proc ChatsFilter_Client
as
    declare @r          int = 0

    SELECT distinct 
           c.[ClientID]
          ,c.[Brief]
          ,c.[Name]
      FROM [tClients] c (nolock)

     -- права
     --inner join vUserAccess ua (nolock)
     --        on ua.UserID    = dbo.GetUserID()
     --       and ua.LinkType  = 7
     --       and ua.LinkID    = c.ClientID
     where 1=1
       and exists (select 1
                     from tChats ct (nolock)
                    where ct.ClientID = c.ClientID)
     order by c.[Brief]       

 exit_:
 return @r
go
grant execute on ChatsFilter_Client to public
go
exec setOV 'ChatsFilter_Client', 'P', '20250127', '1'
go


exec ChatsFilter_Client
