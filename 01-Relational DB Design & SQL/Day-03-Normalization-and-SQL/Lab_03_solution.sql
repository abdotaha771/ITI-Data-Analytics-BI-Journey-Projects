select * from dbo.Departments
select * from dbo.Dependent
select * from dbo.Employee
select * from dbo.Project
select * from dbo.Works_for


--1
select 
	d.Dnum,
	d.Dname,
	d.MGRSSN,
	concat(e.Fname,' ',e.Lname) AS Manager_Name
from Departments d
join Employee e on d.MGRSSN = e.SSN;

--2
select 
	d.Dname,
	p.pname
from Departments d
join project p on d.dnum = p.dnum;

--3
select 
	d.*,
	concat(e.fname,' ',e.lname) as employee_name
from Dependent d
join Employee e on d.ESSN = e.ssn;

--4
select
	pnumber,
	pname,
	Plocation
from Project
where city in ('Cairo','Alex');

--5
select *
from PROJECT
where pname like 'a%';

--6
select
	*
from Employee 
where dno=30
and Salary between 1000 and 2000;

--7
select 
	concat(e.fname,' ',e.lname) as employee_name
from employee e
join Works_for w on e.ssn=w.ESSn
join project p on w.Pno=p.Pnumber
where e.Dno=10
	and p.Pname = 'AL Rabwah'
	and w.Hours >= 10;

--8
select
	e.Fname,
	e.Lname
from Employee e
JOIN Employee s ON e.superssn = s.SSN
WHERE s.Fname = 'Kamel' AND s.Lname = 'Mohamed';

--9
select 
	concat(e.fname,' ',e.lname) as employee_name,
	p.Pname
from employee e
join Works_for w on e.ssn=w.ESSn
join project p on w.Pno=p.Pnumber
order by p.pname;

--10
SELECT p.PNUMBER, d.Dname, m.Lname AS Manager_Lname, m.address, m.Bdate
FROM PROJECT p
JOIN Departments d ON p.DNUM = d.Dnum
JOIN Employee m ON d.MGRSSN = m.SSN
WHERE p.PLOCATION = 'Cairo';

--11
SELECT DISTINCT e.*
FROM Employee e
JOIN Departments d ON e.SSN = d.MGRSSN;

--12
SELECT e.*, d.DEPENDENT_NAME, d.SEX, d.BDATE AS Dep_Bdate
FROM Employee e
LEFT JOIN DEPENDENT d ON e.SSN = d.ESSN;

--13
INSERT INTO Employee (Fname, Lname, SSN, Bdate, address, sex, salary, superssn, DNO)
VALUES ('Abdelrahman', 'Taha', 102672, '2004-06-15', 'Mansoura', 'M', 3000, 112233, 30);

--14
INSERT INTO Employee (Fname, Lname, SSN, Bdate, address, sex, salary, superssn, DNO)
VALUES ('Ziad', 'Ahmed', 102660, '2004-01-01', 'Mansoura', 'M', NULL, NULL, 30);

--15
UPDATE Employee
SET salary = salary * 1.20
WHERE SSN = 102672;