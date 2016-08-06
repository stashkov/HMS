--SELECT *
--FROM p5reservationlist



--SELECT *
--FROM dbo.NameInfo
--WHERE ProfileID = 47

--SELECT *
--FROM dbo.GuestNameInfo
--WHERE GuestNameInfoID = 63

--SELECT *
--FROM dbo.ReservationStay
--WHERE ProfileID = 47

--SELECT *
--FROM dbo.P5ACCOUNT
--WHERE ACC_ACCOUNT = ACC_SQLIDENTITY
--ORDER BY ACC_UPDATED DESC


SELECT  *
FROM    ReservationStay rs
        INNER JOIN Reservation r ON r.ReservationID = rs.ReservationID
        INNER JOIN ReservationStayDate rsd ON rs.ReservationStayID = rsd.ReservationStayID
        INNER JOIN Profile g ON rs.ProfileID = g.ProfileID
        INNER JOIN Channel c ON r.ChannelCode = c.ChannelCode
        INNER JOIN Property p ON p.PropertyCode = r.PropertyCode
        INNER JOIN P5ACCOUNT ON ACC_ACCOUNTID = rs.ReservationStayID
                                AND ACC_PROPERTY = r.PropertyCode
                                AND ACC_ACCOUNTTYPE = 'GUEST'
        LEFT OUTER JOIN GuestNameInfo ni ON ni.ReservationStayID = rs.ReservationStayID
        LEFT OUTER JOIN CodeValue cv ON cv.CodeTypeValue = 'VIP'
                                        AND cv.CodeValue = g.VIPStatusCode
                                        AND g.CustomerID = cv.CustomerID
        LEFT OUTER JOIN P5TAXEXEMPTDEFEXTENDED ON TDE_TAXSTATUSCODE = rs.TaxExempt
                                                  AND TDE_PROPERTY = r.PropertyCode
        LEFT OUTER JOIN PhoneNumber ph ON ph.PhoneNumberID = rs.PhoneNumberID
        LEFT OUTER JOIN PhoneNumber pm ON pm.ProfileID = g.ProfileID
                                          AND pm.PhoneNumberTypeCode = 'MOBILE'
        LEFT OUTER JOIN EmailAddress em ON em.EmailAddressID = rs.EmailAddressID
        LEFT OUTER JOIN PostalAddress ad ON ad.PostalAddressID = rs.PostalAddressID
        LEFT OUTER JOIN Rewards rw ON rw.RewardsID = rs.RewardsID
        LEFT OUTER JOIN ( Rewards rwl
                          INNER JOIN CodeValue cvl ON cvl.CodeValue = rwl.ProgramType
                                                      AND cvl.CodeTypeValue = 'LOYALT'
                        ) ON rwl.ProfileID = g.ProfileID
                             AND rwl.ActiveFlag = 1
        LEFT OUTER JOIN Organization o ON o.OrganizationID = rs.OrganizationID
        LEFT OUTER JOIN PropGroupBooking gb ON gb.PropGroupBookingID = rs.PropGroupBookingID
        LEFT OUTER JOIN TravelAgency ta1 ON ta1.TravelAgencyID = rs.TAProfileID
        LEFT OUTER JOIN TravelAgency ta2 ON ta2.TravelAgencyID = rs.TAProfileID2
        LEFT OUTER JOIN TravelAgency ta3 ON ta3.TravelAgencyID = rs.TAProfileID3
        LEFT OUTER JOIN BookingAgencyContract bac ON bac.BookingAgencyContractID = rs.BookingAgencyContractID
        LEFT OUTER JOIN RatePlan rp ON rsd.RatePlanCode = rp.RatePlanCode
        INNER JOIN RoomType rt ON rt.RoomTypeID = rsd.RoomTypeID
        LEFT OUTER JOIN CreditCard cc ON cc.CreditCardID = r.CreditCardID
        LEFT OUTER JOIN CreditCard cc2 ON cc2.CreditCardID = rs.SettledByCreditCardID
        LEFT OUTER JOIN GuaranteeMethod gm ON gm.GuaranteeMethodCode = r.GuaranteeCode
                                              AND gm.CustomerID = g.CustomerID
        LEFT OUTER JOIN ReservationDeposit rd ON rd.ReservationID = r.ReservationID
        LEFT OUTER JOIN P5RESERVATIONSTAY ON RSY_RESERVATIONSTAYID = rs.ReservationStayID
        LEFT OUTER JOIN P5ROOM rm ON rm.ROO_CODE = RSY_CURRENTROOMCODE
                                     AND rm.ROO_PROPERTYCODE = r.PropertyCode
        LEFT OUTER JOIN P5ROOM rmsched ON rmsched.ROO_ROOMID = rsd.RoomID
                                          AND rmsched.ROO_PROPERTYCODE = r.PropertyCode
        LEFT OUTER JOIN RoomType crt ON crt.RoomTypeID = rm.ROO_ROOMTYPEID
                                        AND rm.ROO_PROPERTYCODE = crt.PropertyCode
        LEFT OUTER JOIN GuestStayStatistics stat ON stat.ProfileID = g.ProfileID
                                                    AND stat.PropertyCode = r.PropertyCode
                                                    AND stat.IsActualRecord = 1
        LEFT OUTER JOIN AR_Account ar ON ar.AccountNumber = rs.DirectBillAccount
                                         AND ar.PropertyCode = r.PropertyCode
                                         AND EXISTS ( SELECT  1
                                                      FROM    P5ARACCOUNTPROFILE
                                                      WHERE   ar.ARProfileID = ARP_PROFILEID )
--WHERE rs.PMSConfirmationNumber = '86434400-1'