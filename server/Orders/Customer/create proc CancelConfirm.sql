drop proc if exists IsCancelApproval
drop proc if exists CancelConfirm
/*
  CancelConfirm - подтверждение отказа клиентом

  @OrderID  - ид заказа
*/
go

create proc CancelConfirm  
as
  declare @r int = 0

  Update o
     set o.Flag = o.Flag | 4096 -- Отказ подтвержден
    from tMarks m with (nolock index=pk_tMarks)
   inner join tOrders o with (updlock index=ao1)
           on o.OrderID = m.ID
  where m.Spid = @@spid
	and m.Type = 3

  -- аудит
  delete pAuditInsert from pAuditInsert with (rowlock index = ao1) where spid=@@spid
  insert pAuditInsert with (rowlock)
        (Spid
        ,ObjectID
        ,ObjectTypeID
        ,ActionID
        ,Comment
        ,Flag
        )
  select @@Spid 
       ,o.OrderID	         
       ,3        
       ,29 -- acCancelConfirm        
       ,'Отказ подтвержден' 
       ,1
    from tMarks m with (nolock index=pk_tMarks)
   inner join tOrders o with (nolock index=ao1)
           on o.OrderID = m.ID
  where m.Spid = @@spid
	and m.Type = 3
                
   exec MassAuditInsert

  exit_:

  return @r
GO
grant exec on CancelConfirm to public
go
exec setOV 'CancelConfirm', 'P', '20241206', '2'
go
 




