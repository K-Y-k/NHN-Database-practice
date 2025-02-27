-- �ش� ���̺� �÷� Ȯ��
SELECT COLUMN_NAME, IS_NULLABLE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Product';


-- ���������� �⺻Ű�� CategoryNo�� �������� �ʴ� ���� �־ ����
INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1);

-- CategoryNo �����͸� �ְ� �ٽ� �ֱ�
INSERT INTO Category VALUES(1, 'Novel'), (2, 'Science');
INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1)

SELECT * FROM Category;

INSERT INTO Product VALUES (2, 'The Two Towers', 25000, 'Book of Legend', 2)
INSERT INTO Product VALUES (4, 'Science', 45000, 'Book of Legend', 1)
INSERT INTO Product VALUES (5, 'Newton', 8000, 'Science Magazine', 1)
INSERT INTO Product VALUES (3, 'Return of the King', 25000, 'Book of Legend', 2)
INSERT INTO Product VALUES (7, 'World War Z', 20000, 'Most interesting book', 1)
INSERT INTO Product VALUES (6, 'Bourne Identity', 18000, 'Spy Novel', 1)
-- �⺻Ű �������� ����Ǹ� ���ĵȴ�.
SELECT * FROM Product;

-- CategoryNo ������ �ε��� ����
CREATE INDEX idx_product_categoryno ON Product(CategoryNo);

-- ������ �ε����� Ȯ��
SELECT t.name, i.name, i.index_id, i.type, i.type_desc
FROM sys.tables t INNER JOIN sys.indexes i
    ON t.object_id = i.object_id
WHERE t.name = 'Product'

-- CategoryNo �������� �����Ͽ� ���ĵǾ� ����
SELECT * FROM Product WITH (INDEX(idx_product_categoryno))
WHERE CategoryNo > 0;

-- MSSQL������ PRIMARY Ű���带 �������� �ʾƼ�
-- �ε����� CREATE ���ְų� 
-- ALTER���� �⺻Ű ���������� �߰��� ���� Ű���� �����ؼ� ����Ѵ�.
SELECT * FROM Product WITH (INDEX(--PRIMARY))
WHERE CategoryNo > 0;


SELECT ProductNo, ProductName, CategoryNo
FROM Product --WITH (INDEX(idx_product_categoryno))
WHERE CategoryNo IN(1,2);

