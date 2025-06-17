if OBJECT_ID('GetMarkOrderStateAction') is not null
    drop proc GetMarkOrderStateAction
go
/* **********************************************************
GetMarkOrderStateAction - список действий для состояний отмеченных заказов
********************************************************** */
create proc GetMarkOrderStateAction
as 

declare @State as table (StatusID    numeric(18, 0), 
                         ActionID    numeric(18, 0), 
                         ActionName  varchar(255),
                         Number      int)

;with Instrument (  InstrumentID ) as (
select top 1
       ia.InstrumentID
  from tObjectType o (nolock)
 inner join tInstrument ia (nolock)
         on ia.ObjectTypeID = o.ObjectTypeID
 where o.Brief = 'Заказы')

insert @State
      (StatusID, ActionID, ActionName, Number)

select distinct 
       mo.StateID     
      ,mo.ActionID          
      ,n.Name 
      ,isnull(mo.Number, 0)
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

DELETE FROM @State
 WHERE (
       SELECT COUNT(DISTINCT StatusID) 
         FROM @State
        ) > 1;


Select ActionID, ActionName
  from @State
order by Number

go
grant exec on GetMarkOrderStateAction to public
go
exec setOV 'GetMarkOrderStateAction', 'P', '20250616', '1'
go

--exec GetMarkOrderStateAction