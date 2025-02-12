alter table tModel add  Number            int
--sp_who
if OBJECT_ID('vMarkOrderStateAction') is not null
    drop view vMarkOrderStateAction



update tCustomerGridOptions
 set Width=45
where [Column]='UnreadMessagesCount'