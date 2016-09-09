    --@ProfileID INT,
    --@CheckInDate DATETIME = '20160705' ,
    --@CheckOutDate DATETIME = '20160706' ,

    --@RatePlanCode NVARCHAR(6) = N'HIGH1' ,
    --@RoomTypeCode NVARCHAR(6) = N'SRTS' ,
    --@GuaranteeCode NVARCHAR(6) = N'6PM' ,
    --@SourceCode NVARCHAR(6) = N'CALL'

	use hotel
	GO

    SELECT
            --c.profileid_hms AS ProfileID ,
		  g.account AS account,

            g.arrival AS CheckIn ,
            g.departure AS CheckOut ,
	        
			--g.rate_code AS RatePlanCode ,
            d2.HMSCode AS RatePlanCode ,
            
			--g.room_type AS RoomTypeCode,
            d1.HMSCode AS RoomTypeCode ,
            
			--g.gtd AS GuaranteeType ,
            d3.HMSCode AS GuaranteeType ,
			
			--g.source AS SourceOfBusiness ,
            d.HMSCode AS SourceOfBusiness ,
            g.room AS RoomNumber ,
            g.status
			,d4.HMSCode AS [Status]
            --g.cxl_code AS cancelcode,
			--g.property AS Property ,
			---c.ConfirmationNumber AS TrackingNumber,
			---c.ReservationID AS ReservationID,
			---c.ReservationStayID AS ReservationStayID,
			---c.executed_on
			--,g.cxl_code
		    --g.account 
    FROM    dbo.guest g
            --INNER JOIN logs.clients c ON g.account = c.account_epitome
            INNER JOIN logs.dictionary d ON d.EpitomeCode = g.source
                                            AND d.Type = N'SourceOfBusiness'
            INNER JOIN logs.dictionary d1 ON d1.EpitomeCode = g.room_type
                                             AND d1.Type = N'RoomType'
            INNER JOIN logs.dictionary d2 ON d2.EpitomeCode = g.rate_code
                                             AND d2.Type = 'RateCode'
            INNER JOIN logs.dictionary d3 ON d3.EpitomeCode = g.gtd
                                             AND d3.Type = 'GuaranteeType'
            INNER JOIN logs.dictionary d4 ON d4.EpitomeCode = g.status
                                             AND d4.Type = 'Status'
    WHERE   --g.status NOT IN ('P', 'W', 'O', 'N', 'C')-- permament, wait
		  g.status IN ('I', 'R')
            AND g.cxl_code IS NULL -- cancelled during check out 
 
-- 'P' PERMAMENT
-- 'W' WAITLIST
-- 'O' CHECKED OUT
-- 'N' NOSHOW
-- 'C' CANCELLED
-- 'I' CHECKED IN
-- 'R' REGISTERED

 