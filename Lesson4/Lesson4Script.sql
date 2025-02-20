--1

SELECT T.Name AS TeacherName, T.Surname AS TeacherSurname, G.Name AS GroupName
FROM Teachers T
CROSS JOIN Groups G;

--2

SELECT F.Name AS FacultyName
FROM Faculties F
WHERE F.Financing < (
    SELECT SUM(D.Financing)
    FROM Departments D
    WHERE D.FacultyId = F.Id
);

--3

SELECT C.Surname AS CuratorSurname, G.Name AS GroupName
FROM Curators C
JOIN GroupsCurators GC ON C.Id = GC.CuratorId
JOIN Groups G ON GC.GroupId = G.Id;

--4

SELECT T.Name AS TeacherName, T.Surname AS TeacherSurname
FROM Teachers T
JOIN Lectures L ON T.Id = L.TeacherId
JOIN GroupsLectures GL ON L.Id = GL.LectureId
JOIN Groups G ON GL.GroupId = G.Id
WHERE G.Name = 'P107';

--5

SELECT T.Surname AS TeacherSurname, F.Name AS FacultyName
FROM Teachers T
JOIN Lectures L ON T.Id = L.TeacherId
JOIN GroupsLectures GL ON L.Id = GL.LectureId
JOIN Groups G ON GL.GroupId = G.Id
JOIN Departments D ON G.DepartmentId = D.Id
JOIN Faculties F ON D.FacultyId = F.Id;

--6

SELECT D.Name AS DepartmentName, G.Name AS GroupName
FROM Departments D
JOIN Groups G ON D.Id = G.DepartmentId;

--7

SELECT S.Name AS SubjectName
FROM Subjects S
JOIN Lectures L ON S.Id = L.SubjectId
JOIN Teachers T ON L.TeacherId = T.Id
WHERE T.Name = 'Samantha' AND T.Surname = 'Adams';

--8

SELECT D.Name AS DepartmentName
FROM Departments D
JOIN Groups G ON D.Id = G.DepartmentId
JOIN GroupsLectures GL ON G.Id = GL.GroupId
JOIN Lectures L ON GL.LectureId = L.Id
JOIN Subjects S ON L.SubjectId = S.Id
WHERE S.Name = 'Database Theory';

--9

SELECT G.Name AS GroupName
FROM Groups G
JOIN Departments D ON G.DepartmentId = D.Id
JOIN Faculties F ON D.FacultyId = F.Id
WHERE F.Name = 'Computer Science';

--10

SELECT G.Name AS GroupName, F.Name AS FacultyName
FROM Groups G
JOIN Departments D ON G.DepartmentId = D.Id
JOIN Faculties F ON D.FacultyId = F.Id
WHERE G.Year = 5;

--11

SELECT
    T.Name AS TeacherName,
    T.Surname AS TeacherSurname,
    S.Name AS SubjectName,
    G.Name AS GroupName
FROM Teachers T
JOIN Lectures L ON T.Id = L.TeacherId
JOIN Subjects S ON L.SubjectId = S.Id
JOIN GroupsLectures GL ON L.Id = GL.LectureId
JOIN Groups G ON GL.GroupId = G.Id
WHERE L.LectureRoom = 'B103';