USE [hotel]
GO

/****** Object:  Index [NonClusteredIndex-date]    Script Date: 13-Aug-16 9:34:36 AM ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[logs].[clients]') AND name = N'NonClusteredIndex-date')
DROP INDEX [NonClusteredIndex-date] ON [logs].[clients]
GO

/****** Object:  Index [NonClusteredIndex-CoverAccProfIDDate]    Script Date: 13-Aug-16 9:34:36 AM ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[logs].[clients]') AND name = N'NonClusteredIndex-CoverAccProfIDDate')
DROP INDEX [NonClusteredIndex-CoverAccProfIDDate] ON [logs].[clients]
GO

/****** Object:  Index [ix_clients_profileid_hms_executed_on]    Script Date: 13-Aug-16 9:34:36 AM ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[logs].[clients]') AND name = N'ix_clients_profileid_hms_executed_on')
DROP INDEX [ix_clients_profileid_hms_executed_on] ON [logs].[clients]
GO

/****** Object:  Table [logs].[clients]    Script Date: 13-Aug-16 9:34:36 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[logs].[clients]') AND type in (N'U'))
DROP TABLE [logs].[clients]
GO

/****** Object:  Table [logs].[clients]    Script Date: 13-Aug-16 9:34:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[logs].[clients]') AND type IN (N'U'))
BEGIN
CREATE TABLE [logs].[clients](
	[ID] [INT] IDENTITY(1,1) NOT NULL,
	[account_epitome] [VARCHAR](20) NOT NULL,
	[profileid_hms] [NVARCHAR](20) NOT NULL,
	[ReservationID] [INT] NULL,
	[ReservationStayID] [INT] NULL,
	[StatusCode] [NVARCHAR](10) NULL,
	[ConfirmationNumber] [INT] NULL,
	[executed_on] [DATETIME] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_PADDING OFF
GO

SET ANSI_PADDING ON

GO

/****** Object:  Index [ix_clients_profileid_hms_executed_on]    Script Date: 13-Aug-16 9:34:36 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[logs].[clients]') AND name = N'ix_clients_profileid_hms_executed_on')
CREATE NONCLUSTERED INDEX [ix_clients_profileid_hms_executed_on] ON [logs].[clients]
(
	[profileid_hms] ASC,
	[executed_on] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO

SET ANSI_PADDING ON

GO

/****** Object:  Index [NonClusteredIndex-CoverAccProfIDDate]    Script Date: 13-Aug-16 9:34:36 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[logs].[clients]') AND name = N'NonClusteredIndex-CoverAccProfIDDate')
CREATE NONCLUSTERED INDEX [NonClusteredIndex-CoverAccProfIDDate] ON [logs].[clients]
(
	[account_epitome] ASC
)
INCLUDE ( 	[profileid_hms],
	[executed_on]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [NonClusteredIndex-date]    Script Date: 13-Aug-16 9:34:36 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[logs].[clients]') AND name = N'NonClusteredIndex-date')
CREATE NONCLUSTERED INDEX [NonClusteredIndex-date] ON [logs].[clients]
(
	[executed_on] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


