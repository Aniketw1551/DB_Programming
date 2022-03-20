-----Joins------

use DB_Programming;

----Company table----

create table Company(
    company_id int not null PRIMARY KEY,
    company_name varchar(50) not null
);

select * from Company;

insert into Company (company_id,company_name) values(101,'TCS'),(102,'Infosys'),(103,'Flipkart');

----Employee table----

create table Employee(
employee_id int IDENTITY (1,1) PRIMARY KEY,
employee_name varchar(50),
gender char(2) not null,
phone_no bigint,
city varchar(50),
zip int );

select * from Employee;

insert into Employee(employee_name,gender,phone_no,city,zip)
    values('Jay','M',739294014,'Mumbai',593012),('Sanket','M',5927182201,'Indore',596964),
          ('Vishakha','F',6578926910,'Lucknow',129345),('Pooja','F',9134527287,'Surat',879531),
		  ('Aarti','F',7432212439,'Pune',402241);

insert into Employee(employee_name,gender,phone_no,city,zip,manager_id)
    values('Karan','M',8729406450,'Noida',872013,2);

	select * from Employee;

	alter table Employee add manager_id int;

	update Employee set manager_id=3 where employee_id in(7)

-----Department table-----

create table Department(
    department_id int not null PRIMARY KEY,
    department_name varchar(50) not null,
    employee_id int FOREIGN KEY REFERENCES Employee(employee_id)
	);

select * from Department;

insert into Department(department_id,department_name,employee_id) values(1001,'HR',1),(1002,'IT',2),(1003,'Developer',3),(1004,'Marketing',4),(1006,'Sales',5);
insert into Department(department_id,department_name,employee_id) values(1007,'IT',6),(1008,'Developer',7);

----Payment table-----

create table Payment(
    payment_id varchar(50) not null PRIMARY KEY,
    basic_salary int,
    bonus int,
    net_salary int,
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id)
	);

insert into Payment(payment_id,basic_salary,bonus,net_salary,employee_id)
    values('#1',20000,2000,22000,1),('#2',17500,1500,19000,2),
          ('#3',23750,1000,24750,3),('#4',26000,0,26000,4),('#5',25000,3000,28000,5);

insert into Payment(payment_id,basic_salary,bonus,net_salary,employee_id) values('#7',30000,1000,31000,7);

update Payment set bonus=1200 where employee_id=4
select * from Payment;


-----Joining Tables using types of joins------

select * from Department

 select * from Employee

 select * from Payment

----Inner join-----

select d.department_name,e.employee_name from Department d inner join Employee e on d.employee_id=e.employee_id;

----Left join-----
select e.employee_name,p.bonus from Employee e left join Payment p on e.employee_id=p.employee_id order by e.employee_id;

----Right join----
select d.net_salary,e.employee_name,e.gender from Payment d right join Employee e on d.employee_id=e.employee_id order by e.employee_name asc;

----Full outer join----
select d.basic_salary ,e.employee_name from Payment d full outer join Employee e on d.employee_id=e.employee_id order by employee_name;

----Self join----
select a.employee_id as 'Emp Id',a.employee_name as 'Employee Name',b.employee_id as 'Manager Id',b.employee_name as 'Manager Name' from Employee a,Employee b where a.manager_id=b.employee_id;

---Cross Join----
select * from Department

select * from Employee

select d.department_name,d.department_id, e.employee_name from Department d cross join Employee e;

