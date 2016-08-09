    --@ProfileID INT,
    --@CheckInDate DATETIME = '20160705' ,
    --@CheckOutDate DATETIME = '20160706' ,

    --@RatePlanCode NVARCHAR(6) = N'HIGH1' ,
    --@RoomTypeCode NVARCHAR(6) = N'SRTS' ,
    --@GuaranteeCode NVARCHAR(6) = N'6PM' ,
    --@SourceCode NVARCHAR(6) = N'CALL'


    SELECT DISTINCT
            c.profileid_hms AS ProfileID ,
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
            g.status,
            --g.cxl_code AS cancelcode,
			--g.property AS Property ,
			c.ConfirmationNumber AS TrackingNumber,
			c.ReservationID AS ReservationID,
			c.ReservationStayID AS ReservationStayID,
			c.executed_on
		

		 --g.account 
    FROM    dbo.guest g
            INNER JOIN logs.clients c ON g.account = c.account_epitome
            INNER JOIN logs.dictionary d ON d.EpitomeCode = g.source
                                            AND d.Type = N'SourceOfBusiness'
            INNER JOIN logs.dictionary d1 ON d1.EpitomeCode = g.room_type
                                             AND d1.Type = N'RoomType'
            INNER JOIN logs.dictionary d2 ON d2.EpitomeCode = g.rate_code
                                             AND d2.Type = 'RateCode'
            INNER JOIN logs.dictionary d3 ON d3.EpitomeCode = g.gtd
                                             AND d3.Type = 'GuaranteeType'
    WHERE   g.status <> 'P'  -- permament
            AND g.status <> 'C'  -- cancelled
            AND g.status <> 'N'  -- noshow
            AND g.status <> 'W'  -- wait
          --AND g.room IS NOT NULL
		  --exclude cancelled
            AND g.cxl_code IS NULL;
 


 SELECT *
 FROM logs.clients


SELECT  *
FROM    logs.dictionary;



