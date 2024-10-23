drop proc if exists ChatsMessageIsRead
go
create proc ChatsMessageIsRead 
              @MessageID numeric(18, 0)
	         --,@Flag     int = null
/*
  ChatsMessageIsRead -
*/           
as

  declare @Flag2     int
         ,@Flag      int
         ,@OrderID   numeric(18, 0)
         
    
  Update tChatsMessage
     set Flag = Flag | 2 -- 2 - Сообщение прочитано             
   where MessageID = @MessageID
 

  select @OrderID = c.OrderID,
         @Flag    = cm.Flag
    from tChatsMessage cm (nolock)
  inner join tChats c (nolock)
          on c.ChatID = cm.ChatID
   where cm.MessageID = @MessageID 


  if @OrderID > 0
  begin
    if @Flag&1>0 -- Сообщение от менеджера
    begin
      set @Flag2 = 32--32 - Сообщение от менеджера
    end
    else
    begin
      set @Flag2 = 2048-- 2048 - Сообщение от клиента
    end

    Update tOrders
       set flag = Flag & ~ @Flag2 
     where OrderID = @OrderID
  end

  exit_:
  return 0

go
grant exec on ChatsMessageIsRead to public
go
exec setOV 'ChatsMessageIsRead', 'P', '20241008', '1'
go
 

--exec ChatsMessageIsRead @ChatID = 1