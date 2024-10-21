if OBJECT_ID('OrderFilter_Client') is not null
    drop proc OrderFilter_Client
/*
  OrderFilter_Client - формирование значений для фильтра клиенты
                       список формируется с учетом прав пользователя
*/
go
create proc OrderFilter_Client
as
    declare @r          int = 0

    SELECT c.[ClientID]
          ,c.[Brief]
          ,c.[Name]
      FROM [tClients] c (nolock)
     -- права
     inner join vUserAccess ua (nolock)
             on ua.UserID    = dbo.GetUserID()
            and ua.LinkType  = 7
            and ua.LinkID    = c.ClientID
     where c.IsActive = 1
     order by c.[Brief]       

 exit_:
 return @r
go
grant exec on OrderFilter_Client to public
go
exec setOV 'OrderFilter_Client', 'P', '20241020', '1'
go
exec OrderFilter_Client 



