if OBJECT_ID('RetCodeInsert') is not null
    drop proc RetCodeInsert
go
/* 						
RetCodeInsert - 
 */
create proc RetCodeInsert
	          @RetCode           numeric(18,0)     
	         ,@Message           varchar(512)         
             ,@MessageEn         varchar(512)  = null 
as


insert tRetCode 
       (RetCode, Message, MessageEn)
select 
       @RetCode  
      ,@Message  
      ,@MessageEn
go
grant execute on RetCodeInsert to public
go
exec setOV 'RetCodeInsert', 'P', '20250529', '0'
go
 
