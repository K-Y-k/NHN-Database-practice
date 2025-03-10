-- 샘플 데이터 추가
-- 고객 도메인
INSERT INTO Customer (CustomerID, CustomerName, Email, PhoneNumber, RegistrationDate, RegisterType, CustomerType)
VALUES 
(1, 'Kyk', 'kyk@naver.com', '010-1111-2222', '2023-03-01 10:00:00', 'Regular', '개인'),
(2, 'Celine', 'celine@gmail.com', '02-1111-2222', '2023-03-02 11:00:00', 'Social', '법인');

INSERT INTO Identification (CustomerID, RegisterNum, PassportNum)
VALUES 
(1, '123456-7890123', 'P1234567'),
(2, '123456-1235687', 'B987654321');

INSERT INTO PreferredFlight (CustomerID, PreferredDepartureLocation, PreferredArrivalLocation)
VALUES 
(1, '서울', '뉴욕'),
(2, '부산', '도쿄');

INSERT INTO IndividualCustomer (CustomerID, Gender, Address, Birth)
VALUES 
(1, '남', '대전광역시 유성구 어은로 57번길', '1985-06-15'),
(2, '여', '456 Elm St, London, UK', '1990-08-22');

INSERT INTO RegularUser (CustomerID, LoginID, Passwor, CreateDate)
VALUES (1, 'kyk_regular', 'kykPwd', '2023-03-01');

INSERT INTO SocialUser (CustomerID, LoginID, Passwor, SocialType, CreateDate)
VALUES (2, 'celine_social', 'celinePwd', 'Google', '2023-03-01');

INSERT INTO CorporateCustomer (CustomerID, CorporateName, BusinessNumber, CorporateAddress, ContactPersonName, ContactPhoneNum)
VALUES (2, 'Celine Corporation', 'B123456789', '대전광역시 유성구 어은로57번길', 'Smith', '02-9876-5432');

INSERT INTO CorporateEmployee (EmployeeID, CustomerID, Position)
VALUES (1, 2, '매니저');

INSERT INTO CorporateBenefit (BenefitID, CustomerID, BenefitType, ValidStart, ValidEnd)
VALUES (1, 2, '할인', '2023-01-01', '2023-12-31');


-- 예약/승객 도메인
INSERT INTO Pnr (PnrID, CustomerID, ReservationCode, ReservationDate, PaxCount, ReservationState)
VALUES 
(1, 1, 'ABC123', '2023-03-05', 2, '예약완료'), 
(2, 1, 'EFG456', '2023-04-01', 1, '예약완료');

INSERT INTO Pax (PaxID, PnrID, CustomerID, Name, Age, PhoneNum)
VALUES 
(1, 1, 1, 'kyk', 28, '010-1111-2222'),
(2, 1, 2, 'celine', 35, '010-3333-4444'),
(3, 2, 1, 'kyk', 28, '010-1111-2222');

INSERT INTO Seg (SegID, PnrID, TicketID, CustomerID, FlightNum, DepartureLocation, ArrivalLocation, DepartureTime, ArrivalTime, BoardingArea)
VALUES 
(1, 1, 1, 1, 100, '서울', '뉴욕', '2023-03-10', '2023-03-11', 'A'),
(2, 2, 2, 1, 200, '서울', '싸이판', '2023-04-10', '2023-04-11', 'B'),
(3, 2, 3, 1, 201, '싸이판', '서울', '2023-04-20', '2023-04-21', 'B'),
(4, 2, 2, 3, 101, '서울', '싸이판', '2025-04-10 09:00:00', '2025-04-10 12:00:00', 'A');
 
INSERT INTO Ssr (SsrID, SegID, PaxID, CustomerID, SsrType, RequestDetail, RequestStatus)
VALUES (1, 1, 1, 1, '식사', '비빔밥', '보류중');

INSERT INTO Coupon (CouponID, SegID, CustomerID, CouponCode, DiscountAmount, isApplied, ExpireDate)
VALUES (1, 1, 1, 'COUPON-1234', 10000, TRUE, '2023-12-31');


-- 발권/결제 도메인
INSERT INTO Ticket (TicketID, CreatedDate)
VALUES 
(1, '2023-03-05'), 
(2, '2023-04-01'), 
(3, '2023-04-01');

INSERT INTO Fare (FareID, TicketID, Price, FareType)
VALUES 
(1, 1, 500, 'Economy'), 
(2, 2, 700, 'RoundTrip'),
(3, 3, 700, 'RoundTrip');

INSERT INTO Tax (TaxID, TicketID, TaxType, TaxAmount)
VALUES 
(1, 1, '공항세', 500),
(2, 2, '공항세', 700),
(3, 3, '공항세', 700);

INSERT INTO PaymentMethod (PaymentMethodID, TicketID, PaymentMethodType, Price)
VALUES 
(1, 1, '신용카드', 55000), 
(2, 2, '신용카드', 77000), 
(3, 3, '신용카드', 77000);

INSERT INTO Refund (RefundID, TicketID, RefundAmount, RefundState, RefundDate)
VALUES (1, 1, 100, '진행중', '2023-03-06');

INSERT INTO RefundFare (RefundFareID, RefundID, FareAmount)
VALUES (1, 1, 500);

INSERT INTO RefundTax (RefundTaxID, RefundID, TaxType, TaxAmount)
VALUES (1, 1, '공항세', 500);

INSERT INTO RefundMethod (RefundMethodID, RefundID, PaymentMethodType)
VALUES (1, 1, '신용카드');


-- 상품 도메인
INSERT INTO Product (ProductID, ProductName, ProductType, Price, CreatedDate)
VALUES 
(1, '항공권', '항공권', 50000, '2023-03-01'),
(2, '추가 수하물', '부가서비스', 15000, '2023-03-01');

INSERT INTO AirTicket (AirTicketID, ProductID, DeparatureLocation, ArrivalLocation, DeparatureDate, ArrivalDate)
VALUES (1, 1, '서울', '뉴욕', '2023-03-10', '2023-03-15');

INSERT INTO AdditionalService (ServiceID, ProductID, ServiceName, ServiceType, Price)
VALUES (1, 2, '추가 수하물 서비스', '수하물', 15000);

INSERT INTO Accessory (AccessoryID, ProductID, AccessoryName, Price)
VALUES (1, 1, '여행용 배게', 5000);

INSERT INTO AffiliateProduct (AffiliateProductID, ProductID, AffiliateProductName, AffiliatePartner, Price)
VALUES (1, 1, '제휴 항공권', '파트너A', 48000);

INSERT INTO BundleProduct (BundleProductID, ProductID, BundleName, Price)
VALUES (1, 1, '결합항공권', 50000);

INSERT INTO BundleProductDetail (BundleProductID, ProductID, Quantity)
VALUES (1, 1, 1);


-- 운항/예약 도메인
INSERT INTO Airline (AirlineID, AirlineInfo)
VALUES 
(1, '대한항공'),
(2, '아시아나항공'),
(3, '제주항공');

INSERT INTO FlightPlan (PlanID, AirlineID, ProductID, SaleDate, SeasonClassificationCode)
VALUES 
(1, 1, 1, '2023-02-28', '여름'),
(2, 3, 1, '2025-04-10', '봄');

INSERT INTO Airport (AirportID, AirportName, AirportLocation)
VALUES 
(1, '인천국제공항', '인천'),
(2, '케네디국제공항', '뉴욕'),
(3, '인천국제공항', '서울'),
(4, '싸이판국제공항', '싸이판');

INSERT INTO AtcAdvisory (AtcID, PlanID, AirportID, AtcPlan)
VALUES (1, 1, 1, '계획A');

INSERT INTO FlightRoute (RouteID, PlanID, Route)
VALUES 
(1, 1, '서울 -> 뉴욕'),
(2, 2, '서울 -> 싸이판');

INSERT INTO DepartureArrival (departureArrivalID, routeID, departureAirportID, arrivalAirportID, departureTime, arrivalTime)
VALUES 
(1, 1, 1, 2, '2023-03-11 08:00:00', '2023-03-11 14:00:00'),
(2, 1, 1, 2, '2024-07-20 22:00:00', '2023-04-21 05:00:00'),
(3, 2, 3, 4, '2025-04-10 09:00:00', '2025-04-10 12:00:00');


-- 승무원 도메인
INSERT INTO Crew (CrewID, CrewInfo)
VALUES (1, 'Pilot - abc');

INSERT INTO CrewFlightPlan (CrewPlanID, FlightPlan)
VALUES (1, '계획A');

INSERT INTO CrewAssignment (PlanID, CrewID, CrewPlanID)
VALUES (1, 1, 1);


-- 문제에서 주어진 사용자 시나리오
-- 1.회원가입
INSERT INTO Customer (CustomerID, CustomerName, Email, PhoneNumber, RegistrationDate, RegisterType, CustomerType)
VALUES 
(3, '홍길동', 'hongildong@naver.com', '010-1111-2222', '2025-03-10 10:00:00', 'Regular', '개인');

INSERT INTO Identification (CustomerID, RegisterNum, PassportNum)
VALUES 
(3, '123456-7890123', 'P1234567');

INSERT INTO PreferredFlight (CustomerID, PreferredDepartureLocation, PreferredArrivalLocation)
VALUES 
(3, '서울', '싸이판');

INSERT INTO IndividualCustomer (CustomerID, Gender, Address, Birth)
VALUES 
(3, '남', '대전광역시 유성구 어은로 57번길', '1995-04-20');

INSERT INTO RegularUser (CustomerID, LoginID, Passwor, CreateDate)
VALUES (3, 'gildongID', 'gildongPwd', '2025-03-10 10:00:00');

-- 2.서울 -> 싸이판 4월 15일 공항 편도 조회 및 선택
SELECT f.PlanID, f.SaleDate, fr.Route, 
       da.departureTime, da.arrivalTime, da.departureAirportID, da.arrivalAirportID
FROM FlightPlan f
JOIN FlightRoute fr ON f.PlanID = fr.PlanID
JOIN DepartureArrival da ON fr.RouteID = da.routeID
JOIN Airport dep_airport ON da.departureAirportID = dep_airport.AirportID
JOIN Airport arr_airport ON da.arrivalAirportID = arr_airport.AirportID
WHERE fr.Route = '서울 -> 싸이판'
AND f.SaleDate BETWEEN '2025-04-10' AND '2025-04-15'
AND da.departureTime BETWEEN '2025-04-10' AND '2025-04-15';

-- 3.승객, 예약내역, 부가서비스, 티켓, 운임, 세금정보, 결제수단에 저장
INSERT INTO Pnr (PnrID, CustomerID, ReservationCode, ReservationDate, PaxCount, ReservationState)
VALUES (3, 3, 'ABCD5678', '2025-03-15', 1, '예약완료');

INSERT INTO Pax (PaxID, PnrID, CustomerID, Name, Age, PhoneNum)
VALUES (4, 3, 3, '홍길동', 31, '010-1234-5678');

INSERT INTO AdditionalServiceReservation (ServiceReservationID, SegID, PaxID, CustomerID, ProductID, ServiceType, Price, ReservationDate)
VALUES (1, 4, 4, 3, 2, '수하물', 20000, '2025-03-15');

INSERT INTO Ticket (TicketID, CreatedDate)
VALUES (4, '2025-03-15');

INSERT INTO Fare (FareID, TicketID, Price, FareType)
VALUES (4, 4, 50000, '일반');

INSERT INTO Tax (TaxID, TicketID, TaxType, TaxAmount)
VALUES (4, 4, '부가세', 3000);

INSERT INTO PaymentMethod (PaymentMethodID, TicketID, PaymentMethodType, Price)
VALUES (4, 4, '카카오페이', 550000);


-- 기본 SELECT 쿼리들
SELECT * FROM Customer;
-- 고객과 식별 정보 조회
SELECT c.CustomerID, 
       c.CustomerName, 
       i.RegisterNum, 
       i.PassportNum, 
       ic.Birth
FROM Customer c
JOIN Identification i ON c.CustomerID = i.CustomerID
JOIN IndividualCustomer ic ON c.CustomerID = ic.CustomerID;

-- 고객 예약 내역 조회
SELECT p.PnrID,
       p.ReservationCode,
       p.ReservationDate,
       pax.Name AS PassengerName,
       pax.Age,
       seg.DepartureLocation,
       seg.ArrivalLocation,
       s.SsrType,
       s.RequestDetail,
       s.RequestStatus
FROM Pnr p
JOIN Pax pax ON p.PnrID = pax.PnrID
JOIN Seg seg ON p.PnrID = seg.PnrID
LEFT JOIN Ssr s ON pax.PaxID = s.PaxID;

-- 발권 관련 정보 조회
SELECT t.TicketID,
       t.CreatedDate,
       f.Price AS FarePrice,
       f.FareType,
       tax.TaxAmount,
       pm.PaymentMethodType,
       pm.Price AS PaymentPrice
FROM Ticket t
JOIN Fare f ON t.TicketID = f.TicketID
JOIN Tax tax ON t.TicketID = tax.TicketID
JOIN PaymentMethod pm ON t.TicketID = pm.TicketID;

-- 쿠폰 및 항공편 관련 정보 조회
SELECT cpn.CouponID,
       cpn.CouponCode,
       cpn.DiscountAmount,
       cpn.isApplied,
       cpn.ExpireDate,
       seg.DepartureLocation,
       seg.ArrivalLocation
FROM Coupon cpn
JOIN Seg seg ON cpn.SegID = seg.SegID;

-- 항공 운항 및 판매 채널 조회
SELECT fp.PlanID,
       fp.SaleDate,
       fp.SeasonClassificationCode,
       al.AirlineInfo,
       fr.Route
FROM FlightPlan fp
JOIN Airline al ON fp.AirlineID = al.AirlineID
JOIN FlightRoute fr ON fp.PlanID = fr.PlanID;