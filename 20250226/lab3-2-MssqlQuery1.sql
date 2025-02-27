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
-- ���ĵ��� ���� �� �����̴�.
SELECT * FROM SampleTable;

-- Equality Selection
SELECT * FROM SampleTable
WHERE no = 2;

-- Range Selection
SELECT * FROM SampleTable
WHERE no Between 2 and 4;

-- �⺻Ű�� ���� ������ ���
ALTER TABLE SampleTable
ALTER COLUMN no INT NOT NULL;

ALTER TABLE SampleTable 
ADD CONSTRAINT pk_sample PRIMARY KEY(no);

-- �⺻ Ű�� �����ϸ�, Ŭ�����͵� �ε����� �ڵ����� �����Ǿ� 
-- ���Ե� ������ �ƴ� �⺻ Ű ������ ���ĵ� ������ �ȴ�.
SELECT * FROM SampleTable;


-- �̸� �������� �ε��� ���� (�� Ŭ�����͵� �ε���)
CREATE INDEX idx_sample_name ON SampleTable(name);

-- QueryOptimizer�� name ������ �ε����� �Ǵ��ϰ� name �������� ������ �����Ѵ�.
SELECT * FROM SampleTable
WHERE name > '';

-- QueryOptimizer�� no ������ �ε����� �Ǵ��ϰ� no �������� ������ �����Ѵ�.
SELECT * FROM SampleTable
WHERE no > 0;


-- �ε��� ������ �������� ���� ���
SELECT * FROM SampleTable WITH(INDEX(pk_sample))
WHERE name > '';

SELECT * FROM SampleTable WITH(INDEX(idx_sample_name))
WHERE no > 0;
