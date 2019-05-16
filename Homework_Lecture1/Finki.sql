CREATE TABLE [dbo].[Teacher](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[AcademyRank] [nvarchar](50) NOT NULL,
	[HireDate] [date] NOT NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].[Student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[EnrolledDate] [date] NOT NULL,
	[Gender] [nchar](1) NULL,
	[NationalIdNumber] [nvarchar](13) NOT NULL,
	[StudentCardNumber] [nvarchar] (20) NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].[Course](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Credit] [decimal](2,1) NOT NULL,
	[AcademicYear] [nvarchar](9) NOT NULL,
	[Semester] [nvarchar] (10) NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].[Grade](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[CourseId] [smallint] NOT NULL,
	[TeacherId] [smallint] NOT NULL,
	[Grade] [tinyint] NOT NULL,
	[Comment] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].[AchievementType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar] (50) NOT NULL,
	[Description] [nvarchar](MAX) NOT NULL,
	[ParticipationRate] [decimal](4,2) NOT NULL,
 CONSTRAINT [PK_AchievementType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].[GradeDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GradeId] [int] NOT NULL,
	[AchievementTypeId] [int] NOT NULL,
	[AchievementPoints] [smallint] NOT NULL,
	[AchievementMaxPoints] [smallint] NOT NULL,
	[AchievementDate] [date] NOT NULL,
 CONSTRAINT [PK_GradeDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO