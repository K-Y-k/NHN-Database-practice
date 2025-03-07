CREATE DATABASE Person;

USE Person;

CREATE TABLE Person (
	PersonID INT PRIMARY KEY,
    ResidentNum VARCHAR(20),
    Birth DATE,
    PhoneNum VARCHAR(20),
    Email VARCHAR(20)
);

CREATE TABLE BirthRegister (
	BirthID INT PRIMARY KEY,
    BirthPlaceID INT,
    AddressID INT,
    PersonID INT,
    BirthName VARCHAR(10),
    Gender VARCHAR(4),
    BirthDate DATE
);

CREATE TABLE BirthPlace (
	BirthPlaceID INT PRIMARY KEY,
    BirthPlace VARCHAR(10)
);

CREATE TABLE DeathReport (
	DeathReport INT PRIMARY KEY,
    DeathPlaceClassificationID INT,
    PersonID INT,
    DeathDate DATE
);

CREATE TABLE DeathPlaceClassification (
	DeathPlaceClassificationID INT PRIMARY KEY,
    DeathPlace VARCHAR(10)
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

ALTER TABLE Person ADD BirthID INT;
ALTER TABLE Person ADD DeathReport INT;

ALTER TABLE Person ADD CONSTRAINT fk_birth_register_birth_id FOREIGN KEY(BirthID) REFERENCES BirthRegister(BirthID);
ALTER TABLE Person ADD CONSTRAINT fk_death_report_death_report_id FOREIGN KEY(DeathReport) REFERENCES DeathReport(DeathReport);

INSERT INTO Address Values(1, '부산광역시 부산진구 가야대로 772');
INSERT INTO Address Values(2, '대구광역시 중구 국채보상로 620');
INSERT INTO Address Values(3, '광주광역시 북구 서하로 123');
INSERT INTO Address Values(4, '대전광역시 유성구 온천로 58');
INSERT INTO Address Values(5,'울산광역시 남구 삼산로 300');
INSERT INTO Address Values(6, '경기도 수원시 팔달구 효원로 300');
INSERT INTO Address Values(7, '강원도 춘천시 영서로 77');
INSERT INTO Address Values(8, '충청북도 청주시 상당로 315');
INSERT INTO Address Values(9, '전라북도 전주시 완산구 백제대로 567');
INSERT INTO Address Values(10, '경상남도 창원시 의창구 원이대로 500');

INSERT INTO Relationship VALUES(1, '배우자');
INSERT INTO Relationship VALUES(2, '부');
INSERT INTO Relationship VALUES(3, '모');
INSERT INTO Relationship VALUES(4, '자녀');

ALTER TABLE DeathPlaceClassification modify column DeathPlace varchar(255);

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

INSERT INTO BirthPlace VALUES(1, '자택');
INSERT INTO BirthPlace VALUES(2, '병원');
INSERT INTO BirthPlace VALUES(3, '기타');



INSERT INTO Person VALUES(1, '000000-0000000', '2000-04-28', '010-0000-0000', 'roger@naver.com');
INSERT INTO Person VALUES(2, '012340-0000000', '2000-04-28', '010-1234-0000', 'r@naver.com');

INSERT INTO BirthRegister VALUES(1, 1, 1, 1, '남길동', '남', '1951-07-21');


INSERT INTO BirthRegister VALUES(1, 2, 4, 1, '홍길동', "남", '1998-08-25 16:04:00');
INSERT INTO BirthRegister VALUES(2, 1, 1, 1, '남길동', '남', '1971-07-21 11:11:11'); 
INSERT INTO Person VALUES(3, '710721-0000000', '2000-04-28', '010-1234-0000', 'a@naver.com');

INSERT INTO BirthRegister VALUES(3, 1, 1, 3, '남석환', '남', '1998-12-21 11:11:11'); 
INSERT INTO Person VALUES(4, '981221-0000000', '2000-04-28', '010-1234-0000', 'b@naver.com');

INSERT INTO BirthRegister VALUES(4, 1, 1, 4, '남기준', '남', '2010-12-21 11:11:11'); 
INSERT INTO Person VALUES(5, '101221-0000000', '2000-04-28', '010-1234-0000', 'c@naver.com');

INSERT INTO BirthRegister VALUES(5, 2, 1, 1, '박한나', '녀', '1996-10-21 11:11:11'); 
INSERT INTO Person VALUES(6, '961021-0000000', '2000-04-28', '010-1234-0000', 'd@naver.com');

INSERT INTO BirthRegister VALUES(6, 2, 1, 2, '이주은', '녀', '2011-11-21 11:11:11'); 
INSERT INTO Person VALUES(7, '111121-0000000', '2000-04-28', '010-1434-0000', 'e@naver.com');

INSERT INTO BirthRegister VALUES(7, 2, 1, 4, '남기석', '남', '2030-05-22 11:11:11'); 
INSERT INTO Person VALUES(8, '300522-0000000', '2000-04-28', '010-1234-0000', 'f@naver.com');

INSERT INTO BirthRegister VALUES(8, 3, 1, 2, '이선미', '녀', '2012-12-21 11:11:11');
INSERT INTO Person VALUES(9, '121221-0000000', '2000-04-28', '010-1555-0000', 'g@naver.com');

SELECT * FROM Person A INNER JOIN BIRTHREGISTER B ON A.BirthID = B.BirthID;
SELECT * FROM Person;
SELECT * FROM BirthRegister;
SELECT * FROM Relationship;

INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(4, 3, 2);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(4, 5, 2);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(5, 4, 2);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(6, 4, 1);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(4, 6, 1);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(6, 5, 3);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(5, 6, 3);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(8, 5, 4);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(5, 8, 2);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(8, 7, 4);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(7, 8, 3);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(7, 5, 1);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(5, 8, 2);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(7, 8, 3);
INSERT INTO Relation(PersonID, RelationshipPersonID, RelationshipID) VALUES(9, 8, 3);

DELETE FROM Relation WHERE PersonID = 9 and RelationshipPersonID = 8;


INSERT INTO DetailReport VALUES(1, 1, '세대분리', '2009-10-02');
INSERT INTO DetailReport VALUES(2, 1, '전입', '2010-02-15');
INSERT INTO DetailReport VALUES(3, 1, '출생등록', '2012-03-17');
INSERT INTO DetailReport VALUES(4, 1, '전입', '2015-11-29');
INSERT INTO DetailReport VALUES(5, 2, '전입', '2009-10-31');
INSERT INTO DetailReport VALUES(6, 3, '전입', '2007-10-31');
INSERT INTO DetailReport VALUES(7, 1, '전입', '2013-03-05');


INSERT INTO AddressReport VALUES(5, 1);
INSERT INTO AddressReport VALUES(7, 2);
INSERT INTO AddressReport VALUES(8, 3);
INSERT INTO AddressReport VALUES(9, 4);
INSERT INTO AddressReport VALUES(5, 5);
INSERT INTO AddressReport VALUES(5, 6);
INSERT INTO AddressReport VALUES(5, 7);

SELECT * FROM Address;
SELECT * FROM AddressReport;

SELECT * FROM DetailReport Natural join Address;

INSERT INTO HouseholdHead VALUES(7, 5);
INSERT INTO HouseholdHead VALUES(8, 5);
INSERT INTO HouseholdHead VALUES(9, 5);

INSERT INTO Certificate VALUES(1, '가족관계증명서');
INSERT INTO Certificate VALUES(2, '주민등록등본');
INSERT INTO Certificate VALUES(3, '출생신고서');
INSERT INTO Certificate VALUES(4, '사망신고서');

INSERT INTO IssueCertificate VALUES(1, 5, 1, '2012-03-15 14:59:00');
INSERT INTO IssueCertificate VALUES(2, 5, 2, '2021-10-25');
INSERT INTO IssueCertificate VALUES(3, 8, 3, '2012-03-17');
INSERT INTO IssueCertificate VALUES(4, 5, 4, '2020-05-02');

INSERT INTO DeathReport VALUES(1, 1, 5, '2020-05-02');
UPDATE Person SET DeathReport = 1 WHERE PersonID = 5;

# 1. 가족관계증명서
SELECT D.CertificateName, I.IssueDate, I.IssueCertificateID
FROM Person A
INNER JOIN BirthRegister B ON A.BirthID = B.BirthID
INNER JOIN Address C ON C.AddressID = B.AddressID
INNER JOIN IssueCertificate I ON I.PersonID = A.PersonID
INNER JOIN Certificate D ON D.CertificateID = I.CertificateID
WHERE B.BirthName = '남기준';

SELECT S.RelationshipName, B.BirthName , A.Birth, A.ResidentNum, B.Gender 
FROM Person A 
INNER JOIN BirthRegister B ON A.BirthID = B.BirthID
INNER JOIN Relation R ON R.PersonID = A.PersonID
INNER JOIN Relationship S ON S.RelationshipID = R.RelationshipID
INNER JOIN Address C ON C.AddressID = B.AddressID
WHERE RelationshipPersonID = 5;

# 2. 주민등록등본
# I.IssueDate, I.IssueCertificateID, B.BirthName, S.Reason
SELECT I.IssueDate, I.IssueCertificateID, B.BirthName, S.Reason
FROM Person A
INNER JOIN BirthRegister B ON A.BirthID = B.BirthID
INNER JOIN Address C ON C.AddressID = B.AddressID
INNER JOIN IssueCertificate I ON I.PersonID = A.PersonID
INNER JOIN Certificate D ON D.CertificateID = I.CertificateID
INNER JOIN AddressReport R ON R.PersonID = A.PersonID
INNER JOIN DetailReport S ON S.DetailReportID = R.DetailReportID
WHERE B.BirthName = '남기준' and D.CertificateID = 2;

SELECT * FROM AddressReport;

SELECT B.Address, A.ReportDate
FROM DetailReport A 
INNER JOIN Address B ON A.AddressID = B.AddressID
INNER JOIN AddressReport R ON R.DetailReportID = A.DetailReportID
INNER JOIN Person P ON P.PersonID = R.PersonID
INNER JOIN BirthRegister C ON C.BirthID = P.BirthID
WHERE C.BirthName = '남기준';

SELECT C.Gender, C.BirthName, P.ResidentNum, A.ReportDate, A.Reason
FROM DetailReport A 
INNER JOIN Address B ON A.AddressID = B.AddressID
INNER JOIN AddressReport R ON R.DetailReportID = A.DetailReportID
INNER JOIN Person P ON P.PersonID = R.PersonID
INNER JOIN BirthRegister C ON C.BirthID = P.BirthID
WHERE B.AddressID = 1;

# 3. 출생신고서
SELECT I.IssueDate, B.BirthName, B.Gender, B.BirthDate, C.Address, P.BirthPlace
FROM Person A
INNER JOIN BirthRegister B ON A.BirthID = B.BirthID
INNER JOIN Address C ON C.AddressID = B.AddressID
INNER JOIN BirthPlace P ON P.BirthPlaceID = B.BirthPlaceID
INNER JOIN Relation R ON R.PersonID = A.PersonID
INNER JOIN Relationship S ON S.RelationshipID = R.RelationshipID
INNER JOIN IssueCertificate I ON I.PersonID = A.PersonID
WHERE A.PersonID = 8;

SELECT S.RelationshipName, B.BirthName , A.Birth, A.ResidentNum
FROM Person A 
INNER JOIN BirthRegister B ON A.BirthID = B.BirthID
INNER JOIN Relation R ON R.PersonID = A.PersonID
INNER JOIN Relationship S ON S.RelationshipID = R.RelationshipID
INNER JOIN Address C ON C.AddressID = B.AddressID
WHERE RelationshipPersonID = 8;

SELECT B.BirthName, P.ResidentNum, P.Email, P.PhoneNum
FROM BirthRegister B
INNER JOIN Person P ON P.PersonID = B.PersonID
WHERE B.BirthID = 8;

# 4. 사망신고서
SELECT I.IssueDate, B.BirthName, P.ResidentNum, R.DeathDate, F.DeathPlace
FROM Person P
INNER JOIN DeathReport R ON R.DeathReport = P.DeathReport
INNER JOIN BirthRegister B ON B.BirthID = P.BirthID
INNER JOIN IssueCertificate I ON I.PersonID = P.PersonID
INNER JOIN DeathPlaceClassification F ON F.DeathPlaceClassificationID = R.DeathPlaceClassificationID
WHERE I.CertificateID = 4;










