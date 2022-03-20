-------Handling Expressions------


----------Try catch -------------

CREATE PROC Divide(
    @a decimal,
    @b decimal,
    @result decimal output
) AS
BEGIN
    BEGIN TRY
        SET @result = @a / @b;
    END TRY
    BEGIN CATCH
        SELECT  
             ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine
            ,ERROR_MESSAGE() AS ErrorMessage;  
    END CATCH
END;

DECLARE @c decimal;
EXEC Divide 5, 0, @c output;
PRINT @c; 
go

------Try catch with transaction--------

CREATE TABLE sales_persons
(
    person_id  INT
    PRIMARY KEY IDENTITY, 
    first_name NVARCHAR(100) NOT NULL, 
    last_name  NVARCHAR(100) NOT NULL
);

insert into 
    sales_persons(first_name, last_name)
values
    ('James','Doe'),
    ('Kemar','Doe');

CREATE TABLE sales_deals
(
    deal_id   INT
    PRIMARY KEY IDENTITY, 
    person_id INT NOT NULL, 
    deal_note NVARCHAR(100), 
    FOREIGN KEY(person_id) REFERENCES sales_persons(
    person_id)
);

insert into 
    sales_deals(person_id, deal_note)
values
    (1,'Deal for James Doe');

select * from sales_persons
select * from sales_deals
go


CREATE PROC report_error
AS
    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_LINE () AS ErrorLine  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;  
GO


CREATE PROC delete_person(
    @person_id INT
) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        -- delete the person
        DELETE FROM sales_persons 
        WHERE person_id = @person_id;
        -- if DELETE succeeds, commit the transaction
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        -- report exception
        EXEC report_error;
        
        -- Test if the transaction is uncommittable.  
        IF (XACT_STATE()) = -1  
        BEGIN  
            PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'  
            ROLLBACK TRANSACTION;  
        END;  
        
        -- Test if the transaction is committable.  
        IF (XACT_STATE()) = 1  
        BEGIN  
            PRINT N'The transaction is committable.' +  
                'Committing transaction.'  
            COMMIT TRANSACTION;     
        END;  
    END CATCH
END;
GO

EXEC delete_person 1;
go

-------- Raiseerror with try catch -----

DECLARE
    @ErrorMessage  NVARCHAR(1000), 
    @ErrorSeverity INT, 
    @ErrorState    INT;

BEGIN TRY
    RAISERROR('Error occurred in the TRY block.', 18, 1);
END TRY
BEGIN CATCH
    SELECT 
        @ErrorMessage = ERROR_MESSAGE(), 
        @ErrorSeverity = ERROR_SEVERITY(), 
        @ErrorState = ERROR_STATE();

    -- return the error inside the CATCH block
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;

------ Raiseerror with dynamic message text-----

DECLARE @MessageText NVARCHAR(100);
SET @MessageText = N'Cannot delete the sales order %s';

RAISERROR(
    @MessageText, -- Message text
    16, -- severity
    1, -- state
    N'2500' -- first argument to the message text
);
----------------------------------------------

CREATE TABLE A(
    id int primary key
);
GO

BEGIN TRY
    INSERT INTO A(id) VALUES(1);
    --cause error
    INSERT INTO A(id) VALUES(1);
END TRY
BEGIN CATCH
    PRINT('Raise the caught error again');
    THROW;
END CATCH
-----------------------------------

EXEC sys.sp_addmessage 
    @msgnum = 50010, 
    @severity = 16, 
    @msgtext =
    N'The order number %s cannot be deleted because it does not exist.', 
    @lang = 'us_english';   
GO

DECLARE @MessageText NVARCHAR(2048);
SET @MessageText =  FORMATMESSAGE(50010, N'500');   

THROW 50010, @MessageText, 1;