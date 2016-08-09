USE VEGAUAT;
------------try to create new reservation

DECLARE @TrackingNumber NVARCHAR(64);
DECLARE @ProfileID INT;
DECLARE @StatusCode NVARCHAR(15);
DECLARE @SourceCode NVARCHAR(6);
DECLARE @MarketSegmentCode NVARCHAR(6);  
DECLARE @GuaranteeCode NVARCHAR(6);
DECLARE @AdultCount INT;
DECLARE @CheckInDate DATETIME;
DECLARE @CheckOutDate DATETIME;
DECLARE @Nights INT;
DECLARE @GuestCount INT;
DECLARE @TotalRoomRevenue DECIMAL;
DECLARE @PropertyRatePlanID INT;
DECLARE @RatePlanCode NVARCHAR(6);
DECLARE @RoomTypeID INT;
DECLARE @RoomTypeCode NVARCHAR(6);
DECLARE @NameInfoID INT;
DECLARE @PropertyCode NVARCHAR(4);
DECLARE @CreatedBy NVARCHAR(10);
DECLARE @CancellationPolicyID INT; 

SET @ProfileID = ( SELECT   MAX(ProfileID)
                   FROM     dbo.NameInfo
                 );
  ----------guest profileID dbo.Profile
SET @GuestCount = 1;
SET @CheckInDate = '20160705';
SET @CheckOutDate = '20160706';

SET @TotalRoomRevenue = 500;
SET @RatePlanCode = N'HIGH1';
SET @RoomTypeCode = N'SRTS';
SET @CancellationPolicyID = 8;
 -- TODO not sure what 8 means need to figure it out


SET @PropertyCode = N'VEGA';
SET @PropertyRatePlanID = ( SELECT  PropertyRatePlanID
                            FROM    dbo.PropertyRatePlan
                            WHERE   RatePlanCode = @RatePlanCode
                          );
SET @RoomTypeID = ( SELECT  RoomTypeID
                    FROM    dbo.RoomType
                    WHERE   RoomTypeCode = @RoomTypeCode
                  );
--depends on room type!
SET @MarketSegmentCode = ( SELECT   CategoryCodeValue
                           FROM     dbo.RatePlan
                           WHERE    RatePlanCode = @RatePlanCode
                         );

SET @Nights = DATEDIFF(dd, @CheckInDate, @CheckOutDate);
SET @CreatedBy = N'R5';
----randomly generate 8 figures number
SET @TrackingNumber = ( SELECT  CONVERT(NUMERIC(8, 0), RAND() * 89999999) + 10000000
                      );
-- if alredy exists in the table generate a new one
WHILE @TrackingNumber IN ( SELECT   TrackingNumber
                           FROM     dbo.TrackingNumber )
    BEGIN
        SET @TrackingNumber = ( SELECT  CONVERT(NUMERIC(8, 0), RAND() * 89999999) + 10000000
                              );
    END;

  

SET @NameInfoID = ( SELECT  NameInfoID
                    FROM    dbo.NameInfo
                    WHERE   ProfileID = @ProfileID
                  );
SET @StatusCode = N'CONFIRMED';
SET @SourceCode = N'CALL';
SET @GuaranteeCode = N'6PM';
SET @AdultCount = 1;
 -- should be in accordance with the room, but 1 is always acceptable

DECLARE @FullName NVARCHAR(102);
DECLARE @FirstName NVARCHAR(102);
DECLARE @LastName NVARCHAR(102);
SET @FullName = ( SELECT    LastName + ', ' + FirstName
                  FROM      dbo.NameInfo
                  WHERE     ProfileID = @ProfileID
                );
SET @FirstName = ( SELECT   FirstName
                   FROM     dbo.NameInfo
                   WHERE    ProfileID = @ProfileID
                 );
SET @LastName = ( SELECT    LastName
                  FROM      dbo.NameInfo
                  WHERE     ProfileID = @ProfileID
                );

INSERT  INTO dbo.TrackingNumber
        ( TrackingNumber ,
          TypeCode ,
          UpdatedBy ,
          UpdatedOn ,
          CreatedBy ,
          CreatedOn
        )
VALUES  ( @TrackingNumber , -- TrackingNumber - nvarchar(64)
          N'RESERV' , -- TypeCode - nvarchar(6)
          N'system' , -- UpdatedBy - nvarchar(50) --can be manual
          GETDATE() , -- UpdatedOn - datetime
          N'system' , -- CreatedBy - nvarchar(50) --can be manual
          GETDATE()  -- CreatedOn - datetime
        );


SELECT ReservationID, GuestProfileID, StatusCode, ConfirmationNumber, UpdatedOn
FROM dbo.Reservation
ORDER BY UpdatedOn DESC

SELECT *
FROM dbo.Profile

-- make reservation - CONFIRMED
-- assign room - CONFIRMED
-- check in = INHOUSE
-- check out = CHKOUT

INSERT  INTO dbo.Reservation
        ( ChannelCode ,
          SubChannelCode ,
          GuestProfileID ,
          OrganizationID ,
          PrimaryProfileType ,
          PropertyCode ,
          StatusCode ,
          SourceCode ,
          MarketSegmentCode ,
          RateAccessCode ,
          Notes ,
          ReservationDate ,
          ConfirmationNumber ,
          ConfirmationDate ,
          ConfirmationFAX ,
          ConfirmationEmail ,
          CancellationNumber ,
          CancellationDate ,
          CancellationReason ,
          ThirdPartyConfirmationNumber ,
          ThirdPartyCancellationNumber ,
          IsTaxExempt ,
          TAProfileID ,
          TAProfileID2 ,
          RewardsID ,
          ReservationShareWithID ,
          PmsShareReferenceNumber ,
          SharePercentage ,
          ReservationTypeCode ,
          IsRateSuppressed ,
          IsPrimaryShareWith ,
          Caller ,
          CreditCardID ,
          GuaranteeCode ,
          GDSRecordLocator ,
          CurrencyBasis ,
          CompanyReference ,
          ThirdPartyShareReferenceNumber ,
          DirectBillAccount ,
          ReasonForStayCode ,
          IsYieldOverridden ,
          TotalYieldableAmount ,
          OpportunityCost ,
          CommissionType ,
          CommissionAmount ,
          ReferenceNumber ,
          ThirdPartyProcessStatus ,
          ThirdPartyProcessTime ,
          WaitlistPriority ,
          CreatedBy ,
          CreatedOn ,
          UpdatedBy ,
          UpdatedOn ,
          SourceLastUpdatedBy ,
          SourceLastUpdatedOn ,
          LinkedOrganizationID ,
          LinkedGuestID ,
          UpdateCount ,
          BookingAgencyContractID ,
          EqualSplit ,
          TAProfileID3 ,
          IsTA2CommissionPercent ,
          TA2CommissionAmount ,
          IsTA3CommissionPercent ,
          TA3CommissionAmount ,
          ShareRate ,
          TravelAuthorization ,
          OriginatingSystemID ,
          SecondarySourceCode
        )
VALUES  ( N'HMS' , -- ChannelCode - nvarchar(6)
          NULL , -- SubChannelCode - nvarchar(50)
          @ProfileID , -- GuestProfileID - int
          NULL , -- OrganizationID - int
          N'GUEST' , -- PrimaryProfileType - nvarchar(6)
          @PropertyCode , -- PropertyCode - nvarchar(15)
          @StatusCode , -- StatusCode - nvarchar(15)
          @SourceCode , -- SourceCode - nvarchar(6)
          @MarketSegmentCode , -- MarketSegmentCode - nvarchar(6)
          NULL , -- RateAccessCode - nvarchar(6)
          N'' , -- Notes - nvarchar(2000)
          GETDATE() , -- ReservationDate - datetime  ---!!! should be a parameter
          @TrackingNumber , -- ConfirmationNumber - nvarchar(64)
          GETDATE() , -- ConfirmationDate - datetime  ---!!! should be a parameter
          NULL , -- ConfirmationFAX - nvarchar(50)
          NULL , -- ConfirmationEmail - nvarchar(50)
          NULL , -- CancellationNumber - nvarchar(64)
          NULL , -- CancellationDate - datetime
          NULL , -- CancellationReason - nvarchar(50)
          NULL , -- ThirdPartyConfirmationNumber - nvarchar(50)
          NULL , -- ThirdPartyCancellationNumber - nvarchar(50)
          0 , -- IsTaxExempt - tinyint
          NULL , -- TAProfileID - int
          NULL , -- TAProfileID2 - int
          NULL , -- RewardsID - int
          NULL , -- ReservationShareWithID - int
          NULL , -- PmsShareReferenceNumber - char(10)
          NULL , -- SharePercentage - decimal
          N'BSC' , -- ReservationTypeCode - nvarchar(6)
          0 , -- IsRateSuppressed - tinyint
          NULL , -- IsPrimaryShareWith - tinyint
          NULL , -- Caller - nvarchar(50)
          NULL , -- CreditCardID - int
          @GuaranteeCode , -- GuaranteeCode - nvarchar(6)
          NULL , -- GDSRecordLocator - nvarchar(50)
          N'RPERB' , -- CurrencyBasis - nvarchar(6)
          NULL , -- CompanyReference - nvarchar(70)
          NULL , -- ThirdPartyShareReferenceNumber - nvarchar(50)
          NULL , -- DirectBillAccount - nvarchar(30)
          NULL , -- ReasonForStayCode - nvarchar(6)
          NULL , -- IsYieldOverridden - tinyint
          NULL , -- TotalYieldableAmount - numeric
          NULL , -- OpportunityCost - numeric
          NULL , -- CommissionType - varchar(15)
          NULL , -- CommissionAmount - decimal
          NULL , -- ReferenceNumber - nvarchar(50)
          NULL , -- ThirdPartyProcessStatus - nvarchar(15)
          NULL , -- ThirdPartyProcessTime - datetime
          NULL , -- WaitlistPriority - int
          @CreatedBy , -- CreatedBy - nvarchar(50)
          GETDATE() , -- CreatedOn - datetime
          @CreatedBy , -- UpdatedBy - nvarchar(50)
          GETDATE() , -- UpdatedOn - datetime
          N'HMS' , -- SourceLastUpdatedBy - nvarchar(50)
          GETDATE() , -- SourceLastUpdatedOn - datetime
          NULL , -- LinkedOrganizationID - int
          NULL , -- LinkedGuestID - int
          NULL , -- UpdateCount - numeric
          NULL , -- BookingAgencyContractID - int
          NULL , -- EqualSplit - tinyint
          NULL , -- TAProfileID3 - int
          NULL , -- IsTA2CommissionPercent - tinyint
          NULL , -- TA2CommissionAmount - numeric
          NULL , -- IsTA3CommissionPercent - tinyint
          NULL , -- TA3CommissionAmount - numeric
          NULL , -- ShareRate - tinyint
          NULL , -- TravelAuthorization - nvarchar(50)
          N'HMS' , -- OriginatingSystemID - nvarchar(50)
          NULL  -- SecondarySourceCode - nvarchar(6)
        );


DECLARE @ReservationID INT;
SET @ReservationID = SCOPE_IDENTITY();

INSERT  INTO dbo.ReservationStay
        ( ReservationID ,
          ProfileID ,
          PropGroupBookingID ,
          OrganizationID ,
          TAProfileID ,
          TAProfileID2 ,
          AdultCount ,
          ChildCount ,
          ArrivalDate ,
          DepartureDate ,
          StatusCode ,
          CurrentSet ,
          ReservationTypeCode ,
          PMSConfirmationNumber ,
          PMSConfirmationDate ,
          PMSCancellationNumber ,
          PMSCancellationDate ,
          SourceLastUpdatedBy ,
          SourceLastUpdatedOn ,
          CurrencyCode ,
          QuotedCurrencyCode ,
          TurndownTimeCode ,
          RoomCleaningTimeCode ,
          TrackCode ,
          DoNotMove ,
          IsRegistrationCardPrinted ,
          IsGuestStay ,
          SettlementTypeCode ,
          SettledByCreditCardID ,
          CreditCardID ,
          EmailAddressID ,
          PostalAddressID ,
          PhoneNumberID ,
          RewardsID ,
          IsTaxExempt ,
          SourceCode ,
          MarketSegmentCode ,
          Notes ,
          CancellationReason ,
          IsRateSuppressed ,
          Caller ,
          GuaranteeCode ,
          CompanyReference ,
          DirectBillAccount ,
          ReasonForStayCode ,
          CommissionType ,
          CommissionAmount ,
          TaxExempt ,
          ReferenceNumber ,
          PackageTransactionCode ,
          PackageOffsetCode ,
          PostPackageTotal ,
          UpdatedBy ,
          UpdatedOn ,
          CreatedBy ,
          CreatedOn ,
          UpdateCount ,
          BookingAgencyContractID ,
          PackageChargeThroughDate ,
          LinkedGuestID ,
          IsCommissionProcessed ,
          TAProfileID3 ,
          IsTA2CommissionPercent ,
          TA2CommissionAmount ,
          IsTA3CommissionPercent ,
          TA3CommissionAmount ,
          TaxID ,
          PMSStatusCode ,
          IsItemsConsumed ,
          ResortFeeCode ,
          GroupAutoTransferRuleType ,
          ConfidentialRateCb ,
          ExpediaHotelCollect ,
          CommissionSecondAmount ,
          TA2CommissionSecondAmount ,
          TA3CommissionSecondAmount ,
          RoomPIN ,
          DoNotMoveReason ,
          GroupRateScheduleCode ,
          ExchangeRateLockType ,
          ExchangeRate ,
          LeaseID ,
          IsNewProfile ,
          HQID ,
          BranchID ,
          BranchName
        )
VALUES  ( @ReservationID , -- ReservationID - int
          @ProfileID , -- ProfileID - int
          NULL , -- PropGroupBookingID - int
          NULL , -- OrganizationID - int
          NULL , -- TAProfileID - int
          NULL , -- TAProfileID2 - int
          @AdultCount , -- AdultCount - int
          0 , -- ChildCount - int
          @CheckInDate , -- ArrivalDate - datetime
          @CheckOutDate , -- DepartureDate - datetime
          @StatusCode , -- StatusCode - nvarchar(50)
          1 , -- CurrentSet - tinyint
          N'BSC' , -- ReservationTypeCode - nvarchar(6)
          @TrackingNumber + '-1' , -- PMSConfirmationNumber - nvarchar(50)
          GETDATE() , -- PMSConfirmationDate - datetime
          NULL , -- PMSCancellationNumber - nvarchar(50)
          NULL , -- PMSCancellationDate - datetime
          N'HMS' , -- SourceLastUpdatedBy - nvarchar(50)
          GETDATE() , -- SourceLastUpdatedOn - datetime
          N'RUB' , -- CurrencyCode - nvarchar(3)
          NULL , -- QuotedCurrencyCode - nvarchar(3)
          NULL , -- TurndownTimeCode - nvarchar(6)
          NULL , -- RoomCleaningTimeCode - nvarchar(6)
          NULL , -- TrackCode - nvarchar(6)
          0 , -- DoNotMove - tinyint
          NULL , -- IsRegistrationCardPrinted - tinyint
          1 , -- IsGuestStay - tinyint
          N'100' , -- SettlementTypeCode - nvarchar(6)
          NULL , -- SettledByCreditCardID - int
          NULL , -- CreditCardID - int
          NULL , -- EmailAddressID - int
          NULL , -- PostalAddressID - int
          NULL , -- PhoneNumberID - int
          NULL , -- RewardsID - int
          0 , -- IsTaxExempt - tinyint
          @SourceCode , -- SourceCode - nvarchar(6)
          @MarketSegmentCode , -- MarketSegmentCode - nvarchar(6)
          NULL , -- Notes - nvarchar(2000)
          NULL , -- CancellationReason - nvarchar(50)
          0 , -- IsRateSuppressed - tinyint
          NULL , -- Caller - nvarchar(50)
          @GuaranteeCode , -- GuaranteeCode - nvarchar(6)
          NULL , -- CompanyReference - nvarchar(70)
          NULL , -- DirectBillAccount - nvarchar(30)
          NULL , -- ReasonForStayCode - nvarchar(6)
          NULL , -- CommissionType - varchar(15)
          NULL , -- CommissionAmount - decimal
          NULL , -- TaxExempt - nvarchar(6)
          NULL , -- ReferenceNumber - nvarchar(50)
          NULL , -- PackageTransactionCode - nvarchar(6)
          NULL , -- PackageOffsetCode - nvarchar(6)
          NULL , -- PostPackageTotal - tinyint
          @CreatedBy , -- UpdatedBy - nvarchar(50)
          GETDATE() , -- UpdatedOn - datetime
          @CreatedBy , -- CreatedBy - nvarchar(50)
          GETDATE() , -- CreatedOn - datetime
          NULL , -- UpdateCount - numeric 
          NULL , -- BookingAgencyContractID - int
          NULL , -- PackageChargeThroughDate - datetime
          NULL , -- LinkedGuestID - int
          NULL , -- IsCommissionProcessed - tinyint
          NULL , -- TAProfileID3 - int
          NULL , -- IsTA2CommissionPercent - tinyint
          NULL , -- TA2CommissionAmount - numeric
          NULL , -- IsTA3CommissionPercent - tinyint
          NULL , -- TA3CommissionAmount - numeric
          N'' , -- TaxID - nvarchar(50)
          N'CNFRMD' , -- PMSStatusCode - nvarchar(6)
          NULL , -- IsItemsConsumed - tinyint
          NULL , -- ResortFeeCode - nvarchar(6)
          NULL , -- GroupAutoTransferRuleType - nvarchar(6)
          0 , -- ConfidentialRateCb - tinyint
          0 , -- ExpediaHotelCollect - tinyint
          NULL , -- CommissionSecondAmount - decimal
          NULL , -- TA2CommissionSecondAmount - numeric
          NULL , -- TA3CommissionSecondAmount - numeric
          N'' , -- RoomPIN - nvarchar(30)
          NULL , -- DoNotMoveReason - nvarchar(6)
          NULL , -- GroupRateScheduleCode - nvarchar(6)
          NULL , -- ExchangeRateLockType - nvarchar(6)
          NULL , -- ExchangeRate - decimal
          NULL , -- LeaseID - nvarchar(30)
          0 , -- IsNewProfile - tinyint
          N'' , -- HQID - nvarchar(50)
          N'' , -- BranchID - nvarchar(50)
          N''  -- BranchName - nvarchar(50)
        );

DECLARE @ReservationStayID INT;
SET @ReservationStayID = SCOPE_IDENTITY();

INSERT  INTO dbo.ReservationStayDate
        ( ReservationStayID ,
          StayDate ,
          PropertyRatePlanID ,
          RatePlanCode ,
          RoomTypeID ,
          RoomTypeCode ,
          RoomID ,
          PackagePlanCode ,
          PromotionCode ,
          ReservationTypeCode ,
          LOSScheduleCode ,
          RateAmount ,
          RoomAmount ,
          TaxAmount ,
          AdultCount ,
          ChildCount ,
          OriginalRateAmount ,
          RateOverrideReasonCode ,
          SourceLastUpdatedBy ,
          SourceLastUpdatedOn ,
          UpdatedBy ,
          UpdatedOn ,
          CreatedBy ,
          CreatedOn ,
          UpdateCount ,
          ResortFee ,
          UnroundedTaxAmount ,
          UnroundedResortFee ,
          ADRDelta ,
          PrePromotionRateAmount ,
          RateTaxAmount
        )
VALUES  ( @ReservationID , -- ReservationStayID - int
          @CheckInDate , -- StayDate - datetime
          @PropertyRatePlanID , -- PropertyRatePlanID - int
          @RatePlanCode , -- RatePlanCode - nvarchar(6)
          @RoomTypeID , -- RoomTypeID - int
          @RoomTypeCode , -- RoomTypeCode - nvarchar(6)
          NULL , -- RoomID - int
          NULL , -- PackagePlanCode - nvarchar(6)
          NULL , -- PromotionCode - nvarchar(10)
          N'BSC' , -- ReservationTypeCode - nvarchar(6)
          N'DY' , -- LOSScheduleCode - nvarchar(6)
          @TotalRoomRevenue , -- RateAmount - decimal
          NULL , -- RoomAmount - decimal
          0 , -- TaxAmount - decimal
          @GuestCount , -- AdultCount - int
          0 , -- ChildCount - int
          NULL , -- OriginalRateAmount - decimal
          NULL , -- RateOverrideReasonCode - nvarchar(6)
          N'HMS' , -- SourceLastUpdatedBy - nvarchar(50)
          GETDATE() , -- SourceLastUpdatedOn - datetime
          @CreatedBy , -- UpdatedBy - nvarchar(50)
          GETDATE() , -- UpdatedOn - datetime
          @CreatedBy , -- CreatedBy - nvarchar(50)
          GETDATE() , -- CreatedOn - datetime
          NULL , -- UpdateCount - numeric
          0 , -- ResortFee - decimal
          0 , -- UnroundedTaxAmount - decimal
          0 , -- UnroundedResortFee - decimal
          NULL , -- ADRDelta - decimal
          NULL , -- PrePromotionRateAmount - decimal
          0  -- RateTaxAmount - decimal
        );

INSERT  INTO dbo.ReservationActivity
        ( ReservationID ,
          EffectiveDateTime ,
          ActivityType ,
          SourceName ,
          Agent ,
          RevenueChange ,
          AverageRateChange ,
          LOSChange ,
          CurrencyCode ,
          CreatedOn ,
          CreatedBy ,
          UpdatedOn ,
          UpdatedBy ,
          ReservationStayID
        )
VALUES  ( @ReservationID , -- ReservationID - int
          GETDATE() , -- EffectiveDateTime - datetime
          N'New' , -- ActivityType - nvarchar(50)
          N'HMS' , -- SourceName - nvarchar(50)
          N'R5' , -- Agent - nvarchar(50)
          0 , -- RevenueChange - decimal
          0 , -- AverageRateChange - decimal
          0 , -- LOSChange - int
          N'RUB' , -- CurrencyCode - nvarchar(3)
          GETDATE() , -- CreatedOn - datetime
          @CreatedBy , -- CreatedBy - nvarchar(50)
          GETDATE() , -- UpdatedOn - datetime
          @CreatedBy , -- UpdatedBy - nvarchar(50)
          @ReservationID  -- ReservationStayID - int
        );

INSERT  INTO dbo.GuestNameInfo
        ( ReservationStayID ,
          NameInfoID ,
          NamePrefix ,
          MiddleInitial ,
          NameSuffix ,
          NameTitle ,
          FirstName ,
          LastName ,
          AliasFirstName ,
          AliasMiddleName ,
          AliasLastName ,
          PrimaryGuest ,
          ArrivalType ,
          ArrivalInformation ,
          ArrivalHotel ,
          ArrivalDate ,
          ArrivalTime ,
          DepartureType ,
          DepartureInformation ,
          DepartureHotel ,
          DepartureDate ,
          DepartureTime ,
          NextDestination ,
          ArrivalNotes ,
          DepartureNotes ,
          IdCheck ,
          IdType ,
          IdNumber ,
          IdIssuedDate ,
          IdExpirationDate ,
          PassportNumber ,
          PassportName ,
          PassportVisaCheck ,
          IssuingCountry ,
          DateOfBirth ,
          Gender ,
          BirthCountry ,
          BirthCity ,
          Occupation ,
          Religion ,
          Mother ,
          Father ,
          PassportIssuedDate ,
          PassportExpirationDate ,
          VisaNotes ,
          VisaNumber ,
          VisaType ,
          VisaStatus ,
          VisaIssuedDate ,
          VisaBeginDate ,
          VisaExpirationDate ,
          Service ,
          Rank ,
          Grade ,
          GuestIdentity ,
          UpdateCount ,
          CreatedBy ,
          CreatedOn ,
          UpdatedBy ,
          UpdatedOn ,
          IdName ,
          IdDateOfBirth ,
          IdGender ,
          Nationality ,
          Address ,
          HotelArrivalTime ,
          HotelDepartureTime ,
          ArrivalTimeNew ,
          DepartureTimeNew ,
          ScannedPassport ,
          PassportType ,
          PassportNationality ,
          PersonalNumber ,
          PassportScannedName ,
          PassportScannedDate ,
          ScannedFirstName ,
          ScannedLastName
        )
VALUES  ( @ReservationStayID , -- ReservationStayID - int
          @NameInfoID , -- NameInfoID - int
          NULL , -- NamePrefix - nvarchar(50)
          NULL , -- MiddleInitial - nvarchar(50)
          NULL , -- NameSuffix - nvarchar(50)
          NULL , -- NameTitle - nvarchar(50)
          @FirstName , -- FirstName - nvarchar(50)
          @LastName , -- LastName - nvarchar(50)
          NULL , -- AliasFirstName - nvarchar(50)
          NULL , -- AliasMiddleName - nvarchar(50)
          NULL , -- AliasLastName - nvarchar(50)
          N'+' , -- PrimaryGuest - nvarchar(1)
          NULL , -- ArrivalType - nvarchar(6)
          NULL , -- ArrivalInformation - nvarchar(1000)
          NULL , -- ArrivalHotel - nvarchar(15)
          @CheckInDate , -- ArrivalDate - datetime
          NULL , -- ArrivalTime - nvarchar(50)
          NULL , -- DepartureType - nvarchar(6)
          NULL , -- DepartureInformation - nvarchar(1000)
          NULL , -- DepartureHotel - nvarchar(15)
          @CheckOutDate , -- DepartureDate - datetime
          NULL , -- DepartureTime - nvarchar(50)
          NULL , -- NextDestination - nvarchar(50)
          NULL , -- ArrivalNotes - nvarchar(1000)
          NULL , -- DepartureNotes - nvarchar(1000)
          NULL , -- IdCheck - nvarchar(1)
          NULL , -- IdType - nvarchar(30)
          NULL , -- IdNumber - nvarchar(50)
          NULL , -- IdIssuedDate - datetime
          NULL , -- IdExpirationDate - datetime
          NULL , -- PassportNumber - nvarchar(50)
          NULL , -- PassportName - nvarchar(50)
          NULL , -- PassportVisaCheck - nvarchar(1)
          NULL , -- IssuingCountry - nvarchar(6)
          NULL , -- DateOfBirth - datetime
          NULL , -- Gender - nvarchar(6)
          NULL , -- BirthCountry - nvarchar(6)
          NULL , -- BirthCity - nvarchar(50)
          NULL , -- Occupation - nvarchar(50)
          NULL , -- Religion - nvarchar(50)
          NULL , -- Mother - nvarchar(50)
          NULL , -- Father - nvarchar(50)
          NULL , -- PassportIssuedDate - datetime
          NULL , -- PassportExpirationDate - datetime
          NULL , -- VisaNotes - nvarchar(1000)
          NULL , -- VisaNumber - nvarchar(50)
          NULL , -- VisaType - nvarchar(10)
          NULL , -- VisaStatus - nvarchar(10)
          NULL , -- VisaIssuedDate - datetime
          NULL , -- VisaBeginDate - datetime
          NULL , -- VisaExpirationDate - datetime
          NULL , -- Service - nvarchar(6)
          NULL , -- Rank - nvarchar(6)
          NULL , -- Grade - nvarchar(6)
          NULL , -- GuestIdentity - nvarchar(30)
          NULL , -- UpdateCount - numeric
          N'R5' , -- CreatedBy - nvarchar(50)
          GETDATE() , -- CreatedOn - datetime
          N'R5' , -- UpdatedBy - nvarchar(50)
          GETDATE() , -- UpdatedOn - datetime
          NULL , -- IdName - nvarchar(50)
          NULL , -- IdDateOfBirth - datetime
          NULL , -- IdGender - nvarchar(6)
          NULL , -- Nationality - nvarchar(6)
          NULL , -- Address - nvarchar(400)
          NULL , -- HotelArrivalTime - datetime
          NULL , -- HotelDepartureTime - datetime
          NULL , -- ArrivalTimeNew - datetime
          NULL , -- DepartureTimeNew - datetime
          NULL , -- ScannedPassport - numeric
          NULL , -- PassportType - nvarchar(50)
          NULL , -- PassportNationality - nvarchar(3)
          NULL , -- PersonalNumber - varchar(30)
          NULL , -- PassportScannedName - nvarchar(100)
          NULL , -- PassportScannedDate - datetime
          NULL , -- ScannedFirstName - nvarchar(50)
          NULL  -- ScannedLastName - nvarchar(50)
        );

INSERT  INTO dbo.P5RESERVATIONSTAY
        ( RSY_RESERVATIONSTAYID ,
          RSY_GEOCODE ,
          RSY_VEHICLE ,
          RSY_UDFCHAR01 ,
          RSY_UDFCHAR02 ,
          RSY_UDFCHAR03 ,
          RSY_UDFCHAR04 ,
          RSY_UDFCHAR05 ,
          RSY_UDFCHAR06 ,
          RSY_UDFCHAR07 ,
          RSY_UDFCHAR08 ,
          RSY_UDFCHAR09 ,
          RSY_UDFCHAR10 ,
          RSY_UDFCHAR11 ,
          RSY_UDFCHAR12 ,
          RSY_UDFCHAR13 ,
          RSY_UDFCHAR14 ,
          RSY_UDFCHAR15 ,
          RSY_UDFNUM01 ,
          RSY_UDFNUM02 ,
          RSY_UDFNUM03 ,
          RSY_UDFNUM04 ,
          RSY_UDFNUM05 ,
          RSY_UDFNUM06 ,
          RSY_UDFNUM07 ,
          RSY_UDFNUM08 ,
          RSY_UDFNUM09 ,
          RSY_UDFNUM10 ,
          RSY_UDFDATE01 ,
          RSY_UDFDATE02 ,
          RSY_UDFDATE03 ,
          RSY_UDFDATE04 ,
          RSY_UDFDATE05 ,
          RSY_UDFCHKBOX01 ,
          RSY_UDFCHKBOX02 ,
          RSY_UDFCHKBOX03 ,
          RSY_UDFCHKBOX04 ,
          RSY_UDFCHKBOX05 ,
          RSY_CREATEDBY ,
          RSY_CREATED ,
          RSY_UPDATEDBY ,
          RSY_UPDATED ,
          RSY_UPDATECOUNT ,
          RSY_CURRENTROOMCODE ,
          RSY_ROOMHOLDID ,
          RSY_DAYSOFROTATION ,
          RSY_CLEANINGDAY1 ,
          RSY_CLEANINGDAY2 ,
          RSY_CLEANINGDAY3 ,
          RSY_CLEANINGDAY4 ,
          RSY_CLEANINGDAY5 ,
          RSY_CLEANINGDAY6 ,
          RSY_CLEANINGDAY7 ,
          RSY_LOYALTYPOINTBALANCE ,
          RSY_LOYALTYPOINTUPDATED ,
          RSY_CHKOUTWITHBALREASON ,
          RSY_ISWALKIN ,
          RSY_ROOMROTATIONSTAYTYPE ,
          RSY_ARPROFILEID
        )
VALUES  ( @ReservationStayID , -- RSY_RESERVATIONSTAYID - int
          NULL , -- RSY_GEOCODE - nvarchar(6)
          NULL , -- RSY_VEHICLE - nvarchar(50)
          NULL , -- RSY_UDFCHAR01 - nvarchar(80)
          NULL , -- RSY_UDFCHAR02 - nvarchar(80)
          NULL , -- RSY_UDFCHAR03 - nvarchar(80)
          NULL , -- RSY_UDFCHAR04 - nvarchar(80)
          NULL , -- RSY_UDFCHAR05 - nvarchar(80)
          NULL , -- RSY_UDFCHAR06 - nvarchar(80)
          NULL , -- RSY_UDFCHAR07 - nvarchar(80)
          NULL , -- RSY_UDFCHAR08 - nvarchar(80)
          NULL , -- RSY_UDFCHAR09 - nvarchar(80)
          NULL , -- RSY_UDFCHAR10 - nvarchar(80)
          NULL , -- RSY_UDFCHAR11 - nvarchar(80)
          NULL , -- RSY_UDFCHAR12 - nvarchar(80)
          NULL , -- RSY_UDFCHAR13 - nvarchar(80)
          NULL , -- RSY_UDFCHAR14 - nvarchar(80)
          NULL , -- RSY_UDFCHAR15 - nvarchar(80)
          NULL , -- RSY_UDFNUM01 - numeric
          NULL , -- RSY_UDFNUM02 - numeric
          NULL , -- RSY_UDFNUM03 - numeric
          NULL , -- RSY_UDFNUM04 - numeric
          NULL , -- RSY_UDFNUM05 - numeric
          NULL , -- RSY_UDFNUM06 - numeric
          NULL , -- RSY_UDFNUM07 - numeric
          NULL , -- RSY_UDFNUM08 - numeric
          NULL , -- RSY_UDFNUM09 - numeric
          NULL , -- RSY_UDFNUM10 - numeric
          NULL , -- RSY_UDFDATE01 - datetime
          NULL , -- RSY_UDFDATE02 - datetime
          NULL , -- RSY_UDFDATE03 - datetime
          NULL , -- RSY_UDFDATE04 - datetime
          NULL , -- RSY_UDFDATE05 - datetime
          N'-' , -- RSY_UDFCHKBOX01 - nvarchar(1)
          N'-' , -- RSY_UDFCHKBOX02 - nvarchar(1)
          N'-' , -- RSY_UDFCHKBOX03 - nvarchar(1)
          N'-' , -- RSY_UDFCHKBOX04 - nvarchar(1)
          N'-' , -- RSY_UDFCHKBOX05 - nvarchar(1)
          N'R5' , -- RSY_CREATEDBY - nvarchar(30)
          GETDATE() , -- RSY_CREATED - datetime
          N'R5' , -- RSY_UPDATEDBY - nvarchar(30)
          GETDATE() , -- RSY_UPDATED - datetime
          0 , -- RSY_UPDATECOUNT - numeric
          NULL , -- RSY_CURRENTROOMCODE - nvarchar(50)
          NULL , -- RSY_ROOMHOLDID - nvarchar(50)
          NULL , -- RSY_DAYSOFROTATION - numeric
          NULL , -- RSY_CLEANINGDAY1 - nvarchar(6)
          NULL , -- RSY_CLEANINGDAY2 - nvarchar(6)
          NULL , -- RSY_CLEANINGDAY3 - nvarchar(6)
          NULL , -- RSY_CLEANINGDAY4 - nvarchar(6)
          NULL , -- RSY_CLEANINGDAY5 - nvarchar(6)
          NULL , -- RSY_CLEANINGDAY6 - nvarchar(6)
          NULL , -- RSY_CLEANINGDAY7 - nvarchar(6)
          NULL , -- RSY_LOYALTYPOINTBALANCE - numeric
          NULL , -- RSY_LOYALTYPOINTUPDATED - datetime
          NULL , -- RSY_CHKOUTWITHBALREASON - nvarchar(6)
          N'-' , -- RSY_ISWALKIN - nvarchar(1)
          NULL , -- RSY_ROOMROTATIONSTAYTYPE - nvarchar(6)
          NULL  -- RSY_ARPROFILEID - int
        );

INSERT  INTO dbo.P5ROOMBLOCKLOCK
        ( RBL_RESSTAYID, RBL_UPDATEDON )
VALUES  ( @ReservationStayID, -- RBL_RESSTAYID - int
          GETDATE()  -- RBL_UPDATEDON - datetime
          );

DECLARE @nowDate DATETIME;
SET @nowDate = ( SELECT GETDATE()
               );

EXEC dbo.prc_UpdateGuestStaySummary @guestProfileID = @ProfileID, -- int
    @reservationStayId = @ReservationStayID, -- int
    @username = N'R5', -- nvarchar(50)
    @updatedOn = @nowDate;

EXEC dbo.prc_UpdateGuestStayStatistics @profileID = @ProfileID, -- int
    @customerID = N'1', -- nvarchar(50)
    @isActualRecord = 1, -- tinyint
    @propertyCode = @PropertyCode, -- nvarchar(15)
    @username = 'R5', -- varchar(30)
    @updatedOn = @nowDate;

EXEC dbo.prc_UpdateGuestStayStatistics @profileID = @ProfileID, -- int
    @customerID = N'1', -- nvarchar(50)
    @isActualRecord = 0, -- tinyint
    @propertyCode = @PropertyCode, -- nvarchar(15)
    @username = 'R5', -- varchar(30)
    @updatedOn = @nowDate;

EXEC dbo.prc_UpdateNonGroupPickups @property = @PropertyCode, -- nvarchar(50)
    @channel = N'HMS', -- nvarchar(50)
    @type = N'RATE', -- nvarchar(50)
    @key = @RatePlanCode, -- nvarchar(50)
    @addFlag = 1, -- int
    @startDate = @nowDate, -- datetime
    @endDate = @nowDate, -- datetime
    @roomCount = 1, -- int
    @updatedBy = N'R5';
 -- nvarchar(50)

EXEC dbo.prc_UpdateNonGroupPickups @property = @PropertyCode, -- nvarchar(50)
    @channel = N'HMS', -- nvarchar(50)
    @type = N'ROOM', -- nvarchar(50)
    @key = @RoomTypeCode, -- nvarchar(50)
    @addFlag = 1, -- int
    @startDate = @nowDate, -- datetime
    @endDate = @nowDate, -- datetime
    @roomCount = 1, -- int
    @updatedBy = N'R5';
 -- nvarchar(50)

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
          @TrackingNumber + '-1' , -- PmsAccountRef - nvarchar(20)
          N'GUEST' , -- AccountType - nvarchar(6)
          @ReservationID , -- ReservationStayId - int
          NULL , -- GroupBookingId - int
          NULL , -- SourceOfBusinessCode - nvarchar(6)
          NULL , -- MarketSegmentCode - nvarchar(6)
          @CreatedBy , -- CreatedBy - nvarchar(50)
          GETDATE() , -- CreatedOn - datetime
          @CreatedBy , -- UpdatedBy - nvarchar(50)
          GETDATE()  -- UpdatedOn - datetime
        );

DECLARE @AccountID INT;
SET @AccountID = SCOPE_IDENTITY();

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
VALUES  ( ( SELECT  MAX(CAST(ACC_ACCOUNT AS INT)) + 1
            FROM    dbo.P5ACCOUNT
          ) , -- ACC_ACCOUNT - nvarchar(30)  --- unique ID for this table
          @PropertyCode , -- ACC_PROPERTY - nvarchar(15)
          N'GUEST' , -- ACC_ACCOUNTTYPE - nvarchar(6)
          @FullName , -- ACC_ACCOUNTNAME - nvarchar(102)
          @ReservationStayID , -- ACC_ACCOUNTID - bigint  --Original reference id for account type. For example, ReservationStayId for Guest Account.
          NULL , -- ACC_ARACCOUNTID - numeric
          NULL , -- ACC_ARBILLINGREFERENCE - nvarchar(1000)
          N'PEND' , -- ACC_STATUS - nvarchar(6)
          @CheckInDate , -- ACC_STARTDATE - datetime
          @CheckOutDate , -- ACC_ENDDATE - datetime
          0 , -- ACC_BALANCE - numeric
          @AccountID , -- ACC_COREACCOUNTID - int  ---------comes from dbo.Account (Matching Account ID in Core table)
          @CreatedBy , -- ACC_UPDATEDBY - nvarchar(30)
          GETDATE() , -- ACC_UPDATED - datetime
          @CreatedBy , -- ACC_CREATEDBY - nvarchar(30)
          GETDATE() , -- ACC_CREATED - datetime
          NULL , -- ACC_UPDATECOUNT - numeric
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

-- updates ACC_INTERFACETOKEN
EXEC dbo.O7ASSIGNINTERFACETOKENFORACCOUNT @sPropertyCode = @PropertyCode,
    @sAccount = @AccountID;

--SELECT @TrackingNumber


INSERT  INTO dbo.P5RESERVATIONSTAYDATE
        ( RSD_RESERVATIONSTAYID ,
          RSD_STAYDATE ,
          RSD_RESERVATIONSHAREWITHID ,
          RSD_SHARERATEFLAG ,
          RSD_FOREIGNEXCHANGE ,
          RSD_PROPERTYRATEAMOUNT ,
          RSD_CREATEDBY ,
          RSD_CREATED ,
          RSD_UPDATEDBY ,
          RSD_UPDATED ,
          RSD_UPDATECOUNT ,
          RSD_ROOMTYPECHARGE ,
          RSD_ROOMTYPECHARGERATEREASON ,
          RSD_ROOMTYPECHARGEUPDATEDBY ,
          RSD_ROOMTYPECHARGEUPDATEDON
        )
VALUES  ( @ReservationStayID , -- RSD_RESERVATIONSTAYID - int
          @CheckInDate , -- RSD_STAYDATE - datetime
          NULL , -- RSD_RESERVATIONSHAREWITHID - int
          0 , -- RSD_SHARERATEFLAG - tinyint
          NULL , -- RSD_FOREIGNEXCHANGE - nvarchar(6)
          NULL , -- RSD_PROPERTYRATEAMOUNT - numeric
          @CreatedBy , -- RSD_CREATEDBY - nvarchar(30)
          GETDATE() , -- RSD_CREATED - datetime
          @CreatedBy , -- RSD_UPDATEDBY - nvarchar(30)
          GETDATE() , -- RSD_UPDATED - datetime
          0 , -- RSD_UPDATECOUNT - numeric
          NULL , -- RSD_ROOMTYPECHARGE - nvarchar(6)
          NULL , -- RSD_ROOMTYPECHARGERATEREASON - nvarchar(6)
          NULL , -- RSD_ROOMTYPECHARGEUPDATEDBY - nvarchar(50)
          NULL  -- RSD_ROOMTYPECHARGEUPDATEDON - datetime
        );




INSERT  INTO dbo.ReservationStayBookingPolicy
        ( ReservationStayID ,
          GtdBookingPolicyID ,
          DepositBookingPolicyID ,
          CancellationPolicyID ,
          CXLRefundPolicyID ,
          CreatedBy ,
          CreatedOn ,
          UpdatedBy ,
          UpdatedOn ,
          UpdateCount
        )
VALUES  ( @ReservationStayID , -- ReservationStayID - int
          NULL , -- GtdBookingPolicyID - int
          NULL , -- DepositBookingPolicyID - int
          @CancellationPolicyID , -- CancellationPolicyID - int  
          NULL , -- CXLRefundPolicyID - int
          @CreatedBy , -- CreatedBy - nvarchar(50)
          GETDATE() , -- CreatedOn - datetime
          @CreatedBy , -- UpdatedBy - nvarchar(50)
          GETDATE() , -- UpdatedOn - datetime
          NULL  -- UpdateCount - numeric
        );

INSERT  INTO dbo.ReservationBookingPolicy
        ( ReservationID ,
          GtdBookingPolicyID ,
          DepositBookingPolicyID ,
          CancellationPolicyID ,
          CXLRefundPolicyID ,
          CreatedBy ,
          CreatedOn ,
          UpdatedBy ,
          UpdatedOn
        )
VALUES  ( @ReservationID , -- ReservationID - int
          NULL , -- GtdBookingPolicyID - int
          NULL , -- DepositBookingPolicyID - int
          @CancellationPolicyID , -- CancellationPolicyID - int
          NULL , -- CXLRefundPolicyID - int
          @CreatedBy , -- CreatedBy - nvarchar(50)
          GETDATE() , -- CreatedOn - datetime
          @CreatedBy , -- UpdatedBy - nvarchar(50)
          GETDATE()  -- UpdatedOn - datetime
        );