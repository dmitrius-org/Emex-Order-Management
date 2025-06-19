if OBJECT_ID('SupplierPricesLoad') is not null
    drop proc SupplierPricesLoad
/*
  SupplierPricesLoad - 
  @SuppliersID - поставщик
  @Direction   - 0 - с постоянной во временную
                 1 - с временной в постоянную
*/
go
create proc SupplierPricesLoad
              @SuppliersID    numeric(18, 0)  
             ,@Direction      int = null
as
  set nocount on
  declare @r int

  select @R         = 0
        ,@Direction = isnull(@Direction, 0)

  if @Direction = 0
  begin

	 delete pSupplierPrices from pSupplierPrices (rowlock) where spid = @@spid
	 insert pSupplierPrices with (rowlock)  
			(
             Spid                         
            ,SupplierPricesID  
            ,SuppliersID	   
            ,Name              
            ,Comment           
            ,DeliveryTerm	   
            ,DeliveryType	   
            ,InWorkingDays     
            ,ShowInSearch      
            ,Flag              
			)
     select @@SPID
           ,SupplierPricesID  
           ,SuppliersID	   
           ,Name              
           ,Comment           
           ,DeliveryTerm	   
           ,DeliveryType	   
           ,InWorkingDays     
           ,ShowInSearch      
           ,Flag   
       from tSupplierPrices (nolock)
      where SuppliersID = @SuppliersID
  end
  else
  begin

    delete tSupplierPrices
	  from tSupplierPrices t  (rowlock)
	 where t.SuppliersID = @SuppliersID
	   and not exists ( select 1
	                      from pSupplierPrices p (nolock)
						 where p.Spid               = @@spid
						   and p.SupplierPricesID = t.SupplierPricesID
					   )

	  insert tSupplierPrices with (rowlock)
			 (
             SuppliersID	   
            ,Name              
            ,Comment           
            ,DeliveryTerm	   
            ,DeliveryType	   
            ,InWorkingDays     
            ,ShowInSearch      
            ,Flag 
			)
     select @SuppliersID  
            ,Name              
            ,Comment           
            ,DeliveryTerm	   
            ,DeliveryType	   
            ,InWorkingDays     
            ,ShowInSearch      
            ,Flag 
       from pSupplierPrices (nolock)
      where Spid = @@Spid --SuppliersID = @SuppliersID
	    and isnull(SupplierPricesID, 0) = 0

     Update t
        set t.SuppliersID	 = p.SuppliersID	  
           ,t.Name           = p.Name             
           ,t.Comment        = p.Comment          
           ,t.DeliveryTerm	 = p.DeliveryTerm	  
           ,t.DeliveryType	 = p.DeliveryType	  
           ,t.InWorkingDays  = p.InWorkingDays    
           ,t.ShowInSearch   = p.ShowInSearch     
           ,t.Flag           = p.Flag           
       from pSupplierPrices p (nolock)
      inner join tSupplierPrices t (updlock)
              on t.SuppliersID      = @SuppliersID
             and t.SupplierPricesID = p.SupplierPricesID
      where p.Spid = @@Spid 
  end

exit_:
return @r
go
grant exec on SupplierPricesLoad to public
go
exec setOV 'SupplierPricesLoad', 'P', '20250618', '0'
go