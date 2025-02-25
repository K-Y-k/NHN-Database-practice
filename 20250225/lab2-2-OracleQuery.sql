-- ���Ἲ ���� ����

-- �ش� ���̺� ���� Ȯ��
desc Category;

-- �ش� ���̺��� �������� Ȯ��
SELECT OWNER, CONSTRAINT_NAME, TABLE_NAME FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'CATEGORY';


-- ��ü ���Ἲ -> �⺻Ű ��������
-- �⺻Ű ���� ���� ���� : �ߺ��� �⺻Ű���� ������ �� ����.
ALTER TABLE Category ADD CONSTRAINT pk_Category PRIMARY KEY(CategoryNo);
ALTER TABLE Product ADD CONSTRAINT pk_Product PRIMARY KEY(ProductNo);


-- ���� ���Ἲ -> �ܷ�Ű ��������
-- �ܷ�Ű �������� ����1 : �⺻Ű�� ������ �ܷ�Ű�� ���� ��� ���� �Ұ��� (�⺻���� ON DELETE NO ACTION)
ALTER TABLE Product ADD CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) 
REFERENCES Category(CategoryNo);
-- ON UPDATE NO ACTION;

-- �ܷ�Ű �������� ����2 : �⺻Ű�� ������ �ܷ�Ű�� ���� ��� �⺻Ű Ʃ�� ������ �ܷ�Ű ���� NULL�� ��ȯ
ALTER TABLE Product ADD CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) 
REFERENCES Category(CategoryNo) 
ON DELETE SET NULL;
-- ON UPDATE SET NULL;

-- �ܷ�Ű �������� ����3 : �⺻Ű�� ������ �ܷ�Ű�� ���� ��� �⺻Ű Ʃ�� ������ �ܷ�Ű Ʃ�õ� ��� ����
-- ��, ����Ŭ�� ON UPDATE ������ ����. -> �ٸ� ��� = Ʈ���Ÿ� ���
ALTER TABLE Product ADD CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) 
REFERENCES Category(CategoryNo) 
ON DELETE CASCADE;
