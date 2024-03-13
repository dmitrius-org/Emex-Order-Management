if OBJECT_ID('ClientReliationUpdateP') is not null
    drop proc ClientReliationUpdateP
/*
  ClientReliationUpdateP - Обновление/изменение связи c клиентом во временной таблиц
*/
go
create proc ClientReliationUpdateP
              @ID                  numeric(18,0)  
             ,@ClientID            numeric(18,0) 
             ,@LinkID              numeric(18,0) 	
             ,@LinkType            numeric(18,0) 
             --

as
  declare @r int = 0

  if isnull(@LinkID  , 0) = 0
  begin
    set @r = 12 -- 'Не заполнено обязательное поле!'
    goto exit_
  end

  delete tRetMessage from tRetMessage (rowlock) where spid=@@spid

  Update pClientReliation
     set 
          ClientID            = @ClientID
         ,LinkID              =	@LinkID
         ,LinkType            = @LinkType
    from pClientReliation (updlock)
   where ID = @ID

exit_:
return @r
go
grant exec on ClientReliationUpdateP to public
go
exec setOV 'ClientReliationUpdateP', 'P', '20240101', '0'
go