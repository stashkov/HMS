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


