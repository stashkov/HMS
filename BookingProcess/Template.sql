CREATE PROCEDURE [dbo].[sp_epi_]
--input parameters for the SP
    @ProfileID INT ,
    @SourceCode NVARCHAR(6) = N'CALL' ,
    @GuaranteeCode NVARCHAR(6) = N'6PM' ,
    @CheckInDate DATETIME = '20160705' ,
    @CheckOutDate DATETIME = '20160706' ,
    @RatePlanCode NVARCHAR(6) = N'HIGH1' ,
    @RoomTypeCode NVARCHAR(6) = N'SRTS'
AS
    BEGIN TRAN;
    BEGIN TRY
        IF @ProfileID = 1
            BEGIN
                PRINT 'privet';
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