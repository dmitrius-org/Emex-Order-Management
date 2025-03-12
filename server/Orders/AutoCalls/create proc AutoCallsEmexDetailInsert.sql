if OBJECT_ID('AutoCallsEmexDetailInsert') is not null
    drop proc AutoCallsEmexDetailInsert
/*
  AutoCallsEmexDetailInsert - 
*/
go
create proc AutoCallsEmexDetailInsert
              @ID               numeric(18,0) = null output -- Идентификатор добавленной записи  
             ,@Subject          varchar(256)     -- Тема
             ,@Status           varchar(32)      -- Cтатус обращения в emex
             ,@Number           varchar(32)      -- Номер обращения в emex
             ,@DetailNumber     varchar(32)      -- Номер детали
             ,@Author           varchar(128)     -- Автор
             ,@Type             int              -- Тип сообщения: 0 - от нас; 1- от них   
             ,@Message          varchar(max)     -- Тело сообщения
             ,@InDateTime       datetime = null  -- Дата

as
  declare @r int = 0

  DECLARE @tID TABLE (ID numeric(18,0));

  INSERT INTO [dbo].[tAutoCallsToEmexDetail]
           ([Subject]
           ,[Status]
           ,[Number]
           ,[DetailNumber]
           ,[Author]
           ,[Type]
           ,[Message]
           ,[InDateTime]
           ,[UpdDateTime])
     OUTPUT inserted.ID into @tID
     SELECT
            @Subject       
           ,@Status        
           ,@Number        
           ,@DetailNumber  
           ,@Author        
           ,@Type          
           ,@Message 
           ,isnull(nullif(@InDateTime, ''), getdate())
           ,isnull(nullif(@InDateTime, ''), getdate())

  Select @ID = max(ID)
    from @tID

exit_:
return @r
go
grant exec on AutoCallsEmexDetailInsert to public
go
exec setOV 'AutoCallsEmexDetailInsert', 'P', '20250311', '3'
go

