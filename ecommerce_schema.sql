create database ECommerce_Db;
use ECommerce_Db;

/* CUSTOMER table*/
CREATE TABLE Customer (
customer_id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone VARCHAR(15),
address VARCHAR(200),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);/*insert customer  table data*/
INSERT INTO Customer (customer_id, name, email, phone, address) VALUES
(1, 'Alice Johnson', 'alice@example.com', '1234567890', 'Delhi'),
(2, 'Bob Smith', 'bob@example.com', '9876543210', 'Mumbai');

/*update customer table */
UPDATE Customer
SET phone = '1112223333'
WHERE customer_id = 1;
select* from customer;

/*PRODUCT table*/
CREATE TABLE Product (
product_id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
description TEXT,
price DECIMAL(10,2) NOT NULL,
stock_quantity INT NOT NULL,
category VARCHAR(50) DEFAULT 'General',
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO Product (product_id, name, description, price, stock_quantity, category) VALUES
(1, 'Smartphone', 'Latest Android phone', 25000.00, 50, 'Electronics'),
(2, 'Headphones', 'Noise cancelling headphones', 5000.00, 100, 'Accessories'),
(3, 'Notebook', NULL, 50.00, 200, NULL);/* insert table data into product*/

/*update product table */
UPDATE Product
SET stock_quantity = stock_quantity - 1
WHERE product_id = 1;

select* from product;

/*ORDERS table*/
CREATE TABLE Orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
status VARCHAR(50) DEFAULT 'Pending',
total_amount DECIMAL(10,2),
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, CURDATE(), 30000.00),
(2, 2, CURDATE(), 50.00);
/*delete from order*/
DELETE FROM Orders
WHERE order_id = 5;
select* from orders;

-- ORDER_ITEM table
CREATE TABLE OrderItem (
order_item_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT NOT NULL,
price_per_item DECIMAL(10,2) NOT NULL,
FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
INSERT INTO OrderItem (order_item_id, order_id, product_id, quantity, price_per_item) VALUES
(1, 1, 1, 1, 25000.00),
(2, 1, 2, 1, 5000.00),
(3, 2, 3, 1, 50.00);
/*delete from orderitem*/
DELETE FROM OrderItem
WHERE order_item_id = 3;
select*from OrderItem;

CREATE TABLE Payment (
payment_id INT PRIMARY KEY,
order_id INT,
amount DECIMAL(10,2) NOT NULL,
method VARCHAR(50) CHECK (method IN ('Credit Card', 'Debit Card', 'UPI', 'Cash')),
payment_date DATE,
FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);
INSERT INTO Payment (payment_id, order_id, amount, method, payment_date) VALUES
(1, 1, 30000.00, 'UPI', CURDATE()),
(2, 2, 50.00, 'Cash', CURDATE());

/*Handle missing values using NULL*/

INSERT INTO Payment (payment_id, order_id, amount, method, payment_date)
VALUES (10, null, 1200.00, 'UPI', NULL);
select*from payment;