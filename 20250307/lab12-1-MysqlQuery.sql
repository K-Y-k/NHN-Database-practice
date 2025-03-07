use Module06;

SELECT * FROM Passenger;

-- 현재 세션의 프로세스 ID를 확인
SELECT connection_id();

-- 자동커밋 활성화 여부 확인
show variables like 'autocommit';

-- 업데이트시 자동 커밋됨
UPDATE Passenger SET Age = 30 WHERE PassengerNo = 3;

-- 업데이트 된 것을 확인
SELECT * 
FROM Passenger 
WHERE PassengerNo = 3;

-- 트랜잭션 작업 수행 시작 선언 (= 해당 작업단위는 잠금 설정)
-- Mysql에서는 트랜잭션 시작을 선언할 때 현재 복사본 데이터를 저장하여 상대 계정이 이전 데이터들을 볼 수 있다.
START TRANSACTION;
-- 현재 세션의 트랜잭션 개수 확인 = 0
SELECT count(1) FROM information_schema.innodb_trx
WHERE trx_mysql_thread_id = CONNECTION_ID();

-- 설정 작업
UPDATE Passenger SET Age = 40 WHERE PassengerNo = 3;
-- 현재 세션의 트랜잭션 개수 확인 = 1
SELECT count(1) FROM information_schema.innodb_trx
WHERE trx_mysql_thread_id = CONNECTION_ID();
UPDATE Passenger SET Age = 50 WHERE PassengerNo = 3;
-- 업데이트 된 것을 확인 작업
SELECT * 
FROM Passenger 
WHERE PassengerNo = 3;

-- 위 작업들을 모두 취소
ROLLBACK;
-- 현재 세션의 트랜잭션 개수 확인 = 0
SELECT count(1) FROM information_schema.innodb_trx
WHERE trx_mysql_thread_id = CONNECTION_ID();
-- 확인해보면 이전 값들로 돌아와있음
SELECT * 
FROM Passenger 
WHERE PassengerNo = 3;


-- 트랜잭션 모드를 수동 트랜잭션으로 변경 및 확인
SET Autocommit = 0;
show variables like 'autocommit';

-- 업데이트 및 확인
UPDATE passenger SET Age = 40 WHERE PassengerNo = 3;
SELECT * FROM passenger WHERE PassengerNo = 3;

-- 롤백 후 확인
ROLLBACK;
SELECT * FROM passenger WHERE PassengerNo = 3;