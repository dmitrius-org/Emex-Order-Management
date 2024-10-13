drop proc if exists ChatsMessageWrite
go
create proc ChatsMessageWrite 
 	          @ChatID   numeric(18, 0)
	         ,@ClientID numeric(18, 0)
             ,@UserID   numeric(18, 0)
	         ,@Message  nvarchar(512)
	         ,@Flag     int
/*
  ChatsMessageWrite -
*/           
as

  declare @ID        as ID
         ,@MessageID numeric(18, 0)
    
  insert into tChatsMessage with (rowlock)
        (     
         ChatID          
  	    ,ClientID        
        ,UserID          
  	    ,[Message]         
  	    ,Flag              
         ) 
  OUTPUT INSERTED.MessageID INTO @ID(ID)    
  select @ChatID   
        ,@ClientID 
        ,@UserID   
        ,@Message  
        ,@Flag     

  select @MessageID = max(ID) 
    from @ID

  exit_:
  return 0

go
grant exec on ChatsMessageWrite to public
go
exec setOV 'ChatsMessageWrite', 'P', '20241008', '1'
go
 

 --exec ChatsMessageWrite @ChatID = 1