drop proc if exists GrantCopy
/* **********************************************************
  GrantCopy - копирование прав с пользователя

  @UserID       -- ид пользователя
  @SourceUserID -- ид пользователя источника данных

********************************************************** */
go
create proc GrantCopy
              @UserID        numeric(18,0)  
             ,@SourceUserID  numeric(18,0)  
as
  set nocount on;

  declare @r int = 0
  
  exec GrantSelect 
         @ObjectID   = @SourceUserID
        ,@ObjectType = 0
  
  insert tGrant with (rowlock)
        (ObjectID
        ,MenuID
        ,ObjectType)
  Select @UserID
        ,v.MenuID
        ,0
    from vGrant v
   where v.ObjectID = @SourceUserID
     and v.Value    = 1
     and not exists (select 1
                       from tGrant g with (nolock index=ao1)
                      where g.ObjectType = 0
                        and g.ObjectID   = @UserID
                        and g.MenuID     = v.MenuID
                     )
--ao1	nonclustered, unique located on PRIMARY	ObjectType, ObjectID, MenuID

  -- сохранение прав на объекты учета
  --delete tGrantObject 
  --  from tGrantObject (rowlock)
  -- where ObjectID   = @ObjectID
  --   and ObjectType = @ObjectType

  --insert tGrantObject
  --      (
  --       ObjectID
  --      ,ObjectType
  --      ,LinkID
  --      ,LinkType
  --      )
  --select p.ObjectID
  --      ,p.ObjectType
  --      ,p.LinkID
  --      ,p.LinkType
  --  from pGrantObject p (nolock)
  -- where p.Spid=@@SPID

  --delete p
  --  from pGrantObject p (rowlock)
  -- where p.Spid=@@SPID

 exit_:
 return @r
go
grant exec on GrantCopy to public
go
exec setOV 'GrantCopy', 'P', '20250117', '1'
go

