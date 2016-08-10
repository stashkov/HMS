DROP TABLE logs.errors
CREATE TABLE logs.errors
    (
	ID INT IDENTITY(1,1) PRIMARY KEY,
      ProfileID INT ,
      SourceCode NVARCHAR(200) ,
      GuaranteeCode NVARCHAR(200) ,
      CheckInDate DATETIME ,
      CheckOutDate DATETIME ,
      RatePlanCode NVARCHAR(200) ,
      RoomTypeCode NVARCHAR(200) ,
      ReservationID INT ,
      ReservationStayID INT ,
      TrackingNumber NVARCHAR(64),
	  RoomNumber VARCHAR(10),
	  Status VARCHAR(10),  -- add derived column and convert this to nvarchar
	  Executed_on DATETIME,
	  ErrorCode INT,
	  ErrorColumn NVARCHAR(500)


    );