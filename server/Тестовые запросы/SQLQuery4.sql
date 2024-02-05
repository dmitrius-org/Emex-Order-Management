  select 
        --,t.GrantObjectID
         t.ObjectID    as UserID
        ,t.ObjectType
        ,t.LinkID      as LinkID
        ,t.LinkType    as LinkType
    from tGrantObject t (nolock)
   where t.ObjectType = 0
   union all
  select 
        --,t.GrantObjectID
         ur.UserID     as UserID
        ,t.ObjectType
        ,t.LinkID      as LinkID
        ,t.LinkType    as LinkType
    from tGrantObject t (nolock)
   inner join tUserReliation ur (nolock)
           on ur.LinkType   = 2 -- связь пользователя и группы
          and ur.GroupID    = t.ObjectID
   where t.ObjectType = 1
  
  --where t.ObjectID   = @ObjectID
  --   and t.ObjectType = @ObjectType

  select * from tUserReliation