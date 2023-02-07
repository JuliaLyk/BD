
go 
CREATE PROCEDURE PSUBJECT
as
begin
declare @k int = (select count(*)from SUBJECT);
select * from SUBJECT;
return @k;
end;			

declare @r int;
EXEC @r=PSUBJECT;
print'' + cast(@r as varchar(3));

--drop procedure psubject--

-----
Alter procedure PSUBJECT @p varchar(20) , @c int output
as 
begin
declare @k int = (select count(*) from SUBJECT);
print 'параметры @p='+@p+',@c'+cast(@c as varchar(3));
select * from SUBJECT where PULPIT=@p;
set @c= @@rowcount;/*которая возвращает количество затронутых строк при выполнении последней инструкции*/
return @k;
end;

EXEC PSUBJECT 'ИСиТ',13


/*6*/
--GROUP BY--
SELECT SUBJECT.SUBJECT,AVG(PROGRESS.NOTE)
FROM PROGRESS INNER JOIN SUBJECT             
ON PROGRESS.SUBJECT=SUBJECT.SUBJECT
WHERE PROGRESS.SUBJECT LIKE 'СУБД'
GROUP BY SUBJECT.SUBJECT
--2--
SELECT AUDITORIUM_TYPE.AUDITORIUM_TYPENAME [Тип аудитории],
min(AUDITORIUM_CAPACITY) [Минимальная],
max (AUDITORIUM_CAPACITY) [Максимальная],
AVG (AUDITORIUM_CAPACITY) [Средняя],
sum(AUDITORIUM_CAPACITY) [Суммарная],
COUNT(*) [Количество]
FROM AUDITORIUM INNER JOIN AUDITORIUM_TYPE
ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
GROUP BY AUDITORIUM_TYPENAME

--10--
SELECT PROGRESS.NOTE,PROGRESS.SUBJECT,
(SELECT COUNT(*) FROM PROGRESS
WHERE PROGRESS.NOTE=PROGRESS.NOTE
AND PROGRESS.SUBJECT=PROGRESS.SUBJECT)[Количество]
FROM PROGRESS
GROUP BY PROGRESS.NOTE,PROGRESS.SUBJECT
HAVING NOTE IN (8,9)

/*7*/
GO
CREATE VIEW [Количество кафедр]
as select FACULTY.FACULTY_NAME,PULPIT.PULPIT
from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
GO
SELECT * FROM [Количество кафедр]

----
GO
CREATE VIEW Аудитории(AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_TYPE)
as select AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM_TYPE like'ЛК'
GO
INSERT Аудитории VALUES ('207-1','207-1','ЛК')
select *from Аудитории
--DROP VIEW Аудитории
-----
go
CREATE VIEW [Дисциплины]
as select top 20 SUBJECT_NAME[Дисциплины], SUBJECT,SUBJECT.PULPIT
from SUBJECT
order by SUBJECT_NAME
go
select*from [Дисциплины]
-----
GO
alter view  [Количество кафедр] with schemabinding
as select FACULTY.FACULTY_NAME,PULPIT.PULPIT
from dbo.FACULTY join dbo.PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
GO

/*14*/
go
create trigger Capacity_Tran on AUDITORIUM after insert,delete,update
as declare @c int=(select max(AUDITORIUM_CAPACITY) from AUDITORIUM);
if(@c>100)
begin 
raiserror('Вместимость не может быть больше 100!',10,1);
rollback;
end;
return;

update AUDITORIUM set AUDITORIUM_CAPACITY=130 where AUDITORIUM_CAPACITY=120

----
go
create trigger TR_TEACHER_DEL on TEACHER after DELETE
as declare @a1 char(10),@a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
print 'операция удаления';
set @a1 =(select [TEACHER] from DELETED);
set @a2 =(select [TEACHER_NAME] from DELETED);
set @a3 =(select [GENDER] from DELETED);
set @a4 =(select [PULPIT] from DELETED);
set @in = @a1 +' '+@a2+' '+@a3+' '+@a4;
insert into TR_AUDIT(STMT,TRNAME,CC) values('DEL','TR_TEACHER_DEL',@in);
return;

delete TEACHER where TEACHER in ('РЖК')
select * from TR_AUDIT

--8--
declare @s int = (select COUNT(*) from TEACHER where PULPIT = 'ИСиТ') 
  IF @s > 5
  print cast(@s as varchar(10)) + ' - Количество больше пяти';
  else
  print cast(@s as varchar(10)) + ' - Количество меньше пяти';








