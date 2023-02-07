use UNIVER
--1--
SELECT PULPIT.PULPIT_NAME, FACULTY.FACULTY_NAME
   FROM PULPIT, FACULTY
   Where PULPIT.FACULTY=FACULTY.FACULTY
         AND
		FACULTY.FACULTY IN (SELECT FACULTY FROM PROFESSION
		                      Where (PROFESSION_NAME Like '%����������%')) 
--2--
SELECT PULPIT.PULPIT_NAME, FACULTY.FACULTY_NAME
   FROM PULPIT Inner Join FACULTY
   ON FACULTY.FACULTY=PULPIT.FACULTY
   Where FACULTY.FACULTY IN (SELECT FACULTY FROM PROFESSION
		                      Where (PROFESSION_NAME Like '%����������%')) 
--3--
SELECT PULPIT.PULPIT_NAME, FACULTY.FACULTY_NAME/*���� ������ �� ����� distinct ������� */
   FROM FACULTY Inner Join PULPIT 
   ON FACULTY.FACULTY=PULPIT.FACULTY 
   Inner Join PROFESSION
   ON PROFESSION.FACULTY=FACULTY.FACULTY 
		                      Where (PROFESSION_NAME Like '%����������%')
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
   WHERE PROGRESS.SUBJECT Like '����')[����],
   (SELECT avg(PROGRESS.NOTE) 
   FROM PROGRESS 
   WHERE PROGRESS.SUBJECT Like '��')[��],
   (SELECT avg(PROGRESS.NOTE)
   FROM PROGRESS
   WHERE PROGRESS.SUBJECT Like '����')[����]
   FROM PROGRESS
--7--
SELECT PROGRESS.NOTE,PROGRESS.SUBJECT 
   FROM PROGRESS
   Where PROGRESS.NOTE>=all(SELECT PROGRESS.NOTE FROM PROGRESS
                               Where PROGRESS.SUBJECT Like '��')
--8--
SELECT PROGRESS.NOTE,PROGRESS.SUBJECT 
   FROM PROGRESS
   Where PROGRESS.NOTE>any(SELECT PROGRESS.NOTE FROM PROGRESS
                               Where PROGRESS.SUBJECT Like '��')





--MY_BASE--
use DB_Lykova

--1--
SELECT CREDITS.������������_�������,OFORMLENN_CREDITS.��������_�����_�������
   FROM CREDITS, OFORMLENN_CREDITS
   Where CREDITS.������������_�������=OFORMLENN_CREDITS.���_�������������
         AND
		OFORMLENN_CREDITS.��������_�����_������� IN (SELECT ��������_�����_������� FROM OFORMLENN_CREDITS
		                      Where (��������_�����_�������  Like '�%'))

--2--
SELECT CREDITS.������������_�������,OFORMLENN_CREDITS.��������_�����_�������
   FROM CREDITS INNER JOIN OFORMLENN_CREDITS
   ON CREDITS.������������_�������=OFORMLENN_CREDITS.���_�������������
         AND
		OFORMLENN_CREDITS.��������_�����_������� IN (SELECT ��������_�����_������� FROM OFORMLENN_CREDITS
		                      Where (��������_�����_�������  Like '�%'))

							  	SELECT ��������_�����_�������,����������_����
	from OFORMLENN_CREDITS inner join CLIENTS
	ON OFORMLENN_CREDITS.��������_�����_�������=CLIENTS.����������_����
	AND CLIENTS.����������_���� LIKE '�%'
--4--
SELECT CREDITS.������,CREDITS.������������_�������
FROM CREDITS
WHERE CREDITS.������=(SELECT TOP(1) CREDITS.������ FROM CREDITS
ORDER BY CREDITS.������ DESC)

--5--
SELECT ������������_�������
   FROM CREDITS
   Where not exists (SELECT * FROM OFORMLENN_CREDITS
                        Where OFORMLENN_CREDITS.��������_�������=CREDITS.��������_�����)

--6--
   SELECT TOP(1)
   (SELECT AVG(CREDITS.������)FROM CREDITS WHERE CREDITS.������������_������� LIKE '��������')[��������]
   from CREDITS
  
--------------------------------------------------------

--------------------------------------------------------


USE UNIVER
 SELECT AUDITORIUM_TYPE.AUDITORIUM_TYPENAME,AUDITORIUM.AUDITORIUM
 FROM AUDITORIUM_TYPE INNER JOIN  AUDITORIUM
 ON AUDITORIUM_TYPE.AUDITORIUM_TYPENAME=AUDITORIUM.
	

	
 
