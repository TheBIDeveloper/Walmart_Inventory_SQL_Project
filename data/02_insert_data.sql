USE WalmartInventoryAnalytics;
GO

--------------------------------------------------
-- Insert Categories
--------------------------------------------------
INSERT INTO categories (category_name)
VALUES
('Groceries'),
('Electronics'),
('Clothing'),
('Home & Kitchen'),
('Health & Personal Care');

--------------------------------------------------
-- Insert Products
--------------------------------------------------
INSERT INTO products (product_name, category_id, unit_price, reorder_level)
VALUES
('Rice 5kg', 1, 12.50, 50),
('Cooking Oil 1L', 1, 5.25, 40),
('LED TV 42 Inch', 2, 420.00, 10),
('Wireless Headphones', 2, 75.00, 20),
('Men T-Shirt', 3, 15.00, 60),
('Women Jeans', 3, 35.00, 50),
('Mixer Grinder', 4, 95.00, 15),
('Vacuum Cleaner', 4, 120.00, 12),
('Shampoo 500ml', 5, 6.50, 80),
('Toothpaste Pack', 5, 4.00, 100);

--------------------------------------------------
-- Insert Warehouses
--------------------------------------------------
INSERT INTO warehouses (warehouse_name, location)
VALUES
('Walmart Central DC', 'Texas'),
('Walmart East DC', 'New York'),
('Walmart West DC', 'California');

--------------------------------------------------
-- Insert Inventory Stock
--------------------------------------------------
INSERT INTO inventory_stock (product_id, warehouse_id, quantity_available, last_updated)
VALUES
(1, 1, 120, GETDATE()),
(2, 1, 35, GETDATE()),
(3, 2, 8, GETDATE()),
(4, 2, 25, GETDATE()),
(5, 3, 70, GETDATE()),
(6, 3, 45, GETDATE()),
(7, 1, 10, GETDATE()),
(8, 2, 5, GETDATE()),
(9, 3, 150, GETDATE()),
(10, 1, 90, GETDATE());

--------------------------------------------------
-- Insert Inventory Movements
--------------------------------------------------
INSERT INTO inventory_movements (product_id, warehouse_id, movement_type, quantity, movement_date)
VALUES
(1, 1, 'OUT', 30, GETDATE()-10),
(1, 1, 'IN', 50, GETDATE()-8),
(2, 1, 'OUT', 20, GETDATE()-6),
(3, 2, 'OUT', 5, GETDATE()-5),
(4, 2, 'IN', 15, GETDATE()-4),
(5, 3, 'OUT', 40, GETDATE()-7),
(6, 3, 'OUT', 25, GETDATE()-3),
(7, 1, 'IN', 20, GETDATE()-2),
(8, 2, 'OUT', 8, GETDATE()-1),
(9, 3, 'OUT', 60, GETDATE()-9);
