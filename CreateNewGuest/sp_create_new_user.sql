USE [VEGAUAT]
GO

DECLARE @RC int
DECLARE @profileid int
DECLARE @PrimaryLanguageCode nvarchar(6)
DECLARE @EmailAddress nvarchar(50)
DECLARE @ProfileTypeCode nvarchar(6)
DECLARE @ProfileStatusCode nvarchar(8)
DECLARE @VIPStatusCode nvarchar(6)
DECLARE @AlternateEmailAddress nvarchar(50)
DECLARE @PMSReferenceNumber nvarchar(50)
DECLARE @HasWebAccess tinyint
DECLARE @BirthMonth int
DECLARE @BirthDay int
DECLARE @BirthYear int
DECLARE @GenderCode nvarchar(6)
DECLARE @Notes nvarchar(255)
DECLARE @SourceLastUpdatedBy nvarchar(50)
DECLARE @SourceLastUpdatedOn datetime
DECLARE @NamePrefix nvarchar(50)
DECLARE @MiddleInitial nvarchar(50)
DECLARE @NameSuffix nvarchar(50)
DECLARE @NameTitle nvarchar(50)
DECLARE @FirstName nvarchar(50)
DECLARE @LastName nvarchar(50)
DECLARE @AliasFirstName nvarchar(50)
DECLARE @AliasMiddleName nvarchar(50)
DECLARE @AliasLastName nvarchar(50)
DECLARE @PrimaryContact nchar(1)
DECLARE @DCountryAccessNumber nvarchar(50)
DECLARE @DAreaCityCode nvarchar(50)
DECLARE @DPhoneNumberTypeCode nvarchar(50)
DECLARE @DPhoneExtension nvarchar(50)
DECLARE @DPhoneNumber nvarchar(50)
DECLARE @ECountryAccessNumber nvarchar(50)
DECLARE @EAreaCityCode nvarchar(50)
DECLARE @EPhoneNumberTypeCode nvarchar(50)
DECLARE @EPhoneExtension nvarchar(50)
DECLARE @EPhoneNumber nvarchar(50)
DECLARE @PPostalCode nvarchar(10)
DECLARE @PAddressTypeCode nvarchar(6)
DECLARE @PStreetAddress nvarchar(400)
DECLARE @PStreetAddress2 nvarchar(400)
DECLARE @PCity nvarchar(50)
DECLARE @PCountryCode nvarchar(6)
DECLARE @PStateProvince nvarchar(50)
DECLARE @BPostalCode nvarchar(10)
DECLARE @BAddressTypeCode nvarchar(6)
DECLARE @BStreetAddress nvarchar(400)
DECLARE @BStreetAddress2 nvarchar(400)
DECLARE @BCity nvarchar(50)
DECLARE @BCountryCode nvarchar(6)
DECLARE @BStateProvince nvarchar(50)
DECLARE @CustomerUserName nvarchar(50)
DECLARE @HintAnswer nvarchar(50)
DECLARE @HintQuestion nvarchar(50)
DECLARE @Password nvarchar(50)
DECLARE @Expiration nvarchar(50)
DECLARE @CCNumber nvarchar(50)
DECLARE @CCTypeCode nvarchar(50)
DECLARE @CCHolderName nvarchar(50)
DECLARE @IsDefault tinyint
DECLARE @username nvarchar(50)
DECLARE @OrganizationID int
DECLARE @AdminOrganizationID int
DECLARE @TravelAgencyID int
DECLARE @AdminTravelAgencyID int
DECLARE @ServiceCode varchar(6)
DECLARE @RankCode varchar(6)
DECLARE @PayGradeCode varchar(6)
DECLARE @SupervisorEmailAddress varchar(50)
DECLARE @CustomerID nvarchar(50)
DECLARE @document_type varchar(10)
DECLARE @document_id nvarchar(50)
DECLARE @doc_holder_name nvarchar(50)
DECLARE @issue_authority nvarchar(50)
DECLARE @issue_countryCode nvarchar(6)
DECLARE @effective_date datetime
DECLARE @expiration_date datetime
DECLARE @issue_date datetime
DECLARE @showOnWeb tinyint
DECLARE @receiveEmailMarketingMaterial tinyint
DECLARE @roomCleanTime varchar(6)
DECLARE @roomDownTime varchar(6)
DECLARE @autoEmailFolio tinyint
DECLARE @Token nvarchar(50)
DECLARE @taxID nvarchar(50)
DECLARE @isTaxExempt tinyint
DECLARE @managedProfileID nvarchar(20)
DECLARE @nationality nvarchar(10)
DECLARE @resortFeeCode nvarchar(6)
DECLARE @twitterID nvarchar(32)
DECLARE @facebookID nvarchar(32)
DECLARE @tripAdvisorID nvarchar(32)
DECLARE @bookingDotComID nvarchar(32)
DECLARE @taxExemptCode nvarchar(6)
DECLARE @vehicle nvarchar(50)
DECLARE @countryOfResidence nvarchar(6)
DECLARE @originatingSystemID nvarchar(50)
DECLARE @isEmailOptIn tinyint
DECLARE @isPartnerEmailOptIn tinyint
DECLARE @updatedFromReservation tinyint

-- TODO: Set parameter values here.
SET	@profileid = NULL
SET	@PrimaryLanguageCode = NULL
SET	@EmailAddress = NULL
SET	@ProfileTypeCode =  N'GST' -- can be pretty much anything, but we have[dbo].[CodeValue].[CodeValue]
SET	@ProfileStatusCode =  N'ACTIVE'
SET	@VIPStatusCode = NULL
SET	@AlternateEmailAddress = NULL
SET	@PMSReferenceNumber = NULL
SET	@HasWebAccess = NULL
SET	@BirthMonth = NULL
SET	@BirthDay = NULL
SET	@BirthYear = NULL
SET	@GenderCode = NULL
SET	@Notes =  N''
SET	@SourceLastUpdatedBy = NULL
SET	@SourceLastUpdatedOn = NULL
SET	@NamePrefix = NULL
SET	@MiddleInitial =  N''
SET	@NameSuffix =  N''
SET	@NameTitle =  N''
SET	@FirstName =  N'Dmitri'
SET	@LastName = N'Medvedevski'
SET	@AliasFirstName =  N''
SET	@AliasMiddleName =  N''
SET	@AliasLastName =  N''
SET	@PrimaryContact = NULL
SET	@DCountryAccessNumber = NULL
SET	@DAreaCityCode = NULL
SET	@DPhoneNumberTypeCode = NULL
SET	@DPhoneExtension = NULL
SET	@DPhoneNumber = NULL
SET	@ECountryAccessNumber = NULL
SET	@EAreaCityCode = NULL
SET	@EPhoneNumberTypeCode = NULL
SET	@EPhoneExtension = NULL
SET	@EPhoneNumber = NULL
SET	@PPostalCode = NULL
SET	@PAddressTypeCode = NULL
SET	@PStreetAddress = NULL
SET	@PStreetAddress2 = NULL
SET	@PCity = NULL
SET	@PCountryCode = NULL
SET	@PStateProvince = NULL
SET	@BPostalCode = NULL
SET	@BAddressTypeCode = NULL
SET	@BStreetAddress = NULL
SET	@BStreetAddress2 = NULL
SET	@BCity = NULL
SET	@BCountryCode = NULL
SET	@BStateProvince = NULL
SET	@CustomerUserName = NULL
SET	@HintAnswer = NULL
SET	@HintQuestion = NULL
SET	@Password = NULL
SET	@Expiration = NULL
SET	@CCNumber = NULL
SET	@CCTypeCode = NULL
SET	@CCHolderName = NULL
SET	@IsDefault = NULL
SET	@username =  N'manually created'
SET	@OrganizationID = NULL
SET	@AdminOrganizationID = NULL
SET	@TravelAgencyID = NULL
SET	@AdminTravelAgencyID = NULL
SET	@ServiceCode =  N''
SET	@RankCode =  N''
SET	@PayGradeCode =  N''
SET	@SupervisorEmailAddress = NULL
SET	@CustomerID =  N'1'
SET	@document_type = NULL
SET	@document_id = NULL
SET	@doc_holder_name = NULL
SET	@issue_authority = NULL
SET	@issue_countryCode = NULL
SET	@effective_date = NULL
SET	@expiration_date = NULL
SET	@issue_date = NULL
SET	@showOnWeb = NULL
SET	@receiveEmailMarketingMaterial = 0
SET	@roomCleanTime = NULL
SET	@roomDownTime = NULL
SET	@autoEmailFolio = 0
SET	@Token = NULL
SET	@taxID = N''
SET	@isTaxExempt = NULL
SET	@managedProfileID = NULL
SET	@nationality = NULL
SET	@resortFeeCode = NULL
SET	@twitterID =  N'*'
SET	@facebookID =  N'*'
SET	@tripAdvisorID =  N'*'
SET	@bookingDotComID =  N'*'
SET	@taxExemptCode =  N''
SET	@vehicle = NULL
SET	@countryOfResidence = NULL
SET	@originatingSystemID = N'HMS'
SET	@isEmailOptIn = NULL
SET	@isPartnerEmailOptIn = NULL
SET	@updatedFromReservation 	=	1



EXECUTE @RC = [dbo].[prc_RegisterUser] 
   @profileid OUTPUT
  ,@PrimaryLanguageCode
  ,@EmailAddress
  ,@ProfileTypeCode
  ,@ProfileStatusCode
  ,@VIPStatusCode
  ,@AlternateEmailAddress
  ,@PMSReferenceNumber
  ,@HasWebAccess
  ,@BirthMonth
  ,@BirthDay
  ,@BirthYear
  ,@GenderCode
  ,@Notes
  ,@SourceLastUpdatedBy
  ,@SourceLastUpdatedOn
  ,@NamePrefix
  ,@MiddleInitial
  ,@NameSuffix
  ,@NameTitle
  ,@FirstName
  ,@LastName
  ,@AliasFirstName
  ,@AliasMiddleName
  ,@AliasLastName
  ,@PrimaryContact
  ,@DCountryAccessNumber
  ,@DAreaCityCode
  ,@DPhoneNumberTypeCode
  ,@DPhoneExtension
  ,@DPhoneNumber
  ,@ECountryAccessNumber
  ,@EAreaCityCode
  ,@EPhoneNumberTypeCode
  ,@EPhoneExtension
  ,@EPhoneNumber
  ,@PPostalCode
  ,@PAddressTypeCode
  ,@PStreetAddress
  ,@PStreetAddress2
  ,@PCity
  ,@PCountryCode
  ,@PStateProvince
  ,@BPostalCode
  ,@BAddressTypeCode
  ,@BStreetAddress
  ,@BStreetAddress2
  ,@BCity
  ,@BCountryCode
  ,@BStateProvince
  ,@CustomerUserName
  ,@HintAnswer
  ,@HintQuestion
  ,@Password
  ,@Expiration
  ,@CCNumber
  ,@CCTypeCode
  ,@CCHolderName
  ,@IsDefault
  ,@username
  ,@OrganizationID
  ,@AdminOrganizationID
  ,@TravelAgencyID
  ,@AdminTravelAgencyID
  ,@ServiceCode
  ,@RankCode
  ,@PayGradeCode
  ,@SupervisorEmailAddress
  ,@CustomerID
  ,@document_type
  ,@document_id
  ,@doc_holder_name
  ,@issue_authority
  ,@issue_countryCode
  ,@effective_date
  ,@expiration_date
  ,@issue_date
  ,@showOnWeb
  ,@receiveEmailMarketingMaterial
  ,@roomCleanTime
  ,@roomDownTime
  ,@autoEmailFolio
  ,@Token
  ,@taxID
  ,@isTaxExempt
  ,@managedProfileID
  ,@nationality
  ,@resortFeeCode
  ,@twitterID
  ,@facebookID
  ,@tripAdvisorID
  ,@bookingDotComID
  ,@taxExemptCode
  ,@vehicle
  ,@countryOfResidence
  ,@originatingSystemID
  ,@isEmailOptIn
  ,@isPartnerEmailOptIn
  ,@updatedFromReservation
GO


