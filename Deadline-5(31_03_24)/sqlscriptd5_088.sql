CREATE DATABASE db_haha;
USE db_haha;


CREATE TABLE users (
    user_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL,
    password VARCHAR(30) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    add_loc VARCHAR(50) NOT NULL,
    add_city VARCHAR(30) NOT NULL,
    add_pin VARCHAR(8) NOT NULL,
    PRIMARY KEY (user_id),
    UNIQUE (username),
    UNIQUE (phone),
    UNIQUE (email),
    INDEX (user_id, username)
);


CREATE TABLE manager (
    man_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    man_name VARCHAR(30) NOT NULL,
    username VARCHAR(20) NOT NULL,
    password VARCHAR(20) NOT NULL,
    phone VARCHAR(10) NOT NULL,
    email VARCHAR(50) NOT NULL,
    PRIMARY KEY (man_id),
    UNIQUE (username),
    UNIQUE (phone),
    UNIQUE (email),
    INDEX (man_id, username)
);


CREATE TABLE category (
    category_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (category_id)
);


CREATE TABLE product (
    prod_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    prod_name VARCHAR(50) NOT NULL,
    quantity INTEGER UNSIGNED NOT NULL,
    brand VARCHAR(20) NOT NULL,
    mrp INTEGER UNSIGNED NOT NULL,
    discount INTEGER UNSIGNED NOT NULL,
    price INTEGER UNSIGNED NOT NULL, 
    model VARCHAR(20) NOT NULL,
    image BLOB DEFAULT NULL,
    category_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (prod_id),
    CHECK (quantity >= 0),
    CHECK (mrp >= 0),
    CHECK (discount >= 0 AND discount <= 100),
    INDEX (prod_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);


CREATE TABLE ord_invoice (
    ord_id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    purchase_time DATETIME NOT NULL,
    user_id INTEGER UNSIGNED NOT NULL,
    prod_id INTEGER UNSIGNED NOT NULL,
    quantity INTEGER UNSIGNED NOT NULL,
    delivery_time DATETIME,
    PRIMARY KEY (ord_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (prod_id) REFERENCES product (prod_id),
    CHECK (quantity > 0),
    INDEX (ord_id)
);


CREATE TABLE cart (
    user_id INTEGER UNSIGNED NOT NULL,
    prod_id INTEGER UNSIGNED NOT NULL,
    quantity INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (user_id, prod_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (prod_id) REFERENCES product (prod_id),
    CHECK (quantity != 0),
    INDEX (user_id, prod_id)
);


CREATE TABLE review (
    user_id INTEGER UNSIGNED NOT NULL,
    prod_id INTEGER UNSIGNED NOT NULL,
    star INTEGER UNSIGNED NOT NULL,
    comments VARCHAR(300) NULL,
    PRIMARY KEY (user_id, prod_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (prod_id) REFERENCES product (prod_id),
    CHECK (star >=0 AND star <= 5),
    INDEX (user_id, prod_id)
);


CREATE TABLE tv (
    tv_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    tv_name VARCHAR(100) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    screen_size DECIMAL(5, 2) NOT NULL,
    resolution VARCHAR(20) NOT NULL,
    prod_id INT UNSIGNED NOT NULL,
    category_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (tv_id),
    FOREIGN KEY (prod_id) REFERENCES product(prod_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);


CREATE TABLE mobile (
    mobile_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    mobile_name VARCHAR(100) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    screen_size DECIMAL(5, 2) NOT NULL,
    operating_system VARCHAR(50) NOT NULL,
    prod_id INT UNSIGNED NOT NULL,
    category_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (mobile_id),
    FOREIGN KEY (prod_id) REFERENCES product(prod_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);


CREATE TABLE laptop (
    laptop_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    laptop_name VARCHAR(100) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    screen_size DECIMAL(5, 2) NOT NULL,
    processor VARCHAR(100) NOT NULL,
    prod_id INT UNSIGNED NOT NULL,
    category_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (laptop_id),
    FOREIGN KEY (prod_id) REFERENCES product(prod_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);


CREATE TABLE monitor (
    monitor_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    monitor_name VARCHAR(100) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    screen_size DECIMAL(5, 2) NOT NULL,
    resolution VARCHAR(20) NOT NULL,
    prod_id INT UNSIGNED NOT NULL,
    category_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (monitor_id),
    FOREIGN KEY (prod_id) REFERENCES product(prod_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);


CREATE TABLE accessory (
    accessory_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    accessory_name VARCHAR(100) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL,
    prod_id INT UNSIGNED NOT NULL,
    category_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (accessory_id),
    FOREIGN KEY (prod_id) REFERENCES product(prod_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);
 
 

INSERT INTO users (username, password, phone, email, first_name, last_name, add_loc, add_city, add_pin) 
VALUES 
('jdoe123', 'securepassword1', '1234567890', 'john.doe@example.com', 'John', 'Doe', '123 Main St', 'New York', '10001'),
('asmith456', 'password1234', '9876543210', 'anna.smith@example.com', 'Anna', 'Smith', '456 Elm St', 'Los Angeles', '90001'),
('mjohnson789', 'letmein', '1112223333', 'michael.johnson@example.com', 'Michael', 'Johnson', '789 Oak St', 'Chicago', '60601'),
('sbrown101', 'password', '4445556666', 'sarah.brown@example.com', 'Sarah', 'Brown', '101 Pine St', 'Houston', '77001'),
('klee888', 'qwerty', '7778889999', 'karen.lee@example.com', 'Karen', 'Lee', '888 Maple St', 'Miami', '33101'),
('dwhite111', 'abc123', '0001112222', 'david.white@example.com', 'David', 'White', '111 Birch St', 'San Francisco', '94101'),
('awilson222', 'letmein123', '3334445555', 'amy.wilson@example.com', 'Amy', 'Wilson', '222 Cedar St', 'Seattle', '98101'),
('rthomas333', 'password456', '6667778888', 'ryan.thomas@example.com', 'Ryan', 'Thomas', '333 Spruce St', 'Boston', '02101'),
('egarcia444', 'pass123', '9990001111', 'emma.garcia@example.com', 'Emma', 'Garcia', '444 Dark St', 'Atlanta', '30301'),
('jrodriguez555', 'password789', '2223334444', 'joseph.rodriguez@example.com', 'Joseph', 'Rodriguez', '555 Oak St', 'Dallas', '75201');



INSERT INTO manager (man_name, username, password, phone, email) 
VALUES 
('Olivia Thompson', 'olivia_thompson', 'password123', '1234567890', 'olivia.thompson@example.com'),
('William Clark', 'william_clark', 'password456', '9876543210', 'william.clark@example.com'),
('Sophia Martinez', 'sophia_martinez', 'password789', '1112223333', 'sophia.martinez@example.com'),
('Alexander Lee', 'alexander_lee', 'passwordabc', '4445556666', 'alexander.lee@example.com'),
('Ava Rodriguez', 'ava_rodriguez', 'passwordxyz', '7778889999', 'ava.rodriguez@example.com'),
('Ethan Harris', 'ethan_harris', 'password123', '0001112222', 'ethan.harris@example.com'),
('Mia Turner', 'mia_turner', 'password456', '3334445555', 'mia.turner@example.com'),
('Liam Price', 'liam_price', 'password789', '6667778888', 'liam.price@example.com'),
('Charlotte King', 'charlotte_king', 'passwordabc', '9990001111', 'charlotte.king@example.com'),
('Noah Wright', 'noah_wright', 'passwordxyz', '2223334444', 'noah.wright@example.com');



INSERT INTO category (category_name) 
VALUES 
('TVs'),
('Mobiles'),
('Laptops'),
('Monitors'),
('Accessories');



INSERT INTO product (prod_name, quantity, brand, mrp, discount, price, model, category_id) 
VALUES 
('Samsung 55-inch 4K Smart TV', 20, 'Samsung', 50000, 10, 45000, 'S55UHD', (SELECT category_id FROM category WHERE category_name = 'TVs')),
('LG 65-inch OLED TV', 15, 'LG', 80000, 15, 68000, 'LG65OLED', (SELECT category_id FROM category WHERE category_name = 'TVs')),
('Sony 50-inch Full HD TV', 25, 'Sony', 40000, 8, 36800, 'Sony50FHD', (SELECT category_id FROM category WHERE category_name = 'TVs')),
('MI 43-inch Smart TV', 30, 'MI', 30000, 5, 28500, 'MI43Smart', (SELECT category_id FROM category WHERE category_name = 'TVs')),
('TCL 55-inch QLED TV', 18, 'TCL', 55000, 12, 48400, 'TCL55QLED', (SELECT category_id FROM category WHERE category_name = 'TVs'));



INSERT INTO product (prod_name, quantity, brand, mrp, discount, price, model, category_id) 
VALUES 
('Apple iPhone 13', 30, 'Apple', 80000, 5, 76000, 'iPhone13', (SELECT category_id FROM category WHERE category_name = 'Mobiles')),
('Samsung Galaxy S21 Ultra', 25, 'Samsung', 90000, 10, 81000, 'GalaxyS21Ultra', (SELECT category_id FROM category WHERE category_name = 'Mobiles')),
('OnePlus 9 Pro', 20, 'OnePlus', 60000, 8, 55200, 'OnePlus9Pro', (SELECT category_id FROM category WHERE category_name = 'Mobiles')),
('Xiaomi Redmi Note 10', 40, 'Xiaomi', 20000, 6, 18800, 'RedmiNote10', (SELECT category_id FROM category WHERE category_name = 'Mobiles')),
('Realme 8 Pro', 35, 'Realme', 25000, 7, 23250, 'Realme8Pro', (SELECT category_id FROM category WHERE category_name = 'Mobiles'));



INSERT INTO product (prod_name, quantity, brand, mrp, discount, price, model, category_id) 
VALUES 
('Dell Inspiron 15', 25, 'Dell', 60000, 10, 54000, 'Inspiron15', (SELECT category_id FROM category WHERE category_name = 'Laptops')),
('HP Pavilion 14', 20, 'HP', 55000, 8, 50600, 'Pavilion14', (SELECT category_id FROM category WHERE category_name = 'Laptops')),
('Lenovo ThinkPad E15', 30, 'Lenovo', 65000, 12, 57200, 'ThinkPadE15', (SELECT category_id FROM category WHERE category_name = 'Laptops')),
('Asus ROG Strix G15', 15, 'Asus', 80000, 15, 68000, 'ROGStrixG15', (SELECT category_id FROM category WHERE category_name = 'Laptops')),
('Acer Swift 3', 22, 'Acer', 48000, 6, 45120, 'Swift3', (SELECT category_id FROM category WHERE category_name = 'Laptops'));



INSERT INTO product (prod_name, quantity, brand, mrp, discount, price, model, category_id) 
VALUES 
('Dell 27-inch IPS Monitor', 30, 'Dell', 20000, 5, 19000, 'Dell27IPS', (SELECT category_id FROM category WHERE category_name = 'Monitors')),
('Samsung 32-inch Curved Monitor', 20, 'Samsung', 25000, 8, 23000, 'Samsung32Curved', (SELECT category_id FROM category WHERE category_name = 'Monitors')),
('LG 24-inch Gaming Monitor', 15, 'LG', 30000, 10, 27000, 'LG24Gaming', (SELECT category_id FROM category WHERE category_name = 'Monitors')),
('AOC 21.5-inch LED Monitor', 35, 'AOC', 15000, 6, 14100, 'AOC21.5LED', (SELECT category_id FROM category WHERE category_name = 'Monitors')),
('BenQ 27-inch 4K Monitor', 25, 'BenQ', 35000, 12, 30800, 'BenQ274K', (SELECT category_id FROM category WHERE category_name = 'Monitors'));



INSERT INTO product (prod_name, quantity, brand, mrp, discount, price, model, category_id) 
VALUES 
('Logitech Wireless Keyboard', 50, 'Logitech', 2500, 10, 2250, 'LogitechKBD', (SELECT category_id FROM category WHERE category_name = 'Accessories')),
('HP Wireless Mouse', 40, 'HP', 1500, 8, 1380, 'HPMouse', (SELECT category_id FROM category WHERE category_name = 'Accessories')),
('SanDisk 64GB USB Flash Drive', 60, 'SanDisk', 1200, 5, 1140, 'SanDisk64GB', (SELECT category_id FROM category WHERE category_name = 'Accessories')),
('Seagate 1TB External Hard Drive', 35, 'Seagate', 5000, 15, 4250, 'Seagate1TB', (SELECT category_id FROM category WHERE category_name = 'Accessories')),
('JBL Portable Bluetooth Speaker', 30, 'JBL', 3000, 12, 2640, 'JBLBluetooth', (SELECT category_id FROM category WHERE category_name = 'Accessories'));



INSERT INTO ord_invoice (purchase_time, user_id, prod_id, quantity, delivery_time) 
VALUES 
('2024-02-10 10:15:00', 1, 1, 2, '2024-02-12 15:00:00'),
('2024-02-10 11:30:00', 2, 3, 1, '2024-02-13 12:00:00'),
('2024-02-11 09:45:00', 3, 2, 3, '2024-02-14 10:30:00'),
('2024-02-11 14:20:00', 4, 4, 2, '2024-02-15 09:00:00'),
('2024-02-12 12:00:00', 5, 5, 1, '2024-02-16 11:00:00');



INSERT INTO cart (user_id, prod_id, quantity) 
VALUES 
(1, 2, 1),
(2, 3, 2),
(3, 1, 3),
(4, 5, 2),
(5, 4, 1);


INSERT INTO review (user_id, prod_id, star, comments) 
VALUES 
(1, 2, 4, 'Great product!'),
(2, 3, 5, 'Excellent quality, highly recommended!'),
(3, 1, 3, 'Average product, could be better.'),
(4, 5, 4, 'Good value for money.'),
(5, 4, 5, 'Very satisfied with the purchase.');



INSERT INTO tv (tv_name, brand, screen_size, resolution, prod_id, category_id) 
VALUES 
('Samsung 55-inch 4K Smart TV', 'Samsung', 55.0, '4K', 1, (SELECT category_id FROM category WHERE category_name = 'TVs')),
('LG 65-inch OLED TV', 'LG', 65.0, 'OLED', 2, (SELECT category_id FROM category WHERE category_name = 'TVs')),
('Sony 50-inch Full HD TV', 'Sony', 50.0, 'Full HD', 3, (SELECT category_id FROM category WHERE category_name = 'TVs')),
('MI 43-inch Smart TV', 'MI', 43.0, 'Smart', 4, (SELECT category_id FROM category WHERE category_name = 'TVs')),
('TCL 55-inch QLED TV', 'TCL', 55.0, 'QLED', 5, (SELECT category_id FROM category WHERE category_name = 'TVs'));



INSERT INTO mobile (mobile_name, brand, screen_size, operating_system, prod_id, category_id) 
VALUES 
('Apple iPhone 13', 'Apple', 6.1, 'iOS', 6, (SELECT category_id FROM category WHERE category_name = 'Mobiles')),
('Samsung Galaxy S21 Ultra', 'Samsung', 6.8, 'Android', 7, (SELECT category_id FROM category WHERE category_name = 'Mobiles')),
('OnePlus 9 Pro', 'OnePlus', 6.55, 'Android', 8, (SELECT category_id FROM category WHERE category_name = 'Mobiles')),
('Xiaomi Redmi Note 10', 'Xiaomi', 6.43, 'Android', 9, (SELECT category_id FROM category WHERE category_name = 'Mobiles')),
('Realme 8 Pro', 'Realme', 6.4, 'Android', 10, (SELECT category_id FROM category WHERE category_name = 'Mobiles'));



INSERT INTO laptop (laptop_name, brand, screen_size, processor, prod_id, category_id) 
VALUES 
('Dell Inspiron 15', 'Dell', 15.6, 'Intel Core i5', 11, (SELECT category_id FROM category WHERE category_name = 'Laptops')),
('HP Pavilion 14', 'HP', 14.0, 'Intel Core i3', 12, (SELECT category_id FROM category WHERE category_name = 'Laptops')),
('Lenovo ThinkPad E15', 'Lenovo', 15.6, 'Intel Core i7', 13, (SELECT category_id FROM category WHERE category_name = 'Laptops')),
('Asus ROG Strix G15', 'Asus', 15.6, 'AMD Ryzen 7', 14, (SELECT category_id FROM category WHERE category_name = 'Laptops')),
('Acer Swift 3', 'Acer', 14.0, 'AMD Ryzen 5', 15, (SELECT category_id FROM category WHERE category_name = 'Laptops'));



INSERT INTO monitor (monitor_name, brand, screen_size, resolution, prod_id, category_id) 
VALUES 
('Dell 27-inch IPS Monitor', 'Dell', 27.0, 'IPS', 16, (SELECT category_id FROM category WHERE category_name = 'Monitors')),
('Samsung 32-inch Curved Monitor', 'Samsung', 32.0, 'Curved', 17, (SELECT category_id FROM category WHERE category_name = 'Monitors')),
('LG 24-inch Gaming Monitor', 'LG', 24.0, 'Gaming', 18, (SELECT category_id FROM category WHERE category_name = 'Monitors')),
('AOC 21.5-inch LED Monitor', 'AOC', 21.5, 'LED', 19, (SELECT category_id FROM category WHERE category_name = 'Monitors')),
('BenQ 27-inch 4K Monitor', 'BenQ', 27.0, '4K', 20, (SELECT category_id FROM category WHERE category_name = 'Monitors'));



INSERT INTO accessory (accessory_name, brand, description, prod_id, category_id) 
VALUES 
('Logitech Wireless Keyboard', 'Logitech', 'Wireless keyboard', 21, (SELECT category_id FROM category WHERE category_name = 'Accessories')),
('HP Wireless Mouse', 'HP', 'Wireless mouse', 22, (SELECT category_id FROM category WHERE category_name = 'Accessories')),
('SanDisk 64GB USB Flash Drive', 'SanDisk', '64GB USB Flash Drive', 23, (SELECT category_id FROM category WHERE category_name = 'Accessories')),
('Seagate 1TB External Hard Drive', 'Seagate', '1TB External Hard Drive', 24, (SELECT category_id FROM category WHERE category_name = 'Accessories')),
('JBL Portable Bluetooth Speaker', 'JBL', 'Portable Bluetooth Speaker', 25, (SELECT category_id FROM category WHERE category_name = 'Accessories'));



SELECT * FROM users;
SELECT * FROM manager;
SELECT * FROM category;
SELECT * FROM product;
SELECT * FROM ord_invoice;
SELECT * FROM cart;
SELECT * FROM review;
SELECT * FROM tv;
SELECT * FROM mobile;
SELECT * FROM laptop;
SELECT * FROM monitor;
SELECT * FROM accessory;

/*--------------------------------------------------------- MADE BY : Anya Hooda (2022088)----------------------------------------------------------------*/

/*----------------------------------------------------------------END OF TEXT----------------------------------------------------------------------------*/

INSERT INTO users (username, password, phone, email, first_name, last_name, add_loc, add_city, add_pin) 
VALUES 
('didaho456', 'pass123', '8221488201', 'duncan.idaho@sample.com', 'Duncan', 'Idaho', '456 Main St', 'Boston', '02102'),
('fherbert789', 'abcxyz', '1112223334', 'frank.herbert@sample.com', 'Frank', 'Herbert', '789 Coke St', 'Boston', '02111'),
('kwalker101', 'p@ssw0rd', '5556667777', 'karen.walker@sample.com', 'Karen', 'Walker', '101 Pane St', 'Boston', '02221');


INSERT INTO users (username, password, phone, email, first_name, last_name, add_loc, add_city, add_pin) 
VALUES 
('bherbert888', 'password', '8900011122', 'brian.herbert@yahoo.com', 'Brian', 'Herbert', '888 Marble St', 'Chicago', '61601'), 
('patreides777', 'securepass', '5556667702', 'paul.atreides@yahoo.com', 'Paul', 'Atreides', '777 Bin St', 'Chicago', '60301'), 
('sgarmus555', 'qwerty', '7890080112', 'sia.garmus@yahoo.com', 'Sia', 'Garmus', '555 Space St', 'Chicago', '69601');


INSERT INTO users (username, password, phone, email, first_name, last_name, add_loc, add_city, add_pin) 
VALUES 
('cevans999', 'password123', '1100998888', 'calvin.evans@msazure.com', 'Calvin', 'Evans', '999 Yummy St', 'Atlanta', '30911'),
('ezott111', 'pass1234', '2293304444', 'elizabeth.zott@msazure.com', 'Elizabeth', 'Zott', '111 Dark St', 'Atlanta', '30301'),
('mzott222', 'letmein', '3332245555', 'mad.zott@hotmail.com', 'Mad', 'Zott', '222 Dark St', 'Atlanta', '30301'),
('hjohnson333', 'abc123', '4445056666', 'harriet.johnson@exxon.com', 'Harriet', 'Johnson', '333 Plum St', 'Atlanta', '30101'),
('djones444', 'qwerty123', '5559667777', 'daisy.jones@exxon.com', 'Daisy', 'Jones', '444 Blue St', 'Atlanta', '30201'),
('bsugar555', 'sugar123', '6667770028', 'billy.sugar@hotmail.com', 'Billy', 'Sugar', '555 Error St', 'Atlanta', '30811');


CREATE TABLE login_attempts (
    user_id INT UNSIGNED NOT NULL,
    success TINYINT NOT NULL,
    attempt_time DATETIME NOT NULL,
    PRIMARY KEY (user_id, attempt_time),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

