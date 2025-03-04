-- 여기에 sys가 보안, 뷰 등 여러 정보를 관리하는 DB다
show databases;

-- 사용자를 확인
SELECT host, user FROM mysql.User;

-- 사용자 생성 (P@ssw0rd, D|$ney 등은 자주 사용되는 패스워드)
CREATE USER Michael IDENTIFIED By 'P@ssw0rd';
-- 생성된 사용자 확인
SELECT host, user FROM mysql.User;

-- Michael 사용자에게 Module06 DB의 Aircraft 테이블에 대한 접근(SELECT 특권)을 허가
GRANT SELECT ON Module06.Aircraft TO Michael;
-- Michael 계정에서 접근시 성공
SELECT * FROM Module06.Aircraft;

-- Michael 사용자에게 Flight 테이블의 FlightNo 필드만 접근(SELECT 특권)을 허가
GRANT SELECT(FlightNo) ON Module06.Flight TO Michael;
-- Michael 계정에서 해당 테이블의 FlightNo 필드만 접근 성공
SELECT AircraftNO, Airline
FROM Module06.Aircraft NATURAL JOIN Module06.Flight;
-- Michael 계정에서 해당 테이블의 모든 필드 접근 성공
SELECT * FROM Module06.Flight;

-- Michael 사용자의 권한들 확인
show grants for Michael;

-- Michael 사용자에게 권한 제거
REVOKE SELECT ON Module06.Aircraft FROM Michael;
-- Michael 계정에서 접근시 실패
SELECT * FROM Module06.Aircraft;

-- Michael 사용자에게 Module06 DB의 모든 개체에 대해 모든 특권을 부여
GRANT ALL privileges ON Module06.* TO Michael;
-- Michal 사용자에게 부여된 Module06 DB의 모든 특권을 제거
REVOKE ALL privileges ON Module06.* FROM Michael;
-- Michael 사용자의 권한들 확인
show grants for Michael;
