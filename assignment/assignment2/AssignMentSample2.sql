show databases;
CREATE DATABASE moduleAssginment;
use moduleAssginment;

DROP TABLE BirthPlace;
DROP TABLE BirthRegister;
DROP TABLE IssueCertificate;
DROP TABLE Certificate;
DROP TABLE Relation;
DROP TABLE RelationShip;
DROP TABLE DeathPlaceClassification;
DROP TABLE DeathReport;
DROP TABLE HouseholdHead;
DROP TABLE AddressReport;
DROP TABLE DetailReport;
DROP TABLE Address;
DROP TABLE Person;

CREATE TABLE Person (
	PersonID INT PRIMARY KEY,
    ResidentNum VARCHAR(20),
    Birth DATE,
    PhoneNum VARCHAR(20),
    Email VARCHAR(20),
    BirthID INT,
    DeathReportID INT
);

CREATE TABLE BirthRegister (
	BirthID INT PRIMARY KEY,
    BirthPlaceID INT,
    AddressID INT,
    PersonID INT,
    Name VARCHAR(10),
    Gender VARCHAR(4),
    BirthDate DATE
);

CREATE TABLE BirthPlace (
	BirthPlaceID INT PRIMARY KEY,
    BirthPlace VARCHAR(10)
);

CREATE TABLE DeathReport (
	DeathReportID INT PRIMARY KEY,
    DeathPlaceClassificationID INT,
    PersonID INT,
    DeathDate DATE
);

CREATE TABLE DeathPlaceClassification (
	DeathPlaceClassificationID INT PRIMARY KEY,
    DeathPlace VARCHAR(255)
);

CREATE TABLE IssueCertificate (
	IssueCertificateID INT PRIMARY KEY,
    PersonID INT,
    CertificateID INT,
    IssueDate DATE
);

CREATE TABLE Certificate (
	CertificateID INT PRIMARY KEY,
    CertificateName VARCHAR(10)
);

CREATE TABLE Relationship (
	RelationshipID INT PRIMARY KEY,
    RelationshipName VARCHAR(10)
);

CREATE TABLE Relation (
	PersonID INT,
    RelationshipPersonID INT,
    RelationshipID INT
);

CREATE TABLE AddressReport (
	PersonID INT,
    DetailReportID INT
);

CREATE TABLE HouseholdHead (
	PersonID INT,
    HouseholdPersonID INT
);

CREATE TABLE DetailReport (
	DetailReportID INT PRIMARY KEY,
    AddressID INT,
    Reason VARCHAR(20),
    ReportDate DATE
);

CREATE TABLE Address (
	AddressID INT PRIMARY KEY,
    Address VARCHAR(255)
);

ALTER TABLE Person ADD CONSTRAINT fk_birth_id FOREIGN KEY(BirthID) REFERENCES BirthRegister(BirthID);
ALTER TABLE Person ADD CONSTRAINT fk_death_id FOREIGN KEY(DeathReportID) REFERENCES DeathReport(DeathReportID);

ALTER TABLE IssueCertificate ADD CONSTRAINT fk_person_id FOREIGN KEY(PersonID) REFERENCES Person(PersonID);
ALTER TABLE IssueCertificate ADD CONSTRAINT fk_certificate_id FOREIGN KEY(CertificateID) REFERENCES Certificate(CertificateID);

ALTER TABLE BirthRegister ADD CONSTRAINT fk_birth_place_id FOREIGN KEY(BirthPlaceID) REFERENCES BirthPlace(BirthPlaceID);
ALTER TABLE BirthRegister ADD CONSTRAINT fk_birth_address_id FOREIGN KEY(AddressID) REFERENCES Address(AddressID);
ALTER TABLE BirthRegister ADD CONSTRAINT fk_birth_person_id FOREIGN KEY(PersonID) REFERENCES Person(PersonID);

ALTER TABLE DetailReport ADD CONSTRAINT fk_detail_report_address_id FOREIGN KEY(AddressID) REFERENCES Address(AddressID);

ALTER TABLE AddressReport ADD CONSTRAINT fk_address_report_person_id FOREIGN KEY(PersonID) REFERENCES Person(PersonID);
ALTER TABLE AddressReport ADD CONSTRAINT fk_detail_report_id FOREIGN KEY(DetailReportID) REFERENCES DetailReport(DetailReportID);

ALTER TABLE Relation ADD CONSTRAINT fk_relation_person_id FOREIGN KEY(PersonID) REFERENCES Person(PersonID);
ALTER TABLE Relation ADD CONSTRAINT fk_relation_relation_person_id FOREIGN KEY(PersonID) REFERENCES Person(PersonID);
ALTER TABLE Relation ADD CONSTRAINT fk_relationship_id FOREIGN KEY(RelationshipID) REFERENCES Relationship(RelationshipID);

ALTER TABLE DeathReport ADD CONSTRAINT fk_death_report_person_id FOREIGN KEY(PersonID) REFERENCES DeathPlaceClassification(DeathPlaceClassificationID);

ALTER TABLE HouseholdHead ADD CONSTRAINT fk_household_head_person_id FOREIGN KEY(PersonID) REFERENCES Person(PersonID);
ALTER TABLE HouseholdHead ADD CONSTRAINT fk_household_head_head_person_id FOREIGN KEY(HouseholdPersonID) REFERENCES Person(PersonID);


-- 사람 데이터 삽입
INSERT INTO Person (PersonID) VALUES(1);
INSERT INTO Person (PersonID, ResidentNum, Birth, PhoneNum, Email) VALUES(2, '000000-0000000', '2000-04-28', '010-0000-0000', 'roger@naver.com');
INSERT INTO Person (PersonID, ResidentNum, Birth, PhoneNum, Email) VALUES(3, '012340-0000000', '2000-04-28', '010-1234-0000', 'r@naver.com');

SELECT * FROM Person;

-- 출생 장소 데이터 삽입
INSERT INTO BirthPlace VALUES(1, "자택");
INSERT INTO BirthPlace VALUES(2, "병원");
INSERT INTO BirthPlace VALUES(3, "기타");

SELECT * FROM BirthPlace;

-- 주소 데이터 삽입
INSERT INTO Address VALUES(1, '부산광역시 부산진구 가야대로 772');
INSERT INTO Address VALUES(2, '대구광역시 중구 국채보상로 620');
INSERT INTO Address VALUES(3, '광주광역시 북구 서하로 123');
INSERT INTO Address VALUES(4, '대전광역시 유성구 온천로 58');
INSERT INTO Address VALUES(5, '울산광역시 남구 삼산로 300');
INSERT INTO Address VALUES(6, '경기도 수원시 팔달구 효원로 300');
INSERT INTO Address VALUES(7, '강원도 춘천시 영서로 77');
INSERT INTO Address VALUES(8, '충청북도 청주시 상당로 315');
INSERT INTO Address VALUES(9, '전라북도 전주시 완산구 백제대로 567');
INSERT INTO Address VALUES(10, '경상남도 창원시 의창구 원이대로 500');

SELECT * FROM Address;

-- 출생신고서 데이터 삽입
INSERT INTO BirthRegister VALUES(1, 2, 3, 1, "남길동", "남", '1960-03-22 16:04');
INSERT INTO Person (PersonID, ResidentNum, Birth, PhoneNum, Email, BirthID) VALUES(4, '123456-1234567', '1960-03-22', '010-1234-5678', '남길@naver.com', 1);

INSERT INTO BirthRegister VALUES(2, 2, 4, 4, "남석환", "남", '1978-05-25 16:04');
INSERT INTO Person (PersonID, ResidentNum, Birth, PhoneNum, Email, BirthID) VALUES(5, '123456-1234567', '1978-05-25', '010-1234-5678', '석환@naver.com', 2);

INSERT INTO BirthRegister VALUES(3, 2, 4, 2, "박한나", "여", '1978-07-25 16:04');
INSERT INTO Person (PersonID, ResidentNum, Birth, PhoneNum, Email, BirthID) VALUES(6, '123456-1234567', '1978-07-25', '010-1234-5678', '한나@naver.com', 3);

INSERT INTO BirthRegister VALUES(4, 2, 4, 5, "남기준", "남", '1988-05-25 16:04');
INSERT INTO Person (PersonID, ResidentNum, Birth, PhoneNum, Email, BirthID) VALUES(7, '123456-1234567', '1988-05-25', '010-1234-5678', '기준@naver.com', 4);

INSERT INTO BirthRegister VALUES(5, 2, 4, 7, "남기석", "남", '1996-10-25 16:04');
INSERT INTO Person (PersonID, ResidentNum, Birth, PhoneNum, Email, BirthID) VALUES(8, '123456-1234567', '1996-10-25', '010-1234-5678', '기석@naver.com', 5);

INSERT INTO BirthRegister VALUES(6, 2, 4, 3, "이주은", "여", '1998-07-25 16:04');
INSERT INTO Person (PersonID, ResidentNum, Birth, PhoneNum, Email, BirthID) VALUES(9, '123456-1234567', '1998-07-25', '010-1234-5678', '주은@naver.com', 6);

INSERT INTO BirthRegister VALUES(7, 2, 4, 3, "이선미", "여", '2000-03-25 16:04');
INSERT INTO Person (PersonID, ResidentNum, Birth, PhoneNum, Email, BirthID) VALUES(10, '123456-1234567', '2000-03-25', '010-1234-5678', '선미@naver.com', 7);


SELECT * FROM Person;
SELECT * FROM BirthRegister;

-- 사망장소 선택지 값 넣기
INSERT INTO DeathPlaceClassification VALUES(1, '주택');
INSERT INTO DeathPlaceClassification VALUES(2, '의료기관');
INSERT INTO DeathPlaceClassification VALUES(3, '사회복지시(양로원,고아원 등)');
INSERT INTO DeathPlaceClassification VALUES(4, '산업장');
INSERT INTO DeathPlaceClassification VALUES(5, '공공시설(학교,운동장 등)');
INSERT INTO DeathPlaceClassification VALUES(6, '도로');
INSERT INTO DeathPlaceClassification VALUES(7, '상업/서비시설(상점,호텔 등)');
INSERT INTO DeathPlaceClassification VALUES(8, '농장(논밭,축사,)');
INSERT INTO DeathPlaceClassification VALUES(9, '병원 이송 중 사망');
INSERT INTO DeathPlaceClassification VALUES(10, '기타');

-- 증명서 종류 데이터 삽입
INSERT INTO Certificate VALUES(1, '가족관계증명서');
INSERT INTO Certificate VALUES(2, '주민등록등본');

-- 관계 종류 데이터 삽입
INSERT INTO Relationship VALUES(1, "부");
INSERT INTO Relationship VALUES(2, "모");
INSERT INTO Relationship VALUES(3, "배우자");
INSERT INTO Relationship VALUES(4, "자녀");

SELECT * From Relationship;
SELECT * From Person;
SELECT * From Relation;
SELECT * From BirthRegister;

-- 관계 데이터 삽입
-- 남길 <-> 석환 (4=남길, 5=석환, 1=부) (5=석환, 4=남길, 4=자녀)
INSERT INTO Relation VALUES(4, 5, 1);
INSERT INTO Relation VALUES(5, 4, 4);
-- 석환 <-> 한나
INSERT INTO Relation VALUES(5, 6, 3);
INSERT INTO Relation VALUES(6, 5, 3);
-- 석환 <-> 기준 (1=부, 4=남길, 5=석환)
INSERT INTO Relation VALUES(5, 7, 1);
INSERT INTO Relation VALUES(7, 5, 4);
-- 한나 <-> 기준
INSERT INTO Relation VALUES(6, 7, 2);
INSERT INTO Relation VALUES(7, 6, 4);
-- 기준 <-> 주은
INSERT INTO Relation VALUES(7, 9, 3);
INSERT INTO Relation VALUES(9, 7, 3);
-- 기준 <-> 기석
INSERT INTO Relation VALUES(7, 8, 1);
INSERT INTO Relation VALUES(8, 7, 4);
-- 주은 <-> 기석
INSERT INTO Relation VALUES(5, 7, 1);
INSERT INTO Relation VALUES(7, 5, 4);


-- 증명서 발급 데이터 삽입
INSERT INTO IssueCertificate VALUES(1, 4, 1, CURDATE());

SELECT * FROM IssueCertificate;
SELECT * FROM Person;

-- 발급한 가족관계 증명서
SELECT CURDATE() AS 발급일, C.IssueCertificateID AS 증명서확인번호,
      A.Address AS 등록기준지
FROM Person P
INNER JOIN BirthRegister B ON P.BirthID = B.BirthID
INNER JOIN IssueCertificate C ON P.PersonID = C.PersonID
INNER JOIN Address A ON A.AddressID = B.AddressID;

SELECT r.RelationshipName AS 구분,
	   b.Name AS 성명,
       DATE_FORMAT(b.BirthDate, '%Y년 %m월 %d일') AS 출생연월일,
       CONCAT(LEFT(p.ResidentNum, 6), '-*******') AS 주민등록번호,
       b.Gender AS 성별
FROM Relation rel
JOIN Person p ON rel.RelationshipPersonID = p.PersonID
JOIN BirthRegister b ON p.BirthID = b.BirthID
JOIN Relationship r ON rel.RelationshipID = r.RelationshipID
where rel.PersonID = 4;

SELECT * FROM RELATION;
SELECT * FROM BirthRegister;

SELECT CURDATE() AS 신고일,
	   B.Name AS 출생자성명, B.Gender AS 성별,
       BP.BirthPlace AS 출생장소,
       A.Address AS 등록기준지
FROM Person P
INNER JOIN BirthRegister B ON P.BirthID = B.BirthID
INNER JOIN BirthPlace BP ON B.BirthPlaceID = BP.BirthPlaceID
INNER JOIN Address A ON A.AddressID = B.AddressID;


SELECT r.RelationshipName AS 구분,
	   b.Name AS 성명,
       DATE_FORMAT(b.BirthDate, '%Y년 %m월 %d일') AS 출생연월일,
       CONCAT(LEFT(p.ResidentNum, 6), '-*******') AS 주민등록번호,
       b.Gender AS 성별
FROM Relation rel
JOIN Person p ON rel.RelationshipPersonID = p.PersonID
JOIN BirthRegister b ON p.BirthID = b.BirthID
JOIN Relationship r ON rel.RelationshipID = r.RelationshipID
where rel.PersonID = 1;

