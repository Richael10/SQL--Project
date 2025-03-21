-- 1️⃣ Create a Database (Check if it exists first)
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'CompanyDB')
BEGIN
    CREATE DATABASE CompanyDB;
END;
GO
USE CompanyDB;
GO

-- 2️⃣ Create the Employees Table
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;
GO

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);
GO

-- 3️⃣ Insert Sample Data
INSERT INTO Employees (FirstName, LastName, Department, Salary, HireDate)
VALUES
('John', 'Doe', 'Finance', 5000.00, '2021-06-15'),
('Jane', 'Smith', 'IT', 6200.50, '2020-09-20'),
('Michael', 'Johnson', 'HR', 4800.75, '2019-12-05'),
('Emily', 'Davis', 'Marketing', 5300.00, '2022-03-10'),
('Robert', 'Brown', 'Operations', 5700.25, '2018-07-25'),
('Sarah', 'Miller', 'Finance', 6200.00, '2023-02-14'),
('David', 'Wilson', 'IT', 7000.80, '2021-11-01'),
('Laura', 'Taylor', 'HR', 4700.60, '2019-09-30'),
('Daniel', 'Anderson', 'Marketing', 5500.00, '2022-07-18'),
('Sophia', 'Thomas', 'Operations', 5900.90, '2020-05-21');
GO

-- 4️⃣ Display the Table
SELECT * FROM Employees;
GO

WITH CTE AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY FirstName, LastName, Department ORDER BY EmployeeID) AS RowNum
    FROM Employees
)
DELETE FROM Employees WHERE EmployeeID IN (SELECT EmployeeID FROM CTE WHERE RowNum > 1);

UPDATE Employees
SET Salary = 5000.00
WHERE Salary IS NULL;

UPDATE Employees
SET Department = 'Unknown'
WHERE Department IS NULL;

UPDATE Employees
SET FirstName = LTRIM(RTRIM(FirstName)),
    LastName = LTRIM(RTRIM(LastName));
UPDATE Employees
SET HireDate = FORMAT(HireDate, 'yyyy-MM-dd');

UPDATE Employees
SET HireDate = FORMAT(HireDate, 'yyyy-MM-dd');

UPDATE Employees
SET Salary = 4000
WHERE Salary < 4000;

SELECT * FROM Employees  
ORDER BY FirstName ASC;

SELECT * FROM Employees  
ORDER BY Salary DESC;

SELECT *,  
       CASE  
           WHEN Salary > 5000 THEN 'Tax Free'  
           ELSE 'Taxable'  
       END AS TaxStatus  
FROM Employees;
