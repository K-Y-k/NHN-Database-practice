-- ���� ����� Ȯ��
SELECT name, principal_id, * FROM sys.server_principals
WHERE type_desc IN ('SQL_LOGIN', 'WINDOWS_GROUP', 'WINDOWS_LOGIN')

-- ����� ����
CREATE LOGIN Michael WITH PASSWORD = 'P@ssw0rd';
-- ������ ����� Ȯ��
SELECT name, principal_id, * FROM sys.server_principals
WHERE type_desc IN ('SQL_LOGIN', 'WINDOWS_GROUP', 'WINDOWS_LOGIN')

-- Michael ����ڿ��� Module06 DB�� Passenger ���̺��� ��� �ʵ� ���� SELECT Ư���� �ο�
GRANT SELECT ON Module06.dbo.Passenger TO Michael
-- Michael �������� Passenger ���̺��� ��� �ʵ� ���ٽ� ����
SELECT * FROM Module06.dbo.Passenger


SELECT * FROM Module06.dbo.Passenger 
INNER JOIN Module06.dbo.Reservation ON Passenger.PassengerNo = Reservation.PassengerNo