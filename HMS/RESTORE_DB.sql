--1 
USE [master]
ALTER DATABASE [VEGAUAT] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [VEGAUAT] FROM  DISK = N'D:\Backup\VEGAUAT_PROD_STASHKOV.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
ALTER DATABASE [VEGAUAT] SET MULTI_USER

GO

--2
--create FUNCTIONS and SP
--SearchAllTables

--3
--clean logs.clients table on EPITOME instance
--USE hotel;
--TRUNCATE TABLE logs.clients

--4
-- restart HMS Application Server


:r "D:\Dropbox\SQL Server Management Studio\Aquivalabs\HMS\BookingProcess\create_sp_assign_room.sql"
:r "D:\Dropbox\SQL Server Management Studio\Aquivalabs\HMS\BookingProcess\create_sp_check_in.sql"
:r "D:\Dropbox\SQL Server Management Studio\Aquivalabs\HMS\BookingProcess\create_sp_check_out.sql"
:r "D:\Dropbox\SQL Server Management Studio\Aquivalabs\HMS\BookingProcess\create_sp_makeReservation.sql"