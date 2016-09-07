USE hotel;

TRUNCATE TABLE logs.dictionary;
GO

--Status
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'Status', N'O', N'CheckedOut' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'Status', N'C', N'Cancelled' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'Status', N'R', N'Reserved' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'Status', N'N', N'Cancelled' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'Status', N'I', N'CheckedIn' );

--RoomType
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'APKN', N'APKN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'DXQS', N'DXQS' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'DXTS', N'DXTS' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'JSQS', N'JSQS' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'JSTS', N'JSTS' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'RSSQ', N'RSSQ' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'SRQS', N'SRQS' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'SRTS', N'SRTS' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'STQS', N'STQS' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'STTS', N'STTS' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RoomType', N'SUQS', N'SUQS' );

--RateCode
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'1P', N'1P' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'2U', N'2U' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'3A', N'3A' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'92', N'92' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'AGD', N'AGD' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ATMN', N'ATMN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BAR', N'BAR' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BARG', N'BARG' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BARNR', N'BARNR' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BARNRG', N'BARNRG' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BARW', N'BARW' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BOOK', N'BOOK' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BRFN', N'BRFN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'CGCN', N'CGCN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'CGRN', N'CGRN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'CNG', N'CNG' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'CNGRSS', N'CNGRSS' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'COMP', N'COMP' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'COST', N'COST' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'D2', N'D2' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'DE', N'DE' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EATN', N'EATN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EB', N'EB' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ECLUB', N'ECLUB' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EE', N'EE' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'FF', N'FF' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'FI', N'FI' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'FX', N'FX' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'GGV', N'GGV' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'GMM', N'GMM' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'GOT', N'GOT' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'GTTN', N'GTTN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HENN', N'HENN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HONN', N'HONN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HRS', N'HRS' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HRSC', N'HRSC' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'JUNK', N'JUNK' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'LON', N'LON' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'LOVE', N'LOVE' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'LOY', N'LOY' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'LS', N'LS' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'LU', N'LU' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'MS14', N'MS14' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'MS14R', N'MS14R' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'MS7', N'MS7' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'MS7R', N'MS7R' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'PEYN', N'PEYN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'PKG', N'PKG' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'PWSN', N'PWSN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'QOT0', N'QOT0' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'RACK', N'RACK' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'RRBW', N'RRBW' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SCG', N'SCG' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD10', N'SD10' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD15', N'SD15' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD20', N'SD20' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD25', N'SD25' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD30', N'SD30' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD35', N'SD35' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD40', N'SD40' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD45', N'SD45' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SD50', N'SD50' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'SPG', N'SPG' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TRAVCO', N'TRAVCO' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTG', N'TTG' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGAT', N'TTGAT' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGBE', N'TTGBE' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGCN', N'TTGCN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGCZ', N'TTGCZ' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGDE', N'TTGDE' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGES', N'TTGES' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGFI', N'TTGFI' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGFR', N'TTGFR' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGIN', N'TTGIN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGIR', N'TTGIR' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGIT', N'TTGIT' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGJP', N'TTGJP' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGKR', N'TTGKR' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGNL', N'TTGNL' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGRS', N'TTGRS' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'TTGSE', N'TTGSE' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'VR', N'VR' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'WD50', N'WD50' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'WHL', N'WHL' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'WHLA', N'WHLA' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'WS', N'WS' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'X2', N'X2' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'XN', N'XN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'XW', N'XW' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'XZ', N'XZ' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'Z10', N'Z10' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ZL', N'ZL' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'2P', N'2P' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'9I', N'9I' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'9Q', N'9Q' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ABBN', N'ABBN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'AC', N'AC' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'AE', N'AE' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BBSN', N'BBSN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'BW', N'BW' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'DXXN', N'DXXN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EC1', N'EC1' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EC3', N'EC3' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EC5', N'EC5' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EC9', N'EC9' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ECE', N'ECE' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ECF', N'ECF' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EX1', N'EX1' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EX5', N'EX5' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EXE', N'EXE' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'EXF', N'EXF' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HK', N'HK' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HP', N'HP' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'HY', N'HY' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'ISNN', N'ISNN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'LP1', N'LP1' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'NOSN', N'NOSN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'RP', N'RP' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'UC', N'UC' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'UZ', N'UZ' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'VAHN', N'VAHN' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'VO', N'VO' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'VOLH', N'VOLH' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'RateCode', N'W', N'W' );

--Guarantee Type
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'AMEX' ,
          N'AMEX'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'CASH' ,
          N'CASH'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'CC' ,
          N'CC'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'DB' ,
          N'DB'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'DIN' ,
          N'DIN'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'MNGR' ,
          N'MNGR'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'UN' ,
          N'UN'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'VISA' ,
          N'VISA'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'GuaranteeType' ,
          N'MC' ,
          N'MC'
        );
--SourceOfBusiness
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'ADV' ,
          N'ADV'
        );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'SourceOfBusiness', N'BW', N'BW' );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'CFM' ,
          N'CFM'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'CMR' ,
          N'CMR'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'EFM' ,
          N'EFM'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'EMAIL' ,
          N'EMAIL'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'FAX' ,
          N'FAX'
        );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'SourceOfBusiness', N'FD', N'FD' );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'IDS' ,
          N'IDS'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'LBM' ,
          N'LBM'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'MFM' ,
          N'MFM'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'TEL' ,
          N'TEL'
        );
INSERT  INTO logs.dictionary
        ( Type ,
          EpitomeCode ,
          HMSCode
        )
VALUES  ( N'SourceOfBusiness' ,
          N'VSP' ,
          N'VSP'
        );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'SourceOfBusiness', N'WI', N'WI' );
INSERT  INTO logs.dictionary
        ( Type, EpitomeCode, HMSCode )
VALUES  ( N'SourceOfBusiness', N'WR', N'WR' );
