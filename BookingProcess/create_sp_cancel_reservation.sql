USE VEGAUAT
GO
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;
GO
--DROP PROCEDURE [dbo].[sp_epi_cancel_reservation]
CREATE PROCEDURE [dbo].[sp_epi_cancel_reservation]
    @ProfileID INT ,
    @ReservationStayID INT,
    @ReservationID INT,
    @CancellationReason nvarchar(10) = N'CXL',  -- TODO map to EPITOME
    @ErrorMessage NVARCHAR(4000) = NULL OUT
AS
    BEGIN TRY
    BEGIN TRANSACTION

    DECLARE @CreatedBy NVARCHAR(10) = N'R5'
    DECLARE @CheckInDate DATETIME = ( SELECT TOP 1 ArrivalDate FROM dbo.ReservationStay WHERE ReservationStayID = @ReservationStayID AND ReservationID = @ReservationID )

    DECLARE @TrackingNumber NVARCHAR(64)
    -- randomly generate 7 figures number
    SET @TrackingNumber = ( SELECT  CONVERT(NUMERIC(7, 0), RAND() * 8999999) + 1000000 );
    WHILE @TrackingNumber IN ( SELECT TrackingNumber FROM dbo.TrackingNumber )
	   SET @TrackingNumber = ( SELECT  CONVERT(NUMERIC(7, 0), RAND() * 8999999) + 1000000 );

    INSERT  INTO dbo.TrackingNumber
            ( TrackingNumber ,
                TypeCode ,
                UpdatedBy ,
                UpdatedOn ,
                CreatedBy ,
                CreatedOn
            )
    VALUES  ( @TrackingNumber , -- TrackingNumber - nvarchar(64)
                N'CANCEL' , -- TypeCode - nvarchar(6)
                N'system' , -- UpdatedBy - nvarchar(50) --can be manual
                GETDATE() , -- UpdatedOn - datetime
                N'system' , -- CreatedBy - nvarchar(50) --can be manual
                GETDATE()  -- CreatedOn - datetime
            );

    UPDATE  dbo.Reservation
    SET     StatusCode = N'CANCELED' ,
		  UpdatedOn = GETDATE() ,
		  UpdatedBy = @CreatedBy,
		  CancellationNumber = @TrackingNumber,
		  CancellationDate = GETDATE(),
		  CancellationReason = @CancellationReason,
		  SourceLastUpdatedOn = GETDATE()
    WHERE   ReservationID = @ReservationID;

    UPDATE  dbo.ReservationStay
    SET     StatusCode = N'CANCELED' ,
		  PMSCancellationNumber = @TrackingNumber + '-1',
		  PMSCancellationDate = GETDATE(),
		  CancellationReason = @CancellationReason,
		  PMSStatusCode = N'CANCLD',
		  UpdatedOn = GETDATE() ,
		  UpdatedBy = @CreatedBy
    WHERE   ReservationStayID = @ReservationStayID;

    INSERT INTO dbo.ReservationActivity
    (
	   ReservationID,
	   EffectiveDateTime,
	   ActivityType,
	   SourceName,
	   Agent,
	   RevenueChange,
	   AverageRateChange,
	   LOSChange,
	   CurrencyCode,
	   CreatedOn,
	   CreatedBy,
	   UpdatedOn,
	   UpdatedBy,
	   ReservationStayID
    )
    VALUES
    (
	   @ReservationID, -- ReservationID - int
	   GETDATE(), -- EffectiveDateTime - datetime
	   N'Cancel', -- ActivityType - nvarchar
	   N'HMS', -- SourceName - nvarchar
	   @CreatedBy, -- Agent - nvarchar
	   0, -- RevenueChange - decimal
	   0, -- AverageRateChange - decimal
	   0, -- LOSChange - int
	   N'RUB', -- CurrencyCode - nvarchar
	   GETDATE(), -- CreatedOn - datetime
	   @CreatedBy, -- CreatedBy - nvarchar
	   GETDATE(), -- UpdatedOn - datetime
	   @CreatedBy, -- UpdatedBy - nvarchar
	   @ReservationStayID -- ReservationStayID - int
    )

    UPDATE  dbo.P5ACCOUNT
    SET     ACC_STATUS = 'CLOSED' ,
		  ACC_UPDATED = GETDATE() ,
		  ACC_UPDATEDBY = @CreatedBy
    WHERE   ACC_ACCOUNTID = @ReservationStayID  -- not a PK but looks like this is enough to identify (actual PK is surrogate in this case)
		  AND ACC_STARTDATE = @CheckInDate;

    COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
	   IF @@TRANCOUNT > 0
		  ROLLBACK TRANSACTION;
 
	   SET @ErrorMessage = ERROR_MESSAGE();
	   DECLARE @ErrorNumber INT = ERROR_NUMBER();
	   DECLARE @ErrorLine INT = ERROR_LINE();
	   DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
	   DECLARE @ErrorState INT = ERROR_STATE();

	   RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
GO