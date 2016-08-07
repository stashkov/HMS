--select * from R5XMLTRANSTATUS
--select * from R5SESSIONS
--select * from R5XMLTRANSTATUSHIST
--select * from P5TEMPCORETICKET
--select * from AvailabilityTableChangeTracker
--select * from Pickup
--select * from R5SCHEDULEDJOBS
--select * from P5INVENTORYAVL  -- general info about room types
--select * from TrackerPickup
--select * from P5DATAACCUMBATCHCONTROL
--select * from P5EXP_RPT_REVENUE ORDER BY ERR_UPDATED DESC
--select * from DWEventLog
--select * from R5WSMESSAGEBUFFER
--select * from R5WSRSPHIST
--select * from R5WSMESSAGES
--select * from R5WSMESSAGESTATUS
--select * from R5WSDUP2
--select * from R5WSREQHIST
--select * from P5PENDINGACCOUNTEVENTCONTROL
--select * from P5DataAccumVersion ORDER BY DAV_UPDATED DESC
--select * from P5BALANCEBASE
--select * from P5TRIALFOLIOCHARGE ORDER BY TFC_UPDATED DESC  --probably a trigger
--select * from P5ACCOUNTSPLIT ORDER BY ACS_UPDATED DESC -- prbably a trigger
--select * from P5RAWTRIALFOLIOCHARGE ORDER BY RTC_UPDATED DESC -- prbably a trigger
--select * from P5RAWTRIALID_IDX
--select * from P5ReservationDataVersion ORDER BY RDV_UPDATED DESC -- probably a trigger
--select * from ReservationStayDate ORDER BY UpdatedOn DESC -- nothing was updated
--select * from P5GUESTSTAYFLAGS ORDER BY GSF_UPDATEDON DESC -- trigger
--select * from P5OBJECTIMAGE -- strange record
--select * from P5DataAccumVersion  -- trigger
--select * from ReservationNonRoomItem ORDER BY UpdatedOn DESC -- nothing was updated
--SELECT * from ReservationNonRoomBundle ORDER BY UpdatedOn DESC -- nothing was updated
--select * from ReservationBookingPolicy ORDER BY UpdatedOn DESC -- nothing was updated
--select * from ReservationDeposit
--select * from P5PROFILEMERGESUSPECTQUEUE ORDER BY MRS_CREATEDON DESC -- nothing was updated
--select * from Profile ORDER BY UpdatedOn DESC -- nothing was updated
--select * from IdDocument
--select * from NameInfo ORDER BY UpdatedOn DESC -- nothing was updated
--select * from ReservationName
--select * from ReservationPreference
--select * from ProfileComment
--select * from ReservationComment
select * from P5ACTIONHISTORY ORDER BY ACT_UPDATED DESC  --!!! new record
--select * from P5ROOMBLOCKINGEVENTS -- second occurence
select * from P5ROOMSTATUS ORDER BY RMS_UPDATED DESC
--select * from ResStayNonRoomBundle  -- nothing was updated
--select * from ResStayNonRoomItem ORDER BY UpdatedOn DESC  -- nothing was updated
--select * from P5GUESTSTAYTRACES ORDER BY GST_UPDATED DESC
--select * from GuestNameInfo ORDER BY  UpdatedOn DESC -- DepartureDate if need to change
select * from P5ACCOUNT ORDER BY ACC_UPDATED DESC -- !!!update ACC_STATUS = 'CLOSED'
--select * from P5RESERVATIONSTAY ORDER BY RSY_UPDATED DESC -- nothing was updated
--select * from P5RESERVATIONSTAYDATE ORDER BY RSD_UPDATED DESC -- nothing was updated
select * from P5ROOMBLOCKINGEVENTS ORDER BY EVT_UPDATED DESC  -- !!! update record
--select * from P5ROOMBLOCKLOCK ORDER BY RBL_UPDATEDON DESC -- probably trigger
--select * from GuestStayStatistics -- covered by proc
--select * from GuestStaySummary -- covered by proc
--select * from ChanPickup ORDER BY UpdatedOn DESC -- probably trigger
--select * from ReservationStayDateChild
--select * from ReservationStayDate ORDER BY UpdatedOn DESC -- looks like nothing was changed
--select * from ReservationShareMigrate 
select * from Reservation ORDER BY UpdatedOn DESC
--select * from P5EGREQUESTQUEUE --probalby a trigger
select * from ReservationStay ORDER BY UpdatedOn DESC
--select * from P5PACKAGELEDGERLOGGING
--select * from R5PROCESSLOCK
--select * from P5ARLEDGERLOGGING
--select * from P5LEDGERLOGGING
--select * from P5SECURITYDEPOSITLEDGERLOGGING


