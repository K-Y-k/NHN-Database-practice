-- 다 대 다 관계 테이블 생성법

-- 데이터베이스를 생성
CREATE DATABASE Module03
GO
-- 연결 컨텍스트를 생성한 Module03 데이터베이스로 변경
USE Module03
GO

-- 생성한 Module03 데이터베이스의 테이블을 확인
SELECT * FROM INFORMATION_SCHEMA.Tables 
WHERE TABLE_TYPE = 'base table'

-- 테이블 생성
CREATE TABLE Category (
    CategoryNo int,
    CategoryName varchar(20) NOT NULL

    CONSTRAINT pk_Category PRIMARY KEY(CategoryNo)
)

-- 생성된 테이블 정보를 확인
SELECT COLUMN_NAME, IS_NULLABLE, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Category'


CREATE TABLE Product (
    ProductNo int PRIMARY KEY,
    ProductName varchar(100) NOT NULL,
    UnitPrice money DEFAULT 0 NOT NULL,
    Description nvarchar(max),
    CategoryNo int

    CONSTRAINT fk_Product_CategoryID FOREIGN KEY(CategoryNo) REFERENCES Category(CategoryNo)
)

SELECT COLUMN_NAME, IS_NULLABLE, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Product'

CREATE TABLE Customer (
	CustomerNo int,
	CustomerName nvarchar(10),
	Email varchar(40),
	Password varchar(16),
)

-- 생성한 테이블의 인덱스 타입을 확인
-- Category와 Product는 PK를 설정했으므로 정렬 b-트리 기반인 CLUSTERED이고
-- Customer는 PK를 설정이 없으므로 Heap
SELECT t.name, i.index_id, i.type, i.type_desc
FROM sys.tables t 
INNER JOIN sys.indexes i
ON t.object_id = i.object_id

--  Customer 테이블은 PRIMARY KEY가 없이 생성된 Heap 이라 실패
CREATE TABLE Orders (
	OrderNo int,
	OrderDate Date,
	CustomerNo int,

	CONSTRAINT pk_Order PRIMARY KEY(OrderNo),
	CONSTRAINT fk_Order_Customer FOREIGN KEY(CustomerNo)
	REFERENCES Customer(CustomerNo)
)

-- Customer 테이블의 CustomerNo 컬럼에 PRIMARY KEY 제약조건을 설정
-- 일반 제약조건 설정
ALTER TABLE Customer ALTER COLUMN CustomerNo int NOT NULL
GO
-- 기본키 설정
ALTER TABLE Customer ADD CONSTRAINT pk_Customer PRIMARY KEY(CustomerNo)

SELECT t.name, i.name, i.index_id, i.type, i.type_desc
FROM sys.tables t INNER JOIN sys.indexes i
ON t.object_id = i.object_id


CREATE TABLE OrderDetail (
    ProductNo int,
    OrderNo	int,
    Quantity int,

	-- 최소성인 후보키를 기본키로 설정
    CONSTRAINT pk_OrderDetail PRIMARY KEY(ProductNo, OrderNo),
    CONSTRAINT fk_OrderDetail_Order FOREIGN KEY(OrderNo) REFERENCES Orders(OrderNo),
    CONSTRAINT fk_OrderDetail_Product FOREIGN KEY(ProductNo) REFERENCES Product(ProductNo)
)