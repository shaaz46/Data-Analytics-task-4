# Data-Analytics-task-4
Analyzing an E-commerce database using MySQL


## Overview  
This task involves analyzing an **E-commerce database** using **MySQL**.  
The dataset contains information about customers, orders, products, categories, and order details.  
We performed SQL operations to extract insights, create reusable views, and optimize query performance using indexes.

---

## Dataset  
- **Database:** MySQL  
- **Tables:**  
  - `customers` – Customer details  
  - `orders` – Order records with dates and amounts  
  - `order_items` – Product quantities and prices per order  
  - `products` – Product details with category links  
  - `categories` – Product category information  

---

## 🛠 Steps & SQL Operations  

### a. SELECT, WHERE, ORDER BY, GROUP BY  
- View all customer details  
- Filter customers by city  
- Sort products by price  
- Group total sales by category  

```sql
SELECT c.category_name, SUM(oi.price * oi.quantity) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_sales DESC;
