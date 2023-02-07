----lab 14
use UNIVER
create table TR_AUDIT(
ID int identity, --�����
STMT varchar(20) --DML-��������
check(STMT in ('INS','DEL','UPD')),
TRNAME varchar(50), --��� ��������
CC varchar(300) -- �����������
)
--DROP TABLE TR_AUDIT
--delete TEACHER WHERE TEACHER='���'
--1--
go
--DROP TRIGGER TR_TEACHER_INS
create trigger TR_TEACHER_INS on TEACHER after INSERT
as declare @a1 char(10),@a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
print '�������� �������';
set @a1 =(select [TEACHER] from inserted);
set @a2 =(select [TEACHER_NAME] from inserted);
set @a3 =(select [GENDER] from inserted);
set @a4 =(select [PULPIT] from inserted);
set @in = @a1 +' '+@a2+' '+@a3+' '+@a4;
insert into TR_AUDIT(STMT,TRNAME,CC) values('INS','TR_TEACHER_INS',@in);
return;

insert into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
values ('���','������� ������ ����������','�','����')
select * from TR_AUDIT

--2--
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

--3--
go
use UNIVER
go
create trigger TR_TEACHER_UPD on TEACHER after UPDATE
as declare @a1 char(10),@a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
print '�������� ����������';
set @a1 =(select [TEACHER] from inserted);
set @a2 =(select [TEACHER_NAME] from inserted);
set @a3 =(select [GENDER] from inserted);
set @a4 =(select [PULPIT] from inserted);
set @in = @a1 +' '+@a2+' '+@a3+' '+@a4;
set @a1 =(select [TEACHER] from DELETED);
set @a2 =(select [TEACHER_NAME] from DELETED);
set @a3 =(select [GENDER] from DELETED);
set @a4 =(select [PULPIT] from DELETED);
set @in = @a1 +' '+@a2+' '+@a3+' '+@a4+' '+@in;
insert into TR_AUDIT(STMT,TRNAME,CC) values('UPD','TR_TEACHER_UPD',@in);
return;
GO
update TEACHER SET PULPIT='����' WHERE TEACHER='������'
select * from TR_AUDIT

--4--
go
create trigger TR_TEACHER on TEACHER after INSERT, DELETE, UPDATE
as declare @a1 char(10),@a2 varchar(100),@a3 char(1), @a4 char(20), @in varchar(300);
declare @ins int=(select count(*) from inserted),
@del int=(select count(*) from deleted);
if @ins>0 and @del=0
begin
print'event INSERT';
set @a1 =(select [TEACHER] from inserted);
set @a2 =(select [TEACHER_NAME] from inserted);
set @a3 =(select [GENDER] from inserted);
set @a4 =(select [PULPIT] from inserted);
set @in = @a1 +' '+@a2+' '+@a3+' '+@a4;
insert into TR_AUDIT(STMT,TRNAME,CC) values('INS','TR_TEACHER_INS',@in);
end;
else if @ins=0 and @del>0
begin
print'event DELETE';
set @a1 =(select [TEACHER] from DELETED);
set @a2 =(select [TEACHER_NAME] from DELETED);
set @a3 =(select [GENDER] from DELETED);
set @a4 =(select [PULPIT] from DELETED);
set @in = @a1 +' '+@a2+' '+@a3+' '+@a4;
insert into TR_AUDIT(STMT,TRNAME,CC) values('DEL','TR_TEACHER_DEL',@in);
end;
else if @ins>0 and @del>0
begin
print'event UPDATE';
set @a1 =(select [TEACHER] from inserted);
set @a2 =(select [TEACHER_NAME] from inserted);
set @a3 =(select [GENDER] from inserted);
set @a4 =(select [PULPIT] from inserted);
set @in = @a1 +' '+@a2+' '+@a3+' '+@a4;
set @a1 =(select [TEACHER] from DELETED);
set @a2 =(select [TEACHER_NAME] from DELETED);
set @a3 =(select [GENDER] from DELETED);
set @a4 =(select [PULPIT] from DELETED);
set @in = @a1 +' '+@a2+' '+@a3+' '+@a4+' '+@in;
insert into TR_AUDIT(STMT,TRNAME,CC) values('UPD','TR_TEACHER_UPD',@in);
end;
return;

insert into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
values ('���','������ �������� ���������','�','����')
delete TEACHER where TEACHER in ('���')
update TEACHER SET PULPIT='����' WHERE TEACHER='���'
select * from TR_AUDIT

--5--
update TEACHER set GENDER = 'H' where TEACHER='���'
select * from TR_AUDIT

--6--
go
CREATE trigger TR_TEACHER_DEL1 on TEACHER after DELETE
as print 'TR_TEACHER_DEL1';
return;

go
CREATE trigger TR_TEACHER_DEL2 on TEACHER after DELETE
as print 'TR_TEACHER_DEL2';
return;
go
CREATE trigger TR_TEACHER_DEL3 on TEACHER after DELETE
as print 'TR_TEACHER_DEL3';
return;

exec sp_settriggerorder @triggername='TR_TEACHER_DEL3',
@order='First',@stmttype='DELETE'

exec sp_settriggerorder @triggername='TR_TEACHER_DEL2',
@order='Last',@stmttype='DELETE'

select t.name,e.type_desc
from sys.triggers t join sys.trigger_events e
on t.object_id = e.object_id
where OBJECT_NAME(t.parent_id)='TEACHER' and e.type_desc='DELETE'

--7--
 create trigger TEACHER_TRAN
 on TEACHER after insert, update, delete
 as declare @c int = (select count(*) from TEACHER)
 if(@c > 2)
 begin
 raiserror('���-�� �������� ������ ��������������!', 10, 1);
 rollback;
 end;
 return;

 update TEACHER Set TEACHER.TEACHER = N'���' where TEACHER.TEACHER = N'����';
 select * from TR_AUDIT;
--8--
go 
create trigger FAC_INSTEAD_OF
on FACULTY instead of delete
as raiserror(N'��������',10,1);
return

delete FROM  FACULTY where FACULTY = 'xzz';
select * from TR_AUDIT
drop trigger FAC_INSTEAD_OF


--9--
DROP  TRIGGER DDL_UNIVER2
CREATE trigger DDL_UNIVER2 on database for DDL_DATABASE_LEVEL_EVENTS
as
declare @t varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)');
if @t1 in (select name from sys.objects WHERE type='U')
begin
print N'��� �������: ' + @t;
print N'��� �������: ' + @t1;
print N'��� �������: ' + @t2;
raiserror ('�������� � �������� ���������',16,1);
rollback;
end;
create table A (I int)
drop table A


-----------------------MyBase-----------------------
--1--use UNIVER
create table TR_MY(
ID int identity, --�����
ST varchar(20) --DML-��������
check(ST in ('INS','DEL','UPD')),
TRNAME varchar(50), --��� ��������
CC varchar(300) -- �����������
)

--2--
go

alter trigger TR_MYY on CLIENTS after INSERT
as declare @a1 char(10),@a2 varchar(100),@a3 char(1), @in varchar(300);
print '�������� �������';
set @a1 =(select [����������_����] from inserted);
set @a2 =(select [�����] from inserted);
set @a3 =(select [�������] from inserted);

set @in = @a1 +' '+@a2+' '+@a3;
insert into TR_MY(ST,TRNAME,CC) values('INS','TR_MYY',@in);
return;

insert into CLIENTS  (����������_����,�����,�������)
values ('�������� �.�','��.���','84757320')
select * from TR_MY

--3--

--7--
alter trigger OL on CREDITS after insert,delete,update
as declare @c int=(select max(������) from CREDITS);
if(@c>10000)
begin 
raiserror('������!!',10,1);
rollback;
end;
return;

update CREDITS set ������=16 where ������=25