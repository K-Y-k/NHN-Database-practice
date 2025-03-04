-- Mysql에서는 뷰를 잘 사용하지 않음
-- 뷰의 장점은 각 특정 부서(HR/마케팅 등)에 필요한 뷰만 제공하여 사용하면 보안을 강화할 수 있다.

USE Module06;

-- 해당 쿼리의 데이터들을 가상의 테이블인 뷰로 만들기
-- 자주 조인해서 사용되는 구조를 뷰로 한번 만들고 편하게 재사용 가능
CREATE VIEW ReservationInfo
AS
SELECT p.PassengerNo, PassengerName, ReservedDate, Deparetures, Arrival, FlightDate
FROM Passenger AS p 
INNER JOIN Reservation AS R ON p.PassengerNo = r.PassengerNo
INNER JOIN Flight AS f ON f.FlightNo = r.FlightNo;

-- 일반적으로 뷰에 데이터 삽입/삭제는 불가능하고 (개체 무결성 위반)
INSERT INTO ReservationInfo VALUES();

-- 단, 뷰가 기존에 존재하는 단일 테이블 형태와 같으면
CREATE VIEW employee_view 
AS
SELECT employee_id, name, department_id
FROM employees;
-- 기존 테이블에 데이터가 들어간다.
INSERT INTO employee_view (employee_id, name, department_id) 
VALUES (102, 'Jane Doe', 3);

-- 뷰를 생성할 때, 테이블의 컬럼 이름을 새로 정의할 수 있다.
CREATE VIEW FlightInfo (No, Aircraft, Airline, FromPort, InPort, Price)
AS
SELECT a.AircraftNo, KindOfAircraft, Airline, Deparetures, Arrival, Price
FROM Flight AS f INNER JOIN Aircraft AS a ON f.AircraftNo = a.AircraftNo;

-- 해당 DB에 현재 생성된 뷰들 확인
show full tables in module06 where TABLE_TYPE LIKE 'VIEW';

-- 뷰 삭제
DROP VIEW ReservationInfo;
DROP VIEW FlightInfo;

-- 삭제되었는지 확인
show full tables in module06 where TABLE_TYPE LIKE 'VIEW';


-- 원본 테이블
SELECT * 
FROM Aircraft
WHERE Airline = '대한항공';
-- 원본 테이블과 비슷한 단일 테이블 구조인 뷰 생성
CREATE VIEW KoreanAir(No, Type)
AS
SELECT AircraftNo, KindOfAircraft FROM Aircraft
WHERE Airline = '대한항공';

-- 추가시 원본 테이블 구조와 비슷하여 원본 테이블에 데이터가 들어가고 뷰에는 해당 데이터가 추가되는 것이 아니다.
-- 단, 원본 테이블에 추가된 데이터가 뷰의 쿼리에 해당되면 갱신됨
INSERT INTO KoreanAir VALUES(107, 'Airbus A220');
-- 원본 테이블에 데이터가 들어가 있음
SELECT * FROM Aircraft;
-- 뷰에는 없음
SELECT * FROM KoreanAir;

-- 뷰에는 현재 해당 데이터가 없기 때문에 업데이트 불가
UPDATE KoreanAir SET
Airline = '대한항공'
WHERE No = 106;
-- 원본 테이블에서 업데이트 적용
UPDATE Aircraft SET
Airline = '대한항공'
WHERE AircraftNo = 106;
-- 업데이트에 성공한 후 뷰에도 해당 데이터가 들어가 있는 것을 확인
SELECT * FROM KoreanAir;
-- 현재 뷰에 있는 데이터이면 업데이트 가능
UPDATE KoreanAir SET
Type = 'dd'
WHERE No = 106;

SELECT * FROM KoreanAir;


-- 각 항공에 대한 뷰 생성
CREATE VIEW AsianaAir (No, Type)
AS
SELECT AircraftNo, KindOfAircraft FROM Aircraft
WHERE Airline = '아시아나 항공';

CREATE VIEW JejuAir (No, Type)
AS
SELECT AircraftNo, KindOfAircraft FROM Aircraft
WHERE Airline = '제주항공';

-- 전체 데이터 확인
SELECT * FROM KoreanAir
UNION
SELECT * FROM AsianaAir
UNION
SELECT * FROM JejuAir;


CREATE VIEW FlightInfo (No, Departures, Arrivals, Price, Date, AircraftNo, AirCraftType, Airline)
AS
SELECT f.FlightNo, Deparetures, Arrival, Price, FlightDate, a.AircraftNo, KindOfAircraft, Airline
FROM Flight AS f 
INNER JOIN Aircraft AS a ON f.AircraftNo = a.AircraftNo;

CREATE VIEW ReservationInfo (No, Name, Grade, ReservedDate, FlightNo)
AS
SELECT p.PassengerNo, PassengerName, Grade, ReservedDate, f.FlightNo
FROM Passenger AS p 
INNER JOIN Reservation AS R ON p.PassengerNo = r.PassengerNo
INNER JOIN Flight AS f ON f.FlightNo = r.FlightNo;

desc FlightInfo;
desc ReservationInfo;

-- 뷰도 조인 가능
SELECT name, ReservedDate, Departures, Arrivals, Date
FROM ReservationInfo AS r 
INNER JOIN FlightInfo AS f ON r.FlightNo = f.No
WHERE r.name = '이순신';


-- 어떤 사용자 계정으로 접속하고 db를 확인하면
-- 다른 사용자가 만들었던 기존 DB들이 보이지 않는다. 접근 권한이 없기 때문
show databases;

-- 해당 사용자에게 특정 권한들 부여
GRANT SELECT ON Module06.Asianaair TO Michael;
GRANT SELECT ON Module06.FlightInfo TO Michael;
GRANT SELECT ON Module06.JejuAir TO Michael;
GRANT SELECT ON Module06.KoreanAir TO Michael;
GRANT SELECT ON Module06.ReservationInfo TO Michael

-- 권한을 부여한 DB가 나타나고
-- 전환 후 접근 가능한 테이블 확인
show databases;
USE Module06;
show tables;

-- 허가 된 테이블 접근 성공
SELECT Name, ReservedDate, Departures, Arrivals, Date
FROM ReservationInfo AS r 
INNER JOIN FlightInfo AS f ON r.FlightNo = f.No
WHERE r.name = '홍길동';

-- 허가되지 않은 테이블 접근 실패
SELECT * FROM Passenger;