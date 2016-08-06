--USE VEGAUAT;
CREATE PROC SearchAllTables
    (
      @SearchStr NVARCHAR(100)
    )
AS
    BEGIN

-- Copyright � 2002 Narayana Vyas Kondreddi. All rights reserved.
-- Purpose: To search all columns of all tables for a given search string
-- Written by: Narayana Vyas Kondreddi
-- Site: http://vyaskn.tripod.com
-- Tested on: SQL Server 7.0 and SQL Server 2000
-- Date modified: 28th July 2002 22:50 GMT

        DECLARE @Results TABLE
            (
              ColumnName NVARCHAR(370) ,
              ColumnValue NVARCHAR(3630)
            );

        SET NOCOUNT ON;

        DECLARE @TableName NVARCHAR(256) ,
            @ColumnName NVARCHAR(128) ,
            @SearchStr2 NVARCHAR(110);
        SET @TableName = '';

        WHILE @TableName IS NOT NULL
            BEGIN
                SET @ColumnName = '';
                SET @TableName = ( SELECT   MIN(QUOTENAME(TABLE_SCHEMA) + '.'
                                                + QUOTENAME(TABLE_NAME))
                                   FROM     INFORMATION_SCHEMA.TABLES
                                   WHERE    TABLE_TYPE = 'BASE TABLE'
                                            AND QUOTENAME(TABLE_SCHEMA) + '.'
                                            + QUOTENAME(TABLE_NAME) > @TableName
                                            AND OBJECTPROPERTY(OBJECT_ID(QUOTENAME(TABLE_SCHEMA)
                                                              + '.'
                                                              + QUOTENAME(TABLE_NAME)),
                                                              'IsMSShipped') = 0
                                 );

                WHILE ( @TableName IS NOT NULL )
                    AND ( @ColumnName IS NOT NULL )
                    BEGIN
                        SET @ColumnName = ( SELECT  MIN(QUOTENAME(COLUMN_NAME))
                                            FROM    INFORMATION_SCHEMA.COLUMNS
                                            WHERE   TABLE_SCHEMA = PARSENAME(@TableName,
                                                              2)
                                                    AND TABLE_NAME = PARSENAME(@TableName,
                                                              1)
                                                    AND DATA_TYPE IN ( 'char',
                                                              'varchar',
                                                              'nchar',
                                                              'nvarchar' )
                                                    AND QUOTENAME(COLUMN_NAME) > @ColumnName
                                          );

                        IF @ColumnName IS NOT NULL
                            BEGIN
                                INSERT  INTO @Results
                                        EXEC
                                            ( 'SELECT ''' + @TableName + '.'
                                              + @ColumnName + ''', LEFT('
                                              + @ColumnName + ', 3630) 
                FROM ' + @TableName + ' (NOLOCK) ' + ' WHERE ' + @ColumnName
                                              + ' LIKE ' + @SearchStr2
                                            );
                            END;
                    END; 
            END;
        SELECT  ColumnName ,
                ColumnValue
        FROM    @Results;
    END;
