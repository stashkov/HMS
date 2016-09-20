USE hotel;
GO

--@RoomCode INT ,
--@StartDate DATETIME ,
--@EndDate DATETIME ,
--@Reason NVARCHAR(30) ,
--@Description NVARCHAR(500)
--DROP TABLE logs.room_blocks

SELECT o.work_order_no,
       CONVERT(NVARCHAR(6), room) AS [RoomCode],
       from_date AS [StartDate],
       to_date AS [EndDate],
       CONVERT(NVARCHAR(6), code) AS [Reason],
       ISNULL(CONVERT(NVARCHAR(2000), notes), '') AS [Description],
	  CONVERT(NVARCHAR(1), [status]) AS [status],
	  o.LastUpdated
FROM dbo.outoforder AS o
WHERE o.status IN('C', 'D', 'A') -- ignore 'M' (minor)
-- Process: Active -> (optionally Cancelled) -> Done
AND ISNUMERIC(o.room) = 1 -- ignores corridors, elevators
AND o.status NOT IN('C', 'D')


SELECT *
FROM logs.room_blocks

SELECT *
FROM logs.errors

TRUNCATE TABLE logs.room_blocks
TRUNCATE TABLE logs.errors
TRUNCATE TABLE logs.clients

DROP TABLE logs.room_blocks

SELECT *
FROM logs.clients