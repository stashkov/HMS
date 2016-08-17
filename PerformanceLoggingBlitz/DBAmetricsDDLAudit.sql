-- script is based on the article
-- https://www.mssqltips.com/sqlservertip/2085/sql-server-ddl-triggers-to-track-all-database-changes/

USE DBAmetrics;
GO

CREATE TABLE dbo.DDLEvents
    (
      ID INT IDENTITY(1, 1)
             NOT NULL
             PRIMARY KEY ,
      EventDate DATETIME DEFAULT CURRENT_TIMESTAMP ,
      EventType NVARCHAR(64) ,
      EventDDL NVARCHAR(MAX) ,
      EventXML XML ,
      DatabaseName NVARCHAR(255) ,
      SchemaName NVARCHAR(255) ,
      ObjectName NVARCHAR(255) ,
      HostName VARCHAR(64) ,
      IPAddress VARCHAR(32) ,
      ProgramName NVARCHAR(255) ,
      LoginName NVARCHAR(255)
    );
GO

--CHANGE THIS VALUE TO YOUR DATABASE
--USE [your_database] !!!
USE hotel;
GO
INSERT  DBAmetrics.dbo.DDLEvents
        ( EventType ,
          EventDDL ,
          DatabaseName ,
          SchemaName ,
          ObjectName ,
          LoginName
        )
		-- we want all prcedures
        SELECT  'CREATE_PROCEDURE' ,
                OBJECT_DEFINITION([object_id]) ,
                DB_NAME() ,
                OBJECT_SCHEMA_NAME([object_id]) ,
                OBJECT_NAME([object_id]) ,
                'initial commit'
        FROM    sys.procedures
        UNION ALL
		-- also we want all the functions
        SELECT  'CREATE_FUNCTION' ,
                OBJECT_DEFINITION([object_id]) ,
                DB_NAME() ,
                OBJECT_SCHEMA_NAME([object_id]) ,
                OBJECT_NAME([object_id]) ,
                'initial commit'
        FROM    sys.objects
        WHERE   type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' );
GO

CREATE TRIGGER DDLTriggerDBLvlEvents ON DATABASE
    FOR DDL_DATABASE_LEVEL_EVENTS
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @EventData XML = EVENTDATA();
 
        DECLARE @ip VARCHAR(32) = ( SELECT  client_net_address
                                    FROM    sys.dm_exec_connections
                                    WHERE   session_id = @@SPID
                                  );
 
        INSERT  DBAmetrics.dbo.DDLEvents
                ( EventType ,
                  EventDDL ,
                  EventXML ,
                  DatabaseName ,
                  SchemaName ,
                  ObjectName ,
                  HostName ,
                  IPAddress ,
                  ProgramName ,
                  LoginName
                )
                SELECT  @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)') ,
                        @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)') ,
                        @EventData ,
                        DB_NAME() ,
                        @EventData.value('(/EVENT_INSTANCE/SchemaName)[1]', 'NVARCHAR(255)') ,
                        @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(255)') ,
                        HOST_NAME() ,
                        @ip ,
                        PROGRAM_NAME() ,
                        SUSER_SNAME();
    END;
GO

USE [master];
GO
CREATE TRIGGER DDLTriggerServLvlEvents ON ALL SERVER
    FOR DDL_SERVER_LEVEL_EVENTS
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @EventData XML = EVENTDATA();
 
        DECLARE @ip VARCHAR(32) = ( SELECT  client_net_address
                                    FROM    sys.dm_exec_connections
                                    WHERE   session_id = @@SPID
                                  );
 
        INSERT  DBAmetrics.dbo.DDLEvents
                ( EventType ,
                  EventDDL ,
                  EventXML ,
                  DatabaseName ,
                  SchemaName ,
                  ObjectName ,
                  HostName ,
                  IPAddress ,
                  ProgramName ,
                  LoginName
                )
                SELECT  @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)') ,
                        @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)') ,
                        @EventData ,
                        DB_NAME() ,
                        @EventData.value('(/EVENT_INSTANCE/SchemaName)[1]', 'NVARCHAR(255)') ,
                        @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(255)') ,
                        HOST_NAME() ,
                        @ip ,
                        PROGRAM_NAME() ,
                        SUSER_SNAME();
    END;
GO