USE MODULE03;

-- INNER JOIN과 NATURAL JOIN 차이
SELECT *
FROM (AirCraft a
	  INNER JOIN Flight f
	  ON a.AirCraftNo = f.AirCraftNo);
SELECT *
FROM (AirCraft
	  NATURAL JOIN Flight);

-- 파일럿(파일럿번호: 정수, 파일럿이름: 문자열, 등급: 정수, 나이: 실수)
-- 비행기(비행기번호: 정수, 비행기이름: 문자열, 비행기종류: 문자열)
-- 운항(파일럿번호: 정수, 비행기번호: 정수, 운항일자: 날짜)


-- 테이블 세팅
CREATE TABLE Pilot1 (
	PilotNo int,
    PilotName varchar(50) NOT NULL,
    Grade int,
    Age int,
    
    CONSTRAINT pk_PilotNo PRIMARY KEY(PilotNo)
);
CREATE TABLE AirCraft (
	AirCraftNo int,
    AirCraftName varchar(50) NOT NULL,
    AirCraftKinds varchar(50) NOT NULL,
    
    CONSTRAINT pk_AirCraftNo PRIMARY KEY(AirCraftNo)
);
CREATE TABLE Flight (
	PilotNo int,
    AirCraftNo int,
    FlightDay varchar(50) NOT NULL,
    
    CONSTRAINT fk_PilotNo_Pilot1 FOREIGN KEY(PilotNo) REFERENCES Pilot1(PilotNo),
    CONSTRAINT fk_AirCraftNo_AirCraft FOREIGN KEY(AirCraftNo) REFERENCES AirCraft(AirCraftNo)
);

-- 값 세팅
INSERT Pilot1 VALUES(13, "홍길동", 1, 44);
INSERT Pilot1 VALUES(32, "이순신", 10, 44);
INSERT Pilot1 VALUES(44, "안중근", 7, 32);

INSERT AirCraft VALUES(101, "에놀라게이", "폭격기");
INSERT AirCraft VALUES(102, "톰캣", "전투기");
INSERT AirCraft VALUES(103, "블랙버드", "정찰기");

INSERT Flight VALUES(13, 101, "2022-10-09");
INSERT Flight VALUES(44, 102, "2022-11-23");

SELECT * FROM Pilot1;
SELECT * FROM AirCraft;
SELECT * FROM Flight;


-- 비행기 101을 운항하는 파일럿의 이름을 구하세요.
-- 홍길동
SELECT PilotName
FROM Pilot1 p
NATURAL JOIN Flight
WHERE AirCraftNo = 101;
-- 내가 푼 방식
SELECT p.PilotName
FROM Pilot1 p
INNER JOIN Flight f
ON p.PilotNo = f.PilotNo
WHERE f.AirCraftNo = 101;
-- 위 문제를 응용하여 개명 연산을 사용하여 각 대수식을 작은 부분으로 분할한 다음 합쳐 연산하는 관계 대수식을 작성하세요.
-- πPilot1.파일럿이름(δFlight.비행기번호(Pilot1><Pilot1.파일럿번호=Flight.파일럿번호Flight)
SELECT Pilot1.파일럿이름
FROM Pilot1 
Inner Join Flight 
ON Pilot1.파일럿번호 = Flight.파일럿번호
WHERE Flight.비행기번호 = 101;

-- 전투기를 운항하는 파일럿의 이름을 구하세요.
-- 안중근
SELECT PilotName
FROM Pilot1
NATURAL JOIN Flight 
NATURAL JOIN Aircraft -- JOIN은 연속으로 가능하다.
WHERE AirCraftKinds = "전투기";
-- 서브쿼리 방식
SELECT PilotName
FROM(SELECT PilotNo
	 FROM Flight
	 WHERE AirCraftNo = 102) AS f
NATURAL JOIN Pilot1 AS p;
-- 내가 푼 방식
SELECT p.PilotName
FROM (	SELECT f.PilotNo
		FROM AirCraft a
		INNER JOIN Flight f
		ON a.AirCraftNo = f.AirCraftNo
        WHERE a.AirCraftKinds = "전투기") AS jaf
INNER JOIN Pilot1 p
ON p.PilotNo = jaf.PilotNo;

-- 이순신이 조종하는 비행기의 종류를 구하세요.
-- 현재 없음
SELECT AirCraftKinds
FROM AirCraft
NATURAL JOIN Flight 
NATURAL JOIN Pilot1
WHERE Pilot1.PilotName = "이순신";
-- 내가 푼 방식
SELECT a.AirCraftKinds
FROM (	SELECT f.AirCraftNo
		FROM Pilot1 p
		INNER JOIN Flight f
		ON p.PilotNo = f.PilotNo
        WHERE p.PilotName = "이순신") AS jpf
INNER JOIN AirCraft a
ON a.AirCraftNo = jpf.AirCraftNo;

-- 운항 스케줄이 잡혀있는 모든 파일럿의 이름을 구하세요.
-- 홍길동, 안중근
SELECT p.PilotName
FROM Pilot1 p
INNER JOIN Flight f
ON p.PilotNo = f.PilotNo;

-- 폭격기 또는 정찰기를 운항하는 파일럿의 이름을 구하세요.
-- 홍길동
SELECT PilotName
FROM Pilot1
INNER JOIN Flight ON Pilot1.PilotNo = Flight.PilotNo
INNER JOIN Aircraft ON Flight.AircraftNo = Aircraft.AircraftNo
WHERE AircraftKinds = "폭격기" OR AircraftKinds = "정찰기";
-- UNION 방식 -> 조인 쿼리들을 다시 합쳐서 효율이 떨어진다.
SELECT PilotName
FROM Pilot1
INNER JOIN Flight
ON Pilot1.PilotNo = Flight.PilotNo
	INNER JOIN Aircraft ON Flight.AircraftNo = Aircraft.AircraftNo
WHERE AircraftKinds = "폭격기"
UNION
SELECT PilotName
FROM Pilot1
INNER JOIN Flight
ON Pilot1.PilotNo = Flight.PilotNo
	INNER JOIN Aircraft ON Flight.AircraftNo = Aircraft.AircraftNo
WHERE AircraftKinds = "정찰기";

-- 전투기와 폭격기를 운형하는 파일럿의 이름을 구하세요.
-- 현재 없음
SELECT PilotName
FROM Pilot1
INNER JOIN Flight ON Pilot1.PilotNo = Flight.PilotNo
INNER JOIN Aircraft ON Flight.AircraftNo = Aircraft.AircraftNo
WHERE AircraftKinds = "전투기" AND AircraftKinds = "폭격기";

-- 폭격기를 운항하지 않는 나이가 40세 이상의 파일럿의 파일럿 번호를 구하세요.
-- 32
SELECT p.PilotNo
FROM Pilot1 p
LEFT JOIN Flight f 
ON p.PilotNo = f.PilotNo
WHERE (f.AirCraftNo != 101 OR f.AirCraftNo IS NULL) AND p.Age >= 40;

-- 한번도 운항하지 않은 파일럿을 구하세요.
-- 이순신
SELECT *
FROM Pilot1 p
LEFT JOIN Flight f
ON p.PilotNo = f.PilotNo
WHERE f.PilotNo IS NULL;
