if OBJECT_ID('ClientAuthorizationClear') is not null
    drop proc ClientAuthorizationClear
/*
  ClientAuthorizationClear - удаление клиента
*/
go
create proc ClientAuthorizationClear
              @ClientID          numeric(18,0)  --  
as
  declare @r int = 0

  --DECLARE @ID TABLE (ID numeric(18,0));

  --if exists (select 1 
  --             from tOrders o (nolock)
  --            where o.ClientID  = @ClientID
  --           )
  --begin
  --  set @r = 101-- 'Удаление запрещено, Клиент используется в таблице заказов!'
  --  goto exit_
  --end 

  --BEGIN TRY 
  --    delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
  --    Begin tran

 	   delete ua
         from tClients c (nolock) 
         inner join tUsersAuthorization ua (rowlock)
                 on ua.UserName = c.Email
        where c.ClientID = @ClientID

  --    commit tran
  --END TRY  
  --BEGIN CATCH  
  --    if @@TRANCOUNT > 0
  --      rollback tran
    
  --    set @r = -1
  --    insert tRetMessage(RetCode, Message) select @r,  ERROR_MESSAGE()  

  --    goto exit_     
  --END CATCH  
 
 exit_:
 return @r
go
grant exec on ClientAuthorizationClear to public
go
exec setOV 'ClientAuthorizationClear', 'P', '20240101', '0'
go

 