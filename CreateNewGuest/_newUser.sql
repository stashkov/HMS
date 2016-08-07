----------- 1 create new user and get its profile id
DECLARE @p1 INT;
SET @p1 = 173;
DECLARE @p4 INT;
SET @p4 = 45;
EXEC sp_prepexec @p1 OUTPUT,
    N'@P0 int OUTPUT,@P1 varchar(8000),@P2 varchar(8000),@P3 nvarchar(4000),@P4 nvarchar(4000),@P5 varchar(8000),@P6 varchar(8000),@P7 varchar(8000),@P8 tinyint,@P9 int,@P10 int,@P11 int,@P12 varchar(8000),@P13 nvarchar(4000),@P14 varchar(8000),@P15 datetime2,@P16 varchar(8000),@P17 nvarchar(4000),@P18 nvarchar(4000),@P19 nvarchar(4000),@P20 nvarchar(4000),@P21 nvarchar(4000),@P22 nvarchar(4000),@P23 nvarchar(4000),@P24 nvarchar(4000),@P25 varchar(8000),@P26 varchar(8000),@P27 varchar(8000),@P28 varchar(8000),@P29 varchar(8000),@P30 varchar(8000),@P31 varchar(8000),@P32 varchar(8000),@P33 varchar(8000),@P34 varchar(8000),@P35 varchar(8000),@P36 varchar(8000),@P37 varchar(8000),@P38 varchar(8000),@P39 varchar(8000),@P40 varchar(8000),@P41 varchar(8000),@P42 varchar(8000),@P43 varchar(8000),@P44 varchar(8000),@P45 varchar(8000),@P46 varchar(8000),@P47 varchar(8000),@P48 varchar(8000),@P49 varchar(8000),@P50 varchar(8000),@P51 varchar(8000),@P52 varchar(8000),@P53 varchar(8000),@P54 varchar(8000),@P55 varchar(8000),@P56 varchar(8000),@P57 varchar(8000),@P58 tinyint,@P59 nvarchar(4000),@P60 int,@P61 int,@P62 int,@P63 int,@P64 nvarchar(4000),@P65 nvarchar(4000),@P66 nvarchar(4000),@P67 varchar(8000),@P68 nvarchar(4000),@P69 varchar(8000),@P70 varchar(8000),@P71 varchar(8000),@P72 varchar(8000),@P73 varchar(8000),@P74 datetime2,@P75 datetime2,@P76 datetime2,@P77 tinyint,@P78 tinyint,@P79 varchar(8000),@P80 varchar(8000),@P81 tinyint,@P82 varchar(8000),@P83 nvarchar(4000),@P84 tinyint,@P85 varchar(8000),@P86 varchar(8000),@P87 varchar(8000),@P88 nvarchar(4000),@P89 nvarchar(4000),@P90 nvarchar(4000),@P91 nvarchar(4000),@P92 nvarchar(4000),@P93 varchar(8000),@P94 varchar(8000),@P95 nvarchar(4000),@P96 tinyint,@P97 tinyint,@P98 tinyint',
    N'EXEC prc_RegisterUser @P0 OUT,@P1,@P2,@P3,@P4,@P5,@P6,@P7,@P8,@P9,                @P10,@P11,@P12,@P13,@P14,@P15,@P16,@P17,@P18,@P19,                @P20,@P21,@P22,@P23,@P24,@P25,@P26,@P27,@P28,@P29,                @P30,@P31,@P32,@P33,@P34,@P35,@P36,@P37,@P38,@P39,                @P40,@P41,@P42,@P43,@P44,@P45,@P46,@P47,@P48,@P49,                @P50,@P51,@P52,@P53,@P54,@P55,@P56,@P57,@P58,@P59,                @P60,@P61,@P62,@P63,@P64,@P65,@P66,@P67,@P68,@P69,                @P70,@P71,@P72,@P73,@P74,@P75,@P76,@P77,@P78,@P79,                @P80,@P81,@P82,@P83,@P84,@P85,@P86,@P87,@P88,@P89,                @P90,@P91,@P92,@P93,@P94,@P95,@P96,@P97,@P98                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ',
    @p4 OUTPUT, NULL, NULL, N'GST', N'ACTIVE', NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, N'', NULL, NULL, NULL, N'', N'', N'', N'Barack',
    N'Obama', N'', N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, N'R5', NULL, NULL, NULL, NULL, N'', N'', N'', NULL, N'1', NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL,
    N'', NULL, NULL, NULL, NULL, N'*', N'*', N'*', N'*', N'', NULL, NULL,
    N'HMS', NULL, NULL, 1;
SELECT  @p1 ,
        @p4;




--------------- 2

DECLARE @p1 INT;
SET @p1 = 267;
EXEC sp_prepexec @p1 OUTPUT,
    N'@P0 nvarchar(4000),@P1 nvarchar(4000),@P2 nvarchar(4000),@P3 decimal(38,6),@P4 bigint,@P5 datetime2,@P6 datetime2,@P7 nvarchar(4000),@P8 nvarchar(4000),@P9 nvarchar(4000),@P10 bigint,@P11 nvarchar(4000),@P12 datetime2,@P13 nvarchar(4000),@P14 datetime2',
    N'INSERT INTO P5ACCOUNT(ACC_ACCOUNTNAME,ACC_PROPERTY,ACC_STATUS,ACC_BALANCE,ACC_COREACCOUNTID,ACC_UPDATED,ACC_STARTDATE,ACC_ACCOUNT,ACC_NOPOST,ACC_CREATEDBY,ACC_ACCOUNTID,ACC_UPDATEDBY,ACC_CREATED,ACC_ACCOUNTTYPE,ACC_ENDDATE) VALUES( @P0, @P1, @P2, @P3, @P4, @P5, @P6, @P7, @P8, @P9, @P10, @P11, @P12, @P13, @P14)                                                                                                                   ',
    N'Obama, Barack', N'VEGA', N'PEND', 0.000000, 47,
    '2016-07-22 04:28:42.3200000', '2016-07-05 00:00:00', N'48', N'-', N'R5',
    46, N'R5', '2016-07-22 04:28:42.3200000', N'GUEST', '2016-07-06 00:00:00';
SELECT  @p1;
-----------4
DECLARE @p1 INT;
SET @p1 = 274;
EXEC sp_prepexec @p1 OUTPUT,
    N'@P0 bigint,@P1 bigint,@P2 nvarchar(4000),@P3 nvarchar(4000),@P4 nvarchar(4000),@P5 nvarchar(4000),@P6 nvarchar(4000),@P7 nvarchar(4000),@P8 nvarchar(4000),@P9 nvarchar(4000),@P10 nvarchar(4000),@P11 nvarchar(4000),@P12 nvarchar(4000),@P13 nvarchar(4000),@P14 nvarchar(4000),@P15 nvarchar(4000),@P16 nvarchar(4000),@P17 nvarchar(4000),@P18 date,@P19 datetime2,@P20 datetime2,@P21 nvarchar(4000),@P22 nvarchar(4000),@P23 nvarchar(4000),@P24 date,@P25 datetime2,@P26 datetime2,@P27 nvarchar(4000),@P28 nvarchar(4000),@P29 nvarchar(4000),@P30 date,@P31 date,@P32 nvarchar(4000),@P33 nvarchar(4000),@P34 nvarchar(4000),@P35 nvarchar(4000),@P36 nvarchar(4000),@P37 nvarchar(4000),@P38 nvarchar(4000),@P39 nvarchar(4000),@P40 nvarchar(4000),@P41 date,@P42 nvarchar(4000),@P43 date,@P44 nvarchar(4000),@P45 nvarchar(4000),@P46 nvarchar(4000),@P47 nvarchar(4000),@P48 date,@P49 date,@P50 date,@P51 nvarchar(4000),@P52 nvarchar(4000),@P53 nvarchar(4000),@P54 date,@P55 date,@P56 nvarchar(4000),@P57 nvarchar(4000),@P58 date,@P59 nvarchar(4000),@P60 datetime2,@P61 nvarchar(4000),@P62 datetime2,@P63 nvarchar(4000)',
    N'INSERT INTO guestNameInfo ( ReservationStayID, NameInfoID, NamePrefix, MiddleInitial, NameSuffix, NameTitle, FirstName, LastName, PrimaryGuest, AliasFirstName, AliasMiddleName, AliasLastName, Service, Rank, Grade, ArrivalType, ArrivalInformation, ArrivalNotes, ArrivalDate, ArrivalTimeNew, HotelArrivalTime, DepartureType, DepartureInformation, DepartureNotes, DepartureDate, DepartureTimeNew, HotelDepartureTime, NextDestination, PassportNumber, PassportName, PassportIssuedDate, PassportExpirationDate, PassportType, IssuingCountry, PassportNationality, BirthCountry, BirthCity, Occupation, Religion, Mother, Father, PassportScannedDate, PersonalNumber, DateOfBirth, Gender, VisaNumber, VisaType, VisaStatus, VisaIssuedDate, VisaBeginDate, VisaExpirationDate, VisaNotes, IdNumber, IdType, IdIssuedDate, IdExpirationDate, Nationality, IdName, IdDateOfBirth, IdGender, CreatedOn, CreatedBy, UpdatedOn, UpdatedBy) values(  @P0,@P1,@P2,@P3,@P4,@P5,@P6,@P7,@P8,@P9,@P10,@P11,@P12,@P13,@P14,@P15,@P16,@P17,@P18,@P19,@P20,@P21,@P22,@P23,@P24,@P25,@P26,@P27,@P28,@P29,@P30,@P31,@P32,@P33,@P34,@P35,@P36,@P37,@P38,@P39,@P40,@P41,@P42,@P43,@P44,@P45,@P46,@P47,@P48,@P49,@P50,@P51,@P52,@P53,@P54,@P55,@P56,@P57,@P58,@P59,@P60,@P61,@P62,@P63)                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ',
    46, 46, NULL, NULL, NULL, NULL, N'Barack', N'Obama', N'+', NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2016-07-05', NULL, NULL, NULL,
    NULL, NULL, '2016-07-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, '2016-07-22 04:28:42.3900000', N'R5',
    '2016-07-22 04:28:42.3900000', N'R5';
SELECT  @p1;



-----------UPDATE existing user
DECLARE @p1 int
SET @p1=99 EXEC sp_prepexec @p1 OUTPUT,
                                N'@P0 varchar(8000),@P1 datetime2,@P2 varchar(8000),@P3 varchar(8000),@P4 nvarchar(4000),@P5 nvarchar(4000),@P6 datetime2,@P7 nvarchar(4000),@P8 varchar(8000),@P9 bigint,@P10 varchar(8000),@P11 nvarchar(4000),@P12 varchar(8000),@P13 varchar(8000),@P14 bigint',
                                 N'UPDATE NAMEINFO  SET aliasmiddlename= @P0 , updatedon= @P1 , aliaslastname= @P2 , namesuffix= @P3 , lastname= @P4 , createdby= @P5 , createdon= @P6 , firstname= @P7 , updatecount= @P8 , profileid= @P9 , nametitle= @P10 , updatedby= @P11 , middleinitial= @P12 , aliasfirstname= @P13   WHERE  (PROFILEID =  @P14)                                                                                                                   ',
                                  NULL,
                                  '2016-07-28 15:22:00',
                                  NULL,
                                  NULL,
                                  N'Freud',
                                   N'R5',
                                    '2016-07-28 00:00:00',
                                    N'Zigmundovich11',
                                     NULL,
                                     53,
                                     NULL,
                                     N'R5',
                                      NULL,
                                      NULL,
                                      53
SELECT @p1 DECLARE @p1 int
SET @p1=100 EXEC sp_prepexec @p1 OUTPUT,
                                 N'@P0 nvarchar(4000),@P1 nvarchar(4000),@P2 bigint',
                                  N'UPDATE GUESTNAMEINFO  SET lastname= @P0 , firstname= @P1   WHERE  (NAMEINFOID =  @P2)                        ',
                                   N'Freud',
                                    N'Zigmundovich11',
                                     54
SELECT @p1


