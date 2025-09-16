create database lesson19h
use lesson19h

CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
FirstName NVARCHAR(50),
LastName NVARCHAR(50),
Department NVARCHAR(50),
Salary DECIMAL(10,2)
);

CREATE TABLE DepartmentBonus (
Department NVARCHAR(50) PRIMARY KEY,
BonusPercentage DECIMAL(5,2)
);

INSERT INTO Employees VALUES
(1, 'John', 'Doe', 'Sales', 5000),
(2, 'Jane', 'Smith', 'Sales', 5200),
(3, 'Mike', 'Brown', 'IT', 6000),
(4, 'Anna', 'Taylor', 'HR', 4500);

INSERT INTO DepartmentBonus VALUES
('Sales', 10),
('IT', 15),
('HR', 8);

go
create proc GetEmployeeBonusData
as begin
select A.EmployeeID,CONCAT(A.FirstName,' ',A.LastName) FullNAme,A.Salary*B.BonusPercentage/100 BonusAmount from Employees A
join DepartmentBonus B on A.Department=B.Department
end

exec GetEmployeeBonusData;
go

create proc DepartmentByUpdateSalary(@depatrmentN varchar(50), @IncreaseProcentage decimal(10,2) )
as begin
update Employees
set Salary=(Salary+ @IncreaseProcentage/100)
where Department =@depatrmentN
select EmployeeID,CONCAT(FirstName,' ',LastName) as fullName,Department,Salary from Employees
where Department=@depatrmentN
end

select * from Employees
EXEC DepartmentByUpdateSalary @depatrmentN = 'Sales', @IncreaseProcentage = 5;

CREATE TABLE Products_Current (
ProductID INT PRIMARY KEY,
ProductName NVARCHAR(100),
Price DECIMAL(10,2)
);

CREATE TABLE Products_New (
ProductID INT PRIMARY KEY,
ProductName NVARCHAR(100),
Price DECIMAL(10,2)
);

INSERT INTO Products_Current VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 600),
(3, 'Smartphone', 800);

INSERT INTO Products_New VALUES
(2, 'Tablet Pro', 700),
(3, 'Smartphone', 850),
(4, 'Smartwatch', 300);

MERGE Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID

WHEN MATCHED THEN
UPDATE SET
target.ProductName = source.ProductName,
target.Price = source.Price

WHEN NOT MATCHED BY TARGET THEN
INSERT (ProductID, ProductName, Price)
VALUES (source.ProductID, source.ProductName, source.Price)

WHEN NOT MATCHED BY SOURCE THEN
DELETE;

-- MERGE tugagach final state ni ko‘rish
SELECT * FROM Products_Current;

CREATE TABLE Tree (
id INT PRIMARY KEY,
p_id INT
);

SELECT
A.id,
case
when A.p_id is null then 'Root'
when A.id in (select p_id from Tree WHERE p_id IS NOT NULL) THEN 'Inner'
else 'Leaf'
end as NodeType
from Tree A

CREATE TABLE Signups (user_id INT, time_stamp DATETIME);
CREATE TABLE Confirmations (user_id INT, time_stamp DATETIME, action ENUM('confirmed','timeout'));

TRUNCATE TABLE Signups;
INSERT INTO Signups (user_id, time_stamp) VALUES
(3, '2020-03-21 10:16:13'),
(7, '2020-01-04 13:57:59'),
(2, '2020-07-29 23:09:44'),
(6, '2020-12-09 10:39:37');

TRUNCATE TABLE Confirmations;
INSERT INTO Confirmations (user_id, time_stamp, action) VALUES
(3, '2021-01-06 03:30:46', 'timeout'),
(3, '2021-07-14 14:00:00', 'timeout'),
(7, '2021-06-12 11:57:29', 'confirmed'),
(7, '2021-06-13 12:58:28', 'confirmed'),
(7, '2021-06-14 13:59:27', 'confirmed'),
(2, '2021-01-22 00:00:00', 'confirmed'),
(2, '2021-02-28 23:59:59', 'timeout');

SELECT
s.user_id,
COALESCE(
ROUND(
1.0 * SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END)
/ NULLIF(COUNT(c.user_id), 0),
2),
0) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
ON s.user_id = c.user_id
GROUP BY s.user_id;

CREATE TABLE employees1 (
id INT PRIMARY KEY,
name VARCHAR(100),
salary DECIMAL(10,2)
);

INSERT INTO employees1 (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);

select * from employees1
where salary=(select min(salary) from employees1)

-- Products Table
CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName NVARCHAR(100),
Category NVARCHAR(50),
Price DECIMAL(10,2)
);

-- Sales Table
CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
Quantity INT,
SaleDate DATE
);

INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(1, 'Laptop Model A', 'Electronics', 1200),
(2, 'Laptop Model B', 'Electronics', 1500),
(3, 'Tablet Model X', 'Electronics', 600),
(4, 'Tablet Model Y', 'Electronics', 700),
(5, 'Smartphone Alpha', 'Electronics', 800),
(6, 'Smartphone Beta', 'Electronics', 850),
(7, 'Smartwatch Series 1', 'Wearables', 300),
(8, 'Smartwatch Series 2', 'Wearables', 350),
(9, 'Headphones Basic', 'Accessories', 150),
(10, 'Headphones Pro', 'Accessories', 250),
(11, 'Wireless Mouse', 'Accessories', 50),
(12, 'Wireless Keyboard', 'Accessories', 80),
(13, 'Desktop PC Standard', 'Computers', 1000),
(14, 'Desktop PC Gaming', 'Computers', 2000),
(15, 'Monitor 24 inch', 'Displays', 200),
(16, 'Monitor 27 inch', 'Displays', 300),
(17, 'Printer Basic', 'Office', 120),
(18, 'Printer Pro', 'Office', 400),
(19, 'Router Basic', 'Networking', 70),
(20, 'Router Pro', 'Networking', 150);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate) VALUES
(1, 1, 2, '2024-01-15'),
(2, 1, 1, '2024-02-10'),
(3, 1, 3, '2024-03-08'),
(4, 2, 1, '2024-01-22'),
(5, 3, 5, '2024-01-20'),
(6, 5, 2, '2024-02-18'),
(7, 5, 1, '2024-03-25'),
(8, 6, 4, '2024-04-02'),
(9, 7, 2, '2024-01-30'),
(10, 7, 1, '2024-02-25'),
(11, 7, 1, '2024-03-15'),
(12, 9, 8, '2024-01-18'),
(13, 9, 5, '2024-02-20'),
(14, 10, 3, '2024-03-22'),
(15, 11, 2, '2024-02-14'),
(16, 13, 1, '2024-03-10'),
(17, 14, 2, '2024-03-22'),
(18, 15, 5, '2024-02-01'),
(19, 15, 3, '2024-03-11'),
(20, 19, 4, '2024-04-01');

go
create proc GetProductSalesSummary
@ProductID int
as
begin
select
p.ProductName,
SUM(s.Quantity) TotalQuantitySold,
SUM(s.Quantity * p.Price) TotalSalesAmount,
MIN(s.SaleDate) FirstSaleDate,
MAX(s.SaleDate) LastSaleDate
from Products p
left JOIN Sales s
on p.ProductID = s.ProductID
where p.ProductID = @ProductID
group by p.ProductName;
end
