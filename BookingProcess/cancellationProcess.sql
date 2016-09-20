use VEGAUAT
GO


select * from dbo.TrackingNumber -- NEW RECORD 2734411 and TypeCode = N'CANCEL' SAVE OLD ONE AS WELL!
select * from dbo.Reservation  -- update CancellationNumber from previous line, CancellationDate = GETDATE(), CancellationReason = N'PRICE', StatusCode = N'CANCELED'
--UpdatedOn = GETDATE(), SourceLastUpdatedOn = GETDATE()
select * from dbo.ReservationStay -- StatusCode = N'CANCELED', PMSCancellationNumber = 'AS_ABOVE+'-1'', PMSCancellationDate = GETDATE(), CancellationReason = N'PRICE', PMSStatusCode = N'CANCLD', UpdatedOn = GETDATE()
select * from dbo.ReservationStayDate -- nothing?
select * from dbo.ReservationActivity -- INSERT
select * from dbo.GuestNameInfo -- nothing?
select * from dbo.P5RESERVATIONSTAY --nothing
select * from dbo.P5ROOMBLOCKLOCK -- nothing
select * from dbo.Account --nothing
select * from dbo.P5ACCOUNT --UPDATE
select * from dbo.P5RESERVATIONSTAYDATE -- nothing
--select * from dbo.ReservationStayBookingPolicy
--select * from dbo.ReservationBookingPolicy

@ReservationStayID INT
@ReservationID INT

DECLARE @TrackingNumber NVARCHAR(64)

-- randomly generate 7 figures number
SET @TrackingNumber = ( SELECT  CONVERT(NUMERIC(7, 0), RAND() * 8999999) + 1000000 );
WHILE @TrackingNumber IN ( SELECT TrackingNumber FROM dbo.TrackingNumber )
    SET @TrackingNumber = ( SELECT  CONVERT(NUMERIC(7, 0), RAND() * 8999999) + 1000000 );


UPDATE  dbo.P5ACCOUNT
SET     ACC_STATUS = 'CLOSED' ,
        ACC_UPDATED = GETDATE() ,
        ACC_UPDATEDBY = @CreatedBy
WHERE   ACC_ACCOUNTID = @ReservationStayID  -- not a PK but looks like this is enough to identify (actual PK is surrogate in this case)
        AND ACC_STARTDATE = @CheckInDate;





INSERT INTO VEGAUAT.dbo.ReservationActivity
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