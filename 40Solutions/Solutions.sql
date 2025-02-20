-- ## 1

CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY not null,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);

-- 1.

INSERT INTO Customers (FirstName, LastName, Email)
VALUES ('Harhar', 'Petrovic', '123@hotmail.com')

-- 2.

UPDATE Customers SET Email = '234@gmail.com' WHERE CustomerID = 1;

-- 3.

DELETE FROM Customers WHERE CustomerID = 5;

-- 4.

SELECT * FROM Customers
ORDER BY LastName

-- 5.

INSERT INTO Customers (FirstName, LastName, Email)
VALUES ('Joski', 'Pon', '543@hotmail.com'),
       ('Emil', 'Alyev', 'emil@outlook.com'),
       ('Atilla', 'Ismailov', 'EddieVanHalen@gmail.com')

-- ## 2

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY not null,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 6.

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES  (1, '2023-03-15', 20)

-- 7.

UPDATE Orders Set TotalAmount = 15 WHERE OrderID = 2

-- 8.

DELETE FROM Orders WHERE OrderID = 3

-- 9.

SELECT * FROM Orders
WHERE CustomerID = 1

-- 10.

SELECT * FROM Orders
WHERE YEAR(OrderDate) = 2023

-- ## 3

CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY not null,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

-- 11.

INSERT INTO Products (ProductName, Price)
VALUES ('Pomidor', 5)

-- 12.

UPDATE Products SET Price = 6 WHERE ProductID = 2

-- 13.

DELETE FROM Products WHERE ProductID = 4

-- 14.

SELECT * FROM Products
WHERE Price > 100

-- 15.

SELECT * FROM Products
WHERE Price <= 50

-- ## 4

CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY not null,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 16.

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES (1, 1, 13, 56)

-- 17.

UPDATE OrderDetails SET Quantity = 12 WHERE OrderDetailID = 1

-- 18.

DELETE FROM OrderDetails WHERE OrderDetailID = 2

-- 19.

SELECT * FROM OrderDetails
WHERE OrderID = 1

-- 20.

SELECT * FROM OrderDetails
WHERE ProductID = 2

-- 21.

SELECT O.OrderID, C.FirstName, C.LastName, O.OrderDate, O.TotalAmount
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID;

-- 22.

SELECT C.FirstName, C.LastName, P.ProductName, OD.Quantity
FROM OrderDetails OD
INNER JOIN Orders O ON OD.OrderID = O.OrderID
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
INNER JOIN Products P ON OD.ProductID = P.ProductID;

-- 23.

SELECT O.OrderID, C.FirstName, C.LastName, O.OrderDate, O.TotalAmount
FROM Orders O
LEFT JOIN Customers C ON O.CustomerID = C.CustomerID;

-- 24.

SELECT O.OrderID, P.ProductName, OD.Quantity, OD.Price
FROM Orders O
INNER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
INNER JOIN Products P ON OD.ProductID = P.ProductID;

-- 25.

SELECT C.CustomerID, C.FirstName, C.LastName, O.OrderID, O.OrderDate
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID;

-- 26.

SELECT P.ProductID, P.ProductName, O.OrderID, OD.Quantity
FROM Products P
RIGHT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
RIGHT JOIN Orders O ON OD.OrderID = O.OrderID;

-- 27.

SELECT O.OrderID, P.ProductName, OD.Quantity, O.OrderDate
FROM Orders O
INNER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
INNER JOIN Products P ON OD.ProductID = P.ProductID;

-- 28.

SELECT C.FirstName, C.LastName, O.OrderID, P.ProductName, OD.Quantity, OD.Price
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
INNER JOIN Products P ON OD.ProductID = P.ProductID;

-- 29.

SELECT C.FirstName, C.LastName
FROM Customers C
WHERE C.CustomerID IN (
    SELECT O.CustomerID FROM Orders O WHERE O.TotalAmount > 500
);

-- 30.

SELECT P.ProductID, P.ProductName
FROM Products P
WHERE P.ProductID IN (
    SELECT OD.ProductID FROM OrderDetails OD GROUP BY OD.ProductID HAVING SUM(OD.Quantity) > 10
);

-- 31.

SELECT C.CustomerID, C.FirstName, C.LastName,
       (SELECT SUM(O.TotalAmount) FROM Orders O WHERE O.CustomerID = C.CustomerID) AS TotalSpent
FROM Customers C;

-- 32.

SELECT P.ProductID, P.ProductName, P.Price
FROM Products P
WHERE P.Price > (SELECT AVG(Price) FROM Products);

-- 33.

SELECT C.FirstName, C.LastName, O.OrderID, P.ProductName, OD.Quantity, OD.Price, O.OrderDate
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID;

-- 34.

SELECT C.FirstName, C.LastName, O.OrderID, P.ProductName, OD.Quantity, OD.Price
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
INNER JOIN Products P ON OD.ProductID = P.ProductID;

-- 35.

SELECT C.FirstName, C.LastName, P.ProductName, SUM(OD.Quantity * OD.Price) AS TotalSpent
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
INNER JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY C.FirstName, C.LastName, P.ProductName;

-- 36.

SELECT O.OrderID, SUM(OD.Quantity * OD.Price) AS TotalAmount
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY O.OrderID
HAVING SUM(OD.Quantity * OD.Price) > 1000;

-- 37.

SELECT C.CustomerID, C.FirstName, C.LastName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING SUM(O.TotalAmount) > (SELECT AVG(TotalAmount) FROM Orders);

-- 38.

SELECT C.CustomerID, C.FirstName, C.LastName, COUNT(O.OrderID) AS OrderCount
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName;

-- 39.

SELECT OD.ProductID, SUM(OD.Quantity) AS TotalQuantity
FROM OrderDetails OD
GROUP BY OD.ProductID
HAVING SUM(OD.Quantity) > 3;

-- 40.

SELECT C.CustomerID, C.FirstName, C.LastName, O.OrderID, SUM(OD.Quantity) AS TotalProducts
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID, C.FirstName, C.LastName, O.OrderID;
