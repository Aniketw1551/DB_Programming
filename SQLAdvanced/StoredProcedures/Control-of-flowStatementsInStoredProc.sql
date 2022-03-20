------Control-of-flow statements-----

----- Begin-End-------

select * from Employeeinfo

begin 
select employee_id,name from Employeeinfo where salary >35000;
if @@ROWCOUNT = 0
print 'No employee with salary greater than 35000 found';
end

----- Begin-end and if else ----------

begin 
declare @name varchar(100)
select top 1 @name=name 
from Employeeinfo 
order by salary desc;
 IF @@ROWCOUNT <> 0
  begin
   print 'The highest paid employee is' + ' ' + @name
  end
 else
  begin
   print 'No employee found';
  end;
end

------While---------

declare @counter int = 1;

WHILE @counter <= 9
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END

------Break-------

declare @counter1 int = 0;

WHILE @counter1 <= 9
BEGIN
    SET @counter1 = @counter1 + 1;
	if @counter1=6
	break;
	print @counter1;
END

------Continue-------

declare @counter2 int = 0;

WHILE @counter2 < 7
BEGIN
    SET @counter2 = @counter2 + 1;
	if @counter2=5
	continue;
	print @counter2;
END