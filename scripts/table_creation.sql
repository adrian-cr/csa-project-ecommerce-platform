USE ECommercePlatform;

CREATE TABLE Users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(20) NOT NULL
);

CREATE TABLE Products (
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  stock_quantity INT NOT NULL
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT REFERENCES Users(user_id),
  order_date DATETIME,
  total_amount DECIMAL(10, 2),
  order_status VARCHAR(20)
);

CREATE TABLE OrderDetails (
  order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT REFERENCES Orders(order_id),
  product_id INT REFERENCES Products(product_id),
  quantity INT NOT NULL,
  unit_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Payments (
  payment_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT REFERENCES Orders(order_id),
  payment_date DATE NOT NULL,
  payment_method VARCHAR(50) NOT NULL,
  amount DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Reviews (
  review_id INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT REFERENCES Products(product_id),
  user_id INT REFERENCES Users(user_id),
  review_text TEXT,
  rating INT CHECK (rating BETWEEN 1 AND 5) NOT NULL,
  review_date DATE NOT NULL
);

CREATE TABLE UserActivity (
  activity_id INT PRIMARY KEY AUTO_INCREMENT,
  entity_type VARCHAR(50),
  entity_id INT NOT NULL,
  activity_type VARCHAR(50) NOT NULL,
  activity_date DATE NOT NULL
);
