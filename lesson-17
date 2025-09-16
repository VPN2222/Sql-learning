DROP TABLE IF EXISTS #RegionSales;
GO

CREATE TABLE #RegionSales (
Region VARCHAR(100),
Distributor VARCHAR(100),
Sales INTEGER NOT NULL,
PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

SELECT R.Region,D.Distributor,COALESCE(S.Sales, 0) Sales from (select distinct Region from #RegionSales) R
cross join (select distinct Distributor from #RegionSales) D
left join #RegionSales S on S.Region = R.Region and S.Distributor = D.Distributor
where not( S.Sales=0)
order by R.Region, D.Distributor;

CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

select top 1 B.name from Employee A
join Employee B on A.managerId=B.id
where B.id>5

CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

select A.product_name,sum(B.unit) from Products A
join Orders B on A.product_id=B.product_id
where year(B.order_date)=2020 and month(B.order_date)=2
group by A.product_name
having sum(B.unit)>=100

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
OrderID INTEGER PRIMARY KEY,
CustomerID INTEGER NOT NULL,
[Count] MONEY NOT NULL,
Vendor VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

select * from Orders
select distinct A.CustomerID, A.Vendor from Orders A
inner join Orders B on A.CustomerID=B.CustomerID

select CustomerID, Vendor
from (
select
CustomerID,
Vendor,
count() AS order_count,
rank() over (partition by CustomerID order by count() desc) rnk
from Orders
group by CustomerID, Vendor
) t
WHERE rnk = 1;

CREATE TABLE Device(
Device_id INT,
Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

go
with signal_counts as (
select Device_id, Locations, count(*) AS A from Device
group by Device_id, Locations
)
select Device_id,
count(distinct Locations) no_of_location,
(select top 1 Locations from signal_counts B
where B.Device_id = C.Device_id order by A desc) max_signal_location,
sum(A) no_of_signals
from signal_counts C
group by Device_id

CREATE TABLE Employee (
EmpID INT,
EmpName VARCHAR(30),
Salary FLOAT,
DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);

select A.EmpID,A.EmpName,A.Salary from Employee A
where A.Salary>(select avg(Salary) from Employee B where A.EmpID=B.EmpID )

CREATE TABLE Spending (
User_id INT,
Spend_date DATE,
Platform VARCHAR(10),
Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);

WITH UserDevice AS (
SELECT
User_id,
Spend_date,
SUM(CASE WHEN Platform = 'Mobile' THEN Amount ELSE 0 END) AS MobileAmount,
SUM(CASE WHEN Platform = 'Desktop' THEN Amount ELSE 0 END) AS DesktopAmount
FROM Spending
GROUP BY User_id, Spend_date
),
Aggregated AS (
SELECT
Spend_date,
CASE
WHEN MobileAmount > 0 AND DesktopAmount = 0 THEN 'Mobile'
WHEN DesktopAmount > 0 AND MobileAmount = 0 THEN 'Desktop'
WHEN MobileAmount > 0 AND DesktopAmount > 0 THEN 'Both'
END AS PlatformType,
(MobileAmount + DesktopAmount) AS TotalAmount
FROM UserDevice
)
SELECT
Spend_date,
PlatformType AS Platform,
SUM(TotalAmount) AS Total_Amount,
COUNT(*) AS Total_users
FROM Aggregated
GROUP BY Spend_date, PlatformType
ORDER BY Spend_date, PlatformType;

go

DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
Product VARCHAR(100) PRIMARY KEY,
Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);
