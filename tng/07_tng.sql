-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT
	emp.emp_id
	, emp.`name`
	, tie.title_code
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
WHERE
		 emp.fire_at IS NULL
	AND tie.end_at IS NULL
;

-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	, emp.gender
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE
		 emp.fire_at IS NULL
	AND sal.end_at IS NULL
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT
	emp.`name`
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE
	emp.emp_id = 10010
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
	emp.emp_id
	, emp.`name`
	, dept.dept_name
FROM employees emp
	JOIN department_emps dee
		ON emp.emp_id = dee.emp_id
			AND dee.end_at IS NULL
	JOIN departments dept
		ON dee.dept_code = dept.dept_code
			AND dept.end_at IS NULL
WHERE
	emp.fire_at IS NULL
ORDER BY emp.emp_id
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	, emp.`name`
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE
	sal.end_at IS NULL
	AND emp.fire_at IS NULL
ORDER BY sal.salary DESC
LIMIT 10
;

-- 속도 개선 버전 (공간 복잡도는 증가할 수 있음)
SELECT
	emp.emp_id
	, emp.`name`
	, sal.salary
FROM employees emp
	JOIN (
		SELECT
			sal.emp_id
			, sal.salary
		FROM salaries sal
		WHERE
			sal.end_at IS NULL
		ORDER BY sal.salary DESC
		LIMIT 10
	) tmp_sal
		ON emp.emp_id = tmp_sal.emp_id
			AND emp.fire_at IS NULL
ORDER BY tmp_sal.salary DESC
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT
	dept.dept_name
	, emp.`name`
	, emp.hire_at
FROM department_managers dem
	JOIN departments dept
		ON dem.dept_code = dept.dept_code
	JOIN employees emp
		ON dem.emp_id = emp.emp_id
WHERE
	dem.end_at IS NULL
	AND dept.end_at IS NULL
	AND emp.fire_at IS NULL
ORDER BY dept.dept_code
;		

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
SELECT
	tit.title
	,tie.emp_id
	, AVG(sal.salary) sal_avg
FROM titles tit
	JOIN title_emps tie
		ON tit.title_code = tie.title_code
			AND tit.title = '부장'
			AND tie.end_at IS NULL
	JOIN salaries sal
		ON sal.emp_id = tie.emp_id
GROUP BY tie.emp_id
;

-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균
SELECT
	emp.`name`
	, AVG(sal.salary) sal_avg
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
	JOIN titles tit
		ON tie.title_code = tit.title_code
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE
	tie.end_at IS NULL
	AND sal.end_at IS NULL
	AND tit.title = '부장'
	AND emp.fire_at IS NULL
GROUP BY emp.emp_id
;

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT
	emp.`name`
	, emp.hire_at
	, emp.emp_id
	, dem.dept_code
FROM employees emp
	JOIN department_managers dem
		ON emp.emp_id = dem.emp_id
ORDER BY dem.dept_code, dem.start_at
;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 
-- 직급의 직급명, 평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.
SELECT
	tit.title
	, FLOOR(AVG(sal.salary)) tit_avg
FROM titles tit
	JOIN title_emps tie
		ON tit.title_code = tie.title_code
	JOIN employees emp
		ON tie.emp_id = emp.emp_id
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE
	tie.end_at IS NULL
	AND sal.end_at IS NULL
	AND emp.fire_at IS NULL
GROUP BY tie.title_code
	HAVING AVG(sal.salary) >= 60000000
ORDER BY tit_avg DESC
;

-- 속도개선???? XXXXXX --------------------
SELECT
	tit.title
FROM (
		SELECT
			tie.emp_id
			, FLOOR(AVG(sal.salary)) tit_avg
		FROM title_emps tie
			JOIN salaries sal
				ON tie.emp_id = sal.emp_id
					AND tie.end_at IS NULL
					AND sal.end_at IS NULL
		GROUP BY tie.title_code, tit.title
		HAVING AVG(sal.salary) >= 60000000
	)	
	JOIN titles tit
		ON tit.title_code = tie.title_code

ORDER BY AVG(sal.salary) DESC
;

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT
	tie.title_code
	, COUNT(*) cnt
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
WHERE
	emp.gender = 'F'
	AND tie.end_at IS NULL
	AND emp.fire_at IS NULL
GROUP BY tie.title_code
;

-- 보너스 문제 (남/여)
SELECT
	tie.title_code
	, emp.gender
	, COUNT(*) cnt
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
WHERE
	tie.end_at IS NULL
	AND emp.fire_at IS NULL
GROUP BY tie.title_code, emp.gender
;