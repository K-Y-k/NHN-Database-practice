-- 인덱스 기준 설정 활용

-- DB 생성
CREATE DATABASE Sample;
USE Sample;

-- 기본 키 설정과 함께 테이블 생성
CREATE TABLE SampleTable (
	no int PRIMARY KEY,
	name varchar(10)
);

INSERT INTO SampleTable VALUES(2, 'Celine');
INSERT INTO SampleTable VALUES(3, 'James');
INSERT INTO SampleTable VALUES(5, 'Jason');
INSERT INTO SampleTable VALUES(7, 'Albert');
INSERT INTO SampleTable VALUES(1, 'Bob');
INSERT INTO SampleTable VALUES(6, 'Cleck');
INSERT INTO SampleTable VALUES(4, 'Peter');
INSERT INTO SampleTable VALUES(8, 'Stephie');
INSERT INTO SampleTable VALUES(9, 'Dape');

-- 기본 키를 설정하면, 클러스터드 인덱스가 자동으로 생성되어 정렬된 구조로 된다.
SELECT * FROM SampleTable;

-- name 필드를 기준으로 인덱스를 새로 생성
CREATE INDEX idx_sample ON SampleTable(name);

-- name 기준으로
-- QueryOptimizer가 기본키의 클러스터드 인덱스 보다 name 기준의 인덱스가 더 빠르다고 판단하여 실행게획을 name 기준으로 세운 것이다!!
SELECT * FROM SampleTable;

-- 숫자를 기준으로 검색하면 QueryOptimizer가 no 기준의 인덱스가 더 빠르다고 판단하고 사용
EXPLAIN SELECT * FROM SampleTable 
WHERE no > 0;

-- 이름 기준으로 검색하면 QueryOptimizer가 name 기준의 인덱스가 더 빠르다고 판단하고 사용
SELECT * FROM SampleTable 
WHERE name > '';