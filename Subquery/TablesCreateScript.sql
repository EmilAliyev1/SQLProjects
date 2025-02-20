CREATE TABLE Curators (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(MAX) CHECK (LEN(Name) > 0) not null,
    Surname NVARCHAR(MAX) CHECK (LEN(Surname) > 0) not null
);

CREATE TABLE Faculties (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) UNIQUE CHECK (LEN(Name) > 0) not null
);

CREATE TABLE Departments (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Building INT CHECK (Building BETWEEN 1 AND 5) not null,
    Financing MONEY CHECK (Financing >= 0) DEFAULT 0 not null,
    Name NVARCHAR(100) UNIQUE CHECK (LEN(Name) > 0) not null,
    FacultyId INT not null,
    FOREIGN KEY (FacultyId) REFERENCES Faculties(Id)
);

CREATE TABLE Groups (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(10) UNIQUE CHECK (LEN(Name) > 0) not null,
    Year INT CHECK (Year BETWEEN 1 AND 5) not null,
    DepartmentId INT not null,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);

CREATE TABLE GroupsCurators (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CuratorId INT not null,
    GroupId INT not null,
    FOREIGN KEY (CuratorId) REFERENCES Curators(Id),
    FOREIGN KEY (GroupId) REFERENCES Groups(Id)
);

CREATE TABLE Students (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(MAX) CHECK (LEN(Name) > 0) not null,
    Surname NVARCHAR(MAX) CHECK (LEN(Surname) > 0) not null,
    Rating INT CHECK (Rating BETWEEN 0 AND 5) not null
);

CREATE TABLE GroupsStudents (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    GroupId INT not null,
    StudentId INT not null,
    FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    FOREIGN KEY (StudentId) REFERENCES Students(Id)
);

CREATE TABLE Subjects (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) UNIQUE CHECK (LEN(Name) > 0) not null
);

CREATE TABLE Teachers (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IsProfessor BIT DEFAULT 0 not null,
    Name NVARCHAR(MAX) CHECK (LEN(Name) > 0) not null,
    Surname NVARCHAR(MAX) CHECK (LEN(Surname) > 0) not null,
    Salary MONEY CHECK (Salary > 0) not null
);

CREATE TABLE Lectures (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Date DATE CHECK (Date <= GETDATE()) not null,
    SubjectId INT not null,
    TeacherId INT not null,
    FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
    FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);

CREATE TABLE GroupsLectures (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    GroupId INT not null,
    LectureId INT not null,
    FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    FOREIGN KEY (LectureId) REFERENCES Lectures(Id)
);