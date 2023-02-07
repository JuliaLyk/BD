
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
print '��������� @p='+@p+',@c'+cast(@c as varchar(3));
select * from SUBJECT where PULPIT=@p;
set @c= @@rowcount;/*������� ���������� ���������� ���������� ����� ��� ���������� ��������� ����������*/
return @k;
end;

EXEC PSUBJECT '����',13


/*6*/
--GROUP BY--
SELECT SUBJECT.SUBJECT,AVG(PROGRESS.NOTE)
FROM PROGRESS INNER JOIN SUBJECT             
ON PROGRESS.SUBJECT=SUBJECT.SUBJECT
WHERE PROGRESS.SUBJECT LIKE '����'
GROUP BY SUBJECT.SUBJECT
--2--
SELECT AUDITORIUM_TYPE.AUDITORIUM_TYPENAME [��� ���������],
min(AUDITORIUM_CAPACITY) [�����������],
max (AUDITORIUM_CAPACITY) [������������],
AVG (AUDITORIUM_CAPACITY) [�������],
sum(AUDITORIUM_CAPACITY) [���������],
COUNT(*) [����������]
FROM AUDITORIUM INNER JOIN AUDITORIUM_TYPE
ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
GROUP BY AUDITORIUM_TYPENAME

--10--
SELECT PROGRESS.NOTE,PROGRESS.SUBJECT,
(SELECT COUNT(*) FROM PROGRESS
WHERE PROGRESS.NOTE=PROGRESS.NOTE
AND PROGRESS.SUBJECT=PROGRESS.SUBJECT)[����������]
FROM PROGRESS
GROUP BY PROGRESS.NOTE,PROGRESS.SUBJECT
HAVING NOTE IN (8,9)

/*7*/
GO
CREATE VIEW [���������� ������]
as select FACULTY.FACULTY_NAME,PULPIT.PULPIT
from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
GO
SELECT * FROM [���������� ������]

----
GO
CREATE VIEW ���������(AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_TYPE)
as select AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_TYPE from AUDITORIUM
where AUDITORIUM_TYPE like'��'
GO
INSERT ��������� VALUES ('207-1','207-1','��')
select *from ���������
--DROP VIEW ���������
-----
go
CREATE VIEW [����������]
as select top 20 SUBJECT_NAME[����������], SUBJECT,SUBJECT.PULPIT
from SUBJECT
order by SUBJECT_NAME
go
select*from [����������]
-----
GO
alter view  [���������� ������] with schemabinding
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
raiserror('����������� �� ����� ���� ������ 100!',10,1);
rollback;
end;
return;

update AUDITORIUM set AUDITORIUM_CAPACITY=130 where AUDITORIUM_CAPACITY=120

----
go
create trigger TR_TEACHER_DEL on TEACHER after DELETE
as declare @a1 char(10),@a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
print '�������� ��������';
set @a1 =(select [TEACHER] from DELETED);
set @a2 =(select [TEACHER_NAME] from DELETED);
set @a3 =(select [GENDER] from DELETED);
set @a4 =(select [PULPIT] from DELETED);
set @in = @a1 +' '+@a2+' '+@a3+' '+@a4;
insert into TR_AUDIT(STMT,TRNAME,CC) values('DEL','TR_TEACHER_DEL',@in);
return;

delete TEACHER where TEACHER in ('���')
select * from TR_AUDIT

--8--
declare @s int = (select COUNT(*) from TEACHER where PULPIT = '����') 
  IF @s > 5
  print cast(@s as varchar(10)) + ' - ���������� ������ ����';
  else
  print cast(@s as varchar(10)) + ' - ���������� ������ ����';








