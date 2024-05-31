drop proc if exists ArticleAdd
/*
  ArticleAdd - 
*/
go
create proc ArticleAdd
              @ArticleID     numeric(18,0) out
             ,@ParentID      numeric(18,0) 
             ,@Name          nvarchar(256)
             ,@Comment       nvarchar(512)= null  
			 ,@Type          int
     
as
  declare @r int = 0

  declare @ID as table (ID numeric(18, 0))
  insert into tArticles
         (
          ParentID
         ,Name
         ,Comment
		 ,Type
         ,UserID
         )
  OUTPUT INSERTED.ArticleID INTO @ID
  select @ParentID    
        ,@Name	     
        ,@Comment	 
		,@Type
		,dbo.GetUserID()


   Select @ArticleID = ID from @ID

 exit_:
 return @r
go
grant exec on ArticleAdd to public
go
exec setOV 'ArticleAdd', 'P', '20240412', '1'
go
