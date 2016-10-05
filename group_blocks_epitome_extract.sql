use hotel
go


select TOP 100 *
from group_blocks

DECLARE @GroupName NVARCHAR(100) = N'mhuhuua000222'
DECLARE @RatePlanCode NVARCHAR(6) = N'BOOK'
DECLARE @SourceCode NVARCHAR(6) = N'CALL'
DECLARE @RatePlanList NVARCHAR(100) = N'SRTS,STQS,STTS'

DECLARE @CheckInDate DATETIME = '20160709'
DECLARE @CheckOutDate DATETIME = '20160715'
DECLARE @ReleaseDate DATETIME = '20160714'

SELECT 
	   CAST(g.saacct AS NVARCHAR(12)) AS saacct, 
	   CAST(name AS NVARCHAR(70)) AS name, 
	   CAST(rate_code AS NVARCHAR(6)) as rate_code, 
	   CAST(source AS NVARCHAR(6)) as source, 
	   arrival, 
	   departure, 
	   cutoff_date
FROM groups g
--WHERE g.LastUpdated > '20160703'
WHERE departure > GETDATE() OR GETDATE() BETWEEN arrival AND departure

select * from logs.group_blocks
-------------------------
SELECT t.saacct, CAST(room_type AS NVARCHAR(10)) AS room_type, SUM(blocked) as blocked, res_date, g.propGroupBookingID
 --SUM(picked_up) as picked_up
FROM (SELECT saacct, 
		  room_type, 
		  blocked as blocked, 
		  --picked_up as picked_up, 
		  res_date, 
		  lastupdated, 
		  ROW_NUMBER() OVER (ORDER BY LastUpdated DESC) as seqnum 
	   FROM group_blocks
	   WHERE LastUpdated > '20160707'
	) t
INNER JOIN logs.group_blocks g ON g.saacct = t.saacct
GROUP BY t.saacct, room_type, res_date, t.seqnum, g.propGroupBookingID
ORDER BY seqnum ASC
----------------------------------

select *
from group_blocks
ORDER BY LastUpdated DESC


select TOP 100 *
from groups


select top 100 *
from group_blocks

select *
from logs.dictionary

select *
from group_blocks
WHERE saacct = 902942




SELECT DISTINCT t.saacct, 
			 CAST(room_type AS NVARCHAR(10)) AS room_type,
			 g.propGroupBookingID, 
			 gg.arrival, 
			 gg.departure, 
			 CAST(gg.rate_code AS NVARCHAR(10)) as rate_code
FROM group_blocks t
INNER JOIN logs.group_blocks g ON g.saacct = t.saacct
INNER JOIN groups gg ON gg.saacct = t.saacct



select c.ReservationStayID, gb.propGroupBookingID
from logs.clients c
INNER JOIN guest g ON g.account = c.account_epitome
INNER JOIN logs.group_blocks gb ON gb.saacct = g.saacct
WHERE g.LastUpdated > ? 

