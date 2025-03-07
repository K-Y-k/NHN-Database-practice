-- 트랜잭션 작업 시작
-- Mssql에서는 트랜잭션 시작을 선언할 때 잠금이 설정되어 다른 사용자들은 접근 자체가 불가능하다.
BEGIN TRANSACTION

-- 트랜잭션 개수확인
SELECT @@TRANCOUNT;

-- 업데이트 작업
UPDATE Passenger SET
Age = 50
WHERE PassengerNo = 3

-- 롤백하면 업데이트 작업이 취소가 된다.
ROLLBACK
