-- 부서별 현재 연봉 평균 구해주세요.
-- 부서명(한글), 평균 연봉 출력

CREATE VIEW view_avg_salary_by_dept
AS
	SELECT
		dept.dept_name
		, CEILING(AVG(sal.salary)) dept_avg
	FROM salaries sal -- 용량이 작은 걸 메인으로 잡는게 좋음.
		JOIN department_emps dee
			ON sal.emp_id = dee.emp_id
			AND dee.end_at IS NULL
			AND sal.end_at IS NULL
		JOIN departments dept
			ON dee.dept_code = dept.dept_code
			AND dee.end_at IS NULL
	GROUP BY dept.dept_name -- 표준문법!!!!!!!!!!!!!!
	ORDER BY dept.dept_name
;

-- 뷰 조회하기
SELECT
	*
FROM view_avg_salary_by_dept
WHERE
	dept_avg >= 44000000
;

-- VIEW 삭제
DROP VIEW view_avg_salary_by_dept;