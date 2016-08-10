CREATE TABLE [logs].[clients]
(
[account_epitome] [varchar] (20) COLLATE Cyrillic_General_CI_AS NOT NULL,
[profileid_hms] [nvarchar] (20) COLLATE Cyrillic_General_CI_AS NOT NULL,
[ReservationID] [int] NULL,
[ReservationStayID] [int] NULL,
[StatusCode] [nvarchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[ConfirmationNumber] [int] NULL,
[executed_on] [datetime] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-CoverAccProfIDDate] ON [logs].[clients] ([account_epitome]) INCLUDE ([profileid_hms], [executed_on]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-date] ON [logs].[clients] ([executed_on]) ON [PRIMARY]
GO
