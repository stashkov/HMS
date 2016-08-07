USE VEGAUAT;

DECLARE @ReservationID INT;
DECLARE @ReservationStayID INT;
DECLARE @CreatedBy NVARCHAR(10);
DECLARE @nowDate DATETIME;
DECLARE @PropertyCode NVARCHAR(4);
DECLARE @CheckInDate DATETIME;
DECLARE @ProfileID INT;
DECLARE @EVENT_ID NVARCHAR(64);
DECLARE @TrackingNumber NVARCHAR(64);
DECLARE @RoomID INT;


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
SET @EVENT_ID = ( SELECT    CAST(MAX(EVT_EVENTID) + 1 AS NVARCHAR)
                  FROM      dbo.P5ROOMBLOCKINGEVENTS
                );
SET @TrackingNumber = ( SELECT  ConfirmationNumber
                        FROM    dbo.Reservation
                        WHERE   ReservationID = @ReservationID
                      );




SET @RoomID = ( SELECT  RoomID
                FROM    dbo.ReservationStayDate
                WHERE   ReservationStayID = @ReservationStayID
                        AND StayDate = @CheckInDate  --primary key composite field of 2
              );


UPDATE  dbo.ReservationStay
SET     StatusCode = N'INHOUSE' ,
        PMSStatusCode = N'INHOUS' ,
        UpdatedOn = GETDATE() ,
        UpdatedBy = @CreatedBy
WHERE   ReservationStayID = @ReservationStayID;
  -- primary key


UPDATE  dbo.Reservation
SET     StatusCode = N'INHOUSE' ,
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


UPDATE  dbo.P5ACCOUNT
SET     ACC_STATUS = 'ACTIVE' ,
        ACC_UPDATED = GETDATE() ,
        ACC_UPDATEDBY = @CreatedBy
WHERE   ACC_ACCOUNTID = @ReservationStayID  -- not a PK but looks like this is enough to identify (actual PK is surrogate in this case)
        AND ACC_STARTDATE = @CheckInDate;

UPDATE  dbo.P5ROOMSTATUS
SET     RMS_FRONTDESKSTATUS = N'OCCP' ,
        RMS_HOUSEKEEPINGSTATUS = N'OCCP' ,
        RMS_SERVICETYPE = N'CHKOUT' ,
        RMS_UPDATEDBY = @CreatedBy ,
        RMS_UPDATED = GETDATE()
        --RMS_UPDATECOUNT = 0 --gives a trigger error
WHERE   RMS_PROPERTY = @PropertyCode
        AND RMS_CODE = @RoomID;

UPDATE  dbo.P5ROOMBLOCKINGEVENTS
SET     EVT_STATUS = N'In-house'
WHERE   EVT_ROOM = @RoomID
        AND EVT_PROPERTYCODE = @PropertyCode
        AND EVT_STARTDATE = @CheckInDate;
  -- not a PK but still uniquely identifies (actual PK is a surrogate key)


INSERT  INTO dbo.P5FOLIOHEADER
        ( FOH_ACCOUNTID ,
          FOH_ACCOUNT ,
          FOH_CONFIRMATIONNUMBER ,
          FOH_PMSCONFIRMATIONNUMBER ,
          FOH_PROPERTY ,
          FOH_INTERFACETOKEN ,
          FOH_UPDATEDBY ,
          FOH_UPDATED ,
          FOH_CREATEDBY ,
          FOH_CREATED ,
          FOH_UPDATECOUNT
        )
VALUES  ( @ReservationStayID , -- FOH_ACCOUNTID - int
          @ReservationStayID , -- FOH_ACCOUNT - nvarchar(30) -- may cause issues in the future since it probably refers to dbo.account.accountid
          @TrackingNumber , -- FOH_CONFIRMATIONNUMBER - nvarchar(64)
          @TrackingNumber + N'-1' , -- FOH_PMSCONFIRMATIONNUMBER - nvarchar(50)
          @PropertyCode , -- FOH_PROPERTY - nvarchar(15)
          111111 , -- FOH_INTERFACETOKEN - numeric
          @CreatedBy , -- FOH_UPDATEDBY - nvarchar(30)
          GETDATE() , -- FOH_UPDATED - datetime
          @CreatedBy , -- FOH_CREATEDBY - nvarchar(30)
          GETDATE() , -- FOH_CREATED - datetime
          0  -- FOH_UPDATECOUNT - numeric
        );



INSERT  INTO dbo.P5ACTIONHISTORY
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
          N'CHKIN' , -- ACT_ACTION - nvarchar(9)
          @CreatedBy , -- ACT_UPDATEDBY - nvarchar(30)
          GETDATE() , -- ACT_UPDATED - datetime
          @CreatedBy , -- ACT_CREATEDBY - nvarchar(30)
          GETDATE() , -- ACT_CREATED - datetime
          0  -- ACT_UPDATECOUNT - numeric
        );


