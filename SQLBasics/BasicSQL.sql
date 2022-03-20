create database DB_Programming;
use DB_Programming;

create table Employeeinfo (
employee_id int IDENTITY (1,1) PRIMARY KEY,
name varchar(50),
salary float,
gender char(2),
phone_no bigint,
startDate Date
);
----Insert data----
insert into Employeeinfo (name,salary,gender,phone_no,startDate) values('Samay',21000,'M', 793813951,'05-08-2016'),('Kavita',23000,'F',9221022190,'06-11-2014'),('Rahul',26000,'M',6432777189,'1-11-2011'),('Nisha',27000,'F',9559110238,'10-24-2018');
insert into Employeeinfo (name,salary,gender,phone_no,startDate,department) values('Deepak',32500,'M',8303957139,'08-30-2019','Sales');

delete from Employeeinfo where employee_id=1006;

----Alter table----
alter table Employeeinfo add department varchar(50) not null default 'IT';

----update table----

update Employeeinfo set department='Sales' where employee_id in(3,4)
update Employeeinfo set salary=27500 where employee_id=4;

----Quering data----

select * from Employeeinfo;
select name,phone_no from Employeeinfo;

----Sorting data----

select * from Employeeinfo order by name;
select name,salary from Employeeinfo order by gender desc;
select name,phone_no from Employeeinfo order by LEN(name) desc;
select name,salary from Employeeinfo order by 1,2;

----Limiting rows----

-----offset fetch----
select name,salary from Employeeinfo order by salary,name offset 2 rows
select name,salary from Employeeinfo order by salary,name offset 1 row fetch next 3 rows only

-----select top-----
select top 3 name,salary from Employeeinfo order by salary desc;
select top 40 percent name,salary from Employeeinfo order by salary desc;

---- Filtering Data ----

select distinct name from Employeeinfo order by name;
select * from Employeeinfo where name='samay';
select * from Employeeinfo where employee_id=5 or gender = 'F';
select * from Employeeinfo where salary=21000 and gender='M';
select name from Employeeinfo where gender='M' and department ='IT'
select * from Employeeinfo where not department='Sales' order by phone_no asc;
select * from Employeeinfo where salary in (24000,27500) order by name;

select * from Employeeinfo where startDate between cast('2011-01-11' as date) and getdate();
select * from Employeeinfo where startDate between cast('2015-06-12' as date) and getdate();

select employee_id,name from Employeeinfo where name like 'S%'

select phone_no,name from Employeeinfo where phone_no like '%0'

select employee_id,name from Employeeinfo where name like 'K%'

select gender,name from Employeeinfo where name like '_a%'

select employee_id,name from Employeeinfo where name like '[SK]%' order by name;

select phone_no,name from Employeeinfo where phone_no like '[5-7]%' order by name;

select employee_id,name from Employeeinfo where name like '[^k-R]%' order by name;

----column and table alias----
select employee_name  + ' ' +  city as EmployeeCity from Employee order by employee_id;

select employee_name  + ' ' +  city as 'Employee City' from Employee order by employee_id;

select name,salary from Employeeinfo where department='IT' order by name asc;

drop table Employeeinfo;

