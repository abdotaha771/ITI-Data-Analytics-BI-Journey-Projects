-- ====================================================================================================
-- HOW TO RUN / TEST DATABASE OBJECTS:
-- 1. TO RUN A PROCEDURE: JUST WRITE "EXEC <ProcedureName>" (AND PASS PARAMETERS IF REQUIRED: param1, param2...).
-- 2. TO FIRE A TRIGGER: YOU DO NOT CALL IT DIRECTLY; IT RUNS AUTOMATICALLY WHEN YOU EXECUTE (INSERT / UPDATE / DELETE) ON ITS TABLE.
-- ====================================================================================================




-- =======================================================
-- 1. Stored Procedure: Number of students per department [ITI DB]
-- =======================================================
USE ITI;
GO

CREATE OR ALTER PROCEDURE sp_GetStudentsPerDept
AS
BEGIN
    SELECT d.Dept_Name, COUNT(s.St_Id) AS Student_Count
    FROM Department d
    LEFT JOIN Student s ON d.Dept_Id = s.Dept_Id
    GROUP BY d.Dept_Name;
END;
GO


-- =======================================================
-- 2. Stored Procedure: Check employees count in project p1 [Company DB]
-- =======================================================
USE Company_SD;
GO

CREATE OR ALTER PROCEDURE sp_CheckEmployeesInProject1
AS
BEGIN
    DECLARE @EmpCount INT;

    SELECT @EmpCount = COUNT(ESSn)
    FROM Works_for
    WHERE Pno = 100;

    IF @EmpCount >= 3
    BEGIN
        PRINT 'The number of employees in the project p1 is 3 or more';
    END
    ELSE
    BEGIN
        PRINT 'The following employees work for the project p1:';
        SELECT e.Fname, e.Lname
        FROM Employee e
        JOIN Works_for w ON e.SSN = w.ESSn
        WHERE w.Pno = 100;
    END
END;
GO

-- =======================================================
-- 3. Stored Procedure: Replace an old employee with a new one in a project [Company DB]
-- =======================================================
CREATE OR ALTER PROCEDURE sp_ReplaceEmployeeInProject
    @OldEmpSSN INT,
    @NewEmpSSN INT,
    @ProjectNo INT
AS
BEGIN
    UPDATE Works_for
    SET ESSn = @NewEmpSSN
    WHERE ESSn = @OldEmpSSN AND Pno = @ProjectNo;
END;
GO

----------------------------------------------------------------------------------------------------------------------

-- =======================================================
-- 4. Audit Table & Trigger on Project Budget Update [Company DB]
-- =======================================================

ALTER TABLE Project ADD Budget DECIMAL(12, 2);
GO
UPDATE Project SET Budget = 100000;
GO

CREATE TABLE Project_Audit (
    ProjectNo INT,
    UserName VARCHAR(100),
    ModifiedDate DATE,
    Budget_Old DECIMAL(12, 2),
    Budget_New DECIMAL(12, 2)
);
GO

CREATE OR ALTER TRIGGER trg_AuditProjectBudget
ON Project
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Budget)
    BEGIN
        INSERT INTO Project_Audit (ProjectNo, UserName, ModifiedDate, Budget_Old, Budget_New)
        SELECT 
            d.Pnumber,
            SUSER_SNAME(),
            CAST(GETDATE() AS DATE),
            d.Budget,
            i.Budget
        FROM deleted d
        JOIN inserted i ON d.Pnumber = i.Pnumber;
    END
END;
GO

-- 4 After Update Trigger 

UPDATE Project SET Budget = 250000 WHERE Pnumber = 200;
SELECT * FROM Project_Audit;
-----------------------------------------------------------------------------------------------------------------------

-- =======================================================
-- 5. Trigger: Prevent inserting new department [ITI DB]
-- =======================================================
USE ITI;
GO

CREATE OR ALTER TRIGGER trg_PreventInsertDepartment
ON Department
INSTEAD OF INSERT
AS
BEGIN
    PRINT 'You cannot insert a new record in Department table';
END;
GO

-- 5. Test Instead Of Insert Trigger

INSERT INTO Department (Dept_Id, Dept_Name) VALUES (999, 'Cyber Security');
SELECT * FROM Department;

----------------------------------------------------------------------------------------------------------------------
-- =======================================================
-- 6. Trigger: Prevent Employee insertion in March [Company DB]
-- =======================================================
USE Company_SD;
GO

CREATE OR ALTER TRIGGER trg_PreventEmployeeInsertInMarch
ON Employee
INSTEAD OF INSERT
AS
BEGIN
    IF MONTH(GETDATE()) = 3
    BEGIN
        PRINT('Insertion in Employee table is not allowed during March');
    END
    ELSE
    BEGIN
        INSERT INTO Employee (Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
        SELECT Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno
        FROM inserted;
    END
END;
GO
-- 6  TEST Instead Of Insert Trigger with Date condition
INSERT INTO Employee (SSN, Fname,Lname, Dno) VALUES (999888, 'Ahmed','Hassan', 30);

------------------------------------------------------------------------------------------------------------------------------
-- =======================================================
-- 7. Trigger: Student Audit after Insert [ITI DB]
-- =======================================================
USE ITI;
GO

CREATE TABLE Student_Audit (
    [Server User Name] VARCHAR(100),
    [Date] DATETIME,
    [Note] VARCHAR(500)
);
GO

CREATE OR ALTER TRIGGER trg_StudentAfterInsert
ON Student
AFTER INSERT
AS
BEGIN
    INSERT INTO Student_Audit ([Server User Name], [Date], [Note])
    SELECT 
        SUSER_SNAME(),
        GETDATE(),
        '[' + SUSER_SNAME() + '] Insert New Row with Key=[' + CAST(i.St_Id AS VARCHAR(20)) + '] in table [Student]'
    FROM inserted i;
END;
GO
-- 7Test  After Insert Trigger
INSERT INTO Student (St_Id, St_Fname, St_Lname, St_Age, Dept_Id) VALUES (8899, 'Omar', 'Khaled', 22, 10);
SELECT * FROM Student_Audit;

----------------------------------------------------------------------------------------------------------------------

-- =======================================================
-- 8. Trigger: Student Audit instead of Delete [ITI DB]
-- =======================================================
----------------------------------------------------------------------
CREATE OR ALTER TRIGGER trg_StudentInsteadOfDelete
ON Student
INSTEAD OF DELETE
AS
BEGIN
    INSERT INTO Student_Audit ([Server User Name], [Date], [Note])
    SELECT 
        SUSER_SNAME(),
        GETDATE(),
        'try to delete Row with Key=[' + CAST(d.St_Id AS VARCHAR(20)) + ']'
    FROM deleted d;
END;
GO

-- 8 Test Instead Of Delete Trigger
DELETE FROM Student WHERE St_Id = 8899;
SELECT * FROM Student_Audit;

