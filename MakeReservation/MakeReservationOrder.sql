


SELECT  * ,
        LEN(TrackingNumber)
FROM    dbo.TrackingNumber
ORDER BY CreatedOn DESC;


SELECT *
FROM dbo.Profile
WHERE ProfileID = 59

SELECT *
FROM dbo.NameInfo
WHERE NameInfoID = 64

--------------
SELECT  *
FROM    dbo.GuestStaySummary
WHERE ProfileID = 59

SELECT  *
FROM    dbo.TrackingNumber
WHERE TrackingNumber = 35000376

SELECT  *
FROM    dbo.Reservation
WHERE ReservationID = 64

SELECT  *
FROM    dbo.ReservationStay
WHERE ReservationID = 64

SELECT  *
FROM    ReservationActivity
WHERE ReservationID = 64

--[dbo].[TrackingNumber].[TrackingNumber]
--[dbo].[Reservation].[ConfirmationNumber]
--[dbo].[ReservationStay].[PMSConfirmationNumber]
--[dbo].[Account].[PmsAccountRef]
--[dbo].[GuestStaySummary].[ConfirmationNumber]

SELECT  *
FROM    dbo.GuestStayStatistics
WHERE ProfileID = 59

-- start really not sure what this is for
SELECT  *
FROM    dbo.Pickup

SELECT  *
FROM    dbo.P5RESERVATIONSTAYDATE;

SELECT  *
FROM    dbo.P5PROFILEMERGESUSPECTQUEUE;
----end really not sure what this is for


---start dictionaries
SELECT  *
FROM    dbo.RoomType;

SELECT  *
FROM    dbo.RatePlan;
---end dictionaries
