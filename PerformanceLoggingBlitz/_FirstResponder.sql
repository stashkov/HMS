-- https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit

USE [master]
--When you want an overall health check, run sp_Blitz.
EXEC dbo.sp_Blitz

--To learn which queries have been using the most resources, run sp_BlitzCache.
--To analyze which indexes are missing or slowing you down, run sp_BlitzIndex.
EXEC sp_blitzIndex @DatabaseName = N'', @Mode = 4

--To find out why the server is slow right now, run sp_BlitzFirst.
EXEC dbo.sp_BlitzFirst  @ExpertMode = 1 -- tinyint


--Actions to take based on the results of EXEC dbo.sp_Blitz
--Last good DBCC CHECKDB over 2 weeks old. For every DB run
EXEC sp_MSforeachDB 'DBCC CHECKDB (?) WITH ALL_ERRORMSGS, EXTENDED_LOGICAL_CHECKS, DATA_PURITY' --NO_INFOMSGS

--Remote DAC Disabled
 EXEC sp_configure 'remote admin connections', 1;
--Before running the second part though, make sure there is no pending changes
SELECT * FROM sys.configurations WHERE value <> value_in_use
--If all you see is DAC, then you can safely
RECONFIGURE

