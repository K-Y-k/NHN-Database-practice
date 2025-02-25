-- 무결성 제약 조건 설정

USE Module02
GO

-- 기본 데이터 세팅
INSERT INTO Category VALUES(1, 'Novel')
INSERT INTO Category VALUES(3, 'Poem')
INSERT INTO Product (ProductNo, ProductName, Price) VALUES (20101927, 'The Second World War', 37800);


-- 해당 스키마 정보 확인
EXEC sp_help 'Category';
EXEC sp_help 'Product';


-- 일반 제약조건 설정 : NULL이 될 수 없다.
ALTER TABLE Category ALTER COLUMN CategoryNo int NOT NULL;


-- 개체 무결성 -> 기본키 제약조건
-- 기본키 제약 조건 설정 : 중복된 기본키값이 존재할 수 없다.
ALTER TABLE Category ADD CONSTRAINT pk_Category PRIMARY KEY(CategoryNo);

ALTER TABLE Product ALTER COLUMN ProductNo int NOT NULL;
ALTER TABLE Product ADD CONSTRAINT pk_Product PRIMARY KEY(ProductNo);

-- 데이터 확인
SELECT * FROM Category;
SELECT * FROM Product;

-- 중복된 기본키 값이라 실패
INSERT INTO Category (CategoryNo, CategoryName) VALUES (3, 'Science');


-- 참조 무결성 -> 외래키 제약조건
-- 외래키 제약조건 설정1 : 기본키에 참조된 외래키가 있을 경우 삭제 불가능 (기본값이 ON DELETE NO ACTION)
ALTER TABLE Product ADD CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) 
REFERENCES Category(CategoryNo);
-- ON UPDATE NO ACTION;

SELECT * FROM Product;

-- 현재 존재하지 않는 기본키 값으로 변경/삽입하려 하여 실패
UPDATE Product SET
CategoryNo = 4
WHERE ProductNo = 20101927;
INSERT INTO Product (ProductNo, ProductName, Price, CategoryNo) VALUES (2312211, 'Cosmos', 28800, 4);
-- 현재 해당 기본키 값과 매핑된 외래키 튜플이 있어서 삭제 실패
DELETE FROM Category WHERE CategoryNo = 2;


-- 외래키 제약조건 설정2 : 기본키에 참조된 외래키가 있을 경우 기본키 튜플 삭제시 외래키 값을 NULL로 변환
ALTER TABLE Product ADD CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) 
REFERENCES Category(CategoryNo) 
ON DELETE SET NULL;
-- ON UPDATE SET NULL;

-- 기본키 삭제시
DELETE FROM Category WHERE CategoryNo = 2;
-- 매핑된 외래키 CategoryNo = 2였던 튜플 모두 NULL로 됨
SELECT * FROM Product;


-- 외래키 제약조건 설정3 : 기본키에 참조된 외래키가 있을 경우 기본키 튜플 삭제시 외래키 튜플도 모두 삭제
ALTER TABLE Product ADD CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) 
REFERENCES Category(CategoryNo) ON UPDATE CASCADE;

-- 기본키 삭제시
DELETE FROM Category WHERE CategoryNo = 2;
-- 매핑된 외래키 CategoryNo = 2였던 튜플 모두 같이 삭제됨
SELECT * FROM Product;