show databases;
use module06;

-- 테이블 잠금
-- 1.터미널1 접속
-- 2.Deadlock 감지를 수행하지 않도록 설정
set global innodb_deadlock_detect = off;
-- 3.터미널 1의 프로세스가 가진 잠금을 확인
SELECT * FROM performance_schema.data_locks;
-- 4.터미널2 접속
-- 5.터미널1에서 Passenger 테이블의 인덱스를 확인
SELECT index_name, column_name, cardinality, index_type 
FROM information_schema.statistics where table_name = 'Passenger';
-- 6.터미널1에서 START TRANSACTION;
START TRANSACTION;
-- 7.터미널1에서 데이터에 대해 잠금설정
SELECT * FROM Passenger WHERE Grade = 10 FOR UPDATE;
-- 8.터미널1의 프로세스가 잠근 객체를 확인
-- 잠금이 걸린 데이터가 나온다.
SELECT engine, engine_transaction_ID, Thread_ID, Object_schema, object_name, Lock_type, Lock_Mode, Lock_data 
FROM performance_schema.data_locks;
-- 9.터미널 2에서 Passenger 테이블에서 등급이 3인 데이터에 대한 잠금 획득을 시도
-- ERROR 1205 (HY000): Lock wait timeout exceeded; try restarting transaction 발생
SELECT * FROM Passenger WHERE Grade = 3 FOR UPDATE;
-- 10.터미널1에서 commit을 하면 터미널2에서 정상 실행됨
commit;


-- 레코드 잠금
-- 1.터미널1에서 잠금 현황을 확인
SELECT engine, engine_transaction_ID, Thread_ID, Object_schema, object_name, Lock_type, Lock_Mode, Lock_data 
FROM performance_schema.data_locks;
-- 2.터미널1에서 Passenger 테이블의 Grade 컬럼에 인덱스를 생성
CREATE INDEX idx_passenger_grade ON Passenger(Grade);
-- 3.터미널1에서 Passenger 테이블에 생성된 인덱스를 확인
SELECT index_name, column_name, cardinality, index_type 
FROM information_schema.statistics where table_name = 'Passenger';
-- 4.터미널1에서 트랜잭션을 시작
BEGIN;
-- 5.터미널1에서 잠금 시도
SELECT * FROM Passenger WHERE Grade = 10 FOR UPDATE;
-- 6.터미널1에서 잠근 객체 확인
SELECT engine, engine_transaction_ID, Thread_ID, Object_schema, object_name, Lock_type, Lock_Mode, Lock_data 
FROM performance_schema.data_locks;
-- 7.터미널2에서 트랜잭션을 시작
BEGIN;
-- 8.터미널2에서 데이터에 대한 잠금을 시도
--   레코드 잠금이므로 조회가 되었다.
SELECT * FROM Passenger WHERE Grade = 9 FOR UPDATE;
-- 9.터미널2의 프로세스 ID를 확인
SELECT connection_id();
-- 10.터미널2의 트랜잭션이 잠금을 획득한 데이터 확인
SELECT engine, engine_transaction_ID, Thread_ID, Object_schema, object_name, Lock_type, Lock_Mode, Lock_data 
FROM performance_schema.data_locks WHERE engine_transaction_ID = 4095;

-- 실행중인 트랜잭션 확인
-- 11.터미널1에서 실행중인 트랜잭션을 확인
SELECT trx_state, trx_tables_in_use, trx_tables_locked 
FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = connection_id();
-- 12.터미널2에서 실행중인 트랜잭션을 확인
SELECT trx_state, trx_tables_in_use, trx_tables_locked FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = connection_id
();
-- 13.터미널1에서 실행중인 트랜잭션을 COMMIT
commit;
-- 14.터미널1에서 실행중인 트랜잭션을 확인
SELECT trx_state, trx_tables_in_use, trx_tables_locked 
FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = connection_id;
-- 15.터미널2에서 실행중인 트랜잭션을 COMMIT 
commit;
-- 16.터미널1에서 실행중인 트랜잭션을 확인
SELECT trx_state, trx_tables_in_use, trx_tables_locked
FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = connection_id();


-- 잠금 확인
-- 1.모니터링을 위한 터미널3 실행
-- 2.터미널1에서 Passenger 테이블에 설정된 인덱스를 확인
SELECT index_name, column_name, cardinality, index_type FROM information_schema.statistics where table_name = 'Passenger';
-- 3.터미널1에서 트랜잭션을 시작
BEGIN;
-- 4.터미널 1에서 Grade가 10인 데이터에 대해 잠금을 요청
SELECT * FROM Passenger WHERE Grade = 10 FOR UPDATE;
-- 5.현재 세션이 잠근 데이터를 확인
SELECT Object_schema, object_name, Lock_type, Lock_Mode, Lock_data 
FROM performance_schema.data_locks 
WHERE engine_transaction_ID = (SELECT trx_id FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = connection_id());
-- 6.터미널 2에서 Passenger 테이블에서 Grade가 10인 데이터를 요청
SELECT * FROM Passenger WHERE Grade = 10;
-- 7.터미널2에서 Passenger 테이블에서 Grade가 10인 데이터에 잠금을 요청
SELECT * FROM Passenger WHERE Grade = 10 FOR UPDATE;
-- 8.터미널3에서 프로세스를 확인
show processlist;

-- 터미널 2에서 잠금 획득
-- 9.터미널1에서 트랜잭션을 시작
BEGIN;
-- 10.터미널2에서 Passenger 테이블에서 Grade가 9인 데이터에 대해 잠금을 획득
SELECT * FROM Passenger WHERE Grade = 9 FOR UPDATE;
-- 11.현재 세션이 잠근 데이터를 확인
SELECT Object_schema, object_name, Lock_type, Lock_Mode, Lock_data 
FROM performance_schema.data_locks WHERE engine_transaction_ID = (SELECT trx_id FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = connection_id());


-- Deadlock
-- 터미널 1에서 터미널 2에서 잠금을 획득한 데이터에 대해 잠금 획득을 시도
SELECT * FROM Passenger WHERE Grade = 9 FOR UPDATE;
-- 터미널 2에서 아래 쿼리를 실행하여 터미널 1에서 잠금을 획득한 데이터에 대해 잠금 획득을 시도
-- 쿼리는 실행을 완료하지 않는다. 잠금을 획득할 때 까지 기다린다. (데드락)
SELECT * FROM Passenger WHERE Grade = 10 FOR UPDATE;
-- 터미널3에서 프로세스 확인
show processlist;


-- MySQL의 Deadlock 감지
-- 1.터미널1에서 Deadlock 감지를 수행하지 않도록 설정
set global innodb_deadlock_detect = on;
-- 2.터미널1에서 트랜잭션을 시작
BEGIN;
-- 3.터미널1에서 아래 쿼리를 살행하여 Passenger 테이블의 Grade가 10인 데이터에 대해 잠금을 요청
UPDATE Passenger SET Age = Age + 1 WHERE Grade = 10;
-- 4.터미널1에서 현재 트랜잭션이 잠금을 수행한 데이터를 확인
SELECT Object_schema, object_name, Lock_type, Lock_Mode, Lock_data FROM performance_schema.data_locks WHERE engine_transaction_ID = (SELECT trx_id FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = connection_id());
-- 5.터미널2에서 트랜잭션을 시작
BEGIN;
-- 6.터미널2에서 Passenger 테이블의 Grade가 9인 데이터에 대해 잠금을 요청
UPDATE Passenger SET Age = Age + 1 WHERE Grade = 9;
-- 7.터미널 1에서 현재 트랜잭션이 잠금을 수행한 데이터를 확인
SELECT Object_schema, object_name, Lock_type, Lock_Mode, Lock_data 
FROM performance_schema.data_locks WHERE engine_transaction_ID = (SELECT trx_id FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = connection_id());
-- 8.터미널1에서 터미널2에서 잠근 데이터에 대한 잠금을 요청
SELECT * FROM Passenger WHERE Grade = 9 FOR UPDATE;
-- 9.터미널2에서 터미널1에서 잠근 데이터에 대한 잠금을 요청
-- 터미널 1에서 Deadlock이 감지되고 트랜잭션이 중단되는 것을 확인할 수 있다.
SELECT * FROM Passenger WHERE Grade = 10 FOR UPDATE;
-- 10.터미널1에서 현재 트랜잭션이 잠금을 수행한 데이터를 확인
SELECT Object_schema, object_name, Lock_type, Lock_Mode, Lock_data FROM performance_schema.data_locks WHERE engine_transaction_ID = (SELECT trx_id FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = connection_id());
-- 11.터미널2에서 트랜잭션을 롤백
ROLLBACK;