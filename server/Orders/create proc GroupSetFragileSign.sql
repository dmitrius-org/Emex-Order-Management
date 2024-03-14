drop proc if exists GroupSetFragileSign
/*
  create proc - групповое изменение признака Fragile
*/
go
create proc GroupSetFragileSign
              @Fragile            nvarchar(512) = null -- Наименование факт            
as
  set nocount on;
  declare @r       int = 0
		 ,@AuditID  numeric(18,0)

  declare @PriceID as table(PriceID numeric(18, 0))

  update p
     set p.Restrictions	   = nullif(@Fragile, '')
	from tMarks m (nolock)
   inner join tOrders t (nolock)
           on t.OrderID = m.ID
   inner join tPrice p (updlock)
           on p.DetailNum = t.DetailNumber
		  and p.MakeLogo  = t.MakeLogo -- производитель
   where m.Spid = @@SPID
     and m.Type = 3

  delete pAuditInsert from pAuditInsert (rowlock) where spid=@@spid
  insert pAuditInsert
        (Spid, ObjectID, ObjectTypeID, ActionID, Comment)
  select @@Spid 
        ,o.OrderID       	         
        ,3        
        ,2      
        ,'Изменение признака Fragile: [' + isnull(@Fragile, '') + ']'
    from tMarks m (nolock)
   inner join tOrders o (nolock)
           on o.OrderID     = m.ID
   where m.Spid = @@SPID
     and m.Type = 3
          
  exec MassAuditInsert

 exit_:
 return @r
go
grant exec on GroupSetFragileSign to public
go
exec setOV 'GroupSetFragileSign', 'P', '20240314', '1'
go
 