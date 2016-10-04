use vegauat
go

DECLARE @GroupName NVARCHAR(100) = N'mhuhuua000222'
DECLARE @RatePlanCode NVARCHAR(6) = N'BOOK'
DECLARE @CheckInDate DATETIME = '20160709'
DECLARE @CheckOutDate DATETIME = '20160715'
DECLARE @ReleaseDate DATETIME = '20160714'
DECLARE @RatePlanList NVARCHAR(100) = N'SRTS,STQS,STTS'
DECLARE @SourceCode NVARCHAR(6) = N'CALL'


DECLARE @DefaultRatePlanID INT = (SELECT PropertyRatePlanID FROM dbo.PropertyRatePlan WHERE RatePlanCode = @RatePlanCode)
DECLARE @GuaranteeCode NVARCHAR(6) = N'CC-GTD'

DECLARE @CancellationFeePolicyID INT = (select BookingPolicyID from [dbo].[BookingPolicy] WHERE name = N'48H') 
DECLARE @CreatedBy NVARCHAR(2) = N'R5'
DECLARE @PropertyCode nvarchar(4) = N'VEGA'
DECLARE @MarketSegmentCode NVARCHAR(6)  = ( SELECT   CategoryCodeValue
                                    FROM     dbo.RatePlan
                                    WHERE    RatePlanCode = @RatePlanCode); 
DECLARE @DefaultStreetAddress NVARCHAR(20) = N'default group address'
DECLARE @DefaultCity NVARCHAR(20) = N'default group city'
DECLARE @Nights INT = DATEDIFF(dd, @CheckInDate, @CheckOutDate);

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

-- create default profile, if exists use it
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
        @SourceLastUpdatedBy = @CreatedBy,
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
        @DPhoneNumber = 1111111,
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
        @username = @CreatedBy,
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

    END
ELSE
    SET @ProfileID = (select profileID from nameinfo where firstname = N'vega default' and lastname = N'group contact')
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
    @CreatedBy, -- UpdatedBy - nvarchar
    GETDATE(), -- UpdatedOn - datetime
    @CreatedBy, -- CreatedBy - nvarchar
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
    @CheckInDate, -- StartDate - datetime
    @CheckOutDate, -- EndDate - datetime
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
    @CreatedBy, -- CreatedBy - nvarchar
    GETDATE(), -- CreatedOn - datetime
    @CreatedBy, -- UpdatedBy - nvarchar
    GETDATE(), -- UpdatedOn - datetime
    NULL, -- SourceLastUpdatedBy - nvarchar
    NULL, -- SourceLastUpdatedOn - datetime
    NULL, -- OrganizationID - int
    NULL, -- TravelAgencyID - int
    NULL, -- Abbreviation - nvarchar
    1, -- AllowRoomBorrowing - tinyint
    0, -- PayCommissionFlag - tinyint
    NULL, -- CommissionType - varchar
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


INSERT INTO dbo.P5GROUPBOOKINGS
(
    GRB_PROPGROUPBOOKINGID,
    GRB_BOOKERTYPECODE,
    GRB_BOOKERID,
    GRB_NIGHTS,
    GRB_COORDINATORNAME,
    GRB_TAXEXEMPTCODE,
    GRB_COPYTOBILLINGDETAILS,
    GRB_BILLINGLASTNAME,
    GRB_BILLINGFIRSTNAME,
    GRB_BILLINGPHONENUMBER,
    GRB_BILLINGFAXNUMBER,
    GRB_BILLINGEMAILADDRESS,
    GRB_REASONFORSTAYCODE,
    GRB_GEOGRAPHICCODE,
    GRB_ARACCOUNTNUMBER,
    GRB_BILLINGREFERENCE,
    GRB_TRAVELAGENCYID2,
    GRB_COMMISSIONTYPE2,
    GRB_COMMISSIONAMOUNT2,
    GRB_TRAVELAGENCYID3,
    GRB_COMMISSIONTYPE3,
    GRB_COMMISSIONAMOUNT3,
    GRB_DEPOSITDUEDATE,
    GRB_DEPOSITAMOUNT,
    GRB_GROUPGUARANTEECODE,
    GRB_GROUPCREDITCARDID,
    GRB_DELEGATEDEPOSITPOLICYID,
    GRB_DELEGATEARACCOUNTNUMBER,
    GRB_DELEGATEBILLINGREFERENCE,
    GRB_SETTLEMENTTYPECODE,
    GRB_SETTLEMENTCREDITCARDID,
    GRB_SETTLEMENTPOSTALCODE,
    GRB_CANCELLATIONDATE,
    GRB_CANCELLATIONNUMBER,
    GRB_CANCELLATIONREASONCODE,
    GRB_UDFCHAR01,
    GRB_UDFCHAR02,
    GRB_UDFCHAR03,
    GRB_UDFCHAR04,
    GRB_UDFCHAR05,
    GRB_UDFCHAR06,
    GRB_UDFCHAR07,
    GRB_UDFCHAR08,
    GRB_UDFCHAR09,
    GRB_UDFCHAR10,
    GRB_UDFCHAR11,
    GRB_UDFCHAR12,
    GRB_UDFCHAR13,
    GRB_UDFCHAR14,
    GRB_UDFCHAR15,
    GRB_UDFNUM01,
    GRB_UDFNUM02,
    GRB_UDFNUM03,
    GRB_UDFNUM04,
    GRB_UDFNUM05,
    GRB_UDFNUM06,
    GRB_UDFNUM07,
    GRB_UDFNUM08,
    GRB_UDFNUM09,
    GRB_UDFNUM10,
    GRB_UDFDATE01,
    GRB_UDFDATE02,
    GRB_UDFDATE03,
    GRB_UDFDATE04,
    GRB_UDFDATE05,
    GRB_UDFCHKBOX01,
    GRB_UDFCHKBOX02,
    GRB_UDFCHKBOX03,
    GRB_UDFCHKBOX04,
    GRB_UDFCHKBOX05,
    GRB_CREATEDBY,
    GRB_CREATED,
    GRB_UPDATEDBY,
    GRB_UPDATED,
    GRB_UPDATECOUNT,
    --GRB_SQLIDENTITY - this column value is auto-generated
    GRB_COMMISSIONSECONDAMOUNT2,
    GRB_COMMISSIONSECONDAMOUNT3,
    GRB_DELSETTLEMENTTYPECODE,
    GRB_DELSETTLEMENTCRCARDID,
    GRB_DELSETTLEMENTARACCNUMBER,
    GRB_DELSETTLEMENTBILLINGREF,
    GRB_DELSETTLEMENTNOPOST,
    GRB_DELSETTLEMENTBILLZIPCODE,
    GRB_CREATEINACTIVEPROFILEFLAG,
    GRB_GUARANTEEPOLICYID,
    GRB_CANCELATIONFEEPOLICYID,
    GRB_CANCELATIONREFUNDPOLICYID,
    GRB_BILLINGLANGUAGECODE,
    GRB_PROMISEDROOMNIGHTS,
    GRB_PROMISEDLOWRATE,
    GRB_PROMISEDHIGHRATE,
    GRB_CRSONLINEURL,
    GRB_LEADID,
    GRB_CRSRATEPLAN,
    GRB_LOYALTYNUMBER,
    GRB_HQID,
    GRB_BRANCHID,
    GRB_BRANCHNAME
)
VALUES
(
    @PropGroupBookingID, -- GRB_PROPGROUPBOOKINGID - int
    NULL, -- GRB_BOOKERTYPECODE - nvarchar
    NULL, -- GRB_BOOKERID - int
    @Nights, -- GRB_NIGHTS - int
    NULL, -- GRB_COORDINATORNAME - nvarchar
    NULL, -- GRB_TAXEXEMPTCODE - nvarchar
    N'-', -- GRB_COPYTOBILLINGDETAILS - nvarchar
    NULL, -- GRB_BILLINGLASTNAME - nvarchar
    NULL, -- GRB_BILLINGFIRSTNAME - nvarchar
    NULL, -- GRB_BILLINGPHONENUMBER - nvarchar
    NULL, -- GRB_BILLINGFAXNUMBER - nvarchar
    NULL, -- GRB_BILLINGEMAILADDRESS - nvarchar
    NULL, -- GRB_REASONFORSTAYCODE - nvarchar
    NULL, -- GRB_GEOGRAPHICCODE - nvarchar
    NULL, -- GRB_ARACCOUNTNUMBER - nvarchar
    NULL, -- GRB_BILLINGREFERENCE - nvarchar
    NULL, -- GRB_TRAVELAGENCYID2 - int
    NULL, -- GRB_COMMISSIONTYPE2 - varchar
    NULL, -- GRB_COMMISSIONAMOUNT2 - decimal
    NULL, -- GRB_TRAVELAGENCYID3 - int
    NULL, -- GRB_COMMISSIONTYPE3 - varchar
    NULL, -- GRB_COMMISSIONAMOUNT3 - decimal
    NULL, -- GRB_DEPOSITDUEDATE - datetime
    NULL, -- GRB_DEPOSITAMOUNT - numeric
    NULL, -- GRB_GROUPGUARANTEECODE - nvarchar
    NULL, -- GRB_GROUPCREDITCARDID - int
    NULL, -- GRB_DELEGATEDEPOSITPOLICYID - int
    NULL, -- GRB_DELEGATEARACCOUNTNUMBER - nvarchar
    NULL, -- GRB_DELEGATEBILLINGREFERENCE - nvarchar
    NULL, -- GRB_SETTLEMENTTYPECODE - nvarchar
    NULL, -- GRB_SETTLEMENTCREDITCARDID - int
    NULL, -- GRB_SETTLEMENTPOSTALCODE - nvarchar
    NULL, -- GRB_CANCELLATIONDATE - datetime
    NULL, -- GRB_CANCELLATIONNUMBER - nvarchar
    NULL, -- GRB_CANCELLATIONREASONCODE - nvarchar
    NULL, -- GRB_UDFCHAR01 - nvarchar
    NULL, -- GRB_UDFCHAR02 - nvarchar
    NULL, -- GRB_UDFCHAR03 - nvarchar
    NULL, -- GRB_UDFCHAR04 - nvarchar
    NULL, -- GRB_UDFCHAR05 - nvarchar
    NULL, -- GRB_UDFCHAR06 - nvarchar
    NULL, -- GRB_UDFCHAR07 - nvarchar
    NULL, -- GRB_UDFCHAR08 - nvarchar
    NULL, -- GRB_UDFCHAR09 - nvarchar
    NULL, -- GRB_UDFCHAR10 - nvarchar
    NULL, -- GRB_UDFCHAR11 - nvarchar
    NULL, -- GRB_UDFCHAR12 - nvarchar
    NULL, -- GRB_UDFCHAR13 - nvarchar
    NULL, -- GRB_UDFCHAR14 - nvarchar
    NULL, -- GRB_UDFCHAR15 - nvarchar
    NULL, -- GRB_UDFNUM01 - numeric
    NULL, -- GRB_UDFNUM02 - numeric
    NULL, -- GRB_UDFNUM03 - numeric
    NULL, -- GRB_UDFNUM04 - numeric
    NULL, -- GRB_UDFNUM05 - numeric
    NULL, -- GRB_UDFNUM06 - numeric
    NULL, -- GRB_UDFNUM07 - numeric
    NULL, -- GRB_UDFNUM08 - numeric
    NULL, -- GRB_UDFNUM09 - numeric
    NULL, -- GRB_UDFNUM10 - numeric
    NULL, -- GRB_UDFDATE01 - datetime
    NULL, -- GRB_UDFDATE02 - datetime
    NULL, -- GRB_UDFDATE03 - datetime
    NULL, -- GRB_UDFDATE04 - datetime
    NULL, -- GRB_UDFDATE05 - datetime
    N'-', -- GRB_UDFCHKBOX01 - nvarchar
    N'-', -- GRB_UDFCHKBOX02 - nvarchar
    N'-', -- GRB_UDFCHKBOX03 - nvarchar
    N'-', -- GRB_UDFCHKBOX04 - nvarchar
    N'-', -- GRB_UDFCHKBOX05 - nvarchar
    @CreatedBy, -- GRB_CREATEDBY - nvarchar
    GETDATE(), -- GRB_CREATED - datetime
    N'', -- GRB_UPDATEDBY - nvarchar
    GETDATE(), -- GRB_UPDATED - datetime
    0, -- GRB_UPDATECOUNT - numeric
    -- GRB_SQLIDENTITY - int
    NULL, -- GRB_COMMISSIONSECONDAMOUNT2 - decimal
    NULL, -- GRB_COMMISSIONSECONDAMOUNT3 - decimal
    NULL, -- GRB_DELSETTLEMENTTYPECODE - nvarchar
    NULL, -- GRB_DELSETTLEMENTCRCARDID - int
    NULL, -- GRB_DELSETTLEMENTARACCNUMBER - nvarchar
    NULL, -- GRB_DELSETTLEMENTBILLINGREF - nvarchar
    0, -- GRB_DELSETTLEMENTNOPOST - tinyint
    NULL, -- GRB_DELSETTLEMENTBILLZIPCODE - nvarchar
    0, -- GRB_CREATEINACTIVEPROFILEFLAG - tinyint
    3, -- GRB_GUARANTEEPOLICYID - int -- TODO map to actual epitome value
    @CancellationFeePolicyID, -- GRB_CANCELATIONFEEPOLICYID - int  
    NULL, -- GRB_CANCELATIONREFUNDPOLICYID - int
    NULL, -- GRB_BILLINGLANGUAGECODE - nvarchar
    NULL, -- GRB_PROMISEDROOMNIGHTS - int
    NULL, -- GRB_PROMISEDLOWRATE - decimal
    NULL, -- GRB_PROMISEDHIGHRATE - decimal
    NULL, -- GRB_CRSONLINEURL - nvarchar
    NULL, -- GRB_LEADID - nvarchar
    NULL, -- GRB_CRSRATEPLAN - nvarchar
    NULL, -- GRB_LOYALTYNUMBER - nvarchar
    NULL, -- GRB_HQID - nvarchar
    NULL, -- GRB_BRANCHID - nvarchar
    NULL -- GRB_BRANCHNAME - nvarchar
)

INSERT  INTO dbo.Account
        ( PropertyCode ,
            PmsAccountRef ,
            AccountType ,
            ReservationStayId ,
            GroupBookingId ,
            SourceOfBusinessCode ,
            MarketSegmentCode ,
            CreatedBy ,
            CreatedOn ,
            UpdatedBy ,
            UpdatedOn
        )
VALUES  ( @PropertyCode , -- PropertyCode - nvarchar(15)
            @TrackingNumber , -- PmsAccountRef - nvarchar(20)
            N'GROUP' , -- AccountType - nvarchar(6)
            NULL , -- ReservationStayId - int
            @PropGroupBookingID , -- GroupBookingId - int
            NULL , -- SourceOfBusinessCode - nvarchar(6)
            NULL , -- MarketSegmentCode - nvarchar(6)
            @CreatedBy , -- CreatedBy - nvarchar(50)
            GETDATE() , -- CreatedOn - datetime
            @CreatedBy , -- UpdatedBy - nvarchar(50)
            GETDATE()  -- UpdatedOn - datetime
        );

DECLARE @AccountID INT = SCOPE_IDENTITY();

-- get next sequence for P5ACCOUNT table
DECLARE @ACC_ACCOUNT INT
EXEC dbo.GetNextSequence @sequenceAlias = N'ACC', @seqNum = @ACC_ACCOUNT OUTPUT

INSERT  INTO dbo.P5ACCOUNT
        ( ACC_ACCOUNT ,
            ACC_PROPERTY ,
            ACC_ACCOUNTTYPE ,
            ACC_ACCOUNTNAME ,
            ACC_ACCOUNTID ,
            ACC_ARACCOUNTID ,
            ACC_ARBILLINGREFERENCE ,
            ACC_STATUS ,
            ACC_STARTDATE ,
            ACC_ENDDATE ,
            ACC_BALANCE ,
            ACC_COREACCOUNTID ,
            ACC_UPDATEDBY ,
            ACC_UPDATED ,
            ACC_CREATEDBY ,
            ACC_CREATED ,
            ACC_UPDATECOUNT ,
            ACC_UNPOSTABLECHARGE ,
            ACC_UDFCHAR01 ,
            ACC_UDFCHAR02 ,
            ACC_UDFCHAR03 ,
            ACC_UDFCHAR04 ,
            ACC_UDFCHAR05 ,
            ACC_UDFCHAR06 ,
            ACC_UDFCHAR07 ,
            ACC_UDFCHAR08 ,
            ACC_UDFCHAR09 ,
            ACC_UDFCHAR10 ,
            ACC_UDFCHAR11 ,
            ACC_UDFCHAR12 ,
            ACC_UDFCHAR13 ,
            ACC_UDFCHAR14 ,
            ACC_UDFCHAR15 ,
            ACC_UDFNUM01 ,
            ACC_UDFNUM02 ,
            ACC_UDFNUM03 ,
            ACC_UDFNUM04 ,
            ACC_UDFNUM05 ,
            ACC_UDFNUM06 ,
            ACC_UDFNUM07 ,
            ACC_UDFNUM08 ,
            ACC_UDFNUM09 ,
            ACC_UDFNUM10 ,
            ACC_UDFDATE01 ,
            ACC_UDFDATE02 ,
            ACC_UDFDATE03 ,
            ACC_UDFDATE04 ,
            ACC_UDFDATE05 ,
            ACC_UDFCHKBOX01 ,
            ACC_UDFCHKBOX02 ,
            ACC_UDFCHKBOX03 ,
            ACC_UDFCHKBOX04 ,
            ACC_UDFCHKBOX05 ,
            ACC_INTERFACETOKEN ,
            ACC_NOPOST ,
            ACC_PRINTONFOLIO ,
            ACC_LASTNAME ,
            ACC_FIRSTNAME ,
            ACC_PHONENUMBER ,
            ACC_FAX ,
            ACC_EMAILADDRESS ,
            ACC_ADDRESS ,
            ACC_COUNTRYCODE ,
            ACC_CITY ,
            ACC_STATEPROVINCE ,
            ACC_ZIPCODE ,
            ACC_CREDITCARDTC ,
            ACC_GUESTLEDGEROFFSETTC ,
            ACC_DEPOSITLEDGEROFFSETTC ,
            ACC_TAXSTATUSCODE ,
            ACC_TAXINVOICETYPE ,
            ACC_NEVERTAXINVOICE ,
            ACC_HQID ,
            ACC_BRANCHID ,
            ACC_BRANCHNAME
        )
VALUES  (
            @ACC_ACCOUNT, -- ACC_ACCOUNT - nvarchar(30)  --- unique ID for this table (from HMS documentation)
            @PropertyCode , -- ACC_PROPERTY - nvarchar(15)
            N'GROUP' , -- ACC_ACCOUNTTYPE - nvarchar(6)
            @GroupName , -- ACC_ACCOUNTNAME - nvarchar(102)
            @PropGroupBookingID , -- ACC_ACCOUNTID - bigint  --Original reference id for account type. For example, ReservationStayId for Guest Account.
            NULL , -- ACC_ARACCOUNTID - numeric
            NULL , -- ACC_ARBILLINGREFERENCE - nvarchar(1000)
            N'PEND' , -- ACC_STATUS - nvarchar(6)
            @CheckInDate , -- ACC_STARTDATE - datetime
            NULL , -- ACC_ENDDATE - datetime
            NULL , -- ACC_BALANCE - numeric
            @AccountID , -- ACC_COREACCOUNTID - int  ---------comes from dbo.Account (Matching Account ID in Core table)
            @CreatedBy , -- ACC_UPDATEDBY - nvarchar(30)
            GETDATE() , -- ACC_UPDATED - datetime
            @CreatedBy , -- ACC_CREATEDBY - nvarchar(30)
            GETDATE() , -- ACC_CREATED - datetime
            1 , -- ACC_UPDATECOUNT - numeric
            N'-' , -- ACC_UNPOSTABLECHARGE - nvarchar(1)
            NULL , -- ACC_UDFCHAR01 - nvarchar(80)
            NULL , -- ACC_UDFCHAR02 - nvarchar(80)
            NULL , -- ACC_UDFCHAR03 - nvarchar(80)
            NULL , -- ACC_UDFCHAR04 - nvarchar(80)
            NULL , -- ACC_UDFCHAR05 - nvarchar(80)
            NULL , -- ACC_UDFCHAR06 - nvarchar(80)
            NULL , -- ACC_UDFCHAR07 - nvarchar(80)
            NULL , -- ACC_UDFCHAR08 - nvarchar(80)
            NULL , -- ACC_UDFCHAR09 - nvarchar(80)
            NULL , -- ACC_UDFCHAR10 - nvarchar(80)
            NULL , -- ACC_UDFCHAR11 - nvarchar(80)
            NULL , -- ACC_UDFCHAR12 - nvarchar(80)
            NULL , -- ACC_UDFCHAR13 - nvarchar(80)
            NULL , -- ACC_UDFCHAR14 - nvarchar(80)
            NULL , -- ACC_UDFCHAR15 - nvarchar(80)
            NULL , -- ACC_UDFNUM01 - numeric
            NULL , -- ACC_UDFNUM02 - numeric
            NULL , -- ACC_UDFNUM03 - numeric
            NULL , -- ACC_UDFNUM04 - numeric
            NULL , -- ACC_UDFNUM05 - numeric
            NULL , -- ACC_UDFNUM06 - numeric
            NULL , -- ACC_UDFNUM07 - numeric
            NULL , -- ACC_UDFNUM08 - numeric
            NULL , -- ACC_UDFNUM09 - numeric
            NULL , -- ACC_UDFNUM10 - numeric
            NULL , -- ACC_UDFDATE01 - datetime
            NULL , -- ACC_UDFDATE02 - datetime
            NULL , -- ACC_UDFDATE03 - datetime
            NULL , -- ACC_UDFDATE04 - datetime
            NULL , -- ACC_UDFDATE05 - datetime
            N'-' , -- ACC_UDFCHKBOX01 - nvarchar(1)
            N'-' , -- ACC_UDFCHKBOX02 - nvarchar(1)
            N'-' , -- ACC_UDFCHKBOX03 - nvarchar(1)
            N'-' , -- ACC_UDFCHKBOX04 - nvarchar(1)
            N'-' , -- ACC_UDFCHKBOX05 - nvarchar(1)
            NULL , -- ACC_INTERFACETOKEN - nvarchar(6)
            N'-' , -- ACC_NOPOST - nvarchar(1)
            N'-' , -- ACC_PRINTONFOLIO - nvarchar(1)
            NULL , -- ACC_LASTNAME - nvarchar(50)
            NULL , -- ACC_FIRSTNAME - nvarchar(50)
            NULL , -- ACC_PHONENUMBER - nvarchar(50)
            NULL , -- ACC_FAX - nvarchar(50)
            NULL , -- ACC_EMAILADDRESS - nvarchar(50)
            NULL , -- ACC_ADDRESS - nvarchar(400)
            NULL , -- ACC_COUNTRYCODE - nvarchar(6)
            NULL , -- ACC_CITY - nvarchar(50)
            NULL , -- ACC_STATEPROVINCE - nvarchar(50)
            NULL , -- ACC_ZIPCODE - nvarchar(20)
            NULL , -- ACC_CREDITCARDTC - nvarchar(6)
            NULL , -- ACC_GUESTLEDGEROFFSETTC - nvarchar(6)
            NULL , -- ACC_DEPOSITLEDGEROFFSETTC - nvarchar(6)
            NULL , -- ACC_TAXSTATUSCODE - nvarchar(6)
            NULL , -- ACC_TAXINVOICETYPE - nvarchar(6)
            NULL , -- ACC_NEVERTAXINVOICE - tinyint
            NULL , -- ACC_HQID - nvarchar(50)
            NULL , -- ACC_BRANCHID - nvarchar(50)
            NULL  -- ACC_BRANCHNAME - nvarchar(50)
        );

-- updates ACC_INTERFACETOKEN; flush output of SP to devnull
DECLARE @devnull TABLE (token int)
INSERT @devnull (token)
EXEC dbo.O7ASSIGNINTERFACETOKENFORACCOUNT @sPropertyCode = @PropertyCode, @sAccount = @AccountID;

INSERT INTO dbo.PropertyRatePlan
(
    --PropertyRatePlanID - this column value is auto-generated
    RatePlanCode,
    PropertyCode,
    IsPercentAdjusted,
    PercentAmount,
    BaseRatePlanID,
    ActiveFlag,
    RoundingScaleCode,
    RoundingAmount,
    RateDurationCode,
    RatePlanTypeCode,
    PropGroupBookingID,
    PromotionCode,
    PackagePlanCode,
    AssociatedPropertyRatePlanID,
    RateInformation,
    CurrencyCode,
    ApplyDynamicPricing,
    IsTaxIncluded,
    IsQualifiedWebRate,
    IsYieldable,
    IsExclusiveRate,
    IsBARRate,
    ToBeMigrated,
    RateBasis,
    AllowOverride,
    IsRoomOnly,
    IsIncludePackageItem,
    MinLOS,
    MaxLOS,
    BeyondLOSRatePlanCode,
    IsQuoteBar,
    MinGuest,
    ManualAdjustment,
    UpdateCount,
    UpdatedBy,
    UpdatedOn,
    CreatedBy,
    CreatedOn,
    IsCommissionableRate,
    IsComplimentary,
    RoomChargeCode,
    MinLeadTime,
    MaxLeadTime,
    VacantRoomChargeCode,
    LeaseChargeCode,
    AllowWeeklyRate,
    AllowMonthlyRate,
    UseAdjustmentPeriod,
    IsCRSRate,
    IsGroupRate,
    IsTrackingRate,
    SendRateToCRS,
    SendGtdToCRS,
    RateLevelCode,
    TrackCode,
    RateCategoryCode,
    HouseUse,
    ManageRatesDaily
)
VALUES
(
    -- PropertyRatePlanID - int
    NULL, -- RatePlanCode - nvarchar
    @PropertyCode, -- PropertyCode - nvarchar
    NULL, -- IsPercentAdjusted - tinyint
    NULL, -- PercentAmount - decimal
    NULL, -- BaseRatePlanID - int
    1, -- ActiveFlag - tinyint
    NULL, -- RoundingScaleCode - nvarchar
    NULL, -- RoundingAmount - decimal
    N'CD', -- RateDurationCode - nvarchar
    N'GR', -- RatePlanTypeCode - nvarchar
    @PropGroupBookingID, -- PropGroupBookingID - int
    NULL, -- PromotionCode - nvarchar
    NULL, -- PackagePlanCode - nvarchar
    NULL, -- AssociatedPropertyRatePlanID - int
    NULL, -- RateInformation - nvarchar
    N'RUB', -- CurrencyCode - nvarchar
    NULL, -- ApplyDynamicPricing - tinyint
    0, -- IsTaxIncluded - tinyint
    0, -- IsQualifiedWebRate - tinyint
    0, -- IsYieldable - tinyint
    0, -- IsExclusiveRate - tinyint
    0, -- IsBARRate - tinyint
    0, -- ToBeMigrated - tinyint
    NULL, -- RateBasis - nvarchar
    0, -- AllowOverride - tinyint
    1, -- IsRoomOnly - tinyint
    0, -- IsIncludePackageItem - tinyint
    NULL, -- MinLOS - int
    NULL, -- MaxLOS - int
    NULL, -- BeyondLOSRatePlanCode - nvarchar
    0, -- IsQuoteBar - tinyint
    NULL, -- MinGuest - int
    0, -- ManualAdjustment - tinyint
    NULL, -- UpdateCount - numeric
    @CreatedBy, -- UpdatedBy - nvarchar
    GETDATE(), -- UpdatedOn - datetime
    @CreatedBy, -- CreatedBy - nvarchar
    GETDATE(), -- CreatedOn - datetime
    1, -- IsCommissionableRate - tinyint
    0, -- IsComplimentary - tinyint
    NULL, -- RoomChargeCode - nvarchar
    NULL, -- MinLeadTime - int
    NULL, -- MaxLeadTime - int
    NULL, -- VacantRoomChargeCode - nvarchar
    NULL, -- LeaseChargeCode - nvarchar
    0, -- AllowWeeklyRate - tinyint
    0, -- AllowMonthlyRate - tinyint
    0, -- UseAdjustmentPeriod - tinyint
    0, -- IsCRSRate - tinyint
    0, -- IsGroupRate - tinyint
    0, -- IsTrackingRate - tinyint
    0, -- SendRateToCRS - tinyint
    0, -- SendGtdToCRS - tinyint
    NULL, -- RateLevelCode - nvarchar
    NULL, -- TrackCode - nvarchar
    NULL, -- RateCategoryCode - nvarchar
    0, -- HouseUse - tinyint
    NULL -- ManageRatesDaily - tinyint
)

DECLARE @PropertyRatePlanID int = SCOPE_IDENTITY()

INSERT INTO [dbo].[PackageInfo]
           ([PropertyRatePlanID]
           ,[TermCondition]
           ,[MinLeadTime]
           ,[ArrivalDayPattern]
           ,[StayThroughDayPattern]
           ,[IsRepeatable]
           ,[Duration]
           ,[PackageTransactionCode]
           ,[PackageOffsetCode]
           ,[PostPackageTotal]
           ,[CreatedBy]
           ,[CreatedOn]
           ,[UpdatedBy]
           ,[UpdatedOn]
           ,[ShowTaxInPackagePrice]
           ,[UseAltPackageTaxCalc])
     VALUES
           (
         @PropertyRatePlanID, --<PropertyRatePlanID, int,>
           N'',--,<TermCondition, nvarchar(255),>
           NULL,--,<MinLeadTime, int,>
           127,--,<ArrivalDayPattern, int,>
           127,--,<StayThroughDayPattern, int,>
           1,--,<IsRepeatable, tinyint,>
           NULL,--,<Duration, int,>
           NULL,--,<PackageTransactionCode, nvarchar(6),>
           NULL,--,<PackageOffsetCode, nvarchar(6),>
           NULL,--,<PostPackageTotal, tinyint,>
           @CreatedBy,--,<CreatedBy, nvarchar(50),>
           GETDATE(),--,<CreatedOn, datetime,>
           @CreatedBy,--,<UpdatedBy, nvarchar(50),>
           GETDATE(),--,<UpdatedOn, datetime,>
           NULL,--,<ShowTaxInPackagePrice, tinyint,>
           NULL--,<UseAltPackageTaxCalc, tinyint,>
         )




---------------Record View tab done
CREATE TABLE #RoomType (ID INT identity(1,1), RatePlanCode nvarchar(10))
DECLARE @tmpRatePlanCode nvarchar(10), @Pos int
DECLARE @tmpRatePlanList NVARCHAR(100)
SET @tmpRatePlanList = LTRIM(RTRIM(@RatePlanList))+ ','
SET @Pos = CHARINDEX(',', @tmpRatePlanList, 1)

IF REPLACE(@tmpRatePlanList, ',', '') <> ''
BEGIN
    WHILE @Pos > 0
    BEGIN
        SET @tmpRatePlanCode = LTRIM(RTRIM(LEFT(@tmpRatePlanList, @Pos - 1)))
        IF @tmpRatePlanCode <> ''
        BEGIN
            INSERT INTO #RoomType (RatePlanCode) VALUES (@tmpRatePlanCode) 
        END
        SET @tmpRatePlanList = RIGHT(@tmpRatePlanList, LEN(@tmpRatePlanList) - @Pos)
        SET @Pos = CHARINDEX(',', @tmpRatePlanList, 1)
    END
END

INSERT INTO PropGroupBookingControl
           ([RowType]
           ,[StayDate]
           ,[PropGroupBookingID]
           ,[PropertyCode]
           ,[AdditionalKeyColumn]
           ,[CurrentAllocatedRoomCount]
           ,[OriginalAllocatedRoomCount]
           ,[ContractedRoomCount]
           ,[ReleasedRoomCount]
           ,[PickUpRoomCount]
           ,[OverBookingRoomCount]
           ,[IsRemovedFromAvail]
           ,[CreatedBy]
           ,[CreatedOn]
           ,[UpdatedBy]
           ,[UpdatedOn]
           ,[SourceLastUpdatedBy]
           ,[SourceLastUpdatedOn]
           ,[AllowBorrowFromOthers]
           ,[AllowOtherstoBorrow]
           ,[UpdateCount]
           ,[SubgroupReducedBlockCount]
           ,[ForecastedRoomCount]
           ,[ReleasedDate])
SELECT           
         N'ROOM', --<RowType, nvarchar(6),>
           DATEADD(DAY, nbr - 1, @CheckInDate), --,<StayDate, datetime,>
           @PropGroupBookingID, --,<PropGroupBookingID, int,>
           @PropertyCode, --,<PropertyCode, nvarchar(15),>
           RatePlanCode,--,<AdditionalKeyColumn, nvarchar(6),>
           0,--,<CurrentAllocatedRoomCount, int,>
           NULL,--,<OriginalAllocatedRoomCount, int,>
           0,--,<ContractedRoomCount, int,>
           NULL,--,<ReleasedRoomCount, int,>
           0,--,<PickUpRoomCount, int,>
           0,--,<OverBookingRoomCount, int,>
           1,--,<IsRemovedFromAvail, tinyint,>
           @CreatedBy,--,<CreatedBy, nvarchar(50),>
           GETDATE(),--,<CreatedOn, datetime,>
           @CreatedBy,--,<UpdatedBy, nvarchar(50),>
           GETDATE(),--,<UpdatedOn, datetime,>
           N'system',--,<SourceLastUpdatedBy, nvarchar(50),>
           GETDATE(),--,<SourceLastUpdatedOn, datetime,>
           1,--,<AllowBorrowFromOthers, tinyint,>
           1,--,<AllowOtherstoBorrow, tinyint,>
           NULL,--,<UpdateCount, numeric(38,0),>
           NULL,--,<SubgroupReducedBlockCount, int,>
           NULL,--,<ForecastedRoomCount, int,>
           NULL--,<ReleasedDate, datetime,>
FROM    ( SELECT    ROW_NUMBER() OVER ( ORDER BY c.object_id ) AS Nbr
        FROM      sys.columns c
        ) nbrs   
       CROSS JOIN #RoomType
WHERE   nbr - 1 <= DATEDIFF(DAY, @CheckInDate, @CheckOutDate)
-----------Room Types tab done



DECLARE @LengthOfStayCode NVARCHAR(10) = N'DY'
DECLARE @WeekDayPattern INT = 127
DECLARE @WeekDayPatternDescription nvarchar(50) = N'Mon,Tue,Wed,Thu,Fri,Sat,Sun'

CREATE TABLE #FlatRates 
(
PropertyCode NVARCHAR(10),
RatePlanCode NVARCHAR(20),
RatePlanTypeCode NVARCHAR(10),
RoomTypeCode NVARCHAR(10),
CurrencyCode NVARCHAR(10),
LengthOfStayCode NVARCHAR(10),
LengthOfStayCodeNumber INT,
WeekDayPattern INT,
StartDate DATETIME,
EndDate DATETIME,
SingleRate decimal(13,4),
DoubleRate decimal(13,4),
TripleRate decimal(13,4),
QuadRate decimal(13,4),
AdditionalAdultRate decimal(13,4),
Child1Rate decimal(13,4),
Child2Rate decimal(13,4),
Child3Rate decimal(13,4),
Child4Rate decimal(13,4),
Child5Rate decimal(13,4),
Child6Rate decimal(13,4),
RoundingScaleCode NVARCHAR(10),
RoundingAmount decimal(13,4),
LowRateLimit NVARCHAR(10),
HighRateLimit NVARCHAR(10)
);
 
INSERT INTO #FlatRates
EXEC prc_GetFlatRatesRange @PropertyCode,@CheckInDate,@CheckOutDate,N'RUB',N'RUB',@LengthOfStayCode,@RatePlanCode,N'',@RatePlanList,1 

INSERT INTO [dbo].[RateEffectivePeriod]
           ([PropertyRatePlanID]
           ,[StartDate]
           ,[EndDate]
           ,[LowRateLimit]
           ,[HighRateLimit]
           ,[ActiveFlag]
           ,[CreatedBy]
           ,[CreatedOn]
           ,[UpdatedBy]
           ,[UpdatedOn]
           ,[UpdateCount]
           ,[RatePlanCode]
           ,[IsPercentAdjusted]
           ,[PercentAmount]
           ,[RoundingScaleCode]
           ,[RoundingAmount]
           ,[Description])
     VALUES
           (
         @PropertyRatePlanID,--<PropertyRatePlanID, int,>
           @CheckInDate,--,<StartDate, datetime,>
           @CheckOutDate,--,<EndDate, datetime,>
           NULL,--,<LowRateLimit, numeric(19,4),>
           NULL,--,<HighRateLimit, numeric(19,4),>
           1,--,<ActiveFlag, tinyint,>
           @CreatedBy,--,<CreatedBy, nvarchar(50),>
           GETDATE(),--,<CreatedOn, datetime,>
           @CreatedBy,--,<UpdatedBy, nvarchar(50),>
           GETDATE(),--,<UpdatedOn, datetime,>
           NULL,--,<UpdateCount, numeric(38,0),>
           @RatePlanCode,--,<RatePlanCode, nvarchar(6),>
           NULL,--,<IsPercentAdjusted, tinyint,>
           NULL,--,<PercentAmount, decimal(19,4),>
           NULL,--,<RoundingScaleCode, nvarchar(6),>
           NULL,--,<RoundingAmount, decimal(19,4),>
           NULL--,<Description, nvarchar(1000),>
         )

DECLARE @RateEffectivePeriodID INT = SCOPE_IDENTITY()

INSERT INTO [dbo].[RateStructure]
           ([RateEffectivePeriodID]
           ,[RoomTypeID]
           ,[LengthOfStayCode]
           ,[WeekDayPattern]
           ,[WeekDayPatternDescription]
           ,[SingleRate]
           ,[DoubleRate]
           ,[TripleRate]
           ,[QuadRate]
           ,[AdditionalAdultRate]
           ,[AdditionalChildRate]
           ,[MinRating]
           ,[MaxRating]
           ,[CreatedBy]
           ,[CreatedOn]
           ,[UpdatedBy]
           ,[UpdatedOn]
           ,[UpdateCount]
           ,[Child1Rate]
           ,[Child2Rate]
           ,[Child3Rate]
           ,[Child4Rate]
           ,[Child5Rate]
           ,[Child6Rate])
SELECT
         @RateEffectivePeriodID,-- <RateEffectivePeriodID, int,>
         RoomTypeID, --<RoomTypeID, int,>
           @LengthOfStayCode,-- ,<LengthOfStayCode, nvarchar(6),>
           @WeekDayPattern,-- ,<WeekDayPattern, int,>
           @WeekDayPatternDescription,-- ,<WeekDayPatternDescription, nvarchar(50),>
           SingleRate,-- ,<SingleRate, numeric(19,4),>
           DoubleRate,-- ,<DoubleRate, numeric(19,4),>
           TripleRate,-- ,<TripleRate, numeric(19,4),>
           QuadRate,-- ,<QuadRate, numeric(19,4),>
           AdditionalAdultRate,-- ,<AdditionalAdultRate, numeric(19,4),>
           NULL,-- ,<AdditionalChildRate, numeric(19,4),>
           1,-- ,<MinRating, int,>
           8,-- ,<MaxRating, int,>
           @CreatedBy,-- ,<CreatedBy, nvarchar(50),>
           GETDATE(),-- ,<CreatedOn, datetime,>
           @CreatedBy,-- ,<UpdatedBy, nvarchar(50),>
           GETDATE(),-- ,<UpdatedOn, datetime,>
           NULL,-- ,<UpdateCount, numeric(38,0),>
           Child1Rate,-- ,<Child1Rate, numeric(19,4),>
           Child2Rate,-- ,<Child2Rate, numeric(19,4),>
           Child3Rate,-- ,<Child3Rate, numeric(19,4),>
           Child4Rate,-- ,<Child4Rate, numeric(19,4),>
           Child5Rate,-- ,<Child5Rate, numeric(19,4),>
           Child6Rate-- ,<Child6Rate, numeric(19,4),>
 FROM #FlatRates fr
 INNER JOIN dbo.RoomType rt ON rt.RoomTypeCode = fr.RoomTypeCode

----------Rate tab done



DROP TABLE #RoomType
DROP TABLE #FlatRates