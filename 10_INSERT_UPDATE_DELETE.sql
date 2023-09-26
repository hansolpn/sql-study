
-- insert
-- 테이블 구조 확인
DESC departments;

-- INSERT의 첫번째 방법 (모든 컬럼 데이터를 한 번에 지정)
INSERT INTO departments
VALUES(300, '영업부', 102, 1800);

SELECT * FROM departments;
ROLLBACK; -- 실행 시점을 다시 뒤로 되돌리는 키워드

-- INSERT의 두번째 방법 (직접 컬럼을 지정하고 저장, NOT NULL 확인하세요!)
INSERT INTO departments
    (department_id, department_name, location_id)
VALUES
    (290, '총무부', 1700);

-- 사본 테이블 생성
-- 사본 테이블을 생성할 때 그냥 생성하면 -> 조회된 데이터까지 모두 복사
-- WHERE절에 false값 (1 = 2)를 지정하면 -> 테이블의 구조만 복사되고 데이터는 복사 x
CREATE TABLE emps AS
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2); -- WHERE 1 = 2 -> 구조만 만들고 싶을때

SELECT * FROM emps;
DROP TABLE emps;

-- INSERT (서브쿼리)
INSERT INTO emps
(SELECT employee_id, first_name, job_id, hire_date 
FROM employees WHERE department_id = 50);

----------------------------------------
-- UPDATE
CREATE TABLE emps AS
(SELECT * FROM employees);

SELECT * FROM emps;

-- UPDATE를 진행할 때는 누구를 수정할 지 잘 지목해야 합니다
-- 그렇지 않으면 수정 대상이 테이블 전체로 지목됩니다.
UPDATE emps SET salary = 30000;

UPDATE emps SET salary = 30000
WHERE employee_id = 100;

UPDATE emps SET salary = salary + salary * 0.1
WHERE employee_id = 100;

UPDATE emps
SET phone_number = '010.4742.8917', manager_id = 102
WHERE employee_id = 100;

-- UPDATE (서브쿼리)
UPDATE emps
    SET (job_id, salary, manager_id) =
    (
        SELECT job_id, salary, manager_id
        FROM emps
        WHERE employee_id = 100
    )
WHERE employee_id = 101;

-------------------------------------------------------------
-- DELETE
DELETE FROM emps
WHERE employee_id = 103;

--DELETE (서브쿼리)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM departments
                        WHERE department_name = 'IT');
