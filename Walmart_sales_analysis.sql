CREATE DATABASE IF NOT EXISTS walmart_Sales;

-- Create table
CREATE TABLE sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct decimal(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct decimal(6,4),
    gross_income DECIMAL(12, 4),
    rating decimal(3, 1),
        -- Derived columns 
    time_of_day VARCHAR(20),
    day_name VARCHAR(10),
    month_name VARCHAR(10)
);
select * from sales;

-- =====================================================
-- Database
-- =====================================================
CREATE DATABASE IF NOT EXISTS walmartSales;
USE walmartSales;

-- =====================================================
-- Data Check
-- =====================================================
SELECT * FROM sales;

-- =====================================================
-- Time of Day Classification
-- =====================================================
UPDATE sales
SET time_of_day =
    CASE
        WHEN time < '12:00:00' THEN 'Morning'
        WHEN time < '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END;

-- =====================================================
-- Day & Month Name
-- =====================================================
UPDATE sales
SET
    day_name   = DAYNAME(date),
    month_name = MONTHNAME(date);

-- =====================================================
-- ------------------ GENERIC ANALYSIS -----------------
-- =====================================================

-- Unique cities
SELECT DISTINCT city FROM sales;

-- City per branch
SELECT DISTINCT branch, city FROM sales;

-- =====================================================
-- ------------------ PRODUCT ANALYSIS -----------------
-- =====================================================

-- Unique product lines
SELECT DISTINCT product_line FROM sales;

-- Most selling product line
SELECT product_line, SUM(quantity) AS total_quantity
FROM sales
GROUP BY product_line
ORDER BY total_quantity DESC;

-- Revenue by month
SELECT month_name, SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- Month with highest COGS
SELECT month_name, SUM(cogs) AS total_cogs
FROM sales
GROUP BY month_name
ORDER BY total_cogs DESC;

-- Product line with highest revenue
SELECT product_line, SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- City with highest revenue
SELECT city, branch, SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch
ORDER BY total_revenue DESC;

-- Product line with highest VAT
SELECT product_line, ROUND(AVG(tax_pct), 4) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Product line performance (Good / Bad)
SELECT
    product_line,
    CASE
        WHEN AVG(quantity) > (SELECT AVG(quantity) FROM sales)
        THEN 'Good'
        ELSE 'Bad'
    END AS remark
FROM sales
GROUP BY product_line;

-- Branches selling above average
SELECT branch, SUM(quantity) AS total_quantity
FROM sales
GROUP BY branch
HAVING total_quantity > (SELECT AVG(quantity) FROM sales);

-- Most common product line by gender
SELECT gender, product_line, COUNT(*) AS count
FROM sales
GROUP BY gender, product_line
ORDER BY count DESC;

-- Average rating per product line
SELECT product_line, ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- =====================================================
-- ------------------ CUSTOMER ANALYSIS ----------------
-- =====================================================

-- Customer types
SELECT DISTINCT customer_type FROM sales;

-- Payment methods
SELECT DISTINCT payment FROM sales;

-- Most common customer type
SELECT customer_type, COUNT(*) AS count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

-- Gender distribution
SELECT gender, COUNT(*) AS count
FROM sales
GROUP BY gender
ORDER BY count DESC;

-- Gender distribution per branch
SELECT branch, gender, COUNT(*) AS count
FROM sales
GROUP BY branch, gender
ORDER BY branch, count DESC;

-- =====================================================
-- ------------------ SALES ANALYSIS -------------------
-- =====================================================

-- Avg rating by time of day
SELECT time_of_day, ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Avg rating by time of day per branch
SELECT branch, time_of_day, ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY branch, time_of_day
ORDER BY branch, avg_rating DESC;

-- Best rating by weekday
SELECT day_name, ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Sales count per weekday per branch
SELECT branch, day_name, COUNT(*) AS total_sales
FROM sales
GROUP BY branch, day_name
ORDER BY branch, total_sales DESC;

-- Sales by time of day on Sunday
SELECT time_of_day, COUNT(*) AS total_sales
FROM sales
WHERE day_name = 'Sunday'
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Revenue by customer type
SELECT customer_type, SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- City with highest VAT
SELECT city, ROUND(AVG(tax_pct),2) AS avg_tax
FROM sales
GROUP BY city
ORDER BY avg_tax DESC;

-- VAT by customer type
SELECT customer_type, ROUND(AVG(tax_pct),4) AS avg_tax
FROM sales
GROUP BY customer_type
ORDER BY avg_tax DESC;
