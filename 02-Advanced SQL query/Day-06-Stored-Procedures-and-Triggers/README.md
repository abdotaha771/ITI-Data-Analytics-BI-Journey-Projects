# Day 6: Stored Procedures and Triggers

This lab applies stored procedures, triggers, auditing, and data modification controls using the **ITI** and **Company** databases.

## Lab Exercises

1. Create a stored procedure without parameters to show the number of students per department using the **ITI** database.
2. Create a stored procedure using the **Company** database that checks the number of employees working on project `p1`. If the number is greater than 3, print a message stating that the number of employees working on project `p1` is more than 3. Otherwise, display a message stating that the following employees are working on project `p1`, followed by each employee's first name and last name.
3. Create a stored procedure for the **Company** database that accepts three parameters: old employee number, new employee number, and project number. Use it to update the `works_on` table when an old employee leaves a project and a new employee replaces them.
4. Add a `Budget` column to the `Project` table and insert draft values. Create an `Audit` table with columns for project number, user name, modification date, old budget, and new budget. Create a trigger to audit updates to the budget column in the **Company** database. The trigger should insert the project number, user name, modification date, old budget, and new budget into the audit table only when the budget is updated.
5. Create a trigger in the **ITI** database to prevent inserting a new record into the `Department` table. Print a message telling the user that a new record cannot be inserted into that table.
6. Create a trigger in the **Company** database to prevent insert operations on the `Employee` table during March.
7. Create an `Audit` table for the `Student` table. Create an `AFTER INSERT` trigger that adds a row containing the server user name, date, and a note in this format: `[username] Insert New Row with Key=[Key Value] in table [table name]`.
8. Create an `AFTER DELETE` trigger on the `Student` table that adds a row to the student audit table. The note should state: `[username] try to delete Row with Key=[Key Value]`.

## Lab Solution

- [Lab 06 solution](Lab_06_solution.sql) - Stored procedures, triggers, and auditing exercises
