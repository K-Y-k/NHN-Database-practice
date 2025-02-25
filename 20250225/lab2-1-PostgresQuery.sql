-- 데이터베이스 생성
CREATE DATABASE Module02;

-- 테이블 생성
CREATE TABLE Category (
	CategoryNo int,
	CategoryName varchar(30),
);

CREATE TABLE Product (
	ProductNo int,
	ProductName varchar(30),
	Price Money,
	CategoryNo int
);

-- 테이블의 데이터 조회
SELECT * FROM Category;

-- 데이터 삽입
INSERT INTO Category VALUES (1, 'Novel');
INSERT INTO Category VALUES (2, 'Poem');
 INSERT INTO Category VALUES (3, 'History / Religion and Magazine');

-- 데이터 수정
UPDATE Category SET
CategoryName = 'Novel'
WHERE CategoryNo = 1;

UPDATE Category SET
CategoryNo = 3
WHERE CategoryNo = 2;
