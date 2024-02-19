if OBJECT_ID('setOV') is not null
  drop proc setOV
go
create proc setOV
        @ObjectName nvarchar(256), 
		@Type       nvarchar(256),
        @ObjectDate nvarchar(256),
        @Version    nvarchar(256)
		
AS
begin
  SET NOCOUNT ON;

  if not exists (select 1
                   from tObjectVersion (nolock)
				  where ObjectName = @ObjectName
				    and [Type]     = @Type
				)
  begin
    --
    insert tObjectVersion
	      (ObjectName
		  ,ObjectDate
		  ,[Type]
		  ,[Version]
		  ,InDatetime
		  ,UpdDatetime)
	select @ObjectName
	      ,@ObjectDate
		  ,@Type
		  ,@Version
		  ,GetDate()
		  ,GetDate()
  end
  else
  begin
    --
    Update tObjectVersion
	   set ObjectDate = @ObjectDate
	      ,[Version]  = @Version
		  ,UpdDatetime= GetDate()
	  from tObjectVersion (updlock)
	 where ObjectName = @ObjectName
	   and [Type]     = @Type
  end

  declare @level1type nvarchar(255)
  select @level1type = case
                         when @Type = 'P'  then 'PROCEDURE'
                         when @Type = 'U'  then 'TABLE'
				         when @Type = 'V'  then 'VIEW'
						 when @Type = 'F'  then 'FUNCTION'
						-- when @Type = 'V'  then 'VIEW'
						 
                       end

  IF NOT EXISTS (SELECT NULL 
                   FROM SYS.EXTENDED_PROPERTIES
                  WHERE [major_id] = OBJECT_ID(@ObjectName) 
				    AND [name] = N'Version'
                    AND [minor_id] = 0)
  begin
    EXECUTE sp_addextendedproperty @name       = N'Version', 
                                   @value      = @Version,
                                   @level0type = N'SCHEMA', 
								   @level0name = N'dbo',
                                   @level1type = @level1type,
								   @level1name = @ObjectName;
  end
  else
  begin
    EXECUTE sp_updateextendedproperty 
	                               @name       = N'Version', 
                                   @value      = @Version,
                                   @level0type = N'SCHEMA', 
								   @level0name = N'dbo',
                                   @level1type = @level1type,
								   @level1name = @ObjectName;
  end

  IF NOT EXISTS (SELECT NULL 
                   FROM SYS.EXTENDED_PROPERTIES
                  WHERE [major_id] = OBJECT_ID(@ObjectName) 
				    AND [name] = N'Date'
                    AND [minor_id] = 0)
  begin
    EXECUTE sp_addextendedproperty @name       = N'Date', 
                                   @value      = @ObjectDate,
                                   @level0type = N'SCHEMA', 
								   @level0name = N'dbo',
                                   @level1type = @level1type,
								   @level1name = @ObjectName;
  end
  else
  begin
    EXECUTE sp_updateextendedproperty 
	                               @name       = N'Date', 
                                   @value      = @ObjectDate,
                                   @level0type = N'SCHEMA', 
								   @level0name = N'dbo',
                                   @level1type = @level1type,
								   @level1name = @ObjectName;
  end

end
go
grant all on setOV to public
go
exec setOV 'setOV', 'P', '20240101', '1.0.0.0'