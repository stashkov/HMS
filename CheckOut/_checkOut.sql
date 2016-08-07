DECLARE @ReservationID INT;
DECLARE @ReservationStayID INT;
DECLARE @CreatedBy NVARCHAR(10);
DECLARE @nowDate DATETIME;
DECLARE @PropertyCode NVARCHAR(4);
DECLARE @CheckOutDate DATETIME;
DECLARE @ProfileID INT;
--DECLARE @EVENT_ID NVARCHAR(64);
DECLARE @TrackingNumber NVARCHAR(64);
DECLARE @CheckInDate DATETIME;


SET @ReservationID = ( SELECT TOP 1
                                ReservationID
                       FROM     dbo.Reservation
                       ORDER BY ReservationID DESC
                     );
      -- create a table in hotel db with mapping to epitome (ProfileID, ReservationStayID, ReservationStay)
                       
SET @ReservationStayID = ( SELECT TOP 1
                                    ReservationStayID
                           FROM     dbo.ReservationStay
                           ORDER BY ReservationStayID DESC
                         );
       -- create a table in hotel db with mapping to epitome 


SET @CreatedBy = N'R5';
SET @nowDate = GETDATE();
SET @PropertyCode = N'VEGA';
SET @CheckInDate = '20160705';
SET @ProfileID = ( SELECT   MAX(ProfileID)
                   FROM     dbo.NameInfo
                 );
--SET @EVENT_ID = ( SELECT    CAST(MAX(EVT_EVENTID) + 1 AS NVARCHAR)
--                  FROM      dbo.P5ROOMBLOCKINGEVENTS
--                );
SET @TrackingNumber = ( SELECT  ConfirmationNumber
                        FROM    dbo.Reservation
                        WHERE   ReservationID = @ReservationID
                      );

DECLARE @RoomID INT;
SET @RoomID = ( SELECT  RoomID
                FROM    dbo.ReservationStayDate
                WHERE   ReservationStayID = @ReservationStayID
                        AND StayDate = @CheckInDate  --primary key composite field of 2
              );


UPDATE  dbo.ReservationStay
SET     StatusCode = N'CHKOUT' ,
        PMSStatusCode = N'CHKOUT' ,
        UpdatedOn = GETDATE() ,
		--DepartureDate = @CheckOutDate, -- if the original departure date has changedW
        UpdatedBy = @CreatedBy
WHERE   ReservationStayID = @ReservationStayID;
  -- primary key


UPDATE  dbo.Reservation
SET     StatusCode = N'CHKOUT' ,
        UpdatedOn = GETDATE() ,
        UpdatedBy = @CreatedBy
WHERE   ReservationID = @ReservationID;
  -- primary key

EXEC dbo.prc_UpdateGuestStaySummary @guestProfileID = @ProfileID, -- int
    @reservationStayId = @ReservationStayID, -- int
    @username = @CreatedBy, -- nvarchar(50)
    @updatedOn = @nowDate;

EXEC dbo.prc_UpdateGuestStayStatistics @profileID = @ProfileID, -- int
    @customerID = N'1', -- nvarchar(50)
    @isActualRecord = 1, -- tinyint
    @propertyCode = @PropertyCode, -- nvarchar(15)
    @username = @CreatedBy, -- varchar(30)
    @updatedOn = @nowDate;

EXEC dbo.prc_UpdateGuestStayStatistics @profileID = @ProfileID, -- int
    @customerID = N'1', -- nvarchar(50)
    @isActualRecord = 0, -- tinyint
    @propertyCode = @PropertyCode, -- nvarchar(15)
    @username = @CreatedBy, -- varchar(30)
    @updatedOn = @nowDate;

UPDATE  dbo.P5ROOMBLOCKINGEVENTS
SET     EVT_STATUS = N'Checked-out'
WHERE   EVT_ROOM = @RoomID
        AND EVT_PROPERTYCODE = @PropertyCode
        AND EVT_STARTDATE = @CheckInDate;
  -- not a PK but still uniquely identifies (actual PK is a surrogate key)


UPDATE  dbo.P5ACCOUNT
SET     ACC_STATUS = 'CLOSED' ,
        ACC_UPDATED = GETDATE() ,
		--ACC_ENDDATE = checkoutdate  -- if needed to change checkout date
        ACC_UPDATEDBY = @CreatedBy
WHERE   ACC_ACCOUNTID = @ReservationStayID  -- not a PK but looks like this is enough to identify (actual PK is surrogate in this case)
        AND ACC_STARTDATE = @CheckInDate;

-- GuestNameInfo.DepartureDate if need to change checkoutdate

UPDATE  dbo.P5ROOMSTATUS
SET     RMS_FRONTDESKSTATUS = N'VAC' ,
        RMS_HOUSEKEEPINGSTATUS = N'VAC' ,
        RMS_SERVICETYPE = N'CHKOUT' , -- CHKOUT is what was inthe table
        RMS_UPDATEDBY = @CreatedBy ,
        RMS_UPDATED = GETDATE()
        --RMS_UPDATECOUNT = 0 --gives a trigger error
WHERE   RMS_PROPERTY = @PropertyCode
        AND RMS_CODE = @RoomID;



INSERT INTO dbo.P5ACTIONHISTORY
        ( ACT_RESERVATIONSTAYID ,
          ACT_PMSCONFIRMATIONNUMBER ,
          ACT_PROPERTYCODE ,
          ACT_ACTION ,
          ACT_UPDATEDBY ,
          ACT_UPDATED ,
          ACT_CREATEDBY ,
          ACT_CREATED ,
          ACT_UPDATECOUNT
        )
VALUES  ( @ReservationStayID , -- ACT_RESERVATIONSTAYID - int
          @TrackingNumber + N'-1' , -- ACT_PMSCONFIRMATIONNUMBER - nvarchar(50)
          @PropertyCode , -- ACT_PROPERTYCODE - nvarchar(15)
          N'CHKOUT' , -- ACT_ACTION - nvarchar(9)
          @CreatedBy , -- ACT_UPDATEDBY - nvarchar(30)
          GETDATE() , -- ACT_UPDATED - datetime
          @CreatedBy , -- ACT_CREATEDBY - nvarchar(30)
          GETDATE() , -- ACT_CREATED - datetime
          0  -- ACT_UPDATECOUNT - numeric
        )