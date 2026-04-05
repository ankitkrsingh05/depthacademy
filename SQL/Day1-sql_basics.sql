-- CRUD OPERATIONS

-- Create
CREATE TABLE <table_name> (
<column_name> <data_type>  <constraint>
)
CREATE TABLE employees1 (
	employee_id SERIAL PRIMARY KEY,
	first_name CHARACTER VARYING (20),
	last_name CHARACTER VARYING (25) NOT NULL,
	email CHARACTER VARYING (100) NOT NULL,
	phone_number CHARACTER VARYING (20),
	hire_date DATE NOT NULL,
	job_id INTEGER NOT NULL,
	salary NUMERIC (8, 2) NOT NULL,
	manager_id INTEGER,
	department_id INTEGER
);
-- Create: insert a new employee
insert into <table_name> (
<col_name1>,<col_name2>
)
Values (
<col_value1>,<col_value2>
)

INSERT INTO employees1 (
    first_name, last_name, email, phone_number,
    hire_date, job_id, salary, manager_id, department_id
)
VALUES (
    'Rahul', 'Sharma', 'rahul.sharma@company.com', '9876543210',
    '2026-04-01', 103, 45000.00, 5, 20
);

-- Read: all employees
select <col_list> from <table_name>;

SELECT * FROM employees;

-- Read: only name, email, department
SELECT first_name, last_name, email, department_id
FROM employees;

-- Read: only name, email, department
SELECT first_name, last_name, email, department_id
FROM employees LIMIT 10

-- Update: give raise to an employee
UPDATE employees1
SET salary = salary * 1.1
WHERE employee_id = 2;

-- Update: change manager
UPDATE employees1
SET manager_id = 8
WHERE employee_id = 1;

-- Delete: (soft‑delete pattern in practice)
-- Here we’ll just show DELETE for learning
DELETE FROM employees1
WHERE employee_id = 10;



------------------------------------------Languages in SQL

---------------------------------------------- DDL
-- Create another table for context
CREATE TABLE departments1 (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

-- Add a column to employees1
ALTER TABLE employees1
ADD COLUMN active BOOLEAN DEFAULT TRUE;

-- Add a foreign key to departments1
ALTER TABLE employees1
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id)
REFERENCES departments1 (department_id);

-- Drop a column (careful!)
DROP COLUMN IF EXISTS active FROM employees1;

--------------------------------------------- DML
-- Bulk insert
INSERT INTO employees1 (
    first_name, last_name, email, hire_date,
    job_id, salary, manager_id, department_id
)
VALUES
    ('Priya',  'Jain', 'priya.jain@company.com', '2026-01-01', 104, 55000.00, 3, 20),
    ('Ankit', 'Singh', 'ankit.singh@company.com', '2026-02-15', 105, 48000.00, 3, 20);

INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (100,'Steven','King','steven.king@sqltutorial.org','515.123.4567','1987-06-17',4,24000.00,NULL,9);


-- Update: promote a few employees
UPDATE employees1
SET salary = salary * 1.15
WHERE department_name = 'Sales';

-- Update: fire a manager (set manager to NULL)
UPDATE employees1
SET manager_id = NULL
WHERE manager_id = 5;

-- fire employess based on rating
Update oracle_employees
set employee_id = NULL
where employee_rating_2026 < 3.8
-- with list of employee ids
where employee_id in (123,456)


-- Delete: remove an old employee
DELETE FROM employees1
WHERE employee_id = 10;

---------------------------------------------- DQL

-- 1. All employees
SELECT * FROM employees1;

-- 2. Names and emails
SELECT first_name, last_name, email
FROM employees1;

-- 3. Filter by salary
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 15000;

-- 3. Filter by salary
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 15000
order by salary desc limit;

-- analytical functions
SELECT max(salary),min(salary), avg(salary) 
FROM employees
--- Grouping of the data

-- Average salary by department
SELECT
    department_id,
    AVG(salary) AS avg_salary,
    COUNT(*) AS employee_count
FROM employees1
GROUP BY department_id
ORDER BY avg_salary DESC;


-- grouping and alias
select department_id,min(salary) min_salary,max(salary) as min_salary, avg(salary) avg_salary
from employees
group by department_id
order by department_id

-- Would this query work??
select department_id,min(salary) min_salary,max(salary) as min_salary, avg(salary) avg_salary
from employees
group by department_id
having min(salary) > 4000
order by department_id

-- ERROR:  column "min_salary" does not exist
-- LINE 4: having min_salary > 4000


select <cols_list>
from <table_name>
where <condition>

-- where is used to filter the rows

-- Helper functions for different datatypes
-- 4. Filter by date range
SELECT first_name, last_name, hire_date
FROM employees1
WHERE hire_date >= '2026-01-01';

-- 5. Filter using text pattern
SELECT first_name, last_name, email
FROM employees1
WHERE email LIKE '%@company.com';

-- 6. Order by salary (descending)
SELECT first_name, last_name, salary
FROM employees1
ORDER BY salary DESC;

-- 7. Order by last_name, then first_name
SELECT first_name, last_name, salary
FROM employees1
ORDER BY last_name ASC, first_name ASC;

-- 8. Top 5 highest‑salaried employees
SELECT first_name, last_name, salary
FROM employees1
ORDER BY salary DESC
LIMIT 5;

-- 9. Pagination: 6th–10th employees
SELECT first_name, last_name, salary
FROM employees1
ORDER BY salary DESC
LIMIT 5 OFFSET 5;


-------------------------------------DQL - level2
-- Average salary by department
SELECT
    department_id,
    AVG(salary) AS avg_salary,
    COUNT(*) AS employee_count
FROM employees1
GROUP BY department_id
ORDER BY avg_salary DESC;

-- Employees per manager
SELECT
    manager_id,
    COUNT(*) AS direct_reports
FROM employees1
WHERE manager_id IS NOT NULL
GROUP BY manager_id
ORDER BY direct_reports DESC;


--
select * from employees

-- Employees per manager where employees salary is greater than 4000 and the each group has salary less than 20000.  
select manager_id,count(distinct employee_id) emp_id,min(salary),max(salary)
from employees
where salary > 4000
group by manager_id
having max(salary) <20000 
order by emp_id desc


---How to start framing a sql query - 
Step 1: know the data sources / tables
	Know whether the data is in the same table or would you have to join other tables?
Step 2: Know which commands are going to get handy
	Know whether you have to group the daata , filter the data, filter the grouped data
Step 3: Filtering conditions
	Identify the filtering is to be done on the whole data or in each of the group.







-- Which managers have only 1 direct report?
SELECT
    manager_id,
    COUNT(*) AS direct_reports
FROM employees1
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING COUNT(*) = 1;



-- Wrong: cannot use alias in WHERE ()
SELECT
    first_name,
    last_name,
    salary,
    salary * 0.12 AS hra
FROM employees1
WHERE hra > 6000;


-- Find max salary per department
SELECT
    department_id,
    MAX(salary) AS max_salary
FROM employees1
GROUP BY department_id
ORDER BY max_salary DESC;

-- Get top‑5 highest‑paid employees overall
SELECT
    employee_id,
    first_name,
    last_name,
    department_id,
    salary
FROM employees1
ORDER BY salary DESC
LIMIT 5;

-- Correct: use actual column
SELECT
    first_name,
    last_name,
    salary,
    salary * 0.12 AS hra
FROM employees1
WHERE salary * 0.12 > 6000;



-- joins
-- It is used when we have to fetch data from 2 or more tables
-- find the maximum salary in each department with the deparment name

select department_name,max(salary)
from employees
join departments on employees.department_id = departments.department_id
group by department_name




