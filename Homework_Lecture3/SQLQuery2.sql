-- HOMEWORK PART 1

--Calculate the count of all grades in the system​
select count(Grade) as allGrades
from dbo.Grade
go

--Calculate the count of all grades per Teacher in the system​
select t.FirstName as TeacherName,t.LastName, count(Grade) as Grades
from dbo.Grade g
inner join dbo.Teacher t on t.ID = g.TeacherID
group by t.FirstName,t.LastName
order by Grades
go

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)​
select t.FirstName as TeacherName,t.LastName, count(Grade) as Grades
from dbo.Grade g
inner join dbo.Teacher t on t.ID = g.TeacherID
where g.StudentID < 100
group by t.FirstName,t.LastName
order by Grades
go

--Find the Maximal Grade, and the Average Grade per Student on all grades in the system
select s.FirstName,s.LastName, max(Grade) as MaxGrade, CAST(AVG(Grade) AS DECIMAL(10,2)) as AvgGrade
from dbo.Grade g
inner join dbo.Student s on s.ID = g.StudentID
group by s.FirstName,s.LastName
go

--------------------------------------------------------------------------------------------
--HOMEWORK PART 2

--Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200​
select t.FirstName,t.LastName, count(Grade) as TotalGrades
from dbo.Grade g
inner join dbo.Teacher t on t.ID = g.TeacherID
group by t.FirstName,t.LastName
having count(Grade) > 200
go

--Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count​
select t.FirstName as TeacherName,t.LastName as TeacherLastName, count(Grade) as AllGrades
from dbo.Grade g
inner join dbo.Teacher t on t.ID = g.TeacherID
where g.StudentID < 100
group by t.FirstName,t.LastName
having count(Grade) > 50
go

--Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade​

select s.FirstName, s.LastName, count(Grade) as AllGrades, max(Grade) as MaxGrade, avg(Grade) as AvgGrade
from dbo.Grade g
inner join dbo.Student s on s.ID = g.StudentID
group by s.FirstName,s.LastName
having max(Grade) = avg(Grade)
go

--List Student First Name and Last Name next to the other details from previous query
-- vekje gore e napraveno :D

---------------------------------------------------------------------------------------------------------------------------
-- HOMEWORK PART 3
--Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student​
create view vv_StudentGrades
as
select g.StudentID, count(Grade) as AllGrades
from dbo.Grade g
group by g.StudentID
go

--Change the view to show Student First and Last Names instead of StudentID​
alter view vv_StudentGrades
as
select s.FirstName as StudentName,s.LastName as StudentLastName,count(Grade) as AllGrades
from dbo.Grade g
inner join dbo.Student s on s.ID = g.StudentID
group by s.FirstName,s.LastName
go

--List all rows from view ordered by biggest Grade Count​​
select * from vv_StudentGrades
order by AllGrades desc
go

--Create new view (vv_StudentGradeDetails) that will
--List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit)

create view vv_StudentGradeDetails
as
select s.FirstName,s.LastName, count(AchievementTypeID) as AllExams
from dbo.Grade g
inner join dbo.Student s on s.ID = g.StudentID
inner join dbo.GradeDetails gd on gd.GradeID = g.ID
inner join dbo.AchievementType a on a.ID = gd.AchievementTypeID
where gd.AchievementTypeID = 5
group by s.FirstName,s.LastName
go
