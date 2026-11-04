DROP DATABASE IF EXISTS RetailLab;
CREATE DATABASE RetailLab;
USE RetailLab;

CREATE TABLE categories (
    category_id    INT           AUTO_INCREMENT PRIMARY KEY,
    category_name  VARCHAR(50)   NOT NULL UNIQUE
);

CREATE TABLE products (
    product_id     INT            AUTO_INCREMENT PRIMARY KEY,
    product_name   VARCHAR(100)   NOT NULL,
    brand          VARCHAR(40)    NOT NULL,
    category_id    INT            NOT NULL,
    unit_price     DECIMAL(10,2)  NOT NULL,
    stock_qty      INT            NOT NULL DEFAULT 0,
    reorder_level  INT            NOT NULL DEFAULT 20,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE customers (
    customer_id     INT           AUTO_INCREMENT PRIMARY KEY,
    full_name       VARCHAR(80)   NOT NULL,
    email           VARCHAR(100)  NULL,                 -- some customers have no email (NULL)
    city            VARCHAR(50)   NOT NULL,
    joined_date     DATE          NOT NULL,
    loyalty_points  INT           NOT NULL DEFAULT 0
);

CREATE TABLE orders (
    order_id       INT           AUTO_INCREMENT PRIMARY KEY,
    customer_id    INT           NOT NULL,
    order_date     DATE          NOT NULL,
    status         VARCHAR(20)   NOT NULL,
    payment_mode   VARCHAR(20)   NOT NULL,
    delivery_date  DATE          NULL,                  -- NULL until the order is delivered
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id     INT  AUTO_INCREMENT PRIMARY KEY,
    order_id    INT  NOT NULL,
    product_id  INT  NOT NULL,
    quantity    INT  NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO categories (category_name) VALUES
('Groceries'), ('Personal Care'), ('Beverages'), ('Household'), ('Snacks');

INSERT INTO products (product_name, brand, category_id, unit_price, stock_qty, reorder_level) VALUES
('Basmati Rice 5kg',          'GoldenHarvest', 1, 550.00,  80, 30),
('Toor Dal 1kg',              'FarmFresh',     1, 165.00, 120, 40),
('Sunflower Oil 1L',          'SunGold',       1, 145.00,  15, 25),
('Green Tea Box',             'LeafLife',      3, 240.00,  45, 20),
('Filter Coffee 500g',        'BrewMaster',    3, 310.00,  12, 20),
('Fruit Juice 1L',            'FreshSip',      3, 110.00,  90, 30),
('Herbal Shampoo',            'PureBloom',     2, 199.00,  70, 25),
('Bath Soap Pack',            'PureBloom',     2, 120.00, 100, 40),
('Dish Wash Liquid',          'SparkleHome',   4,  99.00,   8, 20),
('Floor Cleaner 1L',          'SparkleHome',   4, 175.00,  40, 15),
('Masala Peanuts 200g',       'CrunchTime',    5,  60.00, 150, 50),
('Potato Chips Family Pack',  'CrunchTime',    5,  90.00,  22, 30),
('Instant Noodles Pack of 5', 'FarmFresh',     5,  85.00,   0, 30);

INSERT INTO customers (full_name, email, city, joined_date, loyalty_points) VALUES
('Aarav Sharma',   'aarav@example.com',  'Bengaluru', '2026-01-10', 320),
('Diya Nair',      'diya@example.com',   'Kochi',     '2026-02-14', 150),
('Rohan Gupta',    NULL,                 'Delhi',     '2026-03-03',  90),
('Meera Iyer',     'meera@example.com',  'Chennai',   '2026-03-21',   0),
('Kabir Singh',    'kabir@example.com',  'Mumbai',    '2026-04-09',  60),
('Ananya Reddy',   NULL,                 'Hyderabad', '2026-05-18', 210),
('Vikram Patil',   'vikram@example.com', 'Pune',      '2026-06-02',  40),
('Sneha Kulkarni', 'sneha@example.com',  'Bengaluru', '2026-06-25', 500),
('Aditya Menon',   'aditya@example.com', 'Kochi',     '2026-07-11',  25),
('Isha Kapoor',    'isha@example.com',   'Delhi',     '2026-08-05',   0);

INSERT INTO orders (customer_id, order_date, status, payment_mode, delivery_date) VALUES
(1, '2026-07-05', 'Delivered', 'UPI',  '2026-07-07'),
(2, '2026-07-12', 'Delivered', 'Card', '2026-07-15'),
(3, '2026-08-02', 'Delivered', 'Cash', '2026-08-05'),
(1, '2026-08-10', 'Delivered', 'UPI',  '2026-08-12'),
(4, '2026-08-15', 'Cancelled', 'Card', NULL),
(5, '2026-08-21', 'Delivered', 'Cash', '2026-08-24'),
(2, '2026-09-01', 'Delivered', 'UPI',  '2026-09-03'),
(6, '2026-09-08', 'Pending',   'Card', NULL),
(3, '2026-09-15', 'Delivered', 'UPI',  '2026-09-17'),
(7, '2026-09-22', 'Pending',   'Cash', NULL),
(8, '2026-09-24', 'Shipped',   'UPI',  NULL),
(1, '2026-09-25', 'Pending',   'Card', NULL),
(9, '2026-09-27', 'Shipped',   'Cash', NULL),
(8, '2026-09-28', 'Pending',   'UPI',  NULL);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),  (1, 3, 1),
(2, 5, 2),  (2, 4, 1),
(3, 2, 3),  (3, 9, 2),
(4, 7, 1),  (4, 8, 3),
(5, 1, 1),  (5, 6, 4),
(6, 10, 2), (6, 9, 1),
(7, 2, 2),  (7, 3, 2),
(8, 4, 2),  (8, 5, 1),
(9, 8, 2),  (9, 7, 2),
(10, 6, 6), (10, 1, 1),
(11, 11, 5), (11, 12, 2),
(12, 2, 2), (12, 11, 3),
(13, 6, 3), (13, 12, 1),
(14, 5, 1), (14, 4, 1), (14, 7, 1);

-- Quick check: the tables are loaded
SELECT (SELECT COUNT(*) FROM products)    AS products,
       (SELECT COUNT(*) FROM customers)   AS customers,
       (SELECT COUNT(*) FROM orders)      AS orders,
       (SELECT COUNT(*) FROM order_items) AS order_lines;