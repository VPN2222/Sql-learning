create database leson20h
use leson20h

CREATE TABLE #Sales (
SaleID INT PRIMARY KEY IDENTITY(1,1),
CustomerName VARCHAR(100),
Product VARCHAR(100),
Quantity INT,
Price DECIMAL(10,2),
SaleDate DATE
);

INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');

select * from #Sales
where exists(
select * from #Sales B
where B.SaleDate >= '2024-03-01'
AND B.SaleDate < '2024-04-01'
)

select * from #Sales A
where A.Price=(select max(Price) from #Sales B where A.Product=B.Product)

select * from #Sales A
where A.Price<(select max(Price) from #Sales B )

select DATENAME(MONTH,A.SaleDate) as Month,year(A.SaleDate) as Years,sum(A.Price) as Price from #Sales A
group by year(A.SaleDate),month(A.SaleDate),DATENAME(MONTH,A.SaleDate)

select * from #Sales
where exists(
select * from #Sales A
join #Sales B on A.Product=B.Product
where A.SaleID=B.SaleID and A.Product<>B.Product
)

create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'),
('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'),
('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'),
('Mario', 'Orange')

						select Name, 
						sum(case when Fruit ='Apple' then 1 else 0 end) as Apple, 
						sum(case when Fruit='Orange' then 1 else 0 end)as Orange,
						sum(case when Fruit='Banana' then 1 else 0 end) as Banana
						from Fruits 
					 group by Name
						
						

 create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)

select ch.ChildID,P.ParentId from Family P
join Family ch on P.ChildID=ch.ParentId

with FamilyCTE as (
select ParentId,ChildID from Family
union all
select f.ParentId, c.ChildID from Family f
join FamilyCTE c on f.ChildID = c.ParentId
)
select distinct ParentId OlderPerson, ChildID YoungerPerson from FamilyCTE;

CREATE TABLE #Orders
(
CustomerID INTEGER,
OrderID INTEGER,
DeliveryState VARCHAR(100) NOT NULL,
Amount MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);

INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);

select distinct A.CustomerID,A.OrderID,A.DeliveryState from #Orders A
where A.DeliveryState='CA' or A.DeliveryState='TX'

create table #residents(resid int identity, fullname varchar(50), address varchar(100))

insert into #residents values
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')

update r
set fullname = substring(
r.address,
charindex('name=', r.address) + 5,
charindex(' ', r.address + ' ', charindex('name=', r.address))
- (CHARINDEX('name=', r.address) + 5)
)
from #residents r
where fullname is null or fullname = '';

CREATE TABLE #Routes
(
RouteID INTEGER NOT NULL,
DepartureCity VARCHAR(30) NOT NULL,
ArrivalCity VARCHAR(30) NOT NULL,
Cost MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);

select * from #Routes
go
;WITH cte AS (
SELECT *
FROM #Routes
WHERE DepartureCity = 'Tashkent' AND ArrivalCity = 'Khorezm'
)
SELECT TOP 1 'Cheapest' AS RouteType, RouteID, DepartureCity, ArrivalCity, Cost
FROM cte
ORDER BY Cost ASC

UNION ALL

SELECT TOP 1 'Most Expensive' AS RouteType, RouteID, DepartureCity, ArrivalCity, Cost
FROM #Routes
ORDER BY Cost DESC;

CREATE TABLE #RankingPuzzle
(
ID INT
,Vals VARCHAR(10)
)

INSERT INTO #RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')

select *,DENSE_RANK() over (order by (select null)) from #RankingPuzzle

CREATE TABLE #EmployeeSales (
EmployeeID INT PRIMARY KEY IDENTITY(1,1),
EmployeeName VARCHAR(100),
Department VARCHAR(50),
SalesAmount DECIMAL(10,2),
SalesMonth INT,
SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);

select * from #EmployeeSales A
where SalesAmount>(select avg(SalesAmount) from #EmployeeSales B where A.Department=B.Department)

select * from #EmployeeSales A
where SalesAmount=(select max(SalesAmount) from #EmployeeSales B where A.SalesMonth=B.SalesMonth)

CREATE TABLE Products (
ProductID INT PRIMARY KEY,
Name VARCHAR(50),
Category VARCHAR(50),
Price DECIMAL(10,2),
Stock INT
);

INSERT INTO Products (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);

-- Faraz qilamiz jadval: #Sales(EmployeeID, SaleDate, Amount)
-- Har bir oy bo‘yicha barcha xodimlarni tekshirish
SELECT DISTINCT s.EmployeeID
FROM #Sales s
WHERE NOT EXISTS (
SELECT 1
FROM (
SELECT DISTINCT MONTH(SaleDate) AS MonthNum
FROM #Sales
) m
WHERE NOT EXISTS (
SELECT 1 FROM #Sales s2
WHERE s2.EmployeeID = s.EmployeeID AND MONTH(s2.SaleDate) = m.MonthNum
)
);

SELECT ProductName, StockCount
FROM Products
WHERE StockCount < (SELECT MAX(StockCount) FROM Products);

SELECT ProductName
FROM Products
WHERE CategoryID = (
SELECT CategoryID
FROM Products
WHERE ProductName = 'Laptop'
)

SELECT ProductName, Price
FROM Products
WHERE Price > (
SELECT MIN(Price)
FROM Products
WHERE Category = 'Electronics'
)

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
ProductID INT,
Quantity INT,
OrderDate DATE,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');

SELECT DISTINCT p.ProductName
FROM Products p
WHERE EXISTS (
SELECT 1
FROM Orders o
WHERE o.ProductID = p.ProductID
);

SELECT p.ProductName
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductName
HAVING SUM(o.Quantity) > (
SELECT AVG(TotalQty)
FROM (
SELECT SUM(Quantity) AS TotalQty
FROM Orders
GROUP BY ProductID
) AS Sub
);

SELECT TOP 1 p.ProductName, SUM(o.Quantity) AS TotalQuantity
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantity DESC;
