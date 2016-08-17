USE [hotel]
GO

/****** Object:  Table [logs].[errors]    Script Date: 13-Aug-16 9:35:08 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[logs].[errors]') AND type IN (N'U'))
DROP TABLE [logs].[errors]
GO

/****** Object:  Table [logs].[errors]    Script Date: 13-Aug-16 9:35:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[logs].[errors]') AND type IN (N'U'))
BEGIN
CREATE TABLE [logs].[errors](
	[ID] [INT] IDENTITY(1,1) NOT NULL,
	[ProcedureName] [NVARCHAR](200) NULL,
	[ProfileID] [INT] NULL,
	[SourceCode] [NVARCHAR](200) NULL,
	[GuaranteeCode] [NVARCHAR](200) NULL,
	[CheckInDate] [DATETIME] NULL,
	[CheckOutDate] [DATETIME] NULL,
	[RatePlanCode] [NVARCHAR](200) NULL,
	[RoomTypeCode] [NVARCHAR](200) NULL,
	[ReservationID] [INT] NULL,
	[ReservationStayID] [INT] NULL,
	[TrackingNumber] [NVARCHAR](64) NULL,
	[RoomNumber] [VARCHAR](10) NULL,
	[Status] [NVARCHAR](1) NULL,
	[Executed_on] [DATETIME] NULL,
	[ErrorCode] [INT] NULL,
	[ErrorColumn] [NVARCHAR](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_PADDING OFF
GO


