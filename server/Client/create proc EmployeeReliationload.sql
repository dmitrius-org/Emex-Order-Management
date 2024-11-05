if OBJECT_ID('EmployeeReliationload') is not null
    drop proc EmployeeReliationload
/*
  EmployeeReliationload - 
                          менеджеры у нас это пользователи
  @ClientID  - Ид клиента
  @Direction - 0 - с постоянной во временную
               1 - с временной в постоянную
*/
go
create proc EmployeeReliationload
              @ClientID    numeric(18, 0)  
             ,@Direction   int 
as
  set nocount on
  declare @r int

  select @R         = 0
        ,@Direction = isnull(@Direction, 0)

  if @Direction = 0
  begin

	  delete pClientReliation from pClientReliation (rowlock) where spid = @@spid
	  insert pClientReliation  -- данные с пользователя       
			 (               
             Spid                              
            ,ClientID 
            ,ClientReliationID -- идентификатор ClientReliationID
            ,LinkID	           -- пользователь/группа        
            ,LinkType  -- тип объекта  
            ,ObjectType
			)
      Select @@SPID        
            ,o.LinkID        -- ClientID            
            ,o.GrantObjectID -- ClientReliationID
            ,o.ObjectID      -- LinkID пользователь/группа  
            ,o.LinkType      -- LinkType
            ,o.ObjectType
        from tGrantObject o (nolock)
       where o.ObjectType in (0, 1)
         and o.LinkType   = 7
         and o.LinkID     = @ClientID

  end
  else
  begin

    delete tGrantObject
	  from tGrantObject t  (rowlock)
	 where t.ObjectType in (0, 1) 
       and t.ObjectID  > 0
       and t.LinkType  = 7
       and t.LinkID    = @ClientID
	   and not exists ( select 1
	                      from pClientReliation p (nolock)
						 where p.Spid              = @@spid
						   and isnull(p.ClientReliationID, 0) = t.GrantObjectID 
                      )

	 insert tGrantObject with (rowlock) 
	       (ObjectID -- пользователь/группа
           ,ObjectType
           ,LinkID   -- клиент
           ,LinkType)
	 select p.LinkID   -- пользователь/группа
           ,p.ObjectType
           ,@ClientID-- клиент
           ,p.LinkType   
	   from pClientReliation p (nolock)
	  where p.Spid     = @@Spid 
        and p.LinkType = 7
        and p.ClientReliationID is null
	    --and not exists (select 1
	    --                  from tGrantObject t (nolock)
		   --              where t.ObjectID   = p.LinkID
					--	   and t.ObjectType = p.ObjectType
     --                      and t.LinkID     = @ClientID     
     --                      and t.LinkType   = p.LinkType 
     --                 )

     Update t
        set t.ObjectID = p.LinkID   --пользователь   
           ,t.LinkID   = p.ClientID --клиент  
       from pClientReliation p (nolock)
      inner join tGrantObject t (updlock)
              on t.GrantObjectID = p.ClientReliationID
      where p.Spid     = @@Spid 
        and p.LinkType = 7
  end


exit_:
return @r
go
grant exec on EmployeeReliationload to public
go
exec setOV 'EmployeeReliationload', 'P', '20241105', '1'
go
