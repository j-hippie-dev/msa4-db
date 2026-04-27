-- 1. 직급테이블의 모든 정보를 조회해주세요.
SELECT
	*
FROM titles
;

-- 2. 급여가 60,000,000 이하인 사원의 사번을 조회해 주세요.
SELECT
	emp_id
FROM salaries
WHERE
	salary <= 60000000
	AND end_at IS NULL
;

-- 3. 급여가 60,000,000에서 70,000,000인 사원의 사번을 조회해 주세요.
SELECT
	emp_id
FROM salaries
WHERE
	salary BETWEEN 60000000 AND 70000000
	AND end_at IS NULL
;

-- 4. 사원번호가 10001, 10005인 사원의 사원테이블의 모든 정보를 조회해 주세요.
SELECT
	*
FROM employees
WHERE
	emp_id = 10001
	OR emp_id = 10005
;

-- 5. 직급에 '사'가 포함된 직급코드와 직급명을 조회해 주세요.
SELECT
	title_code
	, title
FROM titles
WHERE
	title LIKE '%사%'
;

-- 6. 사원 이름 오름차순으로 정렬해서 조회해 주세요.
SELECT
	*
FROM employees
ORDER BY `name`
;

-- 7. 사원별 전체 급여의 평균을 조회해 주세요.
SELECT
	AVG(salary) sal_avg
FROM salaries
WHERE
	end_at IS NULL
GROUP BY emp_id
;

-- 8. 사원별 전체 급여의 평균이 30,000,000 ~ 50,000,000인,
--   사원번호와 평균급여를 조회해 주세요.
SELECT
	emp_id
	, AVG(salary) sal_avg
FROM salaries
WHERE
	end_at IS NULL
GROUP BY emp_id
	HAVING sal_avg BETWEEN 30000000 AND 50000000
;

-- 9. 사원별 전체 급여 평균이 70,000,000이상인,
--   사원의 사번, 이름, 성별을 조회해 주세요.
SELECT
	employees.emp_id
	, employees.`name`
	, employees.gender
FROM employees
WHERE emp_id IN (
		SELECT
			salaries.emp_id
		FROM salaries
		GROUP BY
			salaries.emp_id
			HAVING AVG(salaries.salary) >= 70000000
	)
;

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- 기본적으로 r기준이 되는 컬럼 쓰고 연산자 쓰고 ~ 조건 쓰고 ~
-- SELECT
-- 	emp.emp_id
-- 	, emp.`name`
-- 	, emp.gender
-- FROM employees emp
-- WHERE
-- 	70000000 <= ( 		-- EXIST 생략된 것. (true/ false 반환)
-- 		SELECT AVG(sal.salary)
-- 		FROM salaries sal
-- 		WHERE sal.emp_id = emp.emp_id
-- 	)
-- ;

-- 10. 현재 직급이 'T005'인,
--   사원의 사원번호와 이름을 조회해 주세요.
SELECT
	emp.emp_id
	, emp.`name`
FROM employees emp
WHERE
	emp.emp_id IN (
		SELECT title_emps.emp_id
		FROM title_emps
		WHERE title_emps.title_code = 'T005'
				AND title_emps.end_at IS NULL
	)
;