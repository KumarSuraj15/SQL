-- use select query
-- The SELECT statement in MySQL is used to retrieve data from one or more tables in a database. 

select * from classicmodels.customers;

select * from customers;

select * from products;

select * from orders;

select  productName, productLine, quantityInStock
from products;



-- use where clause 
-- The `WHERE` clause in MySQL is used to filter records in a SQL statement, allowing you to specify conditions that must be met.

select * from customers where country = "USA";

select * from customers where creditLimit > 100000;

SELECT 
    customerName, customerNumber
FROM
    customers
WHERE
    creditLimit > 100000;


-- uses a AND, OR, NOT, OPERATORS IN MYSQL
-- AND: Returns a result as true only if all the conditions connected by "AND" are true.
-- OR: Returns a result as true if at least one of the conditions connected by "OR" is true.
-- NOT: Reverses the truth value of a condition, meaning it returns true if the condition is false and vice versa. 

select * from customers
where creditLimit > 100000 and country = "USA";

SELECT * FROM customers WHERE     creditLimit > 100000 AND country = 'USA' AND salesRepEmployeeNumber = 1165;
        
select * from customers
where (country = "USA" or country = "Germany")
and creditLimit > 100000;        

select * from customers where not (country = "USA"  or country = "Germany");
        
-- uses a like operators
-- The LIKE operator is used in a WHERE clause to search for a specified pattern in a column. There are two wildcards often used in conjunction with the LIKE operator: The percent sign (%) represents zero, one, or multiple characters.

select * from customers where phone like "%44%";        
        
-- uses a ORDER BY 
-- The ORDER BY clause is used to sort the result-set in ascending or descending order.  

select contactFirstName, country, city from customers
order by country desc;  


-- uses a LIMIT CLAUSE 
-- The LIMIT clause in MySQL is used to specify the maximum number of rows a query should return.

select * from customers limit 10;

select * from customers limit 1,1;

select * from customers order by creditLimit desc limit 1,1;

select * from customers order by creditLimit desc limit 1,5;

select * from customers
where country = "USA" order by creditLimit desc limit 1;

-- use BETWEEN OPERATOR
-- The BETWEEN operator in MySQL is used to filter results within a specified range, including both boundary values.

select * from customers where customerNumber between 150 and 200;

-- uses IN ADN NOT IN 
-- The IN operator allows you to specify multiple values in a WHERE clause.

select * from customers where country in ("germany", "usa", "france");

select * from customers where country not in ("germany", "usa", "france");

-- uses a string function
-- lenght()

select contactFirstName, length(contactFirstName) from customers;

select contactFirstName, 
length(contactFirstName), 
length(trim(contactFirstName)),
lower(contactFirstName),
upper(contactFirstName),
left(contactFirstName,2),
right(trim(contactFirstName),2),
mid(contactFirstName,3,2),
replace(contactFirstName, "e", "a")
from customers;


-- The "CONCAT" function in MySQL joins multiple strings into a single string.
select
concat(firstName, " " , lastName, " - " , jobTitle) fullname,
concat_ws(" " , firstName, lastName, jobTitle)
from employees;

-- uses an "AGGREGATION FUNCTION" in SQL
-- uses "having clause"

SELECT * FROM classicmodels.orderdetails;

select sum(quantityOrdered) from orderdetails;

select max(quantityOrdered) from orderdetails;

select avg(quantityOrdered) from orderdetails;

select min(quantityOrdered) from orderdetails;

select sum(quantityOrdered), min(quantityOrdered),  avg(quantityOrdered), max(quantityOrdered) from orderdetails;

-- MySQL DATE AND TIME FUNCTION

SELECT orderDate, 
MONTH(orderDate),
MONTHNAME(orderDate), 
year(orderDate),
day(orderDate),
hour(orderDate),
minute(orderDate),
second(orderDate)
FROM orders;

select *, datediff(shippedDate, orderDate) from orders;


-- CASE OPERATOR IN MySQL

-- The CASE statement goes through conditions and return a value when the first condition is met (like an IF-THEN-ELSE statement). So, once a condition is true, it will stop reading and return the result.

-- If no conditions are true, it will return the value in the ELSE clause.

-- If there is no ELSE part and no conditions are true, it returns NULL.

-- Syntax
-- CASE
--     WHEN condition1 THEN result1
--     WHEN condition2 THEN result2
--     WHEN conditionN THEN resultN
--     ELSE result
-- END;

select * from classicmodels.customers;

select 
customerName, 
creditLimit,
CASE 
	WHEN creditLimit < 80000 THEN '5%'
    WHEN creditLimit >= 80000 AND  creditLimit < 100000 THEN '10%'
    WHEN creditLimit >= 100000 AND creditLimit < 150000 THEN '15%'
    ELSE '20%' 
END  AS Bonus
FROM 
	customers;
    
    
-- USES A GROUP BY FUNCTION IN MySQL
-- used to organize data into groups based on identical values in one or more specified columns, allowing you to apply aggregate functions like "COUNT", "SUM", "AVG", "MIN", and "MAX" 
-- Syntax:
-- SELECT column1, aggregate_function(column2) 
-- FROM table_name 
-- WHERE condition 
-- GROUP BY column1;

select customerName, sum(creditLimit) as ts,
avg(creditLimit) as avg_c from customers
group by customerName order by ts desc;


-- USE A HAVING CLAUSE IN MySQL
-- The `HAVING` clause is applied after `GROUP BY` to filter data based on aggregate functions like `SUM`, `COUNT`, or `AVG`. 
-- The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions
-- HAVING Syntax

-- SELECT column_name(s)
-- FROM table_name
-- WHERE condition
-- GROUP BY column_name(s)
-- HAVING condition
-- ORDER BY column_name(s);


select * from classicmodels.customers;

#query the countries where the count of customers >= 

select country, count(customerName) from customers
group by country having count(customerNumber) >= 5;

-- USE A JOIN IN MySQL 

-- The INNER JOIN keyword selects records that have matching/common  values in both tables.
-- INNER JOIN Syntax
-- SELECT column_name(s)
-- FROM table1
-- INNER JOIN table2
-- ON table1.column_name = table2.column_name;

select * from orderdetails;

select products.productName,
orderdetails.quantityOrdered
from products inner join orderdetails;

-- The LEFT JOIN keyword returns all records from the left table (table1), and the matching records (if any) from the right table (table2).
-- LEFT JOIN Syntax
-- SELECT column_name(s)
-- FROM table1
-- LEFT JOIN table2
-- ON table1.column_name = table2.column_name;

select 
	products.productName,
    products.productCode,
    orderdetails.quantityOrdered
from
	products
		left join 
        orderdetails on products.productCode = orderdetails.productCode;
        
-- The CROSS JOIN keyword returns all records from both tables (table1 and table2).
-- CROSS JOIN Syntax
-- SELECT column_name(s)
-- FROM table1
-- CROSS JOIN table2;

select c.*, e.* from customers as c
cross join employees as e 
on c.salesRepEmployeeNumber = e.employeeNumber;

-- A self join is a regular join, but the table is joined with itself.

-- Self Join Syntax
-- SELECT column_name(s)
-- FROM table1 T1, table1 T2
-- WHERE condition;

select * from customers;

select T1.customerName, T2.customerName, T1.country
from customers as T1 join customers as T2
on T1.country <> T2.country;



-- use a SET OPERATORS IN MySQL
-- The SQL standard defines the following three set operations:

-- UNION: Combine all results from two query blocks into a single result, omitting any duplicates.

-- INTERSECT: Combine only those rows which the results of two query blocks have in common, omitting any duplicates.

-- EXCEPT: For two query blocks A and B, return all results from A which are not also present in B, omitting any duplicates.



-- The SQL UNION Operator
-- The UNION operator is used to combine the result-set of two or more SELECT statements.

-- Every SELECT statement within UNION must have the same number of columns
-- The columns must also have similar data types
-- The columns in every SELECT statement must also be in the same order

-- UNION Syntax
-- SELECT column_name(s) FROM table1
-- UNION
-- SELECT column_name(s) FROM table2;

select * from orders
union all
select * from orderdetails;

-- Syntax:

-- The syntax for using INTERSECT in SQL is as follows:

-- SELECT column1, column2, ...
-- FROM table1
-- INTERSECT
-- SELECT column1, column2, ...
-- FROM table2;


-- Syntax of MySQL EXCEPT Operator

-- SELECT column1, column2, ...
-- FROM table1
-- EXCEPT
-- SELECT column1, column2, ...
-- FROM table2;


-- use  a SUBQUERIES IN MySQL


#name of top 5 products based on orders

select products.productName,
sum(orderdetails.quantityOrdered) orders
from products join orderdetails
on products.productCode = orderdetails.productCode
group by products.productName order by orders desc;



-- use  a WINDOWS FUNCTION IN MySQL
#write a query to obtain customerName, country, creditLimit and avg of creditlimt by country from customers.

select customerName, country, creditLimit,
avg(creditLimit) from customers group by
customerName, country, creditLimit;


select customerName, country, creditLimit,
avg(creditLimit) over(partition by country)
from customers;

-- use a CTE in MySQL

-- To use a Common Table Expression (CTE) in MySQL, you start with the "WITH" keyword, followed by a named temporary result set (your CTE), which you can then reference in your main query; essentially creating a reusable intermediate result within your SQL statement to simplify complex queries. 
-- Basic syntax:
-- Code

-- WITH cte_name AS (

--     -- Your subquery that generates the temporary result set

-- ) 

-- SELECT * FROM cte_name;

with  s as (select customers.customerName,
sum(orderdetails.quantityOrdered * orderdetails.priceEach) sales
from customers join orders
on customers.customerNumber = orders.customerNumber
join orderdetails
on orders.orderNumber = orderdetails.orderNumber
group by customers.customerName),

b as (select customers.customerName,
sum(payments.amount) payments from payments join customers
on payments.customerNumber = customers.customerName
group by customers.customerName)

select s.customerName, s.sales - b.payments as pending 
from s join b on s.customerName = b.customerName;



-- use a VIEW IN MySQL
-- In SQL, a view is a virtual table based on the result-set of an SQL statement.

-- A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database.

-- You can add SQL statements and functions to a view and present the data as if the data were coming from one single table.

-- A view is created with the CREATE VIEW statement.

-- CREATE VIEW Syntax

-- CREATE VIEW view_name AS
-- SELECT column1, column2, ...
-- FROM table_name
-- WHERE condition;


-- use a STORED PROCEDURES IN MySQL
-- A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again.

-- So if you have an SQL query that you write over and over again, save it as a stored procedure, and then just call it to execute it.

-- You can also pass parameters to a stored procedure, so that the stored procedure can act based on the parameter value(s) that is passed.

-- Stored Procedure Syntax

-- CREATE PROCEDURE procedure_name
-- AS
-- sql_statement
-- GO;

create procedure anything()
select * from customers;

call anything()






































  
        
        
        
        
        
        
        





