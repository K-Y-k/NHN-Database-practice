-- �����ͺ��̽� ����� Ȯ��
-- GO�� SQL Server���� ���� SQL ��ɾ �����ϰ� ��ġ ó���� �� �� �ְ� �����ִ� ����
-- ��, ������ �ӽ� ���̺� ���� ��ġ ���� �������� �ʴ´�.
-- GO ���� ���� ��ɾ�� ���ο� Ʈ����ǿ��� ����
SELECT name, database_id
FROM sys.databases;
GO

-- �����ͺ��̽� ����
CREATE DATABASE Module02
GO

-- �ش� �����ͺ��̽� ���
USE Module02
GO

-- �ش� �����ͺ��̽��� �����̼�(������ �����ͺ��̽� �������� ���̺�)�� Ȯ��
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'

-- ���̺�(�����̼�) ����
CREATE TABLE Category (
    CategoryNo int,
    CategoryName NVARCHAR(20)
)
GO

CREATE TABLE Product (
	ProductNo	int,
	ProductName	NVARCHAR(30),
    Price		MONEY,
    CategoryNo	int
)
GO

-- �ش� ���̺��� ����� ������ ��ȸ
SELECT * FROM Category;

-- ������ ����
INSERT INTO Category VALUES(1, 'Novel')
INSERT INTO Category VALUES(2, 'Poem')

-- ���� ���� (ó�� ������ �ִ� ���� �ʰ�)
INSERT INTO Category VALUES (3, 'History / Relegion and Magazine')

-- ������ ����
UPDATE Category SET
CategoryName = 'History'

UPDATE Category SET
CategoryName = 'Novel'
WHERE CategoryNo = 1;

UPDATE Category SET
CategoryNo = 3
WHERE CategoryNo = 2;

-- ������ ����
DELETE Category
WHERE CategoryNo = 1;