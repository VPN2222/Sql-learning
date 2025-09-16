CREATE TABLE employees (
id INT PRIMARY KEY,
name VARCHAR(100),
salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);

select * from employees
where salary=(select min(salary) from employees)

CREATE TABLE products (
id INT PRIMARY KEY,
product_name VARCHAR(100),
price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);

select * from products
where price>(select avg(price) from products)

CREATE TABLE departments (
id INT PRIMARY KEY,
department_name VARCHAR(100)
);

CREATE TABLE employees1 (
id INT PRIMARY KEY,
name VARCHAR(100),
department_id INT,
FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees1 (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);

select A.name,B.department_name from departments B
join employees1 A on B.id=A.id
where department_name like 'Sales'

CREATE TABLE customers (
customer_id INT PRIMARY KEY,
name VARCHAR(100)
);

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);

select A.name,B.order_id from customers A
join orders B on A.customer_id!=B.customer_id

drop table products

CREATE TABLE products (
id INT PRIMARY KEY,
product_name VARCHAR(100),
price DECIMAL(10, 2),
category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);

select * from products A
where price=(select max(price) from products B where A.category_id=B.category_id)

drop table departments
CREATE TABLE departments (
id INT PRIMARY KEY,
department_name VARCHAR(100)
);

CREATE TABLE employees12 (
id INT PRIMARY KEY,
name VARCHAR(100),
salary DECIMAL(10, 2),
department_id INT,
FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees12 (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);

select e.id, e.name, e.salary, d.department_name
from employees12 e
join departments d
on e.department_id = d.id
where e.department_id = (
select top 1 department_id
from employees12
group by department_id
order by avg(salary)
);

CREATE TABLE employees123 (
id INT PRIMARY KEY,
name VARCHAR(100),
salary DECIMAL(10, 2),
department_id INT
);

INSERT INTO employees123 (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);

select * from employees123 A
where salary>(select avg(salary) from employees123 B where A.department_id=B.department_id)

CREATE TABLE students (
student_id INT PRIMARY KEY,
name VARCHAR(100)
);

CREATE TABLE grades (
student_id INT,
course_id INT,
grade DECIMAL(4, 2),
FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);

select * from(
select * from grades A
where grade=(select max(grade) from grades B where A.course_id=B.course_id) ) A
join students B on A.student_id=B.student_id

CREATE TABLE products (
id INT PRIMARY KEY,
product_name VARCHAR(100),
price DECIMAL(10, 2),
category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);

select * from products A
where price=(select max(price) from products B where A.category_id=B.category_id)

CREATE TABLE employeesA (
id INT PRIMARY KEY,
name VARCHAR(100),
salary DECIMAL(10, 2),
department_id INT
);

INSERT INTO employeesA (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);

select A.*, B.department_name
from employeesA A
join departments B
on A.department_id = B.id
where A.salary > (select avg(salary) from employeesA)
and A.salary < (
select max(salary)
from employeesA C
where C.department_id = A.department_id)
