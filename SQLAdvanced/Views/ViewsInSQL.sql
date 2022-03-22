----------------Views in SQL-----------------
use DB_Programming;
go
---------Create View----------

select * from Employeeinfo

select * from Employee

select * from ItemSales
go

Create view EmployeeDetails
as
select * from Employeeinfo

select * from EmployeeDetails
go
--------Alter or moifiy view-----------

Alter view EmployeeDetails
as
select name,phone_no from Employeeinfo

select * from EmployeeDetails

----Defination------

sp_helptext 'EmployeeDetails'

drop view EmployeeDetails

----------Create view from single or multiple tables----------

select * from Employee

select * from Payment

alter view EmployeeDetailsMultipleTable
as
select a.employee_name,a.city, a.zip,b.net_salary from Employee a join Payment b on a.employee_id=b.employee_id;

select * from EmployeeDetailsMultipleTable

-------Update metadata of view---------

create view EmployeeDetails1
as
select * from Employeeinfo

select * from EmployeeDetails1

alter table Employeeinfo add city varchar(100)

exec sp_refreshview EmployeeDetails1

-------Schema binding in view--------

create view EmployeeDetails2
as
select * from Employeeinfo

select * from EmployeeDetails2

alter table Employeeinfo drop column city

create view EmployeeDetails2WithSchemaBinding
with schemabinding
as
select name,salary from dbo.Employeeinfo

alter table Employeeinfo drop column name

drop view EmployeeDetails2WithSchemaBinding

-------Hide complexity of query------

-------Row Level Security-----------

create view EmployeeRowLevel
as
select * from Employeeinfo where salary > 26000

select * from EmployeeRowLevel order by salary

------------Column Level Security-----------------

create view EmployeeColumnLevel
as
select name,phone_no from Employeeinfo

select * from EmployeeColumnLevel


--------Update,Delete,insert into view------------

alter view DemoDetails
as
select * from Employee

select * from DemoDetails

delete from Employeeinfo where salary=31500;

--------- Insert Data------------

insert into DemoDetails(employee_name,gender,phone_no,city,zip,manager_id) values('Ram','M',9538129542,'Thane',666301,9)

delete from DemoDetails where employee_id=1008
update DemoDetails set employee_name='Jayesh' where employee_id=1

-----------with check in option------------


create view WithCheckOption
as
select * from Employee where city='Pune'
with check option

select * from WithCheckOption

insert into WithCheckOption(employee_name,gender,phone_no,city,zip,manager_id) values('Prerna','F',5039215831,'Kolkata',332135,9)

--delete from WithCheckOption where manager_id=9