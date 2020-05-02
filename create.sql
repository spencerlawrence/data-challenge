create database dermstore;
create table dermstore.customers(
customer_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
customer_firstname VARCHAR(255) NOT NULL,
customer_lastname VARCHAR(255) NOT NULL,
customer_email VARCHAR(255),
date_created DATETIME DEFAULT CURRENT_TIMESTAMP
);

create table dermstore.products(
product_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
product_name VARCHAR(255) NOT NULL,
product_price DECIMAL(10,2),
product_cost DECIMAL(10,2),
product_status VARCHAR(30),
date_created DATETIME DEFAULT CURRENT_TIMESTAMP
);

create table dermstore.orders(
order_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
customer_id INT UNSIGNED NOT NULL,
order_total DECIMAL(10,2),
order_source VARCHAR(30),
date_created DATETIME DEFAULT CURRENT_TIMESTAMP,
INDEX(customer_id),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

create table dermstore.orders_items(
order_id INT UNSIGNED NOT NULL,
product_id INT UNSIGNED NOT NULL,
item_quantity INT,
item_price DECIMAL(10,2),
date_created DATETIME DEFAULT CURRENT_TIMESTAMP,
INDEX(order_id, product_id),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

create table dermstore.attributes(
attribute_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
attribute_name VARCHAR(255) NOT NULL,
attribute_parent_id INT UNSIGNED NOT NULL
);

create table dermstore.products_attributes(
product_id INT UNSIGNED NOT NULL,
attribute_id INT UNSIGNED NOT NULL,
INDEX(product_id, attribute_id),
FOREIGN KEY (product_id) REFERENCES products(product_id),
FOREIGN KEY (attribute_id) REFERENCES attributes(attribute_id)
);