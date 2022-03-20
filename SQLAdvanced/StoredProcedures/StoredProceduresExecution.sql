use DB_Programming

EXEC SelectAllEmployees;

exec MaleEmployees;

exec FemaleEmployees;

exec ParameterProcedure 5,'Surat'

exec ParameterProcedure1 @department='Sales', @name='Karan'

exec ParameterProcedure2 @department='IT', @name='Disha'

exec ParameterProcedure3 

--VariableProc

exec variable 4
