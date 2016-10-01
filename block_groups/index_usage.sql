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
select * from PropertyRatePlan -- read rates from here
--select * from AvailabilityTableChangeTracker
--select * from P5ACCNEXTLINENUM  --not sure
select * from P5ACCOUNT -- insert  -- ACC_ACCOUNTID = GROUPBOOKINGID from dbo.account
select * from Account
select * from P5GROUPBOOKINGS
select * from PropGroupBookingLock
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

-- randomly generate 7 figures number
DECLARE @TrackingNumber NVARCHAR(64) = ( SELECT  CONVERT(NUMERIC(7, 0), RAND() * 8999999) + 1000000 );
WHILE @TrackingNumber IN ( SELECT TrackingNumber FROM dbo.TrackingNumber )
    SET @TrackingNumber = ( SELECT  CONVERT(NUMERIC(7, 0), RAND() * 8999999) + 1000000 );
     
INSERT  INTO dbo.TrackingNumber
        ( TrackingNumber ,
            TypeCode ,
            UpdatedBy ,
            UpdatedOn ,
            CreatedBy ,
            CreatedOn
        )
VALUES  ( @TrackingNumber , -- TrackingNumber - nvarchar(64)
            N'CANCEL' , -- TypeCode - nvarchar(6)
            N'system' , -- UpdatedBy - nvarchar(50) --can be manual
            GETDATE() , -- UpdatedOn - datetime
            N'system' , -- CreatedBy - nvarchar(50) --can be manual
            GETDATE()  -- CreatedOn - datetime
        );




IF NOT EXISTS (select profileID from nameinfo where firstname = N'vega default' and lastname = N'group contact')
    BEGIN 
	   DECLARE @ProfileID INT = NULL
	   DECLARE @nowDate datetime = GETDATE()

	   EXEC dbo.prc_RegisterUser
	    @profileid = @ProfileID OUTPUT,
	    @PrimaryLanguageCode = NULL,
	    @EmailAddress = NULL,
	    @ProfileTypeCode = N'GRPCNT',
	    @ProfileStatusCode = N'ACTIVE',
	    @VIPStatusCode = NULL,
	    @AlternateEmailAddress = NULL,
	    @PMSReferenceNumber = NULL,
	    @HasWebAccess = 0,
	    @BirthMonth = 0,
	    @BirthDay = 0,
	    @BirthYear = 0,
	    @GenderCode = NULL,
	    @Notes = NULL,
	    @SourceLastUpdatedBy = 'R5',
	    @SourceLastUpdatedOn = @nowDate,
	    @NamePrefix = NULL,
	    @MiddleInitial = NULL,
	    @NameSuffix = NULL,
	    @NameTitle = NULL,
	    @FirstName = N'vega default',
	    @LastName = N'group contact',
	    @AliasFirstName = NULL,
	    @AliasMiddleName = NULL,
	    @AliasLastName = NULL,
	    @PrimaryContact = NULL,
	    @DCountryAccessNumber = NULL,
	    @DAreaCityCode = NULL,
	    @DPhoneNumberTypeCode = NULL,
	    @DPhoneExtension = NULL,
	    @DPhoneNumber = NULL,
	    @ECountryAccessNumber = NULL,
	    @EAreaCityCode = NULL,
	    @EPhoneNumberTypeCode = NULL,
	    @EPhoneExtension = NULL,
	    @EPhoneNumber = NULL,
	    @PPostalCode = NULL,
	    @PAddressTypeCode = NULL,
	    @PStreetAddress = NULL,
	    @PStreetAddress2 = NULL,
	    @PCity = NULL,
	    @PCountryCode = NULL,
	    @PStateProvince = NULL,
	    @BPostalCode = NULL,
	    @BAddressTypeCode = NULL,
	    @BStreetAddress = NULL,
	    @BStreetAddress2 = NULL,
	    @BCity = NULL,
	    @BCountryCode = NULL,
	    @BStateProvince = NULL,
	    @CustomerUserName = NULL,
	    @HintAnswer = NULL,
	    @HintQuestion = NULL,
	    @Password = NULL,
	    @Expiration = NULL,
	    @CCNumber = NULL,
	    @CCTypeCode = NULL,
	    @CCHolderName = NULL,
	    @IsDefault = 0,
	    @username = N'R5',
	    @OrganizationID = 0,
	    @AdminOrganizationID = 0,
	    @TravelAgencyID = 0,
	    @AdminTravelAgencyID = 0,
	    @ServiceCode = '',
	    @RankCode = '',
	    @PayGradeCode = '',
	    @SupervisorEmailAddress = '',
	    @CustomerID = N'1',
	    @document_type = '',
	    @document_id = NULL,
	    @doc_holder_name = NULL,
	    @issue_authority = NULL,
	    @issue_countryCode = NULL,
	    @effective_date = '',
	    @expiration_date = '',
	    @issue_date = '',
	    @showOnWeb = 0,
	    @receiveEmailMarketingMaterial = 0,
	    @roomCleanTime = '',
	    @roomDownTime = '',
	    @autoEmailFolio = 0,
	    @Token = NULL,
	    @taxID = NULL,
	    @isTaxExempt = 0,
	    @managedProfileID = NULL,
	    @nationality = NULL,
	    @resortFeeCode = NULL,
	    @twitterID = NULL,
	    @facebookID = NULL,
	    @tripAdvisorID = NULL,
	    @bookingDotComID = NULL,
	    @taxExemptCode = NULL,
	    @vehicle = NULL,
	    @countryOfResidence = NULL,
	    @originatingSystemID = NULL,
	    @isEmailOptIn = 0,
	    @isPartnerEmailOptIn = 0,
	    @updatedFromReservation = 0

	   select @ProfileID
    END
ELSE
    select profileID from nameinfo where firstname = N'vega default' and lastname = N'group contact'


DECLARE @GroupName NVARCHAR(100) = N'grouptest'
DECLARE @DefaultRatePlanID INT = 78
DECLARE @StartDate DATETIME = '20160709'
DECLARE @EndDate DATETIME = '20160715'
DECLARE @ReleaseDate DATETIME = '20160714'
DECLARE @RatePlanCode NVARCHAR(6) = N'BOOK'
DECLARE @SourceCode NVARCHAR(6) = N'CALL'-- 'CALL'
DECLARE @GuaranteeCode NVARCHAR(6) = N'CASH' 



DECLARE @MarketSegmentCode NVARCHAR(6)  = ( SELECT   CategoryCodeValue
								    FROM     dbo.RatePlan
								    WHERE    RatePlanCode = @RatePlanCode
								); 

DECLARE @DefaultStreetAddress NVARCHAR(20) = N'default address'
DECLARE @DefaultCity NVARCHAR(20) = N'default city'
DECLARE @Nights INT = DATEDIFF(dd, @StartDate, @EndDate);

INSERT INTO dbo.GroupSalesAccount
(
    --GroupSalesAccountID - this column value is auto-generated
    CustomerID,
    Name,
    Abbreviation,
    PMSReferenceNumber,
    GroupContactID,
    OrganizationID,
    TravelAgencyID,
    CreditCardID,
    StreetAddress,
    City,
    StateProvince,
    PostalCode,
    CountryCode,
    GuaranteeCode,
    BillingStreetAddress,
    BillingCity,
    BillingStateProvince,
    BillingPostalCode,
    BillingCountryCode,
    SourceLastUpdatedBy,
    SourceLastUpdatedOn,
    UpdatedBy,
    UpdatedOn,
    CreatedBy,
    CreatedOn,
    TaxID,
    IsTaxExempt
)
VALUES
(
    -- GroupSalesAccountID - int
    '1', -- CustomerID - varchar
    @GroupName, -- Name - nvarchar
    NULL, -- Abbreviation - nvarchar
    NULL, -- PMSReferenceNumber - nvarchar
    @ProfileID, -- GroupContactID - int
    NULL, -- OrganizationID - int
    NULL, -- TravelAgencyID - int
    NULL, -- CreditCardID - int
    @DefaultStreetAddress, -- StreetAddress - nvarchar
    @DefaultCity, -- City - nvarchar
    NULL, -- StateProvince - nvarchar
    NULL, -- PostalCode - nvarchar
    N'RU', -- CountryCode - nvarchar
    NULL, -- GuaranteeCode - nvarchar
    NULL, -- BillingStreetAddress - nvarchar
    NULL, -- BillingCity - nvarchar
    NULL, -- BillingStateProvince - nvarchar
    NULL, -- BillingPostalCode - nvarchar
    NULL, -- BillingCountryCode - nvarchar
    NULL, -- SourceLastUpdatedBy - nvarchar
    NULL, -- SourceLastUpdatedOn - datetime
    N'R5', -- UpdatedBy - nvarchar
    GETDATE(), -- UpdatedOn - datetime
    N'R5', -- CreatedBy - nvarchar
    GETDATE(), -- CreatedOn - datetime
    NULL, -- TaxID - nvarchar
    0 -- IsTaxExempt - tinyint
)

DECLARE @GroupSalesAccountID INT = SCOPE_IDENTITY ( )

INSERT INTO dbo.PropGroupBooking
(
    --PropGroupBookingID - this column value is auto-generated
    GroupSalesAccountID,
    GroupContactID,
    DefaultRatePlanID,
    PropertyCode,
    GroupStatusCode,
    GroupName,
    GroupTypeCode,
    GroupPMSReferenceNumber,
    GroupBookingReferenceNumber,
    StartDate,
    EndDate,
    RateCutOffDate,
    AllowShoulderStaysFlag,
    ActualReleaseDate,
    PlannedReleaseDate,
    SuppressRateDisplayFlag,
    BillingInstruction,
    ReservationMethodCode,
    SendConfirmationsFlag,
    OverBookingTypeCode,
    MarketSegmentCode,
    SourceOfBusinessCode,
    RoomAllocationChangeFlag,
    RateAllocationChangeFlag,
    AllowOverSellFlag,
    Note,
    StreetAddress,
    City,
    StateProvince,
    CountryCode,
    PostalCode,
    GuaranteeCode,
    BillingStreetAddress,
    BillingCity,
    BillingStateProvince,
    BillingCountryCode,
    BillingPostalCode,
    InternalSalesPersonName,
    CreditCardID,
    HasWebAccess,
    CreatedBy,
    CreatedOn,
    UpdatedBy,
    UpdatedOn,
    SourceLastUpdatedBy,
    SourceLastUpdatedOn,
    OrganizationID,
    TravelAgencyID,
    Abbreviation,
    AllowRoomBorrowing,
    PayCommissionFlag,
    CommissionType,
    CommissionAmount,
    EnableRateCutOff,
    RateCutOffDays,
    ShoulderCutoffRatePlanCode,
    ShoulderCutoffUseBAR,
    ReturnAvailabilitytoHouse,
    TrackCode,
    RegistrationCard,
    CopyNoteToReservation,
    GroupAccessCode,
    UpdateCount,
    TaxID,
    IsTaxExempt,
    MainPropGroupBookingID,
    PriorCancelGroupStatusCode,
    AffectsHouseAvail,
    ComplimentaryRate,
    ForecastingOccupancy,
    ResortFeeCode,
    StreetNumber,
    StreetName,
    Apartment,
    District,
    BillingStreetNumber,
    BillingStreetName,
    BillingApartment,
    BillingDistrict,
    CommissionSecondAmount,
    AdditionalRatePlan1,
    AdditionalRatePlan2,
    AdditionalRatePlan3,
    AdditionalRatePlan4,
    AdditionalRatePlan5,
    AdditionalRatePlan6,
    AdditionalRatePlan7,
    AdditionalRatePlan8,
    AdditionalRatePlan9,
    AdditionalRatePlan10,
    DefaultReleaseDays,
    LastReleaseDate
)
VALUES
(
    -- PropGroupBookingID - int
    @GroupSalesAccountID, -- GroupSalesAccountID - int
    @ProfileID, -- GroupContactID - int
    @DefaultRatePlanID, -- DefaultRatePlanID - int
    N'VEGA', -- PropertyCode - nvarchar
    N'DEFNTE', -- GroupStatusCode - nvarchar
    @GroupName, -- GroupName - nvarchar
    N'OTHER', -- GroupTypeCode - nvarchar
    NULL, -- GroupPMSReferenceNumber - nvarchar
    @TrackingNumber, -- GroupBookingReferenceNumber - nvarchar
    @StartDate, -- StartDate - datetime
    @EndDate, -- EndDate - datetime
    NULL, -- RateCutOffDate - datetime
    NULL, -- AllowShoulderStaysFlag - tinyint
    NULL, -- ActualReleaseDate - datetime
    @ReleaseDate, -- PlannedReleaseDate - datetime
    0, -- SuppressRateDisplayFlag - tinyint
    NULL, -- BillingInstruction - nvarchar
    NULL, -- ReservationMethodCode - nvarchar
    0, -- SendConfirmationsFlag - tinyint
    NULL, -- OverBookingTypeCode - nvarchar
    @MarketSegmentCode, -- MarketSegmentCode - nvarchar
    @SourceCode, -- SourceOfBusinessCode - nvarchar
    NULL, -- RoomAllocationChangeFlag - tinyint
    NULL, -- RateAllocationChangeFlag - tinyint
    NULL, -- AllowOverSellFlag - tinyint
    NULL, -- Note - nvarchar
    @DefaultStreetAddress, -- StreetAddress - nvarchar
    @DefaultCity, -- City - nvarchar
    NULL, -- StateProvince - nvarchar
    N'RU', -- CountryCode - nvarchar
    NULL, -- PostalCode - nvarchar
    @GuaranteeCode, -- GuaranteeCode - nvarchar
    NULL, -- BillingStreetAddress - nvarchar
    NULL, -- BillingCity - nvarchar
    NULL, -- BillingStateProvince - nvarchar
    NULL, -- BillingCountryCode - nvarchar
    NULL, -- BillingPostalCode - nvarchar
    NULL, -- InternalSalesPersonName - nvarchar
    NULL, -- CreditCardID - int
    0, -- HasWebAccess - tinyint
    N'R5', -- CreatedBy - nvarchar
    GETDATE(), -- CreatedOn - datetime
    N'R5', -- UpdatedBy - nvarchar
    GETDATE(), -- UpdatedOn - datetime
    NULL, -- SourceLastUpdatedBy - nvarchar
    NULL, -- SourceLastUpdatedOn - datetime
    NULL, -- OrganizationID - int
    NULL, -- TravelAgencyID - int
    NULL, -- Abbreviation - nvarchar
    1, -- AllowRoomBorrowing - tinyint
    0, -- PayCommissionFlag - tinyint
    NULL -- CommissionType - varchar
    NULL, -- CommissionAmount - decimal
    NULL, -- EnableRateCutOff - tinyint
    NULL, -- RateCutOffDays - int
    NULL, -- ShoulderCutoffRatePlanCode - nvarchar
    NULL, -- ShoulderCutoffUseBAR - tinyint
    NULL, -- ReturnAvailabilitytoHouse - tinyint
    NULL, -- TrackCode - nvarchar
    0, -- RegistrationCard - tinyint
    0, -- CopyNoteToReservation - tinyint
    NULL, -- GroupAccessCode - char
    NULL, -- UpdateCount - numeric
    NULL, -- TaxID - nvarchar
    NULL, -- IsTaxExempt - tinyint
    NULL, -- MainPropGroupBookingID - int
    NULL, -- PriorCancelGroupStatusCode - nvarchar
    0, -- AffectsHouseAvail - tinyint
    NULL, -- ComplimentaryRate - nvarchar
    N'DOUBLE', -- ForecastingOccupancy - nvarchar
    NULL, -- ResortFeeCode - nvarchar
    NULL, -- StreetNumber - nvarchar
    NULL, -- StreetName - nvarchar
    NULL, -- Apartment - nvarchar
    NULL, -- District - nvarchar
    NULL, -- BillingStreetNumber - nvarchar
    NULL, -- BillingStreetName - nvarchar
    NULL, -- BillingApartment - nvarchar
    NULL, -- BillingDistrict - nvarchar
    NULL, -- CommissionSecondAmount - decimal
    NULL, -- AdditionalRatePlan1 - nvarchar
    NULL, -- AdditionalRatePlan2 - nvarchar
    NULL, -- AdditionalRatePlan3 - nvarchar
    NULL, -- AdditionalRatePlan4 - nvarchar
    NULL, -- AdditionalRatePlan5 - nvarchar
    NULL, -- AdditionalRatePlan6 - nvarchar
    NULL, -- AdditionalRatePlan7 - nvarchar
    NULL, -- AdditionalRatePlan8 - nvarchar
    NULL, -- AdditionalRatePlan9 - nvarchar
    NULL, -- AdditionalRatePlan10 - nvarchar
    NULL, -- DefaultReleaseDays - int
    NULL -- LastReleaseDate - datetime
)


DECLARE @PropGroupBookingID INT = SCOPE_IDENTITY()

INSERT INTO PropGroupBookingLock (PropGroupBookingID) VALUES (@PropGroupBookingID)