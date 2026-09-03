# Day 10: ETL Using SSIS

This day provides a practical introduction to building ETL workflows with SQL Server Integration Services (SSIS). The lab covers moving data through an SSIS package, applying transformations, combining course-related data, and writing results to text files.

---

## Lab Material

- [SSIS lab.docx](SSIS%20lab.docx): Lab instructions and required SSIS activities.

## Lab Outputs

The `LAB OUTPUT` directory contains the generated results and database backups:

- `ITI.bak` and `Test_Backup.bak`: SQL Server database backup files.
- `students.txt`: Student data exported to a flat file.
- `Merged_Course_Merge.txt`: Output produced by a merge workflow.
- `Merged_Course_Union.txt`: Output produced by a union workflow.
- `task_4_equal_to_30.txt`: Records matching the value 30.
- `task4_greater_than_30.txt`: Records greater than 30.
- `task4_less_than_30.txt`: Records less than 30.

---

## Learning Focus

- Creating and organizing an SSIS package.
- Connecting data sources and destinations.
- Using data-flow transformations.
- Combining and separating records according to requirements.
- Exporting transformed data to flat files.
- Checking output files and backups after package execution.

---

## Outcome

By the end of the day, learners should be able to create a basic SSIS ETL workflow, apply common transformations, and validate its outputs against the lab requirements.
