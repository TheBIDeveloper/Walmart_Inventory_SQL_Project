USE WalmartInventoryAnalytics;
GO

--------------------------------------------------
-- 6. Inventory movement summary per product
--------------------------------------------------
SELECT p.product_name,
       SUM(CASE WHEN m.movement_type = 'IN' THEN m.quantity ELSE 0 END) AS total_in,
       SUM(CASE WHEN m.movement_type = 'OUT' THEN m.quantity ELSE 0 END) AS total_out
FROM inventory_movements m
JOIN products p ON m.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_out DESC;

--------------------------------------------------
-- 7. Net stock movement per warehouse
--------------------------------------------------
SELECT w.warehouse_name,
       SUM(CASE WHEN m.movement_type = 'IN' THEN m.quantity ELSE -m.quantity END) AS net_movement
FROM inventory_movements m
JOIN warehouses w ON m.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_name
ORDER BY net_movement DESC;

--------------------------------------------------
-- 8. Running total of inventory movement per product
--------------------------------------------------
SELECT p.product_name,
       m.movement_date,
       SUM(CASE WHEN m.movement_type = 'IN' THEN m.quantity ELSE -m.quantity END)
       OVER(PARTITION BY p.product_name ORDER BY m.movement_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_stock_change
FROM inventory_movements m
JOIN products p ON m.product_id = p.product_id
ORDER BY p.product_name, m.movement_date;

--------------------------------------------------
-- 9. Top 5 fast-moving products (highest outbound)
--------------------------------------------------
SELECT TOP 5 p.product_name,
       SUM(m.quantity) AS total_outbound
FROM inventory_movements m
JOIN products p ON m.product_id = p.product_id
WHERE m.movement_type = 'OUT'
GROUP BY p.product_name
ORDER BY total_outbound DESC;

--------------------------------------------------
-- 10. Products frequently breaching reorder level
--------------------------------------------------
WITH stock_risk AS (
    SELECT p.product_name,
           i.quantity_available,
           p.reorder_level
    FROM inventory_stock i
    JOIN products p ON i.product_id = p.product_id
)
SELECT *
FROM stock_risk
WHERE quantity_available < reorder_level
ORDER BY quantity_available;
