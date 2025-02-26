-- 다 대 다 관계 테이블 생성법
-- Mysql에서의 MyISAM 엔진과 InnoDB엔진

-- DB 세팅
show databases;
CREATE DATABASE Module03;
use Module03;

CREATE TABLE Category (
	CategoryNo int,
    CategoryName varchar(50) NOT NULL,
    CONSTRAINT pk_Category PRIMARY KEY(CategoryNo)
);

-- 해당 테이블 필드 및 제약조건 확인
desc Category;

-- 해당 테이블 생성했었던 쿼리 자세한 정보 확인
-- ENGINE=InnoDB는 MySQL에서 InnoDB 스토리지 엔진을 사용하여 테이블을 생성하겠다는 의미 
-- 스토리지 엔진은 데이터베이스 테이블의 저장 방식과 데이터 처리 방식을 결정하는 중요한 요소로
-- InnoDB는 가장 널리 사용되는 스토리지 엔진이다.
show create table Category;

CREATE TABLE Product (
	ProductNo int PRIMARY KEY,
    -- NULL 제약조건 설정
    ProductName varchar(100) NOT NULL,
    -- DEFAULT는 기본값 설정(중요하다!)
    UnitPrice int DEFAULT 0 NOT NULL,
    Description text,
    CategoryNo int,
    CONSTRAINT fk_Product_CategoryID FOREIGN KEY(CategoryNo) 
    REFERENCES Category(CategoryNo)
);
desc Product;


-- NVARCHAR와 VARCHAR는 문자 인코딩 방식에 차이가 있다.
-- VARCHAR는 각 문자를 1바이트로 저장하는 방식으로, 주로 ASCII 문자셋을 사용하므로 영어와 같은 문자에서는 공간을 절약한다.
-- NVARCHAR는 유니코드 인코딩을 사용하므로, 각 문자를 2바이트로 저장하므로 VARCHAR보다 더 많은 저장 용량이 필요하다.

-- 여기서는 ENGINE=MyISAM으로 설정하였다. 
-- MyISAM은 트랜잭션과 외래 키 제약을 지원하지 않는다, 테이블 잠금 방식으로 한 번에 한 프로세스만 테이블에 접근 
--         sequence 컬럼일 경우 성능이 더 유리하고 읽기 성능이 좋다.
-- InnoDB는 b트리구조로 트랜젝션과 외래 키 제약을 지원하고, 행 잠금 방식으로 여러 사용자가 같은 테이블의 다른 행을 동시에 수정
--         쓰기 성능이 좋다. 데이터 무결성 유지
CREATE TABLE Customer (
	CustomerNo int,
    CustomerName nvarchar(10),
    Email varchar(40),
    Password varchar(16),
    CONSTRAINT pk_Customer PRIMARY KEY(CustomerNo)
) ENGINE=MyISAM CHARSET=utf8;
show create table Customer;

-- Customer에서의 엔진인 MyISAM과 
-- Oreders에서의 엔진인 InnoDB는 서로 호환이 안된다.
CREATE TABLE Orders (
	OrderNo int,
    OrderDate Date,
    CustomerNo int,
    
    CONSTRAINT pk_Order PRIMARY KEY(OrderNo),
    CONSTRAINT fk_Order_Customer FOREIGN KEY(CustomerNo)
    REFERENCES Customer(CustomerNo)
);

-- 엔진 변경
ALTER TABLE Customer ENGINE=INNODB;

CREATE TABLE OrderDetail (
	ProductNo int,
	OrderNo	int,
	Quantity int,

	CONSTRAINT pk_OrderDetail PRIMARY KEY(ProductNo, OrderNo),
    CONSTRAINT fk_OrderDetail_Order FOREIGN KEY(OrderNo) REFERENCES Orders(OrderNo),
    CONSTRAINT fk_OrderDetail_Product FOREIGN KEY(ProductNo) REFERENCES Product(ProductNo)
);