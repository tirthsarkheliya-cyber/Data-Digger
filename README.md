[README (8).md](https://github.com/user-attachments/files/32849320/README.8.md)
# DataDiggerDB – MySQL CRUD & Aggregation Practice

A hands-on MySQL project that builds a small e-commerce database (`DataDiggerDB`) and practices core SQL: table creation, constraints, foreign keys, CRUD operations, filtering, sorting, subqueries and aggregate functions.

---

## 📌 Problem Statement

Design and implement a simple online-store database in MySQL with four related tables – **Customers**, **Orders**, **Products** and **OrderDetails** – and perform the following tasks:

1. Create the database and tables with proper primary keys, unique/not-null constraints and foreign keys (with `ON DELETE CASCADE`).
2. Insert at least 5 sample records into each table.
3. Perform **Insert, Select, Update and Delete** operations on every table.
4. Retrieve data using conditions (`WHERE`, `BETWEEN`, date arithmetic), sorting (`ORDER BY`) and subqueries.
5. Analyse the data using aggregate functions (`MAX`, `MIN`, `AVG`, `SUM`, `COUNT`) and `GROUP BY` with `LIMIT`.

---

## 🎯 Objective

- Understand relational database design and table relationships.
- Enforce data integrity using `PRIMARY KEY`, `AUTO_INCREMENT`, `UNIQUE`, `NOT NULL` and `FOREIGN KEY ... ON DELETE CASCADE`.
- Practise all CRUD operations in MySQL.
- Write analytical queries to get business insights such as total revenue, top-selling products, and recent orders.

---

## 🗂️ Database Schema

| Table | Columns | Notes |
|-------|---------|-------|
| **Customers** | `CustomerID` (PK, AI), `Name`, `Email` (UNIQUE), `Address` | Stores customer details |
| **Orders** | `OrderID` (PK, AI), `CustomerID` (FK), `OrderDate`, `TotalAmount` | FK → Customers, cascade delete |
| **Products** | `ProductID` (PK, AI), `ProductName`, `Price`, `Stock` | Product catalogue |
| **OrderDetails** | `OrderDetailID` (PK, AI), `OrderID` (FK), `ProductID` (FK), `Quantity`, `SubTotal` | FK → Orders & Products, cascade delete |

**Relationships**

```
Customers (1) ────< Orders (1) ────< OrderDetails >──── (1) Products
```

---

## 🔄 Program Flow

```
Start
  │
  ├─► 1. Create & select database ............ CREATE DATABASE / USE DataDiggerDB
  │       (first attempts failed with ERROR 1046 – "No database selected")
  │
  ├─► 2. Customers table
  │       ├─ CREATE TABLE Customers
  │       ├─ INSERT 5 customers
  │       ├─ SELECT * (view all)
  │       ├─ UPDATE address of CustomerID = 2
  │       ├─ DELETE CustomerID = 5
  │       └─ SELECT customer WHERE Name = 'Alice'
  │
  ├─► 3. Orders table
  │       ├─ CREATE TABLE Orders (FK → Customers)
  │       ├─ INSERT 5 orders (dates relative to CURRENT_DATE)
  │       ├─ SELECT orders of CustomerID = 1
  │       ├─ UPDATE TotalAmount of OrderID = 1
  │       ├─ DELETE OrderID = 4
  │       ├─ SELECT orders from the last 30 days
  │       └─ MAX / MIN / AVG of TotalAmount
  │
  ├─► 4. Products table
  │       ├─ CREATE TABLE Products
  │       ├─ INSERT 5 products
  │       ├─ SELECT ... ORDER BY Price DESC
  │       ├─ UPDATE price of ProductID = 2
  │       ├─ DELETE out-of-stock products (Stock = 0)
  │       ├─ SELECT products WHERE Price BETWEEN 500 AND 2000
  │       └─ SELECT most & least expensive product (subqueries)
  │
  ├─► 5. OrderDetails table
  │       ├─ CREATE TABLE OrderDetails (FK → Orders, Products)
  │       ├─ INSERT 5 order-detail rows
  │       ├─ SELECT details of OrderID = 1
  │       ├─ SUM(SubTotal) → Total Revenue
  │       ├─ GROUP BY ProductID → Top 3 products by quantity
  │       └─ COUNT(*) → times ProductID = 1 was sold
  │
End
```

---

## ▶️ How to Run

1. Install MySQL and open the MySQL command-line client:
   ```bash
   mysql -u root -p
   ```
2. Run the script:
   ```sql
   SOURCE path/to/Tirth_1.sql;
   ```
   > The file is a saved terminal session (contains `mysql>` prompts). To run it directly, copy only the SQL statements into a clean `.sql` file first.
3. Make sure the database is created and selected **before** creating tables:
   ```sql
   CREATE DATABASE IF NOT EXISTS DataDiggerDB;
   USE DataDiggerDB;
   ```

---

## 🖼️ Output Screenshots

> Save your terminal screenshots in an `images/` folder with the names below, and they will show up here.

### 1. Database & Customers table
![Customers Output](images/customers_output.png)

### 2. Orders table & aggregate results
![Orders Output](images/orders_output.png)

### 3. Products table
![Products Output](images/products_output.png)

### 4. OrderDetails & analytics
![OrderDetails Output](images/orderdetails_output.png)

---

## 📊 Key Results (from the run)

| Query | Result |
|-------|--------|
| Highest / Lowest / Average order amount | 2200.00 / 850.50 / 1475.125 |
| Orders in last 30 days | 3 orders (OrderID 1, 2, 5) |
| Products priced 500–2000 | Mechanical Keyboard (1700), USB-C Cable (600) |
| Most / least expensive product | Gaming Monitor (12500) / Wireless Mouse (450) |
| Total revenue | 16150.00 |
| Top-selling product | ProductID 1 (Wireless Mouse) – 3 units |
| Times ProductID 1 was sold | 2 |

---

## 🧰 Concepts Covered

- `CREATE DATABASE`, `USE`, `CREATE TABLE`
- Constraints: `PRIMARY KEY`, `AUTO_INCREMENT`, `UNIQUE`, `NOT NULL`, `FOREIGN KEY`, `ON DELETE CASCADE`
- DML: `INSERT`, `SELECT`, `UPDATE`, `DELETE`
- Filtering & sorting: `WHERE`, `BETWEEN`, `ORDER BY`, `LIMIT`
- Date functions: `CURRENT_DATE`, `INTERVAL`
- Aggregates: `MAX`, `MIN`, `AVG`, `SUM`, `COUNT`, `GROUP BY`
- Subqueries

---

## 👤 Author

**Tirth**
Course / Assignment: MySQL Database Practice (DataDiggerDB)

---

## 📝 Notes

- The first two `CREATE TABLE` and the first `INSERT` attempts failed with `ERROR 1046 (3D000): No database selected`; they succeeded after creating and selecting `DataDiggerDB`.
- Deleting a customer or order also removes related rows because of `ON DELETE CASCADE`.
- Order dates use `CURRENT_DATE - INTERVAL n DAY`, so date values change depending on when the script is run.
