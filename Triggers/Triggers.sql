-- 1

CREATE TRIGGER trg_LimitStudents ON Student
AFTER INSERT
AS
BEGIN
    IF (SELECT COUNT(*) FROM Student WHERE GroupId IN (SELECT GroupId FROM inserted)) > 30
    BEGIN
        print('Max amount of 30 students exceeded');
        ROLLBACK;
    END
END;

-- 2

CREATE TRIGGER trg_UpdateStudentCount ON Student
AFTER INSERT, DELETE
AS
BEGIN
    UPDATE Group
    SET StudentsCount = (SELECT COUNT(*) FROM Student WHERE GroupId = Group.GroupId);
END;

-- 3

CREATE TRIGGER trg_AutoEnroll ON Student
AFTER INSERT
AS
BEGIN
    INSERT INTO Enrollment (StudentId, CourseId)
    SELECT StudentId, CourseId FROM inserted, Course WHERE Name = 'Introduction to Programming';
END;

-- 4

CREATE TRIGGER trg_LowGrade ON Grade
AFTER INSERT, UPDATE
AS
BEGIN
    INSERT INTO Warnings (StudentId, Reason, Date)
    SELECT StudentId, 'Low mark', GETDATE() FROM inserted WHERE Grade < 3;
END;

-- 5

CREATE TRIGGER trg_NoDeleteTeacher ON Teacher
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Course WHERE TeacherId IN (SELECT TeacherId FROM deleted))
    BEGIN
        print('Teacher has courses.');
        RETURN;
    END
    DELETE FROM Teacher WHERE TeacherId IN (SELECT TeacherId FROM deleted);
END;

-- 6

CREATE TRIGGER trg_GradeHistory ON Grade
AFTER UPDATE
AS
BEGIN
    INSERT INTO GradeHistory (StudentId, OldGrade, NewGrade, ChangeDate)
    SELECT d.StudentId, d.Grade, i.Grade, GETDATE() FROM deleted d JOIN inserted i ON d.StudentId = i.StudentId;
END;

-- 7

CREATE TRIGGER trg_Attendance ON Attendance
AFTER INSERT
AS
BEGIN
    INSERT INTO RetakeList (StudentId, Reason)
    SELECT StudentId, 'More than 5 skips'
    FROM Attendance
    WHERE Status = 'Absent'
    GROUP BY StudentId
    HAVING COUNT(*) > 5;
END;

-- 8

CREATE TRIGGER trg_NoDeleteStudent ON Student
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Payments WHERE StudentId IN (SELECT StudentId FROM deleted) AND Status = 'Unpaid')
    OR EXISTS (SELECT 1 FROM Grade WHERE StudentId IN (SELECT StudentId FROM deleted) AND Grade < 3)
    BEGIN
        print('Student has duties');
        RETURN;
    END
    DELETE FROM Student WHERE StudentId IN (SELECT StudentId FROM deleted);
END;

-- 9

CREATE TRIGGER trg_UpdateGPA ON Grade
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE Student
    SET GPA = (SELECT AVG(Grade) FROM Grade WHERE StudentId = Student.StudentId);
END;
