use UNIVER
--1--
SELECT PULPIT.PULPIT_NAME, FACULTY.FACULTY_NAME
   FROM PULPIT, FACULTY
   Where PULPIT.FACULTY=FACULTY.FACULTY
         AND
		FACULTY.FACULTY IN (SELECT FACULTY FROM PROFESSION
		                      Where (PROFESSION_NAME Like '%технология%')) 
--2--
SELECT PULPIT.PULPIT_NAME, FACULTY.FACULTY_NAME
   FROM PULPIT Inner Join FACULTY
   ON FACULTY.FACULTY=PULPIT.FACULTY
   Where FACULTY.FACULTY IN (SELECT FACULTY FROM PROFESSION
		                      Where (PROFESSION_NAME Like '%технология%')) 
--3--
SELECT PULPIT.PULPIT_NAME, FACULTY.FACULTY_NAME/*есть повтор ну можно distinct вписать */
   FROM FACULTY Inner Join PULPIT 
   ON FACULTY.FACULTY=PULPIT.FACULTY 
   Inner Join PROFESSION
   ON PROFESSION.FACULTY=FACULTY.FACULTY 
		                      Where (PROFESSION_NAME Like '%технология%')
--4--
SELECT AUDITORIUM_CAPACITY,AUDITORIUM_TYPE
   FROM AUDITORIUM
   Where AUDITORIUM_CAPACITY=(SELECT  top(1) AUDITORIUM_CAPACITY FROM AUDITORIUM
                             Order by AUDITORIUM_CAPACITY DESC)
--5--
SELECT FACULTY_NAME
   FROM FACULTY
   Where not exists (SELECT * FROM PULPIT
                        Where PULPIT.FACULTY=FACULTY.FACULTY)
--6--
SELECT top(1)
   (SELECT avg(PROGRESS.NOTE)
   FROM PROGRESS
   WHERE PROGRESS.SUBJECT Like 'ОАиП')[ОАиП],
   (SELECT avg(PROGRESS.NOTE) 
   FROM PROGRESS 
   WHERE PROGRESS.SUBJECT Like 'КГ')[КГ],
   (SELECT avg(PROGRESS.NOTE)
   FROM PROGRESS
   WHERE PROGRESS.SUBJECT Like 'СУБД')[СУБД]
   FROM PROGRESS
--7--
SELECT PROGRESS.NOTE,PROGRESS.SUBJECT 
   FROM PROGRESS
   Where PROGRESS.NOTE>=all(SELECT PROGRESS.NOTE FROM PROGRESS
                               Where PROGRESS.SUBJECT Like 'КГ')
--8--
SELECT PROGRESS.NOTE,PROGRESS.SUBJECT 
   FROM PROGRESS
   Where PROGRESS.NOTE>any(SELECT PROGRESS.NOTE FROM PROGRESS
                               Where PROGRESS.SUBJECT Like 'КГ')





--MY_BASE--
use DB_Lykova

--1--
SELECT CREDITS.Наименование_кредита,OFORMLENN_CREDITS.Название_фирмы_клиента
   FROM CREDITS, OFORMLENN_CREDITS
   Where CREDITS.Наименование_кредита=OFORMLENN_CREDITS.Вид_собственности
         AND
		OFORMLENN_CREDITS.Название_фирмы_клиента IN (SELECT Название_фирмы_клиента FROM OFORMLENN_CREDITS
		                      Where (Название_фирмы_клиента  Like 'Л%'))

--2--
SELECT CREDITS.Наименование_кредита,OFORMLENN_CREDITS.Название_фирмы_клиента
   FROM CREDITS INNER JOIN OFORMLENN_CREDITS
   ON CREDITS.Наименование_кредита=OFORMLENN_CREDITS.Вид_собственности
         AND
		OFORMLENN_CREDITS.Название_фирмы_клиента IN (SELECT Название_фирмы_клиента FROM OFORMLENN_CREDITS
		                      Where (Название_фирмы_клиента  Like 'Л%'))

							  	SELECT Название_фирмы_клиента,Контактное_лицо
	from OFORMLENN_CREDITS inner join CLIENTS
	ON OFORMLENN_CREDITS.Название_фирмы_клиента=CLIENTS.Контактное_лицо
	AND CLIENTS.Контактное_лицо LIKE 'Л%'
--4--
SELECT CREDITS.Ставка,CREDITS.Наименование_кредита
FROM CREDITS
WHERE CREDITS.Ставка=(SELECT TOP(1) CREDITS.Ставка FROM CREDITS
ORDER BY CREDITS.Ставка DESC)

--5--
SELECT Наименование_кредита
   FROM CREDITS
   Where not exists (SELECT * FROM OFORMLENN_CREDITS
                        Where OFORMLENN_CREDITS.Название_кредита=CREDITS.Название_банка)

--6--
   SELECT TOP(1)
   (SELECT AVG(CREDITS.Ставка)FROM CREDITS WHERE CREDITS.Наименование_кредита LIKE 'Льготный')[Льготный]
   from CREDITS
  
--------------------------------------------------------

--------------------------------------------------------


USE UNIVER
 SELECT AUDITORIUM_TYPE.AUDITORIUM_TYPENAME,AUDITORIUM.AUDITORIUM
 FROM AUDITORIUM_TYPE INNER JOIN  AUDITORIUM
 ON AUDITORIUM_TYPE.AUDITORIUM_TYPENAME=AUDITORIUM.
	

	
 
