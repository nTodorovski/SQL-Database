--HOMEWORK PART 1

--Find all Students with FirstName = Antonio​
SELECT * 
FROM dbo.Student
WHERE FirstName = 'Antonio'
GO

--Find all Students with DateOfBirth greater than ‘01.01.1999’​
SELECT * 
FROM dbo.Student
WHERE DateOfBirth > '1999.01.01'
GO

--Find all Male students​
SELECT * 
FROM dbo.Student
WHERE Gender = 'M'
GO

--Find all Students with LastName starting With ‘T’​
SELECT * 
FROM dbo.Student
WHERE LastName like 'T%'
GO

--Find all Students Enrolled in January/1998​
SELECT * 
FROM dbo.Student
WHERE year(EnrolledDate) = 1998 and month(EnrolledDate) = 01
GO

--Find all Students with LastName starting With ‘J’ enrolled in January/1998​
SELECT * 
FROM dbo.Student
WHERE LastName like 'J%'
and year(EnrolledDate) = 1998 
and month(EnrolledDate) = 01
GO
---------------------------------------------------------------------------------------
--HOMEWORK PART 2

--Find all Students with FirstName = Antonio ordered by Last Name​
SELECT * 
FROM dbo.Student
WHERE FirstName = 'Antonio'
ORDER BY LastName
GO

--List all Students ordered by FirstName​
SELECT * 
FROM dbo.Student
ORDER BY FirstName
GO

--Find all Male students ordered by EnrolledDate, starting from the last enrolled​
SELECT * 
FROM dbo.Student
WHERE Gender = 'M'
ORDER BY EnrolledDate DESC
GO
----------------------------------------------------------------------------------
--HOMEWORK PART 3

--List all Teacher First Names and Student First Names in single result set with duplicates​
SELECT FirstName 
FROM dbo.Teacher
UNION ALL
SELECT FirstName
FROM dbo.Student
GO

--List all Teacher Last Names and Student Last Names in single result set. Remove duplicates​
SELECT LastName 
FROM dbo.Teacher
UNION
SELECT LastName
FROM dbo.Student
GO

--List all common First Names for Teachers and Students
SELECT LastName 
FROM dbo.Teacher
INTERSECT
SELECT LastName
FROM dbo.Student
GO
---------------------------------------------------------------------------------------------
-- HOMEWORK PART 4

--Change GradeDetails table always to insert value 100 in AchievementMaxPoints column if no value is provided on insert​
ALTER TABLE GradeDetails
ADD CONSTRAINT DF_GradeDetails
DEFAULT 100 FOR [AchievementMaxPoints]
GO

--Change GradeDetails table to prevent inserting AchievementPoints that will more than AchievementMaxPoints​

-- Na ova mi pravi problemi
ALTER TABLE [dbo].[GradeDetails] WITH CHECK
ADD CONSTRAINT CHK_Grade_Details
CHECK (AchievementPoints < AchievementMaxPoints);
GO

--Change AchievementType table to guarantee unique names across the Achievement types
ALTER TABLE [dbo].AchievementType WITH CHECK
ADD CONSTRAINT UQ_AchievementType
UNIQUE (Name);
GO
---------------------------------------------------------------------------------------
-- HOMEWORK PART 5

ALTER TABLE [dbo].[Grade] DROP CONSTRAINT [FK_Grade_Course];
ALTER TABLE [dbo].[Grade] DROP CONSTRAINT [FK_Grade_Teacher];
ALTER TABLE [dbo].[Grade] DROP CONSTRAINT [FK_Grade_Student] 
ALTER TABLE [dbo].[GradeDetails] DROP CONSTRAINT [FK_GradeDetails_AchievementType] 
ALTER TABLE [dbo].[GradeDetails] DROP CONSTRAINT [FK_GradeDetails_Grade]
--Create Foreign key constraints from diagram or with script
ALTER TABLE [dbo].[Grade] ADD CONSTRAINT [FK_Grade_Course] FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Course]([ID]);
ALTER TABLE [dbo].[Grade] ADD CONSTRAINT [FK_Grade_Teacher] FOREIGN KEY ([TeacherID]) REFERENCES [dbo].[Teacher]([ID]);
ALTER TABLE [dbo].[Grade] ADD CONSTRAINT [FK_Grade_Student] FOREIGN KEY ([StudentID]) REFERENCES [dbo].[Student]([ID]);
ALTER TABLE [dbo].[GradeDetails] ADD CONSTRAINT [FK_GradeDetails_AchievementType] FOREIGN KEY ([AchievementTypeID]) REFERENCES [dbo].[AchievementType]([ID]);
ALTER TABLE [dbo].[GradeDetails] ADD CONSTRAINT [FK_GradeDetails_Grade] FOREIGN KEY ([GradeID]) REFERENCES [dbo].[Grade]([ID]);

------------------------------------------------------------------------------------------------------------------------
-- HOMEWORK PART 6
--List all possible combinations of Courses names and AchievementType names that can be passed by student​
select c.Name as CourseName,a.Name as AchievementTypeName
from dbo.Course c
cross join dbo.AchievementType a
GO

--List all Teachers that has any exam Grade​
select DISTINCT t.FirstName
from dbo.[Teacher] t
inner join dbo.Grade g on g.TeacherID = t.ID
GO

--List all Teachers without exam Grade​
select DISTINCT t.FirstName
from dbo.Teacher t
left join dbo.[Grade] g on t.ID = g.TeacherID
where g.TeacherID is null
GO

--List all Students without exam Grade (using Right Join)
select s.FirstName as StudentName
from dbo.[Student] s
right join dbo.Grade g on g.StudentID = s.ID
where g.Grade is null
GO