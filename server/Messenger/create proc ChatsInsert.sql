drop proc if exists ChatsInsert
go
create proc ChatsInsert 
 	          @ChatID   numeric(18, 0) out
	         ,@OrderID  numeric(18, 0)
             ,@ClientID numeric(18, 0)
	         ,@Flag     int
             ,@Name     varchar(256) = null
/*
  ChatsInsert -
*/           
as

  declare @ID        as ID
         ,@MessageID numeric(18, 0)

  select @ChatID= ChatID
    from tChats with (nolock index=ao3)
   where OrderID = @OrderID 

  if isnull(@ChatID, 0) = 0
  begin
      insert tChats with (rowlock)   
             (
              ClientID
             ,OrderID
             ,Flag
             ,Name
             )
      OUTPUT INSERTED.ChatID INTO @ID(ID)   
      select @ClientID
            ,@OrderID
            ,@Flag   
            ,@Name
      
      select @ChatID = max(ID) from @ID
  end

  exit_:
  return 0

go
grant exec on ChatsInsert to public
go
exec setOV 'ChatsInsert', 'P', '20250127', '2'
go
 

 --exec ChatsInsert @ChatID = 1