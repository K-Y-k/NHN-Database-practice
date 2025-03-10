-- DB 세팅
show databases;
CREATE DATABASE airport;
use airport;


-- 테이블 순차적으로 삭제
DROP TABLE AirTicket;
DROP TABLE AdditionalService;
DROP TABLE AffiliateProduct;
DROP TABLE Accessory;
DROP TABLE BundleProductDetail;
DROP TABLE BundleProduct;
DROP TABLE Product;

DROP TABLE RegularUser;
DROP TABLE SocialUser;
DROP TABLE CorporateEmployee;
DROP TABLE CorporateBenefit;
DROP TABLE IndividualCustomer;
DROP TABLE CorporateCustomer;
DROP TABLE Identification;
DROP TABLE PreferredFlight;
DROP TABLE Customer;


-- 고객 도메인
-- 고객 테이블
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    RegistrationDate DATETIME NOT NULL,
    RegisterType VARCHAR(30) NOT NULL,
	CustomerType VARCHAR(30) NOT NULL
);

-- 고객식별 테이블
CREATE TABLE Identification (
    CustomerID INT PRIMARY KEY,
    RegisterNum VARCHAR(50),
    PassportNum VARCHAR(50),
    
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 고객선호비행정보 테이블
CREATE TABLE PreferredFlight (
    CustomerID INT PRIMARY KEY,
    PreferredDepartureLocation VARCHAR(50) NOT NULL,
    PreferredArrivalLocation VARCHAR(50) NOT NULL,
    
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 개인고객 테이블
CREATE TABLE IndividualCustomer (
    CustomerID INT PRIMARY KEY,
    Gender VARCHAR(10) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Birth DATE NOT NULL,
    
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 정회원 테이블 : 웹사이트로 가입한 회원
CREATE TABLE RegularUser (
    CustomerID INT PRIMARY KEY,
    LoginID VARCHAR(20) NOT NULL,
    Passwor VARCHAR(20) NOT NULL,
    CreateDate DATE NOT NULL,
    
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 간편회원 테이블 : 소셜계정으로 가입한 회원
CREATE TABLE SocialUser (
    CustomerID INT PRIMARY KEY,
    LoginID VARCHAR(20) NOT NULL,
    Passwor VARCHAR(20) NOT NULL,
    SocialType VARCHAR(30) NOT NULL, 
    CreateDate DATE NOT NULL,
    
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 법인고객 테이블
CREATE TABLE CorporateCustomer (
    CustomerID INT PRIMARY KEY,
    CorporateName VARCHAR(100) NOT NULL,
    BusinessNumber VARCHAR(30),
    CorporateAddress VARCHAR(255),
    ContactPersonName VARCHAR(100),
    ContactPhoneNum VARCHAR(30),
    
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 법인고객직원 테이블
CREATE TABLE CorporateEmployee (
    EmployeeID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    Position VARCHAR(50) NOT NULL,
    
    FOREIGN KEY (CustomerID) REFERENCES CorporateCustomer(CustomerID)
);

-- 법인우대혜택 테이블
CREATE TABLE CorporateBenefit (
	BenefitID INT PRIMARY KEY,
    CustomerID INT,
    BenefitType VARCHAR(50),
    ValidStart DATE,
    ValidEnd DATE,
    
    FOREIGN KEY (CustomerID) REFERENCES CorporateCustomer(CustomerID)
);


-- 예약/승객 도메인
-- Pnr 테이블 : 승객예약정보
CREATE TABLE Pnr(
	PnrID INT PRIMARY KEY,
    CustomerID INT,
    ReservationCode VARCHAR(50),
    ReservationDate DATE,
    PaxCount INT,
    ReservationState VARCHAR(50),
    
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 승객 테이블
CREATE TABLE Pax(
	PaxID INT PRIMARY KEY,
    PnrID INT,
    CustomerID INT,
    Name VARCHAR(50),
    Age INT,
    PhoneNum VARCHAR(50),
    
    FOREIGN KEY (PnrID) REFERENCES Pnr(PnrID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 특별 서비스 요청 테이블
CREATE TABLE Ssr(
	SsrID INT PRIMARY KEY,
    SegID INT,
    PaxID INT,
    CustomerID INT,
    SsrType VARCHAR(50),
    RequestDetail VARCHAR(50),
    RequestStatus VARCHAR(50),
    
    FOREIGN KEY (PaxID) REFERENCES Pax(PaxID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 항공편 세그먼트 정보 테이블
CREATE TABLE Seg(
    SegID INT PRIMARY KEY,
    PnrID INT,
    TicketID INT,
    CustomerID INT,
    FlightNum INT,
    DepartureLocation VARCHAR(50),
    ArrivalLocation VARCHAR(50),
    DepartureTime date,
    ArrivalTime date,
    BoardingArea VARCHAR(50),
    
    FOREIGN KEY (PnrID) REFERENCES Pnr(PnrID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
ALTER TABLE Ssr ADD CONSTRAINT fk_SegID FOREIGN KEY (SegID) REFERENCES Seg(SegID);

-- 쿠폰 테이블
CREATE TABLE Coupon (
    CouponID INT PRIMARY KEY,
    SegID INT,
    CustomerID INT,
    CouponCode VARCHAR(50),
    DiscountAmount INT,
    isApplied boolean,
    ExpireDate date,
    
    FOREIGN KEY (SegID) REFERENCES Seg(SegID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- 티켓 테이블
CREATE TABLE Ticket(
    TicketID INT PRIMARY KEY,
    CreatedDate date
);

-- 운임 테이블
CREATE TABLE Fare(
    FareID INT PRIMARY KEY,
    TicketID INT,
    Price INT,
    FareType VARCHAR(50),
    
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
);

-- 세금 테이블
CREATE TABLE Tax(
    TaxID INT PRIMARY KEY,
    TicketID INT,
    TaxType VARCHAR(50),
    TaxAmount INT,
    
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
);

-- 결제수단 테이블
CREATE TABLE PaymentMethod(
    PaymentMethodID INT PRIMARY KEY,
    TicketID INT,
    PaymentMethodType VARCHAR(50),
    Price INT,
    
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
);

-- 환불 테이블
CREATE TABLE Refund(
    RefundID INT PRIMARY KEY,
    TicketID INT,
    RefundAmount INT,
    RefundState VARCHAR(50),
    RefundDate date,
    
    Foreign KEY (TicketID) REFERENCES Ticket(TicketID)
);

-- 환불운임 테이블
CREATE TABLE RefundFare(
    RefundFareID INT PRIMARY KEY,
    RefundID INT,
    FareAmount INT,
    
    FOREIGN KEY (RefundID) REFERENCES Refund(RefundID)
);

-- 환불세금 테이블
CREATE TABLE RefundTax(
	RefundTaxID INT PRIMARY KEY,
    RefundID INT,
    TaxType VARCHAR(50),
    TaxAmount INT,
    
    FOREIGN KEY (RefundID) REFERENCES Refund(RefundID)
);

-- 환불결제수단 테이블
CREATE TABLE RefundMethod(
    RefundMethodID int PRIMARY KEY,
    RefundID INT,
    PaymentMethodType VARCHAR(50),
    
    FOREIGN KEY (RefundID) REFERENCES Refund(RefundID)
);

-- 부가서비스예약내역 테이블
CREATE TABLE AdditionalServiceReservation (
    ServiceReservationID INT PRIMARY KEY,
    SegID INT,
    PaxID INT,
    CustomerID INT,
    ProductID INT,
    ServiceType VARCHAR(50),
    Price INT,
    ReservationDate DATE,
    
    FOREIGN KEY (SegID) REFERENCES Seg(SegID),
    FOREIGN KEY (PaxID) REFERENCES Pax(PaxID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


-- 상품 도메인
-- 상품 테이블 : 항공권 외에도 부가서비스, 제휴상품, 액세서리, 결합상품 등 다양한 상품을 포함하여 모든 종류의 상품에 대한 기본 정보를 관리하는 테이블
CREATE TABLE Product(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    ProductType VARCHAR(50),
    Price INT,
    CreatedDate DATE
);
ALTER TABLE AdditionalServiceReservation ADD CONSTRAINT fk_product_id FOREIGN KEY (ProductID) REFERENCES Product(ProductID);

-- 항공권 테이블 : 항공권에 관련된 상세 정보 테이블, ex) 운항스케줄, 운항일자별 LEG/SEG
CREATE TABLE AirTicket (
	AirTicketID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    DeparatureLocation VARCHAR(50) NOT NULL,
    ArrivalLocation VARCHAR(50) NOT NULL,    
    DeparatureDate DATE NOT NULL,
    ArrivalDate DATE NOT NULL,
    
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- 부가서비스 테이블 : 항공권에 추가되는 서비스 테이블, ex) 기내식, 추가 수하물, 좌석 선택 등
CREATE TABLE AdditionalService (
    ServiceID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    ServiceName VARCHAR(50) NOT NULL,
    ServiceType VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- 제휴상품 테이블 : 항공사나 여행사와의 제휴를 통해 제공되는 상품 테이블
CREATE TABLE AffiliateProduct (
    AffiliateProductID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    AffiliateProductName VARCHAR(50) NOT NULL,
    AffiliatePartner VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- 액세서리 테이블 : 항공권 구매와 관련된 부가적인 제품 테이블, ex) 여행 가방, 여행용 어댑터 등
CREATE TABLE Accessory (
    AccessoryID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    AccessoryName VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- 결합상품 테이블 : 여러 상품을 묶어서 제공되는 상품 테이블,  ex) 항공권 + 호텔 숙박 패키지 등을 포함
CREATE TABLE BundleProduct (
    BundleProductID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    BundleName VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
    
-- 결합상품구성상세 테이블 : 여러 개의 상품을 포함하고 있으므로, 결합상품을 구성하는 개별 상품들을 관리하는 테이블
CREATE TABLE BundleProductDetail (
	BundleProductID INT NOT NULL,
    ProductID INT NOT NULL,
	Quantity INT NOT NULL,
    
    PRIMARY KEY (BundleProductID, ProductID),
    FOREIGN KEY (BundleProductID) REFERENCES BundleProduct(BundleProductID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


-- 운항 도메인
-- 운항계획 테이블 : 운항계획에 따른 항공권으로 판매될 수 있음
CREATE TABLE FlightPlan(
    PlanID INT PRIMARY KEY,
    AirlineID INT,
    ProductID INT,
    SaleDate DATE,
    SeasonClassificationCode VARCHAR(50),
    
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- 공항 테이블
 CREATE TABLE Airport (
    AirportID INT PRIMARY KEY,
    AirportName VARCHAR(50),
    AirportLocation VARCHAR(50)
);

-- 권고사항 테이블
CREATE TABLE AtcAdvisory (
    AtcID INT PRIMARY KEY,
    PlanID INT,
    AirportID INT,
    AtcPlan VARCHAR(50),
    
    FOREIGN KEY (PlanID) REFERENCES FlightPlan(PlanID),
    FOREIGN KEY (AirportID) REFERENCES Airport(AirportID)
);
 
-- 승무원 테이블
CREATE TABLE Crew (
    CrewID INT PRIMARY KEY,
    CrewInfo VARCHAR(50)
);

-- 승무원편조 테이블
CREATE TABLE CrewFlightPlan(
    CrewPlanID INT PRIMARY KEY,
    FlightPlan VARCHAR(50)
);

-- 승무원비행계획 테이블
CREATE TABLE CrewAssignment (
    PlanID INT,
    CrewID INT,
    CrewPlanID INT,
    
    FOREIGN KEY (CrewID) REFERENCES Crew(CrewID),
    FOREIGN KEY (CrewPlanID) REFERENCES CrewFlightPlan(CrewPlanID)
);

-- 항공사 테이블
CREATE TABLE Airline(
    AirlineID INT PRIMARY KEY,
    AirlineInfo VARCHAR(50)
);
ALTER TABLE FlightPlan ADD CONSTRAINT fk_airline FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID);

-- 운항경로 테이블
CREATE TABLE FlightRoute(
    RouteID INT PRIMARY KEY,
    PlanID INT,
    Route VARCHAR(50),
    
    FOREIGN KEY (PlanID) REFERENCES FlightPlan(PlanID) 
);

-- 출도착 테이블
CREATE TABLE DepartureArrival (
  departureArrivalID INT PRIMARY KEY,
  routeID INT, 
  departureAirportID INT, 
  arrivalAirportID INT,
  departureTime date,
  arrivalTime date,
  
  FOREIGN KEY (routeID) REFERENCES FlightRoute(RouteID)
);