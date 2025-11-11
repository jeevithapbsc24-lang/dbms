-- ======================================================================
-- Lab Experiment – Implementation of Triggers in SQL
-- ======================================================================

-- Objective:
-- 1. To understand and create triggers in MySQL.
-- 2. To implement BEFORE and AFTER triggers for INSERT, UPDATE, and DELETE operations.

-- ======================================================================
-- Step 1: Create Database
DROP DATABASE IF EXISTS SchoolDB;
CREATE DATABASE SchoolDB;
USE SchoolDB;

-- ======================================================================
-- Step 2: Create Tables
-- Create a Students table and a Logs table to record trigger actions.

CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(50),
    Age INT,
    Marks DECIMAL(5,2)
);

CREATE TABLE StudentLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    ActionType VARCHAR(50),
    ActionDate DATETIME,
    Description VARCHAR(200)
);

-- OUTPUT:
DESC Students; 
DESC StudentLogs;
/*
StudentID	int	NO	PRI		auto_increment
StudentName	varchar(50)	YES			
Age	int	YES			
Marks	decimal(5,2)	YES			*/

DESC StudentLogs;
/*
LogID	int	NO	PRI		auto_increment
ActionType	varchar(50)	YES			
ActionDate	datetime	YES			
Description	varchar(200)	YES			*/

-- ======================================================================
-- Task 1: BEFORE INSERT Trigger
-- Create a trigger to ensure that no student can be inserted with Marks greater than 100.
-- WRITE YOUR TRIGGER CREATION QUERY BELOW

DELIMITER //
CREATE TRIGGER before_student_insert
BEFORE INSERT ON Students
FOR EACH ROW
BEGIN
    IF NEW.Marks > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Marks cannot exceed 100.';
    END IF;
END//
DELIMITER ;

-- OUTPUT:
INSERT INTO Students (StudentName, Age, Marks) VALUES ('Ravi', 18, 105);

-- Output:
/*
0	19	12:50:21	INSERT INTO Students (StudentName, Age, Marks) VALUES ('Ravi', 18, 105)	Error Code: 1644. Marks cannot exceed 100.	0.047 sec
*/

-- ======================================================================
-- Task 2: AFTER INSERT Trigger
-- Create a trigger that inserts a log entry into StudentLogs whenever a new student is added.
-- WRITE YOUR TRIGGER CREATION QUERY BELOW

DELIMITER //
CREATE TRIGGER after_student_insert
AFTER INSERT ON Students
FOR EACH ROW
BEGIN
    INSERT INTO StudentLogs (ActionType, ActionDate, Description)
    VALUES ('INSERT', NOW(), CONCAT('New student added: ', NEW.StudentName, ', Marks: ', NEW.Marks));
END//
DELIMITER ;

-- OUTPUT:
INSERT INTO Students (StudentName, Age, Marks) VALUES ('Ravi', 18, 95);
SELECT * FROM StudentLogs;
-- Expected Output:
/*
LOGID ACTIONTYPE ACTIONDATE     DESCRIPTION
1	INSERT	2025-10-28 12:50:57	New student added: Ravi, Marks: 95.00
2	UPDATE	2025-10-28 12:53:18	Marks updated for Ravi from 95.00 to 98.00
3	INSERT	2025-10-28 12:53:53	New student added: Ravi, Marks: 95.00
			*/

-- ======================================================================
-- Task 3: AFTER UPDATE Trigger
-- Create a trigger that logs any update made to a student’s marks.
-- WRITE YOUR TRIGGER CREATION QUERY BELOW

DELIMITER //
CREATE TRIGGER after_student_update
AFTER UPDATE ON Students
FOR EACH ROW
BEGIN
    IF OLD.Marks <> NEW.Marks THEN
        INSERT INTO StudentLogs (ActionType, ActionDate, Description)
        VALUES ('UPDATE', NOW(), CONCAT('Marks updated for ', NEW.StudentName,
                ' from ', OLD.Marks, ' to ', NEW.Marks));
    END IF;
END//
DELIMITER ;

SET SQL_SAFE_UPDATES=0;

UPDATE Students SET Marks = 98 WHERE StudentName = 'Ravi';
SELECT * FROM StudentLogs;

-- Output:
/*
LogID ActionType   ActionDate Description
1	INSERT	2025-10-28 12:50:57	New student added: Ravi, Marks: 95.00
2	UPDATE	2025-10-28 12:53:18	Marks updated for Ravi from 95.00 to 98.00
3	INSERT	2025-10-28 12:53:53	New student added: Ravi, Marks: 95.00
4	UPDATE	2025-10-28 12:54:58	Marks updated for Ravi from 95.00 to 98.00
			
*/

-- ======================================================================
-- Task 4: AFTER DELETE Trigger
-- Create a trigger that logs when a student record is deleted.
-- WRITE YOUR TRIGGER CREATION QUERY BELOW

DELIMITER //
CREATE TRIGGER after_student_delete
AFTER DELETE ON Students
FOR EACH ROW
BEGIN
    INSERT INTO StudentLogs (ActionType, ActionDate, Description)
    VALUES ('DELETE', NOW(), CONCAT('Student deleted: ', OLD.StudentName));
END//
DELIMITER ;

-- OUTPUT:
DELETE FROM Students WHERE StudentName = 'Ravi';
SELECT * FROM StudentLogs;

-- Expected Output:
/*
LogID ActionType   ActionDate Description
1	INSERT	2025-10-28 12:50:57	New student added: Ravi, Marks: 95.00
2	UPDATE	2025-10-28 12:53:18	Marks updated for Ravi from 95.00 to 98.00
3	INSERT	2025-10-28 12:53:53	New student added: Ravi, Marks: 95.00
4	UPDATE	2025-10-28 12:54:58	Marks updated for Ravi from 95.00 to 98.00
			
*/

-- ======================================================================
-- END OF EXPERIMENT – Implementation of Triggers
-- ======================================================================

