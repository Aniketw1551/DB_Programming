--------------------Functions in SQL------------------
use DB_Programming;
go

------------------System defined functions---------------

select getdate() as CurrentDateandTme;
select app_name();
select current_user 
declare @FName varchar(100)
set @FName='Prateek';
select coalesce(@FName,'Rishi') as Name
go
------------------User Defined functions------------------

--------Scalar Function----------

create function Addition (@a1 int,@a2 int)
returns int
as
begin
declare @result int;
set @result=@a1+@a2;
return @result
end
go

select dbo.Addition(44,6) as Total
go

create function EmployeeCity
(
	@EmpName varchar(20),
	@city varchar(20)
)
returns nvarchar(100)
as
begin return(select @EmpName +' '+@city+ ' ')
end
go

select dbo.EmployeeCity('Karan','Nagpur') EmployeeCity 
go


-----------Table valaued functions-------------


-----------Inline Table valued function--------

select * from EmployeeSalary
go

create function EmployeeList(@Salary int)
returns table
as
return select * from EmployeeSalary where total_salary > @Salary;
go

select * from dbo.EmployeeList(30000)

go


create function EmployeeList1(@employee_id int)
returns table
as
return select * from EmployeeSalary where @employee_id = employee_id
go

select * from dbo.EmployeeList1(6)
go

---------------Drop function------------------

drop function if exists EmployeeList1;


---------------Multi-Statement table valued function--------------

select * from EmployeeSalary
select * from payment
go


create function MultiSatementAllEmployees(@employee_id int)
returns @FullEmployeeDetail table (employee_id int ,employee_name varchar(100), net_salary int, LPA int)
as
begin
declare @LPA int;
declare @EmployeeName varchar(100);

select @EmployeeName=employee_name from EmployeeSalary where employee_id=@employee_id
select @LPA= net_salary*12 from Payment where employee_id=@employee_id

insert into  @FullEmployeeDetail (employee_id,employee_name, net_salary, LPA)
select @employee_id,@EmployeeName,net_salary, @LPA from Payment where employee_id=@employee_id

return 
end

go


select * from dbo.MultiSatementAllEmployees(2)