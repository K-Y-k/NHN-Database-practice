-- ���̺� ������ ����

-- DB ����
CREATE DATABASE Module06
GO

-- refresh �� DB ��ȯ
USE Module06
GO
-- ���� ����� DB Ȯ��
SELECT db_name();

CREATE TABLE Passenger (
    PassengerNo	int,
    PassengerName nvarchar(10)    NOT NULL,
    Grade 	int CHECK (Grade >= 1 AND Grade <= 10) default 1,
    Age     int     NULL

    CONSTRAINT pk_Passenger PRIMARY KEY(PassengerNo)
);

-- ���� ??�� ���ͼ� N ���λ縦 ����Ͽ� �����ڵ� ���ڿ��� ó��
INSERT INTO Passenger VALUES(1, N'ȫ�浿', 7, 44);
INSERT INTO Passenger (PassengerNo, PassengerName, Age) VALUES (2, N'�̼���', 44);
INSERT INTO Passenger (PassengerNo, PassengerName, Grade) VALUES(3, N'���߱�', 7);
INSERT INTO Passenger VALUES(4, N'�迵��', 9, 54);
INSERT INTO Passenger VALUES (5, N'��ҿ�',9, 45);
INSERT INTO Passenger VALUES (6, N'������', 10, 26);
INSERT INTO Passenger VALUES (7, N'õ��', 8, 55);
SELECT * FROM Passenger;


-- �ߺ��� �⺻Ű ������ ����
INSERT INTO Passenger VALUES (4, N'��ҿ�',9, 45);
-- NAME�� NOT NULL�̶� ����
INSERT INTO Passenger (PassengerNo, Grade, Age) VALUES (3, 7, 40);


CREATE TABLE Aircraft (
    AircraftNo int,
    KindOfAircraft varchar(20),
    Airline nvarchar(10)
);

-- �Ϲ� �������� ����
ALTER TABLE Aircraft ALTER COLUMN AircraftNo int NOT NULL;
ALTER TABLE Aircraft ALTER COLUMN KindOfAircraft varchar(20) NOT NULL;
-- �⺻ Ű �������� ����
ALTER TABLE Aircraft ADD CONSTRAINT pk_Aircraft PRIMARY KEY(AircraftNo);

-- ���̺� ��ü ���� Ȯ��
SELECT * 
FROM information_schema.TABLES 
WHERE table_type = 'BASE TABLE'

-- �ش� ���̺��� �� ���� Ȯ��
SELECT column_name, data_type, CHARACTER_MAXIMUM_LENGTH, is_nullable  
FROM information_schema.COLUMNS 
WHERE table_name = 'Aircraft'

-- �ش� ���̺��� Ű �������� ���� Ȯ��
SELECT constraint_name, constraint_type 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE table_name = 'Aircraft'

INSERT INTO Aircraft VALUES (101, 'Boeing 747', N'�����װ�');
INSERT INTO Aircraft VALUES (102, 'Boeing 727', N'�����װ�');
INSERT INTO Aircraft VALUES (103, 'Airbus A380', N'�ƽþƳ� �װ�');
INSERT INTO Aircraft VALUES (104, 'Airbus A300', N'�����װ�');
INSERT INTO Aircraft VALUES (105, 'Boeing 737-800', N'�����װ�');

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

INSERT INTO Flight VALUES(1, 101, N'��õ', N'�������ý���', 1230000, '2022-10-23 10:20');
INSERT INTO Flight VALUES(2, 101, N'�������ý���', N'��õ', 1320000, '2022-10-26 13:00');
INSERT INTO Flight VALUES(3, 105, N'����', N'����', 72000, '2022-11-23 09:00');
INSERT INTO Flight VALUES(4, 105, N'����', N'����', 68000, '2022-11-12 17:30');
INSERT INTO Flight VALUES(5, 103, N'��õ', N'����ũǪ��Ʈ', 1480000, '2022-12-01 18:00');
INSERT INTO Flight VALUES(6, 103, N'����ũǪ��Ʈ', N'��õ', 1560000, '2022-12-10 10:00');
INSERT INTO Flight VALUES(7, 104, N'����', N'����', 70000, '2022-11-13 11:00');
INSERT INTO Flight VALUES(8, 101, N'��õ', N'�������ý���', 1230000, '2022-11-15 10:00');

SELECT * FROM Flight;

-- �װ��� ��ȣ�� 106�� �����Ͱ� �������� �����Ƿ�, ���� ���Ἲ�� �����Ͽ� ����
INSERT INTO Flight VALUES(2, 106, N'�������ý���', N'��õ', 1320000, '2022-10-26 13:00');


CREATE TABLE Reservation (
    PassengerNo int,
    FlightNo int,
    ReservedDate datetime NOT NULL
);
-- �Ϲ� �������� ����
ALTER TABLE Reservation ALTER COLUMN PassengerNo int NOT NULL
GO
ALTER TABLE Reservation ALTER COLUMN FlightNo int NOT NULL
GO
-- �⺻ Ű �������� ����
ALTER TABLE Reservation ADD CONSTRAINT pk_Reservation PRIMARY KEY(PassengerNo, FlightNo)
GO
-- �ܷ� Ű �������� ����
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

-- Mssql ���� ��ȯ �Լ�
SELECT CONVERT(varchar(10), FlightDate, 103)
FROM Flight;


-- SQL Server���� ������ ����
DECLARE @id int
-- ������ ���� �Ҵ�
SET @id = 4
-- 8
SELECT @id + 4
-- PassengerNo�� 4�� ������
SELECT PassengerNo, PassengerName, Age
FROM Passenger
WHERE PassengerNo = @id

-- ���� �ð� ��ȸ
SELECT getDate();

-- �ջ� �Լ�
SELECT SUM(AGE)
FROM Passenger;

-- AS�� ��Ī�� �����ϰ� Mssql�� ��Ī�� �ѱ۷� ����ϰ� ������ []�� �����ش�
-- Mssql�� Natural Join�� ����.
SELECT P.Age +10 AS [����]
FROM Passenger AS p 
INNER JOIN Reservation AS r
ON p.PassengerNo = r.PassengerNo

-- ���� ���� ����(INNER JOIN)�� ����Ѵ�.
-- �������� �����ϴ� ���
SELECT *
FROM Aircraft AS A
-- ó�� �����ϴ� ����
INNER JOIN Flight AS F ON A.AircraftNo = F.AircraftNo
-- �ι�° ����
INNER JOIN Reservation AS R ON F.FlightNo = R.FlightNo
-- ����° ����
INNER JOIN Passenger AS P ON R.PassengerNo = P.PassengerNo
WHERE A.Airline = '�����װ�'

-- Union ������
SELECT DISTINCT A.AircraftNo, A.Airline FROM
(SELECT * FROM Flight WHERE Deparetures=N'��õ'
 UNION
 SELECT * FROM Flight WHERE Arrival=N'����') AS tempFlight
INNER JOIN Aircraft AS A ON tempFlight.AircraftNo = A.AircraftNo;


-- INTERSECT ������
-- �� ������ ���� ��ȹ�� ���� ���� 
-- �ι�° ������ �� �� ȿ�����̴�.
SELECT DISTINCT PassengerName, Age FROM
(SELECT * FROM Flight WHERE Deparetures = '����'
INTERSECT
SELECT * FROM Flight WHERE Arrival = '����') AS tempFlight
INNER JOIN Reservation AS R ON tempFlight.FlightNo = R.FlightNo
INNER JOIN Passenger AS P ON R.PassengerNo = P.PassengerNo;

SELECT PassengerName, Age
FROM Passenger INNER JOIN Reservation ON Passenger.PassengerNo = Reservation.PassengerNo
INNER JOIN Flight ON Reservation.FlightNo = Flight.FlightNo
INNER JOIN Aircraft ON Flight.AircraftNo = Aircraft.AircraftNo
WHERE Flight.Deparetures = '����' AND Flight.Arrival = '����';


-- �װ��� �պ� ����
-- ���� ���̺��� ���̱׷��̼� �ؾ���
CREATE TABLE Airline (
	AirlineNo int,
    Airline nvarchar(10)
    
    CONSTRAINT pk_Airline PRIMARY KEY(Airline)
)
INSERT INTO Airline VALUES(1, N'�����װ�'), (2, N'�ƽþƳ��װ�'), (3, N'�����װ�')

ALTER TABLE Aircraft ADD AirlineNo int