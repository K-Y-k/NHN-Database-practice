-- �� �� �� ���� ���̺� ������

-- �����ͺ��̽��� ����
CREATE DATABASE Module03
GO
-- ���� ���ؽ�Ʈ�� ������ Module03 �����ͺ��̽��� ����
USE Module03
GO

-- ������ Module03 �����ͺ��̽��� ���̺��� Ȯ��
SELECT * FROM INFORMATION_SCHEMA.Tables 
WHERE TABLE_TYPE = 'base table'

-- ���̺� ����
CREATE TABLE Category (
    CategoryNo int,
    CategoryName varchar(20) NOT NULL

    CONSTRAINT pk_Category PRIMARY KEY(CategoryNo)
)

-- ������ ���̺� ������ Ȯ��
SELECT COLUMN_NAME, IS_NULLABLE, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Category'


CREATE TABLE Product (
    ProductNo int PRIMARY KEY,
    ProductName varchar(100) NOT NULL,
    UnitPrice money DEFAULT 0 NOT NULL,
    Description nvarchar(max),
    CategoryNo int

    CONSTRAINT fk_Product_CategoryID FOREIGN KEY(CategoryNo) REFERENCES Category(CategoryNo)
)

SELECT COLUMN_NAME, IS_NULLABLE, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Product'

CREATE TABLE Customer (
	CustomerNo int,
	CustomerName nvarchar(10),
	Email varchar(40),
	Password varchar(16),
)

-- ������ ���̺��� �ε��� Ÿ���� Ȯ��
-- Category�� Product�� PK�� ���������Ƿ� ���� b-Ʈ�� ����� CLUSTERED�̰�
-- Customer�� PK�� ������ �����Ƿ� Heap
SELECT t.name, i.index_id, i.type, i.type_desc
FROM sys.tables t 
INNER JOIN sys.indexes i
ON t.object_id = i.object_id

--  Customer ���̺��� PRIMARY KEY�� ���� ������ Heap �̶� ����
CREATE TABLE Orders (
	OrderNo int,
	OrderDate Date,
	CustomerNo int,

	CONSTRAINT pk_Order PRIMARY KEY(OrderNo),
	CONSTRAINT fk_Order_Customer FOREIGN KEY(CustomerNo)
	REFERENCES Customer(CustomerNo)
)

-- Customer ���̺��� CustomerNo �÷��� PRIMARY KEY ���������� ����
-- �Ϲ� �������� ����
ALTER TABLE Customer ALTER COLUMN CustomerNo int NOT NULL
GO
-- �⺻Ű ����
ALTER TABLE Customer ADD CONSTRAINT pk_Customer PRIMARY KEY(CustomerNo)

SELECT t.name, i.name, i.index_id, i.type, i.type_desc
FROM sys.tables t INNER JOIN sys.indexes i
ON t.object_id = i.object_id


CREATE TABLE OrderDetail (
    ProductNo int,
    OrderNo	int,
    Quantity int,

	-- �ּҼ��� �ĺ�Ű�� �⺻Ű�� ����
    CONSTRAINT pk_OrderDetail PRIMARY KEY(ProductNo, OrderNo),
    CONSTRAINT fk_OrderDetail_Order FOREIGN KEY(OrderNo) REFERENCES Orders(OrderNo),
    CONSTRAINT fk_OrderDetail_Product FOREIGN KEY(ProductNo) REFERENCES Product(ProductNo)
)