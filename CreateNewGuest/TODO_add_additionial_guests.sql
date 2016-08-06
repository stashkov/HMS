USE VEGAUAT

SELECT *
FROM dbo.NameInfo
SELECT *
FROM dbo.GuestNameInfo

BEGIN TRAN
UPDATE dbo.NameInfo
SET    NamePrefix = NULL,
       MiddleInitial = NULL,
       NameSuffix = NULL,
       NameTitle = NULL,
       --FirstName = ?
       --LastName = ?
       PrimaryContact = NULL,
       AliasFirstName = NULL,
       AliasMiddleName = NULL,
       AliasLastName = NULL,
       Fullname = NULL,
       UpdateCount = (SELECT ISNULL(UpdateCount, 0) + 1 FROM dbo.NameInfo WHERE ProfileID = 53), -- dynamically change this!!!
       UpdatedBy = 'FROM_EPITOME',
       UpdatedOn = (SELECT GETDATE())
WHERE ProfileID = 53

UPDATE dbo.GuestNameInfo	
SET GuestNameInfoID ,
       ReservationStayID ,
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
WHERE NameInfoID = (SELECT NameInfoID
FROM dbo.NameInfo
WHERE ProfileID = 1)
END TRAN



-----
DECLARE @p1 INT;
SET @p1 = 22;
EXEC sp_prepexec @p1 OUTPUT,
    N'@P0 bigint,@P1 datetime2,@P2 nvarchar(4000),@P3 nvarchar(4000),@P4 nvarchar(4000),@P5 nvarchar(4000),@P6 datetime2,@P7 nvarchar(4000),@P8 nvarchar(4000)',
    N'INSERT INTO GUESTNAMEINFO(RESERVATIONSTAYID,UPDATEDON,CREATEDBY,UPDATEDBY,LASTNAME,PRIMARYGUEST,CREATEDON,FIRSTNAME,PASSPORTVISACHECK) VALUES( @P0, @P1, @P2, @P3, @P4, @P5, @P6, @P7, @P8)                                                                        ',
    61, '2016-07-29 04:23:10.7300000', N'R5', N'R5', N'Med', N'-',
    '2016-07-29 04:23:10.7300000', N'Dmitri', N'-';
SELECT  @p1;
DECLARE @p1 INT;
SET @p1 = 42;
EXEC sp_prepexec @p1 OUTPUT,
    N'@P0 varchar(8000),@P1 varchar(8000),@P2 varchar(8000),@P3 varchar(8000),@P4 nvarchar(4000),@P5 nvarchar(4000),@P6 varchar(8000),@P7 varchar(8000),@P8 varchar(8000),@P9 nvarchar(4000),@P10 nvarchar(4000)',
    N'  INSERT  INTO NameInfo
        ( namePrefix ,
          middleInitial ,
          nameSuffix ,
          nameTitle ,
          firstName ,
          lastName ,
          aliasFirstName ,
          aliasMiddleName ,
          aliasLastName ,
          createdOn ,
          createdBy ,
          updatedOn ,
          updatedBy
        )
VALUES  ( @P0 ,
          @p1 ,
          @P2 ,
          @P3 ,
          @P4 ,
          @P5 ,
          @P6 ,
          @P7 ,
          @P8 ,
          GETDATE() ,
          @P9 ,
          GETDATE() ,
          @P10
        );
SELECT  SCOPE_IDENTITY() AS nameInfoID;                                                                                           ',
    NULL, NULL, NULL, NULL, N'Dmitri', N'Med', NULL, NULL, NULL, N'R5', N'R5';
SELECT  @p1;



