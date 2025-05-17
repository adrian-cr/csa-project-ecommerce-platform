# Project E-Commerce Platform

The current project contains the necessary `SQL` scripts to:
1. Create a database `ECommercePlatform`.
2. Create tables `Users`, `Products`, `Orders`, `OrderDetails`, `Payments`, `Reviews`, and `SiteActivity`.
3. Populate every table (except `SiteActivity`) with extensive sample data.
4. Perform queries to visualize and update table data.
5. Generate procedures and triggers to ...
 * set the status of an order as `'processing'` when a payment entry referencing it is inserted into the `Payments` table.
 * generate a materialized view containing a report with the 20 most active users once the table `SiteActivity` has 1000 entries.


## Tables
Here is a detailed description for every table in the project:

| Name | Description | Primary Key | Foreign Key(s) |
|----------------|------------------------------------------|-------------------|------------------------------------------------------------------------------|
| `Users` | Stores user information | `User_id`| None |
| `Products` | Contains product details | `Product_id` | None |
| `Orders` | Tracks customer orders | `Order_id` | `Users.user_id` |
| `OrderDetails` | Links products to orders | `OrderDetail_id` | `Orders.order_id`, `Products.product_id` |
| `Payments`| Records payment information | `Payment_id` | `Orders.order_id` |
| `Reviews` | Stores user reviews for products | `Review_id` | `Users.user_id`, `Products.product_id` |
| `SiteActivity` | Logs user activity on the platform| `Activity_id` | `Users.user_id` |
| `MostActiveUsers` | Report of the 20 most active users | N/A | None |

* Please note that `SiteActivity` and `MostActiveUsers` are used exclusively for `TRIGGER` and `PROCEDURE` statements, so they will not appear in the `queries` script.


## Sample Data
The project utilizes mock data provided by Mockaroo. Here is a breakdow with each table's required fields and data types:
| Table Name  | Fields (Data Type)  | Constraints  |
|------------------|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| `Users` | `user_id` (INT), `username` (VARCHAR), `email` (VARCHAR), `password` (VARCHAR), `role` (VARCHAR) | `user_id`: PRIMARY KEY, `email`: UNIQUE |
| `Products`  | `product_id` (INT), `product_name` (VARCHAR), `category` (TEXT), `price` (DECIMAL), `stock_quantity` (INT) | `product_id`: PRIMARY KEY |
| `Orders` | `order_id` (INT), `user_id` (INT), `order_date` (DATE), `total_amount` (DECIMAL), `order_status` (VARCHAR)  | `order_id`: PRIMARY KEY, `user_id`: FOREIGN KEY
| `OrderDetails` | `order_detail_id` (INT), `order_id` (INT), `product_id` (INT), `quantity` (INT), `unit_price` (DECIMAL) | `order_detail_id`: PRIMARY KEY, `order_id` : FOREIGN KEY, `product_id`: FOREIGN KEY |
| `Payments`  | `payment_id` (INT), `order_id` (INT), `payment_date` (DATE), `payment_method` (VARCHAR), `amount` (DECIMAL) | `payment_id`: PRIMARY KEY, `order_id`: FOREIGN KEY  |
| `Reviews`  | `review_id` (INT), `product_id` (INT), `user_id` (INT), `review_text` (TEXT), `rating` (INT), `review_date` (DATE)  | `review_id`: PRIMARY KEY, `user_id`: FOREIGN KEY, `product_id`: FOREIGN KEY, `rating`: CHECK (`rating BETWEEN 1 AND 5`) |
| `SiteActivity` | `activity_id` (INT), `entity_type` (VARCHAR), `entity_id` (INT), `activity_type` (VARCHAR), `activity_date` (DATE) | `activity_id`: PRIMARY KEY, `user_id`: FOREIGN KEY |
| `MostActiveUsers` | `User_id` (INT), `ActivityCount` (INT)  | No constraints  |

*No fields can be `NULL`.

## Queries
The `queries` script file is split into three sections, each with a set of `SQL` queries to visuzalize and update the data in the database:

### I. SIMPLE QUERIES
This section includes brief `SQL` statements to:
* Retrieve the list of all products in a specific category.
* Retrieve the details of a specific user by providing their user_id.
* Retrieve the order history for a particular user.
* Retrieve the products in an order along with their quantities and prices.
* Retrieve the average rating of a product.
* Retrieve the total revenue for a given month.

### II. DATA MODIFICATION
This section contains the necessary `SQL` commands to:
* Add a new product to the inventory.
* Place a new order for a user.
* Update the stock quantity of a product.
* Remove a user's review.

## III. COMPLEX QUERIES
The following `SQL` queries use aliasing and joins to:
* Identify the top-selling products.
* Find users who have placed orders exceeding a certain amount ($800).
* Calculate the overall average rating for each product category.


## Triggers & Procedures
The `ECommercePlatform` database also implements various triggers and stored procedures to:
* Automatically update the order status from `"awaiting payment"` to `"processing"` as soon as a payment for the order is inserted.
* Log activity for `Users`, `Products`, and `Orders` in the `SiteActivity` table.
* Create a materialized view with the most active users once there are 1000 entries in the `SiteActivity` table.
