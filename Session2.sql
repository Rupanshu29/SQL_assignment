-- Task 1: Install MySQL and verify installation
-- This is a manual step, not a query.
-- Install MySQL Community Server (or use MySQL Workbench if already installed),
-- then open MySQL Workbench, connect to 'Local instance MySQL80', and run:
SELECT VERSION();
-- If this runs and shows a version number, the installation is working.


-- Task 2: Create the foodie_app database
CREATE DATABASE IF NOT EXISTS foodie_app;

USE foodie_app;


-- Task 3: Create the restaurants table
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    cuisine VARCHAR(50),
    rating DECIMAL(2,1),
    location VARCHAR(100)
);


-- Task 4: Create the users table
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15) UNIQUE,
    created_at DATETIME
);


-- Task 5: Intentional mistake, then the fix
-- Run the broken statement below first (it is missing a comma after 'name VARCHAR(100)').
-- MySQL will throw a syntax error - take a screenshot of that error for your records.

-- BROKEN VERSION (run this first to see the error):
-- CREATE TABLE test_mistake (
--     id INT PRIMARY KEY
--     name VARCHAR(100),
--     price DECIMAL(6,2)
-- );

-- CORRECTED VERSION (run this after taking the error screenshot):
DROP TABLE IF EXISTS test_mistake;

CREATE TABLE test_mistake (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(6,2)
);
