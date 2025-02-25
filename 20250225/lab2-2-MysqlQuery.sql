-- 무결성 제약 조건을 만들어보기

-- 현재 속성들에 제약조건들이 업고 기본키도 없다.
desc Category;


-- 개체 무결성 -> 해당 테이블에 기본키 제약조건 설정
ALTER TABLE Category ADD CONSTRAINT pk_category PRIMARY KEY(CategoryNo);
ALTER TABLE Product ADD CONSTRAINT pk_Product PRIMARY KEY(ProductNo);
-- CategoryNo와 ProductNo에 PRI가 설정된 것을 확인
desc Category;
desc Product;

-- 현재 기본키에 중복된 값을 넣으려고 하면 기본키의 제약조건인 중복 허용X에 걸린다. 
INSERT INTO Category (Category, CategoryName) VALUES(3 'Science');
-- 현재 기본키에 중복된 값을 넣으려고 하면 기본키의 제약조건인 값이 존재해야하는 부분에서 걸린다.
INSERT INTO Category (CategoryName) VALUES('Science');

INSERT INTO Product (ProductNo, ProductName, Price) VALUES(20101927, 'The Second World War', 37800);
SELECT * FROM Product;


-- 참조 무결성 -> 외래키 제약조건 설정
-- 참조하는 쪽(= 외래키)에서 설정해야 한다.

-- 참조관계인 기본키 튜플이 삭제될 경우 참조된 릴레이션의 외래키 값으 NULL로 변경해주는 설정
ALTER TABLE Product ADD CONSTRAINT fk_product_category FOREIGN KEY(CategoryNo) 
REFERENCES Category(CategoryNo)
ON DELETE SET NULL;
-- Product에 외래키인 CategoryNo가 설정된 것을 확인
desc Product;
SELECT * FROM Product;

-- 현재 Category 테이블에 CategoryNo에 2인 튜플이 존재하지 않아서 실패
UPDATE Product SET
CategoryNo = 2
WHERE ProductNo = 20101927;
-- 현재 CategoryNo에 3인 튜플이 존재하여 변경 성공
UPDATE Product SET
CategoryNo = 3
WHERE ProductNo = 20101927;

INSERT INTO Product (ProductNo, ProductName, Price, CategoryNo) VALUES (97422537, 'Hobbit', 28800, 1);
INSERT INTO Product (ProductNo, ProductName, Price, CategoryNo) VALUES (97422515, 'Lord of the Rings 1', 28800, 1);

-- Category의 데이터를 삭제하려 했지만 이미 참조관계인 릴레이션에 외래키가 있는 튜플이 있어 삭제 불가능
DELETE FROM Category
WHERE CategoryNo = 3;

-- 테이블에 설정된 제약조건을 모두 조회
SELECT * FROM information_schema.table_constraints WHERE table_name='product';

-- 제약 조건 삭제
ALTER TABLE Product DROP CONSTRAINT fk_product_category;

-- 참조관계인 기본키 튜플이 삭제될 경우 참조된 릴레이션의 외래키인 튜플도 같이 삭제 설정 cascade
Alter TABLE Product
ADD CONSTRAINT fk_product_category FOREIGN KEY(CategoryNo)
REFERENCES Category(CategoryNo)
ON DELETE CASCADE;

DELETE FROM Category
WHERE CategoryNo = 3;

SELECT * FROM Category;
SELECT * FROM Product;

-- INSERT INTO Category VALUES (3, 'History');

-- 참조관계인 기본키 튜플이 삭제될 경우 참조된 릴레이션의 외래키인 튜플이 있으면 삭제를 거부하도록 설정
Alter TABLE Product
ADD CONSTRAINT fk_product_category FOREIGN KEY(CategoryNo)
REFERENCES Category(CategoryNo)
ON DELETE NO ACTION;

-- 도메인 무결성

