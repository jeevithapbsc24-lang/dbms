-- ======================================================================
-- Lab Experiment – GROUP BY, HAVING, ORDER BY and INDEXING
-- ======================================================================

-- Objective:
-- 1. To understand and apply the SQL GROUP BY clause to group rows based on column values and perform aggregate operations.
-- 2. To explore the HAVING clause for filtering grouped data post aggregation.
-- 3. To use the ORDER BY clause to sort query results in ascending or descending order.
-- 4. To implement Indexing in SQL for improving query performance.

-- ======================================================================
-- Step 1: Create Database
DROP DATABASE IF EXISTS HospitalDB;
CREATE DATABASE HospitalDB;
USE HospitalDB;

-- ======================================================================
-- Step 2: Create Tables
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE Visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    visit_date DATE,
    doctor_id INT,
    diagnosis VARCHAR(100),
    treatment_cost DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Verify structure
DESC Patients;
DESC Visits;
/*
field        Type           Null    Key      Default Extra
patient_id	 int	          NO	PRI		auto_increment
patient_name varchar(50)	YES			
age	         int	        YES			
gender	     varchar(10)	YES		*/

/*
visit_id	int	NO	PRI		auto_increment
patient_id	int	YES	MUL		
visit_date	date	YES			
doctor_id	int	YES			
diagnosis	varchar(100)	YES			
treatment_cost	decimal(10,2)	YES			*/	
-- ======================================================================
-- Step 3: Insert Sample Data
-- Insert patients
INSERT INTO Patients (patient_name, age, gender) VALUES
('Alice', 30, 'Female'),
('Bob', 45, 'Male'),
('Charlie', 28, 'Male'),
('Diana', 50, 'Female'),
('Eve', 35, 'Female');

-- Insert visits
INSERT INTO Visits (patient_id, visit_date, doctor_id, diagnosis, treatment_cost) VALUES
(1, '2025-10-01', 101, 'Flu', 150.00),
(2, '2025-10-02', 102, 'Diabetes', 300.00),
(3, '2025-10-03', 103, 'Flu', 200.00),
(1, '2025-10-04', 101, 'Cold', 100.00),
(4, '2025-10-05', 104, 'Hypertension', 250.00),
(5, '2025-10-06', 105, 'Flu', 180.00),
(2, '2025-10-07', 102, 'Cold', 120.00),
(3, '2025-10-08', 103, 'Diabetes', 350.00);

-- Verify inserted data
SELECT * FROM Patients;
SELECT * FROM Visits;
/*
1	Alice	30	Female
2	Bob	45	Male
3	Charlie	28	Male
4	Diana	50	Female
5	Eve	35	Female

1	1	2025-10-01	101	Flu	150.00
2	2	2025-10-02	102	Diabetes	300.00
3	3	2025-10-03	103	Flu	200.00
4	1	2025-10-04	101	Cold	100.00
5	4	2025-10-05	104	Hypertension	250.00
6	5	2025-10-06	105	Flu	180.00
7	2	2025-10-07	102	Cold	120.00
8	3	2025-10-08	103	Diabetes	350.00
					*/			

-- ======================================================================
-- Task 1: Grouping Data by Diagnosis
SELECT diagnosis, AVG(treatment_cost) AS avg_cost
FROM Visits
GROUP BY diagnosis;
/*
diagnosis avg_cost
Flu	176.666667
Diabetes	325.000000
Cold	110.000000
Hypertension	250.000000*/
-- ======================================================================
-- Task 2: Filtering with HAVING Clause
SELECT diagnosis, AVG(treatment_cost) AS avg_cost
FROM Visits
GROUP BY diagnosis
HAVING AVG(treatment_cost) > 200;
/*
diagnosis  avg_cost
Diabetes	325.000000
Hypertension	250.000000*/
-- ======================================================================
-- Task 3: Sorting the Results
SELECT diagnosis, AVG(treatment_cost) AS avg_cost
FROM Visits
GROUP BY diagnosis
ORDER BY avg_cost DESC;

/*
diagnosis   avg_cost
Diabetes	325.000000
Hypertension	250.000000
Flu	176.666667
Cold	110.000000*/
-- ======================================================================
-- Task 4: Optimizing with Indexes
-- Create index
CREATE INDEX idx_patient_id ON Visits(patient_id);

-- Query visits for a particular patient (e.g., patient_id = 1)
SELECT * FROM Visits
WHERE patient_id = 1;

/* output
1	1	2025-10-01	101	Flu	150.00
4	1	2025-10-04	101	Cold	100.00
					*/
-- Verify index creation
SHOW INDEX FROM Visits;
/* output
visits	0	PRIMARY	1	visit_id	A	8				BTREE			YES	
visits	1	idx_patient_id	1	patient_id	A	5			YES	BTREE			YES	*/
-- ======================================================================
-- END OF EXPERIMENT
-- ======================================================================
