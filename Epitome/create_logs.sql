CREATE TABLE logs.dictionary
    (
      ID INT IDENTITY(1, 1)
             PRIMARY KEY ,
      [Type] NVARCHAR(30) NOT NULL,
	  EpitomeCode NVARCHAR(200) NOT NULL,
	  HMSCode NVARCHAR(200) NOT NULL,
    );

INSERT INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'GuaranteeType', -- Type - nvarchar(30)
          N'DB', -- EpitomeCode - nvarchar(200)
          N'4PM'  -- HMSCode - nvarchar(200)
          )
INSERT INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'SourceOfBusiness', -- Type - nvarchar(30)
          N'IDS', -- EpitomeCode - nvarchar(200)
          N'Call'  -- HMSCode - nvarchar(200)
          )
INSERT INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'SourceOfBusiness', -- Type - nvarchar(30)
          N'LBM', -- EpitomeCode - nvarchar(200)
          N'Call'  -- HMSCode - nvarchar(200)
          )
INSERT INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'SourceOfBusiness', -- Type - nvarchar(30)
          N'SD', -- EpitomeCode - nvarchar(200)
          N'Call'  -- HMSCode - nvarchar(200)
          )
INSERT INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', -- Type - nvarchar(30)
          N'SRTS', -- EpitomeCode - nvarchar(200)
          N'SRTS'  -- HMSCode - nvarchar(200)
          )

INSERT INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', -- Type - nvarchar(30)
          N'BARNR', -- EpitomeCode - nvarchar(200)
          N'HIGH1'  -- HMSCode - nvarchar(200)
          )
INSERT INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', -- Type - nvarchar(30)
          N'HS2', -- EpitomeCode - nvarchar(200)
          N'HIGH1'  -- HMSCode - nvarchar(200)
          )

INSERT INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'MarketingSegment', -- Type - nvarchar(30)
          N'PRO', -- EpitomeCode - nvarchar(200)
          N'something'  -- HMSCode - nvarchar(200)
          )
INSERT INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'status', -- Type - nvarchar(30)
          N'O', -- EpitomeCode - nvarchar(200)
          N'something'  -- HMSCode - nvarchar(200)
          )
