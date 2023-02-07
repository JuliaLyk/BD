use UNIVER
----1----
GO
CREATE VIEW [Преподаватели]
as select TEACHER,TEACHER_NAME,GENDER,PULPIT
FROM TEACHER;
SELECT * FROM Преподаватели
GO
--DROP VIEW [Преподаватели]
----2----
GO
CREATE VIEW [Количество кафедр]
as select FACULTY.FACULTY_NAME,PULPIT.PULPIT
from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
GO
SELECT * FROM [Количество кафедр]
--DROP view [Количество кафедр]
--3--
GO
CREATE VIEW Аудитории(AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_TYPE)
as select AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM_TYPE like'ЛК'
GO
select *from Аудитории
INSERT Аудитории VALUES ('207-1','207-1','ЛК')

--DROP VIEW Аудитории



--4--
go
CREATE view [Лекционные_аудитории]
as select AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM_TYPE like'ЛК'with check option;
GO
INSERT [Лекционные_аудитории] VALUES ('208-1','208-1','ЛБ-К')
SELECT*FROM [Лекционные_аудитории]
--5--
go
CREATE VIEW [Дисциплины]
as select top 20 SUBJECT_NAME[Дисциплины], SUBJECT,SUBJECT.PULPIT
from SUBJECT
order by SUBJECT_NAME
go
select*from [Дисциплины]
--6--
GO
alter view  [Количество кафедр] with schemabinding
as select FACULTY.FACULTY_NAME,PULPIT.PULPIT
from dbo.FACULTY join dbo.PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
GO

------------
go
ALTER view [Лекционные_аудитории]
as select AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM_TYPE like 'ЛК-К'with check option;
GO
SELECT*FROM [Лекционные_аудитории]




