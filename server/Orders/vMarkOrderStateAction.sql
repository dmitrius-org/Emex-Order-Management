if OBJECT_ID('vMarkOrderStateAction') is not null
    drop view vMarkOrderStateAction
go
/* **********************************************************						
vMarkOrderStateAction - список действий для состоянии отмеченных заказов
********************************************************** */
create view vMarkOrderStateAction
as 

with Instrument (  InstrumentID ) as (
select ia.InstrumentID
  from tObjectType o (nolock)
 inner join tInstrument ia (nolock)
         on ia.ObjectTypeID = o.ObjectTypeID
 where o.Brief = 'Заказы')

select o.OrderID       OrderID
	  ,mo.ActionID     ActionID
	  ,n.Brief         ActionBrief
	  ,n.Name          ActionName
  from Instrument i 
 inner join tMarks m (nolock)
         on m.Spid = @@spid  
        and m.Type = 3
 inner join tOrders o (nolock)
         on o.OrderID = m.ID
 inner join tModel mo (nolock) -- 
         on mo.StateID = o.StatusID
        and mo.InstrumentID = i.InstrumentID
 inner join tNodes n (nolock)
         on n.NodeID = mo.ActionID
		and n.Type   = 1 -- действие
go
grant select on vMarkOrderStateAction to public

