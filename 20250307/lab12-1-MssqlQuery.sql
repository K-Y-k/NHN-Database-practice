-- Ʈ����� �۾� ����
-- Mssql������ Ʈ����� ������ ������ �� ����� �����Ǿ� �ٸ� ����ڵ��� ���� ��ü�� �Ұ����ϴ�.
BEGIN TRANSACTION

-- Ʈ����� ����Ȯ��
SELECT @@TRANCOUNT;

-- ������Ʈ �۾�
UPDATE Passenger SET
Age = 50
WHERE PassengerNo = 3

-- �ѹ��ϸ� ������Ʈ �۾��� ��Ұ� �ȴ�.
ROLLBACK
