-------Set operators---------

-----Union operator---------
select * from Employeeinfo

select * from Employee

select name,phone_no from Employeeinfo union select employee_name,phone_no from Employee

select name,gender from Employeeinfo union select employee_name,gender from Employee order by gender;

-----Intersect--------

select name from Employeeinfo intersect select employee_name from Employee order by name;

-----Except---------

select name from Employeeinfo except select employee_name from Employee order by name desc;