-- Table Creation and Insertion 
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    registration_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),
    stock_quantity INT
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO categories (category_name) VALUES
('Electronics'), ('Clothing'), ('Books'), ('Home Appliances');

INSERT INTO products (product_name, category_id, price, stock_quantity) VALUES
('Smartphone', 1, 500.00, 50),
('Laptop', 1, 800.00, 30),
('T-shirt', 2, 20.00, 100),
('Novel', 3, 15.00, 200),
('Microwave', 4, 150.00, 25);

INSERT INTO customers (first_name, last_name, email, city, country, registration_date) VALUES
('John', 'Doe', 'john@example.com', 'New York', 'USA', '2022-01-15'),
('Jane', 'Smith', 'jane@example.com', 'Los Angeles', 'USA', '2022-02-10'),
('Michael', 'Brown', 'michael@example.com', 'Chicago', 'USA', '2022-03-05');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2023-07-10', 1000.00),
(2, '2023-07-12', 35.00),
(3, '2023-07-15', 150.00);

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 500.00),
(1, 2, 1, 800.00),
(2, 3, 1, 20.00),
(2, 4, 1, 15.00),
(3, 5, 1, 150.00);

-- SELECT, WHERE, ORDER BY, GROUP BY And JOINS
SELECT * FROM customers;

SELECT first_name, last_name, email
FROM customers;

SELECT * 
FROM customers
WHERE city = 'New York';

SELECT * 
FROM products
WHERE price > 100;

SELECT o.order_id, o.order_date, c.first_name, c.last_name, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

SELECT c.customer_id, c.first_name, c.last_name, o.order_id, o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

SELECT o.order_id, o.order_date, c.first_name, c.last_name
FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.customer_id;	

-- Aggregate functions (SUM, AVG) 

SELECT SUM(total_amount) AS total_sales
FROM orders;

SELECT AVG(total_amount) AS avg_order_value
FROM orders;

SELECT COUNT(order_id) AS total_orders
FROM orders;

SELECT MAX(total_amount) AS highest_order,
       MIN(total_amount) AS lowest_order
FROM orders;


-- Views for Analysis

CREATE VIEW sales_by_category AS
SELECT c.category_name, SUM(oi.price * oi.quantity) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name;

SELECT * FROM sales_by_category;

CREATE VIEW customer_purchase_summary AS
SELECT cu.customer_id, cu.first_name, cu.last_name, 
       COUNT(o.order_id) AS total_orders, 
       SUM(o.total_amount) AS total_spent
FROM customers cu
LEFT JOIN orders o ON cu.customer_id = o.customer_id
GROUP BY cu.customer_id;

SELECT * FROM customer_purchase_summary;

