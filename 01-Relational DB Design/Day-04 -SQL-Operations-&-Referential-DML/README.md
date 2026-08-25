# Day 04: SQL Queries & Data Manipulation - Lab 04

This day contains advanced T-SQL queries on the Company database, covering set operations, aggregate functions with grouping and filtering, nested subqueries, correlated subqueries (`EXISTS`), and transactional data modifications (`INSERT`, `UPDATE`, `DELETE`) with foreign key dependency handling.


---

## Topics Covered

* **Set Operations:** Combining distinct query results using `UNION`[cite: 4].
* **Aggregations & Grouping:** Calculating summary metrics using `SUM`, `COUNT`, `AVG`, `MIN`, `MAX`, `GROUP BY`, and applying post-aggregation filters with `HAVING`[cite: 4].
* **Nested & Correlated Subqueries:** Subqueries in `WHERE` / `FROM` clauses, subquery-based ranking, and record existence validation using `EXISTS` and `NOT IN`[cite: 4].
* **Referential Integrity in DML:** Executing cascaded updates and deletions across dependent tables (`WORKS_FOR`, `DEPENDENT`, `EMPLOYEE`, `DEPARTMENTS`) to prevent foreign key violation errors[cite: 4].

---

## Lab Queries & Tasks

1. Display (Using `UNION`):
   * The name and gender of dependents whose gender is Female and depend on a Female Employee[cite: 4].
   * The male dependents who depend on a Male Employee[cite: 4].
2. For each project, list the project name and total hours per week (for all employees) spent on that project[cite: 4].
3. Display the data of the department which has the smallest employee ID over all employees' ID[cite: 4].
4. For each department, retrieve the department name and the maximum, minimum, and average salary of its employees[cite: 4].
5. List the full name of all managers who have no dependents[cite: 4].
6. For each department—if its average salary is less than the average salary of all employees—display its number, name, and number of its employees[cite: 4].
7. Retrieve a list of employees' names and the project names they are working on, ordered by department number and within each department ordered alphabetically by last name, first name[cite: 4].
8. Get the top 2 maximum salaries using a subquery[cite: 4].
9. Get the full name of employees whose name is similar to any dependent name[cite: 4].
10. Display the employee number and name if at least one of them has dependents (using `EXISTS` keyword)[cite: 4].
11. In the department table, insert a new department called `'DEPT IT'` with id `100`, employee with $SSN = 112233$ as a manager for this department, and start date `'2006-11-01'`[cite: 4].
12. Handle the following updates:
    * Update Mrs. Noha Mohamed ($SSN = 968574$) to be the manager of the new department ($ID = 100$)[cite: 4].
    * Update your record ($SSN = 102672$) to be the department 20 manager[cite: 4].
    * Update employee number $102660$ to be supervised by you ($SSN = 102672$)[cite: 4].
13. Delete the data of Mr. Kamel Mohamed ($SSN = 223344$) while handling all foreign key dependencies across `Dependent`, `Departments`, `Employee` (supervisors), and `Works_for`[cite: 4].
14. Update all salaries of employees who work on Project `'Al Rabwah'` by 30%[cite: 4].

---

## Deliverables

* **SQL Solutions Script:** `Lab_04_solution.sql`[cite: 4]
