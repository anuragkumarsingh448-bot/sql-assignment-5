create database subqueries;
use subqueries;
create table employee_Dataset
(emp_id char(6),
name varchar(20),
department_id char (3),
salary int);
select * from employee_Dataset;
insert into employee_Dataset
values
("101", "Abhishek", "D01", 62000);
select * from employee_dataset;
Insert into employee_Dataset
values
("102", "Shubham", "D01", 58000),
("103", "Priya", "D02", 67000),
("104", "Rohit", "D02", 64000),
("105", "Neha", "D03", 72000),
("106", "Aman", "D03", 55000),
("107", "Ravi", "D04", 60000),
("108", "Sneha", "D04", 75000),
("109", "Kiran", "D05", 70000),
("110", "Tanuja", "D05", 65000);
select * from employee_dataset;

create table Department_Dataset
(department_id char(3),
department_name varchar(10),
location varchar(15));
select * from Department_dataset;

insert into department_dataset
values
("D01", "sales", "mumbai"),
("D02", "Marketing", "Delhi"),
("D03", "finance", "Pune"),
("D04", "HR", "Bengaluru"),
("D05", "IT", "Hyderabad");
select * from department_dataset;

create table sales_dataset
(sale_id char(3),
emp_id int,
sale_amount int,
sale_date date);
select * from sales_dataset;
Insert into sales_dataset
values
("201", 101, 4500, 20250105);
select * from sales_dataset;
Insert into sales_dataset
values
("202", 102, 7800, 20250101),
("203", 103, 6700, 20250114),
("204", 104, 12000, 20250120),
("205", 105, 9800, 20250202),
("206", 106, 10500, 20250205),
("207", 107, 3200, 20250209),
("208", 108, 5100, 20250215),
("209", 109, 3900, 20250220),
("210", 110, 7200, 20250301);
select * from sales_dataset;

### Basic Level
### Question no. 1 Retrieve the names of employees who earn more than the average salary of all employees?
select avg(salary) from Employee_dataset;

select * from employee_dataset 
where salary > (select avg(salary) from Employee_dataset);
select * from employee_dataset;

### Question no. 2 Find the employees who belong to the department with the highest average salary?
select * from Employee_dataset;
select * from Department_dataset;
select name from Employee_dataset ed
where department_id = (select department_id from Employee_dataset
group by department_id
order by avg(salary) desc
limit 1);

### Question no. 3 List all employees who have made at least one sale? 
select name, sale_id, sale_amount from Employee_dataset ed
left join Sales_dataset sd
on ed. emp_id = sd.emp_id;

### Question no. 4 Find the employee with the highest sale amount?

select * from Employee_dataset ed
 join sales_dataset sd
 on ed.emp_id = sd.emp_id
 order by sale_amount desc
 limit 1;
 
 ### Question no. 5 Retrieve the names of employees whose salaries are higher than shubham's salary?
select * from employee_dataset;

 select name from Employee_dataset
 where salary > (select salary from employee_dataset where emp_id = "102");
 
 ### Intermediate level
 ### Question no 1 Find employees who work in the same department as abhishek?
 select * from Employee_Dataset 
 where department_id = (select department_id from employee_dataset where name = "abhishek");
 
 ### Question no. 2 List departments that have at least one employee earning more than rs60,000)?
 select * from Employee_dataset ed
 join Department_dataset dd
 on ed.department_id = dd.department_id
 where salary > (select salary from employee_dataset where salary = 60000);
 
 ### Question no. 3 Find the department name of the employee who made the highest sale?
 select name, ed.department_id, department_name, sale_amount from employee_dataset ed
 join department_dataset dd
on ed.department_id = dd.department_id
join sales_dataset sd
on ed.emp_id = sd.emp_id
order by sale_amount desc
limit 1;

### Question no. 4 Retrieve employees who have sales greater than the average sale amount?
select name, sale_amount from employee_dataset ed
join sales_dataset sd
on ed.emp_id = sd.emp_id
where sale_amount > ( select avg(sale_amount) from Sales_dataset);

### Question no. 5 Find the total sales made by employees who earn more than the average salary?
select name, salary, sale_amount from employee_dataset ed
join sales_dataset sd 
on ed.emp_id = sd.emp_id
where salary > (select avg(salary) from employee_dataset);

### Advamced Level
### Question no. 1 find employees who have not made any sales
select name from employee_dataset ed
where emp_id not in (select distinct emp_id from sales_dataset);

#### Question no. 2 List departments where the average salary is above rs 55,000?
select name , department_name, salary from employee_dataset ed 
join department_dataset dd
on ed.department_id = dd.department_id
where (select avg(salary) from employee_dataset) > 55000;

### Question no. 3 retrieve department name where the total sales  exceed rs 10,000?
select department_name, sale_amount from employee_dataset ed
join department_dataset dd
on ed.department_id = dd.department_id
join sales_dataset sd
on ed.emp_id = sd.emp_id
where sale_amount > 10000;

### Question no. 4 Find the employee who has made the second-highest sale?
select name, sale_amount from employee_dataset ed
join sales_dataset sd
on ed.emp_id = sd.emp_id
order by sale_amount desc
limit 1
offset 1;

#### Question no. 5 Retrieve the names of employees whose salary is greater than the highest sale amount recorded? 
select name from employee_dataset 
where salary > (select sale_amount from sales_dataset order by sale_amount desc limit 1);

