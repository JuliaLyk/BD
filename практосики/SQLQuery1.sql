 
 
--С АУДИТОРИЕЙ ЧЕРЕЗ ФУНКЦИЮ
USE UNIVER;
GO
CREATE FUNCTION FAUD (@AUD VARCHAR(50)) RETURNS VARCHAR(50)
AS BEGIN
DECLARE @RC VARCHAR(50);
SET @RC=(SELECT AUDITORIUM_TYPE.AUDITORIUM_TYPENAME FROM AUDITORIUM_TYPE INNER JOIN AUDITORIUM
												ON AUDITORIUM.AUDITORIUM_TYPE=AUDITORIUM_TYPE.AUDITORIUM_TYPE
												WHERE AUDITORIUM.AUDITORIUM=@AUD)
RETURN @RC;
END;
GO
DECLARE @F VARCHAR(50) = DBO.FAUD('301-1');
PRINT 'Тип аудитории 301-1: '+CAST(@F AS VARCHAR(20));
DROP FUNCTION FAUD




--КОЛ-ВО ПРЕПОДОВ НА КАЫЕДРЕ, КАЫЕДРА ПАРАМЕТР
GO
CREATE PROCEDURE PREP  @KAF varchar(20) = null
AS
BEGIN 
SELECT COUNT(TEACHER.TEACHER) FROM TEACHER 
							WHERE TEACHER.PULPIT= @KAF;
END;
GO 
EXEC PREP @KAF = 'ИСиТ'
 --CURSOR--
  -- ВЫВЕСТИ ЧЕРЕЗ ЗАПЯТУЮ ПРЕПОДОВАТЕЛЦ НА КАФЕДРЕ ИСИТ
 DECLARE @te char(1000) ,@t char(1000)='';
 declare TEACHER_ALL cursor for 
			select TEACHER.TEACHER_NAME FROM TEACHER
  WHERE TEACHER.PULPIT = 'ИСиТ'
  open TEACHER_ALL;
  fetch TEACHER_ALL into @te;
  print 'all teacher:'
  while @@FETCH_STATUS=0
  begin
  set @t=rtrim(@te)+','+@t
  FETCH TEACHER_ALL into @te;
end;
 print @t;
close TEACHER_ALL

 ----------
 use UNIVER
Declare @sb char(20), @t char() = '';
Declare TECH CURSOR for select TEACHER_NAME from TEACHER where PULPIT = 'ИСиТ';
OPEn TECH;
Fetch TECH into @sb;
print 'Список дисциплин';
while @@FETCH_STATUS = 0
begin
set @t = rtrim(@sb)+ ','+@t;/*RTRIM убирает пробелы в конце строки*/
fetch TECH into @sb;
end;
print @t;
Close TECH;	
--function--
go
create function COUNT_STUDENTS(@faculty varchar(20)) returns int
as begin declare @rc int =0;
set @rc=(select count(NAME)
from STUDENT join GROUPS
on STUDENT.IDGROUP= GROUPS.IDGROUP
join FACULTY
on GROUPS.FACULTY=FACULTY.FACULTY
where FACULTY.FACULTY=@faculty);
return @rc;
end;
go

declare @f int=dbo.COUNT_STUDENTS('ЛХФ');
print'количество студентов= '+cast(@f as varchar(4));
-------------????????
go 
create function LOL (@FAC VARCHAR(50)) RETURNS VARCHAR (50)
AS 
BEGIN
DECLARE @RC=(SELECT AVG(NOTE)
FROM PROGRESS INNER JOIN SUBJECT
ON PROGRESS.SUBJECT =SUBJECT.SUBJECT
WHERE PROGRESS LIKE 'СУБД')
return @RC;
END;

-------------
GO
ALTER function SR(@t char(20)) returns int
  as
  begin
  declare @a int = (select AVG(NOTE) from PROGRESS WHERE SUBJECT= @t)
  return @a;
  end;
  GO
  PRINT CAST(dbo.SR ('СУБД') AS NVARCHAR(10))

----PROCEDURE-----
GO
CREATE PROCEDURE PREP  @KAF varchar(20) = null
AS
BEGIN 
SELECT COUNT(TEACHER.TEACHER) FROM TEACHER 
							WHERE TEACHER.PULPIT= @KAF;
END;
GO 
EXEC PREP @KAF = 'ИСиТ'
------------

CREATE procedure SR 
@t nvarchar(20)
  as
  
  begin
  declare @a int = (select AVG(NOTE) from PROGRESS WHERE SUBJECT = @t)
  select NOTE, SUBJECT from PROGRESS where SUBJECT = @t
  return @a
  end
  
  declare @s int;
  exec @s = SR @t = 'ОАиП';
  print 'ср балл '+ cast(@s as nvarchar(5));
  DROP procedure SR
 ------------
CREATE procedure SR 
@t nvarchar(20)
  as
  
  begin
  declare @a int = (select AVG(NOTE) from PROGRESS WHERE SUBJECT = @t)
  select NOTE, SUBJECT from PROGRESS where SUBJECT = @t
  return @a
  end
  
  declare @s int;
  exec @s = SR @t = 'ОАиП';
  print 'ср балл '+ cast(@s as nvarchar(5));
  DROP procedure SR
----------------
alter procedure TE @f nvarchar(50)
as 
begin 
declare @k int=(select COUNT(*) from  TEACHER WHERE TEACHER.GENDER='м')
select TEACHER_NAME from TEACHER where TEACHER.GENDER=@f
print 'name ' + cast( @k as nvarchar(5))

select TEACHER_NAME,GENDER FROM TEACHER 
RETURN @k
end

declare @j int;
exec @j = TE @f='м';
print ''+cast(@j as nvarchar(20));

--TRIGGER--

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

----------
 
select COUNT(*)
from STUDENT
--6--
select COUNT(*)
from STUDENT join GROUPS
on STUDENT.IDGROUP=GROUPS.IDGROUP
WHERE GROUPS.FACULTY = 'ТОВ'
group by GROUPS.FACULTY

--8--
--НАЙТИ средний бал по предмету субд  елси <4 , >4 тоже 
declare @h int 
SELECT (AVG(NOTE) FROM PROGRESS where SUBJECT='ОАиП')
  IF @h< 4
  print cast(@H as varchar(10)) + ' - < 4';
  else
  print cast(@h as varchar(10)) + ' - >4';

