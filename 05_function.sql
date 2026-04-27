-- 내장 함수

-- 데이터 타입 변환 함수 (작성법 차이)
SELECT CAST(1234 AS CHAR(4));
SELECT CONVERT(1234, CHAR(4));

-- --------------
-- 제어 흐름 함수
-- --------------
-- IF(수식, 참일 때, 거짓일 때)
SELECT
	`name`
	, gender
	, IF(gender = 'M', '남자', '여자') AS ko_gender
FROM employees
;

-- IFNULL(수식1, 수식2) -- 퍼포먼스 저하 올 수 있음
-- 	수식1이 null이면 수식2를 반환, 아니면 수식1을 반환
SELECT
	IFNULL(fire_at, '재직중')
FROM employees
;

-- NULLIF(수식1, 수식2)
-- 	수식1과 수식2를 비교해서, 같으면 NULL을 반환,
-- 	다르면 수식1을 반환
SELECT
	NULLIF(gender, 'M')
FROM employees
;

-- CASE ~ WHEN ~ ELSE ~ END (case로 시작했으면 end로 끝내줘야 함.)
-- 	다중분기 위해 사용
SELECT
	CASE gender
		WHEN 'M' THEN '남자'
		WHEN 'Z' THEN '선택안함'
		ELSE '여자'
	END AS ko_gender
FROM employees
;

-- -----------
-- 문자열 함수
-- -----------
-- 문자열 연결
SELECT CONCAT('안녕', ' ', '하세요.');
SELECT CONCAT(`name`, gender) FROM employees;

-- 구분자로 문자열 연결
SELECT CONCAT_WS(', ', '안녕', '하세요', '.');
SELECT CONCAT_WS(', ', `name`, gender) FROM employees;

-- 숫자에 자릿수(,) 및 소수점 자릿수 표시
SELECT FORMAT(salary, 0) FROM salaries;

-- 문자열의 왼쪽/오른쪽부터 길이만큼 잘라 반환
SELECT LEFT('123456', 2);
SELECT RIGHT('123456', 2);

-- 영어를 대/소문자로 변경
SELECT UPPER('asdDFs'), LOWER('asdDFs');

-- 문자열의 좌/우에 문자열 길이만큼 채울 문자열을 삽입
SELECT LPAD(emp_id, 10, 0) FROM employees;
SELECT RPAD(emp_id, 10, 0) FROM employees;

-- 좌/우 공백 제거
SELECT '  sdsd ', TRIM('  sdsd ');
SELECT LTRIM('  sdsd '), RTRIM('  sdsd ');

-- 'abcdab'
SELECT TRIM(LEADING 'ab' FROM 'abcdab');
SELECT TRIM(TRAILING 'ab' FROM 'abcdab');
SELECT TRIM(BOTH 'ab' FROM 'abcdab');

-- 문자열을 시작위치에서 길이만큼 잘라서 반환
SELECT SUBSTRING('abcdef', 3, 2);

-- 왼쪽부터 구분자가 횟수번째 만큼 나오면 그 이후 버림 (양수: 왼쪽부터, 음수: 오른쪽부터)
SELECT SUBSTRING_INDEX('meerket_HTML_CSS.html', '.', -1) AS txt;

-- --------
-- 수학함수
-- --------
-- 올림, 반올림, 버림
SELECT CEILING(1.4), ROUND(1.5), FLOOR(1.6);

-- 소수점을 기준으로 특정 자리수까지 구하고 나머지는 버림
SELECT TRUNCATE(1.19, 0);

-- ----------------------
-- 날짜 및 시간 관련 함수
-- ----------------------
-- 현재 날짜/시간 반환 (YYYY-MM-DD hh:mi:ss)
SELECT NOW();

-- 데이트 타입의 값을 `YYYY-MM-DD`양식으로 변환
SELECT DATE(NOW());

-- 날짜1에 단위기간에 따라 더한 날짜/시간을 반환
SELECT ADDDATE(NOW(), INTERVAL 1 YEAR);
SELECT ADDDATE(NOW(), INTERVAL -1 YEAR);
SELECT ADDDATE(NOW(), INTERVAL 1 MONTH);
SELECT ADDDATE(NOW(), INTERVAL 1 DAY);
SELECT ADDDATE(NOW(), INTERVAL 1 HOUR);
SELECT ADDDATE(NOW(), INTERVAL 1 MINUTE);
SELECT ADDDATE(NOW(), INTERVAL 1 SECOND);
SELECT ADDDATE(NOW(), INTERVAL 1 MICROSECOND);

-- --------
-- 집계함수
-- --------
-- 목요일에 했음

-- ---------
-- 순위 함수
-- ---------
-- RANK() OVER(ORDER BY 컬럼 DESC/ASC)
-- 지정한 컬럼을 기준으로 순위를 매겨 반환
-- 동일한 값이 있는 경우 동일한 순위를 부여
SELECT
	emp_id
	, salary
	, RANK() OVER(ORDER BY salary DESC) AS `rank`
FROM salaries
WHERE
	end_at IS NULL
-- ORDER BY salary DESC
LIMIT 10
;

-- ROW_NUMBER() OVER(ORDER BY 컬럼 DESC/ASC)
-- 레코드에 순위를 매겨 반환
-- 동일한 값이 있는 경우에도 각 행에 고유한 번호를 부여
SELECT
	emp_id
	, salary
	, ROW_NUMBER() OVER(ORDER BY salary DESC) AS `rank`
FROM salaries
WHERE
	end_at IS NULL
LIMIT 10
;