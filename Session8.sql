-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Task 1: Create Orders table and insert 8 sample records
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    payment_method VARCHAR(20),
    amount DECIMAL(10,2)
);

INSERT INTO Orders (order_id, user_id, payment_method, amount)
VALUES
(1, 101, 'UPI', 250.00),
(2, 102, 'Card', 500.00),
(3, 101, 'UPI', 320.00),
(4, 103, 'COD', 150.00),
(5, 102, 'Card', 620.00),
(6, 104, 'Wallet', 400.00),
(7, 103, 'COD', 280.00),
(8, 104, 'Wallet', 350.00);


-- Task 2: Count of orders placed using each payment method
SELECT payment_method, COUNT(*) AS order_count
FROM Orders
GROUP BY payment_method;


-- Task 3: Total amount spent by each user_id
SELECT user_id, SUM(amount) AS total_spent
FROM Orders
GROUP BY user_id;


-- Task 4: Payment methods where average order amount is greater than 300
SELECT payment_method, AVG(amount) AS avg_amount
FROM Orders
GROUP BY payment_method
HAVING AVG(amount) > 300;


-- Task 5: Difference between WHERE and HAVING

-- WHERE filters individual rows before any grouping happens.
-- Example: only look at orders above 300 rupees, before grouping them.
SELECT *
FROM Orders
WHERE amount > 300;

-- HAVING filters groups after aggregation has already been done.
-- Example: only show payment methods whose average order amount is above 300.
SELECT payment_method, AVG(amount) AS avg_amount
FROM Orders
GROUP BY payment_method
HAVING AVG(amount) > 300;

-- So WHERE works on raw rows, HAVING works on the summarized/grouped result.