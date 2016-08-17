USE [hotel]
GO

/****** Object:  Table [logs].[dictionary]    Script Date: 13-Aug-16 9:34:57 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[logs].[dictionary]') AND type IN (N'U'))
DROP TABLE [logs].[dictionary]
GO

/****** Object:  Table [logs].[dictionary]    Script Date: 13-Aug-16 9:34:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[logs].[dictionary]') AND type IN (N'U'))
BEGIN
CREATE TABLE [logs].[dictionary](
	[ID] [INT] IDENTITY(1,1) NOT NULL,
	[Type] [NVARCHAR](30) NOT NULL,
	[EpitomeCode] [NVARCHAR](200) NOT NULL,
	[HMSCode] [NVARCHAR](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


