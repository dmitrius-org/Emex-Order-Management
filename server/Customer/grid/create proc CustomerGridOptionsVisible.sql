if OBJECT_ID('CustomerGridOptionsVisible') is not null
    drop proc CustomerGridOptionsVisible
go
/* 						
create proc CustomerGridOptionsVisible - 
 */
create proc CustomerGridOptionsVisible
              @Grid	    nvarchar(256)
             ,@Column	nvarchar(256)
             ,@Visible	bit
             ,@ClientID numeric(18,0)
as

  exec CustomerGridOptionsInsert
              @Grid	    = @Grid
             ,@Column	= @Column
             ,@ClientID = @ClientID

  Update tCustomerGridOptions  
     set Visible  = @Visible
	from tCustomerGridOptions (updlock) 
   Where ClientID = @ClientID
     and Grid     = @Grid   
     and [Column] = @Column

go
grant execute on CustomerGridOptionsVisible to public
go
exec setOV 'CustomerGridOptionsVisible', 'P', '20240101', '0'
go