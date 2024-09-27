USE restaurant_db;

-- Viewing the menu_items table
SELECT * FROM menu_items;

-- Query to find the number of items on the menu
SELECT COUNT(*) FROM menu_items; 
-- There are 32 items in the menu

-- Finding least and most expensive items on the menu
SELECT * 
FROM menu_items 
ORDER BY price; 
-- Least expensive item is Edamame 

SELECT * 
FROM menu_items 
ORDER BY price DESC;
-- Most expensive item = Shrimp Scampi

-- Number of Italian dishes on the menu
SELECT COUNT(*) FROM menu_items
WHERE category = 'Italian';
 -- There are 9 Italian Dishes on the menu

-- Least and most expensive Italian dishes on the menu
SELECT * FROM menu_items 
WHERE category = 'Italian'
ORDER BY price;  
-- The least expensive items are Spaghetti and Fettuccine Alfredo 

SELECT * FROM menu_items 
WHERE category = 'Italian'
ORDER BY price DESC; 
-- The most expensive item is Shrimp Scampi 

-- Number dishes in each category
SELECT category, COUNT(item_name) AS num_dishes  
FROM menu_items 
GROUP BY category;
-- American = 6, Asian = 8, Mexican = 9, Italian = 9

-- The average dish price within each category
SELECT category, AVG(price) AS avg_price  
FROM menu_items 
GROUP BY category;
-- American = 10.07, Asian = 13.48, Mexican = 11.80, Italian = 16.75

-- Viewing the orders table
SELECT * FROM order_details;

-- Finding the date range of the table 
SELECT MIN(order_date), MAX(order_date) FROM order_details;
-- Date range (2023-01-01) - (2023-03-31)

-- Number of orders that were made in this date range
SELECT COUNT(DISTINCT(order_date)) FROM order_details;
-- 90 orders 

-- Number of items that were ordered in this date range
SELECT COUNT(*) FROM order_details;
-- Items ordered were 12,234 

-- Finding which orders had the most number of items
SELECT order_id, COUNT(item_id) AS num_items 
FROM order_details 
GROUP BY order_id
ORDER BY num_items DESC;
-- Orders that had most items = 330, 440, 443, 1957, 2675, 3473, 4305

-- Number of orders that had more than 12 items
SELECT COUNT(*) FROM 
(SELECT order_id, COUNT(item_id) AS num_items 
FROM order_details 
GROUP BY order_id
HAVING num_items > 12) AS num_orders;
-- 20 orders had more than 12 items

-- Combining the menu_items and order_details tables into a single table
SELECT * FROM menu_items; 
SELECT * FROM order_details;

-- Joining the tables 
SELECT * 
FROM order_details od LEFT JOIN menu_items mi 
	ON od.item_id = mi.menu_item_id; 

-- The least and most ordered items
SELECT item_name, COUNT(order_details_id) AS num_purchases 
FROM order_details od LEFT JOIN menu_items mi 
	ON od.item_id = mi.menu_item_id 
GROUP BY item_name
ORDER BY num_purchases;	 
-- Least ordered item was Chicken Tacos = 123 

SELECT item_name, COUNT(order_details_id) AS num_purchases 
FROM order_details od LEFT JOIN menu_items mi 
	ON od.item_id = mi.menu_item_id 
GROUP BY item_name
ORDER BY num_purchases DESC;	
-- Most ordered item was Hamburger = 622 

-- The categories are they in
SELECT item_name, category, COUNT(order_details_id) AS num_purchases 
FROM order_details od LEFT JOIN menu_items mi 
	ON od.item_id = mi.menu_item_id 
GROUP BY item_name, category
ORDER BY num_purchases; 
-- Chicken Tacos = Mexican 

SELECT item_name, category, COUNT(order_details_id) AS num_purchases 
FROM order_details od LEFT JOIN menu_items mi 
	ON od.item_id = mi.menu_item_id 
GROUP BY item_name, category
ORDER BY num_purchases DESC; 
-- Hamburger = American

-- The top 5 orders that spent the most money
SELECT order_id, SUM(price) AS total_spend 
FROM order_details od LEFT JOIN menu_items mi 
	ON od.item_id = mi.menu_item_id 
GROUP BY order_id 
ORDER BY total_spend DESC
LIMIT 5;
-- Top 5 orders had order id = 440, 2075, 1957, 330, 2675

-- View the details of the highest spend order. 
 SELECT category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi 
	ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;

-- Which specific items were purchased?
SELECT item_name 
FROM order_details od LEFT JOIN menu_items mi 
	ON od.item_id = mi.menu_item_id
WHERE order_id = 440;

-- Viewing the details of the top 5 highest spend orders
SELECT order_id, category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi 
	ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;