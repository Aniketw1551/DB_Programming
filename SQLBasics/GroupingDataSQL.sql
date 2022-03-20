---------Grouping Data--------------

use DB_Programming;

select * from Employeeinfo

-----Aggregate functions-----

select min(salary) as MinimumSalary,gender from Employeeinfo group by gender;

select max(salary) as MaximumSalary,gender from Employeeinfo group by gender;

select sum(salary) as TotalSalary,gender from Employeeinfo group by gender;

select avg(salary) as AverageSalary,gender from Employeeinfo group by gender;

select count(name)as NumberOfEmployees,gender from Employeeinfo group by gender;

----Having clause-------

select * from Employeeinfo

select name, min(salary) MinimumSalary from Employeeinfo group by name having min(salary) between 21000 and 27500;

select gender, count(name)as NumberOfEmployees from Employeeinfo group by gender having count(name)>4 order by gender;

select gender,avg(salary) AverageSalary from Employeeinfo group by gender having avg(salary)=27500 order by gender;

select name, max(salary) MaximumSalary from Employeeinfo group by name having max(salary)<=26000 order by name desc;

-------------------------------------------------------------------
create table ItemSales(
brand varchar(100),
category varchar(100),
sales_year int,
sales int,
revenue float
);

insert into ItemSales (brand,category,sales_year,sales,revenue) values('Samsung','Smartphones',2012,10000,200000),('Samsung','Smartphones',2013,15000,300000),('Samsung','Laptop',2012,2000,10000),
																('Samsung','Laptop',2013,5000,20000),('Realme','Smartphones',2012,9000,150000),('Realme','Smartphones',2013,12000,180000),
																('Realme','Laptop',2012,1000,10000),('Xiaomi','Smartphones',2012,14000,250000),('Xiaomi','Laptop',2013,1800,35000);

select * from ItemSales

update ItemSales set brand='Realme' where sales=1000;

-----Groupping sets-----

select brand,sum(sales)TotalSales from ItemSales group by brand order by brand;

select brand,category,sum(sales)TotalSales from ItemSales group by brand,category order by brand,category;


select brand,category,sum(sales)TotalSales from ItemSales group by grouping sets ( (brand,category),(brand) ) order by brand,category;

---------Cube------------

select brand,category,sum(sales)TotalSales from ItemSales group by cube(brand,category);

select brand,category,sum(sales)TotalSales from ItemSales group by brand, cube(category);

--------Rollup----------
select brand,category,sum(sales)TotalSales from ItemSales group by rollup(brand,category);

select brand,category,sum(sales)TotalSales from ItemSales group by category, rollup (brand);

select * from Employee;

select * from Payment;

select * from Department;


select sum(basic_salary) as SALARY_M, avg(net_salary) as AVERAGE_M, 
     count(payment_id) as COUNT_Payment
    from Payment p inner join Employee e
    on p.employee_id=e.employee_id
    where e.gender = 'M' group by e.gender;


