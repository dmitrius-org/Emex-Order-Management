if OBJECT_ID('ClientTypeUpdate') is not null
    drop proc ClientTypeUpdate
/*
  ClientTypeUpdate - изменение Типа клиента
*/
go
create proc ClientTypeUpdate
              @ClientTypeID      numeric(18,0) 
             ,@Name	             nvarchar(256) 
             ,@Comment           nvarchar(512) 
             ,@Prepayment        bit           
             ,@PrepaymentAmount  money         
             ,@Margin            money  -- Наценка в процентах   
             ,@Reliability       money  -- Вероятность поставки 
             ,@Discount          money  -- Скидка 
             ,@Commission        money  -- Комиссия эквайера              
             ,@IsActive          bit           

as
  declare @r int = 0

  DECLARE @ID TABLE (ID numeric(18,0));

  if exists (select 1 
               from tClientType u (nolock)
              where u.Name         = @Name
			    and u.ClientTypeID <> @ClientTypeID)
  begin
    set @r = 120  -- Тип клиент с заданным наименованием существует!
    goto exit_
  end

  delete tRetMessage from tRetMessage (rowlock) where spid=@@spid

  Update tClientType
     set Name	           =@Name
		,Comment           =@Comment
		,Prepayment        =@Prepayment
		,PrepaymentAmount  =@PrepaymentAmount
		,Margin            =@Margin
        ,Reliability       =@Reliability -- Вероятность поставки 
        ,Discount          =@Discount    -- Скидка 
        ,Commission        =@Commission  -- Комиссия эквайера    
		,IsActive          =@IsActive
   where ClientTypeID = @ClientTypeID		 	            

exit_:
return @r
go
grant exec on ClientTypeUpdate to public
go
exec setOV 'ClientTypeUpdate', 'P', '20240101', '1.0.0.0'
go
