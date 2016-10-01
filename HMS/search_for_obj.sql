-- find last executed SP
USE VEGAUAT;
SELECT  OBJECT_NAME(object_id) ,
        *
FROM    sys.dm_exec_procedure_stats
WHERE   database_id = 8
ORDER BY last_execution_time DESC;


-- find tables that contain columnname like
USE VEGAUAT;
SELECT  OBJECT_NAME(object_id) AS tablename ,
        *
FROM    sys.columns
WHERE   name LIKE '%ROOMID%';


-- find SP that uses tablename
USE VEGAUAT;
SELECT DISTINCT
        so.name
FROM    syscomments sc
        INNER JOIN sysobjects so ON sc.id = so.id
WHERE   sc.text LIKE 'AdditionalKeyColumn';


USE VEGAUAT;
EXEC SearchAllTables '%10004%'


-- list foreign keys for a given table
EXEC sp_fkeys 'P5ACCOUNT'


--index usage statistics

SELECT DISTINCT OBJECT_NAME(OBJECT_ID) AS DatabaseName, last_user_update
FROM sys.dm_db_index_usage_stats
WHERE database_id = DB_ID( 'VEGAUAT')
--AND OBJECT_ID=OBJECT_ID('test')
ORDER BY sys.dm_db_index_usage_stats.last_user_update DESC


-- always used
--R5XMLTRANSTATUS
--R5SESSIONS
--TrackerPickup
--R5XMLTRANSTATUSHIST
--P5TEMPCORETICKET
--R5SCHEDULEDJOBS

USE VEGAUAT;
select *
from sys.sequences
WHERE start_value != current_value