# Day 5: Advanced SQL Query

This lab applies SQL Server querying, aggregation, null handling, views, filtering, updating, and date-based analysis using the **ITI** and **AdventureWorks** databases.

## Part 1: Use the ITI Database

The exercises cover:

1. Counting students who have a recorded age.
2. Listing instructor names without repetition.
3. Displaying student ID, full name, and department name using `ISNULL`.
4. Listing all instructors with their department names, including instructors without a department.
5. Displaying students and the courses they are taking when a grade exists.
6. Counting courses for each topic.
7. Finding the maximum and minimum instructor salaries.
8. Finding instructors whose salaries are below the average salary.
9. Finding the department that contains the instructor with the minimum salary.
10. Selecting the two highest instructor salaries.
11. Displaying instructor names and salaries, using `COALESCE` when a salary is missing.
12. Calculating the average instructor salary.
13. Displaying each student's first name and supervisor.
14. Creating a view for students whose course grade is greater than 50.
15. Creating a view for managers and the topics they teach.
16. Creating a view for instructors in the `SD` or `Java` departments.

## Part 2: Use the AdventureWorks Database

The exercises cover:

1. Retrieving sales orders from `7/28/2002` and `7/29/2014`.
2. Listing products with a standard cost below `$110.00`.
3. Displaying products whose weight is unknown.
4. Finding products with a Silver, Black, or Red color.
5. Finding products whose names start with `B`.
6. Updating a product description and finding descriptions containing an underscore.
7. Calculating daily sales totals for a specified date range.
8. Displaying unique employee hire dates.
9. Calculating the average of unique product list prices.
10. Listing products priced between `$100` and `$120`, formatted as `[Product name is only: [List price]]` and sorted by price.

## Lab Solutions

- [Lab 5 Part 1 solution](Lab_05_part1_solution.sql) - ITI database exercises
- [Lab 5 Part 2 solution](Lab_05_part2_solution.sql) - AdventureWorks database exercises
