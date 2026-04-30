-- -----------
-- Transaction
-- -----------
-- Transaction 시작
START TRANSACTION;

INSERT INTO
	employees(
		`name`
		, birth
		, gender
		, hire_at
	)
	VALUES(
		'조은혜'
		, '1996-03-19'
		, 'F'
		, NOW()
	), (
		'미어캣'
		, '1990-02-23'
		, 'M'
		, NOW()
	)
;

SELECT *
FROM employees
WHERE
	`name` = '미어캣'
;

-- COMMIT;
ROLLBACK;