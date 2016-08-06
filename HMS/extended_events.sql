--CREATE EVENT SESSION [monitor_procedures] ON SERVER 
--ADD EVENT sqlserver.rpc_completed 
--    ( 
--        ACTION    (package0.collect_system_time,package0.process_id,sqlserver.client_app_name,sqlserver.client_connection_id,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.nt_username,sqlserver.request_id,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.sql_text,sqlserver.transaction_id,sqlserver.transaction_sequence,sqlserver.username)
--        WHERE    (sqlserver.database_id = 8) 
--    ), 
--ADD EVENT sqlserver.module_end 
--    ( 
--        ACTION    (package0.collect_system_time,package0.process_id,sqlserver.client_app_name,sqlserver.client_connection_id,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.nt_username,sqlserver.request_id,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.sql_text,sqlserver.transaction_id,sqlserver.transaction_sequence,sqlserver.username)
--        WHERE    (sqlserver.database_id = 8) 
--    ) 
--ADD TARGET package0.ring_buffer 
--WITH 
--    (        
--        STARTUP_STATE=OFF 
--    ) 
--GO




--DROP EVENT SESSION [monitor_procedures] ON SERVER
--CREATE EVENT SESSION [monitor_procedures] ON SERVER 
--ADD EVENT sqlserver.module_end(
--    ACTION(package0.collect_system_time,package0.process_id,sqlserver.client_app_name,sqlserver.client_connection_id,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.nt_username,sqlserver.request_id,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.sql_text,sqlserver.transaction_id,sqlserver.transaction_sequence,sqlserver.username)
--    WHERE ([sqlserver].[database_id]=(8))),
--ADD EVENT sqlserver.rpc_completed(
--    ACTION(package0.collect_system_time,package0.process_id,sqlserver.client_app_name,sqlserver.client_connection_id,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.nt_username,sqlserver.request_id,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.sql_text,sqlserver.transaction_id,sqlserver.transaction_sequence,sqlserver.username)
--    WHERE ([sqlserver].[database_id]=(8))),
--ADD EVENT sqlserver.sp_statement_completed(
--    ACTION(package0.collect_system_time,package0.process_id,sqlserver.client_app_name,sqlserver.client_connection_id,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.nt_username,sqlserver.request_id,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.sql_text,sqlserver.transaction_id,sqlserver.transaction_sequence,sqlserver.username)
--    WHERE ([sqlserver].[database_id]=(8))),
--ADD EVENT sqlserver.sql_batch_completed(
--    ACTION(package0.collect_system_time,package0.process_id,sqlserver.client_app_name,sqlserver.client_connection_id,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.nt_username,sqlserver.request_id,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.sql_text,sqlserver.transaction_id,sqlserver.transaction_sequence,sqlserver.username)
--    WHERE ([sqlserver].[database_id]=(8))),
--ADD EVENT sqlserver.sql_statement_completed(
--    ACTION(package0.collect_system_time,package0.process_id,sqlserver.client_app_name,sqlserver.client_connection_id,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.nt_username,sqlserver.request_id,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.sql_text,sqlserver.transaction_id,sqlserver.transaction_sequence,sqlserver.username)
--    WHERE ([sqlserver].[database_id]=(8)))
--ADD TARGET package0.ring_buffer
--WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
--GO


DROP EVENT SESSION [monitor_procedures] ON SERVER
CREATE EVENT SESSION [monitor_procedures] ON SERVER
ADD EVENT sqlserver.module_start (
    ACTION ( package0.collect_system_time, package0.process_id,
    sqlserver.client_app_name, sqlserver.client_connection_id,
    sqlserver.client_hostname, sqlserver.client_pid, sqlserver.database_id,
    sqlserver.database_name, sqlserver.nt_username, sqlserver.request_id,
    sqlserver.session_id, sqlserver.session_nt_username, sqlserver.sql_text,
    sqlserver.transaction_id, sqlserver.transaction_sequence,
    sqlserver.username )
    WHERE ( [sqlserver].[database_id] = ( 8 ) ) ),
ADD EVENT sqlserver.rpc_starting (
    ACTION ( package0.collect_system_time, package0.process_id,
    sqlserver.client_app_name, sqlserver.client_connection_id,
    sqlserver.client_hostname, sqlserver.client_pid, sqlserver.database_id,
    sqlserver.database_name, sqlserver.nt_username, sqlserver.request_id,
    sqlserver.session_id, sqlserver.session_nt_username, sqlserver.sql_text,
    sqlserver.transaction_id, sqlserver.transaction_sequence,
    sqlserver.username )
    WHERE ( [sqlserver].[database_id] = ( 8 ) ) ),
ADD EVENT sqlserver.sp_statement_starting (
    ACTION ( package0.collect_system_time, package0.process_id,
    sqlserver.client_app_name, sqlserver.client_connection_id,
    sqlserver.client_hostname, sqlserver.client_pid, sqlserver.database_id,
    sqlserver.database_name, sqlserver.nt_username, sqlserver.request_id,
    sqlserver.session_id, sqlserver.session_nt_username, sqlserver.sql_text,
    sqlserver.transaction_id, sqlserver.transaction_sequence,
    sqlserver.username )
    WHERE ( [sqlserver].[database_id] = ( 8 ) ) ),
ADD EVENT sqlserver.sql_batch_starting (
    ACTION ( package0.collect_system_time, package0.process_id,
    sqlserver.client_app_name, sqlserver.client_connection_id,
    sqlserver.client_hostname, sqlserver.client_pid, sqlserver.database_id,
    sqlserver.database_name, sqlserver.nt_username, sqlserver.request_id,
    sqlserver.session_id, sqlserver.session_nt_username, sqlserver.sql_text,
    sqlserver.transaction_id, sqlserver.transaction_sequence,
    sqlserver.username )
    WHERE ( [sqlserver].[database_id] = ( 8 ) ) ),
ADD EVENT sqlserver.sql_statement_starting (
    ACTION ( package0.collect_system_time, package0.process_id,
    sqlserver.client_app_name, sqlserver.client_connection_id,
    sqlserver.client_hostname, sqlserver.client_pid, sqlserver.database_id,
    sqlserver.database_name, sqlserver.nt_username, sqlserver.request_id,
    sqlserver.session_id, sqlserver.session_nt_username, sqlserver.sql_text,
    sqlserver.transaction_id, sqlserver.transaction_sequence,
    sqlserver.username )
    WHERE ( [sqlserver].[database_id] = ( 8 ) ) )

--,
--ADD EVENT sqlserver.module_end (
--    ACTION ( package0.collect_system_time, package0.process_id,
--    sqlserver.client_app_name, sqlserver.client_connection_id,
--    sqlserver.client_hostname, sqlserver.client_pid, sqlserver.database_id,
--    sqlserver.database_name, sqlserver.nt_username, sqlserver.request_id,
--    sqlserver.session_id, sqlserver.session_nt_username, sqlserver.sql_text,
--    sqlserver.transaction_id, sqlserver.transaction_sequence,
--    sqlserver.username )
--    WHERE ( [sqlserver].[database_id] = ( 8 ) ) ),
--ADD EVENT sqlserver.rpc_completed (
--    ACTION ( package0.collect_system_time, package0.process_id,
--    sqlserver.client_app_name, sqlserver.client_connection_id,
--    sqlserver.client_hostname, sqlserver.client_pid, sqlserver.database_id,
--    sqlserver.database_name, sqlserver.nt_username, sqlserver.request_id,
--    sqlserver.session_id, sqlserver.session_nt_username, sqlserver.sql_text,
--    sqlserver.transaction_id, sqlserver.transaction_sequence,
--    sqlserver.username )
--    WHERE ( [sqlserver].[database_id] = ( 8 ) ) ),
--ADD EVENT sqlserver.sp_statement_completed (
--    ACTION ( package0.collect_system_time, package0.process_id,
--    sqlserver.client_app_name, sqlserver.client_connection_id,
--    sqlserver.client_hostname, sqlserver.client_pid, sqlserver.database_id,
--    sqlserver.database_name, sqlserver.nt_username, sqlserver.request_id,
--    sqlserver.session_id, sqlserver.session_nt_username, sqlserver.sql_text,
--    sqlserver.transaction_id, sqlserver.transaction_sequence,
--    sqlserver.username )
--    WHERE ( [sqlserver].[database_id] = ( 8 ) ) ),
--ADD EVENT sqlserver.sql_batch_completed (
--    ACTION ( package0.collect_system_time, package0.process_id,
--    sqlserver.client_app_name, sqlserver.client_connection_id,
--    sqlserver.client_hostname, sqlserver.client_pid, sqlserver.database_id,
--    sqlserver.database_name, sqlserver.nt_username, sqlserver.request_id,
--    sqlserver.session_id, sqlserver.session_nt_username, sqlserver.sql_text,
--    sqlserver.transaction_id, sqlserver.transaction_sequence,
--    sqlserver.username )
--    WHERE ( [sqlserver].[database_id] = ( 8 ) ) ),
--ADD EVENT sqlserver.sql_statement_completed (
--    ACTION ( package0.collect_system_time, package0.process_id,
--    sqlserver.client_app_name, sqlserver.client_connection_id,
--    sqlserver.client_hostname, sqlserver.client_pid, sqlserver.database_id,
--    sqlserver.database_name, sqlserver.nt_username, sqlserver.request_id,
--    sqlserver.session_id, sqlserver.session_nt_username, sqlserver.sql_text,
--    sqlserver.transaction_id, sqlserver.transaction_sequence,
--    sqlserver.username )
--    WHERE ( [sqlserver].[database_id] = ( 8 ) ) )
--ADD TARGET package0.ring_buffer
ADD TARGET package0.event_file ( SET filename='checkIn.xel') 
WITH ( MAX_MEMORY = 4096 KB ,
        EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS ,
        MAX_DISPATCH_LATENCY = 30 SECONDS ,
        MAX_EVENT_SIZE = 0 KB ,
        MEMORY_PARTITION_MODE = NONE ,
        TRACK_CAUSALITY = OFF ,
        STARTUP_STATE = OFF );
GO


