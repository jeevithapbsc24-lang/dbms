CREATE DATABASE UniversityDB;
USE UniversityDB;

CREATE TABLE Students (
StudentID INT PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Email VARCHAR(100),
DepartmentID INT
);

CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
DepartmentName VARCHAR(100)
);

CREATE TABLE Courses (
CourseID INT PRIMARY KEY AUTO_INCREMENT,
CourseName VARCHAR(100),
DepartmentID INT,
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Professors (
ProfessorID INT PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(50),
LastName VARCHAR(50),
DepartmentID INT,
Salary DECIMAL(10,2),
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Enrollments (
EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
StudentID INT,
CourseID INT,
EnrollmentDate DATE,
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Departments (DepartmentName) VALUES
('Computer Science'),
('Mathematics'),
('Physics'),
('English'),
('Business Administration');

select * from Departments;

INSERT INTO Students (FirstName, LastName, Email, DepartmentID) VALUES
('John','Doe','john.doe@email.com',1),
('Alice','Smith','alice.smith@email.com',2),
('Robert','Brown','robert.brown@email.com',3),
('Emily','Johnson','emily.johnson@email.com',1),
('David','Williams','david.williams@email.com',4);

INSERT INTO Courses (CourseName, DepartmentID) VALUES
('Database Systems',1),
('Calculus I',2),
('Quantum Mechanics',3),
('English Literature',4),
('Marketing Principles',5);

INSERT INTO Professors (FirstName, LastName, DepartmentID, Salary) VALUES
('Dr. Sarah','Lee',1,75000.00),
('Dr. James','Miller',2,72000.00),
('Dr. Anna','White',3,70000.00),
('Dr. Paul','Taylor',4,71000.00),
('Dr. Linda','Clark',5,73000.00);

-- Insert sample data into Enrollments
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
(1,1,'2024-09-01'),
(2,2,'2024-09-02'),
(3,3,'2024-09-03'),
(4,1,'2024-09-04'),
(5,4,'2024-09-05');

ALTER TABLE Students ADD PhoneNumber VARCHAR(15);

ALTER TABLE Courses MODIFY CourseName VARCHAR(150);

ALTER TABLE Professors DROP COLUMN Salary;



