drop proc if exists ShipmentsSetFlag1C
/*
  ShipmentsSetFlag1C - установка признака 1C

*/
go
create proc ShipmentsSetFlag1C
              @IsFlag bit = null
as
  declare @r        int = 0        
		 ,@AuditID  numeric(18,0)

  select @IsFlag = isnull(@IsFlag, 0)   

  -- отбор объектов к выполнению действия
  Delete pAccrualAction from pAccrualAction (rowlock) where spid = @@spid

  -- проверки
  if not exists (select 1
                   from tMarks (nolock)
				  where Spid = @@spid
				    and Type = 10)
  begin
    set @r = 500 -- 'Отсутствуют объекты для выполнения операции!'
	goto exit_
  end

  --select max(sgn) from pAccrualAction
  --
  insert into pAccrualAction with (rowlock)
        (Spid,
		 ObjectID,
		 ActionID,
		 StateID,
		 NewStateID,
		 Retval,
		 sgn)
  Select @@Spid,
         s.ShipmentsID,
		 0,
		 0,
		 0,
		 0,
		 11 -- sgn
    from tMarks m (nolock)
   inner join tShipments s (nolock)
           on s.ShipmentsID = m.ID
  where m.Spid = @@spid
	and m.Type = 10

  update t
     set t.Flag = (ISNULL(t.Flag, 0) | IIF(ISNULL(@IsFlag, 0) = 1, 4, 0)) & IIF(ISNULL(@IsFlag, 0) = 1, ~0, ~4)
	from pAccrualAction p (nolock)
   inner join tShipments t (updlock)
           on t.ShipmentsID = p.ObjectID
   where p.Spid   = @@spid
	 and p.Retval = 0

  -- аудит
  delete pAuditInsert from pAuditInsert (rowlock) where spid=@@spid
  insert pAuditInsert with (rowlock)
        (Spid
        ,ObjectID
        ,ObjectTypeID
        ,ActionID
        ,Comment
        )
  select @@Spid 
       ,p.ObjectID       	         
       ,10        
       ,2 -- acUpdate        
       ,'Установка признака: 1C' 
  from pAccrualAction p (nolock)
 where p.Spid   = @@spid
   and p.Retval = 0
        
   exec MassAuditInsert

   if exists (select 1
                from pAccrualAction (nolock)
               where Spid   = @@SPID
                 and RetVal <> 0)
     set @r = 506 -- 'Ошибка!'

 exit_:
 return @r
go
grant exec on ShipmentsSetFlag1C to public
go
exec setOV 'ShipmentsSetFlag1C', 'P', '20250531', '0'
go
 