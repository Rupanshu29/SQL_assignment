-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- SESSION 18: Interview Questions + Final Revision
-- ============================================================

-- Task 1: Artists who have uploaded more than 3 songs
DROP TABLE IF EXISTS songs;

CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    song_title VARCHAR(100),
    artist_name VARCHAR(100)
);

INSERT INTO songs VALUES (1, 'Kesariya', 'Arijit Singh');
INSERT INTO songs VALUES (2, 'Apna Bana Le', 'Arijit Singh');
INSERT INTO songs VALUES (3, 'Tum Hi Ho', 'Arijit Singh');
INSERT INTO songs VALUES (4, 'Channa Mereya', 'Arijit Singh');
INSERT INTO songs VALUES (5, 'Excuses', 'AP Dhillon');
INSERT INTO songs VALUES (6, 'Brown Munde', 'AP Dhillon');
INSERT INTO songs VALUES (7, 'Levitating', 'Dua Lipa');

SELECT
    artist_name,
    COUNT(*) AS total_songs
FROM songs
GROUP BY artist_name
HAVING COUNT(*) > 3;


-- Task 2: Each username along with their total order amount
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2)
);

INSERT INTO users VALUES (1, 'amit01');
INSERT INTO users VALUES (2, 'priya_k');
INSERT INTO users VALUES (3, 'no_orders_user');

INSERT INTO orders VALUES (1, 1, 450.00);
INSERT INTO orders VALUES (2, 1, 300.00);
INSERT INTO orders VALUES (3, 2, 620.00);

SELECT
    u.username,
    COALESCE(SUM(o.amount), 0) AS total_order_amount
FROM users AS u
LEFT JOIN orders AS o
    ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
ORDER BY total_order_amount DESC;


-- Task 3: Restaurants whose rating is higher than the average
-- rating of all restaurants
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    rating DECIMAL(2,1)
);

INSERT INTO restaurants VALUES (1, 'Swagat', 4.5);
INSERT INTO restaurants VALUES (2, 'Cafe Delight', 3.6);
INSERT INTO restaurants VALUES (3, 'Mainland China', 4.2);
INSERT INTO restaurants VALUES (4, 'Spice Hub', 3.9);

SELECT
    name,
    rating
FROM restaurants
WHERE rating > (
    SELECT AVG(rating)
    FROM restaurants
);


-- Task 4: Each user's transaction amount and running total
DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    id INT PRIMARY KEY,
    user_id INT,
    transaction_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO transactions VALUES (1, 101, '2026-09-01', 200.00);
INSERT INTO transactions VALUES (2, 101, '2026-09-05', 350.00);
INSERT INTO transactions VALUES (3, 101, '2026-09-10', 150.00);
INSERT INTO transactions VALUES (4, 102, '2026-09-02', 500.00);
INSERT INTO transactions VALUES (5, 102, '2026-09-08', 250.00);

SELECT
    user_id,
    transaction_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY user_id
        ORDER BY transaction_date, id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM transactions
ORDER BY user_id, transaction_date, id;


-- Task 5: Two query optimizations for filtering Flipkart products
DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO products VALUES (1, 'iPhone 15', 'Electronics', 45000.00);
INSERT INTO products VALUES (2, 'Wireless Mouse', 'Electronics', 599.00);
INSERT INTO products VALUES (3, 'Office Chair', 'Furniture', 4500.00);
INSERT INTO products VALUES (4, 'Bluetooth Speaker', 'Electronics', 1499.00);

-- Optimization 1: Composite index on category and price, so filtering
-- by category and then a price range can use the index instead of
-- scanning every row in the table.
CREATE INDEX idx_products_category_price
ON products (category, price);

-- Optimization 2: Select only the required columns and filter early,
-- instead of using SELECT * and filtering later, which reduces the
-- amount of data MySQL has to read and send back.
SELECT product_id, product_name, category, price
FROM products
WHERE category = 'Electronics'
  AND price BETWEEN 10000 AND 50000;
