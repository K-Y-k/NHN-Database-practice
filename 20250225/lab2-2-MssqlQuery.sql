-- ���Ἲ ���� ���� ����

USE Module02
GO

-- �⺻ ������ ����
INSERT INTO Category VALUES(1, 'Novel')
INSERT INTO Category VALUES(3, 'Poem')
INSERT INTO Product (ProductNo, ProductName, Price) VALUES (20101927, 'The Second World War', 37800);


-- �ش� ��Ű�� ���� Ȯ��
EXEC sp_help 'Category';
EXEC sp_help 'Product';


-- �Ϲ� �������� ���� : NULL�� �� �� ����.
ALTER TABLE Category ALTER COLUMN CategoryNo int NOT NULL;


-- ��ü ���Ἲ -> �⺻Ű ��������
-- �⺻Ű ���� ���� ���� : �ߺ��� �⺻Ű���� ������ �� ����.
ALTER TABLE Category ADD CONSTRAINT pk_Category PRIMARY KEY(CategoryNo);

ALTER TABLE Product ALTER COLUMN ProductNo int NOT NULL;
ALTER TABLE Product ADD CONSTRAINT pk_Product PRIMARY KEY(ProductNo);

-- ������ Ȯ��
SELECT * FROM Category;
SELECT * FROM Product;

-- �ߺ��� �⺻Ű ���̶� ����
INSERT INTO Category (CategoryNo, CategoryName) VALUES (3, 'Science');


-- ���� ���Ἲ -> �ܷ�Ű ��������
-- �ܷ�Ű �������� ����1 : �⺻Ű�� ������ �ܷ�Ű�� ���� ��� ���� �Ұ��� (�⺻���� ON DELETE NO ACTION)
ALTER TABLE Product ADD CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) 
REFERENCES Category(CategoryNo);
-- ON UPDATE NO ACTION;

SELECT * FROM Product;

-- ���� �������� �ʴ� �⺻Ű ������ ����/�����Ϸ� �Ͽ� ����
UPDATE Product SET
CategoryNo = 4
WHERE ProductNo = 20101927;
INSERT INTO Product (ProductNo, ProductName, Price, CategoryNo) VALUES (2312211, 'Cosmos', 28800, 4);
-- ���� �ش� �⺻Ű ���� ���ε� �ܷ�Ű Ʃ���� �־ ���� ����
DELETE FROM Category WHERE CategoryNo = 2;


-- �ܷ�Ű �������� ����2 : �⺻Ű�� ������ �ܷ�Ű�� ���� ��� �⺻Ű Ʃ�� ������ �ܷ�Ű ���� NULL�� ��ȯ
ALTER TABLE Product ADD CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) 
REFERENCES Category(CategoryNo) 
ON DELETE SET NULL;
-- ON UPDATE SET NULL;

-- �⺻Ű ������
DELETE FROM Category WHERE CategoryNo = 2;
-- ���ε� �ܷ�Ű CategoryNo = 2���� Ʃ�� ��� NULL�� ��
SELECT * FROM Product;


-- �ܷ�Ű �������� ����3 : �⺻Ű�� ������ �ܷ�Ű�� ���� ��� �⺻Ű Ʃ�� ������ �ܷ�Ű Ʃ�õ� ��� ����
ALTER TABLE Product ADD CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) 
REFERENCES Category(CategoryNo) ON UPDATE CASCADE;

-- �⺻Ű ������
DELETE FROM Category WHERE CategoryNo = 2;
-- ���ε� �ܷ�Ű CategoryNo = 2���� Ʃ�� ��� ���� ������
SELECT * FROM Product;