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

SELECT DISTINCT roomtype
FROM dbo.z_rooms

SELECT *
FROM dbo.z_rooms
ORDER BY code DESC

SELECT *
FROM dbo.room_activity

----

SELECT *
FROM dbo.z_guarantees