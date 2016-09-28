--1 
USE [master]
SET DEADLOCK_PRIORITY HIGH
ALTER DATABASE [VEGAUAT] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [VEGAUAT] FROM  DISK = N'D:\Backup\VEGAUAT_PROD_STASHKOV.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
ALTER DATABASE [VEGAUAT] SET MULTI_USER

GO

--2
--create FUNCTIONS and SP
--SearchAllTables

--3
--clean logs.clients table on EPITOME instance
USE hotel;
TRUNCATE TABLE logs.clients
TRUNCATE TABLE logs.errors


--4
restart HMS Application Server

--5
-- Go to "Query" and Enable "SQLCMD Mode" to run these
:r "D:\Dropbox\SQL Server Management Studio\Aquivalabs\HMS\BookingProcess\create_sp_assign_room.sql"
:r "D:\Dropbox\SQL Server Management Studio\Aquivalabs\HMS\BookingProcess\create_sp_check_in.sql"
:r "D:\Dropbox\SQL Server Management Studio\Aquivalabs\HMS\BookingProcess\create_sp_check_out.sql"
:r "D:\Dropbox\SQL Server Management Studio\Aquivalabs\HMS\BookingProcess\create_sp_makeReservation.sql"
:r "D:\Dropbox\SQL Server Management Studio\Aquivalabs\HMS\BookingProcess\create_sp_cancel_reservation.sql"

:r "D:\Dropbox\SQL Server Management Studio\Aquivalabs\HMS\block_rooms\sp_epi_block_room.sql"
-- Turn off "SQLCMD Mode"


--TROUBLESHOOT

SELECT 'EXEC dbo.' + e.ProcedureName + 
       ' @ProfileID = '          + CAST(e.ProfileID AS nvarchar) + ',' +
       ' @CheckInDate = '        + '''' + CAST(CONVERT(VARCHAR(10), e.CheckInDate, 112) AS nvarchar) + '''' + ',' +
       ' @CheckOutDate = '       + '''' + CAST(CONVERT(VARCHAR(10), e.CheckOutDate, 112) AS nvarchar) + '''' + ',' +
       ' @ReservationStayID = '  + CAST(e.ReservationStayID AS nvarchar) + ',' +
       ' @ConfirmationNumber = ' + CAST(e.TrackingNumber AS nvarchar) + ',' +
       ' @RoomCode = '           + CAST(e.RoomNumber AS nvarchar)
FROM hotel.logs.errors e