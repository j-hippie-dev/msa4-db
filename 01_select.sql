-- SELECT 문
-- DML 중 하나로, 저장되어 있는 데이터를
-- 조회하기 위해 사용하는 쿼리
-- `으로 감싸면, '컴럼으로써 인식시킨다' 라는 의미
SELECT
	emp_id
	, `name`
	, gender
FROM employees
;

-- 테이블 전체 컬럼 조회: *(Asterisk)
SELECT * -- select절
FROM employees -- from절
;

-- WHERE 절: 특정 컴럼의 값이 일치한 데이터만 조회
SELECT *
FROM employees
WHERE emp_id = 10009; -- (=) 비교 연산자. 같다.

SELECT *
FROM employees
WHERE `name` = '조은혜';

SELECT *
FROM employees
WHERE birth >= '1990-01-01'; -- 문자열로 작성. 형태는 같아야 함.

SELECT *
FROM employees
WHERE fire_at IS NOT NULL; -- NULL 값은 is (or is not) 키워드를 붙여야 함.