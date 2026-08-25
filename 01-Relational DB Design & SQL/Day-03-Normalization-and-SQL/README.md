# Day 03: Normalization &  SQL Queries (Joins, DML) - Lab 03

This day covers the concepts of database normalization and practical SQL queries on the Company database, including multi-table joins, self-joins, aggregations, pattern matching, and DML operations.

---

## Topics Covered

* **Database Normalization:** Understanding Functional Dependencies, 1NF, 2NF, 3NF, and BCNF to minimize data redundancy and eliminate anomalies.
* **SQL Joins:** `INNER JOIN`, `LEFT OUTER JOIN`, and `SELF JOIN` for hierarchical reporting.
* **Data Filtering & Sorting:** Range filtering (`BETWEEN`), wildcards (`LIKE`), list checks (`IN`), and result ordering (`ORDER BY`).
* **Data Manipulation Language (DML):** Inserting records with specific constraints and updating existing records based on logical expressions.

---

## Lab Queries & Tasks

1. Display the Department id, name, and the id and name of its manager[cite: 3].
2. Display the name of the departments and the name of the projects under their control[cite: 3].
3. Display the full data about all dependents along with the name of the employee they depend on[cite: 3].
4. Display the id, name, and location of projects in Cairo or Alex city[cite: 3].
5. Display the full data of projects with a name starting with the letter 'a'[cite: 3].
6. Display all employees in department 30 whose salary is between 1000 and 2000 LE monthly[cite: 3].
7. Retrieve the names of all employees in department 10 who work $\ge 10$ hours per week on the "AL Rabwah" project[cite: 3].
8. Find the names of employees who are directly supervised by Kamel Mohamed[cite: 3].
9. Retrieve the names of all employees and the names of the projects they work on, sorted by project name[cite: 3].
10. For each project in Cairo City, find the project number, controlling department name, department manager's last name, address, and birthdate[cite: 3].
11. Display all data of the managers[cite: 3].
12. Display all employees' data and their dependents' data (including employees without dependents)[cite: 3].
13. Insert personal data into the Employee table as a new employee in department 30 ($SSN = 102672$, $SuperSSN = 112233$, $Salary = 3000$)[cite: 3].
14. Insert a friend's personal data as a new employee in department 30 ($SSN = 102660$) with NULL values for salary and supervisor[cite: 3].
15. Upgrade the salary of the inserted employee ($SSN = 102672$) by 20%[cite: 3].

---

## Deliverables

* **SQL Solutions Script:** `Lab_03_solution.sql`
