create database retail_analytics;

use retail_analytics;

select * from customer_Profiles;

select * from sales_transaction;

select * from product_inventory;

alter table sales_transaction
rename column `ï»¿TransactionID` to Transactionid;

alter table customer_profiles
rename column `ï»¿CustomerID` to CustomerID;

alter table product_inventory
rename column `ï»¿ProductID` to ProductID;

describe product_inventory;

-- 1.	Remove Duplicate Transactions 

select Transactionid, count(*) from sales_transaction
group by Transactionid
having count(*) >1;

create table sales_transaction_2
as 
select distinct * from sales_transaction;

drop table sales_transaction;

alter table sales_transaction_2 rename sales_transaction;

select * from sales_transaction;

-- 2.	Identify and Fix Incorrect Prices in Sales Transactions 

select * from sales_transaction;
select * from product_inventory;

select * from product_inventory p
inner join sales_transaction s
on p.productid = s.productid
where p.price <> s.price;

select price from sales_transaction 
where productid=51;

update sales_transaction as t1
inner join product_inventory t2
on t1.productid = t2.productid
set t1.price = t2.price;

-- To identify nulls values in the dataset and then replace it by ‘Unknown'
select * from customer_profiles
where gender is null;

select * from customer_profiles
where location ='';

update customer_Profiles
set location = 'unknown'
where location = '';

select location from customer_profiles;

-- Last cleaning is changing to DATE in Sales_transaction file  

update customer_profiles
set joindate = str_to_date(joindate, '%d/%m%y');

alter table customer_Profiles
modify column joindate date;

select * from customer_profiles;

describe customer_profiles;

select * from sales_transaction;

update sales_transaction 
set transactiondate = str_to_date(transactiondate, '%d/%m/%y');

alter table sales_transaction 
modify column transactiondate date;

describe sales_transaction;

-- Get a summary of total sales and quantities sold per product

select * from sales_transaction;

select productid, count(quantitypurchased) as totalunitssold,
round(sum(price*quantitypurchased),2)as total_sales from sales_transaction
group by productid;

-- Customer Purchase Frequency 

select customerid, count(*) as NumberofTransactions from sales_transaction 
group by customerid
order by NumberofTransactions desc;

-- Product Categories Performance 

select * from sales_transaction;
select* from product_Inventory;

select p.category, sum(s.quantitypurchased) as TotalUnitsSold,
round(sum(s.price*s.quantitypurchased),2) as TotalSales from sales_transaction s
inner join product_inventory p
on s.productid = p.productid
group by p.category;


-- High Sales Products 

select * from sales_transaction;

select productid, round(sum(price*quantitypurchased),2) as totalrevenue from sales_transaction
group by productid
order by totalrevenue desc
limit 10;

-- Low Sales Products 

select productid, round(sum(price*quantitypurchased),2) as totalrevenue from sales_transaction
group by productid
order by totalrevenue
limit 10;


-- Sales Trends 

select * from sales_transaction;

select transactiondate as TransDate, count(*) as Transaction_count,
sum(quantitypurchased) as TotalUnitsSold, round(sum(price*quantitypurchased),2) as Total_sales
from sales_transaction
group by transactiondate
order by transdate desc;

-- Growth rate of sales M-o_M 

select * from sales_transaction;

select month, total_sales, lag(total_sales) over(order by month) as previous_month_sales,
round((total_sales- lag(total_sales) over(order by month))/lag(total_sales) over(order by month)*100,2)
as mom_grrowth_percent from
 (select month(transactiondate) as month, 
round(sum(price*quantityPurchased),2) as total_Sales from sales_transaction
group by month(transactiondate)) as t;

-- Customers - High Purchase Frequency and Revenue 

select * from sales_transaction;

select customerid, count(*) as NumberofTransactions, 
sum(quantitypurchased * price) as TotalSpent from sales_transaction 
group by customerid
having count(*) >10 and sum(quantitypurchased * price) >1000
order by TotalSpent desc;

-- Occasional Customers - Low Purchase Frequency 

select customerid, count(*) as NumberofTransactions, 
sum(quantitypurchased * price) as TotalSpent from sales_transaction 
group by customerid
having count(*) <=2
order by TotalSpent desc;

-- Repeat Purchase Patterns 
-- Identifying customers with repeat purchases of the same product.

select * from sales_transaction;

select customerid, productid, count(*) as TimesPurchased from sales_transaction
group by customerid, productid
having count(*) >1
order by TimesPurchased desc;

-- Loyalty Indicators
-- Duration between first and last purchase as an indicator of customer loyalty

select * from sales_transaction;

select customerid, min(transactiondate) as FirrstPurchase,
max(transactiondate) as LastPurchase, 
datediff(max(transactiondate),min(transactiondate)) as DaysBetweenPurchase from sales_transaction
group by customerid
having DaysBetweenPurchase >0
order by DaysBetweenPurchase desc;

-- Customer Segmentation based on quantity purchased  

select * from customer_profiles;

select * from sales_transaction;

-- CTE

with customer_category as 
(select c.customerid, sum(s.quantitypurchased) as count_all , case when 
sum(s.quantitypurchased) between 1 and 10 then 'low'
when sum(s.quantitypurchased) between 11 and 30 then 'Med'
when sum(s.quantitypurchased) >30 then 'High'
else 'None' end as Customer_Segment from sales_transaction s
inner join customer_profiles c
on s.customerid = c.customerid
group by c.customerid)
select customer_segment, count(*) from customer_category
group by customer_segment;

-- subquery

select t.customer_segment, count(*) from
(select c.customerid, sum(s.quantitypurchased) as count_all , case when 
sum(s.quantitypurchased) between 1 and 10 then 'low'
when sum(s.quantitypurchased) between 11 and 30 then 'Med'
when sum(s.quantitypurchased) >30 then 'High'
else 'None' end as Customer_Segment from sales_transaction s
inner join customer_profiles c
on s.customerid = c.customerid
group by c.customerid) as t
group by t.customer_segment;









