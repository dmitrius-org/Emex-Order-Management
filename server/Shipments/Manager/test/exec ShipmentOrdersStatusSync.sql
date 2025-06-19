
--begin tran

delete from tMarks where spid= @@spid


insert tMarks
       (
         Spid
        ,Type
        ,ID
       )
select @@spid, 10 , 999

exec ShipmentOrdersStatusSync


select * from tMarks (rowlock) where spid = @@Spid
select * from pAccrualAction (rowlock) where spid = @@Spid

--rollback tran
--commit tran