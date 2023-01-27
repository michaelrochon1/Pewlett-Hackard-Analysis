-- Deliverable 1
-- Retrieve data from Employees and Titles tables join the data on the emp_no primary key
-- Filter data by birth date and sort in ascending order of employee number

SELECT emp.emp_no,
	emp.first_name,
	emp.last_name,
	titl.title,
	titl.from_date,
	titl.to_date
INTO retirement_titles
FROM employees as emp
INNER JOIN titles AS titl
	ON (emp.emp_no = titl.emp_no)
	WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- Sort employees into a new table to hold their last title held from the Retirement Titles table

SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title

INTO unique_titles
FROM retirement_titles as rt
	WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

-- Count number of titles that are close to retiring

SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT DESC;

-- Deliverable 2
-- Create a mentoship eligibility table to hold the current employees who were born between Jan 1, 1965 to Dec 31, 1965

SELECT DISTINCT ON(emp.emp_no)
	emp.emp_no,
	emp.first_name,
	emp.last_name,
	emp.birth_date,
	de.from_date,
	de.to_date,
	titl.title
	
INTO mentor_eligibility
FROM employees AS emp
INNER JOIN dept_emp AS de
	ON (emp.emp_no = de.emp_no)

INNER JOIN titles AS titl
    ON (emp.emp_no = titl.emp_no)
	    WHERE (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY emp_no ASC;