----select * from AvailabilityTableChangeTracker -- nothing
--select * from PropGroupBookingControl ORDER BY sourcelastupdatedon desc -- insert 
----select * from PropGroupBooking --nothing

-- both will work
--DECLARE @RatePlanList NVARCHAR(100) = N'SRTS,STQS,STTS'
--DECLARE @RoomCountList NVARCHAR(100) = N'10,15,5'
DECLARE @RatePlanList NVARCHAR(100) = N'SRTS'
DECLARE @RoomCountList NVARCHAR(100) = N'25'
DECLARE @CheckInDate DATETIME = '20160711'
DECLARE @CheckOutDate DATETIME = '20160715'
DECLARE @PropGroupBookingID INT = 3

CREATE TABLE #RoomTypeCount (ID INT identity(1,1), RatePlanCode nvarchar(10), RoomCount int)
DECLARE @tmpRatePlanCode nvarchar(10), @PosRate int, @PosCount int
DECLARE @tmpRoomCount nvarchar(10)

DECLARE @tmpRatePlanList NVARCHAR(100) = LTRIM(RTRIM(@RatePlanList))+ ','
SET @PosRate = CHARINDEX(',', @tmpRatePlanList, 1)

DECLARE @tmpRoomCountList NVARCHAR(100) = LTRIM(RTRIM(@RoomCountList))+ ','
SET @PosCount = CHARINDEX(',', @tmpRoomCountList, 1)

IF REPLACE(@tmpRatePlanList, ',', '') <> ''
BEGIN
    WHILE @PosRate > 0 
    BEGIN
        SET @tmpRatePlanCode = LTRIM(RTRIM(LEFT(@tmpRatePlanList, @PosRate - 1)))
        SET @tmpRoomCount = LTRIM(RTRIM(LEFT(@tmpRoomCountList, @PosCount - 1)))
        IF @tmpRatePlanCode <> ''
          BEGIN
             INSERT INTO #RoomTypeCount (RatePlanCode, RoomCount) VALUES (@tmpRatePlanCode, @tmpRoomCount) 
          END
        SET @tmpRatePlanList = RIGHT(@tmpRatePlanList, LEN(@tmpRatePlanList) - @PosRate)
        SET @tmpRoomCountList = RIGHT(@tmpRoomCountList, LEN(@tmpRoomCountList) - @PosCount)
	   
        SET @PosCount = CHARINDEX(',', @tmpRoomCountList, 1)
        SET @PosRate = CHARINDEX(',', @tmpRatePlanList, 1)
    END
END



DECLARE @id INT = 0
WHILE (1 = 1) 
BEGIN  

  -- Get next 
  SELECT TOP 1 @id = id, @tmpRatePlanCode = RatePlanCode, @tmpRoomCount = RoomCount
  FROM #RoomTypeCount
  WHERE id > @id 
  ORDER BY id

  IF @@ROWCOUNT = 0 BREAK; -- exit loop if no rows selected

  EXEC [dbo].[prc_UpdateGroupBlocks]
		@propGroupBookingId = @PropGroupBookingID,
		@roomType = @tmpRatePlanCode,
		@startDate = @CheckInDate,
		@endDate = @CheckOutDate,
		@allocRoomCount = @tmpRoomCount,
		@contractedRoomCount = 0,
		@isRemovedFromAvail = 1,
		@updatedBy = N'R5',
		@updateSource = N'system',
		@isDeblocking = NULL,
		@forecastedRoomCount = NULL

END



drop table #RoomTypeCount