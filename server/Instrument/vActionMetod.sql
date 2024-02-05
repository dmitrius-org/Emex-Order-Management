if OBJECT_ID('vActionMetod') is not null
    drop view vActionMetod
go
/* **********************************************************						
vActionMetod - получение списка привязанных методов/процедур под действием
********************************************************** */
create view vActionMetod
as
select m.ActionID       ActionID
      ,m.StateID        StateID
	  ,mm.Metod         Metod
	  ,mm.MetodRollback MetodRollback
	  ,mm.Type          MetodType
	  ,mm.N             Number
  from tModel m (nolock) -- 
 inner join tModelMetod mm (nolock)
         on mm.ModelID = m.ModelID
 where m.InstrumentTypeID = 7
go
grant all on vActionMetod to public
--exec dbo.sys_setTableDescription @table = 'vMarkOrderStateAction', @desc = 'Список действий для состоянии отмеченных заказов'

select * from tModel
select * from vActionMetod