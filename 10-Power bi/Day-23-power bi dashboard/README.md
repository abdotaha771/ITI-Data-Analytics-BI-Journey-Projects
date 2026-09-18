# Day 23: Power BI Overview Dashboard

Day 23 builds an interactive overview dashboard on top of the two-fact sales model created in Day 22. The goal is to turn the report-ready model into a management view that combines headline KPIs, trend analysis, and shared filters.

---

## Dashboard Objective

Create one overview page that answers the following questions:

- How much revenue was generated?
- How many orders and units were sold?
- How does sales performance change over time?
- Which territories, top 10 products, and groups contribute most to performance?

The dashboard should remain useful at both the overall level and after applying any combination of slicers.

## Required KPI Cards

Add cards for:

- Total Sales
- Total Orders
- Total Quantity
- Total Customers

Use measures rather than implicit visual aggregations so the KPI definitions remain consistent across the report.

## Required Visuals

Use the supplied [background dashboard.png](background%20dashboard.png) as the page layout guide and add visuals for:

- Sales trend by year and month
- Sales by territory or region
- Top 10 products
- Sales by group or salesperson

All visuals must use the shared dimensions from the Day 22 model and respond to the report filters.


## Files

- [Lab_solution.pbix](Lab_solution.pbix): Power BI report containing the overview dashboard.
- [background dashboard.png](background%20dashboard.png): Dashboard canvas background used to arrange the report visuals.

## Outcome

By the end of Day 23, the two-fact model from Day 22 is used to create an interactive Power BI overview dashboard with KPI cards, analytical visuals.
