CREATE TABLE Departments (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Financing MONEY CHECK (Financing >= 0) DEFAULT 0 not null,
    Name NVARCHAR(100) UNIQUE CHECK (LEN(Name) > 0) not null
);

CREATE TABLE Faculties (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Dean NVARCHAR(MAX) CHECK (LEN(Dean) > 0) not null,
    Name NVARCHAR(100) UNIQUE CHECK (LEN(Name) > 0) not null
);

CREATE TABLE Groups (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(10) UNIQUE CHECK (LEN(Name) > 0) not null,
    Rating INT CHECK (Rating >= 0 AND Rating <= 5) not null,
    Year INT CHECK (Year >= 1 AND Year <= 5) not null
);

CREATE TABLE Teachers (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    EmploymentDate DATE NOT NULL CHECK (EmploymentDate >= '1990-01-01'),
    IsAssistant BIT DEFAULT 0 not null,
    IsProfessor BIT DEFAULT 0 not null,
    Name NVARCHAR(MAX) CHECK (LEN(Name) > 0) not null,
    Position NVARCHAR(MAX) CHECK (LEN(Position) > 0) not null,
    Premium MONEY CHECK (Premium >= 0) DEFAULT 0 not null,
    Salary MONEY CHECK (Salary > 0) not null,
    Surname NVARCHAR(MAX) CHECK (LEN(Surname) > 0) not null
);


-- 1.

SELECT Name, Financing, Id FROM Departments;

-- 2.

SELECT Name AS "Name1", Rating AS "Rating1" FROM Groups;

-- 3.

SELECT Surname, 
       (Salary / Premium) * 100 AS SalaryToPremiumPercentage,
       (Salary / (Salary + Premium)) * 100 AS SalaryTotalPercentage
FROM Teachers;

-- 4.

SELECT CONCAT('The dean of faculty ', Name, ' is ', Dean, '.') AS FacultyInfo FROM Faculties;

-- 5.

SELECT Surname FROM Teachers WHERE IsProfessor = 1 AND Salary > 1050;

-- 6.

SELECT Name FROM Departments WHERE Financing < 11000 OR Financing > 25000;

-- 7.

SELECT Name FROM Faculties WHERE Name <> 'Computer Science';

-- 8.

SELECT Surname, Position FROM Teachers WHERE IsProfessor = 0;

-- 9.

SELECT Surname, Position, Salary, Premium FROM Teachers WHERE IsAssistant = 1 AND (Premium >= 160 AND Premium <= 550);

-- 10.

SELECT Surname, Salary FROM Teachers WHERE IsAssistant = 1;

-- 11.

SELECT Surname, Position FROM Teachers WHERE EmploymentDate < '2000-01-01';

-- 12.

SELECT Name AS "Name of Department" FROM Departments WHERE Name < 'Software Development';

-- 13.

SELECT Surname FROM Teachers WHERE IsAssistant = 1 AND (Salary + Premium) <= 1200;

-- 14.

SELECT Name FROM Groups WHERE Year = 5 AND (Rating >= 2 AND Rating <= 4);

-- 15.

SELECT Surname FROM Teachers WHERE IsAssistant = 1 AND (Salary < 550 OR Premium < 200);