# Walmart_sales_analysis-SQL-POWER-BI
“I structured the project like a production SQL pipeline—schema design, feature engineering, and modular analysis queries. This makes it scalable and BI-tool ready.”


## 📌 Project Overview
This project analyzes Walmart sales data using **MySQL 8.x** to uncover insights related to:
- Product performance
- Customer behavior
- Sales trends
- Revenue distribution
- Branch and city-wise performance

The project follows **industry best practices** for database design, data cleaning, feature engineering, and analytical querying.

---

## 🛠 Tech Stack
- MySQL 8.x
- MySQL Workbench
- SQL (ANSI + MySQL specific functions)

---

## 📂 Dataset
- Source: Walmart sales transactional dataset
- Format: CSV
- Records include invoices, branches, customers, products, ratings, tax, and revenue details

---

## 🗂 Project Workflow

1. **Database Setup**
2. **Schema Design**
3. **Data Cleaning**
4. **Feature Engineering**
5. **Exploratory Data Analysis**
6. **Business Insights**

---

## 📑 SQL Scripts Description

| File | Description |
|-----|------------|
| `01_database_setup.sql` | Creates database |
| `02_table_schema.sql` | Creates sales table |
| `03_data_cleaning.sql` | Initial data validation |
| `04_feature_engineering.sql` | Time/day/month derived columns |
| `05_generic_analysis.sql` | City & branch insights |
| `06_product_analysis.sql` | Product & revenue analysis |
| `07_customer_analysis.sql` | Customer behavior insights |
| `08_sales_analysis.sql` | Time-based sales performance |

---

## 📊 Key Insights
- Identified top-performing product lines
- Analyzed revenue by month and city
- Evaluated customer purchase behavior
- Compared ratings across time, branch, and weekdays
- Determined high-revenue customer segments

---

## ▶ How to Run

1. Open **MySQL Workbench**
2. Run scripts in numeric order from the `sql/` folder
3. Load CSV data into `sales` table
4. Execute analysis queries

---

## 📌 Future Enhancements
- Index optimization
- Views for BI tools
- Stored procedures
- Power BI / Tableau dashboard integration

---



