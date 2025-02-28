-- 테이블과 데이터 세팅
CREATE DATABASE Module06;

show databases;
USE Module06;
SELECT database();

CREATE TABLE Passenger (
	PassengerNo int,
    PassengerName nvarchar(10) NOT NULL,
    Grade int CHECK (Grade >= 1 AND Grade <= 10) DEFAULT 1,
    Age int NULL,
    CONSTRAINT pk_Passenger PRIMARY KEY(PassengerNo)
);
show tables;
desc Passenger;

INSERT INTO Passenger VALUES(1, '홍길동', 7, 44);
INSERT INTO Passenger(PassengerNo, PassengerName, Age) VALUES(2, '이순신', 44);
INSERT INTO Passenger (PassengerNo, PassengerName, Grade) VALUES(3, '안중근', 7);
INSERT INTO Passenger VALUES(4, '김영랑', 9, 54);
INSERT INTO Passenger VALUES (5, '김소월',9, 45);
INSERT INTO Passenger VALUES (6, '윤동주', 10, 26);
INSERT INTO Passenger VALUES (7, '천상병', 8, 55);

SELECT * FROM Passenger;

-- 중복된 키 값이라 실패
INSERT INTO Passenger VALUES (4, '김소월',9, 45);
-- Name이 Not NULL이라 실패
INSERT INTO Passenger (PassengerNo, Grade, Age) VALUES (3, 7, 40);


CREATE TABLE Aircraft (
	AircraftNo int,
    KindOfAircraft varchar(20),
    Airline varchar(10)
);
-- ALTER로 키 또는 일반 제약조건 설정법
ALTER TABLE Aircraft ADD CONSTRAINT pk_Aircraft PRIMARY KEY(AircraftNo);
ALTER TABLE Aircraft MODIFY COLUMN KindOfAircraft varchar(20) NOT NULL;

show tables;
desc Aircraft;

INSERT INTO Aircraft VALUES (101, 'Boeing 747', '대한항공');
INSERT INTO Aircraft VALUES (102, 'Boeing 727', '대한항공');
INSERT INTO Aircraft VALUES (103, 'Airbus A380', '아시아나 항공');
INSERT INTO Aircraft VALUES (104, 'Airbus A300', '대한항공');
INSERT INTO Aircraft VALUES (105, 'Boeing 737-800', '제주항공');

SELECT * FROM Aircraft;

CREATE TABLE Flight (
	FlightNo int,
    AircraftNo int,
    Deparetures nvarchar(10) NOT NULL,
    Arrival nvarchar(10) NOT NULL,
    Price int DEFAULT 0,
    FlightDate dateTime NOT NULl,
    CONSTRAINT pk_Flight PRIMARY KEY(FlightNo),
    CONSTRAINT fk_Flight_Aircraft FOREIGN KEY(AircraftNo) REFERENCES Aircraft(AircraftNo)
);
show tables;
desc Flight;

INSERT INTO Flight VALUES(1, 101, '인천', '샌프란시스코', 1230000, '2022-10-23 10:20');
INSERT INTO Flight VALUES(2, 101, '샌프란시스코', '인천', 1320000, '2022-10-26 13:00');
INSERT INTO Flight VALUES(3, 105, '김포', '제주', 72000, '2022-11-23 09:00');
INSERT INTO Flight VALUES(4, 105, '김포', '김해', 68000, '2022-11-12 17:30');
INSERT INTO Flight VALUES(5, 103, '인천', '프랑크푸르트', 1480000, '2022-12-01 18:00');
INSERT INTO Flight VALUES(6, 103, '프랑크푸르트', '인천', 1560000, '2022-12-10 10:00');
INSERT INTO Flight VALUES(7, 104, '김해', '김포', 70000, '2022-11-13 11:00');
INSERT INTO Flight VALUES(8, 101, '인천', '샌프란시스코', 1230000, '2022-11-15 10:00');

-- 참조관계 테이블의 기본키 106이 존재하지 않아 실패
INSERT INTO Flight VALUES(2, 106, '샌프란시스코', '인천', 1320000, '2022-10-26 13:00');

SELECT * FROM Flight;


 CREATE TABLE Reservation (
	PassengerNo int,
    FlightNo int,
    ReservedDate date NOT NULL
);
-- PassengerNo, FlightNo 쌍을 기본 키 설정
ALTER TABLE Reservation ADD CONSTRAINT pk_Reservation PRIMARY KEY(PassengerNo, FlightNo);
-- 외래 키 설정
ALTER TABLE Reservation ADD CONSTRAINT fk_reservation_passenger FOREIGN KEY(PassengerNo) REFERENCES Passenger(PassengerNo);
ALTER TABLE Reservation ADD CONSTRAINT fk_reservation_flight FOREIGN KEY(FlightNo) REFERENCES Flight(FlightNo);

-- 해당 테이블의 필드 타입과 기본 키 정보 확인
desc reservation;

-- 생성한 제약 조건을 확인
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, ENFORCED 
FROM information_schema.table_constraints 
WHERE table_name = 'Reservation';

INSERT INTO Reservation VALUES (1, 4, '2022-10-22');
INSERT INTO Reservation VALUES (3, 1, '2022-10-20');
INSERT INTO Reservation VALUES (4, 7, '2022-10-11');
INSERT INTO Reservation VALUES (6, 7, '2022-10-21');
INSERT INTO Reservation VALUES (2, 1, '2022-10-11');
INSERT INTO Reservation VALUES (2, 2, '2022-10-11');
INSERT INTO Reservation VALUES (7, 3, '2022-09-11');
INSERT INTO Reservation VALUES (1, 3, '2022-11-09');

SELECT * FROM Reservation;

-- 쿼리의 결과로 반환되는 투플의 수를 반환 함수
SELECT COUNT(*) 
FROM Passenger;

-- 중복 제외 조회
SELECT DISTINCT * FROM Aircraft;

-- 카티션 프로덕트
SELECT *
FROM Passenger, Reservation;
-- 서로 겹치는 속성 이름이 있을 경우 해당 필드는 지정해줘야 한다.
SELECT Passenger.PassengerNo
FROM Passenger, Reservation;

-- 현재 시간 조회 함수
SELECT NOW();

-- 합산 함수
SELECT SUM(AGE)
FROM Passenger;

-- 쿼리 실행이 느릴 경우
-- 1.내가 작성한 쿼리 상태 확인 ex) 4개 한번에 조인 보다 2개 2개 나눠서 조인이 더 유리
-- 2.EXPLAIN을 통해 QueryOptimizer의 실행계획을 비교하여 효율성을 판단할 수 있다.
-- 아래 예시는 데이터가 적어서 모두 동일한 실행계획이라서 아무거나 사용해도 된다.
-- 데이터가 많아지면 같은 결과의 쿼리여도 각 쿼리마다 실행계획이 다를 수 있다!
EXPLAIN SELECT *
FROM Passenger AS p 
NATURAL JOIN Reservation AS r;

EXPLAIN SELECT *
FROM Passenger AS p 
INNER JOIN Reservation AS r
ON p.PassengerNo = r.PassengerNo;

EXPLAIN SELECT *
FROM (SELECT * FROM Passenger) AS p 
NATURAL JOIN Reservation AS r;

EXPLAIN SELECT A.KindOfAircraft, A.Airline, F.FlightDate
FROM Flight F 
NATURAL JOIN Aircraft A
WHERE A.Airline = '대한항공';

EXPLAIN SELECT A.KindOfAircraft, A.Airline, F.FlightDate
FROM Flight F
NATURAL JOIN (SELECT * 
	          FROM Aircraft 
              WHERE Airline = '대한항공') A;


-- 여기서는 서로 결과가 같지만, 
-- 실행 계획을 보면 조인부분에서 키 정보가 하나 더 나와서 연산이 더 일어나 비효율적이다.
EXPLAIN SELECT FlightDate
FROM Flight
WHERE AircraftNo = 101;

EXPLAIN SELECT FlightDate
FROM Aircraft NATURAL JOIN Flight
WHERE AircraftNo = 101;

-- 합집합 UNION
-- 교집합 INTERSECT은 Mysql에서 지원하지 않는다.
EXPLAIN SELECT DISTINCT A.AircraftNo, A.Airline FROM
(SELECT * FROM Flight WHERE Deparetures='인천'
 UNION
 SELECT * FROM Flight WHERE Arrival='제주') AS tempFlight
INNER JOIN Aircraft AS A ON tempFlight.AircraftNo = A.AircraftNo;

-- 서브쿼리 활용 예시
-- 단순 서브쿼리는 조인이랑 비슷하고 
-- 데이터가 많거나 쿼리가 복잡하면 조인이 좀 더 유리하다.
SELECT PassengerName
FROM Passenger
WHERE Age = (SELECT MAX(Age) FROM Passenger);

-- 인라인뷰 서브쿼리
SELECT KindOfAircraft
FROM Aircraft
WHERE AircraftNo IN (SELECT AircraftNo
					FROM Flight
                    WHERE Deparetures = '인천');

-- 스칼라 서브쿼리
-- 조인이 너무 많아 부담되는 경우에 사용
SELECT KindOfAircraft, (SELECT Airline
						FROM Airline
						WHERE AirlineNo = A.AirlineNo) AS Airline
FROM Aircraft AS A;

SELECT KindOfAircraft, Airline
FROM Airline AS A
INNER JOIN Airline AS Airline
ON Aircraft.AirlineNo = A.AirlineNo;

-- 상호연관 서브쿼리
-- 대량인 경우 효율이 떨어져 웬만하면 피해야한다.
--  주 쿼리의 Grade 컬럼과 서브 쿼리의 Grade 컬럼이 상호 연관
SELECT passengerName, Age
FROM passenger AS p1
WHERE age > (SELECT avg(age)
		     FROM passenger AS p2
			 WHERE p1.grade = p2.grade);

-- GROUPBY와 Having절 예시
SELECT Grade, MIN(Age)
FROM Passenger
GROUP BY Grade
HAVING MIN(Age) > 40;


-- 인덱스를 활용한 정렬 방식
-- 인덱스가 Order by보다 효율이 좋다.
CREATE INDEX idx_passenger_Age ON Passenger(Age);

SELECT * FROM Passenger
WHERE Age > 0;

-- Order by절 활용한 정렬 방식
-- 데이터가 많으면 효율이 떨어짐
SELECT * FROM Passenger
ORDER BY Grade DESC;