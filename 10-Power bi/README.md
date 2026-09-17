# Module 10: Power BI

This module introduces Power BI as a complete workflow for preparing data, designing an analytical model, and building report-ready datasets through Power Query transformations and dimensional modeling.

---

## Learning Objectives

- Understand the main stages of a Power BI data workflow.
- Prepare and transform source data with Power Query.
- Distinguish between fact tables and dimension tables.
- Design relationships that support consistent filtering and analysis.
- Apply star-schema concepts to a practical sales model.
- Compare a simple one-fact design with a model containing multiple fact tables.

---

## Core Topics

- Power BI data loading and preparation.
- Power Query transformations.
- Fact-table grain and business-process separation.
- Dimension tables for descriptive analysis.
- Relationships between facts and shared dimensions.
- Sales headers and sales details modeling.
- Building a report-ready semantic model.

---

## Module Directory Structure

```text
10-Power bi/
└── Day-22-power bi/
    ├── README.md
    ├── 2_facts_data_model.png
    └── Lab_solution.pbix
```

The instructor demonstrated a solution based on one fact table and explained the related Power Query transformations and data-model design. The submitted solution extends that idea by using two fact tables:

- `fact_sales_headers` stores order-level information.
- `fact_sales_details` stores line-level sales information.

Both fact tables use shared dimensions such as customer, date, product, salesperson, and territory. This makes the grain of each table more explicit while allowing common filters to be used across the sales model.

No separate lab handout was provided because the instructor developed the transformations and model during the session.

---

## Module Outcome

By the end of this module, learners should be able to prepare source data in Power Query, distinguish between fact and dimension tables, and design a Power BI model that separates order-level and line-level sales data for reporting and analysis.
