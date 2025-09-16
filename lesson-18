CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Category VARCHAR(50),
Price DECIMAL(10,2)
);

CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
ProductID INT,
Quantity INT,
SaleDate DATE,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Samsung Galaxy S23', 'Electronics', 899.99),
(2, 'Apple iPhone 14', 'Electronics', 999.99),
(3, 'Sony WH-1000XM5 Headphones', 'Electronics', 349.99),
(4, 'Dell XPS 13 Laptop', 'Electronics', 1249.99),
(5, 'Organic Eggs (12 pack)', 'Groceries', 3.49),
(6, 'Whole Milk (1 gallon)', 'Groceries', 2.99),
(7, 'Alpen Cereal (500g)', 'Groceries', 4.75),
(8, 'Extra Virgin Olive Oil (1L)', 'Groceries', 8.99),
(9, 'Mens Cotton T-Shirt', 'Clothing', 12.99),
(10, 'Womens Jeans - Blue', 'Clothing', 39.99),
(11, 'Unisex Hoodie - Grey', 'Clothing', 29.99),
(12, 'Running Shoes - Black', 'Clothing', 59.95),
(13, 'Ceramic Dinner Plate Set (6 pcs)', 'Home & Kitchen', 24.99),
(14, 'Electric Kettle - 1.7L', 'Home & Kitchen', 34.90),
(15, 'Non-stick Frying Pan - 28cm', 'Home & Kitchen', 18.50),
(16, 'Atomic Habits - James Clear', 'Books', 15.20),
(17, 'Deep Work - Cal Newport', 'Books', 14.35),
(18, 'Rich Dad Poor Dad - Robert Kiyosaki', 'Books', 11.99),
(19, 'LEGO City Police Set', 'Toys', 49.99),
(20, 'Rubiks Cube 3x3', 'Toys', 7.99);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate)
VALUES
(1, 1, 2, '2025-04-01'),
(2, 1, 1, '2025-04-05'),
(3, 2, 1, '2025-04-10'),
(4, 2, 2, '2025-04-15'),
(5, 3, 3, '2025-04-18'),
(6, 3, 1, '2025-04-20'),
(7, 4, 2, '2025-04-21'),
(8, 5, 10, '2025-04-22'),
(9, 6, 5, '2025-04-01'),
(10, 6, 3, '2025-04-11'),
(11, 10, 2, '2025-04-08'),
(12, 12, 1, '2025-04-12'),
(13, 12, 3, '2025-04-14'),
(14, 19, 2, '2025-04-05'),
(15, 20, 4, '2025-04-19'),
(16, 1, 1, '2025-03-15'),
(17, 2, 1, '2025-03-10'),
(18, 5, 5, '2025-02-20'),
(19, 6, 6, '2025-01-18'),
(20, 10, 1, '2024-12-25'),
(21, 1, 1, '2024-04-20');

create table #MonthlySales (
ProductID INT,
TotalQuantity INT,
TotalRevenue DECIMAL(18,2)
);

insert into #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
select A.ProductID,sum(B.Quantity) TotalQuantity,sum(B.Quantity*A.Price) TotalRevenue from Products A
join Sales B on A.ProductID=B.ProductID
group by A.ProductID

select * from #MonthlySales

create view vw_ProductSalesSummary as
select A.ProductID,A.ProductName,A.Category,sum(B.Quantity) as total from Products A
join Sales B on A.ProductID=B.ProductID
group by A.ProductID,A.ProductName,A.Category

select * from dbo.vw_ProductSalesSummary

go

create function dbo.fn_GetTotalRevenueForProduct(@ProductID INT)
returns decimal as
begin
declare @TotalRevenue decimal(18,2)
select @TotalRevenue=sum(A.Price*B.Quantity) from Products A
join Sales B on A.ProductID=B.ProductID
where A.ProductID=@ProductID
return isnull(@TotalRevenue,0)
end

select dbo.fn_GetTotalRevenueForProduct(1) TotalRevenue;
go

create function fn_GetSalesByCategory(@category VARCHAR(50))
returns table as return(
select A.ProductName,sum(B.Quantity) TotalQuantity,sum(A.Price*B.Quantity) TotalRevenue from Products A
join Sales B on A.ProductID=B.ProductID
where A.Category=@category
group by A.ProductName
)

select* from dbo.fn_GetSalesByCategory('Electronics')
go

create function dbo.fn_IsPrime(@Number INT)
returns varchar(3)
begin
declare @i int = 2;
if @Number <= 1
return 'No';

while @i <= sqrt(@Number)
begin
    if @Number % @i = 0
        return 'No';
		set @i+=1
		end
		return 'yes'
		end
		 
		 select dbo.fn_IsPrime(7)
select dbo.fn_IsPrime(9)

go

create function fn_GetNumbersBetween(@start INT, @EnD INT)
returns @numbers table (Number int)
BEGIN
declare @i int = @start;
while @i <= @EnD
begin
insert into @numbers values (@i);
set @i += 1;
end
return
end

select * from dbo.fn_GetNumbersBetween(5, 10);
go

create function getNthHighestSalary(@n INT)
returns table
return
(
select
case
when count(distinct salary) < @n then null
else (
select distinct salary
from Employee
salary DESC
offset (@N-1) rows fetch next 1 rows ONLY
)
end as HighestNSalary

	select * from dbo.getNthHighestSalary(2);

	go

	select  top 1 id, count(*)  num
from (select requester_id id from RequestAccepted
union all
select accepter_id id from RequestAccepted
) AS AllFriends
group by id
order by count(*) DESC;

go

CREATE TABLE Customers (
customer_id INT PRIMARY KEY,
name VARCHAR(100),
city VARCHAR(50)
);

CREATE TABLE Orders (
order_id INT PRIMARY KEY,
customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
order_date DATE,
amount DECIMAL(10,2)
);

-- Customers
INSERT INTO Customers (customer_id, name, city)
VALUES
(1, 'Alice Smith', 'New York'),
(2, 'Bob Jones', 'Chicago'),
(3, 'Carol White', 'Los Angeles');

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2024-12-10', 120.00),
(102, 1, '2024-12-20', 200.00),
(103, 1, '2024-12-30', 220.00),
(104, 2, '2025-01-12', 120.00),
(105, 2, '2025-01-20', 180.00);

go
create view vw_CustomerOrderSummary
as
select A.customer_id,A.name,count(B.order_id) as Total_Order,count(B.amount)as Total_Amount,max(B.order_date) as last_order_date from Customers A
left join Orders B on A.customer_id=B.customer_id
group by A.customer_id,A.name

select * from dbo.vw_CustomerOrderSummary

go

DROP TABLE IF EXISTS Gaps;

CREATE TABLE Gaps
(
RowNumber INTEGER PRIMARY KEY,
TestCase VARCHAR(100) NULL
);

INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,'Charlie'), (11, NULL), (12, NULL)

SELECT
RowNumber,
MAX(TestCase) OVER (
ORDER BY RowNumber
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS Workflow
FROM Gaps
ORDER BY RowNumber;

