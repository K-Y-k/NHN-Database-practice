-- 데이터베이스 목록을 확인
-- GO는 SQL Server에서 여러 SQL 명령어를 구분하고 배치 처리를 할 수 있게 도와주는 도구
-- 즉, 변수나 임시 테이블 등은 배치 간에 공유되지 않는다.
-- GO 이후 다음 명령어는 새로운 트랜잭션에서 진행
SELECT name, database_id
FROM sys.databases;
GO

-- 데이터베이스 생성
CREATE DATABASE Module02
GO

-- 해당 데이터베이스 사용
USE Module02
GO

-- 해당 데이터베이스의 릴레이션(물리적 데이터베이스 관점에서 테이블)을 확인
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'

-- 테이블(릴레이션) 생성
CREATE TABLE Category (
    CategoryNo int,
    CategoryName NVARCHAR(20)
)
GO

CREATE TABLE Product (
	ProductNo	int,
	ProductName	NVARCHAR(30),
    Price		MONEY,
    CategoryNo	int
)
GO

-- 해당 테이블의 저장된 데이터 조회
SELECT * FROM Category;

-- 데이터 삽입
INSERT INTO Category VALUES(1, 'Novel')
INSERT INTO Category VALUES(2, 'Poem')

-- 삽입 실패 (처음 선언한 최대 길이 초과)
INSERT INTO Category VALUES (3, 'History / Relegion and Magazine')

-- 데이터 수정
UPDATE Category SET
CategoryName = 'History'

UPDATE Category SET
CategoryName = 'Novel'
WHERE CategoryNo = 1;

UPDATE Category SET
CategoryNo = 3
WHERE CategoryNo = 2;

-- 데이터 삭제
DELETE Category
WHERE CategoryNo = 1;