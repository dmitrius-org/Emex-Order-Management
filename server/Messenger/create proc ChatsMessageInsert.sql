drop proc if exists ChatsMessageInsert
go
create proc ChatsMessageInsert 
              @MessageID numeric(18, 0) out
 	         ,@ChatID   numeric(18, 0)
             ,@UserID   numeric(18, 0)
	         ,@Message  nvarchar(512)
	         ,@Flag     int
/*
  ChatsMessageInsert - добавление сообщения в чат
*/           
as

  declare @ID        as ID
         ,@Flag2     int
         ,@OrderID  numeric(18, 0)
    
  insert into tChatsMessage with (rowlock)
        (     
         ChatID              
        ,UserID          
  	    ,[Message]         
  	    ,Flag              
         ) 
  OUTPUT INSERTED.MessageID INTO @ID(ID)    
  select @ChatID   
        ,@UserID   
        ,@Message  
        ,isnull(@Flag, 0)     

  select @MessageID = max(ID) 
    from @ID


  if @MessageID > 0
  begin
    Select @OrderID = OrderID 
      from tChats (nolock)
     where ChatID = @ChatID

    if isnull(@OrderID, 0)=0
      goto exit_

    if @Flag&1>0
    begin
      set @Flag2 = 32--32 - Сообщение от менеджера
    end
    else
    begin
      set @Flag2 = 2048-- 2048 - Сообщение от клиента
    end

    Update tOrders
       set flag = Flag|@Flag2 
     where OrderID = @OrderID
  end

  exit_:
  return 0

go
grant exec on ChatsMessageInsert to public
go
exec setOV 'ChatsMessageInsert', 'P', '20250129', '2'
go
 

 --exec ChatsMessageInsert @ChatID = 1