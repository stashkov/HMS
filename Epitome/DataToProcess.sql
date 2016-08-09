
SELECT TOP 50
        g.account ,
        g.source AS SourceOfBusiness ,
        g.property AS Property ,
        g.arrival AS CheckIn ,
        g.departure AS CheckOut ,
        g.room_type ,
        g.rate_code ,
        g.marketseg AS MarketingSegment ,
        g.room AS RoomNumber ,
        g.status ,
        g.cxl_code AS cancelcode ,
        g.gtd AS GuaranteeTypem,
		d1.HMSCode AS RoomType,
		d.HMSCode AS SourceOfBusinessk,
		d2.HMSCode
FROM    dbo.guest g
        INNER JOIN logs.clients c ON g.account = c.account_epitome
		INNER JOIN logs.dictionary d ON d.EpitomeCode = g.source AND d.Type = N'SourceOfBusiness'
		INNER JOIN logs.dictionary d1 ON d1.EpitomeCode = g.room_type AND d1.Type = N'RoomType'
		INNER JOIN logs.dictionary d2 ON d2.EpitomeCode = g.marketseg AND d2.Type = N'MarketingSegment'
WHERE   g.status <> 'P'
        AND g.status <> 'C'
        AND g.status <> 'N'
		AND g.status <> 'W'
        --AND g.room IS NOT NULL
        AND g.cxl_code IS NULL --exclude cancelled 
ORDER BY CheckIn DESC;



SELECT *
FROM logs.dictionary

