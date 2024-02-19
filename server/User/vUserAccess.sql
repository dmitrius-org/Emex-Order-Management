if OBJECT_ID('vUserAccess') is not null
    drop view vUserAccess
go
/* **********************************************************						
vUserAccess - права на объекты учет

выводим только уникальные строки
********************************************************** */

create view vUserAccess

as
  select t.ObjectID    as UserID
        ,t.LinkID      as LinkID
        ,t.LinkType    as LinkType
    from tGrantObject t with (nolock index =ao1)
   where t.ObjectType = 0

   union

  select ur.UserID     as UserID
        ,t.LinkID      as LinkID
        ,t.LinkType    as LinkType
    from tGrantObject t  with (nolock index =ao1)
   inner join tUserReliation ur  with (nolock index =ao1)
           on ur.LinkType   = 2 -- связь пользователя и группы
          and ur.GroupID    = t.ObjectID
   where t.ObjectType = 1	 

go
grant select on vUserAccess to public
go
exec setOV 'vUserAccess', 'V', '20240101', '1.0.0.0'
go
 
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'vOrders', @desc = 'Список заказов'

