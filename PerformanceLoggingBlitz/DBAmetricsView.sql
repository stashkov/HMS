
USE DBAmetrics;

DECLARE @CheckDateStart NVARCHAR(50) = '20160809 13:40 00:00';
DECLARE @CheckDateEnd NVARCHAR(50) = DATEADD(MI, 10, CAST(@CheckDateStart AS DATETIMEOFFSET));

SELECT  wait_type ,
        SUM(d.wait_time_ms_delta / 60) AS wait_time_minutes ,
        SUM(d.waiting_tasks_count_delta) AS waiting_tasks
FROM    logs.BlitzFirst_WaitStats d
WHERE   d.CheckDate BETWEEN @CheckDateStart AND @CheckDateEnd
        AND d.ServerName = 'something'
GROUP BY d.wait_type
HAVING  SUM(d.waiting_tasks_count_delta) > 0
ORDER BY 2 DESC;