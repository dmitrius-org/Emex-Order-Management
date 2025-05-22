drop proc if exists GroupDetailNameUpdate
/*
  GroupDetailNameUpdate - групповое изменение данных по заказу/детали
*/
go
create proc GroupDetailNameUpdate
              @DetailName             nvarchar(512) = null -- Наименование факт            
as
  set nocount on;
  declare @r            int = 0

  declare @PartsUpdate as TABLE 
  (  OrderID           numeric(18, 0)
  	,DetailName        varchar(256)   -- Наименование детали 
  	,DetailNameOld     varchar(256)   -- Наименование детали 
  );

  update p
     set p.DetailNameF	   = nullif(@DetailName, '')
  OUTPUT t.OrderID, INSERTED.DetailNameF, Deleted.DetailNameF INTO @PartsUpdate(OrderID, DetailName, DetailNameOld )  
	from tMarks m (nolock)
   inner join tOrders t (nolock)
           on t.OrderID = m.ID
   inner join vPartsUpdate p (updlock)
           on p.Brand     = t.MakeLogo -- производитель
          and p.DetailNum = t.DetailNumber
   where m.Spid = @@SPID
     and m.Type = 3

  delete pAuditInsert from pAuditInsert (rowlock) where spid=@@spid
  insert pAuditInsert with (rowlock)
        (Spid
        ,ObjectID
        ,ObjectTypeID
        ,ActionID
        ,Comment
        )
  select @@Spid 
        ,o.OrderID       	         
        ,3        
        ,2      
        , 'Изменение названия: ''' + isnull(pu.DetailNameOld,'') + ''' -> '''+ isnull(pu.DetailName,'') +  ''''
    from tMarks m (nolock)
   inner join tOrders o (nolock)
           on o.OrderID = m.ID
   inner join @PartsUpdate pu
           on pu.OrderID = o.OrderID
   where m.Spid = @@SPID
     and m.Type = 3
          
  exec MassAuditInsert

 exit_:
 return @r
go
grant exec on GroupDetailNameUpdate to public
go
exec setOV 'GroupDetailNameUpdate', 'P', '20250531', '1'
go
 