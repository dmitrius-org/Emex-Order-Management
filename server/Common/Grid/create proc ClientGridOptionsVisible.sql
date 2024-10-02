if OBJECT_ID('ClientGridOptionsVisible') is not null
    drop proc ClientGridOptionsVisible
go
/* 						
create proc ClientGridOptionsVisible - 
 */
create proc ClientGridOptionsVisible
              @Grid	    nvarchar(256)
             ,@Column	nvarchar(256)
             ,@Visible	bit
             ,@ClientID numeric(18, 0)
as

  exec GridOptionsInsert
              @Grid	    = @Grid
             ,@Column	= @Column


  Update tClientGridOptions  
     set Visible = @Visible
	from tClientGridOptions (updlock) 
   Where ClientID = @ClientID
     and Grid     = @Grid   
     and [Column] = @Column

go
grant execute on ClientGridOptionsVisible to public
go
exec setOV 'ClientGridOptionsVisible', 'P', '20240101', '0'
go