CREATE PROCEDURE [dbo].[sp_epi_check_in]
--input parameters for the SP
    @ProfileID INT ,
    @SourceCode NVARCHAR(6) ,
    @GuaranteeCode NVARCHAR(6) ,
    @CheckInDate DATETIME ,
    @CheckOutDate DATETIME ,
    @RatePlanCode NVARCHAR(6) ,
    @RoomTypeCode NVARCHAR(6) ,
    @ReservationID INT ,
    @ReservationStayID INT ,
    @TrackingNumber NVARCHAR(64)
AS
    BEGIN TRAN;
    BEGIN TRY
		-- check if resrvation exists, and status is reserved, and room is not null, then we can CHECK IN
        DECLARE @RoomID INT;


        SET @RoomID = ( SELECT  RoomID
                        FROM    dbo.ReservationStayDate
                        WHERE   ReservationStayID = @ReservationStayID
                                AND StayDate = @CheckInDate  --primary key composite field of 2
                      );
        IF EXISTS ( SELECT  ReservationStayID
                    FROM    ReservationStay
                    WHERE   ReservationStayID = @ReservationStayID )
            AND ( SELECT    StatusCode
                  FROM      Reservation
                  WHERE     ReservationID = @ReservationID
                ) = 'CONFIRMED'
            AND EXISTS ( SELECT RoomID
                         FROM   ReservationStayDate
                         WHERE  ReservationStayID = @ReservationStayID
                                AND RoomID = @RoomID )
            AND ( SELECT    RoomID
                  FROM      ReservationStayDate
                  WHERE     ReservationStayID = @ReservationStayID
                            AND RoomID = @RoomID
                ) IS NOT NULL
            BEGIN

                DECLARE @CreatedBy NVARCHAR(10);
                DECLARE @nowDate DATETIME;
                DECLARE @PropertyCode NVARCHAR(4);
                DECLARE @EVENT_ID NVARCHAR(64);


                SET @CreatedBy = N'R5';
                SET @nowDate = GETDATE();
                SET @PropertyCode = N'VEGA';
                SET @EVENT_ID = ( SELECT    CAST(MAX(EVT_EVENTID) + 1 AS NVARCHAR)
                                  FROM      dbo.P5ROOMBLOCKINGEVENTS
                                ); -- according to docs it is an identity


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



            END;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            SELECT  @ProfileID AS ProfileID ,
                    ERROR_NUMBER() AS ErrorNumber ,
                    ERROR_MESSAGE() AS ErrorMessage;  
        ROLLBACK;
    END CATCH;
 --If we didn't rollback, @@TRANCOUNT should be > 0 and we should commit
    IF @@TRANCOUNT > 0
        COMMIT;


GO