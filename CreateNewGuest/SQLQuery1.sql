USE hotel
SELECT *
FROM guest
WHERE account = 104196

SELECT *
FROM dbo.guest_names
WHERE account = 104196

SELECT DISTINCT status
FROM guest

SELECT  OBJECT_NAME(object_id) AS tablename ,
        *
FROM    sys.columns
WHERE   name LIKE '%status%';

-- 603416
SELECT  *
FROM dbo.guest g
INNER JOIN dbo.guest_names gn ON g.account = gn.account AND gn.preferred_name = 'Y'

SELECT ISNULL(MAX(id), '19000101')
FROM logs.test

SELECT sex
FROM dbo.guest_names