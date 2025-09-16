create database lesson12
use lesson12

Create table Person (personId int, firstName varchar(255), lastName varchar(255))
Create table Address (addressId int, personId int, city varchar(255), state varchar(255))
Truncate table Person
insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen')
insert into Person (personId, lastName, firstName) values ('2', 'Alice', 'Bob')
Truncate table Address
insert into Address (addressId, personId, city, state) values ('1', '2', 'New York City', 'New York')
insert into Address (addressId, personId, city, state) values ('2', '3', 'Leetcode', 'California')

Create table Employee (id int, name varchar(255), salary int, managerId int)
Truncate table Employee
insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3')
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4')
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', NULL)
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', NULL)

CREATE TABLE boys (
Id INT PRIMARY KEY,
name VARCHAR(100),
ParentName VARCHAR(100)
);

CREATE TABLE girls (
Id INT PRIMARY KEY,
name VARCHAR(100),
ParentName VARCHAR(100)
);

INSERT INTO boys (Id, name, ParentName)
VALUES
(1, 'John', 'Michael'),
(2, 'David', 'James'),
(3, 'Alex', 'Robert'),
(4, 'Luke', 'Michael'),
(5, 'Ethan', 'David'),
(6, 'Mason', 'George');

INSERT INTO girls (Id, name, ParentName)
VALUES
(1, 'Emma', 'Mike'),
(2, 'Olivia', 'James'),
(3, 'Ava', 'Robert'),
(4, 'Sophia', 'Mike'),
(5, 'Mia', 'John'),
(6, 'Isabella', 'Emily'),
(7, 'Charlotte', 'George');

DROP TABLE IF EXISTS Cart1;
DROP TABLE IF EXISTS Cart2;
GO

CREATE TABLE Cart1
(
Item VARCHAR(100) PRIMARY KEY
);
GO

CREATE TABLE Cart2
(
Item VARCHAR(100) PRIMARY KEY
);
GO

INSERT INTO Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');
GO

INSERT INTO Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');
GO

Create table Customers (id int, name varchar(255))
Create table Orders (id int, customerId int)
Truncate table Customers
insert into Customers (id, name) values ('1', 'Joe')
insert into Customers (id, name) values ('2', 'Henry')
insert into Customers (id, name) values ('3', 'Sam')
insert into Customers (id, name) values ('4', 'Max')
Truncate table Orders
insert into Orders (id, customerId) values ('1', '3')
insert into Orders (id, customerId) values ('2', '1')

select p.firstName, p.lastName, a.city, a.state from Person p
left join Address a on p.personId = a.personId;

select e.name Employee from Employee e
join Employee m on e.managerId = m.id
where e.salary > m.salary;

select email Email
FROM Person
group by email
HAVING COUNT(*) > 1;

delete p1 from Person p1
join Person p2 on p1.personId= p2.personId and p1.personId > p2.personId;

select distinct g.ParentName from girls g
where g.ParentName NOT IN (
select distinct ParentName from boys
);

select custid,
sum(salesamount) AS TotalSalesAmount,
min(weight) AS LeastWeight
from
where weight > 50
group by custid;
SELECT c1.Item AS [Item Cart 1],
c2.Item AS [Item Cart 2]
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2
ON c1.Item = c2.Item;

select s.student_id,
s.student_name,
sub.subject_name,
COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
ON s.student_id = e.student_id
AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
