-- 다 대 다 관계 테이블 생성법
-- 인덱스 기준 설정 활용

-- DB 생성
CREATE DATABASE Module03;

-- 생성된 DB 확인
SELECT datname FROM pg_database;

-- DB 전환 쿼리가 없어 Navigator에서 queryTool을 생성해야한다.
-- 쉘에서의 방법 -> \c Module03

-- 현재 데이터베이스 컨텍스트를 확인
SELECT current_database();

-- 기본 키 제약조건을 적용한 Category 테이블을 생성
CREATE TABLE Category (
	CategoryNo int,
	CategoryName varchar(20) NOT NULL,

	CONSTRAINT pk_Category PRIMARY KEY(CategoryNo)
);

-- 생성된 테이블 정보 및 제약조건 확인
SELECT column_name, data_type, character_maximum_length, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'category';


CREATE TABLE Product (
    ProductNo int,
    ProductName varchar(100) NOT NULL,
    UnitPrice money,
    Description varchar(4000),
    CategoryNo int,

    CONSTRAINT pk_product PRIMARY KEY(ProductNo),
    CONSTRAINT fk_product_category FOREIGN KEY(CategoryNo) REFERENCES Category(CategoryNo)
);

SELECT column_name, data_type, character_maximum_length, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'product';


CREATE TABLE Customer (
	CustomerNo int,
	CustomerName varchar(10),
	Email varchar(40),
	Password varchar(16)
);


CREATE TABLE Orders (
    OrderNo int,
    OrderDate Date,
    CustomerNo int,

    CONSTRAINT pk_Order PRIMARY KEY(OrderNo),
    CONSTRAINT fk_Order_Customer FOREIGN KEY(CustomerNo) REFERENCES Customer(CustomerNo)
);


CREATE TABLE OrderDetail (
    ProductNo int,
    OrderNo	int,
    Quantity int,

	-- pk를 최소성을 보장하는 후보키로 설정
    CONSTRAINT pk_OrderDetail PRIMARY KEY(ProductNo, OrderNo),
    CONSTRAINT fk_OrderDetail_Order FOREIGN KEY(OrderNo) REFERENCES Orders(OrderNo),
    CONSTRAINT fk_OrderDetail_Product FOREIGN KEY(ProductNo) REFERENCES Product(ProductNo)
);


-- 인덱스 기준 설정하기
SELECT column_name, data_type, character_maximum_length 
FROM information_schema.columns 
WHERE table_name='product';

INSERT INTO Category VALUES(1, 'Novel');
INSERT INTO Category VALUES(2, 'Science');

--  데이터 삽입 순서대로 데이터를 출력된다.
INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (2, 'The Two Towers', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (4, 'Science', 45000, 'Book of Legend', 2);
INSERT INTO Product VALUES (5, 'Newton', 8000, 'Science Magazine', 2);
INSERT INTO Product VALUES (3, 'Return of the King', 25000, 'Book of Legend', 1);

SELECT * FROM Product;

-- Product 테이블의 인덱스를 확인
SELECT tablename, indexname, indexdef 
FROM pg_indexes 
WHERE tablename = 'product';

INSERT INTO Product VALUES (7, 'World War Z', 20000, 'Most interesting book', 1);
INSERT INTO Product VALUES (6, 'Bourne Identity', 18000, 'Spy Novel', 1);

-- 클러스터를 생성
CLUSTER product USING pk_product;
-- 생성된 클러스터에 지정된 인덱스를 기준으로 정렬된다.
SELECT * FROM Product;

-- Product 테이블의 CategoyNo 컬럼에 인덱스를 생성
CREATE INDEX idx_Product_CategoryNo 
ON Product(CategoryNo);

-- Product 테이블의 인덱스를 확인(idx_product_categoryno가 추가됨)
SELECT tablename, indexname, indexdef 
FROM pg_indexes 
WHERE tablename = 'product';

SELECT * FROM Product;

-- Cluster를 다시 클러스터링
CLUSTER product USING pk_product;
CLUSTER product USING idx_product_categoryno;

-- 클러스팅으로 한 인덱스 기준으로 정렬되어 나온다.
SELECT * FROM Product;

-- PostgreSQL에서 인덱스의 사용은 전적으로 Query Optimizer가 결정한다.
-- PostgreSQL에서 인덱스의 사용에 대해서는 https://www.postgresql.org/docs/current/indexes-examine.html를 참조
-- 즉, idx_product_categoryno 기준으로 나와야 했는데
-- PostgreSQL에서의 Query Optimizer의 판단으로 pk_product 기준으로 적용되어 나왔다.
SELECT * FROM Product WHERE CategoryNo > 0;