CREATE DATABASE UNIVERSITY_ECOM_DB;
USE UNIVERSITY_ECOM_DB;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    membership_type VARCHAR(20) DEFAULT 'Regular',
    city VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(30) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    order_date DATE NOT NULL,
    order_quantity INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

ALTER TABLE Customers ADD phone_number VARCHAR(15);
ALTER TABLE Customers DROP COLUMN phone_number; -- Dropping to keep schema clean



INSERT INTO Customers (customer_name, email, membership_type, city) VALUES
('Alice Smith', 'alice@gmail.com', 'Premium', 'Bangalore'),
('Bob Jones', 'bob@gmail.com', 'Regular', 'Mumbai'),
('Charlie Brown', 'charlie@gmail.com', 'Premium', 'Bangalore'),
('David Miller', 'david@gmail.com', 'Regular', 'Delhi'),
('Emma Watson', 'emma@gmail.com', 'Regular', 'Mumbai');

INSERT INTO Products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 60000.00, 15),
('Wireless Mouse', 'Electronics', 1200.00, 40),
('Mechanical Keyboard', 'Electronics', 3500.00, 25),
('Ergonomic Chair', 'Furniture', 8500.00, 10),
('Standing Desk', 'Furniture', 15000.00, 5),
('Old Inventory Asset', 'Discontinued', 500.00, 0); -- Will delete later

INSERT INTO Orders (customer_id, product_id, order_date, order_quantity) VALUES
(1, 1, '2026-09-01', 1),  -- Alice bought a Laptop
(1, 2, '2026-09-02', 2),  -- Alice bought 2 Mice
(2, 4, '2026-09-02', 1),  -- Bob bought a Chair
(3, 1, '2026-09-03', 1),  -- Charlie bought a Laptop
(4, 5, '2026-09-04', 1),  -- David bought a Desk
(5, 2, '2026-09-05', 5);  -- Emma bought 5 Mice

SET SQL_SAFE_UPDATES = 0; -- Turn off safe mode for category-wide updates

UPDATE Products 
SET price = price * 1.05 
WHERE category = 'Electronics';

DELETE FROM Products 
WHERE stock_quantity = 0 AND category = 'Discontinued';

SET SQL_SAFE_UPDATES = 1; -- Re-enable safe mode for structural security


SELECT * FROM Customers;
SELECT * FROM Products;

SELECT city, COUNT(*) AS customer_count
FROM Customers
GROUP BY city;

SELECT 
    category,
    COUNT(*) AS unique_products,
    SUM(stock_quantity) AS total_items_stocked,
    AVG(price) AS average_unit_price,
    MIN(price) AS cheapest_item_price,
    MAX(price) AS peak_item_price
FROM Products
GROUP BY category;

SELECT category, AVG(price) AS average_price
FROM Products
GROUP BY category
HAVING AVG(price) > 5000.00;

SELECT 
    o.order_id,
    c.customer_name,
    c.city,
    p.product_name,
    p.category,
    o.order_quantity,
    p.price AS unit_price,
    (o.order_quantity * p.price) AS total_order_revenue
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Products p ON o.product_id = p.product_id
ORDER BY total_order_revenue DESC;
