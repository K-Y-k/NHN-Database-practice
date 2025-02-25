-- Oracle Database에서 새로운 사용자 계정을 생성하기
-- CREATE USER 사용자아이디 IDENTIFIED BY 비밀번호
-- 2번쨰 행은 해당 사용자가 사용자 데이터와 테이블을 저장할 공간 선언
-- QUOTA 테이블 최대 사용할 수 있는 크기 선언
CREATE USER celine IDENTIFIED BY celine;
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users;

-- 권한 기본값이 어느 권한도 주지 않기 때문에
-- 해당 사용자에게 권한 부여를 해줘야 한다.
GRANT ALL PRIVILEGES TO celine;

-- 연결
CONNECT celine/celine;

-- 현재 사용자의 스키마 확인
SELECT * FROM tab;

-- 테이블 생성
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

-- 데이터 삽입
INSERT INTO Category VALUES(1, 'Novel');
INSERT INTO Category VALUES(2, 'Poem');
-- 삽입 실패 (처음 선언한 길이 초과)
INSERT INTO Category VALUES (3, 'History / Relegion and Magazine');

-- 데이터 조회
SELECT * FROM Category;

-- 데이터 수정
UPDATE Category SET
CategoryName = 'History';

UPDATE Category SET
CategoryName = 'Novel'
WHERE CategoryNo = 1;

UPDATE Category SET
CategoryNo = 3
WHERE CategoryNo = 2;