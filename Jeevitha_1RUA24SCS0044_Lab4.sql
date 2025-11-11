-- ======================================================================
-- Lab Experiment 04 – Implementation of Different Types of Operators in SQL
-- ======================================================================

-- Step 1: Create Database
DROP DATABASE IF EXISTS OperatorLab;
CREATE DATABASE OperatorLab;
USE OperatorLab;

-- Step 2: Create Tables
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Salary DECIMAL(10, 2),
    Department VARCHAR(50),
    HireDate DATE,
    Address VARCHAR(100)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Step 3: Insert Sample Data
INSERT INTO Employees (EmployeeID, Name, Age, Salary, Department, HireDate, Address) VALUES
(1001, 'Ashish', 28, 60000, 'IT', '2024-05-01', '123 Main St, New York'),
(1002, 'Binay', 45, 80000, 'HR', '2020-07-15', '456 Elm St, Chicago'),
(1003, 'Charlie', 32, 55000, 'Finance', '2022-01-10', '789 Oak St, Los Angeles'),
(1004, 'Dhruv', 38, 75000, 'HR', '2021-10-30', '101 Pine St, New York');

INSERT INTO Departments (DepartmentID, DepartmentName, EmployeeID) VALUES
(1, 'IT', 1001),
(2, 'HR', 1002),
(3, 'Finance', 1003);

-- ======================================================================
-- PRACTICE TASKS
-- ======================================================================

-- ========================
-- Exercise 1: Arithmetic Operators
-- ========================

-- a. Add a bonus (10% of Salary) to each employee's salary.
-- WRITE YOUR QUERY BELOW
SELECT Name, Salary, 
Salary *0.10 as bonus
FROM Employees;
/*
Name    Salary      Bonus
Ashish	60000.00	6000.0000
Binay	80000.00	8000.0000
Charlie	55000.00	5500.0000
Dhruv	75000.00	7500.0000*/
-- b. Subtract tax (15% of Salary) from each employee's salary.
-- WRITE YOUR QUERY BELOW
SELECT Name, Salary, 
Salary *0.15 as tax,
Salary - (Salary *0.15) as newsalary
FROM Employees;
/* 
Name    Salary      tax         newsalary
Ashish	60000.00	9000.0000	51000.0000
Binay	80000.00	12000.0000	68000.0000
Charlie	55000.00	8250.0000	46750.0000
Dhruv	75000.00	11250.0000	63750.0000*/
-- c. Calculate the yearly salary from the monthly salary (Salary * 12).
-- WRITE YOUR QUERY BELOW
Select Salary *12 as Yearlysalary
from Employees;
/*
Yearlysalary
720000.00
960000.00
660000.00
900000.00*/
-- d. Find the remainder when employees' ages are divided by 5.
-- WRITE YOUR QUERY BELOW
 SELECT Name, Age, Age% 5 AS AgeRemainder
 From Employees;
/*
Name    Age AgeRemainder
Ashish	28	3
Binay	45	0
Charlie	32	2
Dhruv	38	3 */

-- ========================
-- Exercise 2: Logical Operators
-- ========================

-- a. Employees older than 30 and salary greater than 50000.
-- WRITE YOUR QUERY BELOW
Select Name, Salary
from Employees;
where Age> 30 and salary > 50000;
/*
Name    Salary
Ashish	60000.00
Binay	80000.00
Charlie	55000.00
Dhruv	75000.00*/

-- b. Employees either in 'HR' department OR salary > 70000.
-- WRITE YOUR QUERY BELOW
SELECT Name, Department, Salary
From Employees
Where Department = 'HR' or Salary > 70000;
/*
Name    Department Salary
Binay	HR	80000.00
Dhruv	HR	75000.00*/
-- c. Employees who do NOT live in 'New York'.
-- WRITE YOUR QUERY BELOW
Select Name, Address
FROM Employees
Where Address NOT LIKE '%New York%';
/* 
Name    Address
Binay	456 Elm St, Chicago
Charlie	789 Oak St, Los Angeles*/


-- ========================
-- Exercise 3: Comparison Operators
-- ========================

-- a. Find employees with salary = 60000.
-- WRITE YOUR QUERY BELOW
Select name,salary
From Employees
Where salary = 60000;
/* Ashish	60000.00*/
-- b. List employees not in the 'IT' department.
-- WRITE YOUR QUERY BELOW
Select name,Department
From Employees
Where Department Not like "%IT%";
/*
Name    Department
Binay	HR
Charlie	Finance
Dhruv	HR*/

-- c. Retrieve employees younger than 25 with salary > 50000.
-- WRITE YOUR QUERY BELOW
Select name, Age, Salary
From Employees
Where Age < 25 and salary > 50000;
 /* 
 Name Age Salary*/


-- ========================
-- Exercise 4: Special Operators
-- ========================

-- a. BETWEEN → List employees with age between 25 and 35.
-- WRITE YOUR QUERY BELOW
Select name, Age
From Employees
Where Age Between 25 and 35;
/* 
Name    Age
Ashish	28
Charlie	32*/

-- b. IN → Find employees working in 'HR', 'IT', or 'Finance'.
-- WRITE YOUR QUERY BELOW
SELECT Name, Department
FROM Employees
WHERE Department IN ('HR', 'IT', 'Finance');
/*
Name    Department
Ashish	IT
Binay	HR
Charlie	Finance
Dhruv	HR */


-- c. LIKE → Find employees whose names start with 'A'.
-- WRITE YOUR QUERY BELOW


-- d. IS NULL → List employees whose address is not available.
-- WRITE YOUR QUERY BELOW
SELECT Name, Address
FROM Employees
WHERE Address IS NULL;
 /* 
 Name Address */


-- ========================
-- Exercise 5: Set Operators
-- ========================

-- NOTE: For these, assume you have two Employee tables (Employees2022 and Employees2023).

-- a. UNION → Retrieve employees from 'HR' department in 2023 and 2022.
-- WRITE YOUR QUERY BELOW

CREATE TABLE Employees_2023 (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Salary DECIMAL(10,2),
    Department VARCHAR(50),
    HireDate DATE,
    Address VARCHAR(100)
);
INSERT INTO Employees_2023 (EmployeeID, Name, Age, Salary, Department, HireDate, Address) VALUES
(2001, 'Aarav', 29, 62000, 'HR', '2023-03-10', '12 Lakeview Rd, Mumbai'),
(2003, 'Chirag', 31, 58000, 'Finance', '2023-06-20', '78 Maple Ave, Bengaluru'),
(2004, 'Diya', 27, 65000, 'IT', '2023-08-15', '90 Park Ln, Chennai');

CREATE TABLE Employees_2022 (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Salary DECIMAL(10,2),
    Department VARCHAR(50),
    HireDate DATE,
    Address VARCHAR(100)
);

INSERT INTO Employees_2022 (EmployeeID, Name, Age, Salary, Department, HireDate, Address) VALUES
(1501, 'Ananya', 30, 61000, 'IT', '2022-04-12', '22 Rose St, Pune'),
(1504, 'Devika', 29, 67000, 'IT', '2022-11-30', '55 Lake St, Hyderabad');
TRUNCATE TABLE Employees_2022;
INSERT INTO Employees_2022 (EmployeeID, Name, Age, Salary, Department, HireDate, Address) VALUES
(1501, 'Ananya', 30, 61000, 'HR', '2022-04-12', '22 Rose St, Pune'),
(1504, 'Devika', 29, 67000, 'IT', '2022-11-30', '55 Lake St, Hyderabad');

Select Name, Age
from Employees_2023
Where Department = 'HR'
UNION
SELECT Name, Age
From Employees_2022
Where Department= 'HR';
 
/* Ananya	30 */

-- b. INTERSECT → Find common employees in 'IT' department across 2022 & 2023.
-- (MySQL doesn’t have INTERSECT directly – use INNER JOIN / EXISTS workaround)
-- WRITE YOUR QUERY BELOW

SELECT Name
FROM Employees_2023
Where Department='IT'
INTERSECT
SELECT Name
FROM Employees_2022
Where Department= 'IT';


-- c. EXCEPT → Find employees who worked in 2023 but not in 2022.
-- (MySQL doesn’t have EXCEPT directly – use LEFT JOIN / NOT EXISTS workaround)
-- WRITE YOUR QUERY BELOW
SELECT Name
FROM Employees_2023
Except
SELECT Name
FROM Employees_2022;



-- ======================================================================
-- END OF EXPERIMENT 04
-- ======================================================================