# 🗄️ Day 02: Relational Mapping & SQL Server Fundamentals - Lab 02

This directory contains the original lab specifications, relational schema mapping exercises, and foundational T-SQL queries for **Lab 02**[cite: 1, 2].

---

## 📑 Lab Sections Overview

1. **Relational Schema Mapping:** Converting the 4 conceptual ERDs from Lab 01 (Musicana Records, Real Estate, General Hospital, and Airline Systems) into fully mapped relational tables with Primary Keys and Foreign Keys[cite: 1, 2].
2. **Company Database Implementation:** Building the physical relational schema and database diagram with sample data insertion[cite: 1, 2].
3. **Basic Data Retrieval (T-SQL):** Executing fundamental `SELECT` queries, computed aliases, string concatenations, and conditional filters[cite: 1, 2].

---

## 📌 Lab Problem Statements & Requirements

### Part 1: Relational Schema Mapping
Transform the ERDs from Lab 01 into normalized relational schemas[cite: 1, 2]:
* **Problem 1 (Musicana Records):** Map `Musician`, `Instrument`, `Album`, `Song`, and junction/relationship tables[cite: 1, 2].
* **Problem 2 (Real Estate Firm):** Map `Sales_Office`, `Employee`, `Property`, `Owner`, and the associative ownership table[cite: 1, 2].
* **Problem 3 (General Hospital):** Map `Ward`, `Patient`, `Nurse`, `Consultant`, `Drug`, `Drug_Brand`, and the ternary drug administration table[cite: 1, 2].
* **Problem 4 (Airlines Company):** Map `Airline`, `Airline_Phone`, `Employee`, `Employee_Qualification`, `Aircraft`, `Route`, `Flight_Schedule`, and `Transaction`[cite: 1, 2].

---

### Part 2: Company Database Schema & Diagram
Create the database with the following relational schema, establish primary/foreign key relationships, create the DB diagram, and insert at least 2 rows per table[cite: 1]:

* **EMPLOYEE** (`FNAME`, `LNAME`, `SSN`, `BDATE`, `ADDRESS`, `SEX`, `SALARY`, `SUPERSSN`, `DNO`)[cite: 1]
* **DEPARTMENT** (`DNAME`, `DNUMBER`, `MGRSSN`, `MGRSTARTDATE`)[cite: 1]
* **DEPT_LOCATIONS** (`DNUMBER`, `DLOCATION`)[cite: 1]
* **PROJECT** (`PNAME`, `PNUMBER`, `PLOCATION`, `DNUM`)[cite: 1]
* **WORKS_ON** (`ESSN`, `PNO`, `HOURS`)[cite: 1]
* **DEPENDENT** (`ESSN`, `DEPENDENT_NAME`, `SEX`, `BDATE`, `RELATIONSHIP`)[cite: 1]

---

### Part 3: SQL Querying Tasks (Company DB)
Restore the **Company DB** and construct the following SQL queries[cite: 1]:

1. Display all the employees Data[cite: 1].
2. Display the employee First name, last name, Salary and Department number[cite: 1].
3. Display all the projects names, locations and the department which is responsible about it[cite: 1].
4. If you know that the company policy is to pay an annual commission for each employee with specific percent equals 10% of his/her annual salary, display each employee full name and his annual commission in an `ANNUAL COMM` column (alias)[cite: 1].
5. Display the employees Id, name who earns more than 1000 LE monthly[cite: 1].
6. Display the employees Id, name who earns more than 10000 LE annually[cite: 1].
7. Display the names and salaries of the female employees[cite: 1].
8. Display each department id, name which managed by a manager with id equals 968574[cite: 1].
9. Display the ids, names and locations of the projects which controlled with department 10[cite: 1].

---

## 📂 Lab Files & Deliverables

* 📄 **[View Original Lab Assignment (PDF)](./Lab_02.pdf)**[cite: 1]
* 📄 **[View Completed Lab Solutions (PDF)](./Lab_02_solution.pdf)**[cite: 2]
