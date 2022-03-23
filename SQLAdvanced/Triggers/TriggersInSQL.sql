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

create table Employee_new(
id int primary key,
name varchar(100),
gender varchar(2),
department_id int
);


create table Department_new(
department_id int primary key,
department_name varchar (100)
);

insert into Employee_new values(1,'Sanket','M',3)
insert into Employee_new values(2,'Sahil','M',2)
insert into Employee_new values(3,'Sana','F',1)
insert into Employee_new values(4,'Reema','F',4)
insert into Employee_new values(5,'Aarti','F',1)

insert into Department_new values(1,'IT')
insert into Department_new values(2,'HR')
insert into Department_new values(3,'Manager')
insert into Department_new values(4,'Admin')


select * from Employee_new
select * from Department_new
go


create view vsEmployee_Detail
as
select 
a.id,a.name,a.gender,b.department_name
from Employee_new a inner join Department_new b on a.department_id=b.department_id

select * from vsEmployee_Detail

go

---------------Create Instead of trigger-------------------

create trigger trg_InsteadInsert_new
on vsEmployee_Detail
instead of insert 
as
begin
declare @department_id  int 
select @department_id = department_id  from Department_new join inserted on inserted.department_name = Department_new.department_name

if(@department_id is null)
begin
raiserror('Invalid department name. Statement terminated', 16, 1)
return
end

insert into Employee_new(id,name,gender,department_id)
select id,name,gender,@department_id
from inserted
end


select * from Employee_new
select * from Department_new
select * from vsEmployee_Detail


insert into vsEmployee_Detail(id,name,gender,department_name)values(6,'Akash','M','IT')
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
