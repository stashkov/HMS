select * from dbo.TrackingNumber -- 33681283 became  NEW RECORD 2734411 and TypeCode = N'CANCEL' SAVE OLD ONE AS WELL!
select * from dbo.Reservation  -- update CancellationNumber from previous line, CancellationDate = GETDATE(), CancellationReason = N'PRICE', StatusCode = N'CANCELED'
--UpdatedOn = GETDATE(), SourceLastUpdatedOn = GETDATE()
select * from dbo.ReservationStay -- StatusCode = N'CANCELED', PMSCancellationNumber = 'AS_ABOVE+'-1'', PMSCancellationDate = GETDATE(), CancellationReason = N'PRICE', PMSStatusCode = N'CANCLD', UpdatedOn = GETDATE()
select * from dbo.ReservationStayDate
select * from dbo.ReservationActivity
select * from dbo.GuestNameInfo
select * from dbo.P5RESERVATIONSTAY
select * from dbo.P5ROOMBLOCKLOCK
select * from dbo.Account
select * from dbo.P5ACCOUNT
select * from dbo.P5RESERVATIONSTAYDATE
--select * from dbo.ReservationStayBookingPolicy
--select * from dbo.ReservationBookingPolicy

