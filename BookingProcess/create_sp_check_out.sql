USE VEGAUAT
GO
--DROP PROCEDURE [dbo].[sp_epi_check_out]
CREATE PROCEDURE [dbo].[sp_epi_check_out]
--input parameters for the SP
    @ProfileID INT ,
    @CheckInDate DATETIME ,
    @CheckOutDate DATETIME ,
    @ReservationID INT ,
    @ReservationStayID INT ,
    @TrackingNumber NVARCHAR(64)
AS
    BEGIN TRY
		-- check if resrvation exists, and status is INHOUSE, then we can CHECK OUT
        IF EXISTS ( SELECT  ReservationStayID
                    FROM    ReservationStay
                    WHERE   ReservationStayID = @ReservationStayID )
            AND ( SELECT    StatusCode
                  FROM      Reservation
                  WHERE     ReservationID = @ReservationID
                ) = 'INHOUSE'
            BEGIN
		  BEGIN TRANSACTION CHECKOUT
			 PRINT 'imma inside transaction'
                DECLARE @CreatedBy NVARCHAR(10);

                DECLARE @nowDate DATETIME;
                DECLARE @PropertyCode NVARCHAR(4);
                DECLARE @RoomID INT;


                SET @RoomID = ( SELECT  RoomID
                                FROM    dbo.ReservationStayDate
                                WHERE   ReservationStayID = @ReservationStayID
                                        AND StayDate = @CheckInDate  --primary key composite field of 2
                              );
                SET @CreatedBy = N'R5';
                SET @nowDate = GETDATE();
                SET @PropertyCode = N'VEGA';


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
                          N'CHKOUT' , -- ACT_ACTION - nvarchar(9)
                          @CreatedBy , -- ACT_UPDATEDBY - nvarchar(30)
                          GETDATE() , -- ACT_UPDATED - datetime
                          @CreatedBy , -- ACT_CREATEDBY - nvarchar(30)
                          GETDATE() , -- ACT_CREATED - datetime
                          0  -- ACT_UPDATECOUNT - numeric
                        );

		  COMMIT TRANSACTION CHECKOUT
            END;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
	   BEGIN
            SELECT  @ProfileID AS ProfileID ,
                    ERROR_NUMBER() AS ErrorNumber ,
                    ERROR_MESSAGE() AS ErrorMessage;  
		  ROLLBACK TRANSACTION CHECKOUT;
	   END
    END CATCH;

GO