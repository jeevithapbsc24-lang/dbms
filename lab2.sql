CREATE DATABASE OnlineShoppingDB;
USE OnlineShoppingDB;

CREATE TABLE Customers (
CustomerID INT PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Email VARCHAR(100),
Address VARCHAR(150)
);

CREATE TABLE Products (
ProductID INT PRIMARY KEY AUTO_INCREMENT,
ProductName VARCHAR(100),
Category VARCHAR(50),
Price DECIMAL(10,2),
StockQuantity INT
);

CREATE TABLE Stores (
StoreID INT PRIMARY KEY AUTO_INCREMENT,
StoreName VARCHAR(100),
Location VARCHAR(100)
);

CREATE TABLE Orders (
OrderID INT PRIMARY KEY AUTO_INCREMENT,
CustomerID INT,
StoreID INT,
OrderDate DATE,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);

CREATE TABLE OrderDetails (
OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
OrderID INT,
ProductID INT,
Quantity INT,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Payments (
PaymentID INT PRIMARY KEY AUTO_INCREMENT,
OrderID INT,
PaymentDate DATE,
Amount DECIMAL(10,2),
PaymentMethod VARCHAR(50),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Customers (FirstName, LastName, Email, Address) VALUES
('John','Doe','john.doe@email.com','123 Main St'),
('Alice','Smith','alice.smith@email.com','45 Oak St'),
('Robert','Brown','robert.brown@email.com','78 Pine Ave'),
('Emily','Johnson','emily.johnson@email.com','90 Maple Rd'),
('David','Williams','david.williams@email.com','12 Elm St');

INSERT INTO Stores (StoreName, Location) VALUES
('TechMart','New York'),
('HomeStyle','Chicago'),
('FashionHub','Los Angeles'),
('GadgetWorld','San Francisco'),
('FurnitureCity','Houston');

INSERT INTO Products (ProductName, Category, Price, StockQuantity) VALUES
('Laptop','Electronics',800.00,50),
('Smartphone','Electronics',500.00,100),
('Sofa','Furniture',300.00,20),
('Dining Table','Furniture',400.00,15),
('T-Shirt','Clothing',25.00,200);

INSERT INTO Orders (CustomerID, StoreID, OrderDate) VALUES
(1,1,'2024-09-01'),
(2,2,'2024-09-02'),
(3,3,'2024-09-03'),
(4,4,'2024-09-04'),
(5,5,'2024-09-05');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1,1,1),
(2,3,1),
(3,5,3),
(4,2,2),
(5,4,1);

INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMethod) VALUES
(1,'2024-09-01',800.00,'Credit Card'),
(2,'2024-09-02',300.00,'Cash'),
(3,'2024-09-03',75.00,'Debit Card'),
(4,'2024-09-04',1000.00,'UPI'),
(5,'2024-09-05',400.00,'Credit Card');

UPDATE Products SET StockQuantity = StockQuantity - 1 WHERE ProductID = 1;
UPDATE Products SET Price = Price * 1.10 WHERE Category = 'Furniture';
DELETE FROM Customers WHERE CustomerID = 5;

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Stores;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Payments;
