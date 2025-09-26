-- Select specific columns
SELECT ID, Mode_of_Shipment, Cost_of_the_Product
FROM ecommerce_shipping;

-- Filter shipments by condition
SELECT *
FROM ecommerce_shipping
WHERE Reached_on_Time_YN = 0;   -- Late deliveries


-- Order shipments by product cost
SELECT ID, Cost_of_the_Product, Discount_offered
FROM ecommerce_shipping
ORDER BY Cost_of_the_Product DESC;


-- Average rating per warehouse
SELECT Warehouse_block, AVG(Customer_rating) AS avg_rating
FROM ecommerce_shipping
GROUP BY Warehouse_block;

-- INNER JOIN: Get orders with warehouse location
SELECT e.ID, e.Warehouse_block, w.Location
FROM ecommerce_shipping e
INNER JOIN warehouse_details w
ON e.Warehouse_block = w.Warehouse_block;

-- LEFT JOIN: All orders, even if no warehouse location
SELECT e.ID, e.Warehouse_block, w.Location
FROM ecommerce_shipping e
LEFT JOIN warehouse_details w
ON e.Warehouse_block = w.Warehouse_block;

-- RIGHT JOIN: All warehouses, even if no orders
SELECT e.ID, e.Warehouse_block, w.Location
FROM ecommerce_shipping e
RIGHT JOIN warehouse_details w
ON e.Warehouse_block = w.Warehouse_block;

-- Find the maximum product cost
SELECT MAX(Cost_of_the_Product) 
FROM ecommerce_shipping;

-- Get shipment(s) with that max cost (subquery)
SELECT ID, Mode_of_Shipment, Cost_of_the_Product
FROM ecommerce_shipping
WHERE Cost_of_the_Product = (
    SELECT MAX(Cost_of_the_Product)
    FROM ecommerce_shipping
);

-- Total revenue (before discount)
SELECT SUM(Cost_of_the_Product) AS total_revenue
FROM ecommerce_shipping;

-- Average discount per shipment mode
SELECT Mode_of_Shipment, AVG(Discount_offered) AS avg_discount
FROM ecommerce_shipping
GROUP BY Mode_of_Shipment;

-- Count shipments per gender
SELECT Gender, COUNT(*) AS total_orders
FROM ecommerce_shipping
GROUP BY Gender;

-- View for late deliveries only
CREATE VIEW late_deliveries AS
SELECT ID, Warehouse_block, Mode_of_Shipment, Cost_of_the_Product
FROM ecommerce_shipping
WHERE Reached_on_Time_YN = 0;

-- View for average product cost by shipment mode
CREATE VIEW shipment_avg_cost AS
SELECT Mode_of_Shipment, AVG(Cost_of_the_Product) AS avg_cost
FROM ecommerce_shipping
GROUP BY Mode_of_Shipment;

-- Index on frequently filtered column (faster WHERE on Reached_on_Time_YN)
CREATE INDEX idx_reached_time ON ecommerce_shipping(Reached_on_Time_YN);

-- Index on Mode_of_Shipment for GROUP BY performance
CREATE INDEX idx_mode_shipment ON ecommerce_shipping(Mode_of_Shipment);