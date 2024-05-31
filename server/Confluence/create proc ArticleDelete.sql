drop proc if exists ArticleDelete
/*
  ArticleDelete - Удаление Статьи
*/
go
create proc ArticleDelete
              @ArticleID            numeric(18,0) 
as
  declare @r       int = 0

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran
 

      delete tArticles
        from tArticles (rowlock)       
       where ArticleID = @ArticleID

      delete tArticleDetail
        from tArticleDetail (rowlock)       
       where ArticleID = @ArticleID

      commit tran
  END TRY  
  BEGIN CATCH  
      if @@TRANCOUNT > 0
        rollback tran
    
      set @r = -1
      insert tRetMessage(RetCode, Message) select @r,  ERROR_MESSAGE()  

      goto exit_     
  END CATCH  


 exit_:
 return @r
go
grant exec on ArticleDelete to public
go
exec setOV 'ArticleDelete', 'P', '20240326', '2'
go
