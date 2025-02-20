-- 1

SELECT Building FROM Departments GROUP BY Building HAVING SUM(Financing) > 100000;

-- 2

SELECT G.Name FROM Groups G
JOIN Departments D ON G.DepartmentId = D.Id
JOIN GroupsLectures GL ON G.Id = GL.GroupId
JOIN Lectures L ON GL.LectureId = L.Id
WHERE G.Year = 5 AND D.Name = 'Software Development' AND DATEDIFF(DAY, L.Date, GETDATE()) <= 7
GROUP BY G.Name HAVING COUNT(L.Id) > 10;

-- 3

SELECT G.Name FROM Groups G
JOIN GroupsStudents GS ON G.Id = GS.GroupId
JOIN Students S ON GS.StudentId = S.Id
GROUP BY G.Name HAVING AVG(S.Rating) > (SELECT AVG(S.Rating) FROM GroupsStudents GS
JOIN Students S ON GS.StudentId = S.Id
JOIN Groups G ON GS.GroupId = G.Id WHERE G.Name = 'D221');

-- 4

SELECT Name, Surname FROM Teachers WHERE Salary > (SELECT AVG(Salary) FROM Teachers WHERE IsProfessor = 1);

-- 5

SELECT G.Name FROM Groups G
JOIN GroupsCurators GC ON G.Id = GC.GroupId
GROUP BY G.Name HAVING COUNT(GC.CuratorId) > 1;

-- 6

SELECT G.Name FROM Groups G
JOIN GroupsStudents GS ON G.Id = GS.GroupId
JOIN Students S ON GS.StudentId = S.Id
GROUP BY G.Name HAVING AVG(S.Rating) < (SELECT MIN(S.Rating) FROM Groups G
JOIN GroupsStudents GS ON G.Id = GS.GroupId
JOIN Students S ON GS.StudentId = S.Id WHERE G.Year = 5 GROUP BY G.Id);

-- 7

SELECT F.Name FROM Faculties F
JOIN Departments D ON F.Id = D.FacultyId
GROUP BY F.Name HAVING SUM(D.Financing) > (SELECT SUM(D.Financing) FROM Departments D
JOIN Faculties F ON D.FacultyId = F.Id WHERE F.Name = 'Computer Science');

-- 8

SELECT S.Name, T.Name FROM Lectures L
JOIN Subjects S ON L.SubjectId = S.Id
JOIN Teachers T ON L.TeacherId = T.Id
GROUP BY S.Name, T.Name ORDER BY COUNT(L.Id) desc;

-- 9

SELECT TOP 1 S.Name FROM Lectures L
JOIN Subjects S ON L.SubjectId = S.Id
GROUP BY S.Name ORDER BY COUNT(L.Id) asc;

-- 10

SELECT COUNT(GS.StudentId) AS StudentCount, COUNT(L.SubjectId) AS SubjectCount
FROM Departments D
JOIN Groups G ON D.Id = G.DepartmentId
JOIN GroupsStudents GS ON G.Id = GS.GroupId
JOIN GroupsLectures GL ON G.Id = GL.GroupId
JOIN Lectures L ON GL.LectureId = L.Id
WHERE D.Name = 'Software Development';
