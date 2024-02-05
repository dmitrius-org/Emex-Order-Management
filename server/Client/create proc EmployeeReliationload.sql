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
            ,ClientReliationID --идентификатор ClientReliationID
            ,LinkID	   -- пользователь        
            ,LinkType  -- тип объекта                    
			)
      Select @@SPID        
            ,o.LinkID        -- ClientID            
            ,o.GrantObjectID -- ClientReliationID
            ,o.ObjectID      -- LinkID пользователь  
            ,5               -- LinkType
        from tGrantObject o (nolock)
       where o.ObjectType = 0
         and o.LinkType   = 7
         and o.LinkID     = @ClientID


	  insert pClientReliation   -- данные с группы пользователей
			 (               
             Spid                              
            ,ClientID 
            ,ClientReliationID --идентификатор ClientReliationID
            ,LinkID	   -- пользователь        
            ,LinkType  -- тип объекта                    
			)
      Select @@SPID 
            ,o.LinkID
            ,o.GrantObjectID
            ,ur.UserID        -- LinkID  пользователь 
            ,5                -- LinkType
        from tGrantObject o (nolock)
       inner join tGroups g (nolock)
               on g.GroupID= o.ObjectID 
       inner join tUserReliation ur (nolock)
               on ur.GroupID = g.GroupID
              and ur.LinkType= 2 
       where o.ObjectType = 1
         and o.LinkType   = 7
         and o.LinkID     = @ClientID
         and not exists (select 1
                           from pClientReliation p (nolock)
                          where p.Spid     = @@spid
                            and p.LinkID   = ur.UserID
                            and p.LinkType = 5)

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
						   and p.ClientReliationID = t.GrantObjectID
                           and p.LinkType          = 5
						   and isnull(p.ClientReliationID, 0) <> 0   
                      )

	  insert tGrantObject  
			(ObjectID -- пользователь
            ,ObjectType
            ,LinkID   -- клиент
            ,LinkType)
	  select LinkID   -- пользователь
            ,0
            ,@ClientID-- клиент
            ,7    
	   from pClientReliation (nolock)
	  where Spid     = @@Spid 
        and LinkType = 5
	    and isnull(ClientReliationID, 0) = 0

     Update t
        set t.ObjectID = p.LinkID   --пользователь   
           ,t.LinkID   = p.ClientID --клиент  
       from pClientReliation p (nolock)
      inner join tGrantObject t (updlock)
              on t.GrantObjectID = p.ClientReliationID
      where p.Spid     = @@Spid 
        and p.LinkType = 5
  end


exit_:
return @r
go
grant exec on EmployeeReliationload to public
go
