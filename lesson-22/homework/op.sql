create database lesson22H

CREATE TABLE sales_data (
sale_id INT PRIMARY KEY,
customer_id INT,
customer_name VARCHAR(100),
product_category VARCHAR(50),
product_name VARCHAR(100),
quantity_sold INT,
unit_price DECIMAL(10,2),
total_amount DECIMAL(10,2),
order_date DATE,
region VARCHAR(50)
);

INSERT INTO sales_data VALUES
(1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
(2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
(3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
(4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
(5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
(6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
(7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
(8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
(9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
(10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
(11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
(12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
(13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
(14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
(15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
(16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
(17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
(18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
(19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
(20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
(21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
(22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
(23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
(24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
(25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')

select *,sum(unit_price) over (partition by customer_id order by (select null)) as running_total from sales_data
select *,count(quantity_sold) over(order by product_category) from sales_data

select *,max(total_amount) over(order by product_category) from sales_data

select *,min(unit_price) over(order by product_category) from sales_data

select *,avg(quantity_sold) over(order by order_date rows between 1 preceding and 1 following ) from sales_data

select *,sum(total_amount) over(order by region) from sales_data

select
customer_id,
sum(total_amount) TotalPurchase,
rank() over (order by sum(total_amount) desc) PurchaseRank
from sales_data
group by customer_id
order by PurchaseRank

select *,total_amount-lag(total_amount) over(partition by customer_id order by order_date ) from sales_data

select *,dense_rank() over(partition by product_category order by unit_price) from sales_data

select *,sum(total_amount) over(partition by region order by order_date,sale_id rows unbounded preceding) from sales_data

CREATE TABLE OneColumn (
Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

select *,sum(Value) over (order by Value rows unbounded preceding) as counting from OneColumn a

select customer_id from sales_data
group by customer_id
having count(distinct product_category) > 1

select customer_id,region ,sum(total_amount) FROM sales_data
group by customer_id, region
having sum(total_amount) > (select avg(total_spent )as total_spend from (
select region, sum(total_amount)
from sales_data
group by customer_id, region
) t
where t.region = sales_data.region
);

select customer_id,region,rank() over(partition by region order by sum(total_amount) desc) from sales_data
group by customer_id,region

select *,sum(total_amount) over(partition by customer_id order by order_date,sale_id) from sales_data
order by customer_id,order_date,sale_id

SELECT
DATEPART(YEAR, order_date) year,
DATEPART(MONTH, order_date) month,
SUM(total_amount) monthly_sales,
LAG(SUM(total_amount)) OVER (ORDER BY DATEPART(YEAR, order_date), DATEPART(MONTH, order_date)) prev_month_sales,
(SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY DATEPART(YEAR, order_date), DATEPART(MONTH, order_date)))
* 100.0 / LAG(SUM(total_amount)) OVER (ORDER BY DATEPART(YEAR, order_date), DATEPART(MONTH, order_date)) growth_rate
FROM sales_data
GROUP BY DATEPART(YEAR, order_date), DATEPART(MONTH, order_date)
ORDER BY year, month;

select *,lag(total_amount) over (partition by customer_id order by order_date,sale_id) from sales_data

select sale_id,product_name,unit_price from sales_data
where unit_price>(select avg(unit_price)from sales_data )

CREATE TABLE MyData (
Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);

select Id,Grp,Val1,Val2,
case
when row_number() OVER (partition by Grp order by Id) = 1
then sum(Val1 + Val2) over (partition by Grp)
end as tost
from MyData
ORDER BY Id;

CREATE TABLE TheSumPuzzle (
ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);

with cte as(
select id,max(Cost) as Cost,MAX(Quantity) as Quantity from TheSumPuzzle
group by ID
)

select Id,Cost,Quantity from cte
order by ID

CREATE TABLE Seats
(
SeatNumber INTEGER
);

INSERT INTO Seats VALUES
(7),(13),(14),(15),(27),(28),(29),(30),
(31),(32),(33),(34),(35),(52),(53),(54);

SELECT
SeatNumber + 1 AS GapStart,
LEAD(SeatNumber) OVER (ORDER BY SeatNumber) - 1 AS GapEnd
FROM Seats
WHERE LEAD(SeatNumber) OVER (ORDER BY SeatNumber) - SeatNumber > 1;
