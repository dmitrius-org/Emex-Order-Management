drop proc if exists ArticleDetailEdit
/*
  ArticleDetailEdit - 
*/
go
create proc ArticleDetailEdit
              @ArticleID      numeric(18,0)
             ,@Text           varchar(max)  
as
  declare @r       int = 0


  if not exists (select 1
                   from tArticleDetail (nolock)
				  where ArticleID = @ArticleID)

  begin
    insert tArticleDetail ( ArticleID, [Text] ) select @ArticleID, @Text
  end
  else
  begin
    Update tArticleDetail
       set [Text]    = @Text
     where ArticleID = @ArticleID
  end


 exit_:
 return @r
go
grant exec on ArticleDetailEdit to public
go
exec setOV 'ArticleDetailEdit', 'P', '20240325', '0'
go
