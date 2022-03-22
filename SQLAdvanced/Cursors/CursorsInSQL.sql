--------------------Cursors in SQL---------------------
create table EmployeeSalary(
employee_id int IDENTITY(1,1) not null primary key,
employee_name varchar(100) not null,
department varchar(50) not null,
basic_salary int not null,
bonus int not null,
total_salary int not null,
);


insert into EmployeeSalary (employee_name,department,basic_salary,bonus,total_salary) 
values ('sahil','IT',25000,2000,27000), ('Yash','IT',26000,2500,28500), ('Sanika','Developer',30000,3000,33000), ('Aarti','IT',28000,2000,30000),
		 ('Krish','Developer',27000,1000,28000), ('Vinay','Marketing',31000,1000,32000), ('Prachi','Marketing',24000,2000,26000), ('Sanket','Manager',35000,3500,38500) ;

		 alter table EmployeeSalary add total_salary int null;
update EmployeeSalary set total_salary=26000 where employee_id=9
select * from EmployeeSalary

----------Cursor in SQL-----------

declare @employee_id int,
@employee_name varchar(100),
@basic_salary int,
@bonus int,
@totalsalary int
declare
@net_salary int,
@LPA int

declare employee_cursor cursor for select employee_id,employee_name,basic_salary,bonus,total_salary from EmployeeSalary

open employee_cursor;

fetch next from employee_cursor into @employee_id, @employee_name, @basic_salary, @bonus, @totalsalary

while @@FETCH_STATUS=0
begin
	print concat('Employee Name: ', @employee_name);
	print concat('Employee Id: ', @employee_id);
	print concat('Basic Salary: ', @basic_salary);
	print concat('Bonus: ', @bonus);
	print concat('Total Salary: ', @totalsalary);

	set @LPA=@totalsalary*12;

	print concat ('LPA: ', @LPA);
	if @LPA > 380000
	begin
	print 'Salary: Good';
	end
	else if @LPA > 350000 and  @LPA <380000
	begin
	print 'Salary: Average';
	end
	else 
	begin
	print 'Salary: Below Average';
	end
	print '***************************';
	fetch next from employee_cursor into @employee_id, @employee_name, @basic_salary, @bonus, @totalsalary
	end
	close employee_cursor;
	deallocate employee_cursor;
