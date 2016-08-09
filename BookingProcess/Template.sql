CREATE PROCEDURE [dbo].[sp_epi_]
--input parameters for the SP
    @ProfileID INT ,
    @SourceCode NVARCHAR(6) ,
    @GuaranteeCode NVARCHAR(6) ,
    @CheckInDate DATETIME ,
    @CheckOutDate DATETIME ,
    @RatePlanCode NVARCHAR(6) ,
    @RoomTypeCode NVARCHAR(6)
AS
    BEGIN TRAN;
    BEGIN TRY
        IF @ProfileID = 1
            BEGIN


			    -- your code goes here
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