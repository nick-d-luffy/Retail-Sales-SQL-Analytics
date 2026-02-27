# Retail-Sales-SQL-Analytics
Retail analytics project using SQL (MySQL Workbench)

Project Summary

This project analyzes retail transactional data to uncover insights related to revenue, product performance, and customer behavior using SQL.

The objective was to clean and validate raw data, ensure accurate revenue reporting, and generate insights that support business decision-making.

This case study demonstrates strong analytical thinking, structured problem-solving, and the ability to translate data into actionable business insights.

Business Problem

The retail dataset contained customer information, product inventory data, and sales transactions. However, several data quality issues were present, including:

Duplicate transactions inflating revenue

Price inconsistencies across tables

Missing customer information

Incorrect date formats preventing trend analysis

Without resolving these issues, any revenue or customer analysis would be unreliable.

Analytical Approach

I followed a structured three-step approach:

1. Data Cleaning and Validation

Removed duplicate transaction records

Corrected price mismatches between sales and inventory tables

Standardized missing customer fields

Converted date fields into proper DATE format

Impact: Ensured accurate revenue reporting and reliable analysis.

2. Sales and Revenue Analysis

Calculated total revenue across all transactions

Measured product-wise revenue contribution

Identified top 10 revenue-generating products

Identified low-performing products

Analyzed daily transaction trends

Calculated Month-on-Month revenue growth using window functions

Business Insight:
A small number of products contributed a significant share of total revenue, highlighting key revenue drivers. Low-performing products were flagged for optimization strategies.

3. Customer Behavior and Segmentation

Measured transaction frequency per customer

Identified high-value customers based on total spend and engagement

Identified low-engagement customers for potential reactivation

Analyzed repeat purchase behavior

Calculated customer lifetime duration

Segmented customers into Low, Medium, and High purchase groups

Business Insight:
High-value customers contributed a large portion of revenue, indicating the importance of retention strategies. Customer segmentation enables targeted marketing and improved resource allocation.

Key SQL Concepts Used

GROUP BY and HAVING

Aggregate functions (SUM, COUNT, AVG)

INNER JOIN

Window functions (LAG for MoM growth)

DATEDIFF

Common Table Expressions (CTE)

Subqueries

Data cleaning using UPDATE and ALTER

Date conversion using STR_TO_DATE

Revenue calculation using price * quantity

Skills Demonstrated

Data cleaning and validation

Revenue-focused analysis

Trend analysis and growth measurement

Customer segmentation

Structured problem-solving

Business-oriented thinking

Translating SQL outputs into actionable insights

Business Impact

Improved accuracy of revenue reporting

Identified high-performing products and revenue drivers

Flagged underperforming inventory

Highlighted customer retention opportunities

Enabled data-driven decision-making

Conclusion

This project reflects my ability to approach real-world data problems systematically, ensure data integrity, and deliver meaningful insights using SQL. It showcases both technical SQL proficiency and business-oriented analytical thinking, aligned with Data Analyst role expectations.
