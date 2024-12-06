if OBJECT_ID('CustomerGridOptionsInsert') is not null
    drop proc CustomerGridOptionsInsert
go
/* 						
CustomerGridOptionsInsert - 
 */
create proc CustomerGridOptionsInsert
              @Grid	    nvarchar(256)
             ,@Column	nvarchar(256)
             ,@ClientID numeric(18,0)
as

 if not exists (select 1
                  from tCustomerGridOptions (updlock) 
                 Where ClientID   = @ClientID
                   and Grid     = @Grid   
                   and [Column] = @Column)

  insert tCustomerGridOptions 
        (ClientID, 
		 Grid, 
		 [Column], 
		 visible)
  select @ClientID, @Grid, @Column, 1
go
grant execute on CustomerGridOptionsInsert to public
go
exec setOV 'CustomerGridOptionsInsert', 'P', '20240101', '0'
go
 
