#  Module 01: Relational Database Design & SQL

This module covers the core foundations of relational database systems, moving from abstract business rules to structured conceptual schemas (ERDs), relational mapping, schema normalization, and physical database integrity.

---

##  Learning Objectives by Day

* **Day 01 — Conceptual Modeling & ERD:**
  * Translating business rules into formal Entity-Relationship (ER) diagrams.
  * Mastering cardinalities (1:1, 1:N, M:N), constraints (Total/Partial), and complex attributes (Composite, Multi-valued).

* **Day 02 — Relational Schema Mapping & SQL Server Basics:**
  * Converting conceptual ERDs into relational schemas and physical database diagrams.
  * Implementing referential integrity with Primary Keys, Foreign Keys, and Unique constraints.
  * Writing basic T-SQL data retrieval queries using aliases, string concatenation, and conditional filtering.

* **Day 03 — Schema Normalization & SQL Operations:**
  * Applying functional dependencies and normal forms (1NF, 2NF, 3NF, BCNF) to eliminate redundancy and anomalies.
  * Constructing complex multi-table queries using `INNER JOIN`, `LEFT JOIN`, and `SELF JOIN`.
  * Managing database records using Data Manipulation Language (`INSERT`, `UPDATE`) with logical constraints.

* **Day 04 — SQL Operations & Referential DML:**
  * Combining query results using set operators (`UNION`)[cite: 4].
  * Implementing aggregate functions (`SUM`, `AVG`, `MIN`, `MAX`, `COUNT`) with `GROUP BY` and `HAVING` filtering[cite: 4].
  * Writing nested and correlated subqueries with `EXISTS` and `NOT IN` predicates[cite: 4].
  * Performing multi-table transactional modifications (`INSERT`, `UPDATE`, `DELETE`) with strict foreign key dependency handling[cite: 4].

---

## 📁 Module Directory Structure

```text
01-Relational-Database-Design/
├── Day-01-ERD/
│   ├── README.md                
│   └── lab_01_solution.pdf      
├── Day-02-Relational-Mapping-and-SQL-Basics/
│   ├── README.md
│   ├── Lab_02.pdf
│   └── Lab_02_solution.pdf
├── Day-03-Normalization-and-Advanced-SQL/
│   ├── README.md
│   ├── Lab_03.jpg
│   └── Lab_03_solution.sql
└── Day-04-SQL-and-DML/
    ├── README.md
    └── Lab_04_solution.sql

```


---

##  Labs & Practical Milestones

| Lab | Focus Topic 
| :--- | :--- |
| **Lab 01** | Conceptual ERD Design |
| **Lab 02** | Relational Schema Mapping & SQL Server Basics |
| **Lab 03** | Normalization & SQL |
| **Lab 04** | Advanced Aggregations & Subqueries |
