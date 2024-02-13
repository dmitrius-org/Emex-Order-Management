if OBJECT_ID('GridOptionsVisible') is not null
    drop proc GridOptionsVisible
go
/* 						
create proc GridOptionsVisible - 
 */
create proc GridOptionsVisible
              @Grid	    nvarchar(256)
             ,@Column	nvarchar(256)
             ,@Visible	bit
as

  exec GridOptionsInsert
              @Grid	    = @Grid
             ,@Column	= @Column


  Update tGridOptions  
     set Visible = @Visible
	from tGridOptions (updlock) 
   Where UserID   = dbo.GetUserID() 
     and Grid     = @Grid   
     and [Column] = @Column

go
grant execute on GridOptionsVisible to public

