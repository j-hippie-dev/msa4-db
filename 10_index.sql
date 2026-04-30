-- ------
-- INDEX
-- ------
-- INDEX 확인
SHOW INDEX FROM employees;

-- 0.031초
SELECT * FROM employees WHERE `name` = '조은혜';

-- INDEX 생성 (복수: ,콤마로 구분)
ALTER TABLE employees
ADD INDEX idx_employees_name (`name`)
;

-- 0.000초
SELECT * FROM employees WHERE `name` = '조은혜';

-- INDEX 삭제
ALTER TABLE employees
DROP INDEX idx_employees_name
;