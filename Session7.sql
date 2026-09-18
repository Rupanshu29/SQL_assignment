-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Task 1: Create Orders table and insert 5 rows, including one NULL total_amount
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    total_amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO Orders (order_id, user_name, total_amount, order_date)
VALUES
(1, 'Amit', 450.00, '2026-09-01'),
(2, 'Priya', 620.00, '2026-09-02'),
(3, 'Amit', 300.00, '2026-09-03'),
(4, 'Rahul', NULL, '2026-09-04'),
(5, 'Priya', 750.00, '2026-09-05');


-- Task 2: Count of orders placed by each user
SELECT user_name, COUNT(*) AS order_count
FROM Orders
GROUP BY user_name;


-- Task 3: Average total_amount, ignoring NULL values
SELECT AVG(total_amount) AS average_order_amount
FROM Orders
WHERE total_amount IS NOT NULL;


-- Task 4: Highest and lowest order amount in a single row
SELECT MAX(total_amount) AS highest_amount, MIN(total_amount) AS lowest_amount
FROM Orders;


-- Task 5: Total sales, excluding NULL values
SELECT SUM(total_amount) AS total_sales
FROM Orders
WHERE total_amount IS NOT NULL;