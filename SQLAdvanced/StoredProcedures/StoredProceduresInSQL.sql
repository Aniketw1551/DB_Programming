----------Stored Procedures----------
CREATE PROCEDURE SelectAllEmployees
AS
BEGIN
SELECT * FROM Employee
END
GO

create proc MaleEmployees
as
begin
select * from Employee where gender='M'
end
go

------Alter stored procedure-----

alter proc FemaleEmployees
as
begin
select * from Employee where gender='F' and city in('Surat','Pune')
end
go

------ Parameter stored procedures-----

alter proc ParameterProcedure
@emp_id int,
@city varchar(100)
as
begin
select * from Employee where employee_id=@emp_id or city=@city
end
go

-------Delete stored procedure---

--drop proc ParameterProcedure2

alter proc ParameterProcedure1
@name varchar(100),
@department varchar(100)
as
begin
select phone_no,salary from Employeeinfo where name=@name 
select * from Employeeinfo where department=@department 
order by department 
end
go

-----Optional parameter or default values -------

alter proc ParameterProcedure2
@name varchar(100) = 'Rahul',
@department varchar(100) = 'IT'
as
begin
select * from Employeeinfo where name=@name 
select * from Employeeinfo where department=@department  
order by department 
end
go

create proc ParameterProcedure3
@name varchar(100) = 'Rahul',
@department varchar(100) = NULL
as
begin
select * from Employeeinfo where name=@name 
select * from Employeeinfo where department=@department  
order by department 
end
go

-------Output parameter--------

alter proc VariableProc 
@name varchar(100),
@city varchar(100),
@Result varchar(100) output
as
begin 
set @Result=@name + ' ' + @city
end

declare @Name varchar(100)
exec  VariableProc 'Karan','Pune',@Name output;
select @Name as 'Employee with city';
go

--------Variable------------

alter proc variable(
@employee_id int
)
as 
begin
declare @employee_name varchar(100),@city varchar(100)
select @employee_name = employee_name, @city = city
from Employee 
where employee_id =@employee_id
order by gender;
print @employee_name
print @city
end
go