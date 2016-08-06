--already were used
--TrackerPickup
--R5SESSIONS
--R5XMLTRANSTATUS
--R5XMLTRANSTATUSHIST
--P5TEMPCORETICKET
--R5SCHEDULEDJOBS

--SELECT * from R5XMLTRANSTATUS
--select * from R5WSMESSAGEBUFFER
--select * from R5SESSIONS
select * from R5WSRSPHIST  ORDER BY WSR_SQLIDENTITY  DESC  --strange records
select * from R5WSMESSAGES ORDER BY WSM_SQLIDENTITY  DESC --strange records
select * from R5WSMESSAGESTATUS ORDER BY WSS_TIME DESC --!!!!3 records
--select * from P5TEMPCORETICKET
select * from R5WSDUP2 ORDER BY WD2_TIME DESC -- !!!!strange record
select * from R5WSREQHIST ORDER BY WSQ_TIME DESC -- !!!!3 strange records
--select * from R5XMLTRANSTATUSHIST
--select * from P5PENDINGACCOUNTEVENTCONTROL
--select * from P5DataAccumVersion
select * from P5BALANCEBASE ORDER BY BAL_CREATED DESC --!!!!!!!!!!missing this one
--select * from DWEventLog
select * from P5TRIALFOLIOCHARGE ORDER BY TFC_CREATED DESC  --!!!!!!! missing this one 3 record
select * from P5ACCOUNTSPLIT ORDER BY ACS_UPDATED DESC  --!!!!! missing this one
select * from P5RAWTRIALFOLIOCHARGE ORDER BY RTC_UPDATED DESC  -- 3 records
select * from P5RAWTRIALID_IDX ORDER BY RTC_DATE DESC  -- very strange dates
select * from P5ReservationDataVersion ORDER BY RDV_UPDATED DESC  --!!!!! missing this one
select * from ReservationStayDate ORDER BY ReservationStayID DESC  --got it covered
select * from P5GUESTSTAYFLAGS ORDER BY GSF_UPDATEDON DESC  --!!! missing this one 
select * from P5OBJECTIMAGE ORDER BY IMG_CREATED DESC  -- record is there but the data is not reproducable -- and does not has any triggers or SP
--select * from P5DATAACCUMBATCHCONTROL
select * from P5DataAccumVersion ORDER BY DAV_UPDATED DESC  --!!! missing this one
---- tables above were skipped since data for them is possible to generate 

--select * from P5RESERVATIONSTAYDATE
--select * from ReservationNonRoomItem ORDER BY UpdatedOn DESC   --records are there but not used
--select * from ReservationNonRoomBundle ORDER BY UpdatedOn DESC  --records are there but not used
select * from ReservationBookingPolicy ORDER BY UpdatedOn DESC --!!!!!!! missing this one. this is identical to ReservationSTAYBookingPolicy
--select * from ReservationDeposit
select * from P5PROFILEMERGESUSPECTQUEUE ORDER BY MRS_CREATEDON DESC  --got it covered, trigger
select * from Profile
--select * from IdDocument
select * from NameInfo ORDER BY UpdatedOn DESc
--select * from ReservationName
--select * from ReservationPreference
--select * from ProfileComment
--select * from ProfileComment
--select * from ReservationComment
select * from ReservationStayBookingPolicy  ORDER BY UpdatedOn DESC  -- !!!!!!!!!!!!definitely missing this one
select * from GuestNameInfo ORDER BY UpdatedOn DESC
select * from P5ACCNEXTLINENUM ORDER BY CAST(ANL_ACCOUNT AS INT) DESC  -- got it covered. decription is missing in docs. really not sure what this is NEXT LINE NUM?  -- seems like a trigger because I have this
select * from P5ACCOUNT ORDER BY ACC_UPDATED DESC  -- got it covered
select * from Account ORDER BY UpdatedOn DESC  -- got it covered
select * from P5ROOMBLOCKLOCK ORDER BY RBL_UPDATEDON DESC  -- got it covered
select * from P5RESERVATIONSTAY ORDER BY RSY_UPDATED DESC  -- got it covered
select * from P5RESERVATIONSTAYDATE  ORDER BY RSD_UPDATED DESC -- !!!!!!!!!!!1 record  -- i am missing this one
--select * from AvailabilityTableChangeTracker
--SELECT * from ChanPickup ORDER BY UpdatedOn DESC  -- updated 3 records --notice they are updated not inserted  --notice they are updated not inserted
--select * from Pickup ORDER BY UpdatedOn DESC --- updated 3 records in total!  -- possibly with proc prc_CleanupPickups_Ins --notice they are updated not inserted
--select * from TrackerPickup
select * from GuestStayStatistics ORDER BY UpdatedOn DESC -- got it covered
select * from GuestStaySummary ORDER BY UpdatedOn DESC -- got it covered
select * from ReservationActivity ORDER BY UpdatedOn DESC  -- updated by is different
select * from ReservationStayDate ORDER BY UpdatedOn DESC  -- got it covered
select * from P5EGREQUESTQUEUE  ORDER BY EGR_CREATED DESC --its a trigger, got it covered
select * from ReservationStay ORDER BY UpdatedOn deSC
--select * from ReservationShareMigrate
select * from Reservation ORDER BY UpdatedOn deSC
select * from TrackingNumber ORDER BY UpdatedOn deSC
--select * from PostalAddress
--select * from P5PROFILECONTACTDETAILS
--select * from PhoneNumber  --can be ignored
select * from NameInfo WHERE ProfileID >= 48
select * from Profile WHERE ProfileID >= 48
--select * from R5SCHEDULEDJOBS


