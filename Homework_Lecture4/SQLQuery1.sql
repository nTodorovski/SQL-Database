--HOMEWORK PART 1
--Declare scalar variable for storing FirstName values​

--Assign value ‘Antonio’ to the FirstName variable​

--Find all Students having FirstName same as the variable​
declare @FirstName nvarchar(100)
set @FirstName = 'Antonio'

select *
from dbo.Student
where FirstName = @FirstName
go


--Declare table variable that will contain StudentId, StudentName and DateOfBirth​

--Fill the table variable with all Female students​
DECLARE @StudentList TABLE 
(StudentId int, FirstName NVARCHAR(100), DateOfBirth date);

insert into @StudentList
select Id,FirstName,DateOfBirth
from dbo.Student
where Gender = 'F'

--Declare temp table that will contain LastName and EnrolledDate columns​

--Fill the temp table with all Male students having First Name starting with ‘A’​

--Retrieve the students from the table which last name is with 7 characters​
CREATE TABLE #StudentList 
(LastName NVARCHAR(100), EnrolledDate date);

INSERT INTO #StudentList
SELECT LastName, EnrolledDate 
from dbo.Student
where FirstName like 'A%'

SELECT * 
FROM #StudentList
where Len(LastName) = 7
go
-----------------------------------------------------------------------
--HOMEWORK PART 2
--Declare scalar function (fn_FormatStudentName) for retrieving the Student description for specific StudentId in the following format:​

--StudentCardNumber without “sc-”​ “ – “​

--First character of student FirstName​ “.”​

--Student LastName
CREATE FUNCTION dbo.fn_FormatStudentName (@StudentId int)
RETURNS Nvarchar(100)
AS 
BEGIN

DECLARE @Output Nvarchar(100)

select @Output = RIGHT(StudentCardNumber,5) +  N' - ' + LEFT(FirstName,1) + N'.' + LastName
from dbo.Student
where id = @StudentId

RETURN @Output

END
GO

select *,dbo.fn_FormatStudentName (ID) as FunctionOutput
from dbo.Student
go
-----------------------------------------------------------------------------------------------
--HOMEWORK PART 3
--Create multi-statement table value function that for specific Teacher and Course will return list of students (FirstName, LastName) who passed the exam, together with Grade and CreatedDate​
CREATE FUNCTION dbo.fn_ListOfStudents (@TeacherId int,@CourseId int)
RETURNS @output TABLE (StudentName nvarchar(100),Grade int, CreatedDate date)
AS
BEGIN
INSERT INTO @output
select s.FirstName + N' ' + s.LastName as StudentName, g.Grade as Grade ,g.CreatedDate as CreatedDate
from dbo.[Grade] g
inner join dbo.Teacher t on t.ID = g.TeacherID
inner join dbo.Course c on c.ID = g.CourseID
inner join dbo.Student s on s.ID = g.StudentID
where g.TeacherID = @TeacherId
and g.CourseID = @CourseId
group by s.FirstName,s.LastName,g.Grade,g.CreatedDate

RETURN 
END

GO


declare @CourseId int = 2
declare @TeacherId int = 84

select * from dbo.fn_ListOfStudents(@TeacherId,@CourseId)