-- Create Database
CREATE DATABASE WalmartInventoryAnalytics;
GO

USE WalmartInventoryAnalytics;
GO

--------------------------------------------------
-- Categories Table
--------------------------------------------------
CREATE TABLE categories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name VARCHAR(100) NOT NULL
);

--------------------------------------------------
-- Products Table
--------------------------------------------------
CREATE TABLE products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(150) NOT NULL,
    category_id INT,
    unit_price DECIMAL(10,2),
    reorder_level INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

--------------------------------------------------
-- Warehouses Table
--------------------------------------------------
CREATE TABLE warehouses (
    warehouse_id INT PRIMARY KEY IDENTITY(1,1),
    warehouse_name VARCHAR(100),
    location VARCHAR(100)
);

--------------------------------------------------
-- Inventory Stock Table
--------------------------------------------------
CREATE TABLE inventory_stock (
    stock_id INT PRIMARY KEY IDENTITY(1,1),
    product_id INT,
    warehouse_id INT,
    quantity_available INT,
    last_updated DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

--------------------------------------------------
-- Inventory Movements Table
--------------------------------------------------
CREATE TABLE inventory_movements (
    movement_id INT PRIMARY KEY IDENTITY(1,1),
    product_id INT,
    warehouse_id INT,
    movement_type VARCHAR(20), -- IN / OUT
    quantity INT,
    movement_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);
