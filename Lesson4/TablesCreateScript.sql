create table Faculties(
    Id INT IDENTITY(1,1) PRIMARY KEY not null,
    Financing MONEY DEFAULT 0 CHECK (Financing >= 0) not null,
    Name NVARCHAR(100) UNIQUE CHECK (LEN(Name) > 0) not null
)

create table Departments(
    Id INT IDENTITY(1,1) PRIMARY KEY not null,
    Financing MONEY CHECK (Financing >= 0) DEFAULT 0 not null,
    Name NVARCHAR(100) UNIQUE CHECK(LEN(Name) > 0) not null,
    FacultyId INT not null FOREIGN KEY REFERENCES Faculties(Id)
)

create table Curators(
    Id INT IDENTITY(1,1) PRIMARY KEY not null,
    Name NVARCHAR(max) CHECK(LEN(Name) > 0) not null,
    Surname NVARCHAR(max) CHECK(LEN(Surname) > 0) not null
)

create table Groups(
    Id INT IDENTITY(1,1) PRIMARY KEY not null,
    Name NVARCHAR(100) UNIQUE CHECK(LEN(Name) > 0) not null,
    Year INT CHECK (Year >= 1 AND Year <=5) not null,
    DepartmentId INT not null FOREIGN KEY REFERENCES Departments(Id)
)

create table GroupsCurators(
    Id INT IDENTITY(1,1) PRIMARY KEY not null,
    CuratorId INT not null FOREIGN KEY REFERENCES Curators(Id),
    GroupId INT not null FOREIGN KEY REFERENCES Groups(Id)
)

create table Subjects(
    Id INT IDENTITY(1,1) PRIMARY KEY not null,
    Name NVARCHAR(100) UNIQUE CHECK (LEN(Name) > 0) not null
)

create table Teachers(
    Id INT IDENTITY(1,1) PRIMARY KEY not null,
    Name NVARCHAR(max) CHECK(LEN(Name) > 0) not null,
    Salary MONEY CHECK (Salary >= 0),
    Surname NVARCHAR(max) not null
)

create table Lectures(
    Id INT IDENTITY(1,1) PRIMARY KEY not null,
    LectureRoom NVARCHAR(max) CHECK (LEN(LectureRoom) > 0) not null,
    SubjectId INT not null FOREIGN KEY REFERENCES Subjects(Id),
    TeacherId INT not null FOREIGN KEY REFERENCES Teachers(Id)
)

create table GroupsLectures(
    Id INT IDENTITY(1,1) PRIMARY KEY not null,
    GroupId INT not null FOREIGN KEY REFERENCES Groups(Id),
    LectureId INT not null FOREIGN KEY REFERENCES Lectures(Id)

)