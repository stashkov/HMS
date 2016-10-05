USE VEGAUAT
GO

--DROP PROCEDURE [dbo].[sp_epi_room_block]
CREATE PROCEDURE [dbo].[sp_epi_room_block]
    @RoomCode INT ,
    @StartDate DATETIME ,
    @EndDate DATETIME ,
    @Reason NVARCHAR(30) ,
    @Description NVARCHAR(500),
    @NEWorCOMPLETEorCANCEL nvarchar(8)
AS
    BEGIN TRY
    BEGIN TRANSACTION
	   DECLARE @WorkOrderNumber NVARCHAR(20);
        DECLARE @Status NVARCHAR(10);
        DECLARE @PropertyCode NVARCHAR(4);
        DECLARE @CreatedBy NVARCHAR(10);
        SET @Status = N'ACT'
        SET @PropertyCode = N'VEGA'
        SET @CreatedBy = N'R5';

        IF @NEWorCOMPLETEorCANCEL = N'NEW'
            BEGIN
			 -- get next sequence for P5WORKORDERS table 
			 EXEC dbo.GetNextSequence @sequenceAlias = N'WORKORDERS', @seqNum = @WorkOrderNumber OUTPUT
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
                    --(SELECT  ISNULL(MAX(CAST(WOS_CODE AS INT)), 10000) + 1 FROM dbo.P5WORKORDERS), -- WOS_CODE - nvarchar
				@WorkOrderNumber, --WOS_CODE - nvarchar
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

			 -- get next sequence for P5ACCOUNT table
			 DECLARE @EVT_EVENTID INT
			 EXEC dbo.GetNextSequence @sequenceAlias = N'EVENT', @seqNum = @EVT_EVENTID OUTPUT

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
                    @EVT_EVENTID, -- EVT_EVENTID - nvarchar
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
                    RMS_FRONTDESKSTATUS = N'OOS', -- nvarchar
                    RMS_HOUSEKEEPINGSTATUS = N'OOS' -- nvarchar
                WHERE RMS_CODE = @RoomCode AND RMS_PROPERTY = @PropertyCode
			 
            END;

	  SET @WorkOrderNumber = ( SELECT WOS_CODE FROM dbo.P5WORKORDERS 
						  WHERE WOS_REASON = @Reason
							 AND WOS_DESC = @Description
							 AND WOS_ROOMCODE = @RoomCode
							 AND WOS_STARTDATE = @StartDate )

        IF @NEWorCOMPLETEorCANCEL = N'COMPLETE'
            BEGIN

                UPDATE dbo.P5WORKORDERS
                SET 
                    WOS_STATUS = N'CMPLT',
                    WOS_OUTOFORDER = N'-',
                    WOS_BACKINSERVICEDATE = @EndDate
                WHERE WOS_SQLIDENTITY = @WorkOrderNumber

                DELETE 
                FROM dbo.P5ROOMBLOCKINGEVENTS
                WHERE EVT_WORKORDERNUMBER = @WorkOrderNumber

                UPDATE dbo.P5ROOMSTATUS
                SET
                    RMS_FRONTDESKSTATUS = N'VAC', -- nvarchar
                    RMS_HOUSEKEEPINGSTATUS = N'VAC' -- nvarchar
                WHERE RMS_CODE = @RoomCode AND RMS_PROPERTY = @PropertyCode

            END;
	   IF @NEWorCOMPLETEorCANCEL = N'CANCEL'
		  BEGIN
			 UPDATE P5WORKORDERS
			 SET 
				WOS_STATUS = N'CAN'
			 WHERE WOS_CODE = @WorkOrderNumber

			 DELETE 
			 FROM dbo.P5ROOMBLOCKINGEVENTS
			 WHERE EVT_WORKORDERNUMBER = @WorkOrderNumber

			 UPDATE dbo.P5ROOMSTATUS
			 SET
				RMS_FRONTDESKSTATUS = N'VAC', -- nvarchar
				RMS_HOUSEKEEPINGSTATUS = N'VAC' -- nvarchar
			 WHERE RMS_CODE = @RoomCode AND RMS_PROPERTY = @PropertyCode

		  END;
    COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
	   BEGIN
		  IF @@TRANCOUNT > 0
			 SELECT  ERROR_MESSAGE() AS ErrorMessage;  
			 ROLLBACK TRANSACTION;
	   END
    END CATCH;



GO


