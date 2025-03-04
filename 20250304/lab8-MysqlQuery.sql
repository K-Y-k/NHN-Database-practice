show databases;
use module06;

-- 카테고리에 여러 서브 카테고리가 있는데
-- 서브 카테고리에 또 서브 카테고리가 이어져 있고 이 깊이가 모두 다르면
-- 카테고리 테이블 자기 자신과 관계를 맺는다.
CREATE TABLE Category (
	CategoryNo int,
    Name varchar(10),
    SuperCategoryNo int,
    
    CONSTRAINT pk_Category PRIMARY KEY(CategoryNo),
    CONSTRAINT fk_Category_superCategry FOREIGN KEY(SuperCategoryNo)
    REFERENCES Category(CategoryNo)
);

INSERT INTO Category VALUES(1, '국내도서', NULL);
INSERT INTO Category VALUES(2, '외국도서', NULL);
INSERT INTO Category VALUES(3, '가정/살림', 1);
INSERT INTO Category VALUES(4, '육아', 3);

SELECT * FROM Category;


-- 직장 직원 erd를 직접 쿼리로 만들기
-- 직원
CREATE TABLE Employee (
	EmployeeNo int,
    Name varchar(10),
    
    CONSTRAINT pk_Employee PRIMARY KEY(EmployeeNo)
);
-- 직장
CREATE TABLE Office (
	OfficeNo int,
    City varchar(20),
    
    CONSTRAINT pk_Office PRIMARY KEY(OfficeNo)
);
-- 장소
CREATE TABLE Location (
	LocationNo int,
    Name varchar(20),
    
    CONSTRAINT pk_Location PRIMARY KEY(LocationNo)
);
-- 근무
CREATE TABLE Work (
	EmployeeNo int,
    OfficeNo int,
	LocationNo int,
    
    CONSTRAINT pk_Work PRIMARY KEY(EmployeeNo, OfficeNo, LocationNo),
    CONSTRAINT fk_Work_Employee FOREIGN KEY(EmployeeNo) REFERENCES Employee(EmployeeNo),
    CONSTRAINT fk_Work_Office FOREIGN KEY(OfficeNo) REFERENCES Office(OfficeNo),
    CONSTRAINT fk_Work_Location FOREIGN KEY(LocationNo) REFERENCES Location(LocationNo)
);

DROP TABLE Work;
DROP TABLE Employee;
DROP TABLE Office;
DROP TABLE Location;
