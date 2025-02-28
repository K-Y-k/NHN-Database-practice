-- 테이블 데이터 세팅

-- DB 생성
CREATE DATABASE Module06
GO

-- refresh 후 DB 전환
USE Module06
GO
-- 현재 연결된 DB 확인
SELECT db_name();

CREATE TABLE Passenger (
    PassengerNo	int,
    PassengerName nvarchar(10)    NOT NULL,
    Grade 	int CHECK (Grade >= 1 AND Grade <= 10) default 1,
    Age     int     NULL

    CONSTRAINT pk_Passenger PRIMARY KEY(PassengerNo)
);

-- 현재 ??로 나와서 N 접두사를 사용하여 유니코드 문자열을 처리
INSERT INTO Passenger VALUES(1, N'홍길동', 7, 44);
INSERT INTO Passenger (PassengerNo, PassengerName, Age) VALUES (2, N'이순신', 44);
INSERT INTO Passenger (PassengerNo, PassengerName, Grade) VALUES(3, N'안중근', 7);
INSERT INTO Passenger VALUES(4, N'김영랑', 9, 54);
INSERT INTO Passenger VALUES (5, N'김소월',9, 45);
INSERT INTO Passenger VALUES (6, N'윤동주', 10, 26);
INSERT INTO Passenger VALUES (7, N'천상병', 8, 55);
SELECT * FROM Passenger;


-- 중복된 기본키 값으로 실패
INSERT INTO Passenger VALUES (4, N'김소월',9, 45);
-- NAME은 NOT NULL이라 실패
INSERT INTO Passenger (PassengerNo, Grade, Age) VALUES (3, 7, 40);


CREATE TABLE Aircraft (
    AircraftNo int,
    KindOfAircraft varchar(20),
    Airline nvarchar(10)
);

-- 일반 제약조건 설정
ALTER TABLE Aircraft ALTER COLUMN AircraftNo int NOT NULL;
ALTER TABLE Aircraft ALTER COLUMN KindOfAircraft varchar(20) NOT NULL;
-- 기본 키 제약조건 설정
ALTER TABLE Aircraft ADD CONSTRAINT pk_Aircraft PRIMARY KEY(AircraftNo);

-- 테이블 전체 정보 확인
SELECT * 
FROM information_schema.TABLES 
WHERE table_type = 'BASE TABLE'

-- 해당 테이블의 상세 정보 확인
SELECT column_name, data_type, CHARACTER_MAXIMUM_LENGTH, is_nullable  
FROM information_schema.COLUMNS 
WHERE table_name = 'Aircraft'

-- 해당 테이블의 키 제약조건 정보 확인
SELECT constraint_name, constraint_type 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE table_name = 'Aircraft'

INSERT INTO Aircraft VALUES (101, 'Boeing 747', N'대한항공');
INSERT INTO Aircraft VALUES (102, 'Boeing 727', N'대한항공');
INSERT INTO Aircraft VALUES (103, 'Airbus A380', N'아시아나 항공');
INSERT INTO Aircraft VALUES (104, 'Airbus A300', N'대한항공');
INSERT INTO Aircraft VALUES (105, 'Boeing 737-800', N'제주항공');

SELECT * FROM Aircraft;


CREATE TABLE Flight (
    FlightNo int,
    AircraftNo int,
    Deparetures nvarchar(10) NOT NULL,
    Arrival nvarchar(10) NOT NULL,
    Price money DEFAULT 0,
    FlightDate datetime NOT NULL,

    CONSTRAINT pk_Flight PRIMARY KEY(FlightNo),
    CONSTRAINT fk_Flight_Aircraft FOREIGN KEY(AircraftNo) REFERENCES Aircraft(AircraftNo)
);

SELECT * FROM information_schema.TABLES 
WHERE table_type = 'BASE TABLE'

SELECT column_name, data_type, CHARACTER_MAXIMUM_LENGTH, is_nullable 
FROM information_schema.COLUMNS 
WHERE table_name = 'Flight'

SELECT constraint_name, constraint_type 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE table_name = 'Flight'

INSERT INTO Flight VALUES(1, 101, N'인천', N'샌프란시스코', 1230000, '2022-10-23 10:20');
INSERT INTO Flight VALUES(2, 101, N'샌프란시스코', N'인천', 1320000, '2022-10-26 13:00');
INSERT INTO Flight VALUES(3, 105, N'김포', N'제주', 72000, '2022-11-23 09:00');
INSERT INTO Flight VALUES(4, 105, N'김포', N'김해', 68000, '2022-11-12 17:30');
INSERT INTO Flight VALUES(5, 103, N'인천', N'프랑크푸르트', 1480000, '2022-12-01 18:00');
INSERT INTO Flight VALUES(6, 103, N'프랑크푸르트', N'인천', 1560000, '2022-12-10 10:00');
INSERT INTO Flight VALUES(7, 104, N'김해', N'김포', 70000, '2022-11-13 11:00');
INSERT INTO Flight VALUES(8, 101, N'인천', N'샌프란시스코', 1230000, '2022-11-15 10:00');

SELECT * FROM Flight;

-- 항공기 번호가 106인 데이터가 존재하지 않으므로, 참조 무결성을 위반하여 실패
INSERT INTO Flight VALUES(2, 106, N'샌프란시스코', N'인천', 1320000, '2022-10-26 13:00');


CREATE TABLE Reservation (
    PassengerNo int,
    FlightNo int,
    ReservedDate datetime NOT NULL
);
-- 일반 제약조건 설정
ALTER TABLE Reservation ALTER COLUMN PassengerNo int NOT NULL
GO
ALTER TABLE Reservation ALTER COLUMN FlightNo int NOT NULL
GO
-- 기본 키 제약조건 설정
ALTER TABLE Reservation ADD CONSTRAINT pk_Reservation PRIMARY KEY(PassengerNo, FlightNo)
GO
-- 외래 키 제약조건 설정
ALTER TABLE Reservation ADD CONSTRAINT fk_reservation_passenger FOREIGN KEY(PassengerNo) 
REFERENCES Passenger(PassengerNo);
ALTER TABLE Reservation ADD CONSTRAINT fk_reservation_flight FOREIGN KEY(FlightNo) 
REFERENCES Flight(FlightNo);

SELECT * 
FROM information_schema.TABLES 
WHERE table_type = 'BASE TABLE'

SELECT column_name, data_type, CHARACTER_MAXIMUM_LENGTH, is_nullable 
FROM information_schema.COLUMNS 
WHERE table_name = 'Reservation'

SELECT constraint_name, constraint_type 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE table_name = 'Reservation'

INSERT INTO Reservation VALUES (1, 4, '2022-10-22');
INSERT INTO Reservation VALUES (3, 1, '2022-10-20');
INSERT INTO Reservation VALUES (4, 7, '2022-10-11');
INSERT INTO Reservation VALUES (6, 7, '2022-10-21');
INSERT INTO Reservation VALUES (2, 1, '2022-10-11');
INSERT INTO Reservation VALUES (2, 2, '2022-10-11');
INSERT INTO Reservation VALUES (7, 3, '2022-09-11');
INSERT INTO Reservation VALUES (1, 3, '2022-11-09');

SELECT * FROM Reservation;

-- Mssql 전용 변환 함수
SELECT CONVERT(varchar(10), FlightDate, 103)
FROM Flight;


-- SQL Server에서 변수를 선언
DECLARE @id int
-- 변수에 값을 할당
SET @id = 4
-- 8
SELECT @id + 4
-- PassengerNo가 4인 데이터
SELECT PassengerNo, PassengerName, Age
FROM Passenger
WHERE PassengerNo = @id

-- 현재 시간 조회
SELECT getDate();

-- 합산 함수
SELECT SUM(AGE)
FROM Passenger;

-- AS로 별칭이 가능하고 Mssql은 별칭을 한글로 사용하고 싶으면 []로 씌워준다
-- Mssql은 Natural Join이 없다.
SELECT P.Age +10 AS [나이]
FROM Passenger AS p 
INNER JOIN Reservation AS r
ON p.PassengerNo = r.PassengerNo

-- 보통 동등 조인(INNER JOIN)을 사용한다.
-- 연속으로 조인하는 방식
SELECT *
FROM Aircraft AS A
-- 처음 진행하는 조인
INNER JOIN Flight AS F ON A.AircraftNo = F.AircraftNo
-- 두번째 조인
INNER JOIN Reservation AS R ON F.FlightNo = R.FlightNo
-- 세번째 조인
INNER JOIN Passenger AS P ON R.PassengerNo = P.PassengerNo
WHERE A.Airline = '대한항공'

-- Union 합집합
SELECT DISTINCT A.AircraftNo, A.Airline FROM
(SELECT * FROM Flight WHERE Deparetures=N'인천'
 UNION
 SELECT * FROM Flight WHERE Arrival=N'제주') AS tempFlight
INNER JOIN Aircraft AS A ON tempFlight.AircraftNo = A.AircraftNo;


-- INTERSECT 교집합
-- 두 쿼리의 실행 계획을 비교해 보면 
-- 두번째 쿼리가 좀 더 효율적이다.
SELECT DISTINCT PassengerName, Age FROM
(SELECT * FROM Flight WHERE Deparetures = '김포'
INTERSECT
SELECT * FROM Flight WHERE Arrival = '제주') AS tempFlight
INNER JOIN Reservation AS R ON tempFlight.FlightNo = R.FlightNo
INNER JOIN Passenger AS P ON R.PassengerNo = P.PassengerNo;

SELECT PassengerName, Age
FROM Passenger INNER JOIN Reservation ON Passenger.PassengerNo = Reservation.PassengerNo
INNER JOIN Flight ON Reservation.FlightNo = Flight.FlightNo
INNER JOIN Aircraft ON Flight.AircraftNo = Aircraft.AircraftNo
WHERE Flight.Deparetures = '김포' AND Flight.Arrival = '제주';


-- 항공사 합병 예시
-- 기존 테이블을 마이그레이션 해야함
CREATE TABLE Airline (
	AirlineNo int,
    Airline nvarchar(10)
    
    CONSTRAINT pk_Airline PRIMARY KEY(Airline)
)
INSERT INTO Airline VALUES(1, N'대한항공'), (2, N'아시아나항공'), (3, N'제주항공')

ALTER TABLE Aircraft ADD AirlineNo int