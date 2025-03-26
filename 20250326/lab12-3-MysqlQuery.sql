show databases;
use module06;

-- 1.터미널 접속
-- 2.현재 세션의 프로세스 ID를 확인
SELECT connection_id();
-- 3.현재 세션의 트랜잭션 개수를 확인
SELECT count(1) FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = CONNECTION_ID();
-- 4.트랜잭션을 시작
START TRANSACTION;
-- 5.안중근 고객의 나이를 30으로 업데이트
UPDATE Passenger SET Age = 30
WHERE PassengerNo = 2;
-- 6.업데이트 된 것을 확인 (이때 다른 터미널에서 확인한다면 업데이트 전의 값이 나옴)
SELECT * FROM passenger;
-- 7.현재 세션의 트랜잭션 개수를 확인
SELECT count(1) FROM information_schema.innodb_trx
WHERE trx_mysql_thread_id = CONNECTION_ID();
-- 8.트랜잭션 롤백
ROLLBACK;
-- 9.현재 세션의 트랜잭션 개수를 확인
SELECT count(1) FROM information_schema.innodb_trx WHERE trx_mysql_thread_id = CONNECTION_ID();


CREATE DATABASE Module12;
USE Module12;

CREATE TABLE Members (
    Id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name varchar(10) DEFAULT '홍길동',
    City varchar(10) DEFAULT '부산'
);

-- Members 테이블에 5000개의 데이터를 삽입하는 저장 프로시저를 생성
-- 프로시저 : sql을 함수로 만든 것
DELIMITER $$
CREATE PROCEDURE insertMembers()
BEGIN
	DECLARE i int DEFAULT 1;
	WHILE (i <= 5000) DO
		INSERT INTO members () VALUES ();
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

-- 프로시저 호출
CALL insertMembers();

-- Members 테이블의 데이터를 확인
SELECT * FROM Members;
SELECT COUNT(*) FROM Members;

-- workbench 홈 클릭해서 다른 로컬 인스턴스 생성해서 각 프로세스 id 확인
SELECT connection_id();

-- 전체 프로세스를 확인
Show full processlist;

-- 첫 번째 탭의 쿼리 창에서 트랜잭션을 명시적으로 시작
START TRANSACTION;
-- 첫 번째 탭의 쿼리 창에서 Id가 1000 번에서 1500번 사이의 데이터를 업데이트
UPDATE Members SET
City = '광주'
WHERE Id BETWEEN 1000 AND 1500;
-- 첫 번째 탭의 쿼리 창에서 업데이트 된 데이터를 확인
SELECT * FROM MEMBERS
WHERE Id BETWEEN 1200 AND 1210;
-- 첫 번째 탭의 쿼리 창에서 실행중인 트랜잭션을 확인
SELECT count(1) FROM information_schema.innodb_trx
WHERE trx_mysql_thread_id = CONNECTION_ID();
-- 첫 번째 탭의 쿼리 창에서 트랜잭션이 잠근 데이터를 확인
SELECT * FROM performance_schema.data_locks;

-- 두 번째 탭의 쿼리 창에서 다른 세션에서 업데이트한 데이터를 확인 
-- 부산으로 나옴
SELECT * FROM MEMBERS
WHERE Id BETWEEN 1200 AND 1210;

-- 첫 번째 탭의 쿼리 창에서 트랜잭션을 커밋
COMMIT;
-- 첫 번째 탭의 쿼리 창에서 실행중인 트랜잭션을 확인
SELECT count(1) FROM information_schema.innodb_trx
WHERE trx_mysql_thread_id = CONNECTION_ID();

-- 두 번째 탭의 쿼리 창에서 다른 세션에서 업데이트한 데이터를 확인
-- 업데이트 된 광주로 나옴 (Dirty Read)
SELECT * FROM MEMBERS
WHERE Id BETWEEN 1200 AND 1210;


-- READ COMMITTED/READ UNCOMMITTED/REPEATABLE READ/SERIALIZABLE 트랜잭션 격리 수준
-- 첫 번째/두 번째 탭의 쿼리 창에서 현재 세션의 트랜잭션 격리 수준을 확인
SHOW variables LIKE 'transaction_isolation';

-- 첫 번째 탭의 쿼리 창에서 현재 세션의 트랜잭션 격리 수준을 READ COMMITTED로 설정
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- 첫 번째 탭의 쿼리 창에서 현재 세션의 트랜잭션 격리 수준을 확인
SHOW variables LIKE 'transaction_isolation';

-- 첫 번째 탭의 쿼리 창에서 트랜잭션을 명시적으로 시작합니다.
START TRANSACTION;
-- 첫 번째 탭의 쿼리 창에서 Id가 500번에서 1000번 사이의 데이터를 업데이트
UPDATE Members SET
City = '서울'
WHERE Id BETWEEN 500 AND 1000;
-- 첫 번째 탭의 쿼리 창에서 업데이트 중인 데이터를 읽음
-- 서울로 나옴
SELECT * FROM Members WHERE Id = 600;

-- 두 번째 탭의 쿼리 창에서 업데이트 중인 데이터를 읽음
-- 부산으로 나옴
SELECT * FROM Members WHERE Id = 600;
-- 두 번째 탭의 쿼리 창에서 트랜잭션 격리 수준을 READ UNCOMMITTED로 변경
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- 두 번째 탭의 쿼리 창에서 업데이트 중인 데이터를 읽음
-- 서울로 나옴
SELECT * FROM Members WHERE Id = 600;

-- 두 번째 탭의 쿼리 창에서 트랜잭션 격리 수준을 READ COMMITTED로 변경
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- 두 번째 탭의 쿼리 창에서 업데이트 중인 데이터를 읽는다.
-- 부산으로 나옴
SELECT * FROM Members WHERE Id = 600;

-- 두 번째 탭의 쿼리 창에서 트랜잭션 격리 수준을 REPATABLE READ로 변경
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- 두 번째 탭의 쿼리 창에서 업데이트 중인 데이터를 읽음
-- 부산으로 나옴
SELECT * FROM Members WHERE Id = 600;

-- 두 번째 탭의 쿼리 창에서 트랜잭션 격리 수준을 SERIALIZABLE로 변경
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- 두 번째 탭의 쿼리 창에서 업데이트 중인 데이터를 읽는다.
-- 부산으로 나옴
SELECT * FROM Members WHERE Id = 600;

-- 첫 번째 탭의 쿼리 창에서 트랜잭션을 Commit
COMMIT;

-- 두 번째 탭의 쿼리 창에서 업데이트 중인 데이터를 읽는다.
-- 서울로 나옴
SELECT * FROM Members WHERE Id = 600;