---------Subquery----------
use DB_Programming;

select * from Employee;

select employee_id,employee_name,gender from Employee where employee_id in (select employee_id from Employee where city='Surat' ) order by gender;

-----correlated subquery---------

select * from Employeeinfo

----2nd lowest salary----

select salary from Employeeinfo a where 2=(select count(salary) from Employeeinfo b where a.salary>=b.salary);

----3nd highest salary-----

select salary from Employeeinfo a where 3=(select count(salary) from Employeeinfo b where a.salary<=b.salary);


-----Exists operator-----

select employee_id,employee_name from Employee where exists(select null) order by employee_id;

select * from Employee e where Exists ( select employee_id from Employee q where e.employee_id = q.employee_id and city = 'Surat' ) order by e.employee_id;

-----Any operator-----

select name,salary from Employeeinfo where employee_id = any (select employee_id from Employeeinfo where employee_id > 2 ) order by name;

----All operator-----

select * from ItemSales

select category,avg(sales)AvergeSales from ItemSales group by category order by AvergeSales;

select brand,category,sales from ItemSales where sales < All ( select avg(sales)AvergeSales from ItemSales group by category ) order by sales;

select brand,category,sales from ItemSales where sales > All ( select avg(sales)AvergeSales from ItemSales group by category ) order by sales;