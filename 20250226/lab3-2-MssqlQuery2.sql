-- 해당 테이블 컬럼 확인
SELECT COLUMN_NAME, IS_NULLABLE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Product';


-- 참조관계인 기본키인 CategoryNo가 존재하지 않는 값을 넣어서 실패
INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1);

-- CategoryNo 데이터를 넣고 다시 넣기
INSERT INTO Category VALUES(1, 'Novel'), (2, 'Science');
INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1)

SELECT * FROM Category;

INSERT INTO Product VALUES (2, 'The Two Towers', 25000, 'Book of Legend', 2)
INSERT INTO Product VALUES (4, 'Science', 45000, 'Book of Legend', 1)
INSERT INTO Product VALUES (5, 'Newton', 8000, 'Science Magazine', 1)
INSERT INTO Product VALUES (3, 'Return of the King', 25000, 'Book of Legend', 2)
INSERT INTO Product VALUES (7, 'World War Z', 20000, 'Most interesting book', 1)
INSERT INTO Product VALUES (6, 'Bourne Identity', 18000, 'Spy Novel', 1)
-- 기본키 기준으로 저장되며 정렬된다.
SELECT * FROM Product;

-- CategoryNo 기준의 인덱스 생성
CREATE INDEX idx_product_categoryno ON Product(CategoryNo);

-- 생성된 인덱스들 확인
SELECT t.name, i.name, i.index_id, i.type, i.type_desc
FROM sys.tables t INNER JOIN sys.indexes i
    ON t.object_id = i.object_id
WHERE t.name = 'Product'

-- CategoryNo 기준으로 설정하여 정렬되어 나옴
SELECT * FROM Product WITH (INDEX(idx_product_categoryno))
WHERE CategoryNo > 0;

-- MSSQL에서는 PRIMARY 키워드를 지원하지 않아서
-- 인덱스를 CREATE 해주거나 
-- ALTER에서 기본키 제약조건을 추가할 때의 키명을 선언해서 사용한다.
SELECT * FROM Product WITH (INDEX(--PRIMARY))
WHERE CategoryNo > 0;


SELECT ProductNo, ProductName, CategoryNo
FROM Product --WITH (INDEX(idx_product_categoryno))
WHERE CategoryNo IN(1,2);

