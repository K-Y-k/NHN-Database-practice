-- �� �� �� ���� ���̺� ������
-- �ε��� ���� ���� Ȱ��

-- ���̺� ����
CREATE TABLE Category (
    CategoryNo int,
    CategoryName varchar(20) NOT NULL,

    CONSTRAINT pk_Category PRIMARY KEY(CategoryNo)
);

-- ������ ���̺� ���� �� �������� Ȯ��
desc category;

CREATE TABLE Product (
    ProductNo NUMBER,
    ProductName varchar2(100) NOT NULL,
    UnitPrice NUMBER(19, 4),
    Description varchar2(4000),
    CategoryNo NUMBER,

    CONSTRAINT pk_product PRIMARY KEY(ProductNo),
    CONSTRAINT fk_product_category FOREIGN KEY(CategoryNo) REFERENCES Category(CategoryNo)
);

CREATE TABLE Customer (
	CustomerNo NUMBER,
	CustomerName varchar2(10),
	Email varchar(40),
	Password varchar(16)
);

ALTER TABLE Customer ADD CONSTRAINT pk_customer PRIMARY KEY(CustomerNo);

CREATE TABLE Orders (
    OrderNo NUMBER,
    OrderDate Date,
    CustomerNo int,

    CONSTRAINT pk_Order PRIMARY KEY(OrderNo),
    CONSTRAINT fk_Order_Customer FOREIGN KEY(CustomerNo) REFERENCES Customer(CustomerNo)
);

CREATE TABLE OrderDetail (
    ProductNo int,
    OrderNo int,
    Quantity int,
    
	-- pk�� �ּҼ��� �����ϴ� �ĺ�Ű�� ����
    CONSTRAINT pk_OrderDetail PRIMARY KEY(ProductNo, OrderNo),
    CONSTRAINT fk_OrderDetail_Order FOREIGN KEY(OrderNo) REFERENCES Orders(OrderNo),
    CONSTRAINT fk_OrderDetail_Product FOREIGN KEY(ProductNo) REFERENCES Product(ProductNo)
);

-- �ش� �÷� Ȯ��
desc Product;

-- ���� ����
INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1);

INSERT INTO Category (CategoryNo, CategoryName)
SELECT 1, 'Novel' FROM DUAL
UNION ALL
SELECT 2, 'Science' FROM DUAL;

SELECT * FROM Category;

INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1);
-- ���� �⺻Ű ������ ����
INSERT INTO Product VALUES (1, 'The Two Towers', 25000, 'Book of Legend', 1);

-- ����� ���� ������ ��µ�
INSERT INTO Product VALUES (2, 'The Two Towers', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (4, 'Science', 45000, 'Book of Legend', 2)
INSERT INTO Product VALUES (5, 'Newton', 8000, 'Science Magazine', 2)
INSERT INTO Product VALUES (3, 'Return of the King', 25000, 'Book of Legend', 1);

-- ���� ���� Ȯ��
SELECT constraint_name, constraint_type, table_name 
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'PRODUCT';

-- ���̺� ���� ���� �ܷ�Ű �������� ���� ����
ALTER TABLE OrderDetail 
DROP CONSTRAINT fk_orderdetail_product;

-- ���̺� ����
DROP TABLE Product;

-- IoT ������ ���̺�� �ٽ� ����
CREATE TABLE Product (
    ProductNo NUMBER,
    ProductName varchar2(100) NOT NULL,
    UnitPrice NUMBER(19, 4),
    Description varchar2(4000),
    CategoryNo NUMBER,

    CONSTRAINT pk_product PRIMARY KEY(ProductNo),
    CONSTRAINT fk_product_category FOREIGN KEY(CategoryNo) REFERENCES Category(CategoryNo)
)
ORGANIZATION INDEX
OVERFLOW TABLESPACE users;

INSERT INTO Product VALUES (1, 'Fellowship of the Rings', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (2, 'The Two Towers', 25000, 'Book of Legend', 1);
INSERT INTO Product VALUES (4, 'Science', 45000, 'Book of Legend', 2);
INSERT INTO Product VALUES (5, 'Newton', 8000, 'Science Magazine', 2);
INSERT INTO Product VALUES (3, 'Return of the King', 25000, 'Book of Legend', 1);

-- �ܷ� Ű �������� ����
ALTER TABLE OrderDetail 
ADD CONSTRAINT fk_OrderDetail_Product FOREIGN KEY(ProductNo) 
REFERENCES Product(ProductNo);

-- �ش� ���̺��� �ε��� Ȯ��
SELECT table_name, index_name, column_name
FROM all_ind_columns
WHERE table_name = 'PRODUCT';

-- �ε��� ����
CREATE INDEX idx_Product_CategoryNo ON Product(CategoryNo);

INSERT INTO Product VALUES (7, 'World War Z', 20000, 'Most interesting book', 1);
INSERT INTO Product VALUES (6, 'Bourne Identity', 18000, 'Spy Novel', 1);

-- ����� �⺻ Ű �������� ���ĵ�����
SELECT * FROM Product

-- �ε����� ������ �ʵ� �������� ��ȸ�ϸ�
-- �ش� �ʵ�� ���ĵȴ�.
SELECT * FROM Product 
WHERE CategoryNo > 0;

