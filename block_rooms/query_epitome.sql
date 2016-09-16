USE hotel
GO

SELECT *
FROM dbo.outoforder o
WHERE o.status IN ('C', 'D', 'A') -- ignore 'M'
-- Process: Active -> (optionally Cancelled) -> Done
AND ISNUMERIC(o.room) = 1 -- ignores corridors, elevators
ORDER BY o.to_date DESC


