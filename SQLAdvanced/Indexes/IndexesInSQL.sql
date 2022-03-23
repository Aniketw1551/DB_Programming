---------------------------Indexes in SQL-----------------------
use DB_Programming
go

select * from Employeeinfo

select employee_id,name,salary from Employeeinfo where salary >26000 

------------------------non-clustered index-------------------

--if table already has clustered index then it will create non-clustered index

-----------------Index on multiple table----------------

create index ix_employee_salary
on Employeeinfo(salary asc,name);

---------Unique Index---------------

create Unique index ix_Employee_phoneno
on Employeeinfo(phone_no);

select employee_id ,phone_no from Employeeinfo where phone_no=9221022190;

-----------------Index on single table------------------

select * from ItemSales

create clustered index ix_ItemsSales_brand
on ItemSales(brand);

select * from ItemSales where brand ='Samsung'


-------Rename index--------------

exec sp_rename
	N'Employeeinfo.ix_employee_salary',
	N'ix_Employee_Salary',
	N'Index';


---------Enable index-----------

alter index ix_Employee_phoneno on Employeeinfo rebuild;

alter index all on Employeeinfo rebuild;

-------Disable index------------

alter index ix_Employee_phoneno on Employeeinfo disable;

alter index all on Employeeinfo disable;

----------Drop index------------

drop index ix_employee_salary on Employeeinfo

drop index ix_ItemsSales_brand1 on ItemSales

