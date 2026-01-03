USE WalmartInventoryAnalytics;
GO

--------------------------------------------------
-- 1. View current stock levels
--------------------------------------------------
SELECT p.product_name,
       w.warehouse_name,
       i.quantity_available,
       i.last_updated
FROM inventory_stock i
JOIN products p ON i.product_id = p.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
ORDER BY i.quantity_available;

--------------------------------------------------
-- 2. Products below reorder level
--------------------------------------------------
SELECT p.product_name,
       i.quantity_available,
       p.reorder_level
FROM inventory_stock i
JOIN products p ON i.product_id = p.product_id
WHERE i.quantity_available < p.reorder_level
ORDER BY i.quantity_available;

--------------------------------------------------
-- 3. Warehouse-wise total stock
--------------------------------------------------
SELECT w.warehouse_name,
       SUM(i.quantity_available) AS total_stock
FROM inventory_stock i
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_name
ORDER BY total_stock DESC;

--------------------------------------------------
-- 4. Category-wise stock distribution
--------------------------------------------------
SELECT c.category_name,
       SUM(i.quantity_available) AS category_stock
FROM inventory_stock i
JOIN products p ON i.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY category_stock DESC;

--------------------------------------------------
-- 5. Products with zero or critical stock
--------------------------------------------------
SELECT p.product_name,
       w.warehouse_name,
       i.quantity_available
FROM inventory_stock i
JOIN products p ON i.product_id = p.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id
WHERE i.quantity_available <= 10
ORDER BY i.quantity_available;
