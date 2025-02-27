CREATE TABLE SampleTable (
	no int,
	name varchar(10)
)

INSERT INTO SampleTable (no, name) VALUES (3, 'b');
INSERT INTO SampleTable (no, name) VALUES (1, 'e');
INSERT INTO SampleTable (no, name) VALUES (2, 'c');
INSERT INTO SampleTable (no, name) VALUES (5, 'f');
INSERT INTO SampleTable (no, name) VALUES (4, 'a');

-- Scan
-- 정렬되지 않은 힙 구조이다.
SELECT * FROM SampleTable;

-- Equality Selection
SELECT * FROM SampleTable
WHERE no = 2;

-- Range Selection
SELECT * FROM SampleTable
WHERE no Between 2 and 4;

-- 기본키로 제약 설정할 경우
ALTER TABLE SampleTable
ALTER COLUMN no INT NOT NULL;

ALTER TABLE SampleTable 
ADD CONSTRAINT pk_sample PRIMARY KEY(no);

-- 기본 키를 설정하면, 클러스터드 인덱스가 자동으로 생성되어 
-- 삽입된 순서가 아닌 기본 키 기준의 정렬된 구조로 된다.
SELECT * FROM SampleTable;


-- 이름 기준으로 인덱스 생성 (넌 클러스터드 인덱스)
CREATE INDEX idx_sample_name ON SampleTable(name);

-- QueryOptimizer가 name 기준의 인덱스로 판단하고 name 기준으로 정렬을 실행한다.
SELECT * FROM SampleTable
WHERE name > '';

-- QueryOptimizer가 no 기준의 인덱스로 판단하고 no 기준으로 정렬을 실행한다.
SELECT * FROM SampleTable
WHERE no > 0;


-- 인덱스 기준을 수동으로 설정 방법
SELECT * FROM SampleTable WITH(INDEX(pk_sample))
WHERE name > '';

SELECT * FROM SampleTable WITH(INDEX(idx_sample_name))
WHERE no > 0;
