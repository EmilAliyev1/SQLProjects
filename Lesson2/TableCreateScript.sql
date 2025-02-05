create table Departments(
    Id INT IDENTITY(1,1) PRIMARY KEY not null,
    Financing MONEY CHECK (Financing >= 0) DEFAULT 0 not null,
    Name NVARCHAR(100) UNIQUE CHECK (LEN(Name) > 0) not null
)

create table Faculties(
    Id INT IDENTITY(1,1) PRIMARY KEY not null,
    Name NVARCHAR(100) UNIQUE not null
)

create table Groups(
    Id INT IDENTITY(1,1) PRIMARY KEY not null,
    Name NVARCHAR(100) UNIQUE CHECK (LEN(Name) > 0) not null,
    Rating INT CHECK (Rating >= 0 AND Rating <=5) not null,
    Year INT CHECK (Year >= 1 AND Year <=5) not null
)

create table Teachers(
    Id INT IDENTITY(1,1) PRIMARY KEY not null,
    EmploymentDate DATE CHECK (EmploymentDate >=  '01.01.1990') not null,
    Name NVARCHAR(100) CHECK (LEN(Name) > 0) not null,
    Position NVARCHAR(max) not null,
    Premium MONEY DEFAULT 0 CHECK (Premium >= 0) not null,
    Salary MONEY CHECK (Salary >= 0),
    Surname NVARCHAR(100) CHECK (LEN(Surname) > 0) not null
)