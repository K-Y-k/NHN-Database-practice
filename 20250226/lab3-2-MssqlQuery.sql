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

-- 기본키로 설정할 경우
ALTER TABLE SampleTable
ALTER COLUMN no INT NOT NULL;

ALTER TABLE SampleTable 
ADD CONSTRAINT pk_sample PRIMARY KEY(no);

-- 기본 키를 설정하면, 클러스터드 인덱스가 자동으로 생성되어 정렬된 구조로 된다.
SELECT * FROM SampleTable;
