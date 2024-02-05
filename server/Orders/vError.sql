if OBJECT_ID('vError') is not null
    drop view vError
go
/* **********************************************************						
vError - получение ошибки для отображения на форме при выполнении действия
********************************************************** */

create view vError

as

select p.ObjectID
      ,p.Retval
      ,rc.Message + case 
                      when isnull(p.Message, '') <> '' 
                      then ' [' + p.Message + ']'
                      else '' 
                     end 
         as Message
	  ,o.[MakeLogo]
      ,o.[Manufacturer]
      ,o.[DetailNumber]
	  ,o.Reference
	  ,o.CustomerSubId
  from pAccrualAction p (nolock)
  left join tOrders o (nolock)
         on o.OrderID = p.ObjectID
  left join tRetCode  rc (nolock)
         on rc.RetCode = p.Retval
where p.Spid   = @@spid
  and p.Retval <> 0

go
grant select on vError to public
go
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'vError', @desc = ''

select * from vError
