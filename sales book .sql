CREATE DATABASE Sales_book;
USE Sales_book;
CREATE TABLE Sales(Sales_id int PRIMARY KEY, Sales_date int, Product varchar(50), Price decimal(4,2), location varchar(50));
ALTER TABLE Sales MODIFY Price bigint NOT NULL;
INSERT INTO Sales (Sales_id, Sales_date, Product, Price, location)
VALUES(1, 2026-12-12, 'mobile', 10, 15000,'NORTH'),
(1, 2026-12-12, 'laptop', 10, 15000,'NORTH'),
(1, 2026-12-12, 'computer', 10, 15000,'NORTH'),
(1, 2026-12-12, 'CPU', 10, 15000,'NORTH'),
(1, 2026-12-12, 'mobile', 10, 15000,'NORTH'),
(1, 2026-12-12, 'mobile', 10, 15000,'NORTH'),
(1, 2026-12-12, 'mobile', 10, 15000,'NORTH'),
(1, 2026-12-12, 'mobile', 10, 15000,'NORTH'),
(1, 2026-12-12, 'mobile', 10, 15000,'NORTH'),
(1, 2026-12-12, 'mobile', 10, 15000,'NORTH');
SELECT*FROM Sales;
SELECT count(*) AS TOTAL_SALES FROM Sales;
SELECT count(*) AS REGION_SALES FROM South;





