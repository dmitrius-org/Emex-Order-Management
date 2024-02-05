if OBJECT_ID('ClientTypeInsert') is not null
    drop proc ClientTypeInsert
/*
  ClientTypeInsert - добавление Типа клиента
*/
go
create proc ClientTypeInsert
              @ClientTypeID      numeric(18,0) output
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
              where u.Name = @Name)
  begin
    set @r = 120  -- Тип клиент с заданным наименованием существует!
    goto exit_
  end

  delete tRetMessage from tRetMessage (rowlock) where spid=@@spid

  insert into tClientType
        (
         Name	            
		,Comment          
		,Prepayment       
		,PrepaymentAmount 
		,Margin       
        ,Reliability
        ,Discount
        ,Commission        
		,IsActive         
        )
  OUTPUT INSERTED.ClientTypeID INTO @ID
  select @Name	            
		,@Comment          
		,@Prepayment       
		,@PrepaymentAmount 
		,@Margin 
        ,@Reliability
        ,@Discount
        ,@Commission
		,@IsActive   
		 
  Select @ClientTypeID = ID from @ID

exit_:
return @r
go
grant exec on ClientTypeInsert to public
go
