--# 🟢 Easy-Level Tasks

--## 1. Define and explain the purpose of BULK INSERT in SQL Server
--```sql
-- BULK INSERT is used to efficiently import large amounts of data from external files (like CSV, TXT) into SQL Server tables.
-- It is much faster than manual row-by-row insertion.


## 2. List four file formats that can be imported into SQL Server
```sql
-- Common file formats:
-- 1. CSV (Comma-Separated Values)
-- 2. TXT (Text Files, often tab-delimited)
-- 3. XLS/XLSX (Excel Files)
-- 4. XML (Extensible Markup Language)
--## 3. Create a table Products
--```sql
CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Price DECIMAL(10,2)
);

--## 4. Insert three records into the Products table
--```sql
INSERT INTO Products (ProductID, ProductName, Price)
VALUES
(1, 'Akbarshoh', 2423423.00),
(2, 'Nodirshoh', 242424.00),
(3, 'Ikromshoh', 324234.00);

--## 5. Explain the difference between NULL and NOT NULL
--```sql
-- NULL means the value is missing or unknown. It represents empty information in a table.
-- NOT NULL means the column must always contain a value; you cannot leave it empty.

--## 6. Add a UNIQUE constraint to the ProductName column
--```sql
ALTER TABLE Products
ADD CONSTRAINT UQ_Products_ProductName UNIQUE (ProductName);

--## 7. Write a comment in a SQL query explaining its purpose
--```sql
-- This query selects all records from the Products table
SELECT * FROM Products;

--## 8. Add CategoryID column to the Products table
--```sql
ALTER TABLE Products
ADD CategoryID INT;

--## 9. Create Categories table with constraints
--```sql
CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50) UNIQUE
);

--## 10. Explain the purpose of the IDENTITY column in SQL Server
--```sql
-- The IDENTITY column automatically generates unique, sequential numeric values for each new row.
-- Commonly used for primary keys, so you don't have to manually enter each value.

--# 🟠 Medium-Level Tasks

--## 1. Use BULK INSERT to import data from a text file into the Products table
--```sql
-- Example: Import CSV data from 'C:\Data\products.txt' into Products
BULK INSERT Products
FROM 'C:\Data\products.txt'
WITH (
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2 -- If first row contains headers
);

--## 2. Create a FOREIGN KEY in Products referencing Categories
--```sql
ALTER TABLE Products
ADD CONSTRAINT FK_Products_CategoryID FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);

--## 3. Explain the differences between PRIMARY KEY and UNIQUE KEY
--```sql
-- PRIMARY KEY:
-- - Uniquely identifies each row in the table.
-- - Only one allowed per table.
-- - Cannot be NULL.

-- UNIQUE KEY:
-- - Ensures all values in the column are unique.
-- - Multiple UNIQUE constraints allowed per table.
-- - Allows NULL values (but only one NULL per column).


--## 4. Add a CHECK constraint ensuring Price > 0
--```sql
ALTER TABLE Products
ADD CONSTRAINT chk_price_positive CHECK (Price > 0);


--## 5. Modify Products table to add Stock column (INT, NOT NULL)
--```sql
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;


--## 6. Use ISNULL to replace NULL values in Price column with 0
--```sql
SELECT ISNULL(Price, 0) AS Price
FROM Products;


--## 7. Describe the purpose and usage of FOREIGN KEY constraints in SQL Server
--```sql
-- FOREIGN KEY constraints link a column in one table to a column in another table.
-- They enforce referential integrity, ensuring valid relationships between tables.
-- Example: Orders.CustomerID is a FOREIGN KEY referencing Customers.CustomerID.


---

--# 🔴 Hard-Level Tasks

--## 1. Create Customers table with CHECK constraint (Age >= 18)
--```sql
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Age INT CHECK (Age >= 18)
);


--## 2. Create a table with an IDENTITY column starting at 100, incrementing by 10
--```sql
CREATE TABLE ExampleTable (
    ID INT IDENTITY(100, 10) PRIMARY KEY
);


--## 3. Create a composite PRIMARY KEY in OrderDetails table
--```sql
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);


--## 4. Explain the use of COALESCE and ISNULL for handling NULL values
--```sql
-- ISNULL(expression, replacement_value):
--   - Returns replacement_value if expression is NULL; otherwise returns expression.
--   - Example: ISNULL(Price, 0)

-- COALESCE(expression1, expression2, ..., expressionN):
--   - Returns the first non-NULL value from the list.
--   - Example: COALESCE(HomePhone, MobilePhone, 'No phone')


--## 5. Create Employees table with PRIMARY KEY and UNIQUE KEY on Email
--```sql
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Email VARCHAR(255) UNIQUE
);


--## 6. Create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE
--```sql
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
