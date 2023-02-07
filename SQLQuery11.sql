--1-- 

set nocount on 
if exists (select * from SYS.OBJECTS
where OBJECT_ID= object_id(N'DBO.X'))
drop table X;

declare @c int, @flag char = 'c';
SET IMPLICIT_TRANSACTIONS ON --����� ������� ����������
create table X(K int);
insert X values (1),(2),(3);
set @c = (select count(*) from X);
print '���������� ����� � ������� �:'+cast(@c as varchar(2));
if @flag = 'r' commit;
else rollback;
SET IMPLICIT_TRANSACTIONS OFF

if exists (select * from SYS.OBJECTS
where OBJECT_ID= object_id(N'DBO.X'))
print '������� � ����';
else print '������� � ���'

--2--
begin try
begin tran   --������ ����� ����������
delete AUDITORIUM_TYPE where AUDITORIUM_TYPE='��';
insert AUDITORIUM_TYPE values ('��','���');
insert AUDITORIUM_TYPE values('��','�����');
commit tran;
end try
begin catch
print '������'+case
when error_number()=2627 and patindex('%PK_AUDITORIUM_TYPE%',error_message())>0
then '����� ������'
else '����������� ������:'+cast(error_number()as varchar(5))+error_message()
end;
if @@trancount>0 rollback tran;
end catch;
--3--
declare @point varchar(32)
			begin try
begin tran
delete AUDITORIUM where AUDITORIUM.AUDITORIUM = '322-1'
set @point = 'p1'; save tran @point;
insert AUDITORIUM values (N'439-3�', N'��-�', 15, N'439-3�');
set @point = 'p2'; save tran @point
update AUDITORIUM set AUDITORIUM_TYPE = '��' where AUDITORIUM_CAPACITY = 15;
set @point = 'p3'; save tran @point
truncate table AUDITORIUM;
set @point = 'p4'; save tran @point
insert AUDITORIUM values (N'439-3�', N'��-�', 15, N'439-3�');
commit tran;
end try
begin catch
print N'������: ' + case when error_number() = 2627 and patindex('%PK%', error_message()) > 0 
THEN N'������������ ���������'
when error_number() = 547 and patindex('%FK%', error_message()) > 0
then N'�������������� ��������  �����'
when error_number() = 4712
then N'���������� ��������� TRUNCATE'
else N'����������� ������' + cast(error_number() as varchar(5)) + error_message()
end;
if @@TRANCOUNT > 0
begin
print N'����������� �����: ' + @point;
rollback tran @point;
commit tran;
end;
end catch;


--4-- 
---A---
set transaction isolation level READ UNCOMMITTED
begin transaction
---t1---
select @@SPID,'insert AUDITORIUM','���������', * from AUDITORIUM
                                                 where AUDITORIUM_CAPACITY=15;
select @@SPID,'insert AUDITORIUM','���������', AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM
                                                 where AUDITORIUM_CAPACITY=15;
commit;
---t2---
---B---
begin transaction
select @@SPID
update AUDITORIUM set AUDITORIUM_CAPACITY=11
                  where AUDITORIUM_CAPACITY=15
---t1---
rollback;

--5--
USE UNIVER
---A---
set transaction isolation level READ COMMITTED
begin transaction
select count(*) from AUDITORIUM
                where AUDITORIUM_CAPACITY=60;
---t1---
---t2---
select 'update AUDITORIUM','���������', count(*) from AUDITORIUM
                                        where AUDITORIUM_CAPACITY=60;
commit;
---B---
begin transaction
---t1---
update AUDITORIUM set AUDITORIUM_CAPACITY=11
                  where AUDITORIUM_CAPACITY=60
commit;
---t2---

--6--
USE UNIVER
---A---
set transaction isolation level REPEATABLE READ
begin transaction
select FACULTY_NAME from FACULTY;
---t1---
---t2---
select case
when  FACULTY_NAME='���������� ������������ �������' then 'insert AUDITORIUM' else ''
end 'result',  FACULTY_NAME from FACULTY
commit;
---B---
begin transaction
---t1---
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���1',     '-------');
commit;
---t2---

--7--     
---t2---
USE UNIVER
---A---
set transaction isolation level SERIALIZABLE
begin transaction
select * from FACULTY where FACULTY='���';
---t1---
select FACULTY from FACULTY where FACULTY='���';
---t2---
commit;
---B---
begin transaction
select * from FACULTY where FACULTY='���';
---t1---
commit;
select FACULTY from FACULTY where FACULTY='���';
---t2---
--8--
begin tran 
insert AUDITORIUM_TYPE values('���','������');
begin tran
update AUDITORIUM_TYPE set AUDITORIUM_TYPE='���' where AUDITORIUM_TYPE='���';
commit;
if @@TRANCOUNT>0 rollback;
select 
(select count(*) from AUDITORIUM_TYPE where AUDITORIUM_TYPE='���') 'AUDITORIUM_TYPE',
(select count(*) from AUDITORIUM_TYPE where AUDITORIUM_TYPE='���') 'AUDITORIUM_TYPE';
