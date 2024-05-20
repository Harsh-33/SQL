use hr;
-- list all the employees who are working for marketing dept
select * from departments;
select * from employees;
select * from employees 
where department_id = 
(select department_id from departments where department_name = 'Marketing');
select * from employees e
join departments d 
on e.department_id = d.department_id
where department_name = 'Marketing';

 select first_name ,e.department_id , department_name # when a column is common in both tables 
 from employees e inner join departments d            # we write it as 'e.department_id'
 on e.department_id = d.department_id
 where department_name = 'Marketing';
 
select * from employees;
 
 -- by using subquery 
 select first_name,department_id,'marketing'
 from employees where department_id=
 (select department_id from departments
 where department_name = 'marketing');
 select first_name,department_id from 
 employees where department_id =
 (select department_id from departments where department_name = 'marketing');
 -- but here we cant display department name as here select info is coming from employees table only
 -- this is a single row subquery
 -- operator used -- '=' -- single row operator
 
 
 
 -- list employees who are earning equal to Neena

 select * from employees 
 where salary = 
 (select salary from employees where first_name = 'neena' );
 select e1.* from employees e1
 join employees e2 ## Self join 
 on e1.salary = e2.salary and e2.first_name = 'neena';
 


-- OR

select e1.* from employees e1
 join employees e2
 on e1.salary = e2.salary
 where e2.first_name = 'neena';
 
 select * from departments;
 -- by subquery
 select * from employees
 where salary = 
 (select salary from employees where first_name = 'neena');
 -- first our subquery will excecute to find salary of neena then our main query will run
 
 -- display employee_id ,first_name,salary,job_id
 -- for all employees who earns salary and job_id 
 -- equals to neena
 select employee_id ,first_name,salary,job_id
 from employees where salary = (select salary from employees where first_name = 'neena') 
 and
 job_id = (select job_id from employees where first_name = 'neena');
 
 
 select employee_id ,first_name,salary,job_id from employees
 where salary = (select salary from employees where first_name = 'neena') 
 and job_id = ( select job_id from employees where first_name = 'neena'); 
 
 -- OR
 -- first finding salary and job id of neena 
 select salary,job_id from employees
 where first_name = 'neena';
 -- now:
 select * from employees where (salary,job_id)=
(select salary,job_id from employees
 where first_name = 'neena');
 select * from employees where (salary,job_id) =     ## 'in' will also work here
 (select salary,job_id from employees 
 where first_name = 'neena');

 
 -- write query to display employee_id,employee name
 -- (first_name and last_name) , salary for all
 -- employees who earn more than avg salary of the organisation
 
 select employee_id, concat(first_name,' ',last_name) employee_name
 from employees where salary > (select avg(salary) from employees);
 select employee_id,concat(first_name,last_name) emp_name from
 employees where salary > 
 avg(salary); -- error 
 
 -- using subquery
 select employee_id,concat(first_name,' ',last_name) emp_name from
 employees where salary > 
 (select avg(salary) from employees); 
 
 -- list employees working in sales
 select * from employees where 
 department_id = 
 (select department_id from departments where department_name = 'sales' );
 select * from employees where
 department_id =
 (select department_id from departments where department_name = 'sales');
 
-- these are non-co-related sub query as our subquery is independent of the main query 
-- or it will also work even without the main query


-- list all employees who are reporting to payam
select * from employees;
select * from  departments;
select * from employees ;
select * from employees where manager_id =
(select employee_id from employees where first_name = 'payam');
select * from employees where 
manager_id = (select employee_id from employees 
where first_name = 'payam');
 
 -- by join
 select e1.first_name from employees e1 join employees e2
 on e1.manager_id=e2.employee_id and e2.first_name='payam';
 
 -- list employee details who joined in the same year 
 -- along with clara
 -- exclude clara while listing
 select * from employees 
 where year(hire_date) = 
 (select year(hire_date) from employees where first_name = 'clara')
 and first_name != 'clara';
 select * from employees;
 select * from employees 
 where year(hire_date) = 
 (select year(hire_date) from employees where first_name = 'clara')
 and first_name != 'clara'; 
 
 
 -- what is the second highest salary

 select * from employees 
 order by salary desc limit 1,1; -- top 2 salaries could be same hence wrong approach
 
 select * from employees 
 where salary =
 (select distinct salary from employees 
 order by salary desc limit 1,1);
 
 select * from employees 
 where salary = 
 (select distinct salary from employees
 order by salary desc limit 1,1);
-- why we use distinct = as it will take duplicate values as a single value while ordering

-- find the second highest salary using subquery without using limit
select * from employees where salary = 
(select max(salary) from employees where salary <
(select max(salary) from employees )); 


select * from employees where salary =
(select max(salary) from employees where salary <
(select max(salary) from employees)); -- nested subquery 


-- display employee_id,first_name,salary,department_name and city
-- for all the employees who gets the salary more than 
-- the maximum salary earn by the employee who joined in the year 1997
select * from locations;
select * from departments;


--
select * from employees;
-- we need to use both join and subquery
select * from locations;
select e.employee_id,first_name,salary,department_name,city from
employees e join departments d
using(department_id) -- we can use using() instead of on clause if we have a common column but it is not a good approach
join locations l using(location_id)
where salary>
(select max(salary) from employees where year(hire_date) = 1997);

select e.employee_id,first_name,salary,department_name,city from
employees e join departments d
using(department_id)
join locations l
using(location_id)
where salary>
(select max(salary) from employees where year(hire_date)=1997);


-- display first_name,salary,department_id
-- for those who earn less than avg salary
-- of laura's department
select * from departments;
 
 select first_name,salary,department_id
 from employees where salary < (select avg(salary) from employees where department_id =
 (select department_id from employees where first_name ='laura'));
 

-- list all emloyees earning = david
  select * from employees where salary =
 (select salary from employees where first_name = 'david');
 -- we have 3 diff davids having salary 4800,9500,6800
 -- hence we can use 'in' operator

 select * from employees where salary in
 (select salary from employees where first_name = 'david');
select * from employees where salary =any
 (select salary from employees where first_name = 'david');

-- list all employees earning more than any of the david
 select * from employees where salary >any
 (select salary from employees where first_name = 'david'); -- any works as 'or' operator
 
 select * from employees where salary >
 (select min(salary) from employees where first_name = 'david'); -- same output
 
 select * from employees where salary >all
 (select salary from employees where first_name = 'david'); -- all works as 'and' operator
 
 select * from employees where salary >
 (select max(salary) from employees where first_name = 'david');-- same output
 
 -- >=any 
 -- <any
 -- <=any
 -- =any / in
 
 
 -- 19/12/2023 day2
 use hr;
 -- list employees who are earning the min salary compared to any of the other department
 select * from employees where salary in 
 (select min(salary) from employees group by department_id);
 
 select * from employees where salary in
 (select min(salary) from employees group by department_id);
 select * from employees ;
 select * from departments;
 
 -- list the department_name and department_id even without any employees tagged with that dept
 select * from employees;
 select department_name,department_id from departments;
 
 -- list only those departments names where employees are working
 
 select department_name from departments where department_id in
 (select distinct department_id from employees where department_id is not null);
 
-- list only those departments names where employees are not working
  select department_name from departments where department_id not in	
 (select distinct department_id from employees where department_id is not null);
 
 -- write names of all managers using subquery
 select * from employees;
 select * from departments;
 
 select concat(first_name,' ',last_name) manager_names from employees where
 employee_id in (select distinct manager_id from employees where manager_id is not null);
 
 -- OR
 
 select concat(first_name,' ',last_name) manager_names from employees where
 employee_id in (select manager_id from departments where manager_id is not null);
 
 
 -- list employees working in location 1700
 select * from employees;
 select * from locations;
 select * from departments;
 select * from employees where department_id in 
 (select department_id from departments where location_id = 1700);
 
 -- list employees earning more than avg salary of any of the department
 select * from employees where salary >any 
 (select avg(salary) from employees group by department_id);
 
-- list employees earning more than avg salary of his own department
 
 select * from employees e where salary >
 (select avg(salary) from employees 
 where department_id=e.department_id);
 -- this is an corelated subquery as it is dependent on the outer query so here our main query will get excecuted first
 
 -- list the department_name if atleast an employee is working for that department (already done but now by corelation)
 select department_name from departments d where department_id in
 (select department_id from employees where department_id=d.department_id);
 
 -- OR
 

 

 select department_name from departments d where department_id =
 (select distinct department_id from employees where department_id=d.department_id);
 
 -- display name and dep id of all departs that has at least one employee with salary greater than 10,000
 
 select * from employees;
 select department_name,department_id from departments d where department_id in
 (select department_id from employees where department_id = d.department_id and salary>10000);
 
 -- OR
 
  select department_name,department_id from departments d where department_id =
 (select distinct department_id from employees where department_id = d.department_id and salary>10000);
 
 -- by non corelation
 select department_name,department_id from departments where department_id in
 (select distinct department_id from employees where salary>10000);
 
 
 
 -- exists operator : will give true or false as the output
 
 select * from employees where exists 
 (select * from employees where department_id = 80);
 -- will check if there is any department_id 80
 
 -- list department_name when atleast an employee is working in that dept
 select department_id,department_name from departments d
 where exists 
 (select * from employees where department_id=d.department_id);
 
 -- list department_name where no employee is working in that dept
 select department_id,department_name from departments d
 where not exists 
 (select * from employees where department_id=d.department_id);
 
 -- display name and dep id of all departs that has at least one employee with salary greater than 10,000
select department_name,department_id from departments d where exists
 (select department_id from employees where department_id = d.department_id and salary>10000);
 
 -- display the manager names
 select concat(first_name,' ',last_name) manager_name from employees e
 where exists 
 (select * from employees where manager_id = e.employee_id);

 -- find the department which has highest avg salary (do not use limit)
 select department_id from employees e where salary>all
 (select avg(salary) from employees group by department_id);
 
 select department_id ,avg(salary) avg_sal from employees
 group by department_id 
 having avg_sal>=ALL -- using group by so cant use where , we must use having
 (select avg(salary) from employees 
 group by department_id);
 
use hr ;
 select department_name , count(employee_id) cnt
 from employees e join departments d 
 on e.department_id = d.department_id
 group by department_name
 having cnt>5;

 
-- display department which has highest number of employees
 select * from employees;
 select department_id,count(employee_id) cnt from employees
 group by department_id
 having cnt>=ALL
 (select count(employee_id) from employees 
 group by department_id);
 
 -- and if we need to show department name also :
 
select department_id,count(employee_id) cnt,department_name from employees e join departments d using(department_id)
 group by department_id
 having cnt>=ALL
 (select count(employee_id) from employees 
 group by department_id);
 
 -- find departments whose average salary is more than the avg salary of department 80
 select department_id,avg(salary) _avg ,department_name from employees e join departments d using(department_id)
 group by department_id
 having _avg>
 (select avg(salary) from employees where department_id = 80);
 
 
 -- select operator
 
select count(employee_id) emp_count,
(select count(department_id) from departments) dept_count
from employees;

-- display dep id ,first name, department name using select clause subquery

select department_id,first_name ,
(select department_name from departments where department_id = e.department_id) dept_name
from employees e;




-- 20-12-23
use hr;
-- use of select -- select column1,(select column2 from t2) from t1; 

-- list employees and manager names 
select e1.first_name emp_name ,e2.first_name manager_name 
from employees e1 join employees e2
on e1.manager_id = e2.employee_id;

-- by using select clause subquery
select e1.first_name emp_name ,
(select e2.first_name from employees e2 where e2.employee_id = e1.manager_id) manager_name
from employees e1;

-- OR
select first_name emp_name ,
(select first_name from employees where employee_id = e.manager_id) manager_name
from employees e;



-- subquery in from clause
 
select first_name,salary,0.1*salary bonus from employees;
-- using alias is not mandatory

select first_name,salary,0.1*salary bonus from employees
where bonus>1000; -- error as where dont recognise alias

select first_name,salary,0.1*salary bonus from employees
where 0.1*salary>1000;


-- correct approach
select * from
(select first_name,salary,0.1*salary bonus from employees) temp
 where bonus>1000;
 -- creating a temporary table called temp
 -- and here we must give the alias 

-- CTE ( Common Table Expression ) 'with' clause
with temp as 
(select first_name ,salary,salary*0.1 bonus from employees)
select * from temp where bonus>1000;

create table temp as 
select first_name ,salary,salary*0.1 bonus from employees; -- this will be the permanent table


select * from employees;
select count(job_id) managers from
(select job_id from employees) temp1
 where job_id like '%MGR' union
 select count(job_id) clerks from
(select job_id from employees) temp2
 where job_id like '%CLERK'; -- self attempt , not accurate

 select new_jobid,count(*) from
 (select job_id,
 case when job_id like '%clerk%' then 'clerk'
 else 'manager' end new_jobid
 from employees 
 where job_id like '%mgr%' or job_id like '%man%' or job_id like '%clerk%') temp
group by new_jobid; 
 
-- OR
select 'clerk' ,count(*) from employees where job_id like '%clerk%'
union
select 'Manager' , count(*) from employees where job_id like '%mgr%' or job_id like '%man%';
 
 
 
 select * from employees;
 -- list all employees working in org more than 25 years as on today
 select * from employees where (datediff(current_date,hire_date))/365 > 25;
 -- OR
 select * from 
 (select first_name,datediff(current_date(),hire_date)/365 tenure
 from employees)t
 where tenure>25;
 -- OR
 select * from employees where (year(current_date) - year(hire_date)) > 25; 
-- perfect approach is datediff approach
 
 
 select * from
 (select department_id,job_id,count(*) _count from employees 
 where department_id = 80 
 group by department_id,job_id)t1
 cross join
 (select count(*) from employees
 where department_id =80)t2;
 -- as there is no common column between the two tables hence we used cross join
 
 
 -- OR
 
 select department_id,job_id,count(*),
 (select count(*) from employees where department_id=80) total_count
 from employees
 where department_id = 80
 group by department_id,job_id;
 
 
 -- conditions -- if,notnull,nullif , case etc
 
 -- find given number odd or even if(exp1,exp2,exp3)
 select if(mod(20,2)=0,'even','odd') ;
 
 -- alias 
 select if(mod(20,2)=0,'even','odd') result;
 select if(mod(20,2)=0,'even','odd') result;
 
 -- ifnull(e1,e2)
 -- display first name , salary and commission% for all empl , calculate commsion value
 select first_name , salary, commission_pct , 
 salary*commission_pct comm_value ,
 salary + (salary*commission_pct) total_salary
 from employees;  -- will give null due to null values in commssion
 
 select first_name , salary, commission_pct , 
 salary*commission_pct comm_value ,
 salary + (salary*ifnull(commission_pct,0)) total_salary
 from employees;
 
 -- coalesce 
select first_name , salary, commission_pct , 
 salary*commission_pct comm_value ,
 salary + (salary*coalesce(commission_pct,0)) total_salary
 from employees;
 -- same action of ifnull function
 -- it do have some additional features also - can don multiple checks

select coalesce(primary,secondary,parent,gaurdian,friend);
-- if null can check max 2 values 
 
 
 
 -- nullif(e1,e2)
 select nullif(20,20); -- give null if e1=e2
 select nullif(25,20);

-- find all IT programs and replace with null
select job_id ,nullif(job_id,'IT_PROG') revised_job from employees;

-- by using if
select job_id ,if(job_id = 'IT_PROG',NULL,job_id) revised_job from employees;
 
 
 
 -- case - when there is multiple conditions
 
 -- salary > 15000 verygood
 -- between 12 and 15000 good
 -- between 8 and 12 moderate
 -- <8000 need revision
 
 select first_name,salary,
 case 
 when salary>15000 then 'Very good'
 when salary between 12000 and 15000 then 'Good'
when salary between 8000 and 11999 then 'Moderate'
else 'Need Revision'
end salary_tag from employees;
 
 
 
 -- WINDOW FUNCTIONS:
 -- Advanced Aggregate Functions:
 
 
-- Ranking functions:
-- 1. row_number()
select row_number()over() 'S.No',first_name,department_id from employees;


-- list only the rows from S.no 20 to 30 
select row_number()over() 'S.No',first_name,department_id from employees
where row_number()over() = 20; -- error 'we cannot use window functions with where clause'

select * from 
(select row_number()over() 'S.No',first_name,department_id from employees)t
where `S.No` between 20 and 30; -- will work by using back quotes

-- 2. rank()
select first_name,salary,rank()over(order by salary desc) _rank from employees;

-- 3. dense_rank()
select first_name,salary,rank()over(order by salary desc) _rank,
dense_rank()over(order by salary desc) drnk
from employees;

-- 4. cume_dist()
select first_name,salary,cume_dist()over(order by salary) dist
from employees;



-- aggregate functions:
select first_name,department_id,salary,
sum(salary)over() from employees;

select first_name,department_id,salary,
sum(salary) from employees; -- error hence we have to use over()

-- list all the employees earning more than avg salary of organisation
select * from 
(select first_name,department_id,salary,
avg(salary)over() avg_sal from employees)t
where salary>avg_sal;


-- how to find the avg salary for each department -partition by
select first_name,department_id,salary,
avg(salary)over(partition by department_id) avg_sal from employees;
-- works same as group by

-- list employees who are earning salary more than avg salary of their own department
select * from (select first_name,department_id,salary,
avg(salary)over(partition by department_id) avg_sal_dept
from employees)t
where salary>avg_sal_dept;

--  by correlated subquery
select first_name,salary from employees e where salary>
(select avg(salary) from employees 
where department_id = e.department_id);


-- list employees where salary more than avg salary of the org
select * from (select first_name,department_id,salary,
avg(salary)over() avg_sal_dept
from employees)t
where salary>avg_sal_dept;

 
 -- display depart which has highest avg salary
 select * from
 (select *,dense_rank()over(order by avg_sal desc) rnk from 
 (select department_id,avg(salary) avg_sal from employees 
 group by department_id)t)t1
 where `rnk` = 1;
 -- if we want to display department name
 select * from
 (select *,dense_rank()over(order by avg_sal desc) rnk from 
 (select department_id,department_name,avg(salary) avg_sal from employees
 join departments using(department_id)
 group by department_id)t)t1
 where `rnk` = 1;
 
 
 -- find the senior person from the organisation
 select * from
 (select *,dense_rank()over(order by _joining desc) rnk from 
 (select department_id,department_name,datediff(current_date,hire_date)/365 _joining from employees
 join departments using(department_id)
 group by department_id)t)t1
 where `rnk` = 1;
 
 select first_name,year(current_date)-year(hire_date) from employees;
 
 select * from
 (select first_name,dense_rank()over(order by hire_date) rnk from employees)t
 where `rnk` = 1;
 
 select * from employees where hire_date = 
 (select min(hire_date) from employees);
 
 -- senior in each department
 select * from
 (select first_name,department_id,
 dense_rank()over(partition by department_id order by hire_date) rnk
 from employees)t
 where rnk=1;
 
 
 -- juniormost in each department
 select * from
 (select first_name,department_id,
 dense_rank()over(partition by department_id order by hire_date desc) rnk
 from employees)t
 where rnk=1;
 
 
 -- 21/12/23
 
-- minimum salary of the organisation
use hr ;
select min(salary) from employees;

-- by windows function
select min(salary)over() from employees; -- getting 107 rows

-- find the employee with min salary
select * from employees where salary = 
(select min(salary) from employees);

select first_name,max(salary) from employees; -- wrong approach
-- cant use non aggregate with aggregate function without group by
 select department_id,first_name,max(salary) from employees
 group by department_id;
 
 
 -- find the employee with min salary by window function
select * from 
 (select first_name,salary,department_id,min(salary)over() min_sal from employees)t
 where salary = min_sal;
 
 
 -- find the minimum salary of the each department
 select department_id,min(salary) from employees 
 group by department_id;
 
 -- by window functions
 select first_name,salary,department_id,min(salary)over(partition by department_id) min_sal from employees ;
 
 -- find the person with minimum salary of the each department
 
 select * from employees e where salary =  
 (select min(salary) from employees where department_id=e.department_id);
 
 -- by window function
 select * from
 (select first_name,salary,department_id,min(salary)over(partition by department_id) min_sal from employees)t
 where salary=min_sal;
 
 
 -- who is the employee getting second highest salary
 select * from  employees where salary =
 (select distinct salary from employees order by salary desc limit 1,1);
 
 -- by window functions
 select * from
 (select * ,dense_rank()over(order by salary desc) rnk from employees)t
 where rnk = 2;
 
 -- find employees earning second highest salary from each department
 select * from employees e where salary =
 (select distinct salary from employees 
 where department_id = e.department_id
 order by salary desc limit 1,1);
 
 -- by window functions
 select * from
 (select * ,dense_rank()over(partition by department_id order by salary desc) rnk from employees)t
 where rnk = 2;
 
 -- display all employees with min  max and avg salary of org
 select * from
 (select *,
 min(salary)over() min_sal
 ,max(salary)over() max_sal
 ,count(employee_id)over() emp_count
 ,avg(salary)over() avg_sal from employees)t;
 
 
 -- by subquery
 select * ,(select min(salary) from employees) min_sal
 from employees; -- and so on
 
 
 
 -- ANALYTICAL FUNCTIONS :
 -- lead()
 -- lag()
 -- first_value()
 -- last_value()
 -- Ntile()
 
 -- lead() - will give the next value 
 select first_name,department_id,salary,
 lead(salary)over() next_salary
 from employees;
 
 -- lag - will show the previous value
 select first_name,department_id,salary,
 lag(salary)over() next_salary
 from employees;
 
 select first_name,department_id,salary,
 lead(salary,2)over() next_salary
 from employees; -- will give next value after skipping two values
 
 -- list the first_job and promoted job for each employee
select * from job_history; 
select employee_id,job_id first_job,
 lead(job_id)over(partition by employee_id order by start_date) prom_job
 from job_history; -- will give next value after skipping two values
 
 -- removing null values
select * from
( select employee_id,job_id first_job,
 lead(job_id)over(partition by employee_id order by start_date) prom_job
 from job_history)t
 where prom_job is not null; -- will give next value after skipping two values

-- adding start and end dates 
select * from
( select employee_id,job_id first_job,
start_date firstjob_date,
 lead(job_id)over(partition by employee_id order by start_date) prom_job,
 lead(start_date)over(partition by employee_id order by start_date) prom_date
 from job_history)t
 where prom_job is not null;
 
 
 create table temp (
t_date date,
temp int);

insert into temp values
('2020-12-01',20),
('2020-12-02',25),
('2020-12-03',20),
('2020-12-04',28);
SELECT * from temp;
-- display the date on which the temperature is increased compared to the previous day
select t_date from
(select t_date,temp,
lag(temp)over(order by t_date) previous_temp,
temp - lag(temp)over(order by t_date) diff_temp
from temp)t
where diff_temp >0;


-- first_value(),last_value()

select first_name,salary,
first_value(salary)over() first_val
from employees;

select first_name,salary,
last_value(salary)over() last_val
from employees;


select first_name,salary,
last_value(salary)over(order by salary desc) first_val
from employees; -- will not give the desired output as the framework is changed((unbounded preceding to current row)) due to order by
-- hence we need to change it to default
-- default framing -(unbounded preceding to unbounded following) 

-- order by changes the framing to unbounded preceding to current row
select first_name,salary,
last_value(salary)over(order by salary 
rows between unbounded preceding and unbounded following) last_val
from employees;

-- rows between unbounded preceding and unbounded following -- full
-- rows between unbounded preceding and current row -- first half
-- rows between current row to unbounded following -- second half

-- rows between 1 preceding and 1 following

-- cummulative addition
select first_name,salary,
sum(salary)over(rows between unbounded preceding and current row) cum_total
from employees ;

select first_name,salary,
sum(salary)over(rows between 1 preceding and 1 following) cum_total
from employees ; -- here it is adding 1 preceding + current + 1 proceeding


create table sumid
(id int);
insert into sumid values (10),(11),(12),(13),(14),(15),(16);

select * from sumid;

-- desired output
-- 10 null
-- 11 null
-- 12 null
-- 13 33
-- 14 36
-- 15 39
-- 16 42
select id,
sum(id)over(rows between 1 preceding and 1 following) cum_total
from sumid ;

-- Ntile: to divide the entire dataset into number of groups 

select ntile(10)over() from student;

select first_name,salary,
ntile(10)over() from employees;

select bucket,count(*) from
(select first_name,salary,
ntile(10)over() bucket from employees)t
group by bucket;

-- find out the moderate earners in the organisation
select bucket,count(*) from
(select first_name,salary,
ntile(3)over(order by salary desc) bucket from employees)t
group by bucket;
-- bucket 1 - top earners
-- bucket 2 - modertate earners
-- bucket 3 - least earners 

-- OR to know further details:
select * from
(select first_name,salary,
ntile(3)over(order by salary desc) bucket 
from employees)t
where bucket = 2; -- output will be same if we dont use order by as we need to find moderate , not top or least earners






-- to know brief about functions
help 'count';
help 'function';
help 'functions';



-- 22-12-23
use hr;

-- foreign key -- files sent 
-- primary key -- on whatsapp

-- Transaction language - rollback,committ,savepoint

-- Views - virtual tables
drop view v1;
create view v1 as
select employee_id,first_name,department_id,salary from employees 
where department_id = 80; 


select * from v1;
desc v1;
select * from employees where first_name = 'karen';

update v1 set department_id = 100 where first_name ='karen';
-- now the output 33 (1 row less) 
 
select * from employees where first_name = 'karen';
-- department_id has been changed to 100 in the base tables



-- Normalisation - to reduce the redundancy of the table
-- 1NF
-- 2NF
-- 3NF