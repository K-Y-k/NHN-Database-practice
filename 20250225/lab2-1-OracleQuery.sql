-- Oracle Database���� ���ο� ����� ������ �����ϱ�
-- CREATE USER ����ھ��̵� IDENTIFIED BY ��й�ȣ
-- 2���� ���� �ش� ����ڰ� ����� �����Ϳ� ���̺��� ������ ���� ����
-- QUOTA ���̺� �ִ� ����� �� �ִ� ũ�� ����
CREATE USER celine IDENTIFIED BY celine;
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users;

-- ���� �⺻���� ��� ���ѵ� ���� �ʱ� ������
-- �ش� ����ڿ��� ���� �ο��� ����� �Ѵ�.
GRANT ALL PRIVILEGES TO celine;

-- ����
CONNECT celine/celine;

-- ���� ������� ��Ű�� Ȯ��
SELECT * FROM tab;

-- ���̺� ����
CREATE TABLE Category (
    CategoryNo int,
    CategoryName varchar2(20)
);

CREATE TABLE Product (
    ProductNo int,
    ProductName varchar2(30),
    Price NUMBER(19, 4),
    CategoryNo int
);

-- ������ ����
INSERT INTO Category VALUES(1, 'Novel');
INSERT INTO Category VALUES(2, 'Poem');
-- ���� ���� (ó�� ������ ���� �ʰ�)
INSERT INTO Category VALUES (3, 'History / Relegion and Magazine');

-- ������ ��ȸ
SELECT * FROM Category;

-- ������ ����
UPDATE Category SET
CategoryName = 'History';

UPDATE Category SET
CategoryName = 'Novel'
WHERE CategoryNo = 1;

UPDATE Category SET
CategoryNo = 3
WHERE CategoryNo = 2;