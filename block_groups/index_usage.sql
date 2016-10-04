use vegauat
go
--select * from R5WSMESSAGEBUFFER
--select * from R5SESSIONS
--select * from R5WSRSPHIST
--select * from R5WSMESSAGES
--select * from R5WSMESSAGESTATUS
--select * from P5TEMPCORETICKET
--select * from R5WSDUP2
--select * from R5WSREQHIST
--select * from R5XMLTRANSTATUS
--select * from R5XMLTRANSTATUSHIST
select * from PackageInfo  -- insert 
select * from PropertyRatePlan -- insert
--select * from AvailabilityTableChangeTracker
--select * from P5ACCNEXTLINENUM  --not sure. there is nothing in documentation
select * from P5ACCOUNT -- insert  -- ACC_ACCOUNTID = GROUPBOOKINGID from dbo.account
select * from Account
select * from P5GROUPBOOKINGS -- insert
select * from PropGroupBookingLock -- insert
select * from PropGroupBooking  -- DefaultRatePlanID is from dbo.PropertyRatePlan
select * from GroupSalesAccount  -- GroupContactID = ProfileID
--select * from PostalAddress
--select * from P5PROFILECONTACTDETAILS
--select * from P5PROFILEMERGESUSPECTQUEUE
--select * from PhoneNumber  --covered by proc
--select * from NameInfo  --covered by proc
--select * from Profile -- covered by proc, but ProfileTypeCode = 'GRPCNT' and OriginatingSystemID = NULL
select * from TrackingNumber WHERE TrackingNumber LIKE '223%' order by createdon desc -- insert a new one 7 length with 'CANCEL' 
--select * from R5SCHEDULEDJOBS
--select * from TrackerPickup
