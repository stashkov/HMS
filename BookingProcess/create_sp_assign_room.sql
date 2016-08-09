CREATE PROCEDURE [dbo].[sp_epi_assign_room]
-- HMS Interface: assign a room
    @ProfileID INT ,
    @CheckInDate DATETIME ,
    @CheckOutDate DATETIME ,
    @ReservationStayID INT ,
    @ConfirmationNumber NVARCHAR(64) ,
    @RoomCode NVARCHAR(30)
AS
    BEGIN TRAN;
    BEGIN TRY
        DECLARE @RoomID INT;
        DECLARE @PropertyCode NVARCHAR(4);
		
        SET @PropertyCode = N'VEGA';	
        SET @RoomID = ( SELECT TOP 1
                                ROO_ROOMID
                        FROM    dbo.P5ROOM
                        WHERE   ROO_CODE = @RoomCode
                                AND ROO_PROPERTYCODE = @PropertyCode
                      );
		--check if a room is already specified for this ReservationStayID
        IF EXISTS ( SELECT  RoomID
                    FROM    ReservationStayDate
                    WHERE   ReservationStayID = @ReservationStayID
                            AND RoomID = @RoomID )
            AND ( SELECT    RoomID
                  FROM      ReservationStayDate
                  WHERE     ReservationStayID = @ReservationStayID
                            AND RoomID = @RoomID
                ) IS NULL
            BEGIN
                DECLARE @CreatedBy NVARCHAR(10);
                DECLARE @FullName NVARCHAR(102);
                DECLARE @EVENT_ID NVARCHAR(64);

                SET @FullName = ( SELECT    LastName + ', ' + FirstName
                                  FROM      dbo.NameInfo
                                  WHERE     ProfileID = @ProfileID
                                );

                SET @EVENT_ID = ( SELECT    CAST(MAX(EVT_EVENTID) + 1 AS NVARCHAR)
                                  FROM      dbo.P5ROOMBLOCKINGEVENTS  -- documentation says Sequence key of events (maybe PK?)
                                );
								
                UPDATE  dbo.ReservationStayDate
                SET     RoomID = @RoomID -- room id 
                WHERE   ReservationStayID = @ReservationStayID;

                UPDATE  dbo.P5RESERVATIONSTAY
                SET     RSY_CURRENTROOMCODE = @RoomCode -- room number (an actual room number not the ID)
                WHERE   RSY_RESERVATIONSTAYID = @ReservationStayID;

                EXEC dbo.prc_RoomBlockLock @ReservationStayID;
 -- ResStayID

                INSERT  INTO dbo.P5ROOMBLOCKINGEVENTS
                        ( EVT_EVENTID ,
                          EVT_ROOM ,
                          EVT_PROPERTYCODE ,
                          EVT_RESERVATIONSTAYID ,
                          EVT_STARTDATE ,
                          EVT_ENDDATE ,
                          EVT_EVENTNAME ,
                          EVT_STATUS ,
                          EVT_EVENTROOM ,
                          EVT_PMSCONFIRMATIONNUMBER ,
                          EVT_GUESTNAME ,
                          EVT_VIPLEVEL ,
                          EVT_WORKORDERNUMBER ,
                          EVT_WORKORDERREASON ,
                          EVT_DONOTMOVE ,
                          EVT_CREATEDBY ,
                          EVT_CREATED ,
                          EVT_UPDATEDBY ,
                          EVT_UPDATED ,
                          EVT_UPDATECOUNT ,
                          EVT_EXPIRATIONDATE ,
                          EVT_DAYUSE
                        )
                VALUES  ( @EVENT_ID , -- EVT_EVENTID - nvarchar(30) -- TODO not sure how this field is generated, but for now just use max (docs says 'Sequence key of events' so this supports the idea)
                          @RoomID , -- EVT_ROOM - nvarchar(30)
                          @PropertyCode , -- EVT_PROPERTYCODE - nvarchar(15)
                          @ReservationStayID , -- EVT_RESERVATIONSTAYID - int
                          @CheckInDate , -- EVT_STARTDATE - datetime
                          @CheckOutDate , -- EVT_ENDDATE - datetime
                          N'Reservation' , -- EVT_EVENTNAME - nvarchar(15)
                          N'Reserved' , -- EVT_STATUS - nvarchar(15)
                          @RoomID , -- EVT_EVENTROOM - nvarchar(30)
                          @ConfirmationNumber + '-1' , -- EVT_PMSCONFIRMATIONNUMBER - nvarchar(50)
                          @FullName , -- EVT_GUESTNAME - nvarchar(150)
                          NULL , -- EVT_VIPLEVEL - nvarchar(50)
                          NULL , -- EVT_WORKORDERNUMBER - nvarchar(30)
                          NULL , -- EVT_WORKORDERREASON - nvarchar(6)
                          N'0' , -- EVT_DONOTMOVE - nvarchar(6)
                          @CreatedBy , -- EVT_CREATEDBY - nvarchar(30)
                          GETDATE() , -- EVT_CREATED - datetime
                          @CreatedBy , -- EVT_UPDATEDBY - nvarchar(30)
                          GETDATE() , -- EVT_UPDATED - datetime
                          NULL , -- EVT_UPDATECOUNT - numeric
                          NULL , -- EVT_EXPIRATIONDATE - datetime
                          NULL  -- EVT_DAYUSE - tinyint  --TODO may later cause problems with payments
                        );

            END;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            SELECT  @ProfileID AS ProfileID ,
                    ERROR_NUMBER() AS ErrorNumber ,
                    ERROR_MESSAGE() AS ErrorMessage;  
        ROLLBACK;
    END CATCH;
 --If we didn't rollback, @@TRANCOUNT should be > 0 and we should commit
    IF @@TRANCOUNT > 0
        COMMIT;


GO