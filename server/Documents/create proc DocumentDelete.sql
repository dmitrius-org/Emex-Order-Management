DROP PROCEDURE IF EXISTS DocumentDelete
/*
  DocumentDelete - Удаление документа

*/
go
create proc DocumentDelete
              @DocumentID        numeric(18, 0) 
as
  set nocount on

  declare @r               int = 0
         ,@ClientID        numeric(18, 0)

   select @ClientID = ClientID 
     from tDocuments (nolock)
    where DocumentID = @DocumentID
  

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      
      Begin tran
      
      delete tDocuments from tDocuments (rowlock) where DocumentID=@DocumentID
      
      Update r
         set r.Amount   = isnull((select sum(d2.Amount*d2.Type)
                                    from tDocuments d2 (nolock)
                                   where d2.ClientID   = r.ClientID
                                  ), 0)
        from tRest r (updlock) 
       where r.ClientID = @ClientID
      
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
grant exec on DocumentDelete to public
go
exec setOV 'DocumentDelete', 'P', '20241002', '1'
go