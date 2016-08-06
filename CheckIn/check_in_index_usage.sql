--select * from R5SCHEDULEDJOBS
--select * from R5XMLTRANSTATUS
--select * from R5SESSIONS
--select * from R5XMLTRANSTATUSHIST
--select * from P5TEMPCORETICKET
--select * from TrackerPickup
--select * from R5WSMESSAGEBUFFER
--select * from R5WSMESSAGESTATUS --strange rows
--select * from R5WSRSPHIST --strange rows
--select * from R5WSMESSAGES  --strange rows
--select * from R5WSDUP2  --strange rows
-- select * from R5WSREQHIST  --strange rows
--select * from P5PENDINGACCOUNTEVENTCONTROL
--select * from P5DataAccumVersion
--select * from P5BALANCEBASE
--select * from DWEventLog
--select * from P5TRIALFOLIOCHARGE
--select * from P5ACCOUNTSPLIT
--select * from P5RAWTRIALFOLIOCHARGE
--select * from P5RAWTRIALID_IDX
--select * from P5GUESTSTAYFLAGS
--select * from P5OBJECTIMAGE --strange rows
--select * from P5DATAACCUMBATCHCONTROL
--select * from P5ReservationDataVersion 
--select * from ReservationNonRoomItem ORDER BY UpdatedOn DESC  --records are there but not used
--select * from ReservationNonRoomBundle ORDER BY UpdatedOn DESC  --records are there but not used
--select * from ReservationBookingPolicy ORDER BY UpdatedOn DESC -- no new record inserted or updated but can be if cancellationpolicy were to change
--select * from ReservationDeposit --empty
--select * from P5PROFILEMERGESUSPECTQUEUE ORDER BY MRS_CREATEDON DESC
--select * from Profile ORDER BY UpdatedOn DESC --nothing was updated
--select * from IdDocument
--select * from NameInfo
--select * from ReservationName
--select * from ReservationPreference
--select * from ProfileComment
--select * from ReservationComment
select * from P5ACTIONHISTORY ORDER BY ACT_UPDATED DESC -- !!! new record
select * from P5FOLIOHEADER ORDER BY FOH_UPDATED DESC -- !!! new record
select * from P5ROOMBLOCKINGEVENTS ORDER BY EVT_UPDATED DESC  -- !!!! update record EVT_STATUS = 'In-house'
--select * from P5RESERVATIONSTAYDATE ORDER BY RSD_UPDATED DESC
select * from P5ROOMSTATUS ORDER BY RMS_UPDATED DESC  --!!! update the whole thing, OCCP means occupied, do not forget of composite key property + roomnumber
--select * from GuestNameInfo  ORDER BY updatedOn DESC-- nothing was updated
select * from P5ACCOUNT ORDER BY ACC_UPDATED DESC  -- !!!updated ACC_STATUS = 'ACTIVE' 
--select * from P5RESERVATIONSTAY ORDER BY RSY_UPDATED DESC -- nothing was updated
--select * from GuestStayStatistics  --covered by SP
--select * from GuestStaySummary -- covered by SP
--select * from ReservationStayDateChild
--select * from ReservationShareMigrate
select * from Reservation ORDER BY UpdatedOn DESC  -- !!! updated statuscode = 'INHOUSE'
--select * from ReservationStayDate ORDER BY UpdatedOn DESC -- nothing was updated
--select * from P5EGREQUESTQUEUE ORDER BY EGR_UPDATED DESC --  --its a trigger, got it covered
select * FROM ReservationStay ORDER BY UpdatedOn DESC  -- !!! looks like StatusCode = 'INHOUSE' and UpdatedOn, UpdatedBy

