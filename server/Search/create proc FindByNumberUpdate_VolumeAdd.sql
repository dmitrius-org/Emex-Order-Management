if OBJECT_ID('FindByNumberUpdate_VolumeAdd', 'P') is not null
    drop proc FindByNumberUpdate_VolumeAdd	 
go
/* --------------------------------------------------------
  FindByNumberUpdate_VolumeAdd -
-------------------------------------------------------- */
create proc FindByNumberUpdate_VolumeAdd              
              @VolumeAdd money
as          
set nocount on;

declare @RetVal       int

Update pFindByNumber
   set VolumeAdd = isnull(@VolumeAdd, VolumeAdd)
      ,Flag        = isnull(Flag, 0)| 512 -- Вес изменен клиентом
 where spid = @@spid
       
exit_:
return @RetVal    
go
grant all on FindByNumberUpdate_VolumeAdd to public
go
exec setOV 'FindByNumberUpdate_VolumeAdd', 'P', '20250217', '0'
go
 