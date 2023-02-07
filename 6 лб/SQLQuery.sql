USE UNIVER
--1--
SELECT min(AUDITORIUM_CAPACITY) [Мин вместимотсь],
       max(AUDITORIUM_CAPACITY) [Макс вместимотсь],
	   avg(AUDITORIUM_CAPACITY) [Средняя вместимотсь],
	   sum(AUDITORIUM_CAPACITY) [Суммарная вместимотсь],
	   count(*) [кол-во аудитории]
From AUDITORIUM

--2--

SELECT AUDITORIUM_TYPE.AUDITORIUM_TYPENAME,
       min(AUDITORIUM_CAPACITY) [Минимальная вместимотсь аудитории],
       max(AUDITORIUM_CAPACITY) [Максимальная вместимотсь аудитории],
	   avg(AUDITORIUM_CAPACITY) [Средняя вместимотсь аудитории],
	   sum(AUDITORIUM_CAPACITY) [Суммарная вместимотсь аудитории],
	   count(*) [Общее кол-во аудитории]
From AUDITORIUM Inner Join AUDITORIUM_TYPE
On AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
   GROUP BY AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
--3--
   SELECT *
FROM(SELECT CASE 
WHEN NOTE between 8 and 9 then '8-9'
WHEN NOTE between 6 and 7 then '6-7'
WHEN NOTE between 4 and 5 then '4-5'
else 'меньше 4'
end [Оценка],count(*)[количество]
FROM PROGRESS group by case
WHEN NOTE between 8 and 9 then '8-9'
WHEN NOTE between 6 and 7 then '6-7'
WHEN NOTE between 4 and 5 then '4-5'
else 'меньше 4'
end) as T
order by Case[Оценка]
when '4-5' then 3
when '6-7' then 2
when '8-9' then 1
when 'меньше 4' then 4
else 0
end

--4--
SELECT PROGRESS.NOTE,FACULTY.FACULTY_NAME,GROUPS.PROFESSION,
round(avg(PROGRESS.NOTE AS FLOAT (4)),2)
FROM PROGRESS.NOTE INNER JOIN 

FROM PROGRESS.NOTE INNER JOIN 
select FACULTY.FACULTY, GROUPS.PROFESSION, (2014 - GROUPS.YEAR_FIRST)[Курс],
round(avg(cast(PROGRESS.NOTE as float(4))),2)[Средняя оценка] 

from FACULTY
inner join GROUPS  on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT  on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
group by FACULTY.FACULTY,
	     GROUPS.PROFESSION,
		 GROUPS.YEAR_FIRST
order by [Средняя оценка] desc;
/*4.2*/
USE UNIVER
select FACULTY.FACULTY, GROUPS.PROFESSION, (2014 - GROUPS.YEAR_FIRST)[Курс],
PROGRESS.SUBJECT [SUBJECT],
round(avg(cast(PROGRESS.NOTE as float(4))),2)[Средняя оценка] 


from FACULTY
inner join GROUPS  on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT  on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
Where PROGRESS.SUBJECT='БД'or PROGRESS.SUBJECT='ОАиП'
group by FACULTY.FACULTY,
	     GROUPS.PROFESSION,
		 GROUPS.YEAR_FIRST,
		 PROGRESS.SUBJECT
order by [Средняя оценка] desc;
