if OBJECT_ID('GridOptionsInsert') is not null
    drop proc GridOptionsInsert
go
/* 						
GridOptionsInsert - 
 */
create proc GridOptionsInsert
              @Grid	    nvarchar(256)
             ,@Column	nvarchar(256)
as

 if not exists (select 1
                  from tGridOptions (updlock) 
                 Where UserID   = dbo.GetUserID() 
                   and Grid     = @Grid   
                   and [Column] = @Column)

  insert tGridOptions 
        (UserID, 
		 Grid, 
		 [Column], 
		 visible)
  select dbo.GetUserID() , @Grid, @Column, 1
go
grant execute on GridOptionsInsert to public

