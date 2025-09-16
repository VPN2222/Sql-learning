create table employees(EmpID int, name varchar(50),salary decimal(10,2))
insert into employees values(1,'Ikrom',2323334)
insert into employees(EmpID,name,salary)
values
(2,'bexruz',34343242),
(3,'Asad',2323),
(1,'Abo',900000);
select* from employees
update employees
SET salary =70000
where EmpID=1;

delete employees
where EmpID =2
/*
DELETE removes specific rows from a table base
TRUNCATE delete alln rows quickly without logging individual row deletions
DROP Completly removes only tavle or DAtabse
*/
alter table employees
alter column name varchar(100)

alter table employees
add department varchar(50);

alter table employess
alter column salary float
INSERT INTO employees(EmpID,department)
values(1,'ANORA'),(2,'Finance'),(3,'Demo')
create table DEPARTMENTS(departmentID int primary key,DepartmentN varchar(50))

TRUNCATE TABLE employess;

INSERT INTO DEPARTMENTS (departmentID,DepartmentN)
values (1,'ANORA'),(2,'Finance'),(3,'Demo'),(4,'Line'),(5,'ASAD HOTEL')

Alter table DEPARTMENTS
ADD slary integer;

select * from DEPARTMENTS

update DEPARTMENTS
Set slary=23456
where slary=5000;

EXEC sp_rename 'employees', 'StaffMembers';
select * from StaffMembers

DROP table DEPARTMENTS

create table PRODUCTS(ProductID int primary key,ProductN varchar(50),Category varchar(50),PRICE decimal check(PRICE>0))

select * from PRODUCTS
EXEC sp_rename 'PRODUCT.Category', ' ProductCategory', 'PRODUCT.COLUMN';

INSERT INTO PRODUCTS (ProductN, PRICE)
VALUES
('Laptop', 1200.00),
('Mouse', 25.50),
('Keyboard', 45.99),
('Monitor', 220.00),
('Printer', 150.00);

SELECT * INTO Products_Backup
FROM PRODUCTS;

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

CREATE TABLE Inventory_New (
ProductCode INT IDENTITY(1000, 5) PRIMARY KEY,
ProductName VARCHAR(100),
Price FLOAT
);

INSERT INTO Inventory_New (ProductName, Price)
SELECT ProductName, Price FROM Inventory;

EXEC sp_rename 'Inventory_New', 'Inventory';

