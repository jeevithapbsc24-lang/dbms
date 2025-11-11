-- ======================================================================
-- Lab Experiment – Implementation of Procedures in SQL
-- ======================================================================

-- Objective:
-- 1. To understand and create stored procedures in MySQL.
-- 2. To implement procedures for performing INSERT, UPDATE, and DELETE operations.

-- ======================================================================
-- Step 1: Create Database
DROP DATABASE IF EXISTS CompanyDB;
CREATE DATABASE CompanyDB;
USE CompanyDB;

-- ======================================================================
-- Step 2: Create Table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY AUTO_INCREMENT,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
-- Step 3: Insert Sample Data
INSERT INTO Employees (EmpName, Department, Salary) VALUES
('John', 'IT', 55000),
('Alice', 'HR', 48000),
('Bob', 'Finance', 60000);

-- ======================================================================
-- Task 1: Create a Basic Procedure
-- Create a procedure named DisplayEmployees that retrieves all records.
DELIMITER //

CREATE PROCEDURE DisplayEmployees()
BEGIN
    SELECT * FROM Employees;
END //

DELIMITER ;
-- Task 2: Procedure for INSERT Operation
DELIMITER //
CREATE PROCEDURE AddEmployee(
    IN p_name VARCHAR(50),
    IN p_dept VARCHAR(50),
    IN p_salary DECIMAL(10,2)
)
BEGIN
    INSERT INTO Employees (EmpName, Department, Salary)
    VALUES (p_name, p_dept, p_salary);
END //
DELIMITER ;
-- Task 3: Procedure for UPDATE Operation

DELIMITER //
CREATE PROCEDURE UpdateSalary(
    IN p_empid INT,
    IN p_salary DECIMAL(10,2)
)
BEGIN
    UPDATE Employees
    SET Salary = p_salary
    WHERE EmpID = p_empid;
END //
DELIMITER ;

-- Task 4: Procedure for DELETE Operation
DELIMITER //
CREATE PROCEDURE RemoveEmployee(
    IN p_empid INT
)
BEGIN
    DELETE FROM Employees
    WHERE EmpID = p_empid;
END //
DELIMITER ;

CALL RemoveEmployee(3);
SELECT * FROM Employees;

-- OUTPUT:
/*
EmpID EmpName Department Salary
1	John	IT	55000.00
2	Alice	HR	48000.00 */
			
-- ======================================================================
-- END OF EXPERIMENT – Implementation of Procedures
-- ======================================================================
