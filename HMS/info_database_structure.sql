-- main guest 
SELECT  *
FROM    dbo.NameInfo
WHERE   LastName = 'Putinovichev';
--
SELECT  *
FROM    dbo.Reservation
WHERE   ReservationID = 50;
-- 
SELECT  *
FROM    dbo.GuestNameInfo
WHERE   LastName = 'Putinovichev';
--
SELECT  *
FROM    dbo.P5ACCOUNT
WHERE   ACC_ACCOUNTNAME = 'Putinovichev,Vladimir';


-- table with additional guests in addition to main guest
SELECT  *
FROM    dbo.GuestNameInfo;


-- status of the room
SELECT  *
FROM    P5ROOMBLOCKINGEVENTS;

-- info about reservation
SELECT  *
FROM    dbo.Reservation;

SELECT  *
FROM    dbo.GuaranteeMethod;


