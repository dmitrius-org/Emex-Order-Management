if OBJECT_ID('sys_setTableDescription') is not null
  drop PROCEDURE [sys_setTableDescription]
go
CREATE PROCEDURE [sys_setTableDescription]
        @table nvarchar(128),  -- table name
        @column nvarchar(128) = null, -- column name, NULL if description for table
        @desc sql_variant     -- description text
AS
BEGIN
        SET NOCOUNT ON;

        IF @column IS NOT NULL
            IF NOT EXISTS (SELECT NULL FROM SYS.EXTENDED_PROPERTIES
            WHERE [major_id] = OBJECT_ID(@table) AND [name] = N'MS_Description'
                  AND [minor_id] = (SELECT [column_id]
                                    FROM SYS.COLUMNS WHERE [name] = @column AND [object_id] = OBJECT_ID(@table)))
                EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = @desc,
                                               @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE',
                                               @level1name = @table, @level2type = N'COLUMN', @level2name = @column;
            ELSE
                EXECUTE sp_updateextendedproperty @name = N'MS_Description',
                                                  @value = @desc, @level0type = N'SCHEMA', @level0name = N'dbo',
                                                  @level1type = N'TABLE', @level1name = @table,
                                                  @level2type = N'COLUMN', @level2name = @column;
        ELSE
            IF NOT EXISTS (SELECT NULL FROM SYS.EXTENDED_PROPERTIES
            WHERE [major_id] = OBJECT_ID(@table) AND [name] = N'MS_Description'
                  AND [minor_id] = 0)
                EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = @desc,
                                               @level0type = N'SCHEMA', @level0name = N'dbo',
                                               @level1type = N'TABLE', @level1name = @table;
            ELSE
                EXECUTE sp_updateextendedproperty @name = N'MS_Description', @value = @desc,
                                                  @level0type = N'SCHEMA', @level0name = N'dbo',
                                                  @level1type = N'TABLE', @level1name = @table;
END