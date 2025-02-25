-- 무결성 제약 설정

-- 해당 테이블 정보 확인
desc Category;

-- 해당 테이블의 제약조건 확인
SELECT OWNER, CONSTRAINT_NAME, TABLE_NAME FROM ALL_CONSTRAINTS WHERE TABLE_NAME = 'CATEGORY';


-- 개체 무결성 -> 기본키 제약조건
-- 기본키 제약 조건 설정 : 중복된 기본키값이 존재할 수 없다.
ALTER TABLE Category ADD CONSTRAINT pk_Category PRIMARY KEY(CategoryNo);
ALTER TABLE Product ADD CONSTRAINT pk_Product PRIMARY KEY(ProductNo);


-- 참조 무결성 -> 외래키 제약조건
-- 외래키 제약조건 설정1 : 기본키에 참조된 외래키가 있을 경우 삭제 불가능 (기본값이 ON DELETE NO ACTION)
ALTER TABLE Product ADD CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) 
REFERENCES Category(CategoryNo);
-- ON UPDATE NO ACTION;

-- 외래키 제약조건 설정2 : 기본키에 참조된 외래키가 있을 경우 기본키 튜플 삭제시 외래키 값을 NULL로 변환
ALTER TABLE Product ADD CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) 
REFERENCES Category(CategoryNo) 
ON DELETE SET NULL;
-- ON UPDATE SET NULL;

-- 외래키 제약조건 설정3 : 기본키에 참조된 외래키가 있을 경우 기본키 튜플 삭제시 외래키 튜플도 모두 삭제
-- 단, 오라클은 ON UPDATE 설정은 없다. -> 다른 방법 = 트리거를 사용
ALTER TABLE Product ADD CONSTRAINT fk_Product_Category FOREIGN KEY(CategoryNo) 
REFERENCES Category(CategoryNo) 
ON DELETE CASCADE;
