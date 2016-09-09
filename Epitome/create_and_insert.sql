USE [hotel]
GO

IF NOT EXISTS ( SELECT  SCHEMA_NAME
                FROM    INFORMATION_SCHEMA.SCHEMATA
                WHERE   SCHEMA_NAME = N'logs' )
    BEGIN
        EXEC sp_executesql N'CREATE SCHEMA logs';
    END;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[logs].[dictionary]') AND type in (N'U'))
BEGIN
CREATE TABLE [logs].[dictionary](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](30) NOT NULL,
	[EpitomeCode] [nvarchar](200) NOT NULL,
	[HMSCode] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[logs].[errors]') AND type in (N'U'))
BEGIN
CREATE TABLE [logs].[errors](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProcedureName] [nvarchar](200) NULL,
	[ProfileID] [int] NULL,
	[SourceCode] [nvarchar](200) NULL,
	[GuaranteeCode] [nvarchar](200) NULL,
	[CheckInDate] [datetime] NULL,
	[CheckOutDate] [datetime] NULL,
	[RatePlanCode] [nvarchar](200) NULL,
	[RoomTypeCode] [nvarchar](200) NULL,
	[ReservationID] [int] NULL,
	[ReservationStayID] [int] NULL,
	[TrackingNumber] [nvarchar](64) NULL,
	[RoomNumber] [varchar](10) NULL,
	[Status] [nvarchar](1) NULL,
	[Executed_on] [datetime] NULL,
	[ErrorCode] [int] NULL,
	[ErrorColumn] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[logs].[clients]') AND type in (N'U'))
BEGIN
CREATE TABLE [logs].[clients](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[account_epitome] [varchar](20) NOT NULL,
	[profileid_hms] [nvarchar](20) NOT NULL,
	[ReservationID] [int] NULL,
	[ReservationStayID] [int] NULL,
	[StatusCode] [nvarchar](10) NULL,
	[ConfirmationNumber] [int] NULL,
	[executed_on] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[logs].[clients]') AND name = N'ix_clients_profileid_hms_executed_on')
CREATE NONCLUSTERED INDEX [ix_clients_profileid_hms_executed_on] ON [logs].[clients]
(
	[profileid_hms] ASC,
	[executed_on] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[logs].[clients]') AND name = N'NonClusteredIndex-CoverAccProfIDDate')
CREATE NONCLUSTERED INDEX [NonClusteredIndex-CoverAccProfIDDate] ON [logs].[clients]
(
	[account_epitome] ASC
)
INCLUDE ( 	[profileid_hms],
	[executed_on]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[logs].[clients]') AND name = N'NonClusteredIndex-date')
CREATE NONCLUSTERED INDEX [NonClusteredIndex-date] ON [logs].[clients]
(
	[executed_on] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'Status', N'O', N'CheckedOut' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'Status', N'C', N'Cancelled' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'Status', N'R', N'Reserved' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'Status', N'N', N'Cancelled' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'Status', N'I', N'CheckedIn' );
GO



INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'APKN', N'APKN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'DXQS', N'DXQS' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'DXTS', N'DXTS' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'JSQS', N'JSQS' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'JSTS', N'JSTS' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'RSSQ', N'RSSQ' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'SRQS', N'SRQS' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'SRTS', N'SRTS' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'STQS', N'STQS' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'STTS', N'STTS' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'SUQS', N'SUQS' );
GO


INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'1P', N'1P' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'2U', N'2U' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'3A', N'3A' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'92', N'92' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'AGD', N'AGD' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ATMN', N'ATMN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BAR', N'BAR' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BARG', N'BARG' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BARNR', N'BARNR' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BARNRG', N'BARNRG' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BARW', N'BARW' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BOOK', N'BOOK' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BRFN', N'BRFN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'CGCN', N'CGCN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'CGRN', N'CGRN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'CNG', N'CNG' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'CNGRSS', N'CNGRSS' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'COMP', N'COMP' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'COST', N'COST' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'D2', N'D2' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'DE', N'DE' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EATN', N'EATN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EB', N'EB' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ECLUB', N'ECLUB' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EE', N'EE' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'FF', N'FF' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'FI', N'FI' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'FX', N'FX' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'GGV', N'GGV' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'GMM', N'GMM' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'GOT', N'GOT' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'GTTN', N'GTTN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HENN', N'HENN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HONN', N'HONN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HRS', N'HRS' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HRSC', N'HRSC' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'JUNK', N'JUNK' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'LON', N'LON' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'LOVE', N'LOVE' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'LOY', N'LOY' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'LS', N'LS' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'LU', N'LU' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'MS14', N'MS14' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'MS14R', N'MS14R' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'MS7', N'MS7' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'MS7R', N'MS7R' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'PEYN', N'PEYN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'PKG', N'PKG' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'PWSN', N'PWSN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'QOT0', N'QOT0' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'RACK', N'RACK' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'RRBW', N'RRBW' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SCG', N'SCG' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD10', N'SD10' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD15', N'SD15' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD20', N'SD20' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD25', N'SD25' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD30', N'SD30' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD35', N'SD35' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD40', N'SD40' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD45', N'SD45' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD50', N'SD50' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SPG', N'SPG' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TRAVCO', N'TRAVCO' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTG', N'TTG' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGAT', N'TTGAT' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGBE', N'TTGBE' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGCN', N'TTGCN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGCZ', N'TTGCZ' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGDE', N'TTGDE' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGES', N'TTGES' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGFI', N'TTGFI' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGFR', N'TTGFR' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGIN', N'TTGIN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGIR', N'TTGIR' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGIT', N'TTGIT' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGJP', N'TTGJP' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGKR', N'TTGKR' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGNL', N'TTGNL' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGRS', N'TTGRS' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGSE', N'TTGSE' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'VR', N'VR' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'WD50', N'WD50' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'WHL', N'WHL' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'WHLA', N'WHLA' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'WS', N'WS' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'X2', N'X2' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'XN', N'XN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'XW', N'XW' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'XZ', N'XZ' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'Z10', N'Z10' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ZL', N'ZL' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'2P', N'2P' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'9I', N'9I' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'9Q', N'9Q' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ABBN', N'ABBN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'AC', N'AC' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'AE', N'AE' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BBSN', N'BBSN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BW', N'BW' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'DXXN', N'DXXN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EC1', N'EC1' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EC3', N'EC3' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EC5', N'EC5' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EC9', N'EC9' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ECE', N'ECE' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ECF', N'ECF' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EX1', N'EX1' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EX5', N'EX5' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EXE', N'EXE' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EXF', N'EXF' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HK', N'HK' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HP', N'HP' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HY', N'HY' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ISNN', N'ISNN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'LP1', N'LP1' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'NOSN', N'NOSN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'RP', N'RP' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'UC', N'UC' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'UZ', N'UZ' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'VAHN', N'VAHN' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'VO', N'VO' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'VOLH', N'VOLH' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'W', N'W' );
GO



INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'AMEX' ,
          N'AMEX'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'CASH' ,
          N'CASH'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'CC' ,
          N'CC'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'DB' ,
          N'DB'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'DIN' ,
          N'DIN'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'MNGR' ,
          N'MNGR'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'UN' ,
          N'UN'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'VISA' ,
          N'VISA'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'MC' ,
          N'MC'
        );
GO


INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'ADV' ,
          N'ADV'
        );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'SourceOfBusiness', N'BW', N'BW' );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'CFM' ,
          N'CFM'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'CMR' ,
          N'CMR'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'EFM' ,
          N'EFM'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'EMAIL' ,
          N'EMAIL'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'FAX' ,
          N'FAX'
        );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'SourceOfBusiness', N'FD', N'FD' );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'IDS' ,
          N'IDS'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'LBM' ,
          N'LBM'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'MFM' ,
          N'MFM'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'TEL' ,
          N'TEL'
        );
GO

INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'VSP' ,
          N'VSP'
        );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'SourceOfBusiness', N'WI', N'WI' );
GO

INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'SourceOfBusiness', N'WR', N'WR' );
GO

