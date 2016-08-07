USE hotel

SELECT DATALENGTH(comments)
FROM dbo.guest_names
GROUP BY DATALENGTH(comments)


SELECT comments
FROM dbo.guest_names
WHERE comments IS NOT NULL

SELECT comments, DATALENGTH(comments)
FROM dbo.guest
WHERE comments IS NOT NULL
ORDER BY DATALENGTH(comments) DESC

SELECT TOP 10 *
FROM dbo.guest


SELECT *
FROM dbo.z_roomtype

SELECT *
FROM dbo.z_ratecodes

SELECT *
FROM dbo.z_marketsegment

SELECT *
FROM dbo.guest


-----info about room types
select *
FROM dbo.room_activity

SELECT code, z.roomtype, r.room_type_id
FROM dbo.z_rooms z
INNER JOIN ##roomtype r ON z.roomtype = r.room_type_code
WHERE roomtype IN ('SRQS', 'DXQS', 'STQS', 'APKN', 'SRTS', 'DXTS', 'STTS', 'JSQS', 'SUQSSU', 'RSSQ', 'JSTS')
ORDER BY z.code DESC

SELECT DISTINCT roomtype
FROM dbo.z_rooms

SELECT *
FROM dbo.z_rooms
ORDER BY code DESC

SELECT *
FROM dbo.room_activity

-----

DROP TABLE ##roomtype
CREATE TABLE ##roomtype 
(
room_type_id INT IDENTITY(1,1),
room_type_code nvarchar(10)

)

INSERT INTO ##roomtype        ( room_type_code ) VALUES (N'SRQS')
INSERT INTO ##roomtype        ( room_type_code )VALUES (N'DXQS')
INSERT INTO ##roomtype        ( room_type_code )VALUES (N'STQS')
INSERT INTO ##roomtype        ( room_type_code )VALUES (N'APKN')
INSERT INTO ##roomtype        ( room_type_code )VALUES (N'SRTS')
INSERT INTO ##roomtype        ( room_type_code )VALUES (N'DXTS')
INSERT INTO ##roomtype        ( room_type_code )VALUES (N'STTS')
INSERT INTO ##roomtype        ( room_type_code )VALUES (N'JSQS')
INSERT INTO ##roomtype        ( room_type_code )VALUES (N'SUQSSU')
INSERT INTO ##roomtype        ( room_type_code )VALUES (N'RSSQ')
INSERT INTO ##roomtype        ( room_type_code )VALUES (N'JSTS')


SELECT *
FROM dbo.z_guarantees