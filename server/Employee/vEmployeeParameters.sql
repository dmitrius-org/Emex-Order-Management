if OBJECT_ID('vEmployeeParameters') is not null
    drop view vEmployeeParameters
go
/* **********************************************************						
vEmployeeParameters - 
********************************************************** */
create view vEmployeeParameters
as

select p.EmployeeID,
       p.UserID,
       p.Flag,
       p.ProcessedVal,
	   p.IncorrectVal,
	   p.ConfirmedVal,
	   p.InDateTime,
       p.ValidFrom as UpdDateTime
  from tEmployeeParameters p with (nolock index=PK_tEmployeeParameters_EmployeeID) 

go
grant all on vEmployeeParameters to public
go
exec setOV 'vEmployeeParameters', 'V', '20250204', '0'
go

 Select *
   from vEmployeeParameters 

 select * from tEmployeeParameters for system_time all

 SELECT SYSDATETIME() AS CurrentDateTime,  
        GETUTCDATE() AS UTCDateTime,  
        SYSDATETIMEOFFSET() AS DateTimeWithOffset;

