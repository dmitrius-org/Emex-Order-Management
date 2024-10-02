if OBJECT_ID('ClientGridOptionsInsert') is not null
    drop proc ClientGridOptionsInsert
go
/* 						
ClientGridOptionsInsert - 
 */
create proc ClientGridOptionsInsert
              @Grid	    nvarchar(256)
             ,@Column	nvarchar(256)
             ,@ClientID numeric(18, 0)
as

 if not exists (select 1
                  from tClientGridOptions (updlock) 
                 Where ClientID = @ClientID
                   and Grid     = @Grid   
                   and [Column] = @Column)

  insert tClientGridOptions 
        (ClientID, 
		 Grid, 
		 [Column], 
		 visible)
  select @ClientID, @Grid, @Column, 1
go
grant execute on ClientGridOptionsInsert to public
go
exec setOV 'ClientGridOptionsInsert', 'P', '20240101', '0'
go
 
