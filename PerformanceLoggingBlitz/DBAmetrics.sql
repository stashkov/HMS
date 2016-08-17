-- Based on the wonderful SQL Scripts from:
-- https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit

--Prerequisites
--1. Stored procedure sp_BlitzFirst should be deployed on master database


--Overview of this script
--1. Creates a new databse DBAmetrics
--2. Creates a job that executes sp_BlitzFirst every 10 minutes and collect all the data to DBAmetrics database


--create database for collecting metrics
PRINT 'Creating database [DBAmetrics] to collect metrics later'
--
CREATE DATABASE [DBAmetrics]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBAmetrics', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.EPITOME\MSSQL\DATA\DBAmetrics.mdf' , SIZE = 5120KB , MAXSIZE = 5120000KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DBAmetrics_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.EPITOME\MSSQL\DATA\DBAmetrics_log.ldf' , SIZE = 1024KB , MAXSIZE = 1024000KB , FILEGROWTH = 10240KB )
GO
ALTER DATABASE [DBAmetrics] SET COMPATIBILITY_LEVEL = 120
GO
ALTER DATABASE [DBAmetrics] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBAmetrics] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBAmetrics] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBAmetrics] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBAmetrics] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBAmetrics] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBAmetrics] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBAmetrics] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [DBAmetrics] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBAmetrics] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBAmetrics] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBAmetrics] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBAmetrics] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBAmetrics] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBAmetrics] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBAmetrics] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DBAmetrics] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBAmetrics] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBAmetrics] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBAmetrics] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBAmetrics] SET  READ_WRITE 
GO
ALTER DATABASE [DBAmetrics] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DBAmetrics] SET  MULTI_USER 
GO
ALTER DATABASE [DBAmetrics] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBAmetrics] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DBAmetrics] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DBAmetrics]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [DBAmetrics] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

PRINT '[DBAmetrics] was created'

-- create SQL Agent job which collects metrics every 10 minutes
--create SQL Agent job that collect results from sp_BlitzFirst execution every 5 minutes

USE [msdb]
GO

/****** Object:  Job [BlitzFirstMetrics]    Script Date: 12-Aug-16 6:32:28 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 12-Aug-16 6:32:29 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'BlitzFirstMetrics', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'collects metrics every 5 minutes for a given DB', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'vstashkov', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [sp blitzfirst]    Script Date: 12-Aug-16 6:32:31 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'sp blitzfirst', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'dbo.sp_BlitzFirst 
		@OutputDatabaseName = N''DBAmetrics'', -- nvarchar(256)
		@OutputSchemaName = N''dbo'', -- nvarchar(256)
		@OutputTableName = N''BlitzFirstResults'', -- nvarchar(256)
		@OutputTableNameFileStats = N''BlitzFirst_FileStats'', -- nvarchar(256)
		@OutputTableNamePerfmonStats = N''BlitzFirst_PerfmonStats'', -- nvarchar(256)
		@OutputTableNameWaitStats = N''BlitzFirst_WaitStats'' -- nvarchar(256)', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'CollectorSchedule_Every_5min', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=5, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140220, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'70f09385-4c3b-44fe-9b3d-d0ad0a2ea2ad'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO



