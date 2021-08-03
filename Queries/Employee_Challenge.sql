-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
	first_name, 
	last_name, 
	title 
INTO unique_titles
FROM retirement_title
ORDER BY emp_no ASC, to_date DESC;

--retiring count by title
-- to use "order by" i will be naming the count 
--https://stackoverflow.com/questions/39565394/how-to-rename-result-set-of-count-in-sql
Select title, count(emp_no) as retiring_count
into retiring_titles
from unique_titles
group by title
order by retiring_count DESC, title; 

-----create mentorship_eligibilty
select distinct on (e.emp_no)
		e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		d.from_date,
		d.to_date,
		t.title
Into mentorship_eligibilty
from employees as e
inner join dept_emp as d
	on (e.emp_no=d.emp_no)
inner join titles as t
	on (e.emp_no=t.emp_no)
where (d.to_date='9999-01-01')
and (e.birth_date between '1965-01-01' and '1965-12-31')
order by e.emp_no ASC;


-----***********not part of challange but 
---- Create retirement_title table by joining 
select e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
into retirement_title
from employees as e
inner join titles as t
	on (e.emp_no=t.emp_no)
where (e.birth_date between '1952-01-01' AND '1955-12-31')
order by e.emp_no ASC; 
