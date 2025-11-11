-- STUDENT NAME: Jeevitha
-- USN: 1RUA24SCS0044
-- SECTION: A
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Paste the Output below by execution of above command
-- root@localhost	bhavana	9.1.0	2025-09-29 09:50:23

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- PreCoded Relational Schema and Instance.
-- ----------------------------------------------------------------------------------------------------------------------------------------
create database lab3;
use lab3;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2),
    BirthDate DATE,
    HireDate DATE
);

INSERT INTO Employees (FirstName, LastName, Salary, BirthDate, HireDate) VALUES
('John', 'Doe', 55000.30, '1985-06-15', '2010-01-20'),
('Jane', 'Smith', 65000.50, '1990-08-22', '2012-07-10'),
('Alice', 'Johnson', 72000.10, '1982-11-30', '2015-05-25'),
('Bob', 'Brown', 48000.90, '1978-03-12', '2018-09-15');

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Orders (OrderDate, TotalAmount, EmployeeID) VALUES
('2024-07-15', 250.00, 1),   
('2024-08-10', 175.50, 2),
('2024-09-01', 300.00, 3),
('2024-09-10', 450.75, 1),
('2024-08-25', 123.40, 4);
SELECT * FROM Orders;

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Print the Information of the Employee and Order Table. [ Hint: SELECT * FROM TABLENAME ]
-- Write the SQL Query below this line.
SELECT * FROM Orders;
-- Output: 
-- 1	2024-07-15	250.00	1
-- 2	2024-08-10	175.50	2
-- 3	2024-09-01	300.00	3
-- 4	2024-09-10	450.75	1
-- 5	2024-08-25	123.40	4
SELECT * from Employees;
-- output:
/*
1	John	Doe	55000.30	1985-06-15	2010-01-20
2	Jane	Smith	65000.50	1990-08-22	2012-07-10
3	Alice	Johnson	72000.10	1982-11-30	2015-05-25
4	Bob	Brown	48000.90	1978-03-12	2018-09-15
					*/		
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Number Functions Section
-- ------------------------------------------------------------
/* a. Round Salaries: Round employee salaries to nearest integer */
SELECT ROUND(Salary) AS ROUNDEDSALARY
FROM Employees;

-- Output: 
/*55000
65001
72000
48001*/


/* b. Absolute Values: Show absolute values of salaries */
SELECT abs(Salary) AS Absolutesalary
FROM Employees;

-- Output: 
/*55000.30
65000.50
72000.10
48000.90*/
/* c. Ceiling Values: Get ceiling values of order amounts */
SELECT Ceil(TotalAmount) AS Ceilamt
FROM Orders;

-- Output: 
/* 250
176
300
451
124*/
-- ------------------------------------------------------------
-- Aggregate Functions Section
-- ------------------------------------------------------------
/* a. Count of Employees: Find total number of employees */
SELECT count(*) AS EmployeeCount
FROM Employees;

-- Output: 
-- 4
/* b. Sum of Salaries: Calculate total salary expense */
SELECT Sum(Salary) AS TotalSalary
FROM Employees;

-- Output: 
-- 240001.80
/* c. Average Order Amount: Find average order value */
SELECT avg(TotalAmount) AS AVGamount
FROM Orders;

-- Output: 
-- 259.930000
/* d. Max/Min Salary: Find highest and lowest salaries */
SELECT Min(Salary) AS MinSalary, Max(Salary) AS MaxSalary
FROM Employees;

-- Output: 
-- 48000.90	72000.10
-- ------------------------------------------------------------
-- Character Functions Section
-- ------------------------------------------------------------
/* a. Case Conversion: Show names in uppercase and lowercase */
SELECT UPPER(FirstName) AS UppercaseN, lower(FirstName) as LowercaseN
FROM Employees;
-- Output: 
/* 	UppercaseN	LowercaseN
	JOHN	john
	JANE	jane
	ALICE	alice
	BOB	bob */
    
/* b. Concatenate Names: Create full names */
SELECT CONCAT(FirstName, LastName) as fullname
FROM Employees;
-- Output: 
/*JohnDoe
JaneSmith
AliceJohnson
BobBrown */
/* c. Extract Substring: Get first 3 characters of first names */
SELECT SUBSTRING(FirstName, 1, 3) AS First3Chars
FROM Employees;

-- Output: 
/* Joh
Jan
Ali
Bob*/
-- ------------------------------------------------------------
-- Conversion Functions Section
-- ------------------------------------------------------------
/* Convert String to Date: Convert text to DATE type */
SELECT 
    STR_TO_DATE(BirthDate, '%Y-%m-%d')   AS ConvertedBirthDate,
    STR_TO_DATE(HireDate,  '%Y-%m-%d')   AS ConvertedHireDate
FROM Employees;

-- Output: 
/* 1985-06-15	2010-01-20
1990-08-22	2012-07-10
1982-11-30	2015-05-25
1978-03-12	2018-09-15*/
-- ------------------------------------------------------------
-- Date Functions Section
-- ------------------------------------------------------------
/* a. Current Date/Time: Get current timestamp */
SELECT NOW() AS CurrentDateTime;

-- Output: 
-- 2025-09-29 10:25:18
/* b. Extract Year: Get year from order dates */
SELECT YEAR(OrderDate) as Yearorder
from Orders;
-- Output: 
/* 2024
2024
2024
2024
2024*/
/* c. Add Months: Add 3 months to order dates */
SELECT OrderDate, DATE_ADD(OrderDate, INTERVAL 3 MONTH) AS NewDate
FROM Orders;

-- Output: 
/* 2024-07-15	2024-10-15
2024-08-10	2024-11-10
2024-09-01	2024-12-01
2024-09-10	2024-12-10
2024-08-25	2024-11-25*/
/* d. Days Since Order: Calculate days between order date and now */

SELECT OrderDate, DATEDIFF(NOW(), OrderDate) AS DaysSinceOrder
FROM Orders;

-- Output: 
/* 2024-07-15	441
2024-08-10	415
2024-09-01	393
2024-09-10	384
2024-08-25	400 */
-- END of the Task -- 