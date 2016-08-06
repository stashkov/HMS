--select * from R5WSMESSAGEBUFFER
select * from R5WSMESSAGES -- strange rows
select * from R5WSMESSAGESTATUS -- strange rows
select * from R5WSRSPHIST -- strange rows
select * from R5WSDUP2  -- strange rows
select * from R5WSREQHIST  -- strange rows
--select * from AvailabilityTableChangeTracker
--select * from Pickup ORDER BY CreatedOn DESC  -- index was used but no record inserted
select * from P5ROOMBLOCKINGEVENTS ORDER BY EVT_UPDATED DESC -- new record
select * from P5ROOMBLOCKLOCK ORDER BY RBL_UPDATEDON DESC  -- new record  with [dbo].[prc_RoomBlockLock]( @sResStayID int)
select * from P5RESERVATIONSTAY ORDER BY RSY_CREATED DESC -- update RSY_CURRENTROOMCODE WHERE RSY_RESERVATIONSTAYID =...
select * from ReservationStayDate ORDER BY CreatedOn DESC  -- UPDATE RESERVATIONSTAYDATE  SET roomid= @P0 , updatedon= @P1 , updatedby= @P2   WHERE  (RESERVATIONSTAYID =  @P3) AND  (STAYDATE =  @P4)


