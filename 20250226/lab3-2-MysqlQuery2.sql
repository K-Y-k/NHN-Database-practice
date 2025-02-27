-- 전체 DB 조회
show databases;
-- 현재 DB 조회
SELECT database();

USE Module03;

desc Product;
-- 참조관계인 기본키인 CategoryNo가 존재하지 않는 값을 넣어서 실패
INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1);

INSERT INTO Category VALUES(1, 'Novel');
INSERT INTO Category VALUES(2, 'Science');

INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (4, 'Science', 45000, 'Book of Legend', 2);
INSERT INTO Product VALUES (2, 'The Two Towers', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (5, 'Newton', 8000, 'Science Magazine', 2);
INSERT INTO Product VALUES (3, 'Return of the King', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (7, 'World War Z', 20000, 'Most interesting book', 1);
INSERT INTO Product VALUES (6, 'Bourne Identity', 18000, 'Spy Novel', 1);

-- 저장된 순서가 아닌 기본키 기준으로 정렬되어 나옴
SELECT * FROM Product;

-- CategoryNo 기준의 인덱스 생성
CREATE INDEX idx_Product_CategoryNo ON Product(CategoryNo);

-- 생성된 인덱스들 확인
show index FROM Product;

-- CategoryNo 기준으로 정렬되어 나옴
SELECT * FROM Product
WHERE CategoryNo > 0;
