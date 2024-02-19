drop view if exists vInstrumentTree
go
/* **********************************************************						
vInstrumentTree - структура меню настроек и состояний документообора
********************************************************** */

create view vInstrumentTree
as

select i.InstrumentID      as ID
      ,i.PID               as PID
	  ,isnull(ii.InstrumentTypeID, 0)  as PType
      ,i.Name              as Caption
      ,i.InstrumentTypeID  as ITypeID
	  ,0                   as StateID
	  ,0                   as ModelID
	  ,0                   as TStateID
	  ,i.Flag              as Flag
  from tInstrument i (nolock)   
  left join tInstrument ii (nolock) 
         on ii.InstrumentID = i.PID
union all
-- состояния
select m.ModelID           as ID
      ,m.InstrumentID      as PID
	  ,i.InstrumentTypeID  as PType
      ,n.Name              as Caption
      ,m.InstrumentTypeID  as ITypeID
	  ,m.StateID           as StateID
	  ,m.InstrumentID      as ModelID
	  ,0                   as TStateID
	  ,m.Flag              as Flag
  from tModel m (nolock) 
 inner join tInstrument i (nolock)
         on i.InstrumentID = m.InstrumentID 
 inner join tNodes n (nolock)
         on n.NodeID = m.StateID
		and n.Type   = 0
 where m.ActionID = 0 
union all
-- действия
select m.ModelID           as ID
      ,mc.ModelID          as PID
	  ,mc.InstrumentTypeID as PType
      ,n.Name              as Caption
      ,m.InstrumentTypeID  as ITypeID
	  ,m.StateID           as StateID
	  ,m.InstrumentID      as ModelID
	  ,m.TargetStateID     as TStateID
	  ,m.Flag              as Flag
  from tModel m (nolock) 
 inner join tNodes n (nolock)
         on n.NodeID = m.ActionID
		and n.Type   = 1
 inner join tModel mc (nolock)
         on mc.StateID = m.StateID
		and mc.ActionID = 0 

go
grant all on vInstrumentTree to public
go
exec setOV 'vInstrumentTree', 'V', '20240101', '1.0.0.0'
go
 
