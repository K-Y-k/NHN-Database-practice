-- 다 대 다 관계 테이블 생성법
-- 인덱스 기준 설정 활용

-- 테이블 생성
CREATE TABLE Category (
    CategoryNo int,
    CategoryName varchar(20) NOT NULL,

    CONSTRAINT pk_Category PRIMARY KEY(CategoryNo)
);

-- 생성된 테이블 정보 및 제약조건 확인
desc category;

CREATE TABLE Product (
    ProductNo NUMBER,
    ProductName varchar2(100) NOT NULL,
    UnitPrice NUMBER(19, 4),
    Description varchar2(4000),
    CategoryNo NUMBER,

    CONSTRAINT pk_product PRIMARY KEY(ProductNo),
    CONSTRAINT fk_product_category FOREIGN KEY(CategoryNo) REFERENCES Category(CategoryNo)
);

CREATE TABLE Customer (
	CustomerNo NUMBER,
	CustomerName varchar2(10),
	Email varchar(40),
	Password varchar(16)
);

ALTER TABLE Customer ADD CONSTRAINT pk_customer PRIMARY KEY(CustomerNo);

CREATE TABLE Orders (
    OrderNo NUMBER,
    OrderDate Date,
    CustomerNo int,

    CONSTRAINT pk_Order PRIMARY KEY(OrderNo),
    CONSTRAINT fk_Order_Customer FOREIGN KEY(CustomerNo) REFERENCES Customer(CustomerNo)
);

CREATE TABLE OrderDetail (
    ProductNo int,
    OrderNo int,
    Quantity int,
    
	-- pk를 최소성을 보장하는 후보키로 설정
    CONSTRAINT pk_OrderDetail PRIMARY KEY(ProductNo, OrderNo),
    CONSTRAINT fk_OrderDetail_Order FOREIGN KEY(OrderNo) REFERENCES Orders(OrderNo),
    CONSTRAINT fk_OrderDetail_Product FOREIGN KEY(ProductNo) REFERENCES Product(ProductNo)
);

-- 해당 컬럼 확인
desc Product;

-- 삽입 실패
INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1);

INSERT INTO Category (CategoryNo, CategoryName)
SELECT 1, 'Novel' FROM DUAL
UNION ALL
SELECT 2, 'Science' FROM DUAL;

SELECT * FROM Category;

INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1);
-- 같은 기본키 값으로 실패
INSERT INTO Product VALUES (1, 'The Two Towers', 25000, 'Book of Legend', 1);

-- 현재는 삽입 순으로 출력됨
INSERT INTO Product VALUES (2, 'The Two Towers', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (4, 'Science', 45000, 'Book of Legend', 2)
INSERT INTO Product VALUES (5, 'Newton', 8000, 'Science Magazine', 2)
INSERT INTO Product VALUES (3, 'Return of the King', 25000, 'Book of Legend', 1);

-- 제약 조건 확인
SELECT constraint_name, constraint_type, table_name 
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'PRODUCT';

-- 테이블 삭제 전에 외래키 제약조건 먼저 삭제
ALTER TABLE OrderDetail 
DROP CONSTRAINT fk_orderdetail_product;

-- 테이블 삭제
DROP TABLE Product;

-- IoT 형태의 테이블로 다시 생성
CREATE TABLE Product (
    ProductNo NUMBER,
    ProductName varchar2(100) NOT NULL,
    UnitPrice NUMBER(19, 4),
    Description varchar2(4000),
    CategoryNo NUMBER,

    CONSTRAINT pk_product PRIMARY KEY(ProductNo),
    CONSTRAINT fk_product_category FOREIGN KEY(CategoryNo) REFERENCES Category(CategoryNo)
)
ORGANIZATION INDEX
OVERFLOW TABLESPACE users;

INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (2, 'The Two Towers', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (4, 'Science', 45000, 'Book of Legend', 2);
INSERT INTO Product VALUES (5, 'Newton', 8000, 'Science Magazine', 2);
INSERT INTO Product VALUES (3, 'Return of the King', 25000, 'Book of Legend', 1);

-- 외래 키 제약조건 설정
ALTER TABLE OrderDetail 
ADD CONSTRAINT fk_OrderDetail_Product FOREIGN KEY(ProductNo) 
REFERENCES Product(ProductNo);

-- 해당 테이블의 인덱스 확인
SELECT table_name, index_name, column_name
FROM all_ind_columns
WHERE table_name = 'PRODUCT';

-- 인덱스 생성
CREATE INDEX idx_Product_CategoryNo ON Product(CategoryNo);

INSERT INTO Product VALUES (7, 'World War Z', 20000, 'Most interesting book', 1);
INSERT INTO Product VALUES (6, 'Bourne Identity', 18000, 'Spy Novel', 1);

-- 현재는 기본 키 기준으로 정렬되지만
SELECT * FROM Product

-- 인덱스를 생성한 필드 기준으로 조회하면
-- 해당 필드로 정렬된다.
SELECT * FROM Product 
WHERE CategoryNo > 0;

