

-- index stats for block room
--select * from P5TEMPCORETICKET
--select * from R5SESSIONS
--select * from R5WSDUP2
--select * from R5WSMESSAGES
--select * from R5WSMESSAGESTATUS
--select * from R5WSREQHIST
--select * from R5WSMESSAGEBUFFER
--select * from R5WSRSPHIST
--select * from R5XMLTRANSTATUS
--select * from R5XMLTRANSTATUSHIST
select * from P5ROOMSTATUS WHERE RMS_CODE IN (1402, 1404, 402, 1005) -- update  -OOS when active but then VAC
--select * from AvailabilityTableChangeTracker
select * from Inventory ORDER BY InventoryDate DESC-- insert a lot of data. let's hope I don't have to do that
--select * from TrackerPickup

select * from P5ROOMBLOCKINGEVENTS ORDER BY EVT_UPDATED DESC -- insert
-- EVT_EVENTID is PK 
-- WORKORDERNUMBER (is it from p5workorders)
-- case event_id as int  
--looks like when workorder is done, the record is just deleted

select * from P5WORKORDERS -- insert   
--WOS_STATUS before:ACT after:CMPLT
--WOS_OUTOFORDER before:+ after:-
--WOS_BACKINSERVICEDATE before:NULL after:WOS_PLANNEDENDDATE

--select * from Pickup
--select * from R5SCHEDULEDJOBS


DECLARE @Description NVARCHAR(500);
DECLARE @Reason NVARCHAR(20);
DECLARE @Status NVARCHAR(10);
DECLARE @PropertyCode NVARCHAR(4);
DECLARE @CreatedBy NVARCHAR(10);
DECLARE @StartDate DATETIME;
DECLARE @EndDate DATETIME;
DECLARE @RoomCode INT;

SET @Description = N'test tv is broken'
SET @Reason = N'0100'
SET @Status = N'ACT'
SET @PropertyCode = N'VEGA'
SET @CreatedBy = N'R5';
SET @StartDate = '20160705';
SET @EndDate = '20161106';
SET @RoomCode = 1403;

INSERT INTO dbo.P5WORKORDERS
(
    WOS_CODE,
    WOS_ROOMCODE,
    WOS_PROPERTY,
    WOS_STATUS,
    WOS_REASON,
    WOS_DESC,
    WOS_MINOR,
    WOS_STARTDATE,
    WOS_ORIGINALENDDATE,
    WOS_PLANNEDENDDATE,
    WOS_PERSON,
    WOS_NOTE,
    WOS_BACKINSERVICEDATE,
    WOS_UPDATEDBY,
    WOS_UPDATED,
    WOS_CREATEDBY,
    WOS_CREATED,
    WOS_UDFCHAR01,
    WOS_UDFCHAR02,
    WOS_UDFCHAR03,
    WOS_UDFCHAR04,
    WOS_UDFCHAR05,
    WOS_UDFCHAR06,
    WOS_UDFCHAR07,
    WOS_UDFCHAR08,
    WOS_UDFCHAR09,
    WOS_UDFCHAR10,
    WOS_UDFCHAR11,
    WOS_UDFCHAR12,
    WOS_UDFCHAR13,
    WOS_UDFCHAR14,
    WOS_UDFCHAR15,
    WOS_UDFNUM01,
    WOS_UDFNUM02,
    WOS_UDFNUM03,
    WOS_UDFNUM04,
    WOS_UDFNUM05,
    WOS_UDFNUM06,
    WOS_UDFNUM07,
    WOS_UDFNUM08,
    WOS_UDFNUM09,
    WOS_UDFNUM10,
    WOS_UDFDATE01,
    WOS_UDFDATE02,
    WOS_UDFDATE03,
    WOS_UDFDATE04,
    WOS_UDFDATE05,
    WOS_UDFCHKBOX01,
    WOS_UDFCHKBOX02,
    WOS_UDFCHKBOX03,
    WOS_UDFCHKBOX04,
    WOS_UDFCHKBOX05,
    WOS_UPDATECOUNT,
    --WOS_SQLIDENTITY - this column value is auto-generated
    WOS_DEPARTMENT,
    WOS_URGENTWORKORDER,
    WOS_OUTOFORDER,
    WOS_ROOMSTATUS,
    WOS_SERVICETYPE,
    WOS_AUTOCOMPLETE
)
VALUES
(
    (SELECT  ISNULL(MAX(CAST(WOS_CODE AS INT)), 10000) + 1 FROM dbo.P5WORKORDERS), -- WOS_CODE - nvarchar
    @RoomCode, -- WOS_ROOMCODE - nvarchar
    @PropertyCode, -- WOS_PROPERTY - nvarchar
    @Status, -- WOS_STATUS - nvarchar
    @Reason, -- WOS_REASON - nvarchar
    @Description, -- WOS_DESC - nvarchar
    N'-', -- WOS_MINOR - nvarchar
    @StartDate, -- WOS_STARTDATE - datetime
    @EndDate, -- WOS_ORIGINALENDDATE - datetime
    @EndDate, -- WOS_PLANNEDENDDATE - datetime
    N'', -- WOS_PERSON - nvarchar
    N'', -- WOS_NOTE - nvarchar
    NULL, -- WOS_BACKINSERVICEDATE - datetime
    @CreatedBy, -- WOS_UPDATEDBY - nvarchar
    GETDATE(), -- WOS_UPDATED - datetime
    @CreatedBy, -- WOS_CREATEDBY - nvarchar
    GETDATE(), -- WOS_CREATED - datetime
    NULL, -- WOS_UDFCHAR01 - nvarchar
    NULL, -- WOS_UDFCHAR02 - nvarchar
    NULL, -- WOS_UDFCHAR03 - nvarchar
    NULL, -- WOS_UDFCHAR04 - nvarchar
    NULL, -- WOS_UDFCHAR05 - nvarchar
    NULL, -- WOS_UDFCHAR06 - nvarchar
    NULL, -- WOS_UDFCHAR07 - nvarchar
    NULL, -- WOS_UDFCHAR08 - nvarchar
    NULL, -- WOS_UDFCHAR09 - nvarchar
    NULL, -- WOS_UDFCHAR10 - nvarchar
    NULL, -- WOS_UDFCHAR11 - nvarchar
    NULL, -- WOS_UDFCHAR12 - nvarchar
    NULL, -- WOS_UDFCHAR13 - nvarchar
    NULL, -- WOS_UDFCHAR14 - nvarchar
    NULL, -- WOS_UDFCHAR15 - nvarchar
    NULL, -- WOS_UDFNUMNULL1 - numeric
    NULL, -- WOS_UDFNUMNULL2 - numeric
    NULL, -- WOS_UDFNUMNULL3 - numeric
    NULL, -- WOS_UDFNUMNULL4 - numeric
    NULL, -- WOS_UDFNUMNULL5 - numeric
    NULL, -- WOS_UDFNUMNULL6 - numeric
    NULL, -- WOS_UDFNUMNULL7 - numeric
    NULL, -- WOS_UDFNUMNULL8 - numeric
    NULL, -- WOS_UDFNUMNULL9 - numeric
    NULL, -- WOS_UDFNUM1NULL - numeric
    NULL, -- WOS_UDFDATE01 - datetime
    NULL, -- WOS_UDFDATE02 - datetime
    NULL, -- WOS_UDFDATE03 - datetime
    NULL, -- WOS_UDFDATE04 - datetime
    NULL, -- WOS_UDFDATE05 - datetime
    N'-', -- WOS_UDFCHKBOX01 - nvarchar
    N'-', -- WOS_UDFCHKBOX02 - nvarchar
    N'-', -- WOS_UDFCHKBOX03 - nvarchar
    N'-', -- WOS_UDFCHKBOX04 - nvarchar
    N'-', -- WOS_UDFCHKBOX05 - nvarchar
    0, -- WOS_UPDATECOUNT - numeric
    -- WOS_SQLIDENTITY - int
    NULL, -- WOS_DEPARTMENT - nvarchar
    N'-', -- WOS_URGENTWORKORDER - nvarchar
    N'+', -- WOS_OUTOFORDER - nvarchar
    NULL, -- WOS_ROOMSTATUS - nvarchar
    NULL, -- WOS_SERVICETYPE - nvarchar
    N'-' -- WOS_AUTOCOMPLETE - nvarchar
)

DECLARE @WorkOrderNumber NVARCHAR(20);
SET @WorkOrderNumber = SCOPE_IDENTITY();

INSERT INTO dbo.P5ROOMBLOCKINGEVENTS
(
    EVT_EVENTID,
    EVT_ROOM,
    EVT_PROPERTYCODE,
    EVT_RESERVATIONSTAYID,
    EVT_STARTDATE,
    EVT_ENDDATE,
    EVT_EVENTNAME,
    EVT_STATUS,
    EVT_EVENTROOM,
    EVT_PMSCONFIRMATIONNUMBER,
    EVT_GUESTNAME,
    EVT_VIPLEVEL,
    EVT_WORKORDERNUMBER,
    EVT_WORKORDERREASON,
    EVT_DONOTMOVE,
    EVT_CREATEDBY,
    EVT_CREATED,
    EVT_UPDATEDBY,
    EVT_UPDATED,
    EVT_UPDATECOUNT,
    --EVT_SQLIDENTITY - this column value is auto-generated
    EVT_EXPIRATIONDATE,
    EVT_DAYUSE
)
VALUES
(
    (SELECT  ISNULL(MAX(CAST(EVT_EVENTID AS INT)), 10000) + 1 FROM dbo.P5ROOMBLOCKINGEVENTS), -- EVT_EVENTID - nvarchar
    @RoomCode, -- EVT_ROOM - nvarchar
    @PropertyCode, -- EVT_PROPERTYCODE - nvarchar
    NULL, -- EVT_RESERVATIONSTAYID - int
    @StartDate, -- EVT_STARTDATE - datetime
    @EndDate, -- EVT_ENDDATE - datetime
    NULL, -- EVT_EVENTNAME - nvarchar
    'Out of Order', -- EVT_STATUS - nvarchar
    @RoomCode, -- EVT_EVENTROOM - nvarchar
    NULL, -- EVT_PMSCONFIRMATIONNUMBER - nvarchar
    NULL, -- EVT_GUESTNAME - nvarchar
    NULL, -- EVT_VIPLEVEL - nvarchar
    @WorkOrderNumber, -- EVT_WORKORDERNUMBER - nvarchar
    @Reason, -- EVT_WORKORDERREASON - nvarchar
    NULL, -- EVT_DONOTMOVE - nvarchar
    NULL, -- EVT_CREATEDBY - nvarchar
    NULL, -- EVT_CREATED - datetime
    @CreatedBy, -- EVT_UPDATEDBY - nvarchar
    GETDATE(), -- EVT_UPDATED - datetime
    0, -- EVT_UPDATECOUNT - numeric
    -- EVT_SQLIDENTITY - int
    NULL, -- EVT_EXPIRATIONDATE - datetime
    NULL -- EVT_DAYUSE - tinyint
)

UPDATE dbo.P5ROOMSTATUS
SET
    dbo.P5ROOMSTATUS.RMS_FRONTDESKSTATUS = N'OOS', -- nvarchar
    dbo.P5ROOMSTATUS.RMS_HOUSEKEEPINGSTATUS = N'OOS' -- nvarchar
WHERE RMS_CODE = @RoomCode AND RMS_PROPERTY = @PropertyCode