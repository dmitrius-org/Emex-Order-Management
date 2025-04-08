if OBJECT_ID('vClientEdit') is not null
    drop view vClientEdit
go
/* **********************************************************						
vClientEdit - получение сведений о клиенте для редактирования
********************************************************** */

create view vClientEdit

as

select c.ClientID      
      ,c.Brief       
      ,c.Name	     
	  ,c.SuppliersID
      ,c.inDatetime  
      ,c.updDatetime 
	  ,isnull(c.IsActive, 0) IsActive
	  ,c.UserID
      ,c.Taxes
      ,isnull(c.ResponseType, -1)       ResponseType
      ,isnull(c.NotificationMethod, -1) NotificationMethod
      ,c.NotificationAddress
      ,c.NotificationScript
      ,c.ClientTypeID
      ,c.Email
      ,c.Phone
      ,c.ContactPerson
      ,(SELECT STRING_AGG(n.SearchBrief, ';') WITHIN GROUP (ORDER BY n.SearchID ASC)
          FROM ( 
               SELECT DISTINCT n.SearchBrief,  n.SearchID 
                 FROM STRING_SPLIT(c.StatusRequiringPayment, ';') AS p
                INNER JOIN tNodes n WITH (NOLOCK)
                        ON n.SearchID = p.value  -- Статусы требующие предоплаты c.StatusRequiringPayment
               
               ) AS n
        ) as StatusRequiringPayment      
  from tClients c (nolock)

go
grant all on vClientEdit to public
go
exec setOV 'vClientEdit', 'V', '20250408', '6'
go

select * from vClientEdit