
-- 데드락 감지 설정 해제
set global innodb_deadlock_detect = off;

-- 수행 터미널의 프로세스가 가진 잠금을 확인
SELECT * FROM performance_schema.data_locks;

-- 해당 테이블의 인덱스를 확인
SELECT index_name, column_name, cardinality, index_type 
FROM information_schema.statistics 
where table_name = 'Passenger';

-- 트랜잭션 시작
START TRANSACTION;
-- 현재 터미널의 프로세스 ID를 확인
SELECT connection_id();
-- 데이터에 대해 잠금을 수행
SELECT * FROM Passenger
WHERE Grade = 10 FOR UPDATE;
-- 터미널의 프로세스가 잠근 객체를 확인
SELECT engine, engine_transaction_ID, Thread_ID, Object_schema, object_name, Lock_type, Lock_Mode, Lock_data 
FROM performance_schema.data_locks;
-- 다른 터미널에서 같은 레코드를 잠금 획득 시도
-- -> 쿼리 결과를 보여주지 않고 대기하다가, 지정한 시간이 지나면 취소된다.
--    ERROR 1205 (HY000): Lock wait timeout exceeded; try restarting transaction
SELECT * FROM Passenger WHERE Grade = 3 FOR UPDATE;

-- 다른 터미널에서 다른 레코드 잠금 획득 시도
SELECT * FROM Passenger WHERE Grade = 9 FOR UPDATE;

-- 현재 세션이 잠근 데이터를 확인
SELECT Object_schema, object_name, Lock_type, Lock_Mode, Lock_data 
FROM performance_schema.data_locks 
WHERE engine_transaction_ID = (SELECT trx_id FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = connection_id());