-----------------Triggers in SQL------------------

----------------DML Triggers-------------------

use DB_Programming;

select * from EmployeeSalary
go

insert into EmployeeSalary (employee_name,department,basic_salary,bonus,total_salary) values ('Aakash','IT',24500,1500,26000)
insert into EmployeeSalary (employee_name,department,basic_salary,bonus,total_salary) values ('Neema','Sales',27000,1000,28000)
insert into EmployeeSalary (employee_name,department,basic_salary,bonus,total_salary) values ('Nilesh','Marketing',29000,1000,30000)
go
--------------Audit table--------------

create table Emp_audit
( ID int ,
inserted_by varchar(100)
)
go

select * from Emp_audit
go
------------Trigger for insert event-----------

create trigger trg_insert_audit
on EmployeeSalary
for insert 
as
begin
declare @ID int
select @ID = employee_id from inserted insert into Emp_audit (ID,inserted_by) values (@ID,ORIGINAL_LOGIN())
print 'Insert trigger executed'
end
go

-----------Trigger for delete event-----------

create trigger trg_delete_audit
on EmployeeSalary
for delete 
as
begin
declare @ID int
select @ID = employee_id from deleted insert into Emp_audit (ID,inserted_by) values (@ID,ORIGINAL_LOGIN())
print 'Delete trigger executed'
end
go

delete from EmployeeSalary where employee_id=10

select * from EmployeeSalary
select * from Emp_audit

-------------delete trigger with rollback---------------

create trigger trg_delete
on EmployeeSalary
for delete
as
begin
rollback
print '***** You cannot delete records from this table*****'
end 
go

delete from EmployeeSalary where employee_id=1


select * from Emp_audit
select * from EmployeeSalary
go

----------------Instead of insert trigger------------

create table Products(
product_id int identity (1,1) primary key,
product_name varchar(100),
cost int
);

create table Sales(
sale_id int identity (1,1) primary key,
product_id int,
sale_price int
);

insert into Products values('Mobile',10000)
insert into Products values('Laptop',25000)
insert into Products values('Camera',27000)

insert into Sales values(1,12000)
insert into Sales values(2,30000)
insert into Sales values(1,15000)
insert into Sales values(3,30000)

drop table Sales
select * from Products
select * from Sales
go

--drop table EmployeeCity
--drop view Employee_Detail

create view Product_Detail
as
select 
a.product_id,a.product_name,a.cost,c.sale_price
from Products a inner join Sales c on a.product_id=c.product_id

select * from Product_Detail

go

create trigger trg_InsteadInsert
on Product_Detail
instead of insert 
as
begin
declare @product_id  int 
select product_id = @product_id  from inserted
if exists (select top 1 * from Products where product_id = @product_id)
begin
insert into Sales(product_Id,sale_price)
select a.product_id,a.sale_price from inserted a
end
else
begin
print 'Adequate data not provided'
 end
end
go

drop trigger trg_InsteadInsert

select * from Products
select * from Sales
select * from Product_Detail

insert into Product_Detail(product_id,product_name,cost,sale_price)values(5,'aa',25000,30000)
go

---------------------DDL Triggers---------------------


create database triggerdemo;

use triggerdemo
go

create table t1(
id int );
go

------------Create,alter or drop table--------------

create trigger trg_triggerdemoforalldatabse
on database 
for create_table,alter_table,drop_table
as
begin 
rollback
print 'You are not authorized to create,alter or drop table'
end

alter table t1 add name varchar(100);
go

create table t2(
id int );
go

drop table t1;
go

------------------trigger for all server-------------

create trigger trg_triggerforAllServer
on All server
for create_table,alter_table,drop_table
as
begin 
rollback
print 'You are not authorized to create,alter or drop any tables in this server'
end

create table S( id int) 

----------------List all trigggers----------------
select * from sys.triggers


--------------Defination of trigger--------------

select * from sys.sql_modules
where OBJECT_ID = object_id('trg_delete')
go

-----------disable or enable trigger-----------

disable trigger trg_delete on EmployeeSalary
go

disable trigger trg_triggerforAllServer on all server
go

enable trigger trg_delete on EmployeeSalary
go

-----------------Drop trigger----------------

drop trigger trg_triggerdemo

drop trigger trg_triggerforAllServer
go
