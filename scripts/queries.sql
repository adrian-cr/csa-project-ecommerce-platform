/* I. QUERIES */
-- Retrieve the list of all products in a specific category:
SELECT *
FROM Products
WHERE category = 'Kitchen';

-- Retrieve the details of a specific user by providing their user_id:
SELECT *
FROM Users
WHERE user_id = 16;

-- Retrieve the order history for a particular user:
SELECT *
FROM Orders
WHERE user_id = 58;

-- Retrieve the products in an order along with their quantities and prices:
SELECT p.product_id AS "Product ID", p.product_name AS "Product Name", o.quantity AS "Quantity", o.unit_price AS "Unit Price"
FROM OrderDetails o JOIN Products p
  ON  o.product_id = p.product_id
WHERE o.order_id = 98;

-- Retrieve the average rating of a product:
SELECT p.product_name AS "Product", AVG(r.rating) AS "Average Rating"
FROM Reviews r JOIN Products p
  ON p.product_id = r.product_id
WHERE p.product_id = 16;

-- Retrieve the total revenue for a given month:
SELECT SUM(total_amount) AS "April Revenue"
FROM Orders
WHERE order_date BETWEEN '2025-04-01' AND '2025-04-30';


/* II. DATA MODIFICATION */
-- Add a new product to the inventory:
INSERT INTO Products (product_name, category, price, stock_quantity)
VALUES ('Smart Blender', 'Kitchen', 79.99, 50);

-- Place a new order for a user:
INSERT INTO Orders (user_id, order_date, total_amount)
VALUES (58, '2025-04-15', 150.00);

-- Update the stock quantity of a product:
UPDATE Products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 16;

-- Remove a user's review:
DELETE FROM Reviews
WHERE review_id = 45;


/* III. COMPLEX QUERIES */
-- Identify the top-selling products:
SELECT p.product_name AS "Product Name", SUM(od.quantity) AS "Total Sold"
FROM OrderDetails od JOIN Products p
  ON od.product_id = p.product_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Find users who have placed orders exceeding a certain amount (800):
SELECT DISTINCT u.user_id AS "User ID", u.username AS "Username", o.total_amount AS "Order Total"
FROM Users u JOIN Orders o
  ON u.user_id = o.user_id
WHERE o.total_amount > 800
ORDER BY 3 DESC;

-- Calculate the overall average rating for each product category:
SELECT p.category AS "Category", CAST(AVG(r.rating) AS DECIMAL(10,2)) AS "Average Rating", COUNT(*) AS "Rating Count"
FROM Products p LEFT JOIN Reviews r
  ON p.product_id = r.product_id
WHERE r.rating IS NOT NULL
GROUP BY 1
ORDER BY 3 DESC;