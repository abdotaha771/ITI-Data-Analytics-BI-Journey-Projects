USE ITI;
GO

SELECT * FROM DBO.Course
SELECT * FROM DBO.Department
SELECT * FROM DBO.Ins_Course
SELECT * FROM DBO.Instructor
SELECT * FROM DBO.Stud_Course
SELECT * FROM DBO.Student
SELECT * FROM DBO.Topic



-- 1
SELECT COUNT(St_Age) AS Number_Of_Students
FROM Student;

-- 2
SELECT DISTINCT Ins_Name
FROM Instructor;

-- 3
SELECT 
    s.St_Id AS [Student ID],
    ISNULL(s.St_Fname + ' ' + s.St_Lname, 'No Name') AS [Student Full Name],
    ISNULL(d.Dept_Name, 'No Department') AS [Department name]
FROM Student s
LEFT JOIN Department d ON s.Dept_Id = d.Dept_Id;

-- 4
SELECT i.Ins_Name, d.Dept_Name
FROM Instructor i
LEFT JOIN Department d ON i.Dept_Id = d.Dept_Id;

-- 5
SELECT s.St_Fname + ' ' + s.St_Lname AS Full_Name, c.Crs_Name
FROM Student s
JOIN Stud_Course sc ON s.St_Id = sc.St_Id
JOIN Course c ON sc.Crs_Id = c.Crs_Id
WHERE sc.Grade IS NOT NULL;

-- 6
SELECT t.Top_Name, COUNT(c.Crs_Id) AS Number_Of_Courses
FROM Topic t
JOIN Course c ON t.Top_Id = c.Top_Id
GROUP BY t.Top_Name;

-- 7
SELECT MAX(Salary) AS Max_Salary, MIN(Salary) AS Min_Salary
FROM Instructor;

-- 8
SELECT *
FROM Instructor
WHERE Salary < (SELECT AVG(Salary) FROM Instructor);

-- 9
SELECT d.Dept_Name
FROM Department d
JOIN Instructor i ON d.Dept_Id = i.Dept_Id
WHERE i.Salary = (SELECT MIN(Salary) FROM Instructor);

-- 10
SELECT DISTINCT TOP 2 Salary
FROM Instructor
WHERE Salary IS NOT NULL
ORDER BY Salary DESC;

-- 11
SELECT Ins_Name, COALESCE(CAST(Salary AS VARCHAR(20)), 'Bonus') AS Salary_Or_Bonus
FROM Instructor;

-- 12
SELECT AVG(Salary) AS Avg_Salary
FROM Instructor;

-- 13
SELECT s.St_Fname, sup.*
FROM Student s
JOIN Student sup ON s.St_super = sup.St_Id;
GO

-- 14
CREATE OR ALTER VIEW View_Student_Passed_Courses
AS
SELECT s.St_Fname + ' ' + s.St_Lname AS Full_Name, c.Crs_Name
FROM Student s
JOIN Stud_Course sc ON s.St_Id = sc.St_Id
JOIN Course c ON sc.Crs_Id = c.Crs_Id
WHERE sc.Grade > 50;
GO

-- 15
CREATE OR ALTER VIEW View_Manager_Topics
AS
SELECT DISTINCT ins.Ins_Name AS Manager_Name, t.Top_Name
FROM Department d
JOIN Instructor ins ON d.Dept_Manager = ins.Ins_Id
JOIN Ins_Course ic ON ins.Ins_Id = ic.Ins_Id
JOIN Course c ON ic.Crs_Id = c.Crs_Id
JOIN Topic t ON c.Top_Id = t.Top_Id;
GO

-- 16
CREATE OR ALTER VIEW View_SD_Java_Instructors
AS
SELECT i.Ins_Name, d.Dept_Name
FROM Instructor i
JOIN Department d ON i.Dept_Id = d.Dept_Id
WHERE d.Dept_Name IN ('SD', 'Java');
GO