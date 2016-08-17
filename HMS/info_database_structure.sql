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




---- hotel logs.dictionary
-- fix values in procedures so they point to correct ones
SELECT *
FROM dbo.PropertyRatePlan
WHERE RatePlanCode IN ('1P','2U','3A','92','AGD','ATMN','BAR','BARG','BARNR','BARNRG','BARW','BOOK','BRFN','CGCN','CGRN','CNG','CNGRSS','COMP','COST','D2','DE','EATN','EB','ECLUB','EE','FF','FI','FX','GGV','GMM','GOT','GTTN','HENN','HONN','HRS','HRSC','JUNK','LON','LOVE','LOY','LS','LU','MS14','MS14R','MS7','MS7R','PEYN','PKG','PWSN','QOT0','RACK','RRBW','SCG','SD10','SD15','SD20','SD25','SD30','SD35','SD40','SD45','SD50','SPG','TRAVCO','TTG','TTGAT','TTGBE','TTGCN','TTGCZ','TTGDE','TTGES','TTGFI','TTGFR','TTGIN','TTGIR','TTGIT','TTGJP','TTGKR','TTGNL','TTGRS','TTGSE','VR','WD50','WHL','WHLA','WS','X2','XN','XW','XZ','Z10','ZL','2P','9I','9Q','ABBN','AC','AE','BBSN','BW','DXXN','EC1','EC3','EC5','EC9','ECE','ECF','EX1','EX5','EXE','EXF','HK','HP','HY','ISNN','LP1','NOSN','RP','UC','UZ','VAHN','VO','VOLH','W')

SELECT * FROM RoomType
WHERE RoomTypeCode IN ('APKN','DXQS','DXTS','JSQS','JSTS','RSSQ','SRQS','SRTS','STQS','STTS','SUQS')



SELECT * 
from[dbo].[R5DESCRIPTIONS]
--WHERE DES_TYPE = 'SOURCE' --DES_CODE = 'CALL'
WHERE DES_CODE IN ('ADV','BW','CFM','CMR','EFM','EMAIL','FAX','FD','IDS','LBM','MFM','TEL','VSP','WI','WR')
AND DES_TYPE = 'SOURCE'

