-- 트랜잭션 내의 작업 복구 방법
USE Module03;

-- 데이터 세팅
INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (4, 'Science', 45000, 'Book of Legend', 2);
INSERT INTO Product VALUES (2, 'The Two Towers', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (5, 'Newton', 8000, 'Science Magazine', 2);
INSERT INTO Product VALUES (3, 'Return of the King', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (7, 'World War Z', 20000, 'Most interesting book', 1);
INSERT INTO Product VALUES (6, 'Bourne Identity', 18000, 'Spy Novel', 1);

SELECT * FROM Product;

-- 영구적인 트랜잭션 시작 선언
START TRANSACTION;
-- 트랜잭션 안에서의 작업 후 확인
DELETE FROM Product;
SELECT * FROM Product;
-- 트랜잭션 안에서의 작업들 취소
ROLLBACK;