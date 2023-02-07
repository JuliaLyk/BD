USE UNIVER
--1--
SELECT min(AUDITORIUM_CAPACITY) [��� �����������],
       max(AUDITORIUM_CAPACITY) [���� �����������],
	   avg(AUDITORIUM_CAPACITY) [������� �����������],
	   sum(AUDITORIUM_CAPACITY) [��������� �����������],
	   count(*) [���-�� ���������]
From AUDITORIUM

--2--

SELECT AUDITORIUM_TYPE.AUDITORIUM_TYPENAME,
       min(AUDITORIUM_CAPACITY) [����������� ����������� ���������],
       max(AUDITORIUM_CAPACITY) [������������ ����������� ���������],
	   avg(AUDITORIUM_CAPACITY) [������� ����������� ���������],
	   sum(AUDITORIUM_CAPACITY) [��������� ����������� ���������],
	   count(*) [����� ���-�� ���������]
From AUDITORIUM Inner Join AUDITORIUM_TYPE
On AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
   GROUP BY AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
--3--
   SELECT *
FROM(SELECT CASE 
WHEN NOTE between 8 and 9 then '8-9'
WHEN NOTE between 6 and 7 then '6-7'
WHEN NOTE between 4 and 5 then '4-5'
else '������ 4'
end [������],count(*)[����������]
FROM PROGRESS group by case
WHEN NOTE between 8 and 9 then '8-9'
WHEN NOTE between 6 and 7 then '6-7'
WHEN NOTE between 4 and 5 then '4-5'
else '������ 4'
end) as T
order by Case[������]
when '4-5' then 3
when '6-7' then 2
when '8-9' then 1
when '������ 4' then 4
else 0
end

--4--
SELECT PROGRESS.NOTE,FACULTY.FACULTY_NAME,GROUPS.PROFESSION,
round(avg(PROGRESS.NOTE AS FLOAT (4)),2)
FROM PROGRESS.NOTE INNER JOIN 

FROM PROGRESS.NOTE INNER JOIN 
select FACULTY.FACULTY, GROUPS.PROFESSION, (2014 - GROUPS.YEAR_FIRST)[����],
round(avg(cast(PROGRESS.NOTE as float(4))),2)[������� ������] 

from FACULTY
inner join GROUPS  on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT  on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
group by FACULTY.FACULTY,
	     GROUPS.PROFESSION,
		 GROUPS.YEAR_FIRST
order by [������� ������] desc;
/*4.2*/
USE UNIVER
select FACULTY.FACULTY, GROUPS.PROFESSION, (2014 - GROUPS.YEAR_FIRST)[����],
PROGRESS.SUBJECT [SUBJECT],
round(avg(cast(PROGRESS.NOTE as float(4))),2)[������� ������] 


from FACULTY
inner join GROUPS  on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT  on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
Where PROGRESS.SUBJECT='��'or PROGRESS.SUBJECT='����'
group by FACULTY.FACULTY,
	     GROUPS.PROFESSION,
		 GROUPS.YEAR_FIRST,
		 PROGRESS.SUBJECT
order by [������� ������] desc;
