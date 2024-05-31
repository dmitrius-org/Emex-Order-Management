drop proc if exists ArticleUpdate
/*
  ArticleUpdate - 
*/
go
create proc ArticleUpdate
              @ArticleID     numeric(18,0) 
             ,@ParentID      numeric(18,0) = null
             ,@Name          nvarchar(256)
             ,@Comment       nvarchar(512) = null  
			 
as
  declare @r       int = 0

  Update tArticles
     set ParentID    = isnull(@ParentID, ParentID)	
        ,Name        = @Name
	    ,Comment     = @Comment  
		,updDatetime = getdate()
   where ArticleID = @ArticleID

 exit_:
 return @r
go
grant exec on ArticleUpdate to public
go
exec setOV 'ArticleUpdate', 'P', '20240412', '1'
go
