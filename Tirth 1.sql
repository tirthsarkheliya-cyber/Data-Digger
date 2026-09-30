

mysql> CREATE TABLE Customers (
    ->     CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Name VARCHAR(100) NOT NULL,
    ->     Email VARCHAR(100) UNIQUE NOT NULL,
    ->     Address VARCHAR(255) NOT NULL
    -> );
ERROR 1046 (3D000): No database selected
mysql> CREATE TABLE Customers (
    ->     CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Name VARCHAR(100) NOT NULL,
    ->     Email VARCHAR(100) UNIQUE NOT NULL,
    ->     Address VARCHAR(255) NOT NULL
    -> );
ERROR 1046 (3D000): No database selected
mysql>
mysql> -- Query 1: Insert at least 5 sample customers
mysql> INSERT INTO Customers (Name, Email, Address) VALUES
    -> ('Alice', 'alice@example.com', '123 Elm St, NY'),
    -> ('Bob Smith', 'bob@example.com', '456 Oak St, CA'),
    -> ('Charlie Brown', 'charlie@example.com', '789 Pine St, TX'),
    -> ('David Miller', 'david@example.com', '321 Maple St, FL'),
    -> ('Eva Green', 'eva@example.com', '654 Cedar St, WA');
ERROR 1046 (3D000): No database selected
mysql> CREATE DATABASE IF NOT EXISTS DataDiggerDB;
Query OK, 1 row affected (0.32 sec)

mysql> USE DataDiggerDB;
Database changed
mysql> CREATE TABLE Customers (
    ->     CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Name VARCHAR(100) NOT NULL,
    ->     Email VARCHAR(100) UNIQUE NOT NULL,
    ->     Address VARCHAR(255) NOT NULL
    -> );
Query OK, 0 rows affected (0.32 sec)

mysql>
mysql> INSERT INTO Customers (Name, Email, Address) VALUES
    -> ('Alice', 'alice@example.com', '123 Elm St, NY'),
    -> ('Bob Smith', 'bob@example.com', '456 Oak St, CA'),
    -> ('Charlie Brown', 'charlie@example.com', '789 Pine St, TX'),
    -> ('David Miller', 'david@example.com', '321 Maple St, FL'),
    -> ('Eva Green', 'eva@example.com', '654 Cedar St, WA');
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Customers;
+------------+---------------+---------------------+------------------+
| CustomerID | Name          | Email               | Address          |
+------------+---------------+---------------------+------------------+
|          1 | Alice         | alice@example.com   | 123 Elm St, NY   |
|          2 | Bob Smith     | bob@example.com     | 456 Oak St, CA   |
|          3 | Charlie Brown | charlie@example.com | 789 Pine St, TX  |
|          4 | David Miller  | david@example.com   | 321 Maple St, FL |
|          5 | Eva Green     | eva@example.com     | 654 Cedar St, WA |
+------------+---------------+---------------------+------------------+
5 rows in set (0.01 sec)

mysql> UPDATE Customers
    -> SET Address = '999 Sunset Blvd, CA'
    -> WHERE CustomerID = 2;
Query OK, 1 row affected (0.02 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE FROM Customers
    -> WHERE CustomerID = 5;
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM Customers
    -> WHERE Name = 'Alice';
+------------+-------+-------------------+----------------+
| CustomerID | Name  | Email             | Address        |
+------------+-------+-------------------+----------------+
|          1 | Alice | alice@example.com | 123 Elm St, NY |
+------------+-------+-------------------+----------------+
1 row in set (0.00 sec)

mysql> CREATE TABLE Orders (
    ->     OrderID INT PRIMARY KEY AUTO_INCREMENT,
    ->     CustomerID INT,
    ->     OrderDate DATE NOT NULL,
    ->     TotalAmount DECIMAL(10, 2) NOT NULL,
    ->     FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
    -> );
Query OK, 0 rows affected (0.47 sec)

mysql> INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
    -> (1, CURRENT_DATE - INTERVAL 5 DAY, 1500.00),
    -> (2, CURRENT_DATE - INTERVAL 10 DAY, 850.50),
    -> (3, CURRENT_DATE - INTERVAL 40 DAY, 2200.00),
    -> (1, CURRENT_DATE - INTERVAL 15 DAY, 600.00),
    -> (4, CURRENT_DATE - INTERVAL 2 DAY, 1200.00);
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Orders
    -> WHERE CustomerID = 1;
+---------+------------+------------+-------------+
| OrderID | CustomerID | OrderDate  | TotalAmount |
+---------+------------+------------+-------------+
|       1 |          1 | 2026-09-24 |     1500.00 |
|       4 |          1 | 2026-09-14 |      600.00 |
+---------+------------+------------+-------------+
2 rows in set (0.01 sec)

mysql> UPDATE Orders
    -> SET TotalAmount = 1650.00
    -> WHERE OrderID = 1;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE FROM Orders
    -> WHERE OrderID = 4;
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM Orders
    -> WHERE OrderDate >= CURRENT_DATE - INTERVAL 30 DAY;
+---------+------------+------------+-------------+
| OrderID | CustomerID | OrderDate  | TotalAmount |
+---------+------------+------------+-------------+
|       1 |          1 | 2026-09-24 |     1650.00 |
|       2 |          2 | 2026-09-19 |      850.50 |
|       5 |          4 | 2026-09-27 |     1200.00 |
+---------+------------+------------+-------------+
3 rows in set (0.01 sec)

mysql> SELECT
    ->     MAX(TotalAmount) AS HighestOrderAmount,
    ->     MIN(TotalAmount) AS LowestOrderAmount,
    ->     AVG(TotalAmount) AS AverageOrderAmount
    -> FROM Orders;
+--------------------+-------------------+--------------------+
| HighestOrderAmount | LowestOrderAmount | AverageOrderAmount |
+--------------------+-------------------+--------------------+
|            2200.00 |            850.50 |        1475.125000 |
+--------------------+-------------------+--------------------+
1 row in set (0.02 sec)

mysql> CREATE TABLE Products (
    ->     ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ->     ProductName VARCHAR(100) NOT NULL,
    ->     Price DECIMAL(10, 2) NOT NULL,
    ->     Stock INT NOT NULL
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> INSERT INTO Products (ProductName, Price, Stock) VALUES
    -> ('Wireless Mouse', 450.00, 25),
    -> ('Mechanical Keyboard', 1800.00, 15),
    -> ('Gaming Monitor', 12500.00, 8),
    -> ('USB-C Cable', 600.00, 50),
    -> ('Bluetooth Speaker', 1950.00, 0);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Products
    -> ORDER BY Price DESC;
+-----------+---------------------+----------+-------+
| ProductID | ProductName         | Price    | Stock |
+-----------+---------------------+----------+-------+
|         3 | Gaming Monitor      | 12500.00 |     8 |
|         5 | Bluetooth Speaker   |  1950.00 |     0 |
|         2 | Mechanical Keyboard |  1800.00 |    15 |
|         4 | USB-C Cable         |   600.00 |    50 |
|         1 | Wireless Mouse      |   450.00 |    25 |
+-----------+---------------------+----------+-------+
5 rows in set (0.01 sec)

mysql> UPDATE Products
    -> SET Price = 1700.00
    -> WHERE ProductID = 2;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE FROM Products
    -> WHERE Stock = 0;
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM Products
    -> WHERE Price BETWEEN 500 AND 2000;
+-----------+---------------------+---------+-------+
| ProductID | ProductName         | Price   | Stock |
+-----------+---------------------+---------+-------+
|         2 | Mechanical Keyboard | 1700.00 |    15 |
|         4 | USB-C Cable         |  600.00 |    50 |
+-----------+---------------------+---------+-------+
2 rows in set (0.01 sec)

mysql> SELECT * FROM Products
    -> WHERE Price = (SELECT MAX(Price) FROM Products)
    ->    OR Price = (SELECT MIN(Price) FROM Products);
+-----------+----------------+----------+-------+
| ProductID | ProductName    | Price    | Stock |
+-----------+----------------+----------+-------+
|         1 | Wireless Mouse |   450.00 |    25 |
|         3 | Gaming Monitor | 12500.00 |     8 |
+-----------+----------------+----------+-------+
2 rows in set (0.00 sec)

mysql> CREATE TABLE OrderDetails (
    ->     OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    ->     OrderID INT,
    ->     ProductID INT,
    ->     Quantity INT NOT NULL,
    ->     SubTotal DECIMAL(10, 2) NOT NULL,
    ->     FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    ->     FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal) VALUES
    -> (1, 1, 2, 900.00),
    -> (1, 2, 1, 1700.00),
    -> (2, 4, 1, 600.00),
    -> (3, 3, 1, 12500.00),
    -> (5, 1, 1, 450.00);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM OrderDetails
    -> WHERE OrderID = 1;
+---------------+---------+-----------+----------+----------+
| OrderDetailID | OrderID | ProductID | Quantity | SubTotal |
+---------------+---------+-----------+----------+----------+
|             1 |       1 |         1 |        2 |   900.00 |
|             2 |       1 |         2 |        1 |  1700.00 |
+---------------+---------+-----------+----------+----------+
2 rows in set (0.00 sec)

mysql> SELECT SUM(SubTotal) AS TotalRevenue
    -> FROM OrderDetails;
+--------------+
| TotalRevenue |
+--------------+
|     16150.00 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT
    ->     ProductID,
    ->     SUM(Quantity) AS TotalQuantityOrdered
    -> FROM OrderDetails
    -> GROUP BY ProductID
    -> ORDER BY TotalQuantityOrdered DESC
    -> LIMIT 3;
+-----------+----------------------+
| ProductID | TotalQuantityOrdered |
+-----------+----------------------+
|         1 |                    3 |
|         2 |                    1 |
|         3 |                    1 |
+-----------+----------------------+
3 rows in set (0.01 sec)

mysql> SELECT COUNT(*) AS TimesSold
    -> FROM OrderDetails
    -> WHERE ProductID = 1;
+-----------+
| TimesSold |
+-----------+
|         2 |
+-----------+
1 row in set (0.00 sec)

mysql>