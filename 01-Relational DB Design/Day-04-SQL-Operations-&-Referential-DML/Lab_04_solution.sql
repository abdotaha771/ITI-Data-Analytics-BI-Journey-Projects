Select * from Departments
Select * from Employee
Select * from Dependent
Select * from Project
Select * from Works_for


--1
SELECT
	d.dependent_name,
	d.sex
FROM Dependent d
JOIN Employee e ON d.essn=e.ssn
WHERE d.Sex = 'F' AND e.Sex = 'F'

union
select
	d.dependent_name,
	d.sex
from Dependent d
join Employee e on d.essn=e.ssn
WHERE d.Sex = 'M' AND e.Sex = 'M'

--2
SELECT 
	p.Pname,
	SUM(w.Hours) AS Total_Hours
FROM Project p
JOIN Works_for w ON p.Pnumber = w.Pno
GROUP BY p.Pname

--3
SELECT *
FROM Departments
WHERE DNUM =(SELECT DNO FROM Employee WHERE SSN=(SELECT MIN(SSN) FROM Employee))
	
--4
SELECT d.Dname, 
       MAX(e.Salary) AS Max_Salary, 
       MIN(e.Salary) AS Min_Salary, 
       AVG(e.Salary) AS Avg_Salary
FROM Departments d
JOIN Employee e ON d.Dnum = e.Dno
GROUP BY d.Dname

--5
SELECT 
	CONCAT(e.Fname,' ',e.Lname) AS Manager_Name
FROM Employee e
JOIN Departments d ON e.SSN = d.MGRSSN
WHERE e.SSN NOT IN (SELECT ESSN FROM Dependent WHERE ESSN IS NOT NULL)

--6
SELECT 
	d.Dnum,
	d.Dname,
	COUNT(e.SSN) AS Number_Of_Employees
FROM Departments d
JOIN Employee e ON d.Dnum = e.Dno
GROUP BY d.Dnum, d.Dname
HAVING AVG(e.Salary) < (SELECT AVG(Salary) FROM Employee)

--7
SELECT 
	e.Dno,
	e.Lname,
	e.Fname,
	p.Pname
FROM Employee e
JOIN Works_for w ON e.SSN = w.ESSn
JOIN Project p ON w.Pno = p.Pnumber
ORDER BY e.Dno, e.Lname ASC, e.Fname ASC

--8
SELECT DISTINCT Salary
FROM Employee e1
WHERE Salary IS NOT NULL 
  AND 2 > (
    SELECT COUNT(DISTINCT Salary)
    FROM Employee e2
    WHERE e2.Salary > e1.Salary 
      AND e2.Salary IS NOT NULL
)
ORDER BY Salary DESC

--9
SELECT DISTINCT
	e.Fname + ' ' + e.Lname AS Employee_Name
FROM Employee e
JOIN Dependent d 
  ON d.Dependent_name LIKE '%' + e.Fname + '%' 
  OR d.Dependent_name LIKE '%' + e.Lname + '%'


--10
SELECT e.SSN, e.Fname + ' ' + e.Lname AS Employee_Name
FROM Employee e
WHERE EXISTS (
    SELECT 1
    FROM Dependent d
    WHERE d.ESSN = e.SSN
)

--11
INSERT INTO Departments (Dname, Dnum, MGRSSN, [MGRStart Date])
VALUES ('DEPT IT', 100, 112233, '2006-11-01');

--12

UPDATE Departments
SET MGRSSN = 968574
WHERE Dnum = 100;


UPDATE Departments
SET MGRSSN = 102672
WHERE Dnum = 20;

UPDATE Employee
SET Superssn = 102672
WHERE SSN = 102660;

--13
DELETE FROM Dependent 
WHERE ESSN = 223344;

UPDATE Departments 
SET MGRSSN = 102672 
WHERE MGRSSN = 223344;

UPDATE Employee 
SET Superssn = 102672 
WHERE Superssn = 223344;

DELETE FROM Works_for 
WHERE ESSn = 223344;

DELETE FROM Employee 
WHERE SSN = 223344;



--14
UPDATE Employee
SET Salary = Salary * 1.30
WHERE SSN IN (
    SELECT w.ESSn
    FROM Works_for w
    JOIN Project p ON w.Pno = p.Pnumber
    WHERE p.Pname = 'Al Rabwah'
);
