-- 기존 사용자 확인
SELECT name, principal_id, * FROM sys.server_principals
WHERE type_desc IN ('SQL_LOGIN', 'WINDOWS_GROUP', 'WINDOWS_LOGIN')

-- 사용자 생성
CREATE LOGIN Michael WITH PASSWORD = 'P@ssw0rd';
-- 생성된 사용자 확인
SELECT name, principal_id, * FROM sys.server_principals
WHERE type_desc IN ('SQL_LOGIN', 'WINDOWS_GROUP', 'WINDOWS_LOGIN')

-- Michael 사용자에게 Module06 DB의 Passenger 테이블의 모든 필드 대한 SELECT 특권을 부여
GRANT SELECT ON Module06.dbo.Passenger TO Michael
-- Michael 계정에서 Passenger 테이블의 모든 필드 접근시 성공
SELECT * FROM Module06.dbo.Passenger


SELECT * FROM Module06.dbo.Passenger 
INNER JOIN Module06.dbo.Reservation ON Passenger.PassengerNo = Reservation.PassengerNo