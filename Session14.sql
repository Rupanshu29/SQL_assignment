-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Task 1: Create Orders table, insert 7 rows across different users and dates
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO Orders VALUES (1, 101, '2026-09-01', 250.00);
INSERT INTO Orders VALUES (2, 101, '2026-09-05', 400.00);
INSERT INTO Orders VALUES (3, 101, '2026-09-10', 320.00);
INSERT INTO Orders VALUES (4, 102, '2026-09-02', 600.00);
INSERT INTO Orders VALUES (5, 102, '2026-09-08', 450.00);
INSERT INTO Orders VALUES (6, 103, '2026-09-03', 150.00);
INSERT INTO Orders VALUES (7, 103, '2026-09-09', 275.00);


-- Task 2: LAG() to show each user's previous order amount
SELECT order_id, user_id, order_date,
       LAG(total_amount) OVER (PARTITION BY user_id ORDER BY order_date) AS previous_order_amount
FROM Orders;


-- Task 3: LEAD() to show each user's next order amount
SELECT order_id, user_id, order_date,
       LEAD(total_amount) OVER (PARTITION BY user_id ORDER BY order_date) AS next_order_amount
FROM Orders;


-- Task 4: Running total of total_amount for each user
SELECT order_id, user_id, order_date, total_amount,
       SUM(total_amount) OVER (
           PARTITION BY user_id
           ORDER BY order_date
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS running_total
FROM Orders;


-- Task 5: 3-order moving average of total_amount for each user
SELECT order_id, user_id, order_date, total_amount,
       AVG(total_amount) OVER (
           PARTITION BY user_id
           ORDER BY order_date
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS moving_avg
FROM Orders;
-- Note: AVG() OVER() with this frame is the same as taking
-- SUM(total_amount) OVER (same frame) divided by the number of rows
-- in that frame (up to 3), just written more directly.
