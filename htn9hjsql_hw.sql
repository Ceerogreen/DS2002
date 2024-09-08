-- Part One
/* #1 */ SELECT `Name` FROM `world`.`country` WHERE `Continent` = 'South America';
/* #2 */ SELECT `Population` FROM `world`.`country` WHERE `Name` = 'Germany';
/* #3 */ SELECT city.Name FROM `world`.`city`, `world`.`country` WHERE city.CountryCode = country.Code AND country.Name = 'Japan';
/* #4 */ SELECT `Name` FROM `world`.`country` WHERE `Continent` = 'Africa' ORDER BY `Population` DESC LIMIT 3;
/* #5 */ SELECT `Name`,`LifeExpectancy` FROM `world`.`country` WHERE `Population` > 1000000 AND `Population` < 5000000;
/* #6 */ SELECT country.Name FROM `world`.`country`,`countrylanguage` WHERE country.Code = countrylanguage.CountryCode AND countrylanguage.Language = 'French' AND countrylanguage.IsOfficial = 'T';
/* #7 */ SELECT Album.Title FROM `Chinook_AutoIncrement`.`Album`, `Chinook_AutoIncrement`.`Artist` WHERE Album.ArtistId = Artist.ArtistId AND Artist.Name = 'AC/DC';
/* #8 */ SELECT `FirstName`,`LastName`,`Email` FROM `Chinook_AutoIncrement`.`Customer` WHERE `Country` = 'Brazil';
/* #9 */ SELECT `Name` FROM `Chinook_AutoIncrement`.`Playlist`;
/* #10 */ SELECT Count(Track.TrackId) FROM `Chinook_AutoIncrement`.`Track`, `Chinook_AutoIncrement`.`Genre` WHERE Track.GenreId = Genre.GenreId AND Genre.Name = 'Rock';
/* #11 */ SELECT `FirstName`, `LastName` FROM `Chinook_AutoIncrement`.`Employee` WHERE Employee.ReportsTo = 
	(SELECT `EmployeeId` FROM `Chinook_AutoIncrement`.`Employee` WHERE FirstName = 'Nancy' AND LastName = 'Edwards');
/* #12 */ SELECT Customer.FirstName, Customer.LastName, SUM(Invoice.Total) FROM `Chinook_AutoIncrement`.`Customer`, `Chinook_AutoIncrement`.`Invoice` WHERE Customer.CustomerId = Invoice.CustomerId GROUP BY Customer.CustomerId;
-- Part 2
USE htn9hj;

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
   	name VARCHAR(255) NOT NULL,
    category VARCHAR(255),
    price DECIMAL(10,2),
    quantity INT
);

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    email VARCHAR(255),
    address TEXT
);

CREATE TABLE Purchases (
    purchase_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    purchase_date DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE PurchaseDetails (
    purchase_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    purchase_id INT,
    product_id INT,
    quantity INT,
    price_when_bought DECIMAL(10,2),
    FOREIGN KEY (purchase_id) REFERENCES Purchases(purchase_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO PRODUCTS (name, category, price, quantity)
VALUES
('Pencils', 'Supplies', 1.99, 150),
('Stapler', 'Supplies', 5.99, 40),
('Advil', 'Medicine', 16.99, 50),
('UVA Hoodie', 'Merchandise', 39.99, 40),
('UVA Baseball Cap','Merchandise', 12.99, 60);

INSERT INTO Customers (first_name, last_name, phone_number, email, address)
VALUES
('Alex', 'Adams', '(123) 456-7890', 'aadams@gmail.com', '1 West Range, Charlottesville'),
('Bailey', 'Bryant', '(098) 765-4321', 'bbryant@gmail.com', '2 East Lawn, Charlottesville'),
('Chris', 'Christie', '(434) 928-1452', 'cchristie@hotmail.com', '104 Smith, Charlottesville'),
('Daffy', 'Duck', '(444) 444-4445', 'dduck@verizon.net', '121 Gildersleeve, Charlottesville'),
('Earl', 'Edwards', '(191) 455-2763', 'eedwards@yahoo.com', '100 Carr\'s Hill, Charlottesville');

INSERT INTO Purchases (customer_id, purchase_date, total)
VALUES
(2, '2003-12-15', 3.98),
(4, '2006-5-13', 39.99),
(4, '2007-5-13', 12.99),
(5, '2024-9-8', 22.98),
(1, '2022-2-2', 39.99);

INSERT INTO PurchaseDetails (purchase_id, product_id, quantity, price_when_bought)
VALUES
(1, 1, 2, 1.99),
(2, 4, 1, 39.99),
(3, 5, 1, 12.99),
(4, 2, 1, 5.99),
(4, 3, 1, 16.99),
(5, 4, 1, 39.99);

SELECT Customers.email FROM `Customers`, `Purchases` WHERE Customers.customer_id = Purchases.customer_id AND Purchases.purchase_date >= '2015-01-01';
SELECT * FROM `Purchases` WHERE Purchases.total > 20;
SELECT COUNT(PurchaseDetails.purchase_id) FROM `PurchaseDetails`, `Products` WHERE PurchaseDetails.product_id = Products.product_id AND Products.category = 'Merchandise';