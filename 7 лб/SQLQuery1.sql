use UNIVER
----1----
GO
CREATE VIEW [�������������]
as select TEACHER,TEACHER_NAME,GENDER,PULPIT
FROM TEACHER;
SELECT * FROM �������������
GO
--DROP VIEW [�������������]
----2----
GO
CREATE VIEW [���������� ������]
as select FACULTY.FACULTY_NAME,PULPIT.PULPIT
from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
GO
SELECT * FROM [���������� ������]
--DROP view [���������� ������]
--3--
GO
CREATE VIEW ���������(AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_TYPE)
as select AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM_TYPE like'��'
GO
select *from ���������
INSERT ��������� VALUES ('207-1','207-1','��')

--DROP VIEW ���������



--4--
go
CREATE view [����������_���������]
as select AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM_TYPE like'��'with check option;
GO
INSERT [����������_���������] VALUES ('208-1','208-1','��-�')
SELECT*FROM [����������_���������]
--5--
go
CREATE VIEW [����������]
as select top 20 SUBJECT_NAME[����������], SUBJECT,SUBJECT.PULPIT
from SUBJECT
order by SUBJECT_NAME
go
select*from [����������]
--6--
GO
alter view  [���������� ������] with schemabinding
as select FACULTY.FACULTY_NAME,PULPIT.PULPIT
from dbo.FACULTY join dbo.PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
GO

------------
go
ALTER view [����������_���������]
as select AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM_TYPE like '��-�'with check option;
GO
SELECT*FROM [����������_���������]




