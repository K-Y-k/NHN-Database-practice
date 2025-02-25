-- Category와 Product 릴레이션 생성하기
-- Category(CategoryNo: Integer, CategoryName: String)
-- Product(ProductNo: Integer, ModelNumber: String, ProductName: String,, Price: float, CategoryNo: Integer)

-- 데이터베이스 생성
CREATE DATABASE Module02;

-- 모든 데이터베이스들 확인
show databases;

-- 데이터베이스 전환
use module02;

-- 현재 데이터베이스
SELECT database(); 

CREATE TABLE Category (
	CategoryNo INTEGER,
    CategoryName VARCHAR(20)
);

-- Mysql의 문자는 NVARCHAR이고
-- 정밀한 고정 소수점 숫자를 위한 DECIMAL도 제공한다.
CREATE TABLE Product (
	ProductNo INTEGER,
    ProductName NVARCHAR(30),
    Price DECIMAL,
    CategoryNo INTEGER
);

show tables;

-- 해당 테이블의 데이터 확인
SELECT * FROM Category;

-- 데이터 삽입
INSERT INTO Category VALUES (1, 'Novel');
INSERT INTO Category VALUES (2, 'Poem');

-- 제약조건 위반: 선언할 떄 20자까지 선언했으므로 30자 초과
INSERT INTO Category VALUES (3, 'History / Religion and Magazine');

-- 수정
-- 해당 테이블의 해당 필드의 값을 모두 수정한다.
-- UPDATE는 롤백 불가능하므로 따로 백업해놓아야 한다.
UPDATE Category SET
CategoryName = 'History';

UPDATE Category SET
CategoryNo = 3
WHERE CategoryNo = 2;

desc product;