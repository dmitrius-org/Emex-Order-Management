drop proc if exists GroupSetFragileSign
/*
  create proc - групповое изменение признака Fragile
*/
go
create proc GroupSetFragileSign
              @Fragile bit          
as
  set nocount on;
  declare @r int = 0  

  declare @PartsUpdate as TABLE 
  (  OrderID           numeric(18, 0)
    ,Fragile	       bit
    ,FragileOld	       bit);

  update p
     set p.Fragile = @Fragile
  OUTPUT t.OrderID, INSERTED.Fragile, Deleted.Fragile INTO @PartsUpdate( OrderID, Fragile, FragileOld )  
	from tMarks m (nolock)
   inner join tOrders t (nolock)
           on t.OrderID = m.ID
   inner join vPartsUpdate p
           on p.Brand     = t.MakeLogo -- производитель
          and p.DetailNum = t.DetailNumber
		   
   where m.Spid = @@SPID
     and m.Type = 3

  delete pAuditInsert from pAuditInsert (rowlock) where spid=@@spid
  insert pAuditInsert
        (Spid, ObjectID, ObjectTypeID, ActionID, Comment)
  select @@Spid 
        ,o.OrderID       	         
        ,3        
        ,2      
        ,'Fragile: ''' +  cast(isnull(pu.FragileOld, 0) as varchar)  + ''' -> '''+ cast(isnull(pu.Fragile, 0) as varchar)  + ''''
    from tMarks m (nolock)
   inner join tOrders o (nolock)
           on o.OrderID  = m.ID
   inner join @PartsUpdate pu
           on pu.OrderID = o.OrderID
   where m.Spid = @@SPID
     and m.Type = 3
          
  exec MassAuditInsert

 exit_:
 return @r
go
grant exec on GroupSetFragileSign to public
go
exec setOV 'GroupSetFragileSign', 'P', '20250531', '1'
go
 